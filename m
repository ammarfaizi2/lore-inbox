Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVGFDF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVGFDF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGFDEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:04:25 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:7065 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262060AbVGFCT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:26 -0400
Subject: [PATCH] [21/48] Suspend2 2.1.9.8 for 2.6.12: 550-documentation.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164411280@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/Kconfig 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/Kconfig
--- 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/Kconfig	2005-02-03 22:33:50.000000000 +1100
+++ 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/Kconfig	2005-07-04 23:14:19.000000000 +1000
@@ -1,5 +1,6 @@
 config PM
 	bool "Power Management support"
+	select SYSFS
 	---help---
 	  "Power Management" means that parts of your computer are shut
 	  off or put into a power conserving "sleep" mode if they are not
@@ -30,6 +31,8 @@ config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
+	  Pavel's original version.
+
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
@@ -72,3 +75,77 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+menuconfig SUSPEND2
+	bool "Software Suspend 2"
+	depends on PM
+	---help---
+	  Software Suspend 2 is the 'new and improved' suspend support.
+	  
+	  See the Software Suspend home page (suspend2.net)
+	  for FAQs, HOWTOs and other documentation.
+
+	comment 'Image Storage (you need at least one writer)'
+		depends on SUSPEND2
+	
+	config SUSPEND2_FILEWRITER
+		bool '  File Writer'
+		depends on SUSPEND2
+		---help---
+		  This option enables support for storing an image in a
+		  simple file. This should be possible, but we're still
+		  testing it.
+
+	config SUSPEND2_SWAPWRITER
+		bool '  Swap Writer'
+		depends on SWAP && SUSPEND2
+		---help---
+		  This option enables support for storing an image in your
+		  swap space.
+
+	comment 'General Options'
+		depends on SUSPEND2
+
+	config SUSPEND2_DEFAULT_RESUME2
+		string '  Default resume device name'
+		depends on SUSPEND2
+		---help---
+		  You normally need to add a resume2= parameter to your lilo.conf or
+		  equivalent. With this option properly set, the kernel has a value
+		  to default. No damage will be done if the value is invalid.
+
+	config SUSPEND2_KEEP_IMAGE
+		bool '  Allow Keep Image Mode'
+		depends on SUSPEND2
+		---help---
+		  This option allows you to keep and image and reuse it. It is intended
+		  __ONLY__ for use with systems where all filesystems are mounted read-
+		  only (kiosks, for example). To use it, compile this option in and boot
+		  normally. Set the KEEP_IMAGE flag in /proc/software_suspend and suspend.
+		  When you resume, the image will not be removed. You will be unable to turn
+		  off swap partitions (assuming you are using the swap writer), but future
+		  suspends simply do a power-down. The image can be updated using the
+		  kernel command line parameter suspend_act= to turn off the keep image
+		  bit. Keep image mode is a little less user friendly on purpose - it
+		  should not be used without thought!
+
+	config SUSPEND2_CHECK_RESUME_SAFE
+		bool '  Warn if possibility of filesystem corruption'
+		depends on SUSPEND2
+		default y
+		---help---
+		  This option enables code that looks at what filesystems you have
+		  mounted prior to resuming. If you have any filesystems of type
+		  ext2, ext3, reiser or such like mounted rw, it will warn you
+		  before resuming and default to removing the image instead of
+		  resuming.
+		  
+		  If you're just beginning to set up suspend, it is a good idea to
+		  leave this option on. You can always turn this option off later -
+		  if you only change this option, recompiling the kernel/modules
+		  won't take long at all.
+
+		  Note that if you have this on and use an initrd/initramfs, you
+		  may well need to add
+			mount / -o remount,ro
+		  prior to the echo > /proc/software_suspend/resume call in your
+		  initrd/initramfs. You might want to remount it rw again afterwards.
diff -ruNp 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/Makefile 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/Makefile
--- 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/Makefile	2004-11-03 21:55:05.000000000 +1100
+++ 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/Makefile	2005-07-04 23:14:19.000000000 +1000
@@ -3,9 +3,13 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
-swsusp-smp-$(CONFIG_SMP)	+= smp.o
-
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y) disk.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= smp.o
+
+obj-$(CONFIG_SUSPEND2)			+= suspend2_core/
+obj-$(CONFIG_SUSPEND2_SWAPWRITER)	+= suspend_block_io.o suspend_swap.o
+obj-$(CONFIG_SUSPEND2_FILEWRITER)	+= suspend_block_io.o suspend_file.o
+
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff -ruNp 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/suspend2_core/Makefile 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/suspend2_core/Makefile
--- 560-Kconfig-and-Makefile-for-suspend2.patch-old/kernel/power/suspend2_core/Makefile	1970-01-01 10:00:00.000000000 +1000
+++ 560-Kconfig-and-Makefile-for-suspend2.patch-new/kernel/power/suspend2_core/Makefile	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,13 @@
+# Order is important for compression and encryption - we
+# compress before encrypting.
+
+suspend_core-objs := io.o pagedir.o prepare_image.o \
+		extent.o suspend.o plugins.o utility.o \
+		driver_model.o pageflags.o ui.o proc.o \
+		userspace-nofreeze.o all_settings.o \
+		power_off.o atomic_copy.o
+
+obj-$(CONFIG_SMP)			+= smp.o
+
+obj-$(CONFIG_SUSPEND2)			+= suspend_core.o
+obj-$(CONFIG_CRYPTO)			+= compression.o encryption.o

