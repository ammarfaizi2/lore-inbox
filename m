Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbRA2Ppp>; Mon, 29 Jan 2001 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRA2Pp0>; Mon, 29 Jan 2001 10:45:26 -0500
Received: from colorfullife.com ([216.156.138.34]:19724 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132549AbRA2PpS>;
	Mon, 29 Jan 2001 10:45:18 -0500
Message-ID: <3A758DEA.832F605D@colorfullife.com>
Date: Mon, 29 Jan 2001 16:36:10 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] getting rid of tqueue_lock
Content-Type: multipart/mixed;
 boundary="------------67E602F21A95EF7945D44498"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------67E602F21A95EF7945D44498
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I noticed that the tasks queues still rely on the global tqueue_lock
spinlock, instead of a per-taskqueue lock.

The patch is virtually transparent for task queue users: all users
except ieee1394 use DECLARE_TASK_QUEUE.

I admit that the tqueue_lock isn't that often used (numbers from sgi's
lockstat)

* 10000 users/min during 'find / -xdev -uid 4711' (1.2% of all spinlock
calls)
* 60000 users/min during 'dd if=/dev/hda of=/dev/null' (~1.1% of all
spinlock calls).


--
	Manfred
--------------67E602F21A95EF7945D44498
Content-Type: text/plain; charset=us-ascii;
 name="patch-tqueue"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tqueue"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =-pre11
--- 2.4/drivers/char/n_r3964.c	Mon Dec 11 21:57:28 2000
+++ build-2.4/drivers/char/n_r3964.c	Mon Jan 29 14:54:29 2001
@@ -1185,13 +1185,15 @@
     /*
      * Make sure that our task queue isn't activated.  If it
      * is, take it out of the linked list.
+     * FIXME: buggy, another cpu might be in the middle of
+     *		__run_task_queue().
      */
-    spin_lock_irqsave(&tqueue_lock, flags);
+    spin_lock_irqsave(&tq_timer.lock, flags);
     if (pInfo->bh_1.sync)
     	list_del(&pInfo->bh_1.list);
     if (pInfo->bh_2.sync)
     	list_del(&pInfo->bh_2.list);
-    spin_unlock_irqrestore(&tqueue_lock, flags);
+    spin_unlock_irqrestore(&tq_timer.lock, flags);
 
    /* Remove client-structs and message queues: */
     pClient=pInfo->firstClient;
--- 2.4/include/linux/tqueue.h	Thu Jan  4 23:50:46 2001
+++ build-2.4/include/linux/tqueue.h	Mon Jan 29 14:54:29 2001
@@ -42,10 +42,21 @@
 	void *data;			/* argument to function */
 };
 
-typedef struct list_head task_queue;
+typedef struct {
+	struct list_head list;
+	spinlock_t lock;
+} task_queue;
 
-#define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
-#define TQ_ACTIVE(q)		(!list_empty(&q))
+#define TASK_QUEUE_INIT(name) { LIST_HEAD_INIT(name.list), SPIN_LOCK_UNLOCKED }
+
+#define INIT_TASK_QUEUE(ptr) do { \
+	INIT_LIST_HEAD(&(ptr)->list); \
+	spin_lock_init(&(ptr)->lock); \
+} while (0)
+
+
+#define DECLARE_TASK_QUEUE(q)	task_queue q = TASK_QUEUE_INIT(q)
+#define TQ_ACTIVE(q)		(!list_empty(&(q).list))
 
 extern task_queue tq_timer, tq_immediate, tq_disk;
 
@@ -72,20 +83,18 @@
  * interrupt.
  */
 
-extern spinlock_t tqueue_lock;
-
 /*
  * Queue a task on a tq.  Return non-zero if it was successfully
  * added.
  */
-static inline int queue_task(struct tq_struct *bh_pointer, task_queue *bh_list)
+static inline int queue_task(struct tq_struct *bh_pointer, task_queue *tq)
 {
 	int ret = 0;
 	if (!test_and_set_bit(0,&bh_pointer->sync)) {
 		unsigned long flags;
-		spin_lock_irqsave(&tqueue_lock, flags);
-		list_add_tail(&bh_pointer->list, bh_list);
-		spin_unlock_irqrestore(&tqueue_lock, flags);
+		spin_lock_irqsave(&tq->lock, flags);
+		list_add_tail(&bh_pointer->list, &tq->list);
+		spin_unlock_irqrestore(&tq->lock, flags);
 		ret = 1;
 	}
 	return ret;
@@ -97,10 +106,10 @@
 
 extern void __run_task_queue(task_queue *list);
 
-static inline void run_task_queue(task_queue *list)
+static inline void run_task_queue(task_queue *tq)
 {
-	if (TQ_ACTIVE(*list))
-		__run_task_queue(list);
+	if (TQ_ACTIVE(*tq))
+		__run_task_queue(tq);
 }
 
 #endif /* _LINUX_TQUEUE_H */
--- 2.4/kernel/timer.c	Sun Dec 10 18:53:19 2000
+++ build-2.4/kernel/timer.c	Mon Jan 29 14:54:29 2001
@@ -323,8 +323,6 @@
 	spin_unlock_irq(&timerlist_lock);
 }
 
-spinlock_t tqueue_lock = SPIN_LOCK_UNLOCKED;
-
 void tqueue_bh(void)
 {
 	run_task_queue(&tq_timer);
--- 2.4/kernel/ksyms.c	Mon Jan 29 14:53:44 2001
+++ build-2.4/kernel/ksyms.c	Mon Jan 29 14:54:29 2001
@@ -372,7 +372,6 @@
 
 #ifdef CONFIG_SMP
 /* Various random spinlocks we want to export */
-EXPORT_SYMBOL(tqueue_lock);
 
 /* Big-Reader lock implementation */
 EXPORT_SYMBOL(__brlock_array);
--- 2.4/kernel/softirq.c	Fri Dec 29 23:07:24 2000
+++ build-2.4/kernel/softirq.c	Mon Jan 29 14:54:29 2001
@@ -289,15 +289,15 @@
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
 }
 
-void __run_task_queue(task_queue *list)
+void __run_task_queue(task_queue *tq)
 {
 	struct list_head head, *next;
 	unsigned long flags;
 
-	spin_lock_irqsave(&tqueue_lock, flags);
-	list_add(&head, list);
-	list_del_init(list);
-	spin_unlock_irqrestore(&tqueue_lock, flags);
+	spin_lock_irqsave(&tq->lock, flags);
+	list_add(&head, &tq->list);
+	list_del_init(&tq->list);
+	spin_unlock_irqrestore(&tq->lock, flags);
 
 	next = head.next;
 	while (next != &head) {
--- 2.4/drivers/ieee1394/ieee1394_core.c	Mon Oct  2 04:53:07 2000
+++ build-2.4/drivers/ieee1394/ieee1394_core.c	Mon Jan 29 14:54:29 2001
@@ -100,6 +100,7 @@
 
         INIT_LIST_HEAD(&packet->list);
         sema_init(&packet->state_change, 0);
+        INIT_TASK_QUEUE(&packet->complete_tq);
         packet->state = unused;
         packet->generation = get_hpsb_generation();
         packet->data_be = 1;


--------------67E602F21A95EF7945D44498--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
