Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbULEVzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbULEVzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbULEVzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:55:18 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:36224 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261403AbULEVve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:51:34 -0500
Date: Sun, 5 Dec 2004 22:49:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: swsusp-bigdiff: power-managment changes that are waiting in my tree
Message-ID: <20041205214910.GA1293@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is diff between my tree and mainline; it includes swsusp speedups
and driver-model-related changes. It also includes some junk; I tried
to kill part of it, but this is more "take a look what I have".

It is also right tree to send swsusp patches against :-).

Nigel, if you are still wiling to benchmark swsusp1 vs. suspend2,
please try 2.6.9+ this one.

pm-list: this is direction my tree is heading. These are only first
steps, and obviously lots of drivers are missing.
								Pavel

--- clean/Documentation/pm.txt	2001-12-19 22:38:12.000000000 +0100
+++ linux/Documentation/pm.txt	2004-10-26 12:44:23.000000000 +0200
@@ -36,8 +36,8 @@
   apmd:   http://worldvisions.ca/~apenwarr/apmd/
   acpid:  http://acpid.sf.net/
 
-Driver Interface
-----------------
+Driver Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
 If you are writing a new driver or maintaining an old driver, it
 should include power management support.  Without power management
 support, a single driver may prevent a system with power management
@@ -91,54 +91,6 @@
 void pm_unregister_all(pm_callback cback);
 
 /*
- * Device idle/use detection
- *
- * In general, drivers for all devices should call "pm_access"
- * before accessing the hardware (ie. before reading or modifying
- * a hardware register).  Request or packet-driven drivers should
- * additionally call "pm_dev_idle" when a device is not being used.
- *
- * Examples:
- * 1) A keyboard driver would call pm_access whenever a key is pressed
- * 2) A network driver would call pm_access before submitting
- *    a packet for transmit or receive and pm_dev_idle when its
- *    transfer and receive queues are empty.
- * 3) A VGA driver would call pm_access before it accesses any
- *    of the video controller registers
- *
- * Ultimately, the PM policy manager uses the access and idle
- * information to decide when to suspend individual devices
- * or when to suspend the entire system
- */
-
-/*
- * Description: Update device access time and wake up device, if necessary
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- *
- * Details: If called from an interrupt handler pm_access updates
- *          access time but should never need to wake up the device
- *          (if device is generating interrupts, it should be awake
- *          already)  This is important as we can not wake up
- *          devices from an interrupt handler.
- */
-void pm_access(struct pm_dev *dev);
-
-/*
- * Description: Identify device as currently being idle
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- *
- * Details: A call to pm_dev_idle might signal to the policy manager
- *          to put a device to sleep.  If a new device request arrives
- *          between the call to pm_dev_idle and the pm_callback
- *          callback, the driver should fail the pm_callback request.
- */
-void pm_dev_idle(struct pm_dev *dev);
-
-/*
  * Power management request callback
  *
  * Parameters:
@@ -262,8 +214,8 @@
 
 ACPI Development mailing list: acpi-devel@lists.sourceforge.net
 
-System Interface
-----------------
+System Interface -- OBSOLETE, DO NOT USE!
+----------------*************************
 If you are providing new power management support to Linux (ie.
 adding support for something like APM or ACPI), you should
 communicate with drivers through the existing generic power
--- clean/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
+++ linux/Documentation/power/devices.txt	2004-11-03 02:16:40.000000000 +0100
@@ -141,3 +141,82 @@
 The driver core will not call any extra functions when binding the
 device to the driver. 
 
+pm_message_t meaning
+
+pm_message_t has two fields. event ("major"), and flags.  If driver
+does not know event code, it aborts the request, returning error. Some
+drivers may need to deal with special cases based on the actual type
+of suspend operation being done at the system level. This is why
+there are flags.
+
+Event codes are:
+
+ON -- no need to do anything except special cases like broken
+HW.
+
+FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
+scratch. That probably means stop accepting upstream requests, the
+actual policy of what to do with them beeing specific to a given
+driver. It's acceptable for a network driver to just drop packets
+while a block driver is expected to block the queue so no request is
+lost. (Use IDE as an example on how to do that). FREEZE requires no
+power state change, and it's expected for drivers to be able to
+quickly transition back to operating state.
+
+SUSPEND -- like FREEZE, but also put hardware into low-power state. If
+there's need to distinguish several levels of sleep, additional flag
+is probably best way to do that.
+
+All events are: 
+
+#Prepare for suspend -- userland is still running but we are going to
+#enter suspend state. This gives drivers chance to load firmware from
+#disk and store it in memory, or do other activities taht require
+#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
+#are forbiden once the suspend dance is started.. event = ON, flags =
+#PREPARE_TO_SUSPEND
+
+Apm standby -- prepare for APM event. Quiesce devices to make life
+easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
+
+Apm suspend -- same as APM_STANDBY, but it we should probably avoid
+spinning down disks. event = FREEZE, flags = APM_SUSPEND
+
+System halt, reboot -- quiesce devices to make life easier for BIOS. event
+= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
+
+System shutdown -- at least disks need to be spun down, or data may be
+lost. Quiesce devices, just to make life easier for BIOS. event =
+FREEZE, flags = SYSTEM_SHUTDOWN
+
+Kexec    -- turn off DMAs and put hardware into some state where new
+kernel can take over. event = FREEZE, flags = KEXEC
+
+Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
+may need to be enabled on some devices. This actually has at least 3
+subtypes, system can reboot, enter S4 and enter S5 at the end of
+swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
+SYSTEM_SHUTDOWN, SYSTEM_S4
+
+Suspend to ram  -- put devices into low power state. event = SUSPEND,
+flags = SUSPEND_TO_RAM
+
+Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
+devices into low power mode, but you must be able to reinitialize
+device from scratch in resume method. This has two flavors, its done
+once on suspending kernel, once on resuming kernel. event = FREEZE,
+flags = DURING_SUSPEND or DURING_RESUME
+
+Device detach requested from /sys -- deinitialize device; proably same as
+SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
+= FREEZE, flags = DEV_DETACH.
+
+#These are not really events sent:
+#
+#System fully on -- device is working normally; this is probably never
+#passed to suspend() method... event = ON, flags = 0
+#
+#Ready after resume -- userland is now running, again. Time to free any
+#memory you ate during prepare to suspend... event = ON, flags =
+#READY_AFTER_RESUME
+#
--- clean/Documentation/power/swsusp.txt	2004-10-01 00:29:56.000000000 +0200
+++ linux/Documentation/power/swsusp.txt	2004-11-29 14:02:25.000000000 +0100
@@ -15,10 +15,21 @@
  * If you change kernel command line between suspend and resume...
  *			        ...prepare for nasty fsck or worse.
  *
- * (*) pm interface support is needed to make it safe.
+ * If you change your hardware while system is suspended...
+ *			        ...well, it was not good idea.
+ *
+ * (*) suspend/resume support is needed to make it safe.
 
 You need to append resume=/dev/your_swap_partition to kernel command
-line. Then you suspend by echo 4 > /proc/acpi/sleep.
+line. Then you suspend by 
+
+echo shutdown > /sys/power/disk; echo disk > /sys/power/state
+
+. If you feel ACPI works pretty well on your system, you might try
+
+echo platform > /sys/power/disk; echo disk > /sys/power/state
+
+
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -32,42 +43,24 @@
 to standby mode. Later resuming the machine the saved state is loaded back to
 ram and the machine can continue its work. It has two real benefits. First we
 save ourselves the time machine goes down and later boots up, energy costs
-real high when running from batteries. The other gain is that we don't have to
+are real high when running from batteries. The other gain is that we don't have to
 interrupt our programs so processes that are calculating something for a long
 time shouldn't need to be written interruptible.
 
-Using the code
-
-You have two ways to use this code. The first one is is with a patched
-SysVinit (my patch is against 2.76 and available at my home page). You
-might call 'swsusp' or 'shutdown -z <time>'. Next way is to echo 4 >
-/proc/acpi/sleep.
-
-Either way it saves the state of the machine into active swaps and then
-reboots.  You must explicitly specify the swap partition to resume from with
+swsusp saves the state of the machine into active swaps and then reboots or
+powerdowns.  You must explicitly specify the swap partition to resume from with
 ``resume='' kernel option. If signature is found it loads and restores saved
 state. If the option ``noresume'' is specified as a boot parameter, it skips
 the resuming.
 
-In the meantime while the system is suspended you should not touch any of the
-hardware!
+In the meantime while the system is suspended you should not add/remove any
+of the hardware, write to the filesystems, etc.
 
-About the code
+Sleep states summary
+====================
 
-Things to implement
-- We should only make a copy of data related to kernel segment, since any
-  process data won't be changed.
-- Should make more sanity checks. Or are these enough?
-
-Not so important ideas for implementing
-
-- If a real time process is running then don't suspend the machine.
-- Support for adding/removing hardware while suspended?
-- We should not free pages at the beginning so aggressively, most of them
-  go there anyway..
-
-Sleep states summary (thanx, Ducrot)
-====================================
+There are three different interfaces you can use, /proc/acpi should
+work like this:
 
 In a really perfect world:
 echo 1 > /proc/acpi/sleep       # for standby
@@ -79,7 +72,6 @@
 and perhaps
 echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
 
-
 Frequently Asked Questions
 ==========================
 
@@ -123,27 +115,13 @@
 
 Q: Does linux support ACPI S4?
 
-A: No.
-
-When swsusp was created, ACPI was not too widespread, so we tried to
-avoid using ACPI-specific stuff. ACPI also is/was notoriously
-buggy. These days swsusp works on APM-only i386 machines and even
-without any power managment at all. Some versions also work on PPC.
-
-That means that machine does not enter S4 on suspend-to-disk, but
-simply enters S5. That has few advantages, you can for example boot
-windows on next boot, and return to your Linux session later. You
-could even have few different Linuxes on your box (not sharing any
-partitions), and switch between them.
-
-It also has disadvantages. On HP nx5000, if you unplug power cord
-while machine is suspended-to-disk, Linux will fail to notice that.
+A: Yes. That's what echo platform > /sys/power/disk does.
 
 Q: My machine doesn't work with ACPI. How can I use swsusp than ?
 
 A: Do a reboot() syscall with right parameters. Warning: glibc gets in
 its way, so check with strace:
-
+ 
 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
 
 (Thanks to Peter Osterlund:)
@@ -162,6 +140,8 @@
     return 0;
 }
 
+Also /sys/ interface should be still present.
+
 Q: What is 'suspend2'?
 
 A: suspend2 is 'Software Suspend 2', a forked implementation of
@@ -175,17 +155,22 @@
 website, and not to the Linux Kernel Mailing List. We are working
 toward merging suspend2 into the mainline kernel.
 
-Q: Kernel thread must voluntarily freeze itself (call 'refrigerator'). But
-I found some kernel threads don't do it, and they don't freeze, and
+Q: A kernel thread must voluntarily freeze itself (call 'refrigerator').
+I found some kernel threads that don't do it, and they don't freeze
 so the system can't sleep. Is this a known behavior?
 
-A: All such kernel threads need to be fixed, one by one. Select place
-where it is safe to be frozen (no kernel semaphores should be held at
-that point and it must be safe to sleep there), and add:
+A: All such kernel threads need to be fixed, one by one. Select the
+place where the thread is safe to be frozen (no kernel semaphores
+should be held at that point and it must be safe to sleep there), and
+add:
 
             if (current->flags & PF_FREEZE)
                     refrigerator(PF_FREEZE);
 
+If the thread is needed for writing the image to storage, you should
+instead set the PF_NOFREEZE process flag when creating the thread.
+
+
 Q: What is the difference between between "platform", "shutdown" and
 "firmware" in /sys/power/disk?
 
@@ -201,3 +186,50 @@
 
 "platform" is actually right thing to do, but "shutdown" is most
 reliable.
+
+Q: I do not understand why you have such strong objections to idea of
+selective suspend.
+
+A: Do selective suspend during runtime power managment, that's okay. But
+its useless for suspend-to-disk. (And I do not see how you could use
+it for suspend-to-ram, I hope you do not want that).
+
+Lets see, so you suggest to
+
+* SUSPEND all but swap device and parents
+* Snapshot
+* Write image to disk
+* SUSPEND swap device and parents
+* Powerdown
+
+Oh no, that does not work, if swap device or its parents uses DMA,
+you've corrupted data. You'd have to do
+
+* SUSPEND all but swap device and parents
+* FREEZE swap device and parents
+* Snapshot
+* UNFREEZE swap device and parents
+* Write
+* SUSPEND swap device and parents
+
+Which means that you still need that FREEZE state, and you get more
+complicated code. (And I have not yet introduce details like system
+devices).
+
+Q: There don't seem to be any generally useful behavioral
+distinctions between SUSPEND and FREEZE.
+
+A: Doing SUSPEND when you are asked to do FREEZE is always correct,
+but it may be unneccessarily slow. If you want USB to stay simple,
+slowness may not matter to you. It can always be fixed later.
+
+For devices like disk it does matter, you do not want to spindown for
+FREEZE.
+
+Q: After resuming, system is paging heavilly, leading to very bad interactivity.
+
+A: Try running
+
+cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
+
+after resume.
--- clean/Documentation/power/video.txt	2004-08-15 19:14:52.000000000 +0200
+++ linux/Documentation/power/video.txt	2004-10-29 11:56:46.000000000 +0200
@@ -17,15 +17,18 @@
 
 * systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)
 
-* systems that initialize video card into vga text mode and where BIOS
-  works well enough to be able to set video mode. Use
-  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
-
 * systems where it is possible to call video bios during S3
   resume. Unfortunately, it is not correct to call video BIOS at that
   point, but it happens to work on some machines. Use
   acpi_sleep=s3_bios (Athlon64 desktop system)
 
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+
+* on some systems s3_bios kicks video into text mode, and
+  acpi_sleep=s3_bios,s3_mode is needed (Toshiba Satellite P10-554)
+
 * radeon systems, where X can soft-boot your video card. You'll need
   patched X, and plain text console (no vesafb or radeonfb), see
   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
--- clean/Documentation/sparse.txt	2004-10-16 23:48:08.000000000 +0200
+++ linux/Documentation/sparse.txt	2004-10-24 22:44:47.000000000 +0200
@@ -0,0 +1,72 @@
+Copyright 2004 Linus Torvalds
+Copyright 2004 Pavel Machek <pavel@suse.cz>
+
+Using sparse for typechecking
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+"__bitwise" is a type attribute, so you have to do something like this:
+
+        typedef int __bitwise pm_request_t;
+
+        enum pm_request {
+                PM_SUSPEND = (__force pm_request_t) 1,
+                PM_RESUME = (__force pm_request_t) 2
+        };
+
+which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force" is
+there because sparse will complain about casting to/from a bitwise type,
+but in this case we really _do_ want to force the conversion). And because
+the enum values are all the same type, now "enum pm_request" will be that
+type too.
+
+And with gcc, all the __bitwise/__force stuff goes away, and it all ends
+up looking just like integers to gcc.
+
+Quite frankly, you don't need the enum there. The above all really just
+boils down to one special "int __bitwise" type.
+
+So the simpler way is to just do
+
+        typedef int __bitwise pm_request_t;
+
+        #define PM_SUSPEND ((__force pm_request_t) 1)
+        #define PM_RESUME ((__force pm_request_t) 2)
+
+and you now have all the infrastructure needed for strict typechecking.
+
+One small note: the constant integer "0" is special. You can use a
+constant zero as a bitwise integer type without sparse ever complaining.
+This is because "bitwise" (as the name implies) was designed for making
+sure that bitwise types don't get mixed up (little-endian vs big-endian
+vs cpu-endian vs whatever), and there the constant "0" really _is_
+special.
+
+Modify top-level Makefile to say
+
+CHECK           = sparse -Wbitwise
+
+or you don't get any checking at all.
+
+
+Where to get sparse
+~~~~~~~~~~~~~~~~~~~
+
+With BK, you can just get it from
+
+        bk://sparse.bkbits.net/sparse
+
+and DaveJ has tar-balls at
+
+	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+
+
+Once you have it, just do
+
+        make
+        make install
+
+as your regular user, and it will install sparse in your ~/bin directory.
+After that, doing a kernel make with "make C=1" will run sparse on all the
+C files that get recompiled, or with "make C=2" will run sparse on the
+files whether they need to be recompiled or not (ie the latter is fast way
+to check the whole tree if you have already built it).
--- clean/Makefile	2004-10-19 14:16:26.000000000 +0200
+++ linux/Makefile	2004-10-29 11:56:48.000000000 +0200
@@ -325,7 +325,7 @@
 DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
-CHECK		= sparse
+CHECK		= sparse -Wbitwise
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
--- clean/arch/arm/common/amba.c	2004-04-05 10:45:09.000000000 +0200
+++ linux/arch/arm/common/amba.c	2004-11-04 00:28:43.000000000 +0100
@@ -59,7 +59,7 @@
 #define amba_hotplug NULL
 #endif
 
-static int amba_suspend(struct device *dev, u32 state)
+static int amba_suspend(struct device *dev, pm_message_t state)
 {
 	struct amba_driver *drv = to_amba_driver(dev->driver);
 	int ret = 0;
--- clean/arch/arm/common/locomo.c	2004-08-15 19:14:52.000000000 +0200
+++ linux/arch/arm/common/locomo.c	2004-11-04 00:29:01.000000000 +0100
@@ -673,7 +673,7 @@
 	return dev->devid == drv->devid;
 }
 
-static int locomo_bus_suspend(struct device *dev, u32 state)
+static int locomo_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct locomo_dev *ldev = LOCOMO_DEV(dev);
 	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
--- clean/arch/arm/common/sa1111.c	2004-10-01 00:29:57.000000000 +0200
+++ linux/arch/arm/common/sa1111.c	2004-11-04 00:29:35.000000000 +0100
@@ -1185,7 +1185,7 @@
 	return dev->devid == drv->devid;
 }
 
-static int sa1111_bus_suspend(struct device *dev, u32 state)
+static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct sa1111_dev *sadev = SA1111_DEV(dev);
 	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
--- clean/arch/arm/mach-pxa/pm.c	2004-10-19 14:16:27.000000000 +0200
+++ linux/arch/arm/mach-pxa/pm.c	2004-10-26 00:26:44.000000000 +0200
@@ -66,7 +66,7 @@
 };
 
 
-static int pxa_pm_enter(u32 state)
+static int pxa_pm_enter(suspend_state_t state)
 {
 	unsigned long sleep_save[SLEEP_SAVE_SIZE];
 	unsigned long checksum = 0;
@@ -182,7 +182,7 @@
 /*
  * Called after processes are frozen, but before we shut down devices.
  */
-static int pxa_pm_prepare(u32 state)
+static int pxa_pm_prepare(suspend_state_t state)
 {
 	return 0;
 }
@@ -190,7 +190,7 @@
 /*
  * Called after devices are re-setup, but before processes are thawed.
  */
-static int pxa_pm_finish(u32 state)
+static int pxa_pm_finish(suspend_state_t state)
 {
 	return 0;
 }
--- clean/arch/arm/mach-sa1100/pm.c	2004-10-19 14:16:27.000000000 +0200
+++ linux/arch/arm/mach-sa1100/pm.c	2004-10-26 00:27:12.000000000 +0200
@@ -57,7 +57,7 @@
 };
 
 
-static int sa11x0_pm_enter(u32 state)
+static int sa11x0_pm_enter(suspend_state_t state)
 {
 	unsigned long gpio, sleep_save[SLEEP_SAVE_SIZE];
 	struct timespec delta, rtc;
@@ -153,7 +153,7 @@
 /*
  * Called after processes are frozen, but before we shut down devices.
  */
-static int sa11x0_pm_prepare(u32 state)
+static int sa11x0_pm_prepare(suspend_state_t state)
 {
 	return 0;
 }
@@ -161,7 +161,7 @@
 /*
  * Called after devices are re-setup, but before processes are thawed.
  */
-static int sa11x0_pm_finish(u32 state)
+static int sa11x0_pm_finish(suspend_state_t state)
 {
 	return 0;
 }
--- clean/arch/i386/kernel/acpi/sleep.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/kernel/acpi/sleep.c	2004-10-29 11:56:46.000000000 +0200
@@ -56,11 +56,11 @@
 }
 
 /*
- * acpi_restore_state
+ * acpi_restore_state - undo effects of acpi_save_state_mem
  */
 void acpi_restore_state_mem (void)
 {
-	zap_low_mappings();
+//	zap_low_mappings();
 }
 
 /**
--- clean/arch/i386/kernel/acpi/wakeup.S	2004-06-22 12:35:47.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2004-10-29 11:56:46.000000000 +0200
@@ -11,7 +11,22 @@
 #
 # If physical address of wakeup_code is 0x12345, BIOS should call us with
 # cs = 0x1234, eip = 0x05
-# 
+#
+
+#define BEEP \
+	inb	$97, %al; 	\
+	outb	%al, $0x80; 	\
+	movb	$3, %al; 	\
+	outb	%al, $97; 	\
+	outb	%al, $0x80; 	\
+	movb	$-74, %al; 	\
+	outb	%al, $67; 	\
+	outb	%al, $0x80; 	\
+	movb	$-119, %al; 	\
+	outb	%al, $66; 	\
+	outb	%al, $0x80; 	\
+	movb	$15, %al; 	\
+	outb	%al, $66;
 
 ALIGN
 	.align	4096
@@ -20,6 +35,7 @@
 	wakeup_code_start = .
 	.code16
 
+	BEEP
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
@@ -253,7 +269,7 @@
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags
 
-	movl $ret_point,saved_eip
+	movl $ret_point, saved_eip
 	ret
 
 
@@ -270,7 +286,7 @@
 	call	save_registers
 	pushl	$3
 	call	acpi_enter_sleep_state
-	addl	$4,%esp
+	addl	$4, %esp
 	ret
 	.p2align 4,,7
 ret_point:
--- clean/arch/i386/kernel/apm.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/kernel/apm.c	2004-11-14 23:36:46.000000000 +0100
@@ -1201,8 +1201,8 @@
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 
-	device_suspend(3);
-	device_power_down(3);
+	device_suspend(PMSG_SUSPEND);
+	device_power_down(PMSG_SUSPEND);
 
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
@@ -1255,7 +1255,7 @@
 {
 	int	err;
 
-	device_power_down(3);
+	device_power_down(PMSG_SUSPEND);
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
--- clean/arch/i386/kernel/io_apic.c	2004-10-19 14:16:27.000000000 +0200
+++ linux/arch/i386/kernel/io_apic.c	2004-12-01 13:43:52.000000000 +0100
@@ -572,6 +572,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
+		try_to_freeze(PF_FREEZE);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			do_irq_balance();
@@ -2266,8 +2267,10 @@
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
 	check_timer();
+#ifdef DEBUG
 	if (!acpi_ioapic)
 		print_IO_APIC();
+#endif
 }
 
 /*
--- clean/arch/i386/kernel/signal.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/kernel/signal.c	2004-10-29 11:56:46.000000000 +0200
@@ -587,7 +587,8 @@
 
 	if (current->flags & PF_FREEZE) {
 		refrigerator(0);
-		goto no_signal;
+		if (!signal_pending(current))
+			goto no_signal;
 	}
 
 	if (!oldset)
--- clean/arch/i386/kernel/time.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2004-10-29 11:56:46.000000000 +0200
@@ -319,7 +319,7 @@
 	return retval;
 }
 
-static long clock_cmos_diff;
+static long clock_cmos_diff, sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,6 +328,7 @@
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
+	sleep_start = get_cmos_time();
 	return 0;
 }
 
@@ -335,10 +336,13 @@
 {
 	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sleep_length = get_cmos_time() - sleep_start;
+
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+	jiffies += sleep_length * HZ;
 	return 0;
 }
 
--- clean/arch/i386/power/cpu.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-10-29 11:56:46.000000000 +0200
@@ -148,6 +148,6 @@
 	__restore_processor_state(&saved_context);
 }
 
-
+/* Needed by apm.c */
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);
--- clean/arch/x86_64/kernel/time.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/arch/x86_64/kernel/time.c	2004-10-29 11:56:46.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/x86-64/kernel/time.c
+ *  linux/arch/x86_64/kernel/time.c
  *
  *  "High Precision Event Timer" based timekeeping.
  *
@@ -22,7 +22,6 @@
 #include <linux/time.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
@@ -779,7 +778,17 @@
 	return 0;
 }
 
-void __init pit_init(void)
+static struct sysdev_class rtc_sysclass = {
+	set_kset_name("rtc"),
+};
+
+/* XXX this driverfs stuff should probably go elsewhere later -john */
+static struct sys_device device_rtc = {
+	.id		= 0,
+	.cls	= &rtc_sysclass,
+};
+
+int __init pit_init(void)
 {
 	unsigned long flags;
 
@@ -788,8 +797,22 @@
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
+
+	return 0;
+}
+
+static int pit_devicefs_init(void)
+{
+	int error = sysdev_class_register(&rtc_sysclass);
+#if 0
+	if (!error)
+		error = sysdev_register(&device_rtc);
+#endif
+	return error;
 }
 
+late_initcall(pit_devicefs_init);
+
 int __init time_setup(char *str)
 {
 	report_lost_ticks = 1;
@@ -870,7 +893,8 @@
 
 __setup("report_lost_ticks", time_setup);
 
-static long clock_cmos_diff;
+
+static long clock_cmos_diff, sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -879,17 +903,21 @@
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
+	sleep_start = get_cmos_time();
 	return 0;
 }
 
 static int time_resume(struct sys_device *dev)
 {
 	unsigned long flags;
+	unsigned long sleep_length = get_cmos_time() - sleep_start;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock,flags);
+	printk(KERN_INFO "Slept for %d:%d minutes\n", sleep_length/60, sleep_length%60);
+	jiffies += sleep_length * HZ;
 	return 0;
 }
 
@@ -909,8 +937,10 @@
 static int time_init_device(void)
 {
 	int error = sysdev_class_register(&pit_sysclass);
+#if 0
 	if (!error)
 		error = sysdev_register(&device_i8253);
+#endif
 	return error;
 }
 
--- clean/drivers/acpi/events/evgpeblk.c	2004-10-01 00:30:09.000000000 +0200
+++ linux/drivers/acpi/events/evgpeblk.c	2004-11-01 09:18:06.000000000 +0100
@@ -925,7 +925,7 @@
 
 	/*
 	 * Runtime option: Should Wake GPEs be enabled at runtime?  The default
-	 * is No,they should only be enabled just as the machine goes to sleep.
+	 * is No, they should only be enabled just as the machine goes to sleep.
 	 */
 	if (acpi_gbl_leave_wake_gpes_disabled) {
 		/*
--- clean/drivers/acpi/sleep/main.c	2004-10-01 00:30:09.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2004-11-04 00:18:36.000000000 +0100
@@ -42,7 +42,7 @@
  *	wakeup code to the waking vector. 
  */
 
-static int acpi_pm_prepare(u32 pm_state)
+static int acpi_pm_prepare(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
@@ -74,7 +74,7 @@
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
 
-static int acpi_pm_enter(u32 pm_state)
+static int acpi_pm_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
 	unsigned long flags = 0;
@@ -136,7 +136,7 @@
  *	failed). 
  */
 
-static int acpi_pm_finish(u32 pm_state)
+static int acpi_pm_finish(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
@@ -156,7 +156,7 @@
 
 int acpi_suspend(u32 acpi_state)
 {
-	u32 states[] = {
+	suspend_state_t states[] = {
 		[1]	= PM_SUSPEND_STANDBY,
 		[3]	= PM_SUSPEND_MEM,
 		[4]	= PM_SUSPEND_DISK,
--- clean/drivers/base/platform.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/platform.c	2004-11-04 00:31:33.000000000 +0100
@@ -238,7 +238,7 @@
 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 }
 
-static int platform_suspend(struct device * dev, u32 state)
+static int platform_suspend(struct device * dev, pm_message_t state)
 {
 	int ret = 0;
 
--- clean/drivers/base/power/power.h	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/power.h	2004-11-14 23:36:46.000000000 +0100
@@ -66,14 +66,14 @@
 /*
  * suspend.c
  */
-extern int suspend_device(struct device *, u32);
+extern int suspend_device(struct device *, pm_message_t);
 
 
 /*
  * runtime.c
  */
 
-extern int dpm_runtime_suspend(struct device *, u32);
+extern int dpm_runtime_suspend(struct device *, pm_message_t);
 extern void dpm_runtime_resume(struct device *);
 
 #else /* CONFIG_PM */
@@ -88,7 +88,7 @@
 
 }
 
-static inline int dpm_runtime_suspend(struct device * dev, u32 state)
+static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	return 0;
 }
--- clean/drivers/base/power/resume.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/resume.c	2004-11-14 23:36:46.000000000 +0100
@@ -36,7 +36,7 @@
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
-		if (!dev->power.prev_state)
+		if (dev->power.prev_state == PMSG_ON)
 			resume_device(dev);
 
 		list_add_tail(entry, &dpm_active);
--- clean/drivers/base/power/runtime.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/runtime.c	2004-11-14 23:36:46.000000000 +0100
@@ -13,10 +13,10 @@
 static void runtime_resume(struct device * dev)
 {
 	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state)
+	if (dev->power.power_state == PMSG_ON)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
@@ -44,7 +44,7 @@
  *	@state:	State to enter.
  */
 
-int dpm_runtime_suspend(struct device * dev, u32 state)
+int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -52,7 +52,7 @@
 	if (dev->power.power_state == state)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state != PMSG_ON)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
@@ -73,7 +73,7 @@
  *	always be able to tell, but we need accurate information to
  *	work reliably.
  */
-void dpm_set_power_state(struct device * dev, u32 state)
+void dpm_set_power_state(struct device * dev, pm_message_t state)
 {
 	down(&dpm_sem);
 	dev->power.power_state = state;
--- clean/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-11-14 23:36:46.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
--- clean/drivers/base/power/suspend.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-11-14 23:36:46.000000000 +0100
@@ -11,7 +11,7 @@
 #include <linux/device.h>
 #include "power.h"
 
-extern int sysdev_suspend(u32 state);
+extern int sysdev_suspend(pm_message_t state);
 
 /*
  * The entries in the dpm_active list are in a depth first order, simply
@@ -35,7 +35,7 @@
  *	@state:	Power state device is entering.
  */
 
-int suspend_device(struct device * dev, u32 state)
+int suspend_device(struct device * dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -43,7 +43,7 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (dev->power.power_state == PMSG_ON))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
@@ -70,7 +70,7 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
@@ -112,7 +112,7 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down(pm_message_t state)
 {
 	int error = 0;
 	struct device * dev;
--- clean/drivers/char/vt.c	2004-10-01 00:30:12.000000000 +0200
+++ linux/drivers/char/vt.c	2004-10-26 00:14:17.000000000 +0200
@@ -2186,8 +2186,6 @@
 	if (!printable || test_and_set_bit(0, &printing))
 		return;
 
-	pm_access(pm_con);
-
 	if (kmsg_redirect && vc_cons_allocated(kmsg_redirect - 1))
 		currcons = kmsg_redirect - 1;
 
@@ -2387,7 +2385,6 @@
 {
 	int	retval;
 
-	pm_access(pm_con);
 	retval = do_con_write(tty, from_user, buf, count);
 	con_flush_chars(tty);
 
@@ -2398,7 +2395,6 @@
 {
 	if (in_interrupt())
 		return;	/* n_r3964 calls put_char() from interrupt context */
-	pm_access(pm_con);
 	do_con_write(tty, 0, &ch, 1);
 }
 
@@ -2467,8 +2463,6 @@
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
 
-	pm_access(pm_con);
-	
 	/* if we race with con_close(), vt may be null */
 	acquire_console_sem();
 	vt = tty->driver_data;
--- clean/drivers/ide/ide-disk.c	2004-10-01 00:30:12.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2004-10-29 11:56:48.000000000 +0200
@@ -1419,9 +1419,12 @@
 {
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+#if 0
+		/* FIXME!! */
+		if (system_state == SYSTEM_SNAPSHOT)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
+#endif
 			rq->pm->pm_step = idedisk_pm_standby;
 		break;
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
@@ -1702,7 +1705,6 @@
 		return;
 	}
 
-	printk("Shutdown: %s\n", drive->name);
 	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
 }
 
--- clean/drivers/ide/ide.c	2004-10-01 00:30:12.000000000 +0200
+++ linux/drivers/ide/ide.c	2004-11-04 00:32:27.000000000 +0100
@@ -1499,7 +1499,7 @@
 	return 1;
 }
 
-static int generic_ide_suspend(struct device *dev, u32 state)
+static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
 	ide_drive_t *drive = dev->driver_data;
 	struct request rq;
--- clean/drivers/ieee1394/ieee1394_core.c	2004-06-22 12:36:07.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_core.c	2004-10-29 11:56:46.000000000 +0200
@@ -1039,6 +1039,11 @@
 			continue;
 		}
 
+		if (current->flags & PF_FREEZE) {
+			refrigerator(0);
+			continue;
+		}
+
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
 
--- clean/drivers/input/input.c	2004-08-15 19:14:56.000000000 +0200
+++ linux/drivers/input/input.c	2004-10-25 23:54:57.000000000 +0200
@@ -67,9 +67,6 @@
 {
 	struct input_handle *handle;
 
-	if (dev->pm_dev)
-		pm_access(dev->pm_dev);
-
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
@@ -230,8 +227,6 @@
 
 int input_open_device(struct input_handle *handle)
 {
-	if (handle->dev->pm_dev)
-		pm_access(handle->dev->pm_dev);
 	handle->open++;
 	if (handle->dev->open)
 		return handle->dev->open(handle->dev);
@@ -249,8 +244,6 @@
 void input_close_device(struct input_handle *handle)
 {
 	input_release_device(handle);
-	if (handle->dev->pm_dev)
-		pm_dev_idle(handle->dev->pm_dev);
 	if (handle->dev->close)
 		handle->dev->close(handle->dev);
 	handle->open--;
--- clean/drivers/input/keyboard/atkbd.c	2004-10-01 00:30:13.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2004-10-31 23:46:05.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
+#include <linux/dmi.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -986,8 +987,39 @@
 	.cleanup	= atkbd_cleanup,
 };
 
+static int __init add_evo_keys(struct dmi_system_id *d)
+{
+	printk("Compaq Evo detected, mapping extra keys\n");
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x23] ] = 150;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1e] ] = 155;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1a] ] = 217;
+	atkbd_set2_keycode[0x80 | atkbd_unxlate_table[0x1f] ] = 157;
+	return 0;
+}
+
+static struct dmi_system_id __initdata keyboard_dmi_table[] = {
+	{       /* Handle special keys on Compaq Evo */
+		.callback = add_evo_keys,
+		.ident = "Compaq Evo",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Evo N620c"),
+		},
+	},
+	{       /* Handle special keys on Compaq Evo */
+		.callback = add_evo_keys,
+		.ident = "Compaq Evo",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Evo N600c"),
+		},
+	}
+};
+
+
 int __init atkbd_init(void)
 {
+	dmi_check_system(keyboard_dmi_table);
 	serio_register_driver(&atkbd_drv);
 	return 0;
 }
--- clean/drivers/media/video/bttv-driver.c	2004-10-01 00:30:14.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-11-01 21:25:09.000000000 +0100
@@ -3945,7 +3945,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev, btv->state.pci_cfg);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}
@@ -3964,7 +3964,7 @@
 		pci_enable_device(pci_dev);
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, btv->state.pci_cfg);
 
 	/* restore bt878 state */
--- clean/drivers/net/3c59x.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/drivers/net/3c59x.c	2004-11-14 23:36:46.000000000 +0100
@@ -1550,7 +1550,7 @@
 	int i;
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
@@ -2942,7 +2942,7 @@
 	/* The kernel core really should have pci_get_power_state() */
 
 	if(state != 0)
-		pci_set_power_state(VORTEX_PCI(vp), 0);
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);
 	err = vortex_do_ioctl(dev, rq, cmd);
 	if(state != 0)
 		pci_set_power_state(VORTEX_PCI(vp), state);
@@ -3141,7 +3141,7 @@
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
 	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
-	pci_set_power_state(VORTEX_PCI(vp), 3);
+	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 }
 
 
@@ -3164,7 +3164,7 @@
 	unregister_netdev(dev);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
--- clean/drivers/net/8139cp.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/8139cp.c	2004-11-14 23:36:46.000000000 +0100
@@ -1623,7 +1623,7 @@
 static void cp_set_d3_state (struct cp_private *cp)
 {
 	pci_enable_wake (cp->pdev, 0, 1); /* Enable PME# generation */
-	pci_set_power_state (cp->pdev, 3);
+	pci_set_power_state (cp->pdev, PCI_D3hot);
 }
 
 static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1813,7 +1813,7 @@
 		BUG();
 	unregister_netdev(dev);
 	iounmap(cp->regs);
-	if (cp->wol_enabled) pci_set_power_state (pdev, 0);
+	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);
 	pci_release_regions(pdev);
 	pci_clear_mwi(pdev);
 	pci_disable_device(pdev);
@@ -1863,7 +1863,7 @@
 	netif_device_attach (dev);
 	
 	if (cp->pdev && cp->wol_enabled) {
-		pci_set_power_state (cp->pdev, 0);
+		pci_set_power_state (cp->pdev, PCI_D0);
 		pci_restore_state (cp->pdev, cp->power_state);
 	}
 	
--- clean/drivers/net/8139too.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/8139too.c	2004-11-01 20:41:29.000000000 +0100
@@ -2608,7 +2608,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -2622,7 +2622,7 @@
 	pci_restore_state (pdev, tp->pci_state);
 	if (!netif_running (dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
--- clean/drivers/net/amd8111e.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/amd8111e.c	2004-11-14 23:48:04.000000000 +0100
@@ -1865,17 +1865,17 @@
 		if(lp->options & OPTION_WAKE_PHY_ENABLE)
 			amd8111e_enable_link_change(lp);	
 		
-		pci_enable_wake(pci_dev, 3, 1);
-		pci_enable_wake(pci_dev, 4, 1); /* D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 1);
+		pci_enable_wake(pci_dev, PCI_D3cold, 1);
 
 	}
 	else{		
-		pci_enable_wake(pci_dev, 3, 0);
-		pci_enable_wake(pci_dev, 4, 0); /* 4 == D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 0);
+		pci_enable_wake(pci_dev, PCI_D3cold, 0);
 	}
 	
 	pci_save_state(pci_dev, lp->pm_state);
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 
 	return 0;
 }
@@ -1887,11 +1887,11 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, lp->pm_state);
 
-	pci_enable_wake(pci_dev, 3, 0);
-	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3hot, 0);
+	pci_enable_wake(pci_dev, PCI_D3cold, 0);
 
 	netif_device_attach(dev);
 
--- clean/drivers/net/b44.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/b44.c	2004-10-29 11:56:47.000000000 +0200
@@ -1,6 +1,7 @@
 /* b44.c: Broadcom 4400 device driver.
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2004 Pavel Machek (pavel@suse.cz)
  * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
  *
  * Distribute under GPL.
@@ -89,6 +90,10 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
 };
 
@@ -606,9 +611,6 @@
 		struct ring_info *rp = &bp->tx_buffers[cons];
 		struct sk_buff *skb = rp->skb;
 
-		if (unlikely(skb == NULL))
-			BUG();
-
 		pci_unmap_single(bp->pdev,
 				 pci_unmap_addr(rp, mapping),
 				 skb->len,
@@ -1307,9 +1309,6 @@
 
 	spin_lock_irq(&bp->lock);
 
-#if 0
-	b44_dump_state(bp);
-#endif
 	b44_halt(bp);
 	b44_free_rings(bp);
 	bp->flags &= ~B44_FLAG_INIT_COMPLETE;
@@ -1885,6 +1884,8 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1898,6 +1899,9 @@
 	if (!netif_running(dev))
 		return 0;
 
+	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
+		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
+
 	spin_lock_irq(&bp->lock);
 
 	b44_init_rings(bp);
--- clean/drivers/net/e100.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/e100.c	2004-11-14 23:36:46.000000000 +0100
@@ -2313,7 +2313,7 @@
 	pci_save_state(pdev, nic->pm_state);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -2323,7 +2323,7 @@
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, nic->pm_state);
 	e100_hw_init(nic);
 
--- clean/drivers/net/eepro100.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/eepro100.c	2004-11-14 23:36:46.000000000 +0100
@@ -155,16 +155,6 @@
 
 #define RUN_AT(x) (jiffies + (x))
 
-/* ACPI power states don't universally work (yet) */
-#ifndef CONFIG_PM
-#undef pci_set_power_state
-#define pci_set_power_state null_set_power_state
-static inline int null_set_power_state(struct pci_dev *dev, int state)
-{
-	return 0;
-}
-#endif /* CONFIG_PM */
-
 #define netdevice_start(dev)
 #define netdevice_stop(dev)
 #define netif_set_tx_timeout(dev, tf, tm) \
@@ -1015,7 +1005,7 @@
 	if (netif_msg_ifup(sp))
 		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
 
-	pci_set_power_state(sp->pdev, 0);
+	pci_set_power_state(sp->pdev, PCI_D0);
 
 	/* Set up the Tx queue early.. */
 	sp->cur_tx = 0;
@@ -1964,7 +1954,7 @@
 	if (netif_msg_ifdown(sp))
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, PCI_D2);
 
 	return 0;
 }
@@ -2103,7 +2093,7 @@
 		   access from the timeout handler.
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
@@ -2114,7 +2104,7 @@
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(dev, data->phy_id, data->reg_num, data->val_in);
 		if (t)
--- clean/drivers/net/pci-skeleton.c	2004-08-15 19:14:58.000000000 +0200
+++ linux/drivers/net/pci-skeleton.c	2004-11-14 23:36:46.000000000 +0100
@@ -1922,7 +1922,7 @@
 	spin_unlock_irqrestore (&tp->lock, flags);
 
 	pci_save_state (pdev, tp->pci_state);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -1935,7 +1935,7 @@
 
 	if (!netif_running(dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state (pdev, tp->pci_state);
 	netif_device_attach (dev);
 	netdrv_hw_start (dev);
--- clean/drivers/net/sis900.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/sis900.c	2004-11-14 23:36:46.000000000 +0100
@@ -2212,7 +2212,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 	pci_save_state(pci_dev, sis_priv->pci_state);
 
 	return 0;
@@ -2227,7 +2227,7 @@
 	if(!netif_running(net_dev))
 		return 0;
 	pci_restore_state(pci_dev, sis_priv->pci_state);
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 
 	sis900_init_rxfilter(net_dev);
 
--- clean/drivers/net/starfire.c	2004-08-15 19:14:58.000000000 +0200
+++ linux/drivers/net/starfire.c	2004-11-14 23:36:46.000000000 +0100
@@ -2186,7 +2186,7 @@
 	unregister_netdev(dev);
 
 	/* XXX: add wakeup code -- requires firmware for MagicPacket */
-	pci_set_power_state(pdev, 3);	/* go to sleep in D3 mode */
+	pci_set_power_state(pdev, PCI_D3hot);	/* go to sleep in D3 mode */
 	pci_disable_device(pdev);
 
 	iounmap((char *)dev->base_addr);
--- clean/drivers/net/typhoon.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/net/typhoon.c	2004-11-14 23:36:46.000000000 +0100
@@ -1884,7 +1884,7 @@
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int
@@ -1893,7 +1893,7 @@
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, tp->pci_state);
 
 	/* Post 2.x.x versions of the Sleep Image require a reset before
@@ -2541,7 +2541,7 @@
 	struct typhoon *tp = (struct typhoon *) (dev->priv);
 
 	unregister_netdev(dev);
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev, tp->pci_state);
 	typhoon_reset(tp->ioaddr, NoWait);
 	iounmap(tp->ioaddr);
--- clean/drivers/net/via-rhine.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/net/via-rhine.c	2004-11-01 20:35:30.000000000 +0100
@@ -1957,6 +1957,7 @@
 	rhine_shutdown(&pdev->dev);
 	spin_unlock_irqrestore(&rp->lock, flags);
 
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1970,7 +1971,10 @@
 	if (!netif_running(dev))
 		return 0;
 
-	ret = pci_set_power_state(pdev, 0);
+        if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
+		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
+
+	ret = pci_set_power_state(pdev, PCI_D0);
 	if (debug > 1)
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
 			dev->name, ret ? "failed" : "succeeded", ret);
--- clean/drivers/net/via-velocity.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/drivers/net/via-velocity.c	2004-11-14 23:36:46.000000000 +0100
@@ -804,7 +804,7 @@
 	
 	/* and leave the chip powered down */
 	
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 #ifdef CONFIG_PM
 	{
 		unsigned long flags;
@@ -1742,7 +1742,7 @@
 		goto err_free_rd_ring;
 	
 	/* Ensure chip is running */	
-	pci_set_power_state(vptr->pdev, 0);
+	pci_set_power_state(vptr->pdev, PCI_D0);
 	
 	velocity_init_registers(vptr, VELOCITY_INIT_COLD);
 
@@ -1750,7 +1750,7 @@
 			  dev->name, dev);
 	if (ret < 0) {
 		/* Power down the chip */
-		pci_set_power_state(vptr->pdev, 3);
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		goto err_free_td_ring;
 	}
 
@@ -1868,7 +1868,7 @@
 		free_irq(dev->irq, dev);
 		
 	/* Power down the chip */
-	pci_set_power_state(vptr->pdev, 3);
+	pci_set_power_state(vptr->pdev, PCI_D3hot);
 	
 	/* Free the resources */
 	velocity_free_td_ring(vptr);
@@ -2194,8 +2194,8 @@
 	/* If we are asked for information and the device is power
 	   saving then we need to bring the device back up to talk to it */
 	   	
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 		
 	switch (cmd) {
 	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
@@ -2207,8 +2207,8 @@
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		
 		
 	return ret;
@@ -2818,8 +2818,8 @@
 static int velocity_ethtool_up(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 	return 0;
 }	
 
@@ -2834,8 +2834,8 @@
 static void velocity_ethtool_down(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 }
 
 static int velocity_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
@@ -3229,15 +3229,15 @@
 		velocity_shutdown(vptr);
 		velocity_set_wol(vptr);
 		pci_enable_wake(pdev, 3, 1);
-		pci_set_power_state(pdev, 3);
+		pci_set_power_state(pdev, PCI_D3hot);
 	} else {
 		velocity_save_context(vptr, &vptr->context);
 		velocity_shutdown(vptr);
 		pci_disable_device(pdev);
-		pci_set_power_state(pdev, state);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	}
 #else
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif
 	spin_unlock_irqrestore(&vptr->lock, flags);
 	return 0;
@@ -3252,7 +3252,7 @@
 	if(!netif_running(vptr->dev))
 		return 0;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_wake(pdev, 0, 0);
 	pci_restore_state(pdev, vptr->pci_state);
 
--- clean/drivers/pci/pci-driver.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/pci/pci-driver.c	2004-11-04 00:26:44.000000000 +0100
@@ -295,7 +295,7 @@
 	return 0;
 }
 
-static int pci_device_suspend(struct device * dev, u32 state)
+static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
--- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
@@ -229,7 +229,7 @@
 /**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: Power state we're entering
+ * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
  *
  * Transition a device to a new power state, using the Power Management 
  * Capabilities in the device's config space.
@@ -242,7 +242,7 @@
  */
 
 int
-pci_set_power_state(struct pci_dev *dev, int state)
+pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	int pm;
 	u16 pmcsr;
@@ -300,6 +300,30 @@
 }
 
 /**
+ * pci_choose_state - Choose the power state of a PCI device
+ * @dev: PCI device to be suspended
+ * @state: target sleep state for the whole system
+ *
+ * Returns PCI power state suitable for given device and given system
+ * message.
+ */
+
+pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+{
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return PCI_D0;
+
+	switch (state) {
+	case 0:	return PCI_D0;
+	case 2: return PCI_D2;
+	case 3: return PCI_D3hot;
+	default: BUG();
+	}
+}
+
+EXPORT_SYMBOL(pci_choose_state);
+
+/**
  * pci_save_state - save the PCI configuration space of a device before suspending
  * @dev: - PCI device that we're dealing with
  * @buffer: - buffer to hold config space context
@@ -365,7 +389,7 @@
 {
 	int err;
 
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	if ((err = pcibios_enable_device(dev, bars)) < 0)
 		return err;
 	return 0;
@@ -422,7 +446,7 @@
  * 0 if operation is successful.
  * 
  */
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
 	u16 value;
--- clean/drivers/usb/core/hcd-pci.c	2004-10-01 00:30:19.000000000 +0200
+++ linux/drivers/usb/core/hcd-pci.c	2004-11-14 23:36:46.000000000 +0100
@@ -355,8 +355,8 @@
 	hcd->state = USB_STATE_RESUMING;
 
 	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+		pci_set_power_state (dev, PCI_D0);
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
 	if (retval < 0) {
--- clean/drivers/usb/host/ohci-hub.c	2004-10-19 14:16:28.000000000 +0200
+++ linux/drivers/usb/host/ohci-hub.c	2004-11-14 23:36:46.000000000 +0100
@@ -76,7 +76,7 @@
 	struct usb_device	*root = hcd_to_bus (&ohci->hcd)->root_hub;
 	int			status = 0;
 
-	if (root->dev.power.power_state != 0)
+	if (root->dev.power.power_state != PMSG_ON)
 		return 0;
 	if (time_before (jiffies, ohci->next_statechange))
 		return -EAGAIN;
--- clean/include/asm-i386/suspend.h	2004-08-15 19:15:04.000000000 +0200
+++ linux/include/asm-i386/suspend.h	2004-10-29 11:56:46.000000000 +0200
@@ -9,6 +9,9 @@
 static inline int
 arch_prepare_suspend(void)
 {
+	/* If you want to make non-PSE machine work, turn off paging
+           in do_magic. swsusp_pg_dir should have identity mapping, so
+           it could work...  */
 	if (!cpu_has_pse)
 		return -EPERM;
 	return 0;
--- clean/include/linux/device.h	2004-10-01 00:30:29.000000000 +0200
+++ linux/include/linux/device.h	2004-11-04 00:25:52.000000000 +0100
@@ -61,7 +61,7 @@
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
-	int		(*suspend)(struct device * dev, u32 state);
+	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
 
--- clean/include/linux/page-flags.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/page-flags.h	2004-10-19 16:38:18.000000000 +0200
@@ -74,7 +74,7 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-
+#define PG_nosave_free		19	/* Page is free and should not be written */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -277,6 +277,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
+#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
+#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-11-14 23:36:46.000000000 +0100
@@ -480,6 +480,14 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+typedef int __bitwise pci_power_t;
+
+#define PCI_D0	((pci_power_t __force) 0)
+#define PCI_D1	((pci_power_t __force) 1)
+#define PCI_D2	((pci_power_t __force) 2)
+#define PCI_D3hot	((pci_power_t __force) 3)
+#define PCI_D3cold	((pci_power_t __force) 4)
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -508,7 +516,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
-	u32             current_state;  /* Current operating state. In ACPI-speak,
+	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
@@ -645,7 +653,7 @@
 	struct pci_dynids dynids;
 };
 
-#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
+#define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
@@ -781,8 +789,8 @@
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
-int pci_set_power_state(struct pci_dev *dev, int state);
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 void pci_bus_assign_resources(struct pci_bus *bus);
--- clean/include/linux/pm.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pm.h	2004-11-14 23:36:46.000000000 +0100
@@ -28,44 +28,28 @@
 #include <asm/atomic.h>
 
 /*
- * Power management requests
+ * Power management requests... these are passed to pm_send_all() and friends.
+ *
+ * these functions are old and deprecated, see below.
  */
-enum
-{
-	PM_SUSPEND, /* enter D1-D3 */
-	PM_RESUME,  /* enter D0 */
-
-	PM_SAVE_STATE,  /* save device's state */
+typedef int __bitwise pm_request_t;
 
-	/* enable wake-on */
-	PM_SET_WAKEUP,
-
-	/* bus resource management */
-	PM_GET_RESOURCES,
-	PM_SET_RESOURCES,
-
-	/* base station management */
-	PM_EJECT,
-	PM_LOCK,
-};
+#define PM_SUSPEND	((__force pm_request_t) 1)	/* enter D1-D3 */
+#define PM_RESUME	((__force pm_request_t) 2)	/* enter D0 */
 
-typedef int pm_request_t;
 
 /*
- * Device types
+ * Device types... these are passed to pm_register
  */
-enum
-{
-	PM_UNKNOWN_DEV = 0, /* generic */
-	PM_SYS_DEV,	    /* system device (fan, KB controller, ...) */
-	PM_PCI_DEV,	    /* PCI device */
-	PM_USB_DEV,	    /* USB device */
-	PM_SCSI_DEV,	    /* SCSI device */
-	PM_ISA_DEV,	    /* ISA device */
-	PM_MTD_DEV,	    /* Memory Technology Device */
-};
+typedef int __bitwise pm_dev_t;
 
-typedef int pm_dev_t;
+#define PM_UNKNOWN_DEV	((__force pm_request_t) 0)	/* generic */
+#define PM_SYS_DEV	((__force pm_request_t) 1)	/* system device (fan, KB controller, ...) */
+#define PM_PCI_DEV	((__force pm_request_t) 2)	/* PCI device */
+#define PM_USB_DEV	((__force pm_request_t) 3)	/* USB device */
+#define PM_SCSI_DEV	((__force pm_request_t) 4)	/* SCSI device */
+#define PM_ISA_DEV	((__force pm_request_t) 5)	/* ISA device */
+#define	PM_MTD_DEV	((__force pm_request_t) 6)	/* Memory Technology Device */
 
 /*
  * System device hardware ID (PnP) values
@@ -119,37 +103,27 @@
 /*
  * Register a device with power management
  */
-struct pm_dev *pm_register(pm_dev_t type,
-			   unsigned long id,
-			   pm_callback callback);
+struct pm_dev __deprecated *pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
  * Unregister a device with power management
  */
-void pm_unregister(struct pm_dev *dev);
+void __deprecated pm_unregister(struct pm_dev *dev);
 
 /*
  * Unregister all devices with matching callback
  */
-void pm_unregister_all(pm_callback callback);
+void __deprecated pm_unregister_all(pm_callback callback);
 
 /*
  * Send a request to a single device
  */
-int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
+int __deprecated pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
 
 /*
  * Send a request to all devices
  */
-int pm_send_all(pm_request_t rqst, void *data);
-
-/*
- * Find a device
- */
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
-
-static inline void pm_access(struct pm_dev *dev) {}
-static inline void pm_dev_idle(struct pm_dev *dev) {}
+int __deprecated pm_send_all(pm_request_t rqst, void *data);
 
 #else /* CONFIG_PM */
 
@@ -176,16 +150,10 @@
 	return 0;
 }
 
-static inline struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
-{
-	return 0;
-}
-
-static inline void pm_access(struct pm_dev *dev) {}
-static inline void pm_dev_idle(struct pm_dev *dev) {}
-
 #endif /* CONFIG_PM */
 
+/* Functions above this comment are list-based old-style power
+ * managment. Please avoid using them.  */
 
 /*
  * Callbacks for platform drivers to implement.
@@ -193,34 +161,32 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-enum {
-	PM_SUSPEND_ON = 0,
-	PM_SUSPEND_STANDBY = 1,
-	/* NOTE: PM_SUSPEND_MEM == PCI_D3hot */
-	PM_SUSPEND_MEM = 3,
-	PM_SUSPEND_DISK = 4,
-	PM_SUSPEND_MAX = 5,
-};
-
-enum {
-	PM_DISK_FIRMWARE = 1,
-	PM_DISK_PLATFORM,
-	PM_DISK_SHUTDOWN,
-	PM_DISK_REBOOT,
-	PM_DISK_MAX,
-};
+typedef int __bitwise suspend_state_t;
 
+#define PM_SUSPEND_ON		((__force suspend_state_t) 0)
+#define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
+#define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
+#define PM_SUSPEND_DISK		((__force suspend_state_t) 4)
+#define PM_SUSPEND_MAX		((__force suspend_state_t) 5)
+
+typedef int __bitwise suspend_disk_method_t;
+
+#define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
+#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
+#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
+#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
 
 struct pm_ops {
-	u32	pm_disk_mode;
-	int (*prepare)(u32 state);
-	int (*enter)(u32 state);
-	int (*finish)(u32 state);
+	suspend_disk_method_t pm_disk_mode;
+	int (*prepare)(suspend_state_t state);
+	int (*enter)(suspend_state_t state);
+	int (*finish)(suspend_state_t state);
 };
 
 extern void pm_set_ops(struct pm_ops *);
 
-extern int pm_suspend(u32 state);
+extern int pm_suspend(suspend_state_t state);
 
 
 /*
@@ -229,10 +195,34 @@
 
 struct device;
 
+typedef u32 __bitwise pm_message_t;
+
+/*
+ * There are 4 important states driver can be in:
+ * ON     -- driver is working
+ * FREEZE -- stop operations and apply whatever policy is applicable to a suspended driver
+ *           of that class, freeze queues for block like IDE does, drop packets for
+ *           ethernet, etc... stop DMA engine too etc... so a consistent image can be
+ *           saved; but do not power any hardware down.
+ * SUSPEND - like FREEZE, but hardware is doing as much powersaving as possible. Roughly
+ *           pci D3.
+ *
+ * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3 (SUSPEND).
+ * We'll need to fix the drivers. So yes, putting 3 to all diferent defines is intentional,
+ * and will go away as soon as drivers are fixed. Also note that typedef is neccessary,
+ * we'll probably want to switch to
+ *   typedef struct pm_message_t { int event; int flags; } pm_message_t
+ * or something similar soon.
+ */
+
+#define PMSG_FREEZE	((__force pm_message_t) 3)
+#define PMSG_SUSPEND	((__force pm_message_t) 3)
+#define PMSG_ON		((__force pm_message_t) 0)
+
 struct dev_pm_info {
-	u32			power_state;
+	pm_message_t			power_state;
 #ifdef	CONFIG_PM
-	u32			prev_state;
+	pm_message_t			prev_state;
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
@@ -242,8 +232,8 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
+extern int device_suspend(pm_message_t state);
+extern int device_power_down(pm_message_t state);
 extern void device_power_up(void);
 extern void device_resume(void);
 
--- clean/include/linux/sched.h	2004-10-19 14:16:29.000000000 +0200
+++ linux/include/linux/sched.h	2004-12-01 13:51:30.000000000 +0100
@@ -1027,6 +1027,34 @@
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
 
+/* try_to_freeze
+ *
+ * Checks whether we need to enter the refrigerator
+ * and returns 1 if we did so.
+ */
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+static inline int try_to_freeze(unsigned long refrigerator_flags)
+{
+	if (unlikely(current->flags & PF_FREEZE)) {
+		refrigerator(refrigerator_flags);
+		return 1;
+	} else
+		return 0;
+}
+#else
+static inline void refrigerator(unsigned long flag) {}
+static inline int freeze_processes(void) { BUG(); }
+static inline void thaw_processes(void) {}
+
+static inline int try_to_freeze(unsigned long refrigerator_flags)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
--- clean/include/linux/suspend.h	2004-10-01 00:30:31.000000000 +0200
+++ linux/include/linux/suspend.h	2004-12-01 13:52:10.000000000 +0100
@@ -31,30 +31,21 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 
-#else	/* CONFIG_SOFTWARE_SUSPEND */
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+
+#else
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
-#endif	/* CONFIG_SOFTWARE_SUSPEND */
-
-
-#ifdef CONFIG_PM
-extern void refrigerator(unsigned long);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
-
-#else
-static inline void refrigerator(unsigned long flag) {}
-#endif	/* CONFIG_PM */
+#endif
 
 #ifdef CONFIG_SMP
 extern void disable_nonboot_cpus(void);
--- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/disk.c	2004-11-16 13:14:09.000000000 +0100
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
+ * Copyright (c) 2004 Pavel Machek <pavel@suse.cz>
  *
  * This file is released under the GPLv2.
  *
@@ -15,10 +16,11 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/device.h>
 #include "power.h"
 
 
-extern u32 pm_disk_mode;
+extern suspend_disk_method_t pm_disk_mode;
 extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
@@ -41,7 +43,7 @@
  *	there ain't no turning back.
  */
 
-static int power_down(u32 mode)
+static void power_down(suspend_disk_method_t mode)
 {
 	unsigned long flags;
 	int error = 0;
@@ -49,7 +51,7 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		device_power_down(PM_SUSPEND_DISK);
+ 		device_power_down(PMSG_SUSPEND);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
@@ -67,7 +69,6 @@
 	   after resume. */
 	printk(KERN_CRIT "Please power me down manually\n");
 	while(1);
-	return 0;
 }
 
 
@@ -85,13 +86,26 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	int i;
+	for (i=0; i<5; i++) {
+		int i = 0, tmp;
+		long pages = 0;
+		char *p = "-\\|/";
+
+		printk("Freeing memory...  ");
+		while ((tmp = shrink_all_memory(10000))) {
+			pages += tmp;
+			printk("\b%c", p[i]);
+			i++;
+			if (i > 3)
+				i = 0;
+		}
+		printk("\bdone (%li pages freed)\n", pages);
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ/5);
+	}
 }
 
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -133,8 +147,10 @@
 	free_some_memory();
 
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PM_SUSPEND_DISK)))
+	if ((error = device_suspend(PMSG_FREEZE))) {
+		printk("Some devices failed to suspend\n");
 		goto Finish;
+	}
 
 	return 0;
  Finish:
@@ -152,7 +168,7 @@
  *
  *	If we're going through the firmware, then get it over with quickly.
  *
- *	If not, then call pmdis to do it's thing, then figure out how
+ *	If not, then call swsusp to do its thing, then figure out how
  *	to power down the system.
  */
 
@@ -174,18 +190,9 @@
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
-
-		/*
-		 * FIXME: Leftover from swsusp. Are they necessary?
-		 */
-		mb();
-		barrier();
-
 		error = swsusp_write();
-		if (!error) {
-			error = power_down(pm_disk_mode);
-			pr_debug("PM: Power down failed.\n");
-		}
+		if (!error)
+			power_down(pm_disk_mode);
 	} else
 		pr_debug("PM: Image restored successfully.\n");
 	swsusp_free();
@@ -282,7 +289,7 @@
 
 static ssize_t disk_show(struct subsystem * subsys, char * buf)
 {
-	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
+	return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
 }
 
 
@@ -292,7 +299,7 @@
 	int i;
 	int len;
 	char *p;
-	u32 mode = 0;
+	suspend_disk_method_t mode = 0;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
--- clean/kernel/power/main.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/main.c	2004-11-23 22:59:11.000000000 +0100
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
@@ -22,7 +22,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops * pm_ops = NULL;
-u32 pm_disk_mode = PM_DISK_SHUTDOWN;
+suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -46,7 +46,7 @@
  *	the platform can enter the requested state.
  */
 
-static int suspend_prepare(u32 state)
+static int suspend_prepare(suspend_state_t state)
 {
 	int error = 0;
 
@@ -65,7 +65,7 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(state)))
+	if ((error = device_suspend(PMSG_SUSPEND)))
 		goto Finish;
 	return 0;
  Finish:
@@ -78,13 +78,14 @@
 }
 
 
-static int suspend_enter(u32 state)
+static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if ((error = device_power_down(state)))
+
+	if ((error = device_power_down(PMSG_SUSPEND)))
 		goto Done;
 	error = pm_ops->enter(state);
 	device_power_up();
@@ -99,10 +100,10 @@
  *	@state:		State we're coming out of.
  *
  *	Call platform code to clean up, restart processes, and free the 
- *	console that we've allocated.
+ *	console that we've allocated. This is not called for suspend-to-disk.
  */
 
-static void suspend_finish(u32 state)
+static void suspend_finish(suspend_state_t state)
 {
 	device_resume();
 	if (pm_ops && pm_ops->finish)
@@ -133,7 +134,7 @@
  *	we've woken up).
  */
 
-static int enter_state(u32 state)
+static int enter_state(suspend_state_t state)
 {
 	int error;
 
@@ -183,7 +184,7 @@
  *	structure, and enter (above).
  */
 
-int pm_suspend(u32 state)
+int pm_suspend(suspend_state_t state)
 {
 	if (state > PM_SUSPEND_ON && state < PM_SUSPEND_MAX)
 		return enter_state(state);
@@ -221,7 +222,7 @@
 
 static ssize_t state_store(struct subsystem * subsys, const char * buf, size_t n)
 {
-	u32 state = PM_SUSPEND_STANDBY;
+	suspend_state_t state = PM_SUSPEND_STANDBY;
 	char ** s;
 	char *p;
 	int error;
@@ -230,8 +231,8 @@
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
-		if (*s && !strncmp(buf, *s, len))
+	for (s = &pm_states[state]; *s; s++, state++) {
+		if (!strncmp(buf, *s, len))
 			break;
 	}
 	if (*s)
--- clean/kernel/power/pm.c	2004-08-15 19:15:06.000000000 +0200
+++ linux/kernel/power/pm.c	2004-10-25 23:02:25.000000000 +0200
@@ -256,41 +256,10 @@
 	return 0;
 }
 
-/**
- *	pm_find  - find a device
- *	@type: type of device
- *	@from: where to start looking
- *
- *	Scan the power management list for devices of a specific type. The
- *	return value for a matching device may be passed to further calls
- *	to this function to find further matches. A %NULL indicates the end
- *	of the list. 
- *
- *	To search from the beginning pass %NULL as the @from value.
- *
- *	The caller MUST hold the pm_devs_lock lock when calling this 
- *	function. The instant that the lock is dropped all pointers returned
- *	may become invalid.
- */
- 
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
-{
-	struct list_head *entry = from ? from->entry.next:pm_devs.next;
-	while (entry != &pm_devs) {
-		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
-		if (type == PM_UNKNOWN_DEV || dev->type == type)
-			return dev;
-		entry = entry->next;
-	}
-	return NULL;
-}
-
 EXPORT_SYMBOL(pm_register);
 EXPORT_SYMBOL(pm_unregister);
 EXPORT_SYMBOL(pm_unregister_all);
-EXPORT_SYMBOL(pm_send);
 EXPORT_SYMBOL(pm_send_all);
-EXPORT_SYMBOL(pm_find);
 EXPORT_SYMBOL(pm_active);
 
 
--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-11-25 12:27:35.000000000 +0100
@@ -74,11 +74,8 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-extern int is_head_of_free_region(struct page *);
-
 /* Variables to be preserved over suspend */
-int pagedir_order_check;
-int nr_copy_pages_check;
+static int pagedir_order_check;
 
 extern char resume_file[];
 static dev_t resume_device;
@@ -294,15 +291,19 @@
 {
 	int error = 0;
 	int i;
+	unsigned int mod = nr_copy_pages / 100;
+
+	if (!mod)
+		mod = 1;
 
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk(" %d Pages done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -422,12 +423,12 @@
 static int save_highmem_zone(struct zone *zone)
 {
 	unsigned long zone_pfn;
+	mark_free_pages(zone);
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
 		struct highmem_page *save;
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		int chunk_size;
 
 		if (!(pfn%1000))
 			printk(".");
@@ -444,11 +445,9 @@
 			printk("highmem reserved page?!\n");
 			continue;
 		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
 			continue;
-		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
 			return -ENOMEM;
@@ -520,21 +519,16 @@
  *	We save a page if it's Reserved, and not in the range of pages
  *	statically defined as 'unsaveable', or if it isn't reserved, and
  *	isn't part of a free chunk of pages.
- *	If it is part of a free chunk, we update @pfn to point to the last 
- *	page of the chunk.
  */
 
 static int saveable(struct zone * zone, unsigned long * zone_pfn)
 {
 	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	unsigned long chunk_size;
 	struct page * page;
 
 	if (!pfn_valid(pfn))
 		return 0;
 
-	if (!(pfn%1000))
-		printk(".");
 	page = pfn_to_page(pfn);
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
@@ -543,10 +537,8 @@
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
-	if ((chunk_size = is_head_of_free_region(page))) {
-		*zone_pfn += chunk_size - 1;
+	if (PageNosaveFree(page))
 		return 0;
-	}
 
 	return 1;
 }
@@ -559,10 +551,11 @@
 	nr_copy_pages = 0;
 
 	for_each_zone(zone) {
-		if (!is_highmem(zone)) {
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-				nr_copy_pages += saveable(zone, &zone_pfn);
-		}
+		if (is_highmem(zone))
+			continue;
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			nr_copy_pages += saveable(zone, &zone_pfn);
 	}
 }
 
@@ -572,52 +565,26 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
+	int pages_copied = 0;
 	
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-				if (saveable(zone, &zone_pfn)) {
-					struct page * page;
-					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
-					pbe->orig_address = (long) page_address(page);
-					/* copy_page is no usable for copying task structs. */
-					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-					pbe++;
-				}
-			}
-	}
-}
-
-
-static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
-{
-	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
-	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
-	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
-		else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
+		if (is_highmem(zone))
 			continue;
-		__free_page(page);
-	}
-}
-
-void swsusp_free(void)
-{
-	unsigned long p = (unsigned long)pagedir_save;
-	struct zone *zone;
-	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			free_suspend_pagedir_zone(zone, p);
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			if (saveable(zone, &zone_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				pbe->orig_address = (long) page_address(page);
+				/* copy_page is not usable for copying task structs. */
+				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				pbe++;
+				pages_copied++;
+			}
+		}
 	}
-	free_pages(p, pagedir_order);
+	BUG_ON(pages_copied > nr_copy_pages);
+	nr_copy_pages = pages_copied;
 }
 
 
@@ -683,6 +650,24 @@
 	return 0;
 }
 
+/**
+ *	free_image_pages - Free pages allocated for snapshot
+ */
+
+static void free_image_pages(void)
+{
+	struct pbe * p;
+	int i;
+
+	p = pagedir_save;
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+		if (p->address) {
+			ClearPageNosave(virt_to_page(p->address));
+			free_page(p->address);
+			p->address = 0;
+		}
+	}
+}
 
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
@@ -696,18 +681,19 @@
 
 	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address)
-			goto Error;
+		if (!p->address)
+			return -ENOMEM;
 		SetPageNosave(virt_to_page(p->address));
 	}
 	return 0;
- Error:
-	do { 
-		if (p->address)
-			free_page(p->address);
-		p->address = 0;
-	} while (p-- > pagedir_save);
-	return -ENOMEM;
+}
+
+void swsusp_free(void)
+{
+	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
+	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
+	free_image_pages();
+	free_pages((unsigned long) pagedir_save, pagedir_order);
 }
 
 
@@ -766,28 +752,28 @@
 		return -ENOSPC;
 
 	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
+		printk("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
 	if ((error = alloc_image_pages())) {
-		pr_debug("suspend: Allocating image pages failed.\n");
+		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
 
-	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
 int suspend_prepare_image(void)
 {
-	unsigned int nr_needed_pages = 0;
+	unsigned int nr_needed_pages;
 	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
 		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		restore_highmem();
 		return -ENOMEM;
 	}
 
@@ -854,11 +840,13 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	device_power_down(PMSG_FREEZE);
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
@@ -866,11 +854,11 @@
 
 asmlinkage int swsusp_restore(void)
 {
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
+	wbinvd();	/* Nigel says wbinvd here is good idea... */
 	return 0;
 }
 
@@ -878,6 +866,7 @@
 {
 	int error;
 	local_irq_disable();
+	device_power_down(PMSG_FREEZE);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -887,6 +876,7 @@
 	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
@@ -978,6 +968,8 @@
 		c = *c;
 		free_pages((unsigned long)f, pagedir_order);
 	}
+	if (ret)
+		return ret;
 	printk("|\n");
 	return check_pagedir();
 }
@@ -993,24 +985,14 @@
 
 static atomic_t io_done = ATOMIC_INIT(0);
 
-static void start_io(void)
-{
-	atomic_set(&io_done,1);
-}
-
 static int end_io(struct bio * bio, unsigned int num, int err)
 {
-	atomic_set(&io_done,0);
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
+		panic("I/O error reading memory image");
+	atomic_set(&io_done, 0);
 	return 0;
 }
 
-static void wait_io(void)
-{
-	while(atomic_read(&io_done))
-		io_schedule();
-}
-
-
 static struct block_device * resume_bdev;
 
 /**
@@ -1045,9 +1027,12 @@
 
 	if (rw == WRITE)
 		bio_set_pages_dirty(bio);
-	start_io();
+
+	atomic_set(&io_done, 1);
 	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	wait_io();
+	while (atomic_read(&io_done))
+		yield();
+
  Done:
 	bio_put(bio);
 	return error;
@@ -1103,6 +1088,7 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1121,7 +1107,7 @@
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		pr_debug(KERN_ERR "swsusp: Invalid partition type.\n");
+		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)
@@ -1141,14 +1127,18 @@
 	struct pbe * p;
 	int error;
 	int i;
+	int mod = nr_copy_pages / 100;
+
+	if (!mod)
+		mod = 1;
 
 	if ((error = swsusp_pagedir_relocate()))
 		return error;
 
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages):     ", nr_copy_pages );
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}
@@ -1165,9 +1155,7 @@
 	int i, n = swsusp_info.pagedir_pages;
 	int error = 0;
 
-	pagedir_order = get_bitmask_order(n);
-
-	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
+	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
 	if (!addr)
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
--- clean/kernel/signal.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/signal.c	2004-10-29 11:56:46.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/suspend.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -1483,8 +1484,7 @@
 	unsigned long flags;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
+	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
  	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));
@@ -2260,6 +2260,8 @@
 			ret = -EINTR;
 	}
 
+	if (current->flags & PF_FREEZE)
+		refrigerator(1);
 	return ret;
 }
 
--- clean/kernel/sys.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/sys.c	2004-11-14 23:36:46.000000000 +0100
@@ -471,6 +471,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -481,6 +482,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -497,6 +499,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
--- clean/mm/page_alloc.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/mm/page_alloc.c	2004-10-29 11:56:47.000000000 +0200
@@ -434,26 +434,30 @@
 #endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM
-int is_head_of_free_region(struct page *page)
+
+void mark_free_pages(struct zone *zone)
 {
-        struct zone *zone = page_zone(page);
-        unsigned long flags;
+	unsigned long zone_pfn, flags;
 	int order;
 	struct list_head *curr;
 
-	/*
-	 * Should not matter as we need quiescent system for
-	 * suspend anyway, but...
-	 */
+	if (!zone->spanned_pages)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
+
 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
-			if (page == list_entry(curr, struct page, lru)) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return 1 << order;
-			}
+		list_for_each(curr, &zone->free_area[order].free_list) {
+			unsigned long start_pfn, i;
+
+			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
+
+			for (i=0; i < (1<<order); i++)
+				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-        return 0;
 }
 
 /*
@@ -1568,7 +1572,7 @@
 		zone->zone_start_pfn = zone_start_pfn;
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
+			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
 
 		memmap_init(size, nid, j, zone_start_pfn);
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
