Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUCOTy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbUCOTy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:54:59 -0500
Received: from gprs40-162.eurotel.cz ([160.218.40.162]:28346 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262731AbUCOTyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:54:52 -0500
Date: Mon, 15 Mar 2004 20:54:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Remove pmdisk from kernel
Message-ID: <20040315195440.GA1312@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This removes pmdisk from kernel. Nobody maintains it and swsusp
provides same functionality (and more, pmdisk is actually fork of
swsusp code).

3 files need to be removed by hand, I did not want to obscure patch by
removing them like that (and you probably have slightly different
pmdisk.c, anyway).

rm arch/i386/power/pmdisk.S
rm kernel/power/disk.c
rm kernel/power/pmdisk.c

								Pavel

PS: Alternatively, I'm wiling to kill swsusp, rename pmdisk to "swap
suspend", and submit patches to fix it. Its going to be slightly more
complicated, through... 

--- linux/arch/i386/defconfig	2004-03-11 18:16:02.000000000 +0100
+++ linux-nopmdisk/arch/i386/defconfig	2004-03-15 20:15:35.000000000 +0100
@@ -117,7 +117,6 @@
 #
 CONFIG_PM=y
 CONFIG_SOFTWARE_SUSPEND=y
-# CONFIG_PM_DISK is not set
 
 #
 # ACPI (Advanced Configuration and Power Interface) Support
--- linux/arch/i386/power/Makefile	2003-09-28 22:05:30.000000000 +0200
+++ linux-nopmdisk/arch/i386/power/Makefile	2004-03-15 20:15:54.000000000 +0100
@@ -1,3 +1,2 @@
 obj-$(CONFIG_PM)		+= cpu.o
-obj-$(CONFIG_PM_DISK)		+= pmdisk.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
--- linux/kernel/power/Kconfig	2004-02-23 20:20:42.000000000 +0100
+++ linux-nopmdisk/kernel/power/Kconfig	2004-03-15 20:11:56.000000000 +0100
@@ -42,52 +42,3 @@
 
 	  For more information take a look at Documentation/power/swsusp.txt.
 
-config PM_DISK
-	bool "Suspend-to-Disk Support"
-	depends on PM && SWAP
-	---help---
-	  Suspend-to-disk is a power management state in which the contents
-	  of memory are stored on disk and the entire system is shut down or
-	  put into a low-power state (e.g. ACPI S4). When the computer is 
-	  turned back on, the stored image is loaded from disk and execution
-	  resumes from where it left off before suspending. 
-
-	  This config option enables the core infrastructure necessary to 
-	  perform the suspend and resume transition. 
-
-	  Currently, this suspend-to-disk implementation is based on a forked
-	  version of the swsusp code base. As such, it's still experimental,
-	  and still relies on CONFIG_SWAP. 
-
-	  More information can be found in Documentation/power/.
-
-	  If unsure, Say N.
-
-config PM_DISK_PARTITION
-	string "Default resume partition"
-	depends on PM_DISK
-	default ""
-	---help---
-	  The default resume partition is the partition that the pmdisk suspend-
-	  to-disk implementation will look for a suspended disk image. 
-
-	  The partition specified here will be different for almost every user. 
-	  It should be a valid swap partition (at least for now) that is turned
-	  on before suspending. 
-
-	  The partition specified can be overridden by specifying:
-
-		pmdisk=/dev/<other device> 
-
-	  which will set the resume partition to the device specified. 
-
-	  One may also do: 
-
-		pmdisk=off
-
-	  to inform the kernel not to perform a resume transition. 
-
-	  Note there is currently not a way to specify which device to save the
-	  suspended image to. It will simply pick the first available swap 
-	  device.
-
--- linux/kernel/power/Makefile	2003-09-28 22:06:44.000000000 +0200
+++ linux-nopmdisk/kernel/power/Makefile	2004-03-15 20:12:13.000000000 +0100
@@ -1,5 +1,4 @@
 obj-y				:= main.o process.o console.o pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
-obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
