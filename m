Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUEEGJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUEEGJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUEEGJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:09:08 -0400
Received: from holomorphy.com ([207.189.100.168]:11151 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262391AbUEEGIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:08:51 -0400
Date: Tue, 4 May 2004 23:08:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [0/3] filtered wakeups respun
Message-ID: <20040505060849.GW1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040505060612.GV1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505060612.GV1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 11:06:12PM -0700, William Lee Irwin III wrote:
> Same machine/etc. as before, except this time, ext3 instead of ext2.
> ext3 shows noise-level differences in raw throughputs with large
> reductions in cpu overhead, mostly on the read side.

Precisely the same filtered wakeups for pages as before. Drop in a
fresh wakeup primitive that uses a key to discriminate between the
waiters for different objects on a hashed waitqueue, and make the
page waiting functions use it.


-- wli


Index: wake-2.6.6-rc3-mm1/include/linux/wait.h
===================================================================
--- wake-2.6.6-rc3-mm1.orig/include/linux/wait.h	2004-04-03 19:37:07.000000000 -0800
+++ wake-2.6.6-rc3-mm1/include/linux/wait.h	2004-05-04 13:16:00.000000000 -0700
@@ -28,6 +28,11 @@
 	struct list_head task_list;
 };
 
+struct filtered_wait_queue {
+	void *key;
+	wait_queue_t wait;
+};
+
 struct __wait_queue_head {
 	spinlock_t lock;
 	struct list_head task_list;
@@ -104,6 +109,7 @@
 	list_del(&old->task_list);
 }
 
+void FASTCALL(wake_up_filtered(wait_queue_head_t *, void *));
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
@@ -257,6 +263,16 @@
 		wait->func = autoremove_wake_function;			\
 		INIT_LIST_HEAD(&wait->task_list);			\
 	} while (0)
+
+#define DEFINE_FILTERED_WAIT(name, p)					\
+	struct filtered_wait_queue name = {				\
+		.key	= p,						\
+		.wait	=	{					\
+			.task	= current,				\
+			.func	= autoremove_wake_function,		\
+			.task_list = LIST_HEAD_INIT(name.wait.task_list),\
+		},							\
+	}
 	
 #endif /* __KERNEL__ */
 
Index: wake-2.6.6-rc3-mm1/kernel/sched.c
===================================================================
--- wake-2.6.6-rc3-mm1.orig/kernel/sched.c	2004-04-30 15:06:49.000000000 -0700
+++ wake-2.6.6-rc3-mm1/kernel/sched.c	2004-05-04 13:16:00.000000000 -0700
@@ -2518,6 +2518,19 @@
 	}
 }
 
+void fastcall wake_up_filtered(wait_queue_head_t *q, void *key)
+{
+	unsigned long flags;
+	unsigned int mode = TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE;
+	struct filtered_wait_queue *wait, *save;
+	spin_lock_irqsave(&q->lock, flags);
+	list_for_each_entry_safe(wait, save, &q->task_list, wait.task_list) {
+		if (wait->key == key)
+			wait->wait.func(&wait->wait, mode, 0);
+	}
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
 /**
  * __wake_up - wake up threads blocked on a waitqueue.
  * @q: the waitqueue
Index: wake-2.6.6-rc3-mm1/mm/filemap.c
===================================================================
--- wake-2.6.6-rc3-mm1.orig/mm/filemap.c	2004-04-30 15:06:49.000000000 -0700
+++ wake-2.6.6-rc3-mm1/mm/filemap.c	2004-05-04 13:16:00.000000000 -0700
@@ -307,16 +307,16 @@
 void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_FILTERED_WAIT(wait, page);
 
 	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(waitqueue, &wait.wait, TASK_UNINTERRUPTIBLE);
 		if (test_bit(bit_nr, &page->flags)) {
 			sync_page(page);
 			io_schedule();
 		}
 	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	finish_wait(waitqueue, &wait.wait);
 }
 
 EXPORT_SYMBOL(wait_on_page_bit);
@@ -344,7 +344,7 @@
 		BUG();
 	smp_mb__after_clear_bit(); 
 	if (waitqueue_active(waitqueue))
-		wake_up_all(waitqueue);
+		wake_up_filtered(waitqueue, page);
 }
 
 EXPORT_SYMBOL(unlock_page);
@@ -363,7 +363,7 @@
 		smp_mb__after_clear_bit();
 	}
 	if (waitqueue_active(waitqueue))
-		wake_up_all(waitqueue);
+		wake_up_filtered(waitqueue, page);
 }
 
 EXPORT_SYMBOL(end_page_writeback);
@@ -379,16 +379,16 @@
 void fastcall __lock_page(struct page *page)
 {
 	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_FILTERED_WAIT(wait, page);
 
 	while (TestSetPageLocked(page)) {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
 			sync_page(page);
 			io_schedule();
 		}
 	}
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, &wait.wait);
 }
 
 EXPORT_SYMBOL(__lock_page);
