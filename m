Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSIZECq>; Thu, 26 Sep 2002 00:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbSIZECq>; Thu, 26 Sep 2002 00:02:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:36824 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261246AbSIZECo>;
	Thu, 26 Sep 2002 00:02:44 -0400
Message-ID: <3D928813.7EAD7F3C@digeo.com>
Date: Wed, 25 Sep 2002 21:07:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:07:48.0341 (UTC) FILETIME=[46524A50:01C26512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It's worth a whopping 2% on spwecweb on an 8-way.  Which is faintly
surprising because __wake_up and other wait/wakeup functions are not
apparent in the specweb profiles which I've seen.



The main objective of this is to reduce the CPU cost of the wait/wakeup
operation.  When a task is woken up, its waitqueue is removed from the
waitqueue_head by the waker (ie: immediately), rather than by the woken
process.

This means that a subsequent wakeup does not need to revisit the
just-woken task.  It also means that the just-woken task does not need
to take the waitqueue_head's lock, which may well reside in another
CPU's cache.

I have no decent measurements on the effect of this change - possibly a
20-30% drop in __wake_up cost in Badari's 40-dds-to-40-disks test (it
was the most expensive function), but it's inconclusive.  And no
quantitative testing of which I am aware has been performed by
networking people.

The API is very simple to use (Linus thought it up):

my_func(waitqueue_head_t *wqh)
{
	DEFINE_WAIT(wait);

	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
	if (!some_test)
		schedule();
	finish_wait(wqh, &wait);
}

or:

	DEFINE_WAIT(wait);

	while (!some_test_1) {
		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
		if (!some_test_2)
			schedule();
		...
	}
	finish_wait(wqh, &wait);

You need to bear in mind that once prepare_to_wait has been performed,
your task could be removed from the waitqueue_head and placed into
TASK_RUNNING at any time.  You don't know whether or not you're still
on the waitqueue_head.

Running prepare_to_wait() when you're already on the waitqueue_head is
fine - it will do the right thing.

Running finish_wait() when you're actually not on the waitqueue_head is
fine.

Running finish_wait() when you've _never_ been on the waitqueue_head is
fine, as ling as the DEFINE_WAIT() macro was used to initialise the
waitqueue.

You don't need to fiddle with current->state.  prepare_to_wait() and
finish_wait() will do that.  finish_wait() will always return in state
TASK_RUNNING.

There are plenty of usage examples in vm-wakeups.patch and
tcp-wakeups.patch.




 include/linux/wait.h |   26 ++++++++++++++++++++++++++
 kernel/fork.c        |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/ksyms.c       |    4 ++++
 3 files changed, 76 insertions(+)

--- 2.5.38/include/linux/wait.h~prepare_to_wait	Wed Sep 25 20:15:20 2002
+++ 2.5.38-akpm/include/linux/wait.h	Wed Sep 25 20:15:20 2002
@@ -119,6 +119,32 @@ static inline void __remove_wait_queue(w
 		_raced;						\
 	})
 
+/*
+ * Waitqueue's which are removed from the waitqueue_head at wakeup time
+ */
+void FASTCALL(prepare_to_wait(wait_queue_head_t *q,
+				wait_queue_t *wait, int state));
+void FASTCALL(prepare_to_wait_exclusive(wait_queue_head_t *q,
+				wait_queue_t *wait, int state));
+void FASTCALL(finish_wait(wait_queue_head_t *q, wait_queue_t *wait));
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync);
+
+#define DEFINE_WAIT(name)						\
+	wait_queue_t name = {						\
+		.task		= current,				\
+		.func		= autoremove_wake_function,		\
+		.task_list	= {	.next = &name.task_list,	\
+					.prev = &name.task_list,	\
+				},					\
+	}
+
+#define init_wait(wait)							\
+	do {								\
+		wait->task = current;					\
+		wait->func = autoremove_wake_function;			\
+		INIT_LIST_HEAD(&wait->task_list);			\
+	} while (0)
+	
 #endif /* __KERNEL__ */
 
 #endif
--- 2.5.38/kernel/fork.c~prepare_to_wait	Wed Sep 25 20:15:20 2002
+++ 2.5.38-akpm/kernel/fork.c	Wed Sep 25 20:15:20 2002
@@ -103,6 +103,52 @@ void remove_wait_queue(wait_queue_head_t
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
+void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	__set_current_state(state);
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+void
+prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	__set_current_state(state);
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue_tail(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+void finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+	if (!list_empty(&wait->task_list)) {
+		spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync)
+{
+	int ret = default_wake_function(wait, mode, sync);
+
+	if (ret)
+		list_del_init(&wait->task_list);
+	return ret;
+}
+
 void __init fork_init(unsigned long mempages)
 {
 	/* create a slab on which task_structs can be allocated */
--- 2.5.38/kernel/ksyms.c~prepare_to_wait	Wed Sep 25 20:15:20 2002
+++ 2.5.38-akpm/kernel/ksyms.c	Wed Sep 25 20:15:20 2002
@@ -400,6 +400,10 @@ EXPORT_SYMBOL(irq_stat);
 EXPORT_SYMBOL(add_wait_queue);
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 EXPORT_SYMBOL(remove_wait_queue);
+EXPORT_SYMBOL(prepare_to_wait);
+EXPORT_SYMBOL(prepare_to_wait_exclusive);
+EXPORT_SYMBOL(finish_wait);
+EXPORT_SYMBOL(autoremove_wake_function);
 
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);

.
