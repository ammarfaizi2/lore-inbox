Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSFQUOe>; Mon, 17 Jun 2002 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316973AbSFQUOd>; Mon, 17 Jun 2002 16:14:33 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:63726 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316971AbSFQUOc>; Mon, 17 Jun 2002 16:14:32 -0400
Date: Mon, 17 Jun 2002 16:14:34 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617161434.D1457@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This patch against 2.5.22 adds support for wait queue function 
callbacks, which are used by aio to build async read / write 
operations on top of existing wait queues at points that would 
normally block a process.  Comments?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5/v2.5.22-waitqueue-func.diff
diff -urN v2.5.22/include/linux/wait.h wq-func-v2.5.22.diff/include/linux/wait.h
--- v2.5.22/include/linux/wait.h	Mon Jun 10 21:41:10 2002
+++ wq-func-v2.5.22.diff/include/linux/wait.h	Mon Jun 17 15:53:25 2002
@@ -19,13 +19,16 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
+typedef struct __wait_queue wait_queue_t;
+typedef void (*wait_queue_func_t)(wait_queue_t *wait);
+
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
 	struct task_struct * task;
+	wait_queue_func_t func;
 	struct list_head task_list;
 };
-typedef struct __wait_queue wait_queue_t;
 
 struct __wait_queue_head {
 	spinlock_t lock;
@@ -40,6 +43,7 @@
 
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
 	task:		tsk,						\
+	func:		NULL,						\
 	task_list:	{ NULL, NULL } }
 
 #define DECLARE_WAITQUEUE(name, tsk)					\
@@ -62,6 +66,15 @@
 {
 	q->flags = 0;
 	q->task = p;
+	q->func = NULL;
+}
+
+static inline void init_waitqueue_func_entry(wait_queue_t *q,
+					wait_queue_func_t func)
+{
+	q->flags = 0;
+	q->task = NULL;
+	q->func = func;
 }
 
 static inline int waitqueue_active(wait_queue_head_t *q)
@@ -89,6 +102,22 @@
 	list_del(&old->task_list);
 }
 
+#define add_wait_queue_cond(q, wait, cond) \
+	({							\
+		unsigned long flags;				\
+		int _raced = 0;					\
+		wq_write_lock_irqsave(&(q)->lock, flags);	\
+		(wait)->flags = 0;				\
+		__add_wait_queue((q), (wait));			\
+		rmb();						\
+		if (!(cond)) {					\
+			_raced = 1;				\
+			__remove_wait_queue((q), (wait));	\
+		}						\
+		wq_write_unlock_irqrestore(&(q)->lock, flags);	\
+		_raced;						\
+	})
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN v2.5.22/kernel/sched.c wq-func-v2.5.22.diff/kernel/sched.c
--- v2.5.22/kernel/sched.c	Mon Jun 17 15:41:42 2002
+++ wq-func-v2.5.22.diff/kernel/sched.c	Mon Jun 17 16:00:03 2002
@@ -916,13 +916,22 @@
  */
 static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
-	struct list_head *tmp;
+	struct list_head *tmp, *next;
 	unsigned int state;
 	wait_queue_t *curr;
 	task_t *p;
 
-	list_for_each(tmp, &q->task_list) {
+	list_for_each_safe(tmp, next, &q->task_list) {
+		wait_queue_func_t func;
 		curr = list_entry(tmp, wait_queue_t, task_list);
+		func = curr->func;
+		if (func) {
+			unsigned flags = curr->flags;
+			func(curr);
+			if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
+				break;
+			continue;
+		}
 		p = curr->task;
 		state = p->state;
 		if ((state & mode) && try_to_wake_up(p, sync) &&
