Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVALWpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVALWpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVALWpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:45:21 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:41417 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261532AbVALWlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:41:31 -0500
Date: Wed, 12 Jan 2005 23:40:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: refrigerator cleanups
Message-ID: <20050112224039.GA2228@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is from Nigel's swsusp2, it kills ugly #include <suspend.h>
from all over the tree, and makes code slightly nicer. I only left
those parts that do not change any code, please apply.

From: Nigel Cunningham <ncunningham@linuxmail.org>
Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

diff -ruNp 582-refrigerator-old/arch/arm/kernel/signal.c 582-refrigerator-new/arch/arm/kernel/signal.c
--- 582-refrigerator-old/arch/arm/kernel/signal.c	2004-12-10 14:26:17.000000000 +1100
+++ 582-refrigerator-new/arch/arm/kernel/signal.c	2005-01-12 17:49:22.000000000 +1100
@@ -12,7 +12,6 @@
 #include <linux/signal.h>
 #include <linux/ptrace.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
 
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
@@ -689,10 +688,8 @@ static int do_signal(sigset_t *oldset, s
 	if (!user_mode(regs))
 		return 0;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (current->ptrace & PT_SINGLESTEP)
 		ptrace_cancel_bpt(current);
diff -ruNp 582-refrigerator-old/arch/mips/kernel/irixsig.c 582-refrigerator-new/arch/mips/kernel/irixsig.c
--- 582-refrigerator-old/arch/mips/kernel/irixsig.c	2005-01-12 17:06:59.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/irixsig.c	2005-01-12 17:49:22.000000000 +1100
@@ -13,7 +13,6 @@
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/ptrace.h>
-#include <linux/suspend.h>
 
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -179,10 +178,8 @@ asmlinkage int do_irix_signal(sigset_t *
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/arch/mips/kernel/signal32.c 582-refrigerator-new/arch/mips/kernel/signal32.c
--- 582-refrigerator-old/arch/mips/kernel/signal32.c	2005-01-12 17:06:59.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/signal32.c	2005-01-12 17:49:22.000000000 +1100
@@ -773,10 +773,8 @@ asmlinkage int do_signal32(sigset_t *old
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/arch/mips/kernel/signal.c 582-refrigerator-new/arch/mips/kernel/signal.c
--- 582-refrigerator-old/arch/mips/kernel/signal.c	2004-12-10 14:27:08.000000000 +1100
+++ 582-refrigerator-new/arch/mips/kernel/signal.c	2005-01-12 17:49:22.000000000 +1100
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
-#include <linux/suspend.h>
 #include <linux/unistd.h>
 #include <linux/compiler.h>
 
@@ -577,10 +576,8 @@ asmlinkage int do_signal(sigset_t *oldse
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/arch/sh/kernel/signal.c 582-refrigerator-new/arch/sh/kernel/signal.c
--- 582-refrigerator-old/arch/sh/kernel/signal.c	2004-12-10 14:26:51.000000000 +1100
+++ 582-refrigerator-new/arch/sh/kernel/signal.c	2005-01-12 17:49:22.000000000 +1100
@@ -24,7 +24,6 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
-#include <linux/suspend.h>
 
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -579,10 +578,8 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/arch/sh64/kernel/signal.c 582-refrigerator-new/arch/sh64/kernel/signal.c
--- 582-refrigerator-old/arch/sh64/kernel/signal.c	2004-11-03 21:53:44.000000000 +1100
+++ 582-refrigerator-new/arch/sh64/kernel/signal.c	2005-01-12 17:49:22.000000000 +1100
@@ -701,10 +701,8 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-		}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/arch/x86_64/kernel/signal.c 582-refrigerator-new/arch/x86_64/kernel/signal.c
--- 582-refrigerator-old/arch/x86_64/kernel/signal.c	2005-01-12 17:07:01.000000000 +1100
+++ 582-refrigerator-new/arch/x86_64/kernel/signal.c	2005-01-12 17:49:22.000000000 +1100
@@ -24,7 +24,6 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
-#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -423,10 +422,8 @@ int do_signal(struct pt_regs *regs, sigs
 		return 1;
 	} 	
 
-	if (current->flags & PF_FREEZE) {
-		refrigerator(0);
+	if (try_to_freeze(0))
 		goto no_signal;
-	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -ruNp 582-refrigerator-old/drivers/ieee1394/nodemgr.c 582-refrigerator-new/drivers/ieee1394/nodemgr.c
--- 582-refrigerator-old/drivers/ieee1394/nodemgr.c	2004-12-10 14:26:52.000000000 +1100
+++ 582-refrigerator-new/drivers/ieee1394/nodemgr.c	2005-01-12 17:49:22.000000000 +1100
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
-#include <linux/suspend.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -1480,10 +1479,8 @@ static int nodemgr_host_thread(void *__h
 
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
diff -ruNp 582-refrigerator-old/drivers/input/serio/serio.c 582-refrigerator-new/drivers/input/serio/serio.c
--- 582-refrigerator-old/drivers/input/serio/serio.c	2005-01-12 17:07:03.000000000 +1100
+++ 582-refrigerator-new/drivers/input/serio/serio.c	2005-01-12 17:49:22.000000000 +1100
@@ -34,7 +34,6 @@
 #include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
-#include <linux/suspend.h>
 #include <linux/slab.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -225,8 +224,7 @@ static int serio_thread(void *nothing)
 	do {
 		serio_handle_events();
 		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list));
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
diff -ruNp 582-refrigerator-old/drivers/net/8139too.c 582-refrigerator-new/drivers/net/8139too.c
--- 582-refrigerator-old/drivers/net/8139too.c	2005-01-12 17:07:04.000000000 +1100
+++ 582-refrigerator-new/drivers/net/8139too.c	2005-01-12 17:49:22.000000000 +1100
@@ -108,7 +108,6 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <linux/crc32.h>
-#include <linux/suspend.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
@@ -1625,8 +1624,7 @@ static int rtl8139_thread (void *data)
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
 			/* make swsusp happy with our thread */
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
diff -ruNp 582-refrigerator-old/drivers/net/irda/sir_kthread.c 582-refrigerator-new/drivers/net/irda/sir_kthread.c
--- 582-refrigerator-old/drivers/net/irda/sir_kthread.c	2004-11-03 21:55:05.000000000 +1100
+++ 582-refrigerator-new/drivers/net/irda/sir_kthread.c	2005-01-12 17:49:22.000000000 +1100
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/suspend.h>
 
 #include <net/irda/irda.h>
 
diff -ruNp 582-refrigerator-old/drivers/net/irda/stir4200.c 582-refrigerator-new/drivers/net/irda/stir4200.c
--- 582-refrigerator-old/drivers/net/irda/stir4200.c	2005-01-12 17:07:05.000000000 +1100
+++ 582-refrigerator-new/drivers/net/irda/stir4200.c	2005-01-12 17:49:22.000000000 +1100
@@ -46,7 +46,6 @@
 #include <linux/time.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/suspend.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/usb.h>
diff -ruNp 582-refrigerator-old/drivers/net/wireless/airo.c 582-refrigerator-new/drivers/net/wireless/airo.c
--- 582-refrigerator-old/drivers/net/wireless/airo.c	2005-01-12 17:07:06.000000000 +1100
+++ 582-refrigerator-new/drivers/net/wireless/airo.c	2005-01-12 17:49:22.000000000 +1100
@@ -33,7 +33,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
-#include <linux/suspend.h>
 #include <linux/in.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
@@ -2918,8 +2917,7 @@ static int airo_thread(void *data) {
 			flush_signals(current);
 
 		/* make swsusp happy with our thread */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		if (test_bit(JOB_DIE, &ai->flags))
 			break;
diff -ruNp 582-refrigerator-old/drivers/pcmcia/cs.c 582-refrigerator-new/drivers/pcmcia/cs.c
--- 582-refrigerator-old/drivers/pcmcia/cs.c	2005-01-12 17:07:07.000000000 +1100
+++ 582-refrigerator-new/drivers/pcmcia/cs.c	2005-01-12 17:49:22.000000000 +1100
@@ -29,7 +29,6 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/suspend.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -711,8 +710,7 @@ static int pccardd(void *__skt)
 		}
 
 		schedule();
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		if (!skt->thread)
 			break;
diff -ruNp 582-refrigerator-old/drivers/pcmcia/socket_sysfs.c 582-refrigerator-new/drivers/pcmcia/socket_sysfs.c
--- 582-refrigerator-old/drivers/pcmcia/socket_sysfs.c	2004-11-03 21:51:32.000000000 +1100
+++ 582-refrigerator-new/drivers/pcmcia/socket_sysfs.c	2005-01-12 17:49:22.000000000 +1100
@@ -25,7 +25,6 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/suspend.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
diff -ruNp 582-refrigerator-old/drivers/usb/core/hub.c 582-refrigerator-new/drivers/usb/core/hub.c
--- 582-refrigerator-old/drivers/usb/core/hub.c	2005-01-12 17:07:08.000000000 +1100
+++ 582-refrigerator-new/drivers/usb/core/hub.c	2005-01-12 17:49:22.000000000 +1100
@@ -26,7 +26,6 @@
 #include <linux/ioctl.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
-#include <linux/suspend.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -2748,8 +2747,7 @@ static int hub_thread(void *__unused)
 	do {
 		hub_events();
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	pr_debug ("%s: khubd exiting\n", usbcore_name);
diff -ruNp 582-refrigerator-old/drivers/w1/w1.c 582-refrigerator-new/drivers/w1/w1.c
--- 582-refrigerator-old/drivers/w1/w1.c	2004-12-10 14:26:55.000000000 +1100
+++ 582-refrigerator-new/drivers/w1/w1.c	2005-01-12 17:49:22.000000000 +1100
@@ -32,7 +32,6 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/suspend.h>
 
 #include "w1.h"
 #include "w1_io.h"
@@ -628,8 +627,7 @@ int w1_control(void *data)
 		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&w1_control_wait, timeout);
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending(current) && (timeout > 0));
 
 		if (signal_pending(current))
@@ -701,8 +699,7 @@ int w1_process(void *data)
 		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&dev->kwait, timeout);
-			if (current->flags & PF_FREEZE)
-				refrigerator(PF_FREEZE);
+			try_to_freeze(PF_FREEZE);
 		} while (!signal_pending(current) && (timeout > 0));
 
 		if (signal_pending(current))
diff -ruNp 582-refrigerator-old/fs/jffs2/background.c 582-refrigerator-new/fs/jffs2/background.c
--- 582-refrigerator-old/fs/jffs2/background.c	2005-01-12 17:07:10.000000000 +1100
+++ 582-refrigerator-new/fs/jffs2/background.c	2005-01-12 17:49:22.000000000 +1100
@@ -15,7 +15,6 @@
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include "nodelist.h"
 
 
@@ -93,12 +92,8 @@ static int jffs2_garbage_collect_thread(
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
 
diff -ruNp 582-refrigerator-old/fs/reiserfs/journal.c 582-refrigerator-new/fs/reiserfs/journal.c
--- 582-refrigerator-old/fs/reiserfs/journal.c	2005-01-12 21:09:02.046118352 +1100
+++ 582-refrigerator-new/fs/reiserfs/journal.c	2005-01-12 17:49:22.000000000 +1100
@@ -50,7 +50,6 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/suspend.h>
 #include <linux/buffer_head.h>
 #include <linux/workqueue.h>
 #include <linux/writeback.h>
diff -ruNp 582-refrigerator-old/fs/xfs/linux-2.6/xfs_buf.c 582-refrigerator-new/fs/xfs/linux-2.6/xfs_buf.c
--- 582-refrigerator-old/fs/xfs/linux-2.6/xfs_buf.c	2005-01-12 21:09:02.051117592 +1100
+++ 582-refrigerator-new/fs/xfs/linux-2.6/xfs_buf.c	2005-01-12 17:49:22.000000000 +1100
@@ -51,7 +51,6 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
-#include <linux/suspend.h>
 #include <linux/percpu.h>
 #include <linux/blkdev.h>
 
@@ -1685,9 +1684,7 @@ pagebuf_daemon(
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		/* swsusp */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout((xfs_buf_timer_centisecs * HZ) / 100);
diff -ruNp 582-refrigerator-old/fs/xfs/linux-2.6/xfs_super.c 582-refrigerator-new/fs/xfs/linux-2.6/xfs_super.c
--- 582-refrigerator-old/fs/xfs/linux-2.6/xfs_super.c	2005-01-12 17:07:12.000000000 +1100
+++ 582-refrigerator-new/fs/xfs/linux-2.6/xfs_super.c	2005-01-12 17:49:22.000000000 +1100
@@ -71,7 +71,6 @@
 #include <linux/namei.h>
 #include <linux/init.h>
 #include <linux/mount.h>
-#include <linux/suspend.h>
 #include <linux/writeback.h>
 
 STATIC struct quotactl_ops linvfs_qops;
@@ -489,8 +489,7 @@ xfssyncd(
 		set_current_state(TASK_INTERRUPTIBLE);
 		timeleft = schedule_timeout(timeleft);
 		/* swsusp */
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 
diff -ruNp 582-refrigerator-old/include/linux/sched.h 582-refrigerator-new/include/linux/sched.h
--- 582-refrigerator-old/include/linux/sched.h	2005-01-12 21:09:01.862146320 +1100
+++ 582-refrigerator-new/include/linux/sched.h	2005-01-12 17:51:01.000000000 +1100
@@ -735,7 +735,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
 
-#define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
+#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
diff -ruNp 582-refrigerator-old/mm/pdflush.c 582-refrigerator-new/mm/pdflush.c
--- 582-refrigerator-old/mm/pdflush.c	2005-01-12 21:09:02.067115160 +1100
+++ 582-refrigerator-new/mm/pdflush.c	2005-01-12 17:49:23.000000000 +1100
@@ -17,7 +17,6 @@
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/suspend.h>
 #include <linux/fs.h>		// Needed by writeback.h
 #include <linux/writeback.h>	// Prototypes pdflush_operation()
 #include <linux/kthread.h>
@@ -106,8 +105,7 @@ static int __pdflush(struct pdflush_work
 		spin_unlock_irq(&pdflush_lock);
 
 		schedule();
-		if (current->flags & PF_FREEZE) {
-			refrigerator(PF_FREEZE);
+		if (try_to_freeze(PF_FREEZE)) {
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
diff -ruNp 582-refrigerator-old/mm/vmscan.c 582-refrigerator-new/mm/vmscan.c
--- 582-refrigerator-old/mm/vmscan.c	2005-01-12 21:09:02.217092360 +1100
+++ 582-refrigerator-new/mm/vmscan.c	2005-01-12 17:49:23.000000000 +1100
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/writeback.h>
-#include <linux/suspend.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
 					buffer_heads_over_limit */
diff -ruNp 582-refrigerator-old/net/sunrpc/sched.c 582-refrigerator-new/net/sunrpc/sched.c
--- 582-refrigerator-old/net/sunrpc/sched.c	2005-01-12 17:07:17.000000000 +1100
+++ 582-refrigerator-new/net/sunrpc/sched.c	2005-01-12 17:49:23.000000000 +1100
@@ -18,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
-#include <linux/suspend.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
diff -ruNp 582-refrigerator-old/net/sunrpc/svcsock.c 582-refrigerator-new/net/sunrpc/svcsock.c
--- 582-refrigerator-old/net/sunrpc/svcsock.c	2005-01-12 17:07:17.000000000 +1100
+++ 582-refrigerator-new/net/sunrpc/svcsock.c	2005-01-12 17:49:23.000000000 +1100
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/suspend.h>
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -1227,8 +1227,7 @@ svc_recv(struct svc_serv *serv, struct s
 
 		schedule_timeout(timeout);
 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
+		try_to_freeze(PF_FREEZE);
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
