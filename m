Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWBNS0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWBNS0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWBNS0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:26:09 -0500
Received: from verein.lst.de ([213.95.11.210]:20175 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422758AbWBNS0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:26:08 -0500
Date: Tue, 14 Feb 2006 19:26:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: use kthread_ API
Message-ID: <20060214182604.GA19973@lst.de>
References: <20060214175305.GD19080@lst.de> <6243.1139941329@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6243.1139941329@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 06:22:09PM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Use the kthread_ API instead of opencoding lots of hairy code for kernel
> > thread creation and teardown.
> 
> NAK. The kthread API appears nowhere in the patch.

Sorry, I accidentally attached a different afs patch.  Here's the
correct one:


Index: linux-2.6/fs/afs/cmservice.c
===================================================================
--- linux-2.6.orig/fs/afs/cmservice.c	2006-01-11 11:55:42.000000000 +0100
+++ linux-2.6/fs/afs/cmservice.c	2006-02-10 14:27:05.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include "server.h"
 #include "cell.h"
 #include "transport.h"
@@ -97,14 +98,11 @@
 	.ops_end	= &AFSCM_ops[sizeof(AFSCM_ops) / sizeof(AFSCM_ops[0])],
 };
 
-static DECLARE_COMPLETION(kafscmd_alive);
-static DECLARE_COMPLETION(kafscmd_dead);
-static DECLARE_WAIT_QUEUE_HEAD(kafscmd_sleepq);
+static struct task_struct *kafscmd_thread;
 static LIST_HEAD(kafscmd_attention_list);
 static LIST_HEAD(afscm_calls);
 static DEFINE_SPINLOCK(afscm_calls_lock);
 static DEFINE_SPINLOCK(kafscmd_attention_lock);
-static int kafscmd_die;
 
 /*****************************************************************************/
 /*
@@ -112,39 +110,31 @@
  */
 static int kafscmd(void *arg)
 {
-	DECLARE_WAITQUEUE(myself, current);
-
 	struct rxrpc_call *call;
 	_SRXAFSCM_xxxx_t func;
 	int die;
 
 	printk(KERN_INFO "kAFS: Started kafscmd %d\n", current->pid);
 
-	daemonize("kafscmd");
-
-	complete(&kafscmd_alive);
-
 	/* loop around looking for things to attend to */
 	do {
 		if (list_empty(&kafscmd_attention_list)) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			add_wait_queue(&kafscmd_sleepq, &myself);
 
 			for (;;) {
 				set_current_state(TASK_INTERRUPTIBLE);
 				if (!list_empty(&kafscmd_attention_list) ||
 				    signal_pending(current) ||
-				    kafscmd_die)
+				    kthread_should_stop())
 					break;
 
 				schedule();
 			}
 
-			remove_wait_queue(&kafscmd_sleepq, &myself);
 			set_current_state(TASK_RUNNING);
 		}
 
-		die = kafscmd_die;
+		die = kthread_should_stop();
 
 		/* dequeue the next call requiring attention */
 		call = NULL;
@@ -175,9 +165,7 @@
 
 	} while(!die);
 
-	/* and that's all */
-	complete_and_exit(&kafscmd_dead, 0);
-
+	return 0;
 } /* end kafscmd() */
 
 /*****************************************************************************/
@@ -223,7 +211,7 @@
 
 	spin_unlock(&kafscmd_attention_lock);
 
-	wake_up(&kafscmd_sleepq);
+	wake_up_process(kafscmd_thread);
 
 	_leave(" {u=%d}", atomic_read(&call->usage));
 } /* end afscm_attention() */
@@ -263,7 +251,7 @@
 	if (removed)
 		rxrpc_put_call(call);
 
-	wake_up(&kafscmd_sleepq);
+	wake_up_process(kafscmd_thread);
 
 	_leave("");
 } /* end afscm_error() */
@@ -297,11 +285,11 @@
 
 	down_write(&afscm_sem);
 	if (!afscm_usage) {
-		ret = kernel_thread(kafscmd, NULL, 0);
-		if (ret < 0)
+		kafscmd_thread = kthread_run(kafscmd, NULL, "kafscmd");
+		if (IS_ERR(kafscmd_thread)) {
+			ret = PTR_ERR(kafscmd_thread);
 			goto out;
-
-		wait_for_completion(&kafscmd_alive);
+		}
 
 		ret = rxrpc_add_service(afs_transport, &AFSCM_service);
 		if (ret < 0)
@@ -317,10 +305,7 @@
 	return 0;
 
  kill:
-	kafscmd_die = 1;
-	wake_up(&kafscmd_sleepq);
-	wait_for_completion(&kafscmd_dead);
-
+	kthread_stop(kafscmd_thread);
  out:
 	up_write(&afscm_sem);
 	return ret;
@@ -369,10 +354,7 @@
 		}
 		spin_unlock(&afscm_calls_lock);
 
-		/* get rid of my daemon */
-		kafscmd_die = 1;
-		wake_up(&kafscmd_sleepq);
-		wait_for_completion(&kafscmd_dead);
+		kthread_stop(kafscmd_thread);
 
 		/* dispose of any calls waiting for attention */
 		spin_lock(&kafscmd_attention_lock);
Index: linux-2.6/fs/afs/kafsasyncd.c
===================================================================
--- linux-2.6.orig/fs/afs/kafsasyncd.c	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/fs/afs/kafsasyncd.c	2006-02-10 14:35:37.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include "cell.h"
 #include "server.h"
 #include "volume.h"
@@ -29,11 +30,8 @@
 #include <asm/errno.h>
 #include "internal.h"
 
-static DECLARE_COMPLETION(kafsasyncd_alive);
-static DECLARE_COMPLETION(kafsasyncd_dead);
-static DECLARE_WAIT_QUEUE_HEAD(kafsasyncd_sleepq);
+
 static struct task_struct *kafsasyncd_task;
-static int kafsasyncd_die;
 
 static int kafsasyncd(void *arg);
 
@@ -55,15 +53,10 @@
  */
 int afs_kafsasyncd_start(void)
 {
-	int ret;
-
-	ret = kernel_thread(kafsasyncd, NULL, 0);
-	if (ret < 0)
-		return ret;
-
-	wait_for_completion(&kafsasyncd_alive);
-
-	return ret;
+	kafsasyncd_task = kthread_run(kafsasyncd, NULL, "kafsasyncd");
+	if (IS_ERR(kafsasyncd_task))
+		return PTR_ERR(kafsasyncd_task);
+	return 0;
 } /* end afs_kafsasyncd_start() */
 
 /*****************************************************************************/
@@ -72,11 +65,7 @@
  */
 void afs_kafsasyncd_stop(void)
 {
-	/* get rid of my daemon */
-	kafsasyncd_die = 1;
-	wake_up(&kafsasyncd_sleepq);
-	wait_for_completion(&kafsasyncd_dead);
-
+	kthread_stop(kafsasyncd_task);
 } /* end afs_kafsasyncd_stop() */
 
 /*****************************************************************************/
@@ -88,32 +77,22 @@
 	struct afs_async_op *op;
 	int die;
 
-	DECLARE_WAITQUEUE(myself, current);
-
-	kafsasyncd_task = current;
-
 	printk("kAFS: Started kafsasyncd %d\n", current->pid);
 
-	daemonize("kafsasyncd");
-
-	complete(&kafsasyncd_alive);
-
 	/* loop around looking for things to attend to */
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&kafsasyncd_sleepq, &myself);
 
 		for (;;) {
 			if (!list_empty(&kafsasyncd_async_attnq) ||
 			    signal_pending(current) ||
-			    kafsasyncd_die)
+			    kthread_should_stop())
 				break;
 
 			schedule();
 			set_current_state(TASK_INTERRUPTIBLE);
 		}
 
-		remove_wait_queue(&kafsasyncd_sleepq, &myself);
 		set_current_state(TASK_RUNNING);
 
 		try_to_freeze();
@@ -121,7 +100,7 @@
 		/* discard pending signals */
 		afs_discard_my_signals();
 
-		die = kafsasyncd_die;
+		die = kthread_should_stop();
 
 		/* deal with the next asynchronous operation requiring
 		 * attention */
@@ -156,7 +135,6 @@
 
 	/* need to kill all outstanding asynchronous operations before
 	 * exiting */
-	kafsasyncd_task = NULL;
 	spin_lock(&kafsasyncd_async_lock);
 
 	/* fold the busy and attention queues together */
@@ -186,8 +164,7 @@
 
 	/* and that's all */
 	_leave("");
-	complete_and_exit(&kafsasyncd_dead, 0);
-
+	return 0;
 } /* end kafsasyncd() */
 
 /*****************************************************************************/
@@ -228,7 +205,7 @@
 
 	spin_unlock(&kafsasyncd_async_lock);
 
-	wake_up(&kafsasyncd_sleepq);
+	wake_up_process(kafsasyncd_task);
 
 	_leave("");
 } /* end afs_kafsasyncd_attend_op() */
@@ -251,7 +228,7 @@
 
 	spin_unlock(&kafsasyncd_async_lock);
 
-	wake_up(&kafsasyncd_sleepq);
+	wake_up_process(kafsasyncd_task);
 
 	_leave("");
 } /* end afs_kafsasyncd_terminate_op() */
Index: linux-2.6/fs/afs/kafstimod.c
===================================================================
--- linux-2.6.orig/fs/afs/kafstimod.c	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/fs/afs/kafstimod.c	2006-02-10 14:31:41.000000000 +0100
@@ -13,16 +13,14 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include "cell.h"
 #include "volume.h"
 #include "kafstimod.h"
 #include <asm/errno.h>
 #include "internal.h"
 
-static DECLARE_COMPLETION(kafstimod_alive);
-static DECLARE_COMPLETION(kafstimod_dead);
-static DECLARE_WAIT_QUEUE_HEAD(kafstimod_sleepq);
-static int kafstimod_die;
+static struct task_struct *kafstimod_thread;
 
 static LIST_HEAD(kafstimod_list);
 static DEFINE_SPINLOCK(kafstimod_lock);
@@ -35,15 +33,11 @@
  */
 int afs_kafstimod_start(void)
 {
-	int ret;
+	kafstimod_thread = kthread_run(kafstimod, NULL, "kafstimod");
+	if (IS_ERR(kafstimod_thread))
+		return PTR_ERR(kafstimod_thread);
 
-	ret = kernel_thread(kafstimod, NULL, 0);
-	if (ret < 0)
-		return ret;
-
-	wait_for_completion(&kafstimod_alive);
-
-	return ret;
+	return 0;
 } /* end afs_kafstimod_start() */
 
 /*****************************************************************************/
@@ -52,11 +46,7 @@
  */
 void afs_kafstimod_stop(void)
 {
-	/* get rid of my daemon */
-	kafstimod_die = 1;
-	wake_up(&kafstimod_sleepq);
-	wait_for_completion(&kafstimod_dead);
-
+	kthread_stop(kafstimod_thread);
 } /* end afs_kafstimod_stop() */
 
 /*****************************************************************************/
@@ -67,28 +57,20 @@
 {
 	struct afs_timer *timer;
 
-	DECLARE_WAITQUEUE(myself, current);
-
 	printk("kAFS: Started kafstimod %d\n", current->pid);
 
-	daemonize("kafstimod");
-
-	complete(&kafstimod_alive);
-
 	/* loop around looking for things to attend to */
  loop:
 	set_current_state(TASK_INTERRUPTIBLE);
-	add_wait_queue(&kafstimod_sleepq, &myself);
 
 	for (;;) {
 		unsigned long jif;
 		signed long timeout;
 
 		/* deal with the server being asked to die */
-		if (kafstimod_die) {
-			remove_wait_queue(&kafstimod_sleepq, &myself);
+		if (kthread_should_stop()) {
 			_leave("");
-			complete_and_exit(&kafstimod_dead, 0);
+			return 0;
 		}
 
 		try_to_freeze();
@@ -126,7 +108,6 @@
 	 *   entry
 	 */
  immediate:
-	remove_wait_queue(&kafstimod_sleepq, &myself);
 	set_current_state(TASK_RUNNING);
 
 	_debug("@@@ Begin Timeout of %p", timer);
@@ -172,7 +153,7 @@
 
 	spin_unlock(&kafstimod_lock);
 
-	wake_up(&kafstimod_sleepq);
+	wake_up_process(kafstimod_thread);
 
 	_leave("");
 } /* end afs_kafstimod_add_timer() */
@@ -197,7 +178,7 @@
 
 	spin_unlock(&kafstimod_lock);
 
-	wake_up(&kafstimod_sleepq);
+	wake_up_process(kafstimod_thread);
 
 	_leave(" = %d", ret);
 	return ret;
