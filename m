Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUJDN0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUJDN0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUJDNXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:23:07 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:18048 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267352AbUJDNT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:19:26 -0400
Date: Mon, 4 Oct 2004 14:06:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: Documentation update
Message-ID: <20041004120631.GA25706@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Documentation update, against -rc3. Please apply,
							Pavel

%patch
Index: linux/Documentation/power/swsusp.txt
===================================================================
--- linux.orig/Documentation/power/swsusp.txt	2004-10-01 12:24:26.000000000 +0200
+++ linux/Documentation/power/swsusp.txt	2004-10-01 00:51:36.000000000 +0200
@@ -15,10 +15,18 @@
  * If you change kernel command line between suspend and resume...
  *			        ...prepare for nasty fsck or worse.
  *
- * (*) pm interface support is needed to make it safe.
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
@@ -32,42 +40,24 @@
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
-
-About the code
-
-Things to implement
-- We should only make a copy of data related to kernel segment, since any
-  process data won't be changed.
-- Should make more sanity checks. Or are these enough?
+In the meantime while the system is suspended you should not add/remove any
+of the hardware, write to the filesystems, etc.
 
-Not so important ideas for implementing
+Sleep states summary
+====================
 
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
@@ -79,7 +69,6 @@
 and perhaps
 echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
 
-
 Frequently Asked Questions
 ==========================
 
@@ -123,27 +112,13 @@
 
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
@@ -162,6 +137,8 @@
     return 0;
 }
 
+Also /sys/ interface should be still present.
+
 Q: What is 'suspend2'?
 
 A: suspend2 is 'Software Suspend 2', a forked implementation of
@@ -175,17 +152,22 @@
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
 
Index: linux/Documentation/power/video.txt
===================================================================
--- linux.orig/Documentation/power/video.txt	2004-10-01 12:24:26.000000000 +0200
+++ linux/Documentation/power/video.txt	2004-07-06 11:53:46.000000000 +0200
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


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
