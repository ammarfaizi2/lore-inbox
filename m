Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTFQB2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTFQB2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:28:31 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:19218 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S264498AbTFQB2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:28:25 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Brad Campbell <brad@wasp.net.au>,
       Nigel Cunningham <ncunningham@clear.net.nz>
Subject: tstinter kernel interactivity test script updated
Date: Tue, 17 Jun 2003 09:35:46 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306170255.01294.mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org, swsusp-devel@lists.sourceforge.net,
       swsusp@lister.fornax.hu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a script which demonstrates interactivity and locking issues. It is also challenging  swsusp

Quick instructions:

Save in current dir, make executable

On X terminal:
  ./tstinter start # Two 400MB dd write loops

To stop:

  ./tstinter stop  # stop the test
        
To clean files:

  ./tstinter clean # get rid of the files 

Also try this
  ./tstinter startr # Two dd 400MB write loops + One dd 200MB read loop

Details and changelog are in script.

When specifying number of blocks (n) a starting point is the 
amount of physical RAM / 5K. i.e. for 500MB RAM use 100K blocks

vmstat output every 30ms is interesting on all kernels!

#!/bin/bash

#*****************************************************************
#
# tstinter - a linux kernel interactivity test script 
#
# This script invokes:
# - User selectable  number of instances of dd each writing 
#     a large file.  Time taken by dd is displayed in a xterm
#
# - Xterm lists temporary files used by dd every second 
# - Xterm runs vmstat -n every 30ms 
# - Optionl dd read loop of a 200MB file in a xterm
#
# What to look for
#
# Slowdown or stoppping of ls and vmstat xterms
# Mouse hangs
# Poor response on invoking terminal
# Time fluctuations of dd loops - especially of Real time
#
#*****************************************************************
#
# Copyright:   2003 Michael Frank
# License:     GPL Version 2 
#
# Version:    0.2  16 June 2003 
#
# Usage:      ./tstinter FUNCTION [parameters]                                       
# Usage when script is in $PATH: tstinter FUNCTION parameters                
#                                                                 
# FUNCTION:                                                       
#
# start [i] [n]   Start test with [i] invocations of dd writes 
#                  of [n] 4K blocks
#                  when [i] is omitted, 2 instances are invoked
#                    [i] is limited to 10
#                  when [n] is omitted, 100K blocks (400MB) are used
#
# startr [i] [n]  As above, but also invokes one dd read 
#                   loop of a 200MB file
#   
# end            End test
# clean          Cleanup test files $FILE*
#
#*****************************************************************
#
# Examples:
#
# ./tstinter start          Start the test with 2 instances of dd 
#                            each writing 100K 4K blocks
# ./tstinter start 3 20000  Start the test with 3 instances of dd 
#                            each writing 20000 blocks
#
# ./tstinter startr         Start the test with 2 instances of dd 
#                            each writing 100K 4K blocks and with
#                            and with one instance of dd reading a
#                            200MB file
#
# ./tstinter stop            Stop the test
#
# ./tstinter clean [-f/-i]   Cleanup files written by dd 
#              
#*****************************************************************
#
# Requirements: 
#
# recent bash
# recent dd,killall,sleep,usleep,touch,X,xterm,vmstat
# Sufficient free disk space (1G for default invocation)
#  
#*****************************************************************
# Changes
# 0.1 Initial version
# 0.2 
#  - more security advise 
#  - for older dd use 4096 instead of 4K and 100000 instead of 100K
#  - for older bash dont  use ((x--))   
#  - replace uname loop with vmstat loop
#*****************************************************************
#
# Known Bugs and Limitations
#
# [n] can't be specified on its own
#
# tstinter may fill up the disk and slow the system down to the  
# point of unusability 
#
# usage with PIO hardisk mode is not recommended 
#
#
#*****************************************************************
#
# Security:
#
# Save all files and exit all applications in case reset is 
# required
#
# Should not be run as root 
#
# Be sure that $TEMP/$FILE* does not match any valuable files 
#
# Avoid setting i > 2 and if so increase i in small steps
#
#*****************************************************************
#
# Optional configuration: 
#
# Edit TEMP to a user writeable temporary directory if not set
#
if [ "$TEMP" = "" ]; then
  TEMP=/tmp
fi
#
# Edit FILE to another test file prefix as required
#
FILE=_x_y_z_
#
#*****************************************************************
#
# Internal use
#
TEMPFILE=$TEMP/$FILE
#
# For further invocation
#
TSTINTER=$0
#
#*****************************************************************
#
# Execute function
#
case $1 in
#
# start test
#
start | startr)
# start vmstat loop
  $TSTINTER _xtu  
# start ls loop
  $TSTINTER _xtl  
  sleep 5
  if [ "$2" = "" ]; then
    i=2
  else
    i=$2
  fi;
  if ((i > 10)); then
    echo Too many instances $i
    exit 1
  fi
#invoke dd read loop
  if [ "$1" = "startr" ]; then
    $TSTINTER _xread 50K r
   sleep 1
  fi
#invoke dd write loops
  while (( i )); do
    (( i-=1 ))
    $TSTINTER _xwrite "$2" $i
    sleep 1
  done
  ;;
#
# stop test
#
stop) killall ${0#${0%/*}/};; 
#
# Cleanup files
#
#
clean) rm  $2 $TEMPFILE*;;
#
#*****************************************************************
#
# Functions below are for internal use and spawned by the above 
# This method is used for ease of debug and test termination
#
# Loop timed dd read of $2 4K blocks from $TEMPFILE$3
# $TEMPFILE$3 is created first
#
_read) 
  if [ "$2" = "" ]; then
    count=100000
  else
    count=$2
  fi
  dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
  while (( 1 )); do
    time dd if=$TEMPFILE$3 of=/dev/null bs=4096 count=$count &> /dev/null
  done
  ;;
#
# Read as above in a xterm
#
_xread) xterm -e $TSTINTER _read "$2" $3 &;;
#
# Loop timed dd write of $2 4096 blocks to file $3
#
_write) 
  if [ "$2" = "" ]; then
    count=100000
  else
    count=$2
  fi
  while (( 1 )); do
    time dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
  done
  ;;
#
# Write as above in a xterm
#
_xwrite) xterm -e $TSTINTER _write "$2" $3 &;;
#
# Start a xterm printing vmstat 
#
_xtu) xterm -e $TSTINTER _xtu1&;;
#             
# Loop vmstat -n with a short delay
#
_xtu1)
  i=0
  while (( 1 )); do
    ((i += 1)); echo -n "$i "
    vmstat -n
    usleep 30000
  done
  ;;
_xtl) xterm -e $TSTINTER _xtl1&;;
#             
# Loop ls -l $TEMPFILE with a delay
#
_xtl1)
  i=0
  while (( 1 )); do
    ((i += 1)); echo "$i "
    ls -l $TEMPFILE*
    sleep 1
  done
  ;;
#
# Default
#
*) echo $TSTINTER bad function $*;;
esac
# End of script

Regards
Michael

-- 
Powered by linux-2.5.71, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting it up at
http://www.codemonkey.org.uk/post-halloween-2.5.txt


