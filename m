Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312853AbSDHKZX>; Mon, 8 Apr 2002 06:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDHKZW>; Mon, 8 Apr 2002 06:25:22 -0400
Received: from [195.39.17.254] ([195.39.17.254]:44938 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312853AbSDHKZV>;
	Mon, 8 Apr 2002 06:25:21 -0400
Date: Mon, 8 Apr 2002 12:25:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work
Message-ID: <20020408102508.GA2494@elf.ucw.cz>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz> <1018254348.571.129.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It tries killing init on resume for me and panics.  the actual suspend
> worked though (apparently).  I attached the ksymoops output to the
> panic.

You need my previous patch too. Here are both, combined.

								Pavel

--- linux-ac.clean/Documentation/swsusp.txt	Tue Jan 29 12:16:13 2002
+++ linux-swsusp.24/Documentation/swsusp.txt	Sun Apr  7 11:42:03 2002
@@ -0,0 +1,168 @@
+From kernel/suspend.c:
+
+ * BIG FAT WARNING *********************************************************
+ *
+ * If you have unsupported (*) devices using DMA...
+ *				...say goodbye to your data.
+ *
+ * If you touch anything on disk between suspend and resume...
+ *				...kiss your data goodbye.
+ *
+ * If your disk driver does not support suspend... (IDE does)
+ *				...you'd better find out how to get along
+ *				   without your data.
+ *
+ * (*) pm interface support is needed to make it safe.
+
+You need to append resume=/dev/your_swap_partition to kernel command
+line. Then you suspend by echo 4 > /proc/acpi/sleep.
+
+[Notice. Rest docs is pretty outdated (see date!) It should be safe to
+use swsusp on ext3/reiserfs these days.]
+
+
+Article about goals and implementation of Software Suspend for Linux
+Author: Gábor Kuti
+Last revised: Jan 23rd, 2000
+
+Idea and goals to achieve
+
+Nowadays it is common in several laptops that they have a suspend button. It
+saves the state of the machine to a filesystem or to a partition and switches
+to standby mode. Later resuming the machine the saved state is loaded back to
+ram and the machine can continue its work. It has two real benefits. First we
+save ourselves the time machine goes down and later boots up, energy costs
+real high when running from batteries. The other gain is that we don't have to
+interrupt our programs so processes that are calculating something for a long
+time shouldn't need to be written interruptible.
+
+On desk machines the power saving function isn't as important as it is in
+laptops but we really may benefit from the second one. Nowadays the number of
+desk machines supporting suspend function in their APM is going up but there
+are (and there will still be for a long time) machines that don't even support
+APM of any kind. On the other hand it is reported that using APM's suspend
+some irqs (e.g. ATA disk irq) is lost and it is annoying for the user until
+the Linux kernel resets the device.
+
+So I started thinking about implementing Software Suspend which doesn't need
+any APM support and - since it uses pretty near only high-level routines - is
+supposed to be architecture independent code.
+
+Using the code
+
+The code is experimental right now - testers, extra eyes are welcome. To
+compile this support into the kernel, you need CONFIG_EXPERIMENTAL, 
+and then CONFIG_SOFTWARE_SUSPEND in menu General Setup to be  enabled. It
+cannot be used as a module and I don't think it will ever be needed.
+
+You have two ways to use this code. The first one is if you've compiled in
+sysrq support then you may press Sysrq-D to request suspend. The other way
+is with a patched SysVinit (my patch is against 2.76 and available at my
+home page). You might call 'swsusp' or 'shutdown -z <time>'.
+
+Either way it saves the state of the machine into active swaps and then
+reboots. By the next booting the kernel's resuming function is either triggered
+by swapon -a (which is ought to be in the very early stage of booting) or you
+may explicitly specify the swap partition/file to resume from with ``resume=''
+kernel option. If signature is found it loads and restores saved state. If the
+option ``noresume'' is specified as a boot parameter, it skips the resuming.
+Warning! Look at section ``Things to implement'' to see what isn't yet
+implemented.  Also I strongly suggest you to list all active swaps in
+/etc/fstab. Firstly because you don't have to specify anything to resume and
+secondly if you have more than one swap area you can't decide which one has the
+'root' signature. Also, it doesn't yet support ``embedded'' swapfiles, e.g. you
+have a dos partition mounted on /dos and also have a /dos/swapfile named
+swapfile..  I plan to add support to mount all necessary filesystems readonly.
+
+In the meantime while the system is suspended you should not touch any of the
+hardware!
+
+About the code
+Goals reached
+
+The code can be downloaded from
+http://falcon.sch.bme.hu/~seasons/linux/. It mainly works but there are still
+some of XXXs, TODOs, FIXMEs in the code which seem not to be too important. It
+should work all right except for the problems listed in ``Things to
+implement''. Notes about the code are really welcome.
+
+How the code works
+
+When suspending is triggered it immediately wakes up process bdflush. Bdflush
+checks whether we have anything in our run queue tq_bdflush. Since we queued up
+function do_software_suspend, it is called. Here we shrink everything including
+dcache, inodes, buffers and memory (here mainly processes are swapped out). We
+count how many pages we need to duplicate (we have to be atomical!) then we
+create an appropiate sized page directory. It will point to the original and
+the new (copied) address of the page. We get the free pages by
+__get_free_pages() but since it changes state we have to be able to track it
+later so it also flips in a bit in page's flags (a new Nosave flag). We
+duplicate pages and then mark them as used (so atomicity is ensured). After
+this we write out the image to swaps, do another sync and the machine may
+reboot. We also save registers to stack.
+
+By resuming an ``inverse'' method is executed. The image if exists is loaded,
+loadling is either triggered by ``swapon -a'' or ``resume='' kernel option.  We
+change our task to bdflush (it is needed because if we don't do this init does
+an oops when it is waken up later) and then pages are copied back to their
+original location. We restore registers, free previously allocated memory,
+activate memory context and task information. Here we should restore hardware
+state but even without this the machine is restored and processes are continued
+to work. I think hardware state should be restored by some list (using
+notify_chain) and probably by some userland program (run-parts?) for users'
+pleasure. Check out my patch at the same location for the sysvinit patch.
+
+WARNINGS!
+- Using swsusp on logging fs (e.g.reiserfs) could lead to pretty bad things:
+  mounting of reiserfs (even readonly!) means log is replayed, which 
+  means writes to filesystem. That could lead to pretty bad corruption.
+- It does not like pcmcia cards. And this is logical: pcmcia cards need cardmgr to be
+  initialized. they are not initialized during singleuser boot, but "resumed" kernel does
+  expect them to be initialized. That leads to armagedon. You should eject any pcmcia cards
+  before suspending.
+
+Things to implement
+- SMP support. I've done an SMP support but since I don't have access to a kind
+  of this one I cannot test it. Please SMP people test it.  .. Tested it,
+  doesn't work. Had no time to figure out why. There is some mess with
+  interrupts AFAIK..
+- We should only make a copy of data related to kernel segment, since any
+  process data won't be changed.
+- Should \#define ADDRESS go into linux/mm.h?
+- By copying pages back to their original position, copy_page caused General
+  Protection Fault. Why?
+- Hardware state restoring.  Now there's support for notifying via the notify
+  chain, event handlers are welcome. Some devices may have microcodes loaded
+  into them. We should have event handlers for them aswell.
+- We should support other architectures (There are really only some arch
+  related functions..)
+- We should also restore original state of swaps if the ``noresume'' kernel
+  option is specified.. Or do we need such a feature to save state for some
+  other time? Do we need some kind of ``several saved states''?  (Linux-HA
+  people?). There's been some discussion about checkpointing on linux-future.
+- Should make more sanity checks. Or are these enough?
+
+Not so important ideas for implementing
+
+- Should SIGSTOP_SUSPEND called SIGFREEZE? Or is it some kind of stealing
+  for Solaris?
+- If a real time process is running then don't suspend the machine.
+- Is there any sense in compressing the outwritten pages?
+- Support for power.conf file as in Solaris, autoshutdown, special
+  devicetypes support, maybe in sysctl.
+- Introduce timeout for SMP locking. But first locking ought to work :O
+- Pre-detect if we don't have enough swap space or free it instead of
+  calling panic.
+- Support for adding/removing hardware while suspended?
+- We should not free pages at the beginning so aggressively, most of them
+  go there anyway..
+- If X is active while suspending then by resuming calling svgatextmode
+  corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
+
+Any other idea you might have tell me!
+
+Contacting the author
+If you have any question or any patch that solves the above or detected
+problems please contact me at seasons@falcon.sch.bme.hu. I might delay
+answering, sorry about that.
+
--- linux-ac.clean/drivers/ide/ide-disk.c	Sun Apr  7 10:55:09 2002
+++ linux-swsusp.24/drivers/ide/ide-disk.c	Mon Apr  8 01:22:06 2002
@@ -1567,7 +1567,7 @@
 		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
 
 		if (!hwgroup) continue;
-		hwgroup->handler = hwgroup->handler_save;
+		hwgroup->handler = NULL; /* hwgroup->handler_save; */
 		hwgroup->handler_save = NULL;
 	}
 	driver_blocked = 0;
@@ -1584,6 +1584,7 @@
 		if (hwgroup->handler != panic_box)
 			panic("Handler was not set to panic?");
 		hwgroup->handler_save = NULL;
+		hwgroup->handler = NULL;
 	}
 	driver_blocked = 0;
 }
--- linux-ac.clean/include/linux/mm.h	Sun Apr  7 10:55:12 2002
+++ linux-swsusp.24/include/linux/mm.h	Mon Apr  8 01:04:06 2002
@@ -303,7 +303,9 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
-#define PG_nosave		29
+#define PG_nosave		16
+/* Don't you dare to use high bits, they seem to be used for something else! */
+
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
--- linux-ac.clean/init/main.c	Sun Apr  7 10:55:13 2002
+++ linux-swsusp.24/init/main.c	Sun Apr  7 11:54:39 2002
@@ -522,15 +522,15 @@
 	tc_init();
 #endif
 
-	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
-	   log corrupting stuff */
-	software_resume();
-
 	/* Networking initialization needs a process context */ 
 	sock_init();
 
 	start_context_thread();
 	do_initcalls();
+
+	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
+	   log corrupting stuff */
+	software_resume();
 
 #ifdef CONFIG_IRDA
 	irda_proto_init();
--- linux-ac.clean/kernel/suspend.c	Sun Apr  7 10:55:13 2002
+++ linux-swsusp.24/kernel/suspend.c	Mon Apr  8 00:51:02 2002
@@ -32,20 +32,6 @@
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/swsusp.txt
- *
- * BIG FAT WARNING *********************************************************
- *
- * If you have unsupported (*) devices using DMA...
- *				...say goodbye to your data.
- *
- * If you touch anything on disk between suspend and resume...
- *				...kiss your data goodbye.
- *
- * If your disk driver does not support suspend... (IDE does)
- *				...you'd better find out how to get along
- *				   without your data.
- *
- * (*) pm interface support is needed to make it safe.
  */
 
 /*



-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
