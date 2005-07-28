Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVG1UCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVG1UCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1UAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:00:10 -0400
Received: from graphe.net ([209.204.138.32]:64745 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261566AbVG1T7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:59:12 -0400
Date: Thu, 28 Jul 2005 12:59:08 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Task notifier: s/try_to_freeze/try_todo_list/ in some
 drivers [optional]
In-Reply-To: <Pine.LNX.4.62.0507281256070.12781@graphe.net>
Message-ID: <Pine.LNX.4.62.0507281257380.12781@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
 <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net>
 <Pine.LNX.4.62.0507281256070.12781@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to replace try_to_freeze with try_todo_list 

Replaces:

try_to_freeze -> try_todo_list
freezing -> todo_listactive
refrigerator -> run_todo_list

This patch is incomplete. Drivers may continue using try_to_freeze, freezing
and refrigerators since the above mapping is also provided by macros in
include/linux/sched.h.

At some point--when all drivers have been changed--the macros in include/linux/sched.h
may be removed.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/block/pktcdvd.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/block/pktcdvd.c	2005-07-28 12:45:13.000000000 -0700
@@ -1250,8 +1250,7 @@
 			residue = schedule_timeout(min_sleep_time);
 			VPRINTK("kcdrwd: wake up\n");
 
-			/* make swsusp happy with our thread */
-			try_to_freeze();
+			try_todo_list();
 
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
 				if (!pkt->sleep_time)
Index: linux-2.6.13-rc3/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/ieee1394/ieee1394_core.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/ieee1394/ieee1394_core.c	2005-07-28 12:45:13.000000000 -0700
@@ -1044,7 +1044,7 @@
 
 	while (1) {
 		if (down_interruptible(&khpsbpkt_sig)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			printk("khpsbpkt: received unexpected signal?!\n" );
 			break;
Index: linux-2.6.13-rc3/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/ieee1394/nodemgr.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/ieee1394/nodemgr.c	2005-07-28 12:45:13.000000000 -0700
@@ -1510,7 +1510,7 @@
 
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
 			break;
Index: linux-2.6.13-rc3/drivers/input/gameport/gameport.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/input/gameport/gameport.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/input/gameport/gameport.c	2005-07-28 12:45:13.000000000 -0700
@@ -435,7 +435,7 @@
 		gameport_handle_events();
 		wait_event_interruptible(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
Index: linux-2.6.13-rc3/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/input/serio/serio.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/input/serio/serio.c	2005-07-28 12:45:13.000000000 -0700
@@ -371,7 +371,7 @@
 		serio_handle_events();
 		wait_event_interruptible(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
Index: linux-2.6.13-rc3/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-07-28 12:45:13.000000000 -0700
@@ -394,7 +394,7 @@
 			break;
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		if (down_interruptible(&fepriv->sem))
 			break;
Index: linux-2.6.13-rc3/drivers/net/irda/stir4200.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/net/irda/stir4200.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/net/irda/stir4200.c	2005-07-28 12:45:13.000000000 -0700
@@ -763,7 +763,7 @@
 	{
 #ifdef CONFIG_PM
 		/* if suspending, then power off and wait */
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active())) {
 			if (stir->receiving)
 				receive_stop(stir);
 			else
@@ -771,7 +771,7 @@
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			refrigerator();
+			run_todo_list();
 
 			if (change_speed(stir, stir->speed))
 				break;
Index: linux-2.6.13-rc3/drivers/pcmcia/cs.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/pcmcia/cs.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/pcmcia/cs.c	2005-07-28 12:45:14.000000000 -0700
@@ -683,7 +683,7 @@
 		}
 
 		schedule();
-		try_to_freeze();
+		try_todo_list();
 
 		if (!skt->thread)
 			break;
Index: linux-2.6.13-rc3/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/usb/core/hub.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/usb/core/hub.c	2005-07-28 12:45:14.000000000 -0700
@@ -2812,7 +2812,7 @@
 		wait_event_interruptible(khubd_wait,
 				!list_empty(&hub_event_list) ||
 				kthread_should_stop());
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
 	pr_debug("%s: khubd exiting\n", usbcore_name);
Index: linux-2.6.13-rc3/drivers/usb/storage/usb.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/usb/storage/usb.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/usb/storage/usb.c	2005-07-28 12:45:14.000000000 -0700
@@ -847,7 +847,7 @@
 		wait_event_interruptible_timeout(us->delay_wait,
 				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
 				delay_use * HZ);
-		if (try_to_freeze())
+		if (try_todo_list())
 			goto retry;
 	}
 
Index: linux-2.6.13-rc3/fs/afs/kafsasyncd.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/afs/kafsasyncd.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/afs/kafsasyncd.c	2005-07-28 12:45:14.000000000 -0700
@@ -116,7 +116,7 @@
 		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
Index: linux-2.6.13-rc3/fs/afs/kafstimod.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/afs/kafstimod.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/afs/kafstimod.c	2005-07-28 12:45:14.000000000 -0700
@@ -91,7 +91,7 @@
 			complete_and_exit(&kafstimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
Index: linux-2.6.13-rc3/fs/jbd/journal.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/jbd/journal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/jbd/journal.c	2005-07-28 12:45:14.000000000 -0700
@@ -167,7 +167,7 @@
 	}
 
 	wake_up(&journal->j_wait_done_commit);
-	if (freezing(current)) {
+	if (todo_list_active()) {
 		/*
 		 * The simpler the better. Flushing journal isn't a
 		 * good idea, because that depends on threads that may
@@ -175,7 +175,7 @@
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
 		spin_unlock(&journal->j_state_lock);
-		refrigerator();
+		run_todo_list();
 		spin_lock(&journal->j_state_lock);
 	} else {
 		/*
Index: linux-2.6.13-rc3/fs/jfs/jfs_logmgr.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/jfs/jfs_logmgr.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/jfs/jfs_logmgr.c	2005-07-28 12:45:14.000000000 -0700
@@ -2359,9 +2359,9 @@
 			lbmStartIO(bp);
 			spin_lock_irq(&log_redrive_lock);
 		}
-		if (freezing(current)) {
+		if (todo_list_active()) {
 			spin_unlock_irq(&log_redrive_lock);
-			refrigerator();
+			run_todo_list();
 		} else {
 			add_wait_queue(&jfs_IO_thread_wait, &wq);
 			set_current_state(TASK_INTERRUPTIBLE);
Index: linux-2.6.13-rc3/fs/lockd/clntproc.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/lockd/clntproc.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/lockd/clntproc.c	2005-07-28 12:45:14.000000000 -0700
@@ -313,7 +313,7 @@
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
-		try_to_freeze();
+		try_todo_list();
 		if (!signalled ())
 			status = 0;
 	}
Index: linux-2.6.13-rc3/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/xfs/linux-2.6/xfs_buf.c	2005-07-28 12:45:14.000000000 -0700
@@ -1771,9 +1771,9 @@
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active())) {
 			xfsbufd_force_sleep = 1;
-			refrigerator();
+			run_todo_list();
 		} else {
 			xfsbufd_force_sleep = 0;
 		}
Index: linux-2.6.13-rc3/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.13-rc3.orig/fs/xfs/linux-2.6/xfs_super.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/fs/xfs/linux-2.6/xfs_super.c	2005-07-28 12:45:14.000000000 -0700
@@ -482,8 +482,8 @@
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		timeleft = schedule_timeout(timeleft);
-		/* swsusp */
-		try_to_freeze();
+
+		try_todo_list();
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 
Index: linux-2.6.13-rc3/kernel/sched.c
===================================================================
--- linux-2.6.13-rc3.orig/kernel/sched.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/kernel/sched.c	2005-07-28 12:45:14.000000000 -0700
@@ -4341,7 +4341,7 @@
 		struct list_head *head;
 		migration_req_t *req;
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_irq(&rq->lock);
 
Index: linux-2.6.13-rc3/mm/pdflush.c
===================================================================
--- linux-2.6.13-rc3.orig/mm/pdflush.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/mm/pdflush.c	2005-07-28 12:45:14.000000000 -0700
@@ -105,7 +105,7 @@
 		spin_unlock_irq(&pdflush_lock);
 
 		schedule();
-		if (try_to_freeze()) {
+		if (try_todo_list()) {
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
Index: linux-2.6.13-rc3/mm/vmscan.c
===================================================================
--- linux-2.6.13-rc3.orig/mm/vmscan.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/mm/vmscan.c	2005-07-28 12:45:14.000000000 -0700
@@ -1217,7 +1217,7 @@
 	for ( ; ; ) {
 		unsigned long new_order;
 
-		try_to_freeze();
+		try_todo_list();
 
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;
Index: linux-2.6.13-rc3/net/rxrpc/krxiod.c
===================================================================
--- linux-2.6.13-rc3.orig/net/rxrpc/krxiod.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/net/rxrpc/krxiod.c	2005-07-28 12:45:14.000000000 -0700
@@ -138,7 +138,7 @@
 
 		_debug("### End Work");
 
-		try_to_freeze();
+		try_todo_list();
 
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
Index: linux-2.6.13-rc3/net/rxrpc/krxtimod.c
===================================================================
--- linux-2.6.13-rc3.orig/net/rxrpc/krxtimod.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/net/rxrpc/krxtimod.c	2005-07-28 12:45:14.000000000 -0700
@@ -90,7 +90,7 @@
 			complete_and_exit(&krxtimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		rxrpc_discard_my_signals();
Index: linux-2.6.13-rc3/net/sunrpc/svcsock.c
===================================================================
--- linux-2.6.13-rc3.orig/net/sunrpc/svcsock.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/net/sunrpc/svcsock.c	2005-07-28 12:45:14.000000000 -0700
@@ -1186,7 +1186,7 @@
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 
-	try_to_freeze();
+	try_todo_list();
 	if (signalled())
 		return -EINTR;
 
@@ -1227,7 +1227,7 @@
 
 		schedule_timeout(timeout);
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);
Index: linux-2.6.13-rc3/drivers/net/8139too.c
===================================================================
--- linux-2.6.13-rc3.orig/drivers/net/8139too.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/drivers/net/8139too.c	2005-07-28 12:45:14.000000000 -0700
@@ -1605,8 +1605,7 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
-			/* make swsusp happy with our thread */
-			try_to_freeze();
+			try_todo_list();
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
