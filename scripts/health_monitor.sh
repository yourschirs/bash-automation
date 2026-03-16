#!/bin/bash

# ─────────────────────────────────────────
# System Health Monitor
# Author: Your Name
# Description: Logs CPU, RAM, and disk usage
#              Alerts if thresholds are breached
# ─────────────────────────────────────────

LOGFILE="$HOME/bash-automation/logs/health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Thresholds
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

# ── Gather metrics ──
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# ── Log current stats ──
echo "[$TIMESTAMP] CPU: ${CPU_USAGE}% | RAM: ${RAM_USAGE}% | DISK: ${DISK_USAGE}%" >> "$LOGFILE"

# ── Alert logic ──
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "[$TIMESTAMP] ⚠ ALERT: CPU usage high at ${CPU_USAGE}%" >> "$LOGFILE"
fi

if [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ]; then
    echo "[$TIMESTAMP] ⚠ ALERT: RAM usage high at ${RAM_USAGE}%" >> "$LOGFILE"
fi

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "[$TIMESTAMP] ⚠ ALERT: Disk usage high at ${DISK_USAGE}%" >> "$LOGFILE"
fi
