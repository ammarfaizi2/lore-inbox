Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbRABUUE>; Tue, 2 Jan 2001 15:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbRABUTy>; Tue, 2 Jan 2001 15:19:54 -0500
Received: from duba06h06-0.dplanet.ch ([212.35.36.67]:36362 "EHLO
	duba06h06-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S131479AbRABUTk>; Tue, 2 Jan 2001 15:19:40 -0500
Message-ID: <3A523012.CF78B83D@dplanet.ch>
Date: Tue, 02 Jan 2001 20:46:26 +0100
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Coppermine is a PIII or a Celeron? WINCHIP2/WINCHIP3D diff?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When working in cpu autoconfiguration I found some problems:

I have to identify this processor:
  Vendor: Intel
  Family: 6
  Model:  8
Is it a "Pentium III (Coppermine)" (setup.c:1709)
or a "Celeron (Coppermine)" (setup.c:1650) ?


What is the difference between MWINCHIP2 and MWINCHIP3D?
I don't find differences in the sources


	giacomo



Version 3 of my cpu detection and configuration:


diff -uNr old.linux/CREDITS linux/CREDITS
--- old.linux/CREDITS	Fri Dec 29 13:32:46 2000
+++ linux/CREDITS	Fri Dec 29 13:43:02 2000
@@ -458,6 +458,12 @@
 S: Fremont, California 94539
 S: USA
 
+N: Giacomo Catenazzi
+E: cate@debian.org
+D: Random kernel hack and fixes
+D: Author of scripts/cpu_detect.sh
+S: Switzerland
+
 N: Gordon Chaffee
 E: chaffee@cs.berkeley.edu
 W: http://bmrc.berkeley.edu/people/chaffee/
diff -uNr old.linux/Makefile linux/Makefile
--- old.linux/Makefile	Fri Dec 29 11:26:55 2000
+++ linux/Makefile	Fri Dec 29 13:32:10 2000
@@ -65,6 +65,16 @@
 do-it-all:	config
 endif
 
+# Second stage configuration
+# Note that GNU make will read again this Makefile, so the CONFIG are
+# updated
+ifeq ($(CONFIG_CPU_CURRENT), y)
+CONFIGURATION = config2
+do-it-all:      config2
+.config:        config2
+	@echo "Rescanning the main Makefile"
+endif
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system
map
 # images.  Uncomment if you want to place them anywhere other than
root.
@@ -273,6 +283,14 @@
 
 config: symlinks
 	$(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
+
+config2:
+	echo "CONFIG_CPU_CURRENT=n" >> .config
+	echo `$(CONFIG_SHELL) $(TOPDIR)/scripts/cpu_detect.sh`=y >> .config
+	$(MAKE) oldconfig
+
+config2.test:
+	echo "CONFIG_CPU_CURRENT=$(CONFIG_CPU_CURRENT)"
 
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
 	scripts/split-include include/linux/autoconf.h include/config
diff -uNr old.linux/arch/i386/config.in linux/arch/i386/config.in
--- old.linux/arch/i386/config.in	Fri Dec 29 11:26:55 2000
+++ linux/arch/i386/config.in	Fri Dec 29 13:14:58 2000
@@ -26,7 +26,9 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-choice 'Processor family' \
+bool "Optimize for current CPU" CONFIG_CPU_CURRENT
+if [ "$CONFIG_CPU_CURRENT" != "y" ]; then
+   choice 'Processor family' \
 	"386				CONFIG_M386 \
 	 486				CONFIG_M486 \
 	 586/K5/5x86/6x86/6x86MX	CONFIG_M586 \
@@ -41,6 +43,10 @@
 	 Winchip-C6			CONFIG_MWINCHIPC6 \
 	 Winchip-2			CONFIG_MWINCHIP2 \
 	 Winchip-2A/Winchip-3		CONFIG_MWINCHIP3D" Pentium-Pro
+else
+   # First configuration stage: Allow all possible processors deps
+   define_bool CONFIG_M386 y
+fi
 #
 # Define implied options from the CPU selection here
 #
diff -uNr old.linux/scripts/cpu_detect.sh linux/scripts/cpu_detect.sh
--- old.linux/scripts/cpu_detect.sh	Thu Jan  1 01:00:00 1970
+++ linux/scripts/cpu_detect.sh	Tue Jan  2 10:29:31 2001
@@ -0,0 +1,81 @@
+#! /bin/bash
+
+# Copyright (C) 2000-2001  Giacomo Catenazzi  <cate@debian.org>
+# This is free software, see GNU General Public License 2 for details.
+
+# This script try to autodetect the CPU.
+# On SMP I assume that all processors are of the same type as the first
+
+# Version 3
+
+
+function check_cpu () {
+    if echo "$cpu_id" | egrep -e "$1" ; then
+	# CPU detected
+	echo $2
+	exit 0
+    fi
+}
+
+
+### i386 ###
+
+if [ "$ARCH" = "i386" ] ; then
+
+    if [ ! -r /proc/cpuinfo ] ; then
+	echo "cpu_detect: Could not read /proc/cpuinfo" 1>&2
+	echo CONFIG_M386
+	exit 2
+    fi
+
+  vendor=$(sed -n 's/^vendor_id.*: *\([-A-Za-z0-9_]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_fam=$(sed -n 's/^cpu family.*: *\([0-9A-Za-z]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_mod=$(sed -n 's/^model[^a-z]*: *\([0-9A-Za-z]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_name=$(sed -n 's/^model name.*: *\(.*\)$/\1/pg' /proc/cpuinfo)
+  cpu_id="$vendor:$cpu_fam:$cpu_mod:$cpu_name"
+
+    #echo $cpu_id  # for debug
+
+    check_cpu '^GenuineIntel:.*:.*:Pentium [67]'  CONFIG_M586TSC
+    check_cpu '^GenuineIntel:.*:.*:Pentium MMX'   CONFIG_M586MMX
+    check_cpu '^GenuineIntel:.*:.*:Pentium Pro'   CONFIG_M686
+    check_cpu '^GenuineIntel:.*:.*:Pentium II\>'  CONFIG_M686
+    check_cpu '^GenuineIntel:.*:.*:Celeron'       CONFIG_M686
+    check_cpu '^GenuineIntel:.*:.*:Pentium III'   CONFIG_M686FXSR
+    check_cpu '^GenuineIntel:.*:.*:Pentium IV'    CONFIG_MPENTIUM4   #
???
+    check_cpu '^GenuineIntel:4:.*:'               CONFIG_M486
+    check_cpu '^GenuineIntel:5:[01237]:'          CONFIG_M586TSC
+    check_cpu '^GenuineIntel:5:[48]:'             CONFIG_M586MMX
+    check_cpu '^GenuineIntel:6:[01356]:'          CONFIG_M686
+    check_cpu '^GenuineIntel:6:[789]:'            CONFIG_M686FXSR
+    check_cpu '^GenuineIntel:6:1[1]:'             CONFIG_M686FXSR
+
+    check_cpu '^AuthenticAMD:.*:.*:K5'            CONFIG_M586
+    check_cpu '^AuthenticAMD:.*:.*:K6'            CONFIG_MK6
+    check_cpu '^AuthenticAMD:.*:.*:Athlon'        CONFIG_MK7
+    check_cpu '^AuthenticAMD:4:.*:'               CONFIG_M486
+    check_cpu '^AuthenticAMD:5:[0123]:'           CONFIG_M586
+    check_cpu '^AuthenticAMD:5:[89]:'             CONFIG_MK6
+    check_cpu '^AuthenticAMD:5:1[01]:'            CONFIG_MK6
+    check_cpu '^AuthenticAMD:6:[0124]:'           CONFIG_MK7
+
+    check_cpu '^UMC:4:[12]:'                      CONFIG_M486
+    check_cpu '^NexGenDriven:.*:.*:Nx586'         CONFIG_M386
+    check_cpu '^NexGenDriven:5:0:'                CONFIG_M386
+    check_cpu '^TransmetaCPU:.*:.*:'              CONFIG_MCRUSOE
+    check_cpu '^GenuineTMx86:.*:.*:'              CONFIG_MCRUSOE
+
+    check_cpu '^CentaurHauls:.*:.*:WinChip C6'    CONFIG_MWINCHIPC6
+    check_cpu '^CentaurHauls:.*:.*:WinChip 2\>'   CONFIG_MWINCHIP2
+    check_cpu '^CentaurHauls:.*:.*:WinChip 2[AB]' CONFIG_MWINCHIP2A
+    check_cpu '^CentaurHauls:.*:.*:WinChip [34]'  CONFIG_MWINCHIP2A
+    check_cpu '^CentaurHauls:5:4:'                CONFIG_MWINCHIPC6
+
+    # default value
+    check_cpu '^.*:.*:.*:'                        CONFIG_M386
+    echo "cpu_detect: CPU not detected. Using default" 2>&1
+    exit 1
+fi
+
+echo "cpu_detect: ARCH '$ARCH' not implemented" 2>&1
+exit 3
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
