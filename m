Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUDSHIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 03:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDSHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 03:08:23 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:24758 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263604AbUDSHHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 03:07:48 -0400
Subject: [PATCH] Rename PF_IOTHREAD.
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082357671.2620.10.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Mon, 19 Apr 2004 16:54:31 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A few weeks ago, Pavel and I agreed that PF_IOTHREAD should be renamed
to PF_NOFREEZE. This reflects the fact that some threads so marked
aren't actually used for IO while suspending, but simply shouldn't be
frozen. This patch, against 2.6.5 vanilla, applies that change. In the
refrigerator calls, the actual value doesn't matter (so long as it's
non-zero) and it makes more sense to use PF_FREEZE so I've used that.

Please apply.

Nigel

diff -ruN linux-2.6.5/arch/i386/kernel/apm.c linux-2.6.5-NoFreeze/arch/i386/kernel/apm.c
--- linux-2.6.5/arch/i386/kernel/apm.c	2004-04-17 03:20:58.000000000 +1000
+++ linux-2.6.5-NoFreeze/arch/i386/kernel/apm.c	2004-04-19 16:37:30.000000000 +1000
@@ -1701,7 +1701,7 @@
 
 	daemonize("kapmd");
 
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 #ifdef CONFIG_SMP
 	/* 2002/08/01 - WT
diff -ruN linux-2.6.5/drivers/block/loop.c linux-2.6.5-NoFreeze/drivers/block/loop.c
--- linux-2.6.5/drivers/block/loop.c	2004-04-17 03:21:04.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/block/loop.c	2004-04-19 16:42:24.000000000 +1000
@@ -472,7 +472,7 @@
 	 * hence, it mustn't be stopped at all
 	 * because it could be indirectly used during suspension
 	 */
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	set_user_nice(current, -20);
 
diff -ruN linux-2.6.5/drivers/input/serio/serio.c linux-2.6.5-NoFreeze/drivers/input/serio/serio.c
--- linux-2.6.5/drivers/input/serio/serio.c	2004-04-17 03:21:05.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/input/serio/serio.c	2004-04-19 16:44:21.000000000 +1000
@@ -154,7 +154,7 @@
 		serio_handle_events();
 		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list)); 
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
diff -ruN linux-2.6.5/drivers/md/md.c linux-2.6.5-NoFreeze/drivers/md/md.c
--- linux-2.6.5/drivers/md/md.c	2004-04-17 03:21:06.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/md/md.c	2004-04-19 16:44:45.000000000 +1000
@@ -2711,7 +2711,7 @@
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
diff -ruN linux-2.6.5/drivers/net/8139too.c linux-2.6.5-NoFreeze/drivers/net/8139too.c
--- linux-2.6.5/drivers/net/8139too.c	2004-04-17 03:21:07.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/net/8139too.c	2004-04-19 16:39:00.000000000 +1000
@@ -1619,7 +1619,7 @@
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
 			/* make swsusp happy with our thread */
 			if (current->flags & PF_FREEZE)
-				refrigerator(PF_IOTHREAD);
+				refrigerator(PF_FREEZE);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
diff -ruN linux-2.6.5/drivers/net/irda/sir_kthread.c linux-2.6.5-NoFreeze/drivers/net/irda/sir_kthread.c
--- linux-2.6.5/drivers/net/irda/sir_kthread.c	2004-02-06 15:27:33.000000000 +1100
+++ linux-2.6.5-NoFreeze/drivers/net/irda/sir_kthread.c	2004-04-19 16:40:12.000000000 +1000
@@ -137,7 +137,7 @@
 
 		/* make swsusp happy with our thread */
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		run_irda_queue();
 	}
diff -ruN linux-2.6.5/drivers/net/irda/stir4200.c linux-2.6.5-NoFreeze/drivers/net/irda/stir4200.c
--- linux-2.6.5/drivers/net/irda/stir4200.c	2004-03-16 09:20:03.000000000 +1100
+++ linux-2.6.5-NoFreeze/drivers/net/irda/stir4200.c	2004-04-19 16:40:32.000000000 +1000
@@ -774,7 +774,7 @@
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 			if (change_speed(stir, stir->speed))
 				break;
diff -ruN linux-2.6.5/drivers/net/wireless/airo.c linux-2.6.5-NoFreeze/drivers/net/wireless/airo.c
--- linux-2.6.5/drivers/net/wireless/airo.c	2004-04-17 03:21:09.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/net/wireless/airo.c	2004-04-19 16:39:48.000000000 +1000
@@ -2883,7 +2883,7 @@
 
 		/* make swsusp happy with our thread */
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		if (test_bit(JOB_DIE, &ai->flags))
 			break;
diff -ruN linux-2.6.5/drivers/pcmcia/cs.c linux-2.6.5-NoFreeze/drivers/pcmcia/cs.c
--- linux-2.6.5/drivers/pcmcia/cs.c	2004-04-17 03:21:10.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/pcmcia/cs.c	2004-04-19 16:44:33.000000000 +1000
@@ -720,7 +720,7 @@
 
 		schedule();
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		if (!skt->thread)
 			break;
diff -ruN linux-2.6.5/drivers/scsi/libata-core.c linux-2.6.5-NoFreeze/drivers/scsi/libata-core.c
--- linux-2.6.5/drivers/scsi/libata-core.c	2004-04-17 03:21:11.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/scsi/libata-core.c	2004-04-19 16:41:09.000000000 +1000
@@ -2629,7 +2629,7 @@
                         flush_signals(current);
                         
                 if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
                                                         
 
                 if ((timeout < 0) || (ap->time_to_die))
diff -ruN linux-2.6.5/drivers/scsi/scsi_error.c linux-2.6.5-NoFreeze/drivers/scsi/scsi_error.c
--- linux-2.6.5/drivers/scsi/scsi_error.c	2004-04-17 03:21:11.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/scsi/scsi_error.c	2004-04-19 16:41:33.000000000 +1000
@@ -1620,7 +1620,7 @@
 
 	daemonize("scsi_eh_%d", shost->host_no);
 
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	shost->eh_wait = &sem;
 	shost->ehandler = current;
diff -ruN linux-2.6.5/drivers/usb/core/hub.c linux-2.6.5-NoFreeze/drivers/usb/core/hub.c
--- linux-2.6.5/drivers/usb/core/hub.c	2004-04-17 03:21:16.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/usb/core/hub.c	2004-04-19 16:44:08.000000000 +1000
@@ -1142,7 +1142,7 @@
 		hub_events();
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 	} while (!signal_pending(current));
 
 	dbg("hub_thread exiting");
diff -ruN linux-2.6.5/drivers/usb/storage/usb.c linux-2.6.5-NoFreeze/drivers/usb/storage/usb.c
--- linux-2.6.5/drivers/usb/storage/usb.c	2004-04-17 03:21:19.000000000 +1000
+++ linux-2.6.5-NoFreeze/drivers/usb/storage/usb.c	2004-04-19 16:41:57.000000000 +1000
@@ -277,7 +277,7 @@
 	 */
 	daemonize("usb-storage");
 
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	unlock_kernel();
 
diff -ruN linux-2.6.5/fs/jbd/journal.c linux-2.6.5-NoFreeze/fs/jbd/journal.c
--- linux-2.6.5/fs/jbd/journal.c	2004-01-13 14:17:40.000000000 +1100
+++ linux-2.6.5-NoFreeze/fs/jbd/journal.c	2004-04-19 16:47:00.000000000 +1000
@@ -172,7 +172,7 @@
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
 		spin_unlock(&journal->j_state_lock);
-		refrigerator(PF_IOTHREAD);
+		refrigerator(PF_FREEZE);
 		spin_lock(&journal->j_state_lock);
 	} else {
 		/*
diff -ruN linux-2.6.5/fs/jfs/jfs_logmgr.c linux-2.6.5-NoFreeze/fs/jfs/jfs_logmgr.c
--- linux-2.6.5/fs/jfs/jfs_logmgr.c	2004-04-17 03:21:20.000000000 +1000
+++ linux-2.6.5-NoFreeze/fs/jfs/jfs_logmgr.c	2004-04-19 16:46:14.000000000 +1000
@@ -2330,7 +2330,7 @@
 		}
 		if (current->flags & PF_FREEZE) {
 			spin_unlock_irq(&log_redrive_lock);
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 		} else {
 			add_wait_queue(&jfs_IO_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
diff -ruN linux-2.6.5/fs/jfs/jfs_txnmgr.c linux-2.6.5-NoFreeze/fs/jfs/jfs_txnmgr.c
--- linux-2.6.5/fs/jfs/jfs_txnmgr.c	2004-04-17 03:21:20.000000000 +1000
+++ linux-2.6.5-NoFreeze/fs/jfs/jfs_txnmgr.c	2004-04-19 16:46:39.000000000 +1000
@@ -2813,7 +2813,7 @@
 
 		if (current->flags & PF_FREEZE) {
 			LAZY_UNLOCK(flags);
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
@@ -3017,7 +3017,7 @@
 
 		if (current->flags & PF_FREEZE) {
 			TXN_UNLOCK();
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
diff -ruN linux-2.6.5/fs/xfs/linux/xfs_buf.c linux-2.6.5-NoFreeze/fs/xfs/linux/xfs_buf.c
--- linux-2.6.5/fs/xfs/linux/xfs_buf.c	2004-03-16 09:20:14.000000000 +1100
+++ linux-2.6.5-NoFreeze/fs/xfs/linux/xfs_buf.c	2004-04-19 16:45:54.000000000 +1000
@@ -1633,7 +1633,7 @@
 	do {
 		/* swsusp */
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(xfs_flush_interval);
diff -ruN linux-2.6.5/fs/xfs/linux/xfs_super.c linux-2.6.5-NoFreeze/fs/xfs/linux/xfs_super.c
--- linux-2.6.5/fs/xfs/linux/xfs_super.c	2004-03-16 09:20:14.000000000 +1100
+++ linux-2.6.5-NoFreeze/fs/xfs/linux/xfs_super.c	2004-04-19 16:45:36.000000000 +1000
@@ -464,7 +464,7 @@
 		schedule_timeout(xfs_syncd_interval);
 		/* swsusp */
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 		if (vfsp->vfs_flag & VFS_RDONLY)
diff -ruN linux-2.6.5/include/linux/sched.h linux-2.6.5-NoFreeze/include/linux/sched.h
--- linux-2.6.5/include/linux/sched.h	2004-04-17 03:21:25.000000000 +1000
+++ linux-2.6.5-NoFreeze/include/linux/sched.h	2004-04-19 16:38:34.000000000 +1000
@@ -522,7 +522,7 @@
 #define PF_FLUSHER	0x00002000	/* responsible for disk writeback */
 
 #define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
-#define PF_IOTHREAD	0x00008000	/* this thread is needed for doing I/O to swap */
+#define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
diff -ruN linux-2.6.5/kernel/power/process.c linux-2.6.5-NoFreeze/kernel/power/process.c
--- linux-2.6.5/kernel/power/process.c	2004-01-13 14:16:35.000000000 +1100
+++ linux-2.6.5-NoFreeze/kernel/power/process.c	2004-04-19 16:47:24.000000000 +1000
@@ -28,7 +28,7 @@
 static inline int freezeable(struct task_struct * p)
 {
 	if ((p == current) || 
-	    (p->flags & PF_IOTHREAD) || 
+	    (p->flags & PF_NOFREEZE) || 
 	    (p->state == TASK_ZOMBIE) ||
 	    (p->state == TASK_DEAD))
 		return 0;
diff -ruN linux-2.6.5/kernel/sched.c linux-2.6.5-NoFreeze/kernel/sched.c
--- linux-2.6.5/kernel/sched.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/kernel/sched.c	2004-04-19 16:47:36.000000000 +1000
@@ -2778,7 +2778,7 @@
 		migration_req_t *req;
 
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		spin_lock_irq(&rq->lock);
 		head = &rq->migration_queue;
diff -ruN linux-2.6.5/kernel/softirq.c linux-2.6.5-NoFreeze/kernel/softirq.c
--- linux-2.6.5/kernel/softirq.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/kernel/softirq.c	2004-04-19 16:43:24.000000000 +1000
@@ -309,7 +309,7 @@
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
diff -ruN linux-2.6.5/kernel/workqueue.c linux-2.6.5-NoFreeze/kernel/workqueue.c
--- linux-2.6.5/kernel/workqueue.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/kernel/workqueue.c	2004-04-19 16:43:39.000000000 +1000
@@ -181,7 +181,7 @@
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	set_user_nice(current, -10);
 
diff -ruN linux-2.6.5/mm/pdflush.c linux-2.6.5-NoFreeze/mm/pdflush.c
--- linux-2.6.5/mm/pdflush.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/mm/pdflush.c	2004-04-19 16:48:07.000000000 +1000
@@ -107,7 +107,7 @@
 
 		schedule();
 		if (current->flags & PF_FREEZE) {
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
diff -ruN linux-2.6.5/mm/vmscan.c linux-2.6.5-NoFreeze/mm/vmscan.c
--- linux-2.6.5/mm/vmscan.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/mm/vmscan.c	2004-04-19 16:47:54.000000000 +1000
@@ -1052,7 +1052,7 @@
 		struct page_state ps;
 
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
diff -ruN linux-2.6.5/net/bluetooth/bnep/core.c linux-2.6.5-NoFreeze/net/bluetooth/bnep/core.c
--- linux-2.6.5/net/bluetooth/bnep/core.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/net/bluetooth/bnep/core.c	2004-04-19 16:42:58.000000000 +1000
@@ -458,7 +458,7 @@
 
         daemonize("kbnepd %s", dev->name);
 	set_user_nice(current, -15);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
         set_fs(KERNEL_DS);
 
diff -ruN linux-2.6.5/net/bluetooth/cmtp/core.c linux-2.6.5-NoFreeze/net/bluetooth/cmtp/core.c
--- linux-2.6.5/net/bluetooth/cmtp/core.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/net/bluetooth/cmtp/core.c	2004-04-19 16:43:13.000000000 +1000
@@ -293,7 +293,7 @@
 
 	daemonize("kcmtpd_ctr_%d", session->num);
 	set_user_nice(current, -15);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	set_fs(KERNEL_DS);
 
diff -ruN linux-2.6.5/net/bluetooth/rfcomm/core.c linux-2.6.5-NoFreeze/net/bluetooth/rfcomm/core.c
--- linux-2.6.5/net/bluetooth/rfcomm/core.c	2004-04-17 03:21:26.000000000 +1000
+++ linux-2.6.5-NoFreeze/net/bluetooth/rfcomm/core.c	2004-04-19 16:42:43.000000000 +1000
@@ -1819,7 +1819,7 @@
 
 	daemonize("krfcommd");
 	set_user_nice(current, -10);
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	set_fs(KERNEL_DS);
 
diff -ruN linux-2.6.5/net/sunrpc/sched.c linux-2.6.5-NoFreeze/net/sunrpc/sched.c
--- linux-2.6.5/net/sunrpc/sched.c	2004-04-17 03:21:30.000000000 +1000
+++ linux-2.6.5-NoFreeze/net/sunrpc/sched.c	2004-04-19 16:45:16.000000000 +1000
@@ -976,7 +976,7 @@
 		}
 		__rpc_schedule();
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		if (++rounds >= 64) {	/* safeguard */
 			schedule();
diff -ruN linux-2.6.5/net/sunrpc/svcsock.c linux-2.6.5-NoFreeze/net/sunrpc/svcsock.c
--- linux-2.6.5/net/sunrpc/svcsock.c	2004-01-13 14:17:13.000000000 +1100
+++ linux-2.6.5-NoFreeze/net/sunrpc/svcsock.c	2004-04-19 16:45:05.000000000 +1000
@@ -1209,7 +1209,7 @@
 		schedule_timeout(timeout);
 
 		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+			refrigerator(PF_FREEZE);
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);


