Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSFQWJV>; Mon, 17 Jun 2002 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSFQWJU>; Mon, 17 Jun 2002 18:09:20 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:49655 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317059AbSFQWJM>; Mon, 17 Jun 2002 18:09:12 -0400
Date: Mon, 17 Jun 2002 18:09:13 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617180913.I1457@redhat.com>
References: <20020617165340.F1457@redhat.com> <Pine.LNX.4.44.0206171357450.875-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206171357450.875-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Jun 17, 2002 at 02:02:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 02:02:22PM -0700, Linus Torvalds wrote:
> In short, the event "func" could never be NULL, and would always return
> whether the wakeup/event was "successful" from an exclusivity standpoint.

How's the patch below?  The main reason for passing in the pointer to 
the wait queue structure is that the aio functions need to remove 
themselves from the wait list if the event they were waiting for occurs.  
It seems to boot for me, how about others?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."


diff -urN v2.5.22/include/linux/wait.h wq-func-v2.5.22-c.diff/include/linux/wait.h
--- v2.5.22/include/linux/wait.h	Mon Jun 10 21:41:10 2002
+++ wq-func-v2.5.22-c.diff/include/linux/wait.h	Mon Jun 17 17:34:09 2002
@@ -19,13 +19,17 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
+typedef struct __wait_queue wait_queue_t;
+typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
+extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync);
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
@@ -40,13 +44,14 @@
 
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
 	task:		tsk,						\
+	func:		default_wake_function,				\
 	task_list:	{ NULL, NULL } }
 
 #define DECLARE_WAITQUEUE(name, tsk)					\
 	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
-	lock:		SPIN_LOCK_UNLOCKED,			\
+	lock:		SPIN_LOCK_UNLOCKED,				\
 	task_list:	{ &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
@@ -62,6 +67,15 @@
 {
 	q->flags = 0;
 	q->task = p;
+	q->func = default_wake_function;
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
@@ -89,6 +103,22 @@
 	list_del(&old->task_list);
 }
 
+#define add_wait_queue_cond(q, wait, cond) \
+	({							\
+		unsigned long flags;				\
+		int _raced = 0;					\
+		spin_lock_irqsave(&(q)->lock, flags);	\
+		(wait)->flags = 0;				\
+		__add_wait_queue((q), (wait));			\
+		rmb();						\
+		if (!(cond)) {					\
+			_raced = 1;				\
+			__remove_wait_queue((q), (wait));	\
+		}						\
+		spin_lock_irqrestore(&(q)->lock, flags);	\
+		_raced;						\
+	})
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN v2.5.22/kernel/sched.c wq-func-v2.5.22-c.diff/kernel/sched.c
--- v2.5.22/kernel/sched.c	Mon Jun 17 15:41:42 2002
+++ wq-func-v2.5.22-c.diff/kernel/sched.c	Mon Jun 17 17:33:38 2002
@@ -905,6 +905,12 @@
 }
 #endif /* CONFIG_PREEMPT */
 
+int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
+{
+	task_t *p = curr->task;
+	return ((p->state & mode) && try_to_wake_up(p, sync));
+}
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
@@ -916,18 +922,17 @@
  */
 static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
-	struct list_head *tmp;
-	unsigned int state;
-	wait_queue_t *curr;
-	task_t *p;
+	struct list_head *tmp, *next;
 
-	list_for_each(tmp, &q->task_list) {
+	list_for_each_safe(tmp, next, &q->task_list) {
+		wait_queue_t *curr;
+		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
-		p = curr->task;
-		state = p->state;
-		if ((state & mode) && try_to_wake_up(p, sync) &&
-			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
-				break;
+		flags = curr->flags;
+		if (curr->func(curr, mode, sync) &&
+		    (flags & WQ_FLAG_EXCLUSIVE) &&
+		    !--nr_exclusive)
+			break;
 	}
 }
 
