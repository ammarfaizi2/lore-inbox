Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbUKXODr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbUKXODr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKXOCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:02:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28055 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262700AbUKXN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:29:01 -0500
Subject: Suspend 2 merge: 21/51: Refrigerator upgrade.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101296026.5805.275.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the suspend2 version of the process refrigerator. We do things in three steps:

1. Freeze userspace threads (p->mm != NULL) that don't have
PF_SYNCTHREAD. This should stop new I/O being submitted.
2. Let data get synced to disk and run our own sys_sync just in case no
one else was. PF_SYNCTHREAD is given to processes when they begin a
sys_sync (or sibling) and removed when they exit the call, so no sync
operations were hung under step 1. After this we set the DISABLE_SYNCING
flag to stop further syncs.
3. Since kernel threads that don't have PF_NOFREEZE.

Included in this patch is a new try_to_freeze() macro Andrew M suggested
a while back. The refrigerator declarations are put in sched.h to save
extra includes of suspend.h.

Changes to keep swsusp working are included.

Note that you can also thaw just the kernel threads; this allows syncing
while eating memory.

diff -ruN 582-refrigerator-old/arch/arm/kernel/signal.c 582-refrigerator-new/arch/arm/kernel/signal.c
--- 582-refrigerator-old/arch/arm/kernel/signal.c	2004-11-24 09:52:51.000000000 +1100
+++ 582-refrigerator-new/arch/arm/kernel/signal.c	2004-11-24 17:56:06.836085952 +1100
@@ -12,7 +12,6 @@
 #include <linux/signal.h>
 #include <linux/ptrace.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
 
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
@@ -689,10 +688,8 @@
 	if (!user_mode(regs))
 		return 0;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (current->ptrace & PT_SINGLESTEP)
 		ptrace_cancel_bpt(current);
diff -ruN 582-refrigerator-old/arch/i386/kernel/io_apic.c 582-refrigerator-new/arch/i386/kernel/io_apic.c
--- 582-refrigerator-old/arch/i386/kernel/io_apic.c	2004-11-24 18:03:13.053291088 +1100
+++ 582-refrigerator-new/arch/i386/kernel/io_apic.c	2004-11-24 17:56:06.839085496 +1100
@@ -575,6 +575,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
+		try_to_freeze(PF_FREEZE);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			do_irq_balance();
diff -ruN 582-refrigerator-old/arch/i386/kernel/signal.c 582-refrigerator-new/arch/i386/kernel/signal.c
--- 582-refrigerator-old/arch/i386/kernel/signal.c	2004-11-24 18:03:13.109282576 +1100
+++ 582-refrigerator-new/arch/i386/kernel/signal.c	2004-11-24 17:56:06.840085344 +1100
@@ -18,7 +18,6 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <asm/processor.h>
@@ -596,10 +595,8 @@
 		return 1;
 #endif
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(PF_FREEZE) && !signal_pending(current))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/mips/kernel/irixsig.c 582-refrigerator-new/arch/mips/kernel/irixsig.c
--- 582-refrigerator-old/arch/mips/kernel/irixsig.c	2004-11-03 21:54:45.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/irixsig.c	2004-11-24 17:56:06.855083064 +1100
@@ -13,7 +13,6 @@
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/ptrace.h>
-#include <linux/suspend.h>
 
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -182,10 +181,8 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/mips/kernel/signal32.c 582-refrigerator-new/arch/mips/kernel/signal32.c
--- 582-refrigerator-old/arch/mips/kernel/signal32.c	2004-11-24 09:52:53.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/signal32.c	2004-11-24 17:56:30.046557424 +1100
@@ -18,7 +18,6 @@
 #include <linux/wait.h>
 #include <linux/ptrace.h>
 #include <linux/compat.h>
-#include <linux/suspend.h>
 #include <linux/bitops.h>
 
 #include <asm/asm.h>
@@ -700,10 +699,8 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/mips/kernel/signal.c 582-refrigerator-new/arch/mips/kernel/signal.c
--- 582-refrigerator-old/arch/mips/kernel/signal.c	2004-11-24 09:52:53.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/signal.c	2004-11-24 17:56:06.893077288 +1100
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
-#include <linux/suspend.h>
 #include <linux/unistd.h>
 #include <linux/bitops.h>
 
@@ -551,10 +550,8 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/sh/kernel/signal.c 582-refrigerator-new/arch/sh/kernel/signal.c
--- 582-refrigerator-old/arch/sh/kernel/signal.c	2004-11-24 09:52:54.000000000 +1100
+++ 582-refrigerator-new/arch/sh/kernel/signal.c	2004-11-24 17:56:06.899076376 +1100
@@ -24,7 +24,6 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
-#include <linux/suspend.h>
 
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -579,10 +578,8 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/sh64/kernel/signal.c 582-refrigerator-new/arch/sh64/kernel/signal.c
--- 582-refrigerator-old/arch/sh64/kernel/signal.c	2004-11-03 21:53:44.000000000 +1100
+++ 582-refrigerator-new/arch/sh64/kernel/signal.c	2004-11-24 17:56:06.914074096 +1100
@@ -701,10 +701,8 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-		}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/arch/x86_64/kernel/signal.c 582-refrigerator-new/arch/x86_64/kernel/signal.c
--- 582-refrigerator-old/arch/x86_64/kernel/signal.c	2004-11-03 21:54:16.000000000 +1100
+++ 582-refrigerator-new/arch/x86_64/kernel/signal.c	2004-11-24 17:56:06.939070296 +1100
@@ -24,7 +24,6 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
-#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -417,10 +416,8 @@
 		return 1;
 	} 	
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruN 582-refrigerator-old/drivers/ieee1394/ieee1394_core.c 582-refrigerator-new/drivers/ieee1394/ieee1394_core.c
--- 582-refrigerator-old/drivers/ieee1394/ieee1394_core.c	2004-11-03 21:52:22.000000000 +1100
+++ 582-refrigerator-new/drivers/ieee1394/ieee1394_core.c	2004-11-24 17:56:06.947069080 +1100
@@ -32,7 +32,6 @@
 #include <linux/bitops.h>
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
-#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -1030,15 +1029,17 @@
 
 	daemonize("khpsbpkt");
 
-	while (!down_interruptible(&khpsbpkt_sig)) {
-		if (khpsbpkt_kill)
+	while (1) {
+		if (down_interruptible(&khpsbpkt_sig)) {
+			if (try_to_freeze(0))
+				continue;
+			printk("khpsbpkt: received unexpected signal?!\n" );
 			break;
-
-		if (current->flags & PF_FREEZE) {
-			refrigerator(0);
-			continue;
 		}
 
+		if (khpsbpkt_kill)
+			break;
+
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
 
diff -ruN 582-refrigerator-old/drivers/ieee1394/nodemgr.c 582-refrigerator-new/drivers/ieee1394/nodemgr.c
--- 582-refrigerator-old/drivers/ieee1394/nodemgr.c	2004-11-24 09:52:58.000000000 +1100
+++ 582-refrigerator-new/drivers/ieee1394/nodemgr.c	2004-11-24 17:57:00.519924768 +1100
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
-#include <linux/suspend.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -1480,10 +1479,8 @@
 
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
-			if (current->flags & PF_FREEZE) {
-				refrigerator(0);
+			if (try_to_freeze(PF_FREEZE))
 				continue;
-			}
 			printk("NodeMgr: received unexpected signal?!\n" );
 			break;
 		}
@@ -1498,6 +1495,8 @@
 		for (i = 0; i < 4 ; i++) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (msleep_interruptible(63)) {
+				if (try_to_freeze(PF_FREEZE))
+					continue;
 				up(&nodemgr_serialize);
 				goto caught_signal;
 			}
diff -ruN 582-refrigerator-old/drivers/input/serio/serio.c 582-refrigerator-new/drivers/input/serio/serio.c
--- 582-refrigerator-old/drivers/input/serio/serio.c	2004-11-24 09:52:58.000000000 +1100
+++ 582-refrigerator-new/drivers/input/serio/serio.c	2004-11-24 17:56:06.968065888 +1100
@@ -34,7 +34,6 @@
 #include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-#include <linux/suspend.h>
 #include <linux/slab.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -225,8 +224,7 @@
 	do {
 		serio_handle_events();
 		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list));
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
diff -ruN 582-refrigerator-old/drivers/md/md.c 582-refrigerator-new/drivers/md/md.c
--- 582-refrigerator-old/drivers/md/md.c	2004-11-24 09:52:58.000000000 +1100
+++ 582-refrigerator-new/drivers/md/md.c	2004-11-24 17:56:06.977064520 +1100
@@ -36,7 +36,6 @@
 #include <linux/sysctl.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
-#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2761,6 +2760,7 @@
 	 */
 
 	daemonize(thread->name, mdname(thread->mddev));
+	current->flags |= PF_NOFREEZE;
 
 	current->exit_signal = SIGCHLD;
 	allow_signal(SIGKILL);
@@ -2785,8 +2785,6 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
diff -ruN 582-refrigerator-old/drivers/media/video/msp3400.c 582-refrigerator-new/drivers/media/video/msp3400.c
--- 582-refrigerator-old/drivers/media/video/msp3400.c	2004-11-24 09:52:59.000000000 +1100
+++ 582-refrigerator-new/drivers/media/video/msp3400.c	2004-11-24 17:58:02.541496056 +1100
@@ -741,6 +741,7 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
+again:
 	add_wait_queue(&msp->wq, &wait);
 	if (!kthread_should_stop()) {
 		if (timeout < 0) {
@@ -756,9 +757,11 @@
 #endif
 		}
 	}
-	if (current->flags & PF_FREEZE)
-		refrigerator(PF_FREEZE);
 	remove_wait_queue(&msp->wq, &wait);
+
+	if (try_to_freeze(PF_FREEZE))
+		goto again;
+
 	return msp->restart;
 }
 
diff -ruN 582-refrigerator-old/drivers/media/video/tvaudio.c 582-refrigerator-new/drivers/media/video/tvaudio.c
--- 582-refrigerator-old/drivers/media/video/tvaudio.c	2004-11-24 09:52:59.000000000 +1100
+++ 582-refrigerator-new/drivers/media/video/tvaudio.c	2004-11-24 17:56:06.982063760 +1100
@@ -285,6 +285,7 @@
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
+		try_to_freeze(PF_FREEZE);
 		if (chip->done || signal_pending(current))
 			break;
 		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
diff -ruN 582-refrigerator-old/drivers/mtd/mtd_blkdevs.c 582-refrigerator-new/drivers/mtd/mtd_blkdevs.c
--- 582-refrigerator-old/drivers/mtd/mtd_blkdevs.c	2004-11-24 09:52:59.000000000 +1100
+++ 582-refrigerator-new/drivers/mtd/mtd_blkdevs.c	2004-11-24 17:56:06.984063456 +1100
@@ -113,6 +113,8 @@
 			schedule();
 			remove_wait_queue(&tr->blkcore_priv->thread_wq, &wait);
 
+			try_to_freeze(PF_FREEZE);
+
 			spin_lock_irq(rq->queue_lock);
 
 			continue;
diff -ruN 582-refrigerator-old/drivers/net/8139too.c 582-refrigerator-new/drivers/net/8139too.c
--- 582-refrigerator-old/drivers/net/8139too.c	2004-11-24 09:52:59.000000000 +1100
+++ 582-refrigerator-new/drivers/net/8139too.c	2004-11-24 17:56:06.987063000 +1100
@@ -108,7 +108,6 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <linux/crc32.h>
-#include <linux/suspend.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
@@ -1624,8 +1623,7 @@
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
 			/* make swsusp happy with our thread */
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
diff -ruN 582-refrigerator-old/drivers/net/irda/sir_kthread.c 582-refrigerator-new/drivers/net/irda/sir_kthread.c
--- 582-refrigerator-old/drivers/net/irda/sir_kthread.c	2004-11-03 21:55:05.000000000 +1100
+++ 582-refrigerator-new/drivers/net/irda/sir_kthread.c	2004-11-24 17:56:06.988062848 +1100
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/suspend.h>
 
 #include <net/irda/irda.h>
 
@@ -113,6 +112,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 
 	daemonize("kIrDAd");
+	current->flags |= PF_NOFREEZE;
 
 	irda_rq_queue.thread = current;
 
@@ -135,10 +135,6 @@
 			__set_task_state(current, TASK_RUNNING);
 		remove_wait_queue(&irda_rq_queue.kick, &wait);
 
-		/* make swsusp happy with our thread */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
-
 		run_irda_queue();
 	}
 
diff -ruN 582-refrigerator-old/drivers/net/irda/stir4200.c 582-refrigerator-new/drivers/net/irda/stir4200.c
--- 582-refrigerator-old/drivers/net/irda/stir4200.c	2004-11-24 09:53:01.000000000 +1100
+++ 582-refrigerator-new/drivers/net/irda/stir4200.c	2004-11-24 17:56:06.990062544 +1100
@@ -46,7 +46,6 @@
 #include <linux/time.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/suspend.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/usb.h>
diff -ruN 582-refrigerator-old/drivers/net/wireless/airo.c 582-refrigerator-new/drivers/net/wireless/airo.c
--- 582-refrigerator-old/drivers/net/wireless/airo.c	2004-11-24 09:53:02.000000000 +1100
+++ 582-refrigerator-new/drivers/net/wireless/airo.c	2004-11-24 17:56:06.998061328 +1100
@@ -33,7 +33,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
-#include <linux/suspend.h>
 #include <linux/in.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
@@ -2918,8 +2917,7 @@
 			flush_signals(current);
 
 		/* make swsusp happy with our thread */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		if (test_bit(JOB_DIE, &ai->flags))
 			break;
diff -ruN 582-refrigerator-old/drivers/pcmcia/cs.c 582-refrigerator-new/drivers/pcmcia/cs.c
--- 582-refrigerator-old/drivers/pcmcia/cs.c	2004-11-24 09:53:02.000000000 +1100
+++ 582-refrigerator-new/drivers/pcmcia/cs.c	2004-11-24 17:56:07.020057984 +1100
@@ -48,7 +48,6 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/suspend.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -718,8 +717,7 @@
 		}
 
 		schedule();
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		if (!skt->thread)
 			break;
diff -ruN 582-refrigerator-old/drivers/pcmcia/socket_sysfs.c 582-refrigerator-new/drivers/pcmcia/socket_sysfs.c
--- 582-refrigerator-old/drivers/pcmcia/socket_sysfs.c	2004-11-03 21:51:32.000000000 +1100
+++ 582-refrigerator-new/drivers/pcmcia/socket_sysfs.c	2004-11-24 17:56:07.035055704 +1100
@@ -25,7 +25,6 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/suspend.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
diff -ruN 582-refrigerator-old/drivers/pnp/pnpbios/core.c 582-refrigerator-new/drivers/pnp/pnpbios/core.c
--- 582-refrigerator-old/drivers/pnp/pnpbios/core.c	2004-11-24 09:53:03.000000000 +1100
+++ 582-refrigerator-new/drivers/pnp/pnpbios/core.c	2004-11-24 17:58:33.769748640 +1100
@@ -179,6 +179,10 @@
 		 * Poll every 2 seconds
 		 */
 		msleep_interruptible(2000);
+
+		if(current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
 		if(signal_pending(current))
 			break;
 
diff -ruN 582-refrigerator-old/drivers/scsi/libata-core.c 582-refrigerator-new/drivers/scsi/libata-core.c
--- 582-refrigerator-old/drivers/scsi/libata-core.c	2004-11-24 18:03:13.232263880 +1100
+++ 582-refrigerator-new/drivers/scsi/libata-core.c	2004-11-24 17:56:07.050053424 +1100
@@ -35,7 +35,6 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
diff -ruN 582-refrigerator-old/drivers/usb/core/hub.c 582-refrigerator-new/drivers/usb/core/hub.c
--- 582-refrigerator-old/drivers/usb/core/hub.c	2004-11-24 09:53:05.000000000 +1100
+++ 582-refrigerator-new/drivers/usb/core/hub.c	2004-11-24 17:56:07.053052968 +1100
@@ -26,7 +26,6 @@
 #include <linux/ioctl.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
-#include <linux/suspend.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -2713,8 +2712,7 @@
 	do {
 		hub_events();
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	pr_debug ("%s: khubd exiting\n", usbcore_name);
diff -ruN 582-refrigerator-old/drivers/w1/w1.c 582-refrigerator-new/drivers/w1/w1.c
--- 582-refrigerator-old/drivers/w1/w1.c	2004-11-24 09:53:07.000000000 +1100
+++ 582-refrigerator-new/drivers/w1/w1.c	2004-11-24 17:56:07.076049472 +1100
@@ -32,7 +32,6 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/suspend.h>
 
 #include "w1.h"
 #include "w1_io.h"
@@ -628,8 +627,7 @@
 		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&w1_control_wait, timeout);
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending(current) && (timeout > 0));
 
 		if (signal_pending(current))
@@ -701,8 +699,7 @@
 		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&dev->kwait, timeout);
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending(current) && (timeout > 0));
 
 		if (signal_pending(current))
diff -ruN 582-refrigerator-old/fs/afs/kafsasyncd.c 582-refrigerator-new/fs/afs/kafsasyncd.c
--- 582-refrigerator-old/fs/afs/kafsasyncd.c	2004-11-03 21:55:01.000000000 +1100
+++ 582-refrigerator-new/fs/afs/kafsasyncd.c	2004-11-24 17:56:07.089047496 +1100
@@ -116,6 +116,8 @@
 		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		afs_discard_my_signals();
 
diff -ruN 582-refrigerator-old/fs/afs/kafstimod.c 582-refrigerator-new/fs/afs/kafstimod.c
--- 582-refrigerator-old/fs/afs/kafstimod.c	2004-11-03 21:55:05.000000000 +1100
+++ 582-refrigerator-new/fs/afs/kafstimod.c	2004-11-24 17:56:07.092047040 +1100
@@ -91,6 +91,8 @@
 			complete_and_exit(&kafstimod_dead, 0);
 		}
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		afs_discard_my_signals();
 
diff -ruN 582-refrigerator-old/fs/buffer.c 582-refrigerator-new/fs/buffer.c
--- 582-refrigerator-old/fs/buffer.c	2004-11-24 09:53:07.000000000 +1100
+++ 582-refrigerator-new/fs/buffer.c	2004-11-24 17:59:03.766188488 +1100
@@ -38,6 +38,8 @@
 #include <linux/bio.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/swap.h>
 #include <linux/bitops.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
@@ -170,6 +172,16 @@
  */
 int fsync_super(struct super_block *sb)
 {
+	int ret;
+
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
+		return 0;
+	
+	current->flags |= PF_SYNCTHREAD;
+
 	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
@@ -181,7 +193,10 @@
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
 
-	return sync_blockdev(sb->s_bdev);
+	ret = sync_blockdev(sb->s_bdev);
+
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /*
@@ -192,12 +207,22 @@
 int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
+	int ret;
+
+	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
+		return 0;
+
+	current->flags |= PF_SYNCTHREAD;
+
 	if (sb) {
 		int res = fsync_super(sb);
 		drop_super(sb);
+		current->flags &= ~PF_SYNCTHREAD;
 		return res;
 	}
-	return sync_blockdev(bdev);
+	ret = sync_blockdev(bdev);
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /**
@@ -277,6 +302,14 @@
  */
 static void do_sync(unsigned long wait)
 {
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
+		return;
+
+	current->flags |= PF_SYNCTHREAD;
+
 	wakeup_bdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
@@ -288,6 +321,8 @@
 		printk("Emergency Sync complete\n");
 	if (unlikely(laptop_mode))
 		laptop_sync_completion();
+
+	current->flags &= ~PF_SYNCTHREAD;
 }
 
 asmlinkage long sys_sync(void)
@@ -296,6 +331,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(sys_sync);
+
 void emergency_sync(void)
 {
 	pdflush_operation(do_sync, 0);
@@ -313,6 +350,11 @@
 	struct super_block * sb;
 	int ret;
 
+	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
+		return 0;
+
+	current->flags |= PF_SYNCTHREAD;
+
 	/* sync the inode to buffers */
 	write_inode_now(inode, 0);
 
@@ -325,6 +367,8 @@
 
 	/* .. finally sync the buffers to disk */
 	ret = sync_blockdev(sb->s_bdev);
+
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -334,6 +378,8 @@
 	struct address_space *mapping;
 	int ret, err;
 
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -363,6 +409,7 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -372,6 +419,8 @@
 	struct address_space *mapping;
 	int ret, err;
 
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -398,6 +447,7 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -1062,6 +1112,8 @@
 	 * async buffer heads in use.
 	 */
 	free_more_memory();
+	if (suspend_task == current->pid)
+		suspend2_cleanup_finished_io();
 	goto try_again;
 }
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
diff -ruN 582-refrigerator-old/fs/jbd/journal.c 582-refrigerator-new/fs/jbd/journal.c
--- 582-refrigerator-old/fs/jbd/journal.c	2004-11-24 09:53:07.000000000 +1100
+++ 582-refrigerator-new/fs/jbd/journal.c	2004-11-24 17:56:07.115043544 +1100
@@ -130,6 +130,7 @@
 	current_journal = journal;
 
 	daemonize("kjournald");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
diff -ruN 582-refrigerator-old/fs/jffs/intrep.c 582-refrigerator-new/fs/jffs/intrep.c
--- 582-refrigerator-old/fs/jffs/intrep.c	2004-11-03 21:53:49.000000000 +1100
+++ 582-refrigerator-new/fs/jffs/intrep.c	2004-11-24 17:56:07.127041720 +1100
@@ -3338,6 +3338,7 @@
 	D1(int i = 1);
 
 	daemonize("jffs_gcd");
+	current->flags |= PF_SYNCTHREAD;
 
 	c->gc_task = current;
 
@@ -3373,6 +3374,9 @@
 			siginfo_t info;
 			unsigned long signr = 0;
 
+			if (try_to_freeze(PF_FREEZE))
+				continue;
+
 			spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(current, &current->blocked, &info);
 			spin_unlock_irq(&current->sighand->siglock);
diff -ruN 582-refrigerator-old/fs/jffs2/background.c 582-refrigerator-new/fs/jffs2/background.c
--- 582-refrigerator-old/fs/jffs2/background.c	2004-11-03 21:51:10.000000000 +1100
+++ 582-refrigerator-new/fs/jffs2/background.c	2004-11-24 17:56:07.150038224 +1100
@@ -15,7 +15,6 @@
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include "nodelist.h"
 
 
@@ -93,12 +92,8 @@
 			schedule();
 		}
 
-		if (current->flags & PF_FREEZE) {
-			refrigerator(0);
-			/* refrigerator() should recalc sigpending for us
-			   but doesn't. No matter - allow_signal() will. */
+		if (try_to_freeze(0))
 			continue;
-		}
 
 		cond_resched();
 
diff -ruN 582-refrigerator-old/fs/jfs/jfs_logmgr.c 582-refrigerator-new/fs/jfs/jfs_logmgr.c
--- 582-refrigerator-old/fs/jfs/jfs_logmgr.c	2004-11-24 09:53:07.000000000 +1100
+++ 582-refrigerator-new/fs/jfs/jfs_logmgr.c	2004-11-24 17:56:07.168035488 +1100
@@ -2316,6 +2316,7 @@
 	struct lbuf *bp;
 
 	daemonize("jfsIO");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruN 582-refrigerator-old/fs/jfs/jfs_txnmgr.c 582-refrigerator-new/fs/jfs/jfs_txnmgr.c
--- 582-refrigerator-old/fs/jfs/jfs_txnmgr.c	2004-11-24 09:53:07.000000000 +1100
+++ 582-refrigerator-new/fs/jfs/jfs_txnmgr.c	2004-11-24 17:56:07.172034880 +1100
@@ -47,7 +47,6 @@
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include "jfs_incore.h"
@@ -2727,6 +2726,7 @@
 	struct jfs_sb_info *sbi;
 
 	daemonize("jfsCommit");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruN 582-refrigerator-old/fs/lockd/clntlock.c 582-refrigerator-new/fs/lockd/clntlock.c
--- 582-refrigerator-old/fs/lockd/clntlock.c	2004-11-03 21:55:00.000000000 +1100
+++ 582-refrigerator-new/fs/lockd/clntlock.c	2004-11-24 17:56:07.183033208 +1100
@@ -200,6 +200,7 @@
 	struct inode *inode;
 
 	daemonize("%s-reclaim", host->h_name);
+	current->flags |= PF_SYNCTHREAD;
 	allow_signal(SIGKILL);
 
 	/* This one ensures that our parent doesn't terminate while the
@@ -222,6 +223,7 @@
 
 		fl->fl_u.nfs_fl.flags &= ~NFS_LCK_RECLAIM;
 		nlmclnt_reclaim(host, fl);
+		try_to_freeze(PF_FREEZE);
 		if (signalled())
 			break;
 		goto restart;
diff -ruN 582-refrigerator-old/fs/lockd/clntproc.c 582-refrigerator-new/fs/lockd/clntproc.c
--- 582-refrigerator-old/fs/lockd/clntproc.c	2004-11-03 21:55:04.000000000 +1100
+++ 582-refrigerator-new/fs/lockd/clntproc.c	2004-11-24 17:56:07.185032904 +1100
@@ -310,6 +310,7 @@
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
+		try_to_freeze(PF_FREEZE);
 		if (!signalled ())
 			status = 0;
 	}
diff -ruN 582-refrigerator-old/fs/lockd/svc.c 582-refrigerator-new/fs/lockd/svc.c
--- 582-refrigerator-old/fs/lockd/svc.c	2004-11-03 21:54:14.000000000 +1100
+++ 582-refrigerator-new/fs/lockd/svc.c	2004-11-24 17:56:07.191031992 +1100
@@ -112,6 +112,7 @@
 	up(&lockd_start);
 
 	daemonize("lockd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Process request with signals blocked, but allow SIGKILL.  */
 	allow_signal(SIGKILL);
@@ -135,6 +136,8 @@
 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
+		try_to_freeze(PF_SYNCTHREAD);
+
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
diff -ruN 582-refrigerator-old/fs/nfsd/nfssvc.c 582-refrigerator-new/fs/nfsd/nfssvc.c
--- 582-refrigerator-old/fs/nfsd/nfssvc.c	2004-11-24 09:53:08.000000000 +1100
+++ 582-refrigerator-new/fs/nfsd/nfssvc.c	2004-11-24 17:59:23.732153200 +1100
@@ -180,6 +180,7 @@
 	/* Lock module and set up kernel thread */
 	lock_kernel();
 	daemonize("nfsd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* After daemonize() this kernel thread shares current->fs
 	 * with the init process. We need to create files with a
diff -ruN 582-refrigerator-old/fs/reiserfs/journal.c 582-refrigerator-new/fs/reiserfs/journal.c
--- 582-refrigerator-old/fs/reiserfs/journal.c	2004-11-24 18:03:13.238262968 +1100
+++ 582-refrigerator-new/fs/reiserfs/journal.c	2004-11-24 17:56:07.211028952 +1100
@@ -50,7 +50,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/suspend.h>
 #include <linux/buffer_head.h>
 #include <linux/workqueue.h>
 #include <linux/writeback.h>
diff -ruN 582-refrigerator-old/fs/xfs/linux-2.6/xfs_buf.c 582-refrigerator-new/fs/xfs/linux-2.6/xfs_buf.c
--- 582-refrigerator-old/fs/xfs/linux-2.6/xfs_buf.c	2004-11-24 18:03:13.239262816 +1100
+++ 582-refrigerator-new/fs/xfs/linux-2.6/xfs_buf.c	2004-11-24 17:56:07.214028496 +1100
@@ -51,7 +51,6 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
-#include <linux/suspend.h>
 #include <linux/percpu.h>
 
 #include "xfs_linux.h"
@@ -1657,7 +1656,7 @@
 
 	/*  Set up the thread  */
 	daemonize("xfsbufd");
-	current->flags |= PF_MEMALLOC;
+	current->flags |= PF_MEMALLOC | PF_SYNCTHREAD;
 
 	pagebuf_daemon_task = current;
 	pagebuf_daemon_active = 1;
@@ -1665,9 +1664,7 @@
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		/* swsusp */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout((xfs_buf_timer_centisecs * HZ) / 100);
diff -ruN 582-refrigerator-old/fs/xfs/linux-2.6/xfs_super.c 582-refrigerator-new/fs/xfs/linux-2.6/xfs_super.c
--- 582-refrigerator-old/fs/xfs/linux-2.6/xfs_super.c	2004-11-03 21:55:00.000000000 +1100
+++ 582-refrigerator-new/fs/xfs/linux-2.6/xfs_super.c	2004-11-24 17:56:07.230026064 +1100
@@ -71,7 +71,6 @@
 #include <linux/namei.h>
 #include <linux/init.h>
 #include <linux/mount.h>
-#include <linux/suspend.h>
 #include <linux/writeback.h>
 
 STATIC struct quotactl_ops linvfs_qops;
@@ -472,6 +471,7 @@
 	struct vfs_sync_work	*work, *n;
 
 	daemonize("xfssyncd");
+	current->flags |= PF_SYNCTHREAD;
 
 	vfsp->vfs_sync_work.w_vfs = vfsp;
 	vfsp->vfs_sync_work.w_syncer = vfs_sync_worker;
@@ -485,8 +485,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		timeleft = schedule_timeout(timeleft);
 		/* swsusp */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 
diff -ruN 582-refrigerator-old/include/linux/sched.h 582-refrigerator-new/include/linux/sched.h
--- 582-refrigerator-old/include/linux/sched.h	2004-11-24 18:03:13.123280448 +1100
+++ 582-refrigerator-new/include/linux/sched.h	2004-11-24 17:59:48.248426160 +1100
@@ -19,6 +19,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -701,7 +702,7 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
 
-#define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
+#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -710,6 +711,8 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_SYNCTHREAD	0x00800000	/* this thread can start activity during the 
+					   early part of freezing processes */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
@@ -720,6 +723,29 @@
 }
 #endif
 
+/* try_to_freeze
+ *
+ * Checks whether we need to enter the refrigerator
+ * and returns 1 if we did so.
+ */
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
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
+static inline int try_to_freeze(unsigned long refrigerator_flags)
+{
+	return 0;
+}
+#endif
+
 extern unsigned long long sched_clock(void);
 
 /* sched_exec is called by processes performing an exec */
@@ -1119,6 +1145,14 @@
 
 #endif
 
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern unsigned int suspend_task;
+#else
+#define refrigerator(a)			do { } while(0)
+#define suspend_task (0)
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -ruN 582-refrigerator-old/kernel/exit.c 582-refrigerator-new/kernel/exit.c
--- 582-refrigerator-old/kernel/exit.c	2004-11-24 18:03:13.124280296 +1100
+++ 582-refrigerator-new/kernel/exit.c	2004-11-24 17:56:07.236025152 +1100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
+#include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/namespace.h>
 #include <linux/key.h>
@@ -802,6 +803,8 @@
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
+	if (unlikely(test_suspend_state(SUSPEND_FREEZER_ON)))
+		refrigerator(0);
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 
diff -ruN 582-refrigerator-old/kernel/fork.c 582-refrigerator-new/kernel/fork.c
--- 582-refrigerator-old/kernel/fork.c	2004-11-24 18:03:13.126279992 +1100
+++ 582-refrigerator-new/kernel/fork.c	2004-11-24 17:56:07.238024848 +1100
@@ -39,6 +39,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1125,6 +1126,10 @@
 	int trace = 0;
 	long pid = alloc_pidmap();
 
+
+	if (unlikely(test_suspend_state(SUSPEND_FREEZER_ON)))
+		refrigerator(0);
+
 	if (pid < 0)
 		return -EAGAIN;
 	if (unlikely(current->ptrace)) {
diff -ruN 582-refrigerator-old/kernel/power/disk.c 582-refrigerator-new/kernel/power/disk.c
--- 582-refrigerator-old/kernel/power/disk.c	2004-11-24 09:53:12.000000000 +1100
+++ 582-refrigerator-new/kernel/power/disk.c	2004-11-24 17:56:07.253022568 +1100
@@ -116,7 +116,7 @@
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	pm_restore_console();
 }
 
@@ -128,7 +128,7 @@
 	pm_prepare_console();
 
 	sys_sync();
-	if (freeze_processes()) {
+	if (freeze_processes(1)) {
 		error = -EBUSY;
 		goto Thaw;
 	}
@@ -152,7 +152,7 @@
 	platform_finish();
  Thaw:
 	enable_nonboot_cpus();
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	pm_restore_console();
 	return error;
 }
diff -ruN 582-refrigerator-old/kernel/power/main.c 582-refrigerator-new/kernel/power/main.c
--- 582-refrigerator-old/kernel/power/main.c	2004-11-24 18:03:13.289255216 +1100
+++ 582-refrigerator-new/kernel/power/main.c	2004-11-24 17:56:07.254022416 +1100
@@ -55,7 +55,7 @@
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (freeze_processes(1)) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
@@ -72,7 +72,7 @@
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	pm_restore_console();
 	return error;
 }
@@ -107,7 +107,7 @@
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	pm_restore_console();
 }
 
diff -ruN 582-refrigerator-old/kernel/power/power.h 582-refrigerator-new/kernel/power/power.h
--- 582-refrigerator-old/kernel/power/power.h	2004-11-03 21:55:05.000000000 +1100
+++ 582-refrigerator-new/kernel/power/power.h	2004-11-24 17:56:07.264020896 +1100
@@ -45,8 +45,8 @@
 
 extern struct subsystem power_subsys;
 
-extern int freeze_processes(void);
-extern void thaw_processes(void);
+extern int freeze_processes(int no_progress);
+extern void thaw_processes(int which_threads);
 
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
diff -ruN 582-refrigerator-old/kernel/power/process.c 582-refrigerator-new/kernel/power/process.c
--- 582-refrigerator-old/kernel/power/process.c	2004-11-24 09:53:12.000000000 +1100
+++ 582-refrigerator-new/kernel/power/process.c	2004-11-24 18:03:09.613813968 +1100
@@ -1,121 +1,521 @@
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
- *                           suspend transitions.
+ * kernel/power/process.c
  *
- * Originally from swsusp.
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Freeze_and_free contains the routines software suspend uses to freeze other
+ * processes during the suspend cycle and to (if necessary) free up memory in
+ * accordance with limitations on the image size.
+ *
+ * Ideally, the image saved to disk would be an atomic copy of the entire 
+ * contents of all RAM and related hardware state. One of the first 
+ * prerequisites for getting our approximation of this is stopping the activity
+ * of other processes. We can't stop all other processes, however, since some 
+ * are needed in doing the I/O to save the image. Freeze_and_free.c contains 
+ * the routines that control suspension and resuming of these processes.
+ * 
+ * Under high I/O load, we need to be careful about the order in which we
+ * freeze processes. If we freeze processes in the wrong order, we could
+ * deadlock others. The freeze_order array this specifies the order in which
+ * critical processes are frozen. All others are suspended after these have
+ * entered the refrigerator.
+ *
+ * Another complicating factor is that freeing memory requires the processes
+ * to not be frozen, but at the end of freeing memory, they need to be frozen
+ * so that we can be sure we actually have eaten enough memory. This is why
+ * freezing and freeing are in the one file. The freezer is not called from
+ * the main logic, but indirectly, via the code for eating memory. The eat
+ * memory logic is iterative, first freezing processes and checking the stats,
+ * then (if necessary) unfreezing them and eating more memory until it looks 
+ * like the criteria are met (at which point processes are frozen & stats
+ * checked again).
  */
 
+#define SUSPEND_FREEZER_C
 
-#undef DEBUG
-
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
+#include <asm/tlbflush.h>
 
-/* 
- * Timeout for stopping processes
+#include "suspend.h"
+
+volatile struct suspend2_core_ops * suspend2_core_ops = NULL;
+unsigned long suspend_action = 0;
+unsigned long suspend_result = 0;
+unsigned long suspend_debug_state = 0;
+unsigned long software_suspend_state = ((1 << SUSPEND_DISABLED) | (1 << SUSPEND_BOOT_TIME) |
+		(1 << SUSPEND_RESUME_NOT_DONE) | (1 << SUSPEND_IGNORE_LOGLEVEL));
+unsigned int suspend_task = 0;
+
+atomic_t __nosavedata suspend_cpu_counter = { 0 }; 
+
+/* Timeouts when freezing */
+#define FREEZER_TOTAL_TIMEOUT (5 * HZ)
+#define FREEZER_CHECK_TIMEOUT (HZ / 10)
+
+extern void suspend_relinquish_console(void);
+
+/* ------------------------------------------------------------------------ */
+
+/**
+ * refrigerator - idle routine for frozen processes
+ * @flag: unsigned long, non zero if signals to be flushed.
+ *
+ * A routine for kernel threads which should not do work during suspend
+ * to enter and spin in until the process is finished.
  */
-#define TIMEOUT	(6 * HZ)
 
+void refrigerator(unsigned long flag)
+{
+	unsigned long flags;
+	long save;
+	
+	if (unlikely(current->flags & PF_NOFREEZE)) {
+		current->flags &= ~PF_FREEZE;
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		recalc_sigpending();
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		return;
+	}
+
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care). 
+	 */
+	if ((flag) && (current->flags & PF_FREEZE)) {
+
+		suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
+			"\n%s (%d) refrigerated and sigpending recalculated.",
+			current->comm, current->pid);
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		recalc_sigpending();
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	} else
+		suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
+			"\n%s (%d) refrigerated.",
+			current->comm, current->pid);
+
+	if (test_suspend_state(SUSPEND_FREEZER_ON)) {
+		save = current->state;
+		current->flags |= PF_FROZEN;
+		while (current->flags & PF_FROZEN) {
+			current->state = TASK_STOPPED;
+			schedule();
+			if (flag) {
+				spin_lock_irqsave(
+					&current->sighand->siglock, flags);
+				recalc_sigpending();
+				spin_unlock_irqrestore(
+					&current->sighand->siglock, flags);
+			}
+		}
+		current->state = save;
+	} else
+		suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
+				"No longer freezing processes. Dropping out.\n");
+	current->flags &= ~PF_FREEZE;
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+}
+
+
+#ifdef CONFIG_SMP
+static void __smp_pause(void * data)
+{
+	atomic_inc(&suspend_cpu_counter);
+	while(test_suspend_state(SUSPEND_FREEZE_SMP)) {
+		cpu_relax();
+		barrier();
+	}
+	local_flush_tlb();
+	atomic_dec(&suspend_cpu_counter);
+}
+
+void smp_pause(void)
+{
+	set_suspend_state(SUSPEND_FREEZE_SMP);
+	smp_call_function(__smp_pause, NULL, 0, 0);
+
+	while (atomic_read(&suspend_cpu_counter) < (num_online_cpus() - 1)) {
+		cpu_relax();
+		barrier();
+	}
+}
 
-static inline int freezeable(struct task_struct * p)
+void smp_continue(void)
 {
-	if ((p == current) || 
+	clear_suspend_state(SUSPEND_FREEZE_SMP);
+		
+	while (atomic_read(&suspend_cpu_counter)) {
+		cpu_relax();
+		barrier();
+	}
+}
+
+extern void __smp_suspend_lowlevel(void * info);
+
+void smp_suspend(void)
+{
+	set_suspend_state(SUSPEND_FREEZE_SMP);
+	smp_call_function(__smp_suspend_lowlevel, NULL, 0, 0);
+
+	while (atomic_read(&suspend_cpu_counter) < (num_online_cpus() - 1)) {
+		cpu_relax();
+		barrier();
+	}
+}
+#else
+#define smp_pause() do { } while(0)
+#define smp_continue() do { } while(0)
+#define smp_suspend() do { } while(0)
+#endif
+
+/*
+ * to_be_frozen
+ *
+ * Description:	Determine whether a process should be frozen yet.
+ * Parameters:	struct task_struct *	The process to consider.
+ * 		int			Which group of processes to consider.
+ * Returns:	int			0 if don't freeze yet, otherwise do.
+ */
+static int to_be_frozen(struct task_struct * p, int type_being_frozen) {
+
+	if ((p == current) ||
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED) ||
-	    (p->state == TASK_TRACED))
+	    (p->state == TASK_TRACED) ||
+	    (p->state == TASK_STOPPED))
+		return 0;
+	if ((!(p->mm)) && (type_being_frozen < 3))
+		return 0;
+	if ((p->flags & PF_SYNCTHREAD) && (type_being_frozen == 1))
 		return 0;
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(unsigned long flag)
+/*
+ * num_to_be_frozen
+ *
+ * Description:	Determine how many processes of our type are still to be
+ * 		frozen. As a side effect, update the progress bar too.
+ * Parameters:	int	Which type we are trying to freeze.
+ * 		int	Whether we are displaying our progress.
+ */
+static int num_to_be_frozen(int type_being_frozen, int no_progress) {
+	
+	struct task_struct *p, *g;
+	int todo_this_type = 0, total_todo = 0;
+	int total_threads = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (to_be_frozen(p, type_being_frozen)) {
+			todo_this_type++;
+			total_todo++;
+		} else if (to_be_frozen(p, 3))
+			total_todo++;
+		total_threads++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	if ((!no_progress) && (suspend2_core_ops)) {
+		suspend2_core_ops->update_status(
+				total_threads - total_todo,
+				total_threads,
+				"%d/%d", 
+				total_threads - total_todo,
+				total_threads);
+	}
+	return todo_this_type;
+}
+
+/*
+ * freeze_threads
+ *
+ * Freeze a set of threads having particular attributes.
+ *
+ * Types:
+ * 1: User threads not syncing.
+ * 2: Remaining user threads.
+ * 3: Kernel threads.
+ */
+extern void show_task(struct task_struct * p);
+
+static int freeze_threads(int type, int no_progress)
 {
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
-	long save;
-	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
-	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
-	current->flags &= ~PF_FREEZE;
+	struct task_struct *p, *g;
+	unsigned long start_time = jiffies;
+	int result = 0, still_to_do;
+
+	suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 1,
+		"\n STARTING TO FREEZE TYPE %d THREADS.\n",
+		type);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
-
-	current->flags |= PF_FROZEN;
-	while (current->flags & PF_FROZEN)
-		schedule();
-	pr_debug("%s left refrigerator\n", current->comm);
-	current->state = save;
-}
-
-/* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
-{
-       int todo;
-       unsigned long start_time;
-	struct task_struct *g, *p;
-	
-	printk( "Stopping tasks: " );
-	start_time = jiffies;
 	do {
-		todo = 0;
+		int numsignalled = 0;
+
+		/* 
+		 * Pause the other processors so we can safely
+		 * change threads' flags
+		 */
+		smp_pause();
+
+		if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+			smp_continue();
+			return 1;
+		}
+
+		preempt_disable();
+
+		local_irq_disable();
+
 		read_lock(&tasklist_lock);
+
+		/*
+		 * Signal the processes.
+		 *
+		 * We signal them every time through. Otherwise pdflush -
+		 * and maybe other processes - might never enter the
+		 * fridge.
+		 *
+		 * NB: We're inside an SMP pause. Our printks are unsafe.
+		 * They're only here for debugging.
+		 *
+		 */
+		
 		do_each_thread(g, p) {
 			unsigned long flags;
-			if (!freezeable(p))
-				continue;
-			if ((p->flags & PF_FROZEN) ||
-			    (p->state == TASK_TRACED) ||
-			    (p->state == TASK_STOPPED))
+			if (!to_be_frozen(p, type))
 				continue;
-
-			/* FIXME: smp problem here: we may not access other process' flags
-			   without locking */
+			
+			numsignalled++;
+			suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0, 
+				"\n   %s: pid %d",
+				p->comm, p->pid);
 			p->flags |= PF_FREEZE;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
 		} while_each_thread(g, p);
+
+		if (numsignalled)
+			suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
+				"\n Number of threads signalled this iteration is %d.\n",
+				numsignalled);
+
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
-		if (time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			return todo;
+
+		/* 
+		 * Let the processes run.
+		 */		
+		smp_continue();
+
+		preempt_enable();
+
+		local_irq_enable();
+		
+		/*
+		 * Sleep.
+		 */
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		schedule_timeout(FREEZER_CHECK_TIMEOUT);
+
+		still_to_do = num_to_be_frozen(type, no_progress);
+	} while(still_to_do && (!TEST_RESULT_STATE(SUSPEND_ABORTED)) &&
+		!time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT));
+
+	/*
+	 * Did we time out? See if we failed to freeze processes as well.
+	 *
+	 */
+	if ((time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT)) && (still_to_do)) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (!to_be_frozen(p, type)) 
+				continue;
+			
+			if (!result) {
+				printk(KERN_ERR name_suspend
+					"Stopping tasks failed.\n");
+				printk(KERN_ERR "Tasks that refused to be refrigerated"
+					" and haven't since exited:\n");
+				result = 1;
+			}
+			
+			if (p->flags & PF_FREEZE) {
+				printk(" - %s (#%d) signalled but "
+					"didn't enter refrigerator.\n",
+					p->comm, p->pid);
+				show_task(p);
+			} else
+				printk(" - %s (#%d) wasn't "
+					"signalled.\n",
+					p->comm, p->pid);
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+	} else
+		suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 1,
+			"\n\nSuccessfully froze processes of type %d.\n",
+			type);
+	return result;
+}
+
+/*
+ * freeze_processes - Freeze processes prior to saving an image of memory.
+ * 
+ * Return value: 0 = success, else # of processes that we failed to stop.
+ */
+extern asmlinkage long sys_sync(void);
+
+/* Freeze_processes.
+ * If the flag no_progress is non-zero, progress bars not be updated.
+ * Debugging output is still printed.
+ */
+int freeze_processes(int no_progress)
+{
+	int showidlelist, result = 0, num_type[3];
+	struct task_struct *p, *g;
+
+	showidlelist = 1;
+
+	num_type[0] = num_type[1] = num_type[2] = 0;
+
+	set_suspend_state(SUSPEND_FREEZER_ON);
+
+	suspend_result = 0;	/* Might be called from pm_disk or suspend -
+				   ensure reset */
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->mm) {
+			if (p->flags & PF_SYNCTHREAD) {
+				suspend_message(SUSPEND_FREEZER, SUSPEND_MEDIUM, 0,
+					"%s (%d) is a syncthread at entrance to "
+					"fridge\n", p->comm, p->pid);
+				num_type[1]++;
+			} else
+				num_type[2]++;
+		} else {
+			if (p->flags & PF_NOFREEZE)
+				suspend_message(SUSPEND_FREEZER, SUSPEND_MEDIUM, 0,
+					"%s (%d) is NO_FREEZE.\n",
+					p->comm, p->pid);
+			else
+				num_type[2]++;
 		}
-	} while(todo);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+	suspend_message(SUSPEND_FREEZER, SUSPEND_MEDIUM, 0, "\n");
+
+	/* First, freeze all userspace,	non syncing threads. */
+	if (freeze_threads(1, no_progress) || (TEST_RESULT_STATE(SUSPEND_ABORTED)))
+		goto aborting;
 	
-	printk( "|\n" );
-	BUG_ON(in_atomic());
-	return 0;
+	/* Now freeze processes that were syncing and are still running */
+	if (freeze_threads(2, no_progress) || (TEST_RESULT_STATE(SUSPEND_ABORTED)))
+		goto aborting;
+
+	/* Now do our own sync, just in case one wasn't running already */
+	if ((!no_progress) && (suspend2_core_ops))
+		suspend2_core_ops->prepare_status(1, 1,
+			"Freezing processes: Syncing remaining I/O.");
+
+	sys_sync();
+
+	set_suspend_state(SUSPEND_DISABLE_SYNCING);
+
+	/* Freeze kernel threads */
+	if (freeze_threads(3, no_progress) || (TEST_RESULT_STATE(SUSPEND_ABORTED)))
+		goto aborting;
+
+	if (TEST_ACTION_STATE(SUSPEND_FREEZE_TIMERS)) {
+		printk("Enabling timer freezer. If you get a hang, note " \
+			"the timer attempting to run, press T to disable " \
+			"the timer freezer. After resuming, please look up " \
+			"the address you recorded in System.map and report " \
+			"the routinue to Nigel.\n");
+		set_suspend_state(SUSPEND_TIMER_FREEZER_ON);
+	}
+
+	suspend_task = current->pid;
+out:
+	suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 1,
+				"Left freezer loop.\n");
+
+	clear_suspend_state(SUSPEND_FREEZE_SMP);
+
+	while (atomic_read(&suspend_cpu_counter)) {
+		cpu_relax();
+		barrier();
+	}
+
+	return result;
+aborting:
+	result = -1;
+	goto out;
 }
 
-void thaw_processes(void)
+void thaw_processes(int which_threads)
 {
-	struct task_struct *g, *p;
+	struct task_struct *p, *g;
+	suspend_message(SUSPEND_FREEZER, SUSPEND_LOW, 1, "Thawing tasks\n");
+	
+	suspend_task = 0;
+	if (which_threads != FREEZER_KERNEL_THREADS)
+		clear_suspend_state(SUSPEND_FREEZER_ON);
+
+	clear_suspend_state(SUSPEND_DISABLE_SYNCING);
+	clear_suspend_state(SUSPEND_TIMER_FREEZER_ON);
+	
+	/* 
+	 * Pause the other processors so we can safely
+	 * change threads' flags
+	 */
+
+	smp_pause();
+
+	preempt_disable();
+	
+	local_irq_disable();
 
-	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
+
 	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
 		if (p->flags & PF_FROZEN) {
+			if ((which_threads == FREEZER_KERNEL_THREADS) &&
+				(p->mm))
+				continue;
+			suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0,
+					"Waking %5d: %s.\n", p->pid, p->comm);
 			p->flags &= ~PF_FROZEN;
 			wake_up_process(p);
-		} else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		}
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
-	schedule();
-	printk( " done\n" );
+
+	smp_continue();
+	
+	preempt_enable();
+
+	local_irq_enable();
 }
 
+EXPORT_SYMBOL(suspend_task);
+EXPORT_SYMBOL(suspend_action);
+EXPORT_SYMBOL(software_suspend_state);
+EXPORT_SYMBOL(freeze_processes);
+EXPORT_SYMBOL(thaw_processes);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(smp_suspend);
+EXPORT_SYMBOL(smp_continue);
+#endif
 EXPORT_SYMBOL(refrigerator);
diff -ruN 582-refrigerator-old/kernel/signal.c 582-refrigerator-new/kernel/signal.c
--- 582-refrigerator-old/kernel/signal.c	2004-11-24 18:03:13.005298384 +1100
+++ 582-refrigerator-new/kernel/signal.c	2004-11-24 17:56:07.270019984 +1100
@@ -2178,10 +2178,11 @@
 			sigandsets(&current->blocked, &current->blocked, &these);
 			recalc_sigpending();
 			spin_unlock_irq(&current->sighand->siglock);
-
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
-
+			if (current->flags & PF_FREEZE) {
+				refrigerator(PF_FREEZE);
+			}
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
diff -ruN 582-refrigerator-old/mm/pdflush.c 582-refrigerator-new/mm/pdflush.c
--- 582-refrigerator-old/mm/pdflush.c	2004-11-24 18:03:13.252260840 +1100
+++ 582-refrigerator-new/mm/pdflush.c	2004-11-24 17:56:07.271019832 +1100
@@ -17,7 +17,6 @@
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/suspend.h>
 #include <linux/fs.h>		// Needed by writeback.h
 #include <linux/writeback.h>	// Prototypes pdflush_operation()
 #include <linux/kthread.h>
@@ -90,7 +89,7 @@
 
 static int __pdflush(struct pdflush_work *my_work)
 {
-	current->flags |= PF_FLUSHER;
+	current->flags |= (PF_FLUSHER | PF_SYNCTHREAD);
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);
@@ -106,8 +105,7 @@
 		spin_unlock_irq(&pdflush_lock);
 
 		schedule();
-		if (current->flags & PF_FREEZE) {
-			refrigerator(PF_FREEZE);
+		if (try_to_freeze(PF_FREEZE)) {
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
diff -ruN 582-refrigerator-old/mm/vmscan.c 582-refrigerator-new/mm/vmscan.c
--- 582-refrigerator-old/mm/vmscan.c	2004-11-24 18:03:13.302253240 +1100
+++ 582-refrigerator-new/mm/vmscan.c	2004-11-24 17:56:07.273019528 +1100
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/writeback.h>
-#include <linux/suspend.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
 					buffer_heads_over_limit */
@@ -1170,8 +1169,7 @@
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
 	for ( ; ; ) {
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
diff -ruN 582-refrigerator-old/net/bluetooth/rfcomm/core.c 582-refrigerator-new/net/bluetooth/rfcomm/core.c
--- 582-refrigerator-old/net/bluetooth/rfcomm/core.c	2004-11-03 21:51:10.000000000 +1100
+++ 582-refrigerator-new/net/bluetooth/rfcomm/core.c	2004-11-24 17:56:07.285017704 +1100
@@ -1726,6 +1726,8 @@
 			schedule();
 		}
 
+		try_to_freeze(PF_FREEZE);
+
 		/* Process stuff */
 		clear_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
 		rfcomm_process_sessions();
diff -ruN 582-refrigerator-old/net/rxrpc/krxiod.c 582-refrigerator-new/net/rxrpc/krxiod.c
--- 582-refrigerator-old/net/rxrpc/krxiod.c	2004-11-03 21:51:11.000000000 +1100
+++ 582-refrigerator-new/net/rxrpc/krxiod.c	2004-11-24 17:56:07.289017096 +1100
@@ -138,6 +138,8 @@
 
 		_debug("### End Work");
 
+		try_to_freeze(PF_FREEZE);
+
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruN 582-refrigerator-old/net/rxrpc/krxsecd.c 582-refrigerator-new/net/rxrpc/krxsecd.c
--- 582-refrigerator-old/net/rxrpc/krxsecd.c	2004-11-03 21:52:23.000000000 +1100
+++ 582-refrigerator-new/net/rxrpc/krxsecd.c	2004-11-24 17:56:07.291016792 +1100
@@ -107,6 +107,8 @@
 
 		_debug("### End Inbound Calls");
 
+		try_to_freeze(PF_FREEZE);
+
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruN 582-refrigerator-old/net/rxrpc/krxtimod.c 582-refrigerator-new/net/rxrpc/krxtimod.c
--- 582-refrigerator-old/net/rxrpc/krxtimod.c	2004-11-03 21:51:24.000000000 +1100
+++ 582-refrigerator-new/net/rxrpc/krxtimod.c	2004-11-24 17:56:07.292016640 +1100
@@ -90,6 +90,8 @@
 			complete_and_exit(&krxtimod_dead, 0);
 		}
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruN 582-refrigerator-old/net/sunrpc/sched.c 582-refrigerator-new/net/sunrpc/sched.c
--- 582-refrigerator-old/net/sunrpc/sched.c	2004-11-03 21:53:47.000000000 +1100
+++ 582-refrigerator-new/net/sunrpc/sched.c	2004-11-24 17:56:07.316012992 +1100
@@ -18,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
-#include <linux/suspend.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
diff -ruN 582-refrigerator-old/net/sunrpc/svcsock.c 582-refrigerator-new/net/sunrpc/svcsock.c
--- 582-refrigerator-old/net/sunrpc/svcsock.c	2004-11-03 21:51:16.000000000 +1100
+++ 582-refrigerator-new/net/sunrpc/svcsock.c	2004-11-24 17:56:07.324011776 +1100
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/suspend.h>
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -1187,6 +1186,7 @@
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 	
+	try_to_freeze(PF_FREEZE);
 	if (signalled())
 		return -EINTR;
 
@@ -1227,8 +1227,7 @@
 
 		schedule_timeout(timeout);
 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);


