Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUG1HyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUG1HyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUG1HvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:51:08 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:15778 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266824AbUG1H3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:29:47 -0400
Subject: [PATCH] Add missing refrigerator support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090999347.8316.15.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 28 Jul 2004 17:23:01 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Some kernel threads currently lack refrigerator support. This patch
fills in the gaps.

Regards,

Nigel

diff -ruN linux-2.6.8-rc1-mm1/arch/i386/kernel/io_apic.c software-suspend-linux-2.6.8-rc1-mm1-rev1/arch/i386/kernel/io_apic.c
--- linux-2.6.8-rc1-mm1/arch/i386/kernel/io_apic.c	2004-07-27 20:29:34.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/arch/i386/kernel/io_apic.c	2004-07-27 23:48:47.542517776 +1000
@@ -571,6 +573,8 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			do_irq_balance();
diff -ruN linux-2.6.8-rc1-mm1/drivers/char/hvc_console.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/char/hvc_console.c
--- linux-2.6.8-rc1-mm1/drivers/char/hvc_console.c	2004-04-17 03:21:04.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/char/hvc_console.c	2004-07-27 23:48:47.570513520 +1000
@@ -270,6 +270,7 @@
 	int i;
 
 	daemonize("khvcd");
+	current->flags |= PF_NOFREEZE;
 
 	for (;;) {
 		if (cpus_empty(cpus_in_xmon)) {
diff -ruN linux-2.6.8-rc1-mm1/drivers/ieee1394/nodemgr.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/ieee1394/nodemgr.c
--- linux-2.6.8-rc1-mm1/drivers/ieee1394/nodemgr.c	2004-07-27 20:29:37.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/ieee1394/nodemgr.c	2004-07-27 23:48:47.575512760 +1000
@@ -1482,7 +1481,7 @@
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
 			if (current->flags & PF_FREEZE) {
-				refrigerator(0);
+				refrigerator(PF_FREEZE);
 				continue;
 			}
 			printk("NodeMgr: received unexpected signal?!\n" );
@@ -1497,6 +1496,10 @@
 		for (i = 0; i < 4 ; i++) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (schedule_timeout(HZ/16)) {
+				if (current->flags & PF_FREEZE) {
+					refrigerator(PF_FREEZE);
+					continue;
+				}
 				up(&nodemgr_serialize);
 				goto caught_signal;
 			}
diff -ruN linux-2.6.8-rc1-mm1/drivers/md/md.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/md/md.c
--- linux-2.6.8-rc1-mm1/drivers/md/md.c	2004-07-27 20:30:36.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/md/md.c	2004-07-27 23:48:47.582511696 +1000
@@ -2832,6 +2831,7 @@
 	 */
 
 	daemonize(thread->name, mdname(thread->mddev));
+	current->flags |= PF_NOFREEZE;
 
 	current->exit_signal = SIGCHLD;
 	allow_signal(SIGKILL);
@@ -2856,8 +2856,6 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
diff -ruN linux-2.6.8-rc1-mm1/drivers/media/video/msp3400.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/media/video/msp3400.c
--- linux-2.6.8-rc1-mm1/drivers/media/video/msp3400.c	2004-07-27 20:29:39.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/media/video/msp3400.c	2004-07-27 23:48:47.583511544 +1000
@@ -738,6 +738,7 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
+again:
 	add_wait_queue(&msp->wq, &wait);
 	if (!msp->rmmod) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -747,6 +748,12 @@
 			schedule_timeout(timeout);
 	}
 	remove_wait_queue(&msp->wq, &wait);
+	
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		goto again;
+	}
+
 	return msp->rmmod || signal_pending(current);
 }
 
diff -ruN linux-2.6.8-rc1-mm1/drivers/media/video/tvaudio.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/media/video/tvaudio.c
--- linux-2.6.8-rc1-mm1/drivers/media/video/tvaudio.c	2004-06-18 12:44:02.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/media/video/tvaudio.c	2004-07-27 23:48:47.584511392 +1000
@@ -285,6 +285,8 @@
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		if (chip->done || signal_pending(current))
 			break;
 		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
diff -ruN linux-2.6.8-rc1-mm1/drivers/message/i2o/i2o_block.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/message/i2o/i2o_block.c
--- linux-2.6.8-rc1-mm1/drivers/message/i2o/i2o_block.c	2004-07-27 20:29:39.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/message/i2o/i2o_block.c	2004-07-27 23:48:47.586511088 +1000
@@ -615,6 +615,11 @@
 	{
 		if(down_interruptible(&i2ob_evt_sem))
 		{
+			if (current->flags & PF_FREEZE) {
+				refrigerator(PF_FREEZE);
+				continue;
+			}
+
 			evt_running = 0;
 			printk("exiting...");
 			break;
diff -ruN linux-2.6.8-rc1-mm1/drivers/message/i2o/i2o_core.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/message/i2o/i2o_core.c
--- linux-2.6.8-rc1-mm1/drivers/message/i2o/i2o_core.c	2004-07-27 20:29:39.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/message/i2o/i2o_core.c	2004-07-27 23:48:47.588510784 +1000
@@ -1027,6 +1027,11 @@
 	{
 		if(down_interruptible(&evt_sem))
 		{
+			if (current->flags & PF_FREEZE) {
+				refrigerator(PF_FREEZE);
+				continue;
+			}
+
 			dprintk(KERN_INFO "I2O event thread dead\n");
 			printk("exiting...");
 			evt_running = 0;
@@ -1195,6 +1200,11 @@
 		down_interruptible(&c->lct_sem);
 		if(signal_pending(current))
 		{
+			if (current->flags & PF_FREEZE) {
+				refrigerator(PF_FREEZE);
+				continue;
+			}
+
 			dprintk(KERN_ERR "%s: LCT thread dead\n", c->name);
 			c->lct_running = 0;
 			return 0;
diff -ruN linux-2.6.8-rc1-mm1/drivers/net/irda/sir_kthread.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/net/irda/sir_kthread.c
--- linux-2.6.8-rc1-mm1/drivers/net/irda/sir_kthread.c	2004-06-18 12:44:05.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/net/irda/sir_kthread.c	2004-07-27 23:48:47.589510632 +1000
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
 
diff -ruN linux-2.6.8-rc1-mm1/drivers/pnp/pnpbios/core.c software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/pnp/pnpbios/core.c
--- linux-2.6.8-rc1-mm1/drivers/pnp/pnpbios/core.c	2004-07-27 20:30:37.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/drivers/pnp/pnpbios/core.c	2004-07-27 23:48:47.591510328 +1000
@@ -179,6 +179,8 @@
 		 */
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ*2);
+		if(current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		if(signal_pending(current))
 			break;
 
diff -ruN linux-2.6.8-rc1-mm1/fs/jffs/intrep.c software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/jffs/intrep.c
--- linux-2.6.8-rc1-mm1/fs/jffs/intrep.c	2004-07-27 20:29:46.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/jffs/intrep.c	2004-07-27 23:48:47.603508504 +1000
@@ -3373,6 +3374,11 @@
 			siginfo_t info;
 			unsigned long signr = 0;
 
+			if (current->flags & PF_FREEZE) {
+				refrigerator(PF_FREEZE);
+				continue;
+			}
+
 			spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(current, &current->blocked, &info);
 			spin_unlock_irq(&current->sighand->siglock);
diff -ruN linux-2.6.8-rc1-mm1/fs/lockd/clntlock.c software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/clntlock.c
--- linux-2.6.8-rc1-mm1/fs/lockd/clntlock.c	2004-07-27 20:30:38.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/clntlock.c	2004-07-27 23:48:47.608507744 +1000
@@ -222,6 +223,8 @@
 
 		fl->fl_u.nfs_fl.flags &= ~NFS_LCK_RECLAIM;
 		nlmclnt_reclaim(host, fl);
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		if (signalled())
 			break;
 		goto restart;
diff -ruN linux-2.6.8-rc1-mm1/fs/lockd/clntproc.c software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/clntproc.c
--- linux-2.6.8-rc1-mm1/fs/lockd/clntproc.c	2004-07-27 20:30:38.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/clntproc.c	2004-07-27 23:48:47.609507592 +1000
@@ -310,6 +310,8 @@
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		if (!signalled ())
 			status = 0;
 	}
diff -ruN linux-2.6.8-rc1-mm1/fs/lockd/svc.c software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/svc.c
--- linux-2.6.8-rc1-mm1/fs/lockd/svc.c	2004-03-16 09:20:13.000000000 +1100
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/fs/lockd/svc.c	2004-07-27 23:48:47.609507592 +1000
@@ -135,6 +136,9 @@
 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_SYNCTHREAD);
+
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
diff -ruN linux-2.6.8-rc1-mm1/net/bluetooth/rfcomm/core.c software-suspend-linux-2.6.8-rc1-mm1-rev1/net/bluetooth/rfcomm/core.c
--- linux-2.6.8-rc1-mm1/net/bluetooth/rfcomm/core.c	2004-06-18 12:44:22.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/net/bluetooth/rfcomm/core.c	2004-07-27 23:48:47.662499536 +1000
@@ -1738,6 +1738,9 @@
 			schedule();
 		}
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
 		/* Process stuff */
 		clear_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
 		rfcomm_process_sessions();
diff -ruN linux-2.6.8-rc1-mm1/net/sunrpc/svcsock.c software-suspend-linux-2.6.8-rc1-mm1-rev1/net/sunrpc/svcsock.c
--- linux-2.6.8-rc1-mm1/net/sunrpc/svcsock.c	2004-07-27 20:29:52.000000000 +1000
+++ software-suspend-linux-2.6.8-rc1-mm1-rev1/net/sunrpc/svcsock.c	2004-07-27 23:48:47.663499384 +1000
@@ -1192,6 +1192,8 @@
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 	
+	if (current->flags & PF_FREEZE)
+		refrigerator(PF_FREEZE);
 	if (signalled())
 		return -EINTR;
 


