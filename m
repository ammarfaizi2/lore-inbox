Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWAZDxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWAZDxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWAZDtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:40 -0500
Received: from [202.53.187.9] ([202.53.187.9]:17387 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932224AbWAZDtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:12 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 04/23] [Suspend2] Todo notifier for processes.
Date: Thu, 26 Jan 2006 13:45:36 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034534.3178.67961.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(This is Christoph Lameter's patch, previously posted to LKML. This
revision only updates it to apply against the current codebase).

Introduce a todo notifier in the task_struct so that a task can be told to
do certain things. Abuse the suspend hooks try_to_freeze, freezing and
refrigerator to establish checkpoints where the todo list is processed.

This will break software suspend (next patch fixes and cleans up
software suspend).

This patch has been updated so as to apply to current git. Since that's
the only change, I've kept Christoph's original Signed-off-by.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 arch/arm/kernel/signal.c                  |    2 -
 arch/frv/kernel/signal.c                  |    2 -
 arch/h8300/kernel/signal.c                |    2 -
 arch/i386/kernel/io_apic.c                |    2 -
 arch/i386/kernel/signal.c                 |    2 -
 arch/m32r/kernel/signal.c                 |    2 -
 arch/mips/kernel/irixsig.c                |    2 -
 arch/mips/kernel/signal32.c               |    2 -
 arch/powerpc/kernel/signal_32.c           |    2 -
 arch/sh/kernel/signal.c                   |    2 -
 arch/sh64/kernel/signal.c                 |    2 -
 arch/x86_64/kernel/signal.c               |    2 -
 drivers/block/pktcdvd.c                   |    3 -
 drivers/ieee1394/nodemgr.c                |    2 -
 drivers/input/gameport/gameport.c         |    2 -
 drivers/input/serio/serio.c               |    8 +++
 drivers/macintosh/therm_adt746x.c         |    2 -
 drivers/media/dvb/dvb-core/dvb_frontend.c |    2 -
 drivers/media/video/msp3400-driver.c      |    2 -
 drivers/media/video/tvaudio.c             |    2 -
 drivers/media/video/video-buf-dvb.c       |    2 -
 drivers/net/irda/stir4200.c               |    4 +
 drivers/net/wireless/airo.c               |    2 -
 drivers/pcmcia/cs.c                       |    2 -
 drivers/pnp/pnpbios/core.c                |    2 -
 drivers/usb/core/hub.c                    |    2 -
 drivers/usb/gadget/file_storage.c         |    2 -
 drivers/usb/storage/usb.c                 |    2 -
 drivers/w1/w1.c                           |    4 +
 fs/afs/kafsasyncd.c                       |    2 -
 fs/afs/kafstimod.c                        |    2 -
 fs/jbd/journal.c                          |    4 +
 fs/jffs/intrep.c                          |    2 -
 fs/jffs2/background.c                     |    2 -
 fs/jfs/jfs_logmgr.c                       |    4 +
 fs/jfs/jfs_txnmgr.c                       |    8 +--
 fs/lockd/clntlock.c                       |    1 
 fs/lockd/clntproc.c                       |    2 -
 fs/lockd/svc.c                            |    2 +
 fs/xfs/linux-2.6/xfs_buf.c                |    4 +
 fs/xfs/linux-2.6/xfs_super.c              |    2 -
 include/linux/sched.h                     |   80 ++++++++---------------------
 kernel/audit.c                            |    2 -
 kernel/sched.c                            |    2 -
 kernel/signal.c                           |    4 +
 kernel/workqueue.c                        |    2 -
 mm/page_alloc.c                           |    1 
 mm/pdflush.c                              |    2 -
 mm/vmscan.c                               |    2 -
 net/rxrpc/krxiod.c                        |    2 -
 net/rxrpc/krxsecd.c                       |    2 -
 net/rxrpc/krxtimod.c                      |    2 -
 net/sunrpc/sched.c                        |    4 +
 net/sunrpc/svcsock.c                      |    4 +
 54 files changed, 94 insertions(+), 119 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a0cd0a9..7bbcf0f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -644,7 +644,7 @@ static int do_signal(sigset_t *oldset, s
 	if (!user_mode(regs))
 		return 0;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (current->ptrace & PT_SINGLESTEP)
diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index 679c1d5..5d1567f 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -500,7 +500,7 @@ static void do_signal(void)
 	if (!user_mode(__frame))
 		return;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index f13d5e8..acce2c7 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -516,7 +516,7 @@ asmlinkage int do_signal(struct pt_regs 
 	if ((regs->ccr & 0x10))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	current->thread.esp0 = (unsigned long) regs;
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index f2dd218..760da02 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -578,7 +578,7 @@ static int balanced_irq(void *unused)
 
 	for ( ; ; ) {
 		time_remaining = schedule_timeout_interruptible(time_remaining);
-		try_to_freeze();
+		try_todo_list();
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			preempt_disable();
diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index 963616d..75f017e 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -582,7 +582,7 @@ static void fastcall do_signal(struct pt
 	if (!user_mode(regs))
 		return;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
index 71763f7..5311cce 100644
--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -370,7 +370,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze()) 
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index 08273a2..0a86eb4 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -185,7 +185,7 @@ asmlinkage int do_irix_signal(sigset_t *
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 98b185b..62d28ff 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -822,7 +822,7 @@ int do_signal32(sigset_t *oldset, struct
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3747ab0..0bd53de 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1132,7 +1132,7 @@ int do_signal(sigset_t *oldset, struct p
 	int signr, ret;
 
 #ifdef CONFIG_PPC32
-	if (try_to_freeze()) {
+	if (try_todo_list()) {
 		signr = 0;
 		if (!signal_pending(current))
 			goto no_signal;
diff --git a/arch/sh/kernel/signal.c b/arch/sh/kernel/signal.c
index b475c4d..e6df050 100644
--- a/arch/sh/kernel/signal.c
+++ b/arch/sh/kernel/signal.c
@@ -578,7 +578,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/arch/sh64/kernel/signal.c b/arch/sh64/kernel/signal.c
index 3ea8929..8727da0 100644
--- a/arch/sh64/kernel/signal.c
+++ b/arch/sh64/kernel/signal.c
@@ -696,7 +696,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/arch/x86_64/kernel/signal.c b/arch/x86_64/kernel/signal.c
index 5876df1..f086f3c 100644
--- a/arch/x86_64/kernel/signal.c
+++ b/arch/x86_64/kernel/signal.c
@@ -443,7 +443,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 93affee..0774b13 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1255,8 +1255,7 @@ static int kcdrwd(void *foobar)
 			residue = schedule_timeout(min_sleep_time);
 			VPRINTK("kcdrwd: wake up\n");
 
-			/* make swsusp happy with our thread */
-			try_to_freeze();
+			try_todo_list();
 
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
 				if (!pkt->sleep_time)
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 082c7fd..b2766e9 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -1581,7 +1581,7 @@ static int nodemgr_host_thread(void *__h
 
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
 			break;
diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index b765a15..19271d5 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -440,7 +440,7 @@ static int gameport_thread(void *nothing
 		gameport_handle_event();
 		wait_event_interruptible(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index edd7254..8e0c32b 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -312,6 +312,12 @@ static void serio_handle_event(void)
 
 		serio_remove_duplicate_events(event);
 		serio_free_event(event);
+
+		if (unlikely(todo_list_active())) {
+  			up(&serio_sem);
+			try_todo_list();
+  			down(&serio_sem);
+		}
 	}
 
 	up(&serio_sem);
@@ -375,7 +381,7 @@ static int serio_thread(void *nothing)
 		serio_handle_event();
 		wait_event_interruptible(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop());
 
 	printk(KERN_DEBUG "serio: kseriod exiting\n");
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 5ebfd1d..97d2ad7 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -337,7 +337,7 @@ static int monitor_task(void *arg)
 	struct thermostat* th = arg;
 
 	while(!kthread_should_stop()) {
-		try_to_freeze();
+		try_todo_list();
 		msleep_interruptible(2000);
 
 #ifndef DEBUG
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 771f32d..f01d545 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -520,7 +520,7 @@ static int dvb_frontend_thread(void *dat
 			break;
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		if (down_interruptible(&fepriv->sem))
 			break;
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 69ed369..4a4b2fe 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -398,7 +398,7 @@ int msp_sleep(struct msp_state *state, i
 	}
 
 	remove_wait_queue(&state->wq, &wait);
-	try_to_freeze();
+	try_todo_list();
 	return state->restart;
 }
 
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 6d03b9b..0d9e473 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -283,7 +283,7 @@ static int chip_thread(void *data)
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
-		try_to_freeze();
+		try_todo_list();
 		if (chip->done || signal_pending(current))
 			break;
 		v4l_dbg(1, debug, &chip->c, "%s: thread wakeup\n", chip->c.name);
diff --git a/drivers/media/video/video-buf-dvb.c b/drivers/media/video/video-buf-dvb.c
index 0a4004a..2568065 100644
--- a/drivers/media/video/video-buf-dvb.c
+++ b/drivers/media/video/video-buf-dvb.c
@@ -62,7 +62,7 @@ static int videobuf_dvb_thread(void *dat
 			break;
 		if (kthread_should_stop())
 			break;
-		try_to_freeze();
+		try_todo_list();
 
 		/* feed buffer data to demux */
 		if (buf->state == STATE_DONE)
diff --git a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
index 31867e4..f48f86e 100644
--- a/drivers/net/irda/stir4200.c
+++ b/drivers/net/irda/stir4200.c
@@ -762,7 +762,7 @@ static int stir_transmit_thread(void *ar
 	{
 #ifdef CONFIG_PM
 		/* if suspending, then power off and wait */
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active())) {
 			if (stir->receiving)
 				receive_stop(stir);
 			else
@@ -770,7 +770,7 @@ static int stir_transmit_thread(void *ar
 
 			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
 
-			refrigerator();
+			run_todo_list();
 
 			if (change_speed(stir, stir->speed))
 				break;
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index a4c7ae9..db505c6 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -2910,7 +2910,7 @@ static int airo_thread(void *data) {
 			flush_signals(current);
 
 		/* make swsusp happy with our thread */
-		try_to_freeze();
+		try_todo_list();
 
 		if (test_bit(JOB_DIE, &ai->flags))
 			break;
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 613f2f1..2cafae0 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -681,7 +681,7 @@ static int pccardd(void *__skt)
 			break;
 
 		schedule();
-		try_to_freeze();
+		try_todo_list();
 	}
 	/* make sure we are running before we exit */
 	set_current_state(TASK_RUNNING);
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index b154b3f..f6ad731 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -170,7 +170,7 @@ static int pnp_dock_thread(void * unused
 		msleep_interruptible(2000);
 
 		if(signal_pending(current)) {
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 			break;
 		}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 650d5ee..dc232f0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2870,7 +2870,7 @@ static int hub_thread(void *__unused)
 		wait_event_interruptible(khubd_wait,
 				!list_empty(&hub_event_list) ||
 				kthread_should_stop());
-		try_to_freeze();
+		try_todo_list();
 	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
 	pr_debug("%s: khubd exiting\n", usbcore_name);
diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index de59c58..2ffca51 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -1557,7 +1557,7 @@ static int sleep_thread(struct fsg_dev *
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
-		try_to_freeze();
+		try_todo_list();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current)) {
 			rc = -EINTR;
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index dbcf239..0d6bcaa 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -860,7 +860,7 @@ retry:
 		wait_event_interruptible_timeout(us->delay_wait,
 				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
 				delay_use * HZ);
-		if (try_to_freeze())
+		if (try_todo_list())
 			goto retry;
 	}
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 024206c..7e8d624 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -720,7 +720,7 @@ static int w1_control(void *data)
 	while (!control_needs_exit || have_to_wait) {
 		have_to_wait = 0;
 
-		try_to_freeze();
+		try_todo_list();
 		msleep_interruptible(w1_control_timeout * 1000);
 
 		if (signal_pending(current))
@@ -796,7 +796,7 @@ int w1_process(void *data)
 	allow_signal(SIGTERM);
 
 	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
-		try_to_freeze();
+		try_todo_list();
 		msleep_interruptible(w1_timeout * 1000);
 
 		if (signal_pending(current))
diff --git a/fs/afs/kafsasyncd.c b/fs/afs/kafsasyncd.c
index 7ac07d0..cd0cbda 100644
--- a/fs/afs/kafsasyncd.c
+++ b/fs/afs/kafsasyncd.c
@@ -116,7 +116,7 @@ static int kafsasyncd(void *arg)
 		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
diff --git a/fs/afs/kafstimod.c b/fs/afs/kafstimod.c
index 65bc05a..127b2ac 100644
--- a/fs/afs/kafstimod.c
+++ b/fs/afs/kafstimod.c
@@ -91,7 +91,7 @@ static int kafstimod(void *arg)
 			complete_and_exit(&kafstimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		afs_discard_my_signals();
diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index e4b516a..c7113af 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -153,7 +153,7 @@ loop:
 	}
 
 	wake_up(&journal->j_wait_done_commit);
-	if (freezing(current)) {
+	if (todo_list_active()) {
 		/*
 		 * The simpler the better. Flushing journal isn't a
 		 * good idea, because that depends on threads that may
@@ -161,7 +161,7 @@ loop:
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
 		spin_unlock(&journal->j_state_lock);
-		refrigerator();
+		run_todo_list();
 		spin_lock(&journal->j_state_lock);
 	} else {
 		/*
diff --git a/fs/jffs/intrep.c b/fs/jffs/intrep.c
index b2e9542..f077572 100644
--- a/fs/jffs/intrep.c
+++ b/fs/jffs/intrep.c
@@ -3391,7 +3391,7 @@ jffs_garbage_collect_thread(void *ptr)
 			siginfo_t info;
 			unsigned long signr = 0;
 
-			if (try_to_freeze())
+			if (try_todo_list())
 				continue;
 
 			spin_lock_irq(&current->sighand->siglock);
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 7b77a95..a8b4fe3 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -96,7 +96,7 @@ static int jffs2_garbage_collect_thread(
 			schedule();
 		}
 
-		if (try_to_freeze())
+		if (try_todo_list())
 			continue;
 
 		cond_resched();
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index d27bac6..436e1e3 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2362,9 +2362,9 @@ int jfsIOWait(void *arg)
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
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 2ddb6b8..7758373 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2793,9 +2793,9 @@ int jfs_lazycommit(void *arg)
 		/* In case a wakeup came while all threads were active */
 		jfs_commit_thread_waking = 0;
 
-		if (freezing(current)) {
+		if (todo_list_active()) {
 			LAZY_UNLOCK(flags);
-			refrigerator();
+			run_todo_list();
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
@@ -2992,9 +2992,9 @@ int jfs_sync(void *arg)
 		/* Add anon_list2 back to anon_list */
 		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
 
-		if (freezing(current)) {
+		if (todo_list_active()) {
 			TXN_UNLOCK();
-			refrigerator();
+			run_todo_list();
 		} else {
 			DECLARE_WAITQUEUE(wq, current);
 
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 3eaf6e7..df8a823 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -237,6 +237,7 @@ restart:
 
 		fl->fl_u.nfs_fl.flags &= ~NFS_LCK_RECLAIM;
 		nlmclnt_reclaim(host, fl);
+		try_todo_list();
 		if (signalled())
 			break;
 		goto restart;
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 1455240..96daffe 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -311,7 +311,7 @@ static int nlm_wait_on_grace(wait_queue_
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
-		try_to_freeze();
+		try_todo_list();
 		if (!signalled ())
 			status = 0;
 	}
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 71a30b4..6fb8e0c 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -138,6 +138,8 @@ lockd(struct svc_rqst *rqstp)
 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
+		try_todo_list();
+  
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index e44b7c1..6696eba 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1677,9 +1677,9 @@ xfsbufd(
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		if (unlikely(freezing(current))) {
+		if (unlikely(todo_list_active(current))) {
 			set_bit(XBT_FORCE_SLEEP, &target->bt_flags);
-			refrigerator();
+			run_todo_list();
 		} else {
 			clear_bit(XBT_FORCE_SLEEP, &target->bt_flags);
 		}
diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index f22e426..cec9c38 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -578,7 +578,7 @@ xfssyncd(
 	for (;;) {
 		timeleft = schedule_timeout_interruptible(timeleft);
 		/* swsusp */
-		try_to_freeze();
+		try_todo_list();
 		if (kthread_should_stop() && list_empty(&vfsp->vfs_sync_list))
 			break;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cfcd1c..7d566dd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,6 +35,7 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 #include <linux/rcupdate.h>
+#include <linux/notifier.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -817,7 +818,10 @@ struct task_struct {
 	int (*notifier)(void *priv);
 	void *notifier_data;
 	sigset_t *notifier_mask;
-	
+
+	/* todo list to be executed in the context of this thread */
+	struct notifier_block *todo;
+
 	void *security;
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
@@ -1390,79 +1394,37 @@ extern long sched_getaffinity(pid_t pid,
 
 extern void normalize_rt_tasks(void);
 
-#ifdef CONFIG_PM
-/*
- * Check if a process has been frozen
- */
-static inline int frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
-
-/*
- * Check if there is a request to freeze a process
- */
-static inline int freezing(struct task_struct *p)
-{
-	return p->flags & PF_FREEZE;
-}
-
 /*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
+ * Check if there is a todo list request
  */
-static inline void freeze(struct task_struct *p)
+static inline int todo_list_active(void)
 {
-	p->flags |= PF_FREEZE;
+	return current->todo != NULL;
 }
 
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
+static inline void run_todo_list(void)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	notifier_call_chain(&current->todo, 0, current);
 }
 
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-static inline int try_to_freeze(void)
+static inline int try_todo_list(void)
 {
-	if (freezing(current)) {
-		refrigerator();
+	if (todo_list_active()) {
+		run_todo_list();
 		return 1;
 	} else
 		return 0;
 }
-#else
-static inline int frozen(struct task_struct *p) { return 0; }
-static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
-static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
 
-static inline int try_to_freeze(void) { return 0; }
+/*
+ * Compatibility definitions to use the suspend checkpoints for the task todo
+ * list. These may be removed once all uses of try_to_free,  refrigerator and
+ * freezing have been removed.
+ */
+#define try_to_freeze try_todo_list
+#define refrigerator run_todo_list
+#define freezing(p) todo_list_active()
 
-#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index 0cd1b16..7af8794 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -289,7 +289,7 @@ static int kauditd_thread(void *dummy)
 		} else {
 			DECLARE_WAITQUEUE(wait, current);
 			
-			try_to_freeze();
+			try_todo_list();
 
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&kauditd_wait, &wait);
diff --git a/kernel/sched.c b/kernel/sched.c
index ad3c9ac..7e685bc 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4589,7 +4589,7 @@ static int migration_thread(void *data)
 		struct list_head *head;
 		migration_req_t *req;
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_irq(&rq->lock);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index d3efafd..4b367b3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -214,7 +214,7 @@ static inline int has_pending_signals(si
 fastcall void recalc_sigpending_tsk(struct task_struct *t)
 {
 	if (t->signal->group_stop_count > 0 ||
-	    (freezing(t)) ||
+	    (t->todo) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked))
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
@@ -2307,7 +2307,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 
 			timeout = schedule_timeout_interruptible(timeout);
 
-			try_to_freeze();
+			try_todo_list();
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 124b6b8..74d2334 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -211,7 +211,7 @@ static int worker_thread(void *__cwq)
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
-		try_to_freeze();
+		try_todo_list();
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df54e2f..f9151b9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1030,6 +1030,7 @@ rebalance:
 			do_retry = 1;
 	}
 	if (do_retry) {
+		try_todo_list();
 		blk_congestion_wait(WRITE, HZ/50);
 		goto rebalance;
 	}
diff --git a/mm/pdflush.c b/mm/pdflush.c
index c4b6d0a..d1417da 100644
--- a/mm/pdflush.c
+++ b/mm/pdflush.c
@@ -106,7 +106,7 @@ static int __pdflush(struct pdflush_work
 		spin_unlock_irq(&pdflush_lock);
 
 		schedule();
-		if (try_to_freeze()) {
+		if (try_todo_list()) {
 			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34b61..7bc80c3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1463,7 +1463,7 @@ static int kswapd(void *p)
 	for ( ; ; ) {
 		unsigned long new_order;
 
-		try_to_freeze();
+		try_todo_list();
 
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;
diff --git a/net/rxrpc/krxiod.c b/net/rxrpc/krxiod.c
index dada34a..be76d85 100644
--- a/net/rxrpc/krxiod.c
+++ b/net/rxrpc/krxiod.c
@@ -138,7 +138,7 @@ static int rxrpc_krxiod(void *arg)
 
 		_debug("### End Work");
 
-		try_to_freeze();
+		try_todo_list();
 
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
diff --git a/net/rxrpc/krxsecd.c b/net/rxrpc/krxsecd.c
index 1aadd02..38a587f 100644
--- a/net/rxrpc/krxsecd.c
+++ b/net/rxrpc/krxsecd.c
@@ -107,7 +107,7 @@ static int rxrpc_krxsecd(void *arg)
 
 		_debug("### End Inbound Calls");
 
-		try_to_freeze();
+		try_todo_list();
 
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
diff --git a/net/rxrpc/krxtimod.c b/net/rxrpc/krxtimod.c
index 3e74669..8ca7ff3 100644
--- a/net/rxrpc/krxtimod.c
+++ b/net/rxrpc/krxtimod.c
@@ -90,7 +90,7 @@ static int krxtimod(void *arg)
 			complete_and_exit(&krxtimod_dead, 0);
 		}
 
-		try_to_freeze();
+		try_todo_list();
 
 		/* discard pending signals */
 		rxrpc_discard_my_signals();
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7415406..1b2fb95 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -671,6 +671,9 @@ static int __rpc_execute(struct rpc_task
 
 		/* sync task: sleep here */
 		dprintk("RPC: %4d sync task going to sleep\n", task->tk_pid);
+
+		try_todo_list();
+
 		/* Note: Caller should be using rpc_clnt_sigmask() */
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_interruptible,
@@ -711,6 +714,7 @@ static int __rpc_execute(struct rpc_task
 int
 rpc_execute(struct rpc_task *task)
 {
+	try_todo_list();
 	rpc_set_active(task);
 	rpc_set_running(task);
 	return __rpc_execute(task);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 5058062..d840ddd 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1177,7 +1177,7 @@ svc_recv(struct svc_serv *serv, struct s
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 
-	try_to_freeze();
+	try_todo_list();
 	cond_resched();
 	if (signalled())
 		return -EINTR;
@@ -1219,7 +1219,7 @@ svc_recv(struct svc_serv *serv, struct s
 
 		schedule_timeout(timeout);
 
-		try_to_freeze();
+		try_todo_list();
 
 		spin_lock_bh(&serv->sv_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);

--
Nigel Cunningham		nigel at suspend2 dot net
