Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUGJT0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUGJT0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUGJT0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:26:04 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:63911 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266353AbUGJTYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:24:55 -0400
Subject: [PATCH] Documentation/laptop-mode.txt
From: Dax Kelson <dax@gurulabs.com>
To: Linus Torvalds <torvalds@osdl.org>, bart@samwel.tk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1089487487.3792.5.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 13:24:47 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a external configuration file for /sbin/laptop_mode, and
/etc/acpi/actions/battery.sh. Convert battery.sh to use CPUFreq (off by
default) instead of CPU throttling (that was off by default).

Cleanup some formating for 80 columns. 

All changes were written by me on a plane flight from Philadelphia to
Salt Lake City on July 9th. :)

--- linux-2.6.7/Documentation/laptop-mode.txt-org	2004-07-07 13:10:21.000000000 -0600
+++ linux-2.6.7/Documentation/laptop-mode.txt	2004-07-10 13:19:17.603239712 -0600
@@ -3,7 +3,7 @@
 
 Document Author: Bart Samwel (bart@samwel.tk)
 Date created: January 2, 2004
-Last modified: April 3, 2004
+Last modified: July 10, 2004
 
 Introduction
 ------------
@@ -158,13 +158,89 @@
   (http://noflushd.sourceforge.net/), it seems that noflushd prevents laptop-mode
   from doing its thing.
 
+Configuration file for control and ACPI battery scripts
+--------------
+
+This allows the tunables to be changed for the scripts via an external
+configuration file
+
+It should be installed as /etc/default/laptop-mode on Debian, and as
+/etc/sysconfig/laptop-mode on Red Hat, SUSE, Mandrake, and other work-alikes.
+
+--------------------CONFIG FILE BEGIN-------------------------------------------
+# Maximum time, in seconds, of hard drive spindown time that you are
+# confortable with. Worst case, it's possible that you could lose this
+# amount of work if your battery fails you while in laptop mode.
+MAX_AGE=600
+
+# Read-ahead, in kilobytes. You can spin down the disk while playing MP3/OGG, by
+# setting the disk readahead to 8MB (READAHEAD=16384). Effectively, the disk
+# will read a complete MP3 at once, and will then spin down while the MP3/OGG is
+# playing.
+READAHEAD=4096
+
+# Shall we remount journaled fs. with appropiate commit interval? (1=yes)
+DO_REMOUNTS=1
+
+# And shall we add the "noatime" option to that as well? (1=yes)
+DO_REMOUNT_NOATIME=1
+
+# Dirty synchronous ratio.  At this percentage of dirty pages the process
+# which
+# calls write() does its own writeback
+DIRTY_RATIO=40
+
+#
+# Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has been
+# exceeded, the kernel will wake pdflush which will then reduce the amount
+# of dirty memory to dirty_background_ratio.  Set this nice and low, so once
+# some writeout has commenced, we do a lot of it.
+#
+DIRTY_BACKGROUND_RATIO=5
+
+# kernel default dirty buffer age
+DEF_AGE=30
+DEF_UPDATE=5
+DEF_DIRTY_BACKGROUND_RATIO=10
+DEF_DIRTY_RATIO=40
+DEF_XFS_AGE_BUFFER=15
+DEF_XFS_SYNC_INTERVAL=30
+DEF_XFS_BUFD_INTERVAL=1
+
+# This must be adjusted manually to the value of HZ in the running kernel
+# on 2.4, until the XFS people change their 2.4 external interfaces to work in
+# centisecs. This can be automated, but it's a work in progress that still
+# needs# some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ for
+# external
+# interfaces, and that is currently always set to 100. So you don't need to
+# change this on 2.6.
+XFS_HZ=100
+
+# Should the maximum CPU frequency be adjusted down while on battery?
+# Requires CPUFreq to be setup.
+# See Documentation/cpu-freq/user-guide.txt for more info
+CPU_MANAGE=no
+
+# When on battery what is the maximum CPU speed that the system should
+# use? Legal values are "slowest" for the slowest speed that your 
+# CPU is able to operate at, or a value listed in:
+# /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
+# Only applicable if CPU_MANAGE=yes
+CPU_MAXFREQ=slowest
+
+# Spindown time for your hard drive (man hdparm for valid values)
+# I prefer 2 hours on AC and 20 seconds for battery
+AC_HD=244
+BATT_HD=4
+
+--------------------CONFIG FILE END---------------------------------------------
 
 Control script
 --------------
 
 Please note that this control script works for the Linux 2.4 and 2.6 series.
 
---------------------CONTROL SCRIPT BEGIN------------------------------------------
+--------------------CONTROL SCRIPT BEGIN----------------------------------------
 #!/bin/bash
 
 # start or stop laptop_mode, best run by a power management daemon when
@@ -183,21 +259,35 @@
 
 #############################################################################
 
-# Age time, in seconds. should be put into a sysconfig file
-MAX_AGE=600
+# Source config
+if [ -f /etc/default/laptop-mode ] ; then
+	# Debian
+	. /etc/default/laptop-mode
+elif [ -f /etc/sysconfig/laptop-mode ] ; then
+	# Others
+        . /etc/sysconfig/laptop-mode
+fi
+
+# Don't raise an error if the config file is incomplete
+# set defaults instead:
+
+# Maximum time, in seconds, of hard drive spindown time that you are
+# confortable with. Worst case, it's possible that you could lose this
+# amount of work if your battery fails you while in laptop mode.
+MAX_AGE=${MAX_AGE:-'600'}
 
 # Read-ahead, in kilobytes
-READAHEAD=4096
+READAHEAD=${READAHEAD:-'4096'}
 
 # Shall we remount journaled fs. with appropiate commit interval? (1=yes)
-DO_REMOUNTS=1
+DO_REMOUNTS=${DO_REMOUNTS:-'1'}
 
 # And shall we add the "noatime" option to that as well? (1=yes)
-DO_REMOUNT_NOATIME=1
+DO_REMOUNT_NOATIME=${DO_REMOUNT_NOATIME:-'1'}
 
 # Dirty synchronous ratio.  At this percentage of dirty pages the process which
 # calls write() does its own writeback
-DIRTY_RATIO=40
+DIRTY_RATIO=${DIRTY_RATIO:-'40'}
 
 #
 # Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has been
@@ -205,16 +295,16 @@
 # of dirty memory to dirty_background_ratio.  Set this nice and low, so once
 # some writeout has commenced, we do a lot of it.
 #
-DIRTY_BACKGROUND_RATIO=5
+DIRTY_BACKGROUND_RATIO=${DIRTY_BACKGROUND_RATIO:-'5'}
 
 # kernel default dirty buffer age
-DEF_AGE=30
-DEF_UPDATE=5
-DEF_DIRTY_BACKGROUND_RATIO=10
-DEF_DIRTY_RATIO=40
-DEF_XFS_AGE_BUFFER=15
-DEF_XFS_SYNC_INTERVAL=30
-DEF_XFS_BUFD_INTERVAL=1
+DEF_AGE=${DEF_AGE:-'30'}
+DEF_UPDATE=${DEF_UPDATE:-'5'}
+DEF_DIRTY_BACKGROUND_RATIO=${DEF_DIRTY_BACKGROUND_RATIO:-'10'}
+DEF_DIRTY_RATIO=${DEF_DIRTY_RATIO:-'40'}
+DEF_XFS_AGE_BUFFER=${DEF_XFS_AGE_BUFFER:-'15'}
+DEF_XFS_SYNC_INTERVAL=${DEF_XFS_SYNC_INTERVAL:-'30'}
+DEF_XFS_BUFD_INTERVAL=${DEF_XFS_BUFD_INTERVAL:-'1'}
 
 # This must be adjusted manually to the value of HZ in the running kernel
 # on 2.4, until the XFS people change their 2.4 external interfaces to work in
@@ -222,7 +312,7 @@
 # some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ for external
 # interfaces, and that is currently always set to 100. So you don't need to
 # change this on 2.6.
-XFS_HZ=100
+XFS_HZ=${XFS_HZ:-'100'}
 
 #############################################################################
 
@@ -466,7 +556,7 @@
 esac
 
 exit 0
---------------------CONTROL SCRIPT END--------------------------------------------
+--------------------CONTROL SCRIPT END------------------------------------------
 
 
 ACPI integration
@@ -475,22 +565,34 @@
 Dax Kelson submitted this so that the ACPI acpid daemon will
 kick off the laptop_mode script and run hdparm.
 
----------------------------/etc/acpi/events/ac_adapter BEGIN-------------------------------------------
+-----------------/etc/acpi/events/ac_adapter BEGIN------------------------------
 event=ac_adapter
 action=/etc/acpi/actions/battery.sh
----------------------------/etc/acpi/events/ac_adapter END-------------------------------------------
+----------------/etc/acpi/events/ac_adapter END---------------------------------
 
----------------------------/etc/acpi/actions/battery.sh BEGIN-------------------------------------------
-#!/bin/sh
+----------------/etc/acpi/actions/battery.sh BEGIN------------------------------
+#!/bin/bash
 
-# cpu throttling
-# cat /proc/acpi/processor/CPU0/throttling for more info
-ACAD_THR=0
-BATT_THR=2
+# Source config
+if [ -f /etc/default/laptop-mode ] ; then
+	# Debian
+	. /etc/default/laptop-mode
+elif [ -f /etc/sysconfig/laptop-mode ] ; then
+	# Others
+        . /etc/sysconfig/laptop-mode
+fi
+
+# Don't raise an error if the config file is incomplete
+# set defaults instead:
+ 
+# cpu frequency scaling
+# See Documentation/cpu-freq/user-guide.txt for more info
+CPU_MANAGE=${CPU_MANAGE:-'no'}
+CPU_MAXFREQ=${CPU_MAXFREQ:-'slowest'}
 
 # spindown time for HD (man hdparm for valid values)
-# I prefer 2 hours for acad and 20 seconds for batt
-ACAD_HD=244
+# I prefer 2 hours on AC and 20 seconds for battery
+AC_HD=244
 BATT_HD=4
 
 # ac/battery event handler
@@ -501,9 +603,11 @@
         "on-line")
                 echo "Setting HD spindown for AC mode."
                 /sbin/laptop_mode stop
-                /sbin/hdparm -S $ACAD_HD /dev/hda > /dev/null 2>&1
+                /sbin/hdparm -S $AC_HD /dev/hda > /dev/null 2>&1
                 /sbin/hdparm -B 255 /dev/hda > /dev/null 2>&1
-                #echo -n $ACAD_CPU:$ACAD_THR > /proc/acpi/processor/CPU0/limit
+                if [ $CPU_MANAGE = 'yes' ]; then
+			echo `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq` > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
+		fi 
                 exit 0
         ;;
         "off-line")
@@ -511,11 +615,16 @@
                 /sbin/laptop_mode start
                 /sbin/hdparm -S $BATT_HD /dev/hda > /dev/null 2>&1
                 /sbin/hdparm -B 1 /dev/hda > /dev/null 2>&1
-                #echo -n $BATT_CPU:$BATT_THR > /proc/acpi/processor/CPU0/limit
+                if [ $CPU_MANAGE = 'yes' -a -e /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq ]; then
+			if [ $CPU_MAXFREQ = 'slowest' ]; then
+				CPU_MAXFREQ=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`
+			fi
+			echo $CPU_MAXFREQ > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
+		fi
                 exit 0
         ;;
 esac
----------------------------/etc/acpi/actions/battery.sh END-------------------------------------------
+---------------------------/etc/acpi/actions/battery.sh END---------------------
 
 Monitoring tool
 ---------------
@@ -523,7 +632,7 @@
 Bartek Kania submitted this, it can be used to measure how much time your disk
 spends spun up/down.
 
----------------------------dslm.c BEGIN-------------------------------------------
+---------------------------dslm.c BEGIN-----------------------------------------
 /*
  * Simple Disk Sleep Monitor
  *  by Bartek Kania
@@ -689,4 +798,4 @@
 
     return 0;
 }
----------------------------dslm.c END---------------------------------------------
+---------------------------dslm.c END-------------------------------------------


