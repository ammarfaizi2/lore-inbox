Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVCOXPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVCOXPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVCOXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:14:34 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:15282 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262126AbVCOXMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:12:46 -0500
Subject: [PATCH] (Revised) Add missing refrigerator calls
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110925639.9818.80.camel@pegasus>
References: <1110924757.6454.132.camel@desktop.cunningham.myip.net.au>
	 <1110925639.9818.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1110928443.6454.166.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Mar 2005 10:14:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

Okay. I'll leave mtd_blkdevs as NO_FREEZE and remove the superfluous
bluetooth addition.

Here's a revised version:

diff -ruNp 213-missing-refrigerator-calls-old/drivers/media/video/msp3400.c 213-missing-refrigerator-calls-new/drivers/media/video/msp3400.c
--- 213-missing-refrigerator-calls-old/drivers/media/video/msp3400.c	2005-03-16 10:10:49.000000000 +1100
+++ 213-missing-refrigerator-calls-new/drivers/media/video/msp3400.c	2005-03-16 10:10:53.000000000 +1100
@@ -734,6 +734,7 @@ static int msp34xx_sleep(struct msp3400c
 {
 	DECLARE_WAITQUEUE(wait, current);
 
+again:
 	add_wait_queue(&msp->wq, &wait);
 	if (!kthread_should_stop()) {
 		if (timeout < 0) {
@@ -749,9 +750,12 @@ static int msp34xx_sleep(struct msp3400c
 #endif
 		}
 	}
-	if (current->flags & PF_FREEZE)
-		refrigerator(PF_FREEZE);
+
 	remove_wait_queue(&msp->wq, &wait);
+	
+	if (try_to_freeze(PF_FREEZE))
+		goto again;
+
 	return msp->restart;
 }
 
diff -ruNp 213-missing-refrigerator-calls-old/drivers/media/video/tvaudio.c 213-missing-refrigerator-calls-new/drivers/media/video/tvaudio.c
--- 213-missing-refrigerator-calls-old/drivers/media/video/tvaudio.c	2005-02-03 22:33:29.000000000 +1100
+++ 213-missing-refrigerator-calls-new/drivers/media/video/tvaudio.c	2005-03-11 09:35:15.000000000 +1100
@@ -286,6 +286,7 @@ static int chip_thread(void *data)
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
+		try_to_freeze(PF_FREEZE);
 		if (chip->done || signal_pending(current))
 			break;
 		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
diff -ruNp 213-missing-refrigerator-calls-old/drivers/pnp/pnpbios/core.c 213-missing-refrigerator-calls-new/drivers/pnp/pnpbios/core.c
--- 213-missing-refrigerator-calls-old/drivers/pnp/pnpbios/core.c	2005-02-14 09:05:26.000000000 +1100
+++ 213-missing-refrigerator-calls-new/drivers/pnp/pnpbios/core.c	2005-03-11 09:35:15.000000000 +1100
@@ -180,8 +180,12 @@ static int pnp_dock_thread(void * unused
 		 * Poll every 2 seconds
 		 */
 		msleep_interruptible(2000);
-		if(signal_pending(current))
+		
+		if(signal_pending(current)) {
+			if (try_to_freeze(PF_FREEZE))
+				continue;
 			break;
+		}
 
 		status = pnp_bios_dock_station_info(&now);
 
diff -ruNp 213-missing-refrigerator-calls-old/fs/afs/kafsasyncd.c 213-missing-refrigerator-calls-new/fs/afs/kafsasyncd.c
--- 213-missing-refrigerator-calls-old/fs/afs/kafsasyncd.c	2005-02-03 22:33:40.000000000 +1100
+++ 213-missing-refrigerator-calls-new/fs/afs/kafsasyncd.c	2005-03-11 09:35:15.000000000 +1100
@@ -116,6 +116,8 @@ static int kafsasyncd(void *arg)
 		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		afs_discard_my_signals();
 
diff -ruNp 213-missing-refrigerator-calls-old/fs/afs/kafstimod.c 213-missing-refrigerator-calls-new/fs/afs/kafstimod.c
--- 213-missing-refrigerator-calls-old/fs/afs/kafstimod.c	2005-02-03 22:33:40.000000000 +1100
+++ 213-missing-refrigerator-calls-new/fs/afs/kafstimod.c	2005-03-11 09:35:15.000000000 +1100
@@ -91,6 +91,8 @@ static int kafstimod(void *arg)
 			complete_and_exit(&kafstimod_dead, 0);
 		}
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		afs_discard_my_signals();
 
diff -ruNp 213-missing-refrigerator-calls-old/fs/lockd/clntproc.c 213-missing-refrigerator-calls-new/fs/lockd/clntproc.c
--- 213-missing-refrigerator-calls-old/fs/lockd/clntproc.c	2004-12-10 14:27:10.000000000 +1100
+++ 213-missing-refrigerator-calls-new/fs/lockd/clntproc.c	2005-03-11 09:35:15.000000000 +1100
@@ -312,6 +312,7 @@ static int nlm_wait_on_grace(wait_queue_
 	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
 	if (!signalled ()) {
 		schedule_timeout(NLMCLNT_GRACE_WAIT);
+		try_to_freeze(PF_FREEZE);
 		if (!signalled ())
 			status = 0;
 	}
diff -ruNp 213-missing-refrigerator-calls-old/kernel/signal.c 213-missing-refrigerator-calls-new/kernel/signal.c
--- 213-missing-refrigerator-calls-old/kernel/signal.c	2005-03-16 10:10:48.000000000 +1100
+++ 213-missing-refrigerator-calls-new/kernel/signal.c	2005-03-16 10:10:41.000000000 +1100
@@ -2201,6 +2201,8 @@ sys_rt_sigtimedwait(const sigset_t __use
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
diff -ruNp 213-missing-refrigerator-calls-old/net/rxrpc/krxiod.c 213-missing-refrigerator-calls-new/net/rxrpc/krxiod.c
--- 213-missing-refrigerator-calls-old/net/rxrpc/krxiod.c	2005-02-03 22:33:53.000000000 +1100
+++ 213-missing-refrigerator-calls-new/net/rxrpc/krxiod.c	2005-03-11 09:35:15.000000000 +1100
@@ -138,6 +138,8 @@ static int rxrpc_krxiod(void *arg)
 
 		_debug("### End Work");
 
+		try_to_freeze(PF_FREEZE);
+
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruNp 213-missing-refrigerator-calls-old/net/rxrpc/krxsecd.c 213-missing-refrigerator-calls-new/net/rxrpc/krxsecd.c
--- 213-missing-refrigerator-calls-old/net/rxrpc/krxsecd.c	2005-02-03 22:33:53.000000000 +1100
+++ 213-missing-refrigerator-calls-new/net/rxrpc/krxsecd.c	2005-03-11 09:35:15.000000000 +1100
@@ -107,6 +107,8 @@ static int rxrpc_krxsecd(void *arg)
 
 		_debug("### End Inbound Calls");
 
+		try_to_freeze(PF_FREEZE);
+
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruNp 213-missing-refrigerator-calls-old/net/rxrpc/krxtimod.c 213-missing-refrigerator-calls-new/net/rxrpc/krxtimod.c
--- 213-missing-refrigerator-calls-old/net/rxrpc/krxtimod.c	2005-02-03 22:33:53.000000000 +1100
+++ 213-missing-refrigerator-calls-new/net/rxrpc/krxtimod.c	2005-03-11 09:35:15.000000000 +1100
@@ -90,6 +90,8 @@ static int krxtimod(void *arg)
 			complete_and_exit(&krxtimod_dead, 0);
 		}
 
+		try_to_freeze(PF_FREEZE);
+
 		/* discard pending signals */
 		rxrpc_discard_my_signals();
 
diff -ruNp 213-missing-refrigerator-calls-old/net/sunrpc/svcsock.c 213-missing-refrigerator-calls-new/net/sunrpc/svcsock.c
--- 213-missing-refrigerator-calls-old/net/sunrpc/svcsock.c	2005-02-03 22:33:53.000000000 +1100
+++ 213-missing-refrigerator-calls-new/net/sunrpc/svcsock.c	2005-03-11 09:35:15.000000000 +1100
@@ -1186,6 +1186,7 @@ svc_recv(struct svc_serv *serv, struct s
 	arg->len = (pages-1)*PAGE_SIZE;
 	arg->tail[0].iov_len = 0;
 	
+	try_to_freeze(PF_FREEZE);
 	if (signalled())
 		return -EINTR;
 


On Wed, 2005-03-16 at 09:27, Marcel Holtmann wrote:
> Hi Nigel,
> 
> > There are a number of threads that currently have no refrigerator
> > handling in Linus' tree. This patch addresses part of that issue. The
> > remainder will be addressed in other patches, following soon.
> > 
> > Signed-off-by: Nigel Cunningham <ncunningham@cyclades.com>
> 
> I am fine with the net/bluetooth/rfcomm/ part, but what about the bnep/
> and cmtp/ and hidp/ part of the Bluetooth subsystem? Do we need this
> there, too?
> 
> Regards
> 
> Marcel
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

