Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbQL2ONM>; Fri, 29 Dec 2000 09:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQL2ONC>; Fri, 29 Dec 2000 09:13:02 -0500
Received: from dubb05h09-0.dplanet.ch ([212.35.36.9]:57863 "EHLO
	duba02h02-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S129803AbQL2OMq>; Fri, 29 Dec 2000 09:12:46 -0500
Message-ID: <3A4C941E.EA824F87@student.ethz.ch>
Date: Fri, 29 Dec 2000 14:39:42 +0100
From: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: [PATCH] Processor autodetection (when configuring kernel)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Here a first try to autodetect the processor when configure kernel.

How it works:
1) I add a CONFIG_CPU_CURRENT boolean.
2) If it is set, the next Makefile will call script/cpu_detect.sh
   and try to detect the processor (it return CONFIG_M386 if it fails)
3) Makefile sets the autodetected processor and CONFIG_CPU_CURRENT=n,
   so next time it will use the already detected CPU
4) it does a make oldconfig to configure the the other processor flags (
   and to be sure that it will be a correct configuration file)
4) The GNU make will automagically restart makefile, bacause and include
   (include .config) is changed.


I don't know well the non-intel processors, so addition for extra
processors are welcome.

	giacomo


The patch
=========


diff -urN old.linux/Makefile linux/Makefile
--- old.linux/Makefile  Fri Dec 29 11:26:55 2000
+++ linux/Makefile      Fri Dec 29 13:32:10 2000
@@ -65,6 +65,16 @@
 do-it-all:     config
 endif
 
+# Second stage configuration
+# Note that GNU make will read again this Makefile, so the CONFIG are
+# updated
+ifeq ($(CONFIG_CPU_CURRENT), y)
+CONFIGURATION = config2
+do-it-all:      config2
+.config:        config2
+       @echo "Rescanning the main Makefile"
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
+       echo "CONFIG_CPU_CURRENT=n" >> .config
+       echo `$(CONFIG_SHELL) $(TOPDIR)/scripts/cpu_detect.sh`=y >>
.config
+       $(MAKE) oldconfig
+
+config2.test:
+       echo "CONFIG_CPU_CURRENT=$(CONFIG_CPU_CURRENT)"
 
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
        scripts/split-include include/linux/autoconf.h include/config
diff -urN old.linux/arch/i386/config.in linux/arch/i386/config.in
--- old.linux/arch/i386/config.in       Fri Dec 29 11:26:55 2000
+++ linux/arch/i386/config.in   Fri Dec 29 13:14:58 2000
@@ -26,7 +26,9 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-choice 'Processor family' \
+bool "Optimize for current CPU" CONFIG_CPU_CURRENT
+if [ "$CONFIG_CPU_CURRENT" != "y" ]; then
+   choice 'Processor family' \
        "386                            CONFIG_M386 \
         486                            CONFIG_M486 \
         586/K5/5x86/6x86/6x86MX        CONFIG_M586 \
@@ -41,6 +43,10 @@
         Winchip-C6                     CONFIG_MWINCHIPC6 \
         Winchip-2                      CONFIG_MWINCHIP2 \
         Winchip-2A/Winchip-3           CONFIG_MWINCHIP3D" Pentium-Pro
+else
+   # First configuration stage: Allow all possible processors deps
+   define_bool CONFIG_M386 y
+fi
 #
 # Define implied options from the CPU selection here
 #
diff -urN old.linux/scripts/cpu_detect.sh linux/scripts/cpu_detect.sh
--- old.linux/scripts/cpu_detect.sh     Thu Jan  1 01:00:00 1970
+++ linux/scripts/cpu_detect.sh Fri Dec 29 14:10:42 2000
@@ -0,0 +1,35 @@
+#! /bin/bash
+
+# Copyright (C) 2000  Giacomo Catenazzi  <cate@debian.org>
+# This is free software, see GNU General Public License 2 for details.
+
+# This script try to autodetect the CPU.
+# On SMP I assume that all processors are of the same type as the first
+
+
+if [ "$ARCH" = "i386" ] ; then
+  vendor=$(sed -n 's/^vendor_id.*: \([-A-Za-z0-9_]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_fam=$(sed -n 's/^cpu family.*: \([0-9A-Za-z]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_mod=$(sed -n 's/^model[^a-z]*: \([0-9A-Za-z]*\).*$/\1/pg'
/proc/cpuinfo)
+  cpu_id="$vendor:$cpu_fam:$cpu_mod"
+
+  #echo $cpu_id  # for debug
+
+  case $cpu_id in
+    GenuineIntel:5:[0123]      )  echo CONFIG_M586TSC   ;;
+    GenuineIntel:5:[48]        )  echo CONFIG_M586MMX   ;;
+    GenuineIntel:6:[01356]     )  echo CONFIG_M686      ;;
+    GenuineIntel:6:{8,9,11}    )  echo CONFIG_M686FXSR  ;;
+    AuthenticAMD:5:[0123]      )  echo CONFIG_M586      ;;
+    AuthenticAMD:5:{8,9,10,11} )  echo CONFIG_MK6       ;;
+    AuthenticAMD:6:[0124]      )  echo CONFIG_MK7       ;;
+    UMC:4:[12]                 )  echo CONFIG_M486      ;; # "UMC" !
+    NexGenDriven:5:0           )  echo CONFIG_M386      ;;
+    {TransmetaCPU,GenuineTMx86}:* ) echo CONFIG_MCROSUE ;;   
+
+    # some default values
+
+    *                          )  echo CONFIG_M386      ;;
+
+  esac
+fi
diff -urN old.linux/CREDITS linux/CREDITS
--- old.linux/CREDITS   Fri Dec 29 13:32:46 2000
+++ linux/CREDITS       Fri Dec 29 13:43:02 2000
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
