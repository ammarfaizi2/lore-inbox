Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWBNRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWBNRwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWBNRwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:52:45 -0500
Received: from verein.lst.de ([213.95.11.210]:63692 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422722AbWBNRwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:52:44 -0500
Date: Tue, 14 Feb 2006 18:52:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: use kthread_ API
Message-ID: <20060214175240.GC19080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/net/rxrpc/krxiod.c
===================================================================
--- linux-2.6.orig/net/rxrpc/krxiod.c	2005-12-27 18:30:36.000000000 +0100
+++ linux-2.6/net/rxrpc/krxiod.c	2006-02-10 15:04:50.000000000 +0100
@@ -13,14 +13,15 @@
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/kthread.h>
 #include <rxrpc/krxiod.h>
 #include <rxrpc/transport.h>
 #include <rxrpc/peer.h>
 #include <rxrpc/call.h>
 #include "internal.h"
 
-static DECLARE_WAIT_QUEUE_HEAD(rxrpc_krxiod_sleepq);
-static DECLARE_COMPLETION(rxrpc_krxiod_dead);
+
+static struct task_struct *krxiod_thread;
 
 static atomic_t rxrpc_krxiod_qcount = ATOMIC_INIT(0);
 
@@ -30,20 +31,14 @@
 static LIST_HEAD(rxrpc_krxiod_callq);
 static DEFINE_SPINLOCK(rxrpc_krxiod_callq_lock);
 
-static volatile int rxrpc_krxiod_die;
-
 /*****************************************************************************/
 /*
  * Rx I/O daemon
  */
 static int rxrpc_krxiod(void *arg)
 {
-	DECLARE_WAITQUEUE(krxiod,current);
-
 	printk("Started krxiod %d\n",current->pid);
 
-	daemonize("krxiod");
-
 	/* loop around waiting for work to do */
 	do {
 		/* wait for work or to be told to exit */
@@ -51,19 +46,16 @@
 		if (!atomic_read(&rxrpc_krxiod_qcount)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 
-			add_wait_queue(&rxrpc_krxiod_sleepq, &krxiod);
-
 			for (;;) {
 				set_current_state(TASK_INTERRUPTIBLE);
 				if (atomic_read(&rxrpc_krxiod_qcount) ||
-				    rxrpc_krxiod_die ||
+				    kthread_should_stop() ||
 				    signal_pending(current))
 					break;
 
 				schedule();
 			}
 
-			remove_wait_queue(&rxrpc_krxiod_sleepq, &krxiod);
 			set_current_state(TASK_RUNNING);
 		}
 		_debug("### End Wait");
@@ -143,11 +135,9 @@
                 /* discard pending signals */
 		rxrpc_discard_my_signals();
 
-	} while (!rxrpc_krxiod_die);
-
-	/* and that's all */
-	complete_and_exit(&rxrpc_krxiod_dead, 0);
+	} while (!kthread_should_stop());
 
+	return 0;
 } /* end rxrpc_krxiod() */
 
 /*****************************************************************************/
@@ -156,7 +146,10 @@
  */
 int __init rxrpc_krxiod_init(void)
 {
-	return kernel_thread(rxrpc_krxiod, NULL, 0);
+	krxiod_thread = kthread_run(rxrpc_krxiod, NULL, "krxiod");
+	if (IS_ERR(krxiod_thread))
+		return PTR_ERR(krxiod_thread);
+	return 0;
 
 } /* end rxrpc_krxiod_init() */
 
@@ -166,10 +159,7 @@
  */
 void rxrpc_krxiod_kill(void)
 {
-	rxrpc_krxiod_die = 1;
-	wake_up_all(&rxrpc_krxiod_sleepq);
-	wait_for_completion(&rxrpc_krxiod_dead);
-
+	kthread_stop(krxiod_thread);
 } /* end rxrpc_krxiod_kill() */
 
 /*****************************************************************************/
@@ -194,7 +184,7 @@
 		}
 
 		spin_unlock_irqrestore(&rxrpc_krxiod_transportq_lock, flags);
-		wake_up_all(&rxrpc_krxiod_sleepq);
+		wake_up_process(krxiod_thread);
 	}
 
 	_leave("");
@@ -239,7 +229,7 @@
 		}
 		spin_unlock_irqrestore(&rxrpc_krxiod_callq_lock, flags);
 	}
-	wake_up_all(&rxrpc_krxiod_sleepq);
+	wake_up_process(krxiod_thread);
 
 } /* end rxrpc_krxiod_queue_call() */
 
Index: linux-2.6/net/rxrpc/krxsecd.c
===================================================================
--- linux-2.6.orig/net/rxrpc/krxsecd.c	2005-12-27 18:30:36.000000000 +0100
+++ linux-2.6/net/rxrpc/krxsecd.c	2006-02-10 15:05:37.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/kthread.h>
 #include <rxrpc/krxsecd.h>
 #include <rxrpc/transport.h>
 #include <rxrpc/connection.h>
@@ -30,8 +31,8 @@
 #include <net/sock.h>
 #include "internal.h"
 
-static DECLARE_WAIT_QUEUE_HEAD(rxrpc_krxsecd_sleepq);
-static DECLARE_COMPLETION(rxrpc_krxsecd_dead);
+
+static struct task_struct *krxsecd_thread;
 static volatile int rxrpc_krxsecd_die;
 
 static atomic_t rxrpc_krxsecd_qcount;
@@ -49,14 +50,10 @@
  */
 static int rxrpc_krxsecd(void *arg)
 {
-	DECLARE_WAITQUEUE(krxsecd, current);
-
 	int die;
 
 	printk("Started krxsecd %d\n", current->pid);
 
-	daemonize("krxsecd");
-
 	/* loop around waiting for work to do */
 	do {
 		/* wait for work or to be told to exit */
@@ -64,22 +61,19 @@
 		if (!atomic_read(&rxrpc_krxsecd_qcount)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 
-			add_wait_queue(&rxrpc_krxsecd_sleepq, &krxsecd);
-
 			for (;;) {
 				set_current_state(TASK_INTERRUPTIBLE);
 				if (atomic_read(&rxrpc_krxsecd_qcount) ||
-				    rxrpc_krxsecd_die ||
+				    kthread_should_stop() ||
 				    signal_pending(current))
 					break;
 
 				schedule();
 			}
 
-			remove_wait_queue(&rxrpc_krxsecd_sleepq, &krxsecd);
 			set_current_state(TASK_RUNNING);
 		}
-		die = rxrpc_krxsecd_die;
+		die = kthread_should_stop();
 		_debug("### End Wait");
 
 		/* see if there're incoming calls in need of authenticating */
@@ -114,9 +108,8 @@
 
 	} while (!die);
 
-	/* and that's all */
-	complete_and_exit(&rxrpc_krxsecd_dead, 0);
 
+	return 0;
 } /* end rxrpc_krxsecd() */
 
 /*****************************************************************************/
@@ -125,7 +118,10 @@
  */
 int __init rxrpc_krxsecd_init(void)
 {
-	return kernel_thread(rxrpc_krxsecd, NULL, 0);
+	krxsecd_thread = kthread_run(rxrpc_krxsecd, NULL, "krxsecd");
+	if (IS_ERR(krxsecd_thread))
+		return PTR_ERR(krxsecd_thread);
+	return 0;
 
 } /* end rxrpc_krxsecd_init() */
 
@@ -136,9 +132,7 @@
 void rxrpc_krxsecd_kill(void)
 {
 	rxrpc_krxsecd_die = 1;
-	wake_up_all(&rxrpc_krxsecd_sleepq);
-	wait_for_completion(&rxrpc_krxsecd_dead);
-
+	kthread_stop(krxsecd_thread);
 } /* end rxrpc_krxsecd_kill() */
 
 /*****************************************************************************/
@@ -197,7 +191,7 @@
 
 	spin_unlock(&rxrpc_krxsecd_initmsgq_lock);
 
-	wake_up(&rxrpc_krxsecd_sleepq);
+	wake_up_process(krxsecd_thread);
 
 	_leave("");
 } /* end rxrpc_krxsecd_queue_incoming_call() */
Index: linux-2.6/net/rxrpc/krxtimod.c
===================================================================
--- linux-2.6.orig/net/rxrpc/krxtimod.c	2006-01-26 13:52:05.000000000 +0100
+++ linux-2.6/net/rxrpc/krxtimod.c	2006-02-10 15:05:07.000000000 +0100
@@ -13,15 +13,14 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include <rxrpc/rxrpc.h>
 #include <rxrpc/krxtimod.h>
 #include <asm/errno.h>
 #include "internal.h"
 
-static DECLARE_COMPLETION(krxtimod_alive);
-static DECLARE_COMPLETION(krxtimod_dead);
-static DECLARE_WAIT_QUEUE_HEAD(krxtimod_sleepq);
-static int krxtimod_die;
+
+static struct task_struct *krxtimod_thread;
 
 static LIST_HEAD(krxtimod_list);
 static DEFINE_SPINLOCK(krxtimod_lock);
@@ -34,15 +33,10 @@
  */
 int rxrpc_krxtimod_start(void)
 {
-	int ret;
-
-	ret = kernel_thread(krxtimod, NULL, 0);
-	if (ret < 0)
-		return ret;
-
-	wait_for_completion(&krxtimod_alive);
-
-	return ret;
+	krxtimod_thread = kthread_run(krxtimod, NULL, "krxtimod");
+	if (IS_ERR(krxtimod_thread))
+		return PTR_ERR(krxtimod_thread);
+	return 0;
 } /* end rxrpc_krxtimod_start() */
 
 /*****************************************************************************/
@@ -51,11 +45,7 @@
  */
 void rxrpc_krxtimod_kill(void)
 {
-	/* get rid of my daemon */
-	krxtimod_die = 1;
-	wake_up(&krxtimod_sleepq);
-	wait_for_completion(&krxtimod_dead);
-
+	kthread_stop(krxtimod_thread);
 } /* end rxrpc_krxtimod_kill() */
 
 /*****************************************************************************/
@@ -64,30 +54,22 @@
  */
 static int krxtimod(void *arg)
 {
-	DECLARE_WAITQUEUE(myself, current);
-
 	rxrpc_timer_t *timer;
 
 	printk("Started krxtimod %d\n", current->pid);
 
-	daemonize("krxtimod");
-
-	complete(&krxtimod_alive);
-
 	/* loop around looking for things to attend to */
  loop:
 	set_current_state(TASK_INTERRUPTIBLE);
-	add_wait_queue(&krxtimod_sleepq, &myself);
 
 	for (;;) {
 		unsigned long jif;
 		long timeout;
 
 		/* deal with the server being asked to die */
-		if (krxtimod_die) {
-			remove_wait_queue(&krxtimod_sleepq, &myself);
+		if (kthread_should_stop()) {
 			_leave("");
-			complete_and_exit(&krxtimod_dead, 0);
+			return 0;
 		}
 
 		try_to_freeze();
@@ -125,7 +107,6 @@
 	 *   entry
 	 */
  immediate:
-	remove_wait_queue(&krxtimod_sleepq, &myself);
 	set_current_state(TASK_RUNNING);
 
 	_debug("@@@ Begin Timeout of %p", timer);
@@ -171,7 +152,7 @@
 
 	spin_unlock(&krxtimod_lock);
 
-	wake_up(&krxtimod_sleepq);
+	wake_up_process(krxtimod_thread);
 
 	_leave("");
 } /* end rxrpc_krxtimod_add_timer() */
@@ -196,7 +177,7 @@
 
 	spin_unlock(&krxtimod_lock);
 
-	wake_up(&krxtimod_sleepq);
+	wake_up_process(krxtimod_thread);
 
 	_leave(" = %d", ret);
 	return ret;
