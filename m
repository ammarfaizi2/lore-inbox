Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWJ1K65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWJ1K65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWJ1K65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:58:57 -0400
Received: from verein.lst.de ([213.95.11.210]:54190 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1752125AbWJ1K64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:58:56 -0400
Date: Sat, 28 Oct 2006 12:57:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
       Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061028105755.GA20103@lst.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4543162B.7030701@drzeus.cx>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.349 () BAYES_30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 10:34:51AM +0200, Pierre Ossman wrote:
> > It seems that most of the users that are left are for pretty obscure
> > functionality, so I wouldn't expect that to happen so soon. Maybe we
> > should mark it as __deprecated in the declaration?
> > 
> 
> What should be used to replace it? The MMC block driver uses it to
> manage the block device queue. I am not that intimate with the block
> layer so I do not know the proper fix.

kthread_create/kthread_run.  Here's a draft patch (and it's against
a rather old tree and untested due to lack of hardware so it really
should be considered just a draft).


Index: linux-2.6/drivers/mmc/mmc_queue.c
===================================================================
--- linux-2.6.orig/drivers/mmc/mmc_queue.c	2006-10-28 12:48:42.000000000 +0200
+++ linux-2.6/drivers/mmc/mmc_queue.c	2006-10-28 12:57:12.000000000 +0200
@@ -10,12 +10,12 @@
  */
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/kthread.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include "mmc_queue.h"
 
-#define MMC_QUEUE_EXIT		(1 << 0)
 #define MMC_QUEUE_SUSPENDED	(1 << 1)
 
 /*
@@ -59,7 +59,6 @@
 {
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
-	DECLARE_WAITQUEUE(wait, current);
 
 	/*
 	 * Set iothread to ensure that we aren't put to sleep by
@@ -67,12 +66,7 @@
 	 */
 	current->flags |= PF_MEMALLOC|PF_NOFREEZE;
 
-	daemonize("mmcqd");
-
-	complete(&mq->thread_complete);
-
 	down(&mq->thread_sem);
-	add_wait_queue(&mq->thread_wq, &wait);
 	do {
 		struct request *req = NULL;
 
@@ -84,7 +78,7 @@
 		spin_unlock_irq(q->queue_lock);
 
 		if (!req) {
-			if (mq->flags & MMC_QUEUE_EXIT)
+			if (kthread_should_stop())
 				break;
 			up(&mq->thread_sem);
 			schedule();
@@ -95,10 +89,8 @@
 
 		mq->issue_fn(mq, req);
 	} while (1);
-	remove_wait_queue(&mq->thread_wq, &wait);
 	up(&mq->thread_sem);
 
-	complete_and_exit(&mq->thread_complete, 0);
 	return 0;
 }
 
@@ -113,7 +105,7 @@
 	struct mmc_queue *mq = q->queuedata;
 
 	if (!mq->req)
-		wake_up(&mq->thread_wq);
+		wake_up_process(mq->thread);
 }
 
 /**
@@ -152,36 +144,31 @@
 			 GFP_KERNEL);
 	if (!mq->sg) {
 		ret = -ENOMEM;
-		goto cleanup;
+		goto cleanup_queue;
 	}
 
-	init_completion(&mq->thread_complete);
-	init_waitqueue_head(&mq->thread_wq);
 	init_MUTEX(&mq->thread_sem);
 
-	ret = kernel_thread(mmc_queue_thread, mq, CLONE_KERNEL);
-	if (ret >= 0) {
-		wait_for_completion(&mq->thread_complete);
-		init_completion(&mq->thread_complete);
-		ret = 0;
-		goto out;
+	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd");
+	if (IS_ERR(mq->thread)) {
+		ret = PTR_ERR(mq->thread);
+		goto free_sg;
 	}
 
- cleanup:
+	return 0;
+
+ free_sg:
 	kfree(mq->sg);
 	mq->sg = NULL;
-
+ cleanup_queue:
 	blk_cleanup_queue(mq->queue);
- out:
 	return ret;
 }
 EXPORT_SYMBOL(mmc_init_queue);
 
 void mmc_cleanup_queue(struct mmc_queue *mq)
 {
-	mq->flags |= MMC_QUEUE_EXIT;
-	wake_up(&mq->thread_wq);
-	wait_for_completion(&mq->thread_complete);
+	kthread_stop(mq->thread);
 
 	kfree(mq->sg);
 	mq->sg = NULL;
Index: linux-2.6/drivers/mmc/mmc_queue.h
===================================================================
--- linux-2.6.orig/drivers/mmc/mmc_queue.h	2006-10-28 12:49:31.000000000 +0200
+++ linux-2.6/drivers/mmc/mmc_queue.h	2006-10-28 12:54:54.000000000 +0200
@@ -6,8 +6,7 @@
 
 struct mmc_queue {
 	struct mmc_card		*card;
-	struct completion	thread_complete;
-	wait_queue_head_t	thread_wq;
+	struct task_struct	*thread;
 	struct semaphore	thread_sem;
 	unsigned int		flags;
 	struct request		*req;
