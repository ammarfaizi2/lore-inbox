Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTE2IiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTE2IiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:38:09 -0400
Received: from imsantv30.netvigator.com ([210.87.253.77]:33430 "EHLO
	imsantv30.netvigator.com") by vger.kernel.org with ESMTP
	id S262016AbTE2Ih6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:37:58 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18, 2.4.21-rc3/6, 2.5.70-mm1 Interactivity test + script
Date: Thu, 29 May 2003 16:50:58 +0800
User-Agent: KMail/1.5.2
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305291650.58620.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a script which demonstrates interactivity and locking issues.

Initial test results on a P4/2.4G/533 512MB with IDE (EXT3). Using IDE udma5 ~50MB/s except on 2.4.18.

2.5.70-mm1 works best. Running opera 7 browsing LKML (big page) and hardly notice it is running the script. 

2.4.21-rc6 is better than 2.4.21-rc3, but behaves similar with fewer and seemingly shorter hangs

2.4.21-rc3 has many interactivity problems, mouse hangs, slow response to keyboard

2.4.18 vanilla all but dies. It is totally unusable.  IDE throughput only 6.2MB, but that may be my hardware. I am baffled as I expected it to be better than next releases by what I read .....


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

Details are in script.

Regards
Michael

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
# - Xterm runs uname -a every 30ms 
# - Optionl dd read loop of a 200MB file in a xterm
#
# What to look for
#
# Slowdown or stoppping of ls and uname xterms
# Mouse hangs
# Poor response on invoking terminal
# Time fluctuations of dd loops - especially of Real time
#
#*****************************************************************
#
# Copyright:  2003 Michael Frank
# License:    GPL Version 2
#
# Version:    0.1 29 May 2003 
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
# dd,killall,sleep,usleep,touch,X,xterm
# Sufficient free disk space (1G for default invocation)
#  
#*****************************************************************
#
# Known Bugs and Limitations
#
# [n] can't be specified on its own
# tstinter may fill up the disk leading to unusability of system
#
#*****************************************************************
#
# Security:
#
# Should not be run as root 
# Be sure that $TEMP/$FILE* does not match any valuable files 
# All care and no responsibilities taken
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
# start uname loop
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
  while (( i--)); do
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
    count=100K
  else
    count=$2
  fi
  dd if=/dev/zero of=$TEMPFILE$3 bs=4K count=$count
  while (( 1 )); do
    time dd if=$TEMPFILE$3 of=/dev/null bs=4K count=$count &> /dev/null
  done
  ;;
#
# Read as above in a xterm
#
_xread) xterm -e $TSTINTER _read "$2" $3 &;;
#
# Loop timed dd write of $2 4K blocks to file $3
#
_write) 
  if [ "$2" = "" ]; then
    count=100K
  else
    count=$2
  fi
  while (( 1 )); do
    time dd if=/dev/zero of=$TEMPFILE$3 bs=4K count=$count
  done
  ;;
#
# Write as above in a xterm
#
_xwrite) xterm -e $TSTINTER _write "$2" $3 &;;
#
# Start a xterm printing uname -a 
#
_xtu) xterm -e $TSTINTER _xtu1&;;
#             
# Loop uname -a with a short delay
#
_xtu1)
  i=0
  while (( 1 )); do
    ((i += 1)); echo -n "$i "
    uname -a
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


