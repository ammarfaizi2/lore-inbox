Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWGMV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWGMV2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWGMV2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:28:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3209 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030403AbWGMV2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:28:37 -0400
Date: Thu, 13 Jul 2006 22:28:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: akpm@osdl.org, achirica@users.sourceforge.net,
       "David C. Hansen" <haveblue@us.ibm.com>, serue@us.ibm.com,
       clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: airo.c
Message-ID: <20060713212824.GA14729@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sukadev Bhattiprolu <sukadev@us.ibm.com>, akpm@osdl.org,
	achirica@users.sourceforge.net,
	"David C. Hansen" <haveblue@us.ibm.com>, serue@us.ibm.com,
	clg@fr.ibm.com, linux-kernel@vger.kernel.org
References: <20060713205319.GA23594@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713205319.GA23594@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 01:53:19PM -0700, Sukadev Bhattiprolu wrote:
> Andrew,
> 
> Javier Achirica, one of the major contributors to drivers/net/wireless/airo.c
> took a look at this patch, and doesn't have any problems with it. It doesn't
> fix any bugs and is just a cleanup, so it certainly isn't a candidate
> for this mainline cycle

I'm not sure it's that easy.  I think it needs some more love:

 - switch to wake_uo_process
 - kill JOB_DIE
 - cleanup a the convoluted mess in airo_thread a bit

Note that it's still reimplementing the single threaded workqueue
functionality quite badly.  So if someone could switch it over and while
we're at it try to kill the idiociy of doing the trylock in the calling
context and only then calling the thread by always calling the thread
(which also solves the synchronization problem).

Anywhy, here's a small incremental patch ontop of yours to implement my
above items:

Index: linux-2.6/drivers/net/wireless/airo.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/airo.c	2006-07-13 23:23:28.000000000 +0200
+++ linux-2.6/drivers/net/wireless/airo.c	2006-07-13 23:25:38.000000000 +0200
@@ -1173,7 +1173,6 @@
 #define FLAG_FLASHING	15
 #define FLAG_WPA_CAPABLE	16
 	unsigned long flags;
-#define JOB_DIE	0
 #define JOB_XMIT	1
 #define JOB_XMIT11	2
 #define JOB_STATS	3
@@ -1191,7 +1190,6 @@
 	struct task_struct *list_bss_task;
 	struct task_struct *airo_thread_task;
 	struct semaphore sem;
-	wait_queue_head_t thr_wait;
 	unsigned long expires;
 	struct {
 		struct sk_buff *skb;
@@ -2182,7 +2180,7 @@
 		set_bit(FLAG_PENDING_XMIT, &priv->flags);
 		netif_stop_queue(dev);
 		set_bit(JOB_XMIT, &priv->jobs);
-		wake_up_interruptible(&priv->thr_wait);
+		wake_up_process(priv->airo_thread_task);
 	} else
 		airo_end_xmit(dev);
 	return 0;
@@ -2253,7 +2251,7 @@
 		set_bit(FLAG_PENDING_XMIT11, &priv->flags);
 		netif_stop_queue(dev);
 		set_bit(JOB_XMIT11, &priv->jobs);
-		wake_up_interruptible(&priv->thr_wait);
+		wake_up_process(priv->airo_thread_task);
 	} else
 		airo_end_xmit11(dev);
 	return 0;
@@ -2295,7 +2293,7 @@
 		/* Get stats out of the card if available */
 		if (down_trylock(&local->sem) != 0) {
 			set_bit(JOB_STATS, &local->jobs);
-			wake_up_interruptible(&local->thr_wait);
+			wake_up_process(local->airo_thread_task);
 		} else
 			airo_read_stats(local);
 	}
@@ -2322,7 +2320,7 @@
 		change_bit(FLAG_PROMISC, &ai->flags);
 		if (down_trylock(&ai->sem) != 0) {
 			set_bit(JOB_PROMISC, &ai->jobs);
-			wake_up_interruptible(&ai->thr_wait);
+			wake_up_process(ai->airo_thread_task);
 		} else
 			airo_set_promisc(ai);
 	}
@@ -2399,7 +2397,6 @@
 		}
 		clear_bit(FLAG_REGISTERED, &ai->flags);
 	}
-	set_bit(JOB_DIE, &ai->jobs);
 	kthread_stop(ai->airo_thread_task);
 
 	/*
@@ -2809,7 +2806,6 @@
 	sema_init(&ai->sem, 1);
 	ai->config.len = 0;
 	ai->pci = pci;
-	init_waitqueue_head (&ai->thr_wait);
 	ai->airo_thread_task = kthread_run(airo_thread, dev, dev->name);
 	if (IS_ERR(ai->airo_thread_task))
 		goto err_out_free;
@@ -2927,7 +2923,6 @@
 err_out_unlink:
 	del_airo_dev(dev);
 err_out_thr:
-	set_bit(JOB_DIE, &ai->jobs);
 	kthread_stop(ai->airo_thread_task);
 err_out_free:
 	free_netdev(dev);
@@ -3055,70 +3050,52 @@
 	wireless_send_event(ai->dev, SIOCGIWSCAN, &wrqu, NULL);
 }
 
-static int airo_thread(void *data) {
+static int airo_thread(void *data)
+{
 	struct net_device *dev = data;
 	struct airo_info *ai = dev->priv;
-	int locked;
 	
-	while(1) {
+	while (1) {
 		/* make swsusp happy with our thread */
 		try_to_freeze();
 
-		if (test_bit(JOB_DIE, &ai->jobs))
-			break;
+		for (;;) {
+			unsigned long wake_at;
 
-		if (ai->jobs) {
-			locked = down_interruptible(&ai->sem);
-		} else {
-			wait_queue_t wait;
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (kthread_should_stop())
+				break;
+			if (ai->jobs)
+				break;
+			if (ai->scan_timeout &&
+			    time_after_eq(jiffies, ai->scan_timeout)) {
+				set_bit(JOB_SCAN_RESULTS, &ai->jobs);
+				break;
+			}
 
-			init_waitqueue_entry(&wait, current);
-			add_wait_queue(&ai->thr_wait, &wait);
-			for (;;) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				if (ai->jobs)
-					break;
-				if (ai->expires || ai->scan_timeout) {
-					if (ai->scan_timeout &&
-							time_after_eq(jiffies,ai->scan_timeout)){
-						set_bit(JOB_SCAN_RESULTS, &ai->jobs);
-						break;
-					} else if (ai->expires &&
-							time_after_eq(jiffies,ai->expires)){
-						set_bit(JOB_AUTOWEP, &ai->jobs);
-						break;
-					}
-					if (!kthread_should_stop()) {
-						unsigned long wake_at;
-						if (!ai->expires || !ai->scan_timeout) {
-							wake_at = max(ai->expires,
-								ai->scan_timeout);
-						} else {
-							wake_at = min(ai->expires,
-								ai->scan_timeout);
-						}
-						schedule_timeout(wake_at - jiffies);
-						continue;
-					}
-				} else if (!kthread_should_stop()) {
-					schedule();
-					continue;
-				}
+			if (ai->expires &&
+			    time_after_eq(jiffies, ai->expires)){
+				set_bit(JOB_AUTOWEP, &ai->jobs);
 				break;
 			}
-			current->state = TASK_RUNNING;
-			remove_wait_queue(&ai->thr_wait, &wait);
-			locked = 1;
-		}
 
-		if (locked)
-			continue;
+			if (ai->expires && ai->scan_timeout)
+				wake_at = min(ai->expires, ai->scan_timeout);
+			else if (ai->expires || ai->scan_timeout)
+				wake_at = max(ai->expires, ai->scan_timeout);
+			else
+				wake_at = MAX_SCHEDULE_TIMEOUT;
 
-		if (test_bit(JOB_DIE, &ai->jobs)) {
-			up(&ai->sem);
-			break;
+			schedule_timeout(wake_at - jiffies);
 		}
 
+		__set_current_state(TASK_RUNNING);
+		if (kthread_should_stop())
+			break;
+
+		if (down_interruptible(&ai->sem)) 
+			continue;
+
 		if (ai->power.event || test_bit(FLAG_FLASHING, &ai->flags)) {
 			up(&ai->sem);
 			continue;
@@ -3180,7 +3157,7 @@
 			OUT4500( apriv, EVACK, EV_MIC );
 			if (test_bit(FLAG_MIC_CAPABLE, &apriv->flags)) {
 				set_bit(JOB_MIC, &apriv->jobs);
-				wake_up_interruptible(&apriv->thr_wait);
+				wake_up_process(apriv->airo_thread_task);
 			}
 		}
 		if ( status & EV_LINK ) {
@@ -3234,13 +3211,13 @@
 
 				if (down_trylock(&apriv->sem) != 0) {
 					set_bit(JOB_EVENT, &apriv->jobs);
-					wake_up_interruptible(&apriv->thr_wait);
+					wake_up_process(apriv->airo_thread_task);
 				} else
 					airo_send_event(dev);
 			} else if (!scan_forceloss) {
 				if (auto_wep && !apriv->expires) {
 					apriv->expires = RUN_AT(3*HZ);
-					wake_up_interruptible(&apriv->thr_wait);
+					wake_up_process(apriv->airo_thread_task);
 				}
 
 				/* Send event to user space */
@@ -3903,7 +3880,7 @@
 
 	if (auto_wep) {
 		ai->expires = RUN_AT(3*HZ);
-		wake_up_interruptible(&ai->thr_wait);
+		wake_up_process(ai->airo_thread_task);
 	}
 
 	return SUCCESS;
@@ -7179,7 +7156,7 @@
 out:
 	up(&ai->sem);
 	if (wake)
-		wake_up_interruptible(&ai->thr_wait);
+		wake_up_process(ai->airo_thread_task);
 	return 0;
 }
 
@@ -7677,7 +7654,7 @@
 		/* Get stats out of the card if available */
 		if (down_trylock(&local->sem) != 0) {
 			set_bit(JOB_WSTATS, &local->jobs);
-			wake_up_interruptible(&local->thr_wait);
+			wake_up_process(local->airo_thread_task);
 		} else
 			airo_read_wireless_stats(local);
 	}
