Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSKOQnc>; Fri, 15 Nov 2002 11:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbSKOQnb>; Fri, 15 Nov 2002 11:43:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266425AbSKOQmc>;
	Fri, 15 Nov 2002 11:42:32 -0500
Date: Fri, 15 Nov 2002 16:49:27 +0000
From: Matthew Wilcox <willy@debian.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] use thread_info.h in uaccess.h
Message-ID: <20021115164927.G20070@parcelfarce.linux.theplanet.co.uk>
References: <20021115113223.GN18180@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115113223.GN18180@conectiva.com.br>; from acme@conectiva.com.br on Fri, Nov 15, 2002 at 09:32:23AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we're janitoring headers...

This patch removes all the wait_queue handling code from sched.h and puts
it in wait.h with the rest of the wait_queue handling code.  Note that
sched.h must continue to include wait.h for the wait_queue_head_t embedded
in struct task.  However there may be files which only need wait.h now.

diff -urpNX dontdiff linux-2.5.47/include/linux/sched.h linux-2.5.47-wait/include/linux/sched.h
--- linux-2.5.47/include/linux/sched.h	2002-11-15 05:42:21.000000000 -0800
+++ linux-2.5.47-wait/include/linux/sched.h	2002-11-15 05:44:44.000000000 -0800
@@ -488,31 +488,10 @@ extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
-extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
-extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
-extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
-				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
-						    signed long timeout));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
 
-#define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
-#define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
-#define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
-#define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
-#define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
-#define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
-#define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
-#ifdef CONFIG_SMP
-#define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
-#else
-#define wake_up_interruptible_sync(x)   __wake_up((x),TASK_INTERRUPTIBLE, 1)
-#endif
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
@@ -654,10 +633,6 @@ extern task_t *child_reaper;
 extern int do_execve(char *, char **, char **, struct pt_regs *);
 extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
 
-extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
-extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
-extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
-
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
 #else
@@ -665,108 +640,6 @@ extern void wait_task_inactive(task_t * 
 #endif
 extern void kick_if_running(task_t * p);
 
-#define __wait_event(wq, condition) 					\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_UNINTERRUPTIBLE);		\
-		if (condition)						\
-			break;						\
-		schedule();						\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event(wq, condition) 					\
-do {									\
-	if (condition)	 						\
-		break;							\
-	__wait_event(wq, condition);					\
-} while (0)
-
-#define __wait_event_interruptible(wq, condition, ret)			\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_INTERRUPTIBLE);			\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			schedule();					\
-			continue;					\
-		}							\
-		ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event_interruptible(wq, condition)				\
-({									\
-	int __ret = 0;							\
-	if (!(condition))						\
-		__wait_event_interruptible(wq, condition, __ret);	\
-	__ret;								\
-})
-
-#define __wait_event_interruptible_timeout(wq, condition, ret)		\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_INTERRUPTIBLE);			\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			ret = schedule_timeout(ret);			\
-			if (!ret)					\
-				break;					\
-			continue;					\
-		}							\
-		ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event_interruptible_timeout(wq, condition, timeout)	\
-({									\
-	long __ret = timeout;						\
-	if (!(condition))						\
-		__wait_event_interruptible_timeout(wq, condition, __ret); \
-	__ret;								\
-})
-	
-/*
- * Must be called with the spinlock in the wait_queue_head_t held.
- */
-static inline void add_wait_queue_exclusive_locked(wait_queue_head_t *q,
-						   wait_queue_t * wait)
-{
-	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue_tail(q,  wait);
-}
-
-/*
- * Must be called with the spinlock in the wait_queue_head_t held.
- */
-static inline void remove_wait_queue_locked(wait_queue_head_t *q,
-					    wait_queue_t * wait)
-{
-	__remove_wait_queue(q,  wait);
-}
-
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
 
diff -urpNX dontdiff linux-2.5.47/include/linux/wait.h linux-2.5.47-wait/include/linux/wait.h
--- linux-2.5.47/include/linux/wait.h	2002-09-27 20:10:43.000000000 -0700
+++ linux-2.5.47-wait/include/linux/wait.h	2002-11-15 07:36:32.000000000 -0800
@@ -10,14 +10,11 @@
 
 #ifdef __KERNEL__
 
-#include <linux/kernel.h>
+#include <linux/config.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
-#include <linux/config.h>
-
-#include <asm/page.h>
-#include <asm/processor.h>
+#include <asm/system.h>
 
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync);
@@ -83,6 +80,10 @@ static inline int waitqueue_active(wait_
 	return !list_empty(&q->task_list);
 }
 
+extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+
 static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
 {
 	list_add(&new->task_list, &head->task_list);
@@ -103,6 +104,125 @@ static inline void __remove_wait_queue(w
 	list_del(&old->task_list);
 }
 
+extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
+extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+
+#define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
+#define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
+#define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
+#define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
+#define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
+#define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
+#define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
+#ifdef CONFIG_SMP
+#define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#else
+#define wake_up_interruptible_sync(x)   __wake_up((x),TASK_INTERRUPTIBLE, 1)
+#endif
+
+#define __wait_event(wq, condition) 					\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		schedule();						\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event(wq, condition) 					\
+do {									\
+	if (condition)	 						\
+		break;							\
+	__wait_event(wq, condition);					\
+} while (0)
+
+#define __wait_event_interruptible(wq, condition, ret)			\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			schedule();					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible(wq, condition)				\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible(wq, condition, __ret);	\
+	__ret;								\
+})
+
+#define __wait_event_interruptible_timeout(wq, condition, ret)		\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			ret = schedule_timeout(ret);			\
+			if (!ret)					\
+				break;					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_interruptible_timeout(wq, condition, __ret); \
+	__ret;								\
+})
+	
+/*
+ * Must be called with the spinlock in the wait_queue_head_t held.
+ */
+static inline void add_wait_queue_exclusive_locked(wait_queue_head_t *q,
+						   wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(q,  wait);
+}
+
+/*
+ * Must be called with the spinlock in the wait_queue_head_t held.
+ */
+static inline void remove_wait_queue_locked(wait_queue_head_t *q,
+					    wait_queue_t * wait)
+{
+	__remove_wait_queue(q,  wait);
+}
+
 #define add_wait_queue_cond(q, wait, cond) \
 	({							\
 		unsigned long flags;				\
@@ -120,7 +240,19 @@ static inline void __remove_wait_queue(w
 	})
 
 /*
- * Waitqueue's which are removed from the waitqueue_head at wakeup time
+ * These are the old interfaces to sleep waiting for an event.
+ * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
+ * We plan to remove these interfaces during 2.7.
+ */
+extern void FASTCALL(sleep_on(wait_queue_head_t *q));
+extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
+				      signed long timeout));
+extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
+extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
+						    signed long timeout));
+
+/*
+ * Waitqueues which are removed from the waitqueue_head at wakeup time
  */
 void FASTCALL(prepare_to_wait(wait_queue_head_t *q,
 				wait_queue_t *wait, int state));

-- 
Revolutions do not require corporate support.
