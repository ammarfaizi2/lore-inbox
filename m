Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUABXHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUABXHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:07:34 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:9102 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265690AbUABXHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:07:22 -0500
Date: Fri, 2 Jan 2004 23:43:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>, Patrick Mochel <mochel@osdl.org>
Subject: Trivial swsusp/sleep fixes
Message-ID: <20040102224334.GA446@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills outdated docs, and adds some helpfull docs about video
issues with suspend. Please apply,

								Pavel

PS: Patrick, are you there? I have not heard from you for pretty
long...

%patch
Index: linux.new/Documentation/power/swsusp.txt
===================================================================
--- linux.new.orig/Documentation/power/swsusp.txt	2003-12-25 13:28:50.000000000 +0100
+++ linux.new/Documentation/power/swsusp.txt	2003-12-25 13:29:06.000000000 +0100
@@ -17,13 +17,30 @@
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
 
-[Notice. Rest docs is pretty outdated (see date!) It should be safe to
-use swsusp on ext3/reiserfs these days.]
+Pavel's unreliable guide to swsusp mess
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
+
+There are currently two versions of swap suspend in the kernel, the old
+"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
+version in kernel/power/pmdisk.c. They provide the same functionality;
+the old version looks ugly but was tested, while the new version looks
+nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
+calls the old version, echo disk > /sys/power/state calls the new one.
+
+[In the future, when the new version is stable enough, two things can
+happen:
+
+* the new version is moved into swsusp.c, and swsusp is renamed to swap
+  suspend (Pavel prefers this)
+
+* pmdisk is kept as is and swsusp.c is removed from the kernel]
+
 
 
 Article about goals and implementation of Software Suspend for Linux
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Author: G‚ábor Kuti
-Last revised: 2002-04-08
+Last revised: 2003-10-20 by Pavel Machek
 
 Idea and goals to achieve
 
@@ -36,84 +53,23 @@
 interrupt our programs so processes that are calculating something for a long
 time shouldn't need to be written interruptible.
 
-On desk machines the power saving function isn't as important as it is in
-laptops but we really may benefit from the second one. Nowadays the number of
-desk machines supporting suspend function in their APM is going up but there
-are (and there will still be for a long time) machines that don't even support
-APM of any kind. On the other hand it is reported that using APM's suspend
-some irqs (e.g. ATA disk irq) is lost and it is annoying for the user until
-the Linux kernel resets the device.
-
-So I started thinking about implementing Software Suspend which doesn't need
-any APM support and - since it uses pretty near only high-level routines - is
-supposed to be architecture independent code.
-
 Using the code
 
-The code is experimental right now - testers, extra eyes are welcome. To
-compile this support into the kernel, you need CONFIG_EXPERIMENTAL, 
-and then CONFIG_SOFTWARE_SUSPEND in menu General Setup to be  enabled. It
-cannot be used as a module and I don't think it will ever be needed.
-
-You have two ways to use this code. The first one is if you've compiled in
-sysrq support then you may press Sysrq-D to request suspend. The other way
-is with a patched SysVinit (my patch is against 2.76 and available at my
-home page). You might call 'swsusp' or 'shutdown -z <time>'. Next way is to
-echo 4 > /proc/acpi/sleep.
+You have two ways to use this code. The first one is is with a patched
+SysVinit (my patch is against 2.76 and available at my home page). You
+might call 'swsusp' or 'shutdown -z <time>'. Next way is to echo 4 >
+/proc/acpi/sleep.
 
 Either way it saves the state of the machine into active swaps and then
 reboots.  You must explicitly specify the swap partition to resume from with
 ``resume='' kernel option. If signature is found it loads and restores saved
 state. If the option ``noresume'' is specified as a boot parameter, it skips
-the resuming.  Warning! Look at section ``Things to implement'' to see what
-isn't yet implemented.  Also I strongly suggest you to list all active swaps
-in /etc/fstab. Firstly because you don't have to specify anything to resume
-and secondly if you have more than one swap area you can't decide which one
-has the 'root' signature. 
+the resuming.
 
 In the meantime while the system is suspended you should not touch any of the
 hardware!
 
 About the code
-Goals reached
-
-The code can be downloaded from
-http://falcon.sch.bme.hu/~seasons/linux/. It mainly works but there are still
-some of XXXs, TODOs, FIXMEs in the code which seem not to be too important. It
-should work all right except for the problems listed in ``Things to
-implement''. Notes about the code are really welcome.
-
-How the code works
-
-When suspending is triggered it immediately wakes up process bdflush. Bdflush
-checks whether we have anything in our run queue tq_bdflush. Since we queued up
-function do_software_suspend, it is called. Here we shrink everything including
-dcache, inodes, buffers and memory (here mainly processes are swapped out). We
-count how many pages we need to duplicate (we have to be atomical!) then we
-create an appropriate sized page directory. It will point to the original and
-the new (copied) address of the page. We get the free pages by
-__get_free_pages() but since it changes state we have to be able to track it
-later so it also flips in a bit in page's flags (a new Nosave flag). We
-duplicate pages and then mark them as used (so atomicity is ensured). After
-this we write out the image to swaps, do another sync and the machine may
-reboot. We also save registers to stack.
-
-By resuming an ``inverse'' method is executed. The image if exists is loaded,
-loadling is either triggered by ``resume='' kernel option.  We
-change our task to bdflush (it is needed because if we don't do this init does
-an oops when it is waken up later) and then pages are copied back to their
-original location. We restore registers, free previously allocated memory,
-activate memory context and task information. Here we should restore hardware
-state but even without this the machine is restored and processes are continued
-to work. I think hardware state should be restored by some list (using
-notify_chain) and probably by some userland program (run-parts?) for users'
-pleasure. Check out my patch at the same location for the sysvinit patch.
-
-WARNINGS!
-- It does not like pcmcia cards. And this is logical: pcmcia cards need
-  cardmgr to be initialized. they are not initialized during singleuser boot,
-  but "resumed" kernel does expect them to be initialized. That leads to
-  armagedon. You should eject any pcmcia cards before suspending.
 
 Things to implement
 - SMP support. I've done an SMP support but since I don't have access to a kind
@@ -122,34 +78,14 @@
   interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since any
   process data won't be changed.
-- Hardware state restoring.  Now there's support for notifying via the notify
-  chain, event handlers are welcome. Some devices may have microcodes loaded
-  into them. We should have event handlers for them as well.
-- We should support other architectures (There are really only some arch
-  related functions..)
-- We should also restore original state of swaps if the ``noresume'' kernel
-  option is specified.. Or do we need such a feature to save state for some
-  other time? Do we need some kind of ``several saved states''?  (Linux-HA
-  people?). There's been some discussion about checkpointing on linux-future.
 - Should make more sanity checks. Or are these enough?
 
 Not so important ideas for implementing
 
 - If a real time process is running then don't suspend the machine.
-- Support for power.conf file as in Solaris, autoshutdown, special
-  devicetypes support, maybe in sysctl.
-- Introduce timeout for SMP locking. But first locking ought to work :O
-- Pre-detect if we don't have enough swap space or free it instead of
-  calling panic.
 - Support for adding/removing hardware while suspended?
 - We should not free pages at the beginning so aggressively, most of them
   go there anyway..
-- If X is active while suspending then by resuming calling svgatextmode
-  corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
-
-Drivers we support
-- IDE disks are okay
-- vesafb
 
 Drivers that need support
 - pc_keyb -- perhaps we can wait for vojtech's input patches
Index: linux.new/Documentation/power/video.txt
===================================================================
--- linux.new.orig/Documentation/power/video.txt	2003-12-25 13:29:06.000000000 +0100
+++ linux.new/Documentation/power/video.txt	2003-12-25 13:29:06.000000000 +0100
@@ -0,0 +1,36 @@
+
+		Video issues with S3 resume
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		     2003, Pavel Machek
+
+During S3 resume, hardware needs to be reinitialized. For most
+devices, this is easy, and kernel driver knows how to do
+it. Unfortunately there's one exception: video card. Those are usually
+initialized by BIOS, and kernel does not have enough information to
+boot video card. (Kernel usually does not even contain video card
+driver -- vesafb and vgacon are widely used).
+
+This is not problem for swsusp, because during swsusp resume, BIOS is
+run normally so video card is normally initialized.
+
+There are three types of systems where video works after S3 resume:
+
+* systems where video state is preserved over S3. (HP Omnibook xe3)
+
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+
+* systems where it is possible to call video bios during S3
+  resume. Unfortunately, it is not correct to call video BIOS at that
+  point, but it happens to work on some machines. Use
+  acpi_sleep=s3_bios (Athlon64 desktop system)
+
+Now, if you pass acpi_sleep=something, and it does not work with your
+bios, you'll get hard crash during resume. Be carefull.
+
+You may have system where none of above works. At that point you
+either invent another ugly hack that works, or write proper driver for
+your video card (good luck getting docs :-(). Maybe suspending from X
+(proper X, knowing your hardware, not XF68_FBcon) might have better
+chance of working.


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
