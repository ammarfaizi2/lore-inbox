Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTFCAtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFCAtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:49:07 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:23172 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S264540AbTFCAsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:48:38 -0400
Date: Mon, 2 Jun 2003 21:02:13 -0400
Message-Id: <200306030102.h5312Dh06421@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, george@mvista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] preallocate signal queue resource  - Posix timers
Reply-to: jim.houston@attbi.com
--text follows this line--

Hi Linus, Everyone,

Please consider applying this patch.

The attached patch adds a new interface to kernel/signal.c which allows
signals to be sent using preallocated sigqueue structures.  It also
modifies kernel/posix-timers.c to use this interface.  The patch is against
linux-2.5.70.

The current timer code may fail to deliver a timer expiry signal if
there are no sigqueue structures available at the time of the expiry.
The Posix specification is clear that the signal queuing resource should be
allocated at timer_create time.  This allows the error to be returned to
the application rather than silently losing the signal.

This patch does not change the sigqueue structure allocation policy.
I hope to revisit that in another patch.

Here is the definition for the new interface:

struct sigqueue *sigqueue_alloc(void)
	Preallocate a sigqueue structure for use with the functions
	described below.

void sigqueue_free(struct sigqueue *q)
	Free a preallocated sigqueue structure.  If the sigqueue
	structure being freed is still queued, it will be removed 
	from the queue.  I currently leave the signal pending.
	It may be delivered without the siginfo structure.

int send_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
	This function is equivalent to send_sig_info().  It queues
	a signal to the specified thread using  the supplied sigqueue
	structure.  The caller is expected to fill in the siginfo_t
	which is part of the sigqueue structure.

int send_group_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
	This function is equivalent to send_group_sig_info().  It queues
	the signal to a process allowing the system to select which thread
	will receive the signal in a multi-threaded process.
	Again, the sigqueue structure is used to queue the signal.

Both send_sigqueue() and send_group_sigqueue() return 0 if the signal
is queued. They return 1 if the signal was not queued because the 
process is ignoring the signal.

Both versions include code to increment the si_overrun count if the 
sigqueue entry is for a Posix timer and they are called while the 
sigqueue entry is still queued.  Yes, I know that the current code
doesn't rearm the timer until the signal is delivered.  Having this
extra bit of code doesn't do any harm, and I plan to use it.

These routines do not check if there already is a legacy (non-realtime) signal
pending.  They always queue the signal.  This requires that collect_signal()
always checks if there is another matching siginfo before clearing the signal
bit.

Jim Houston - Concurrent Computer Corp.

--


diff -urN -X dontdiff linux-2.5.70.orig/include/linux/init_task.h linux-2.5.70/include/linux/init_task.h
--- linux-2.5.70.orig/include/linux/init_task.h	Fri May 30 15:47:56 2003
+++ linux-2.5.70/include/linux/init_task.h	Sat May 31 19:18:12 2003
@@ -45,7 +45,9 @@
 
 #define INIT_SIGNALS(sig) {	\
 	.count		= ATOMIC_INIT(1), 		\
-	.shared_pending	= { NULL, &sig.shared_pending.head, {{0}}}, \
+	.shared_pending	= { 				\
+		.list = LIST_HEAD_INIT(sig.shared_pending.list),	\
+		.signal =  {{0}}}, \
 }
 
 #define INIT_SIGHAND(sighand) {	\
@@ -97,9 +99,11 @@
 	.files		= &init_files,					\
 	.signal		= &init_signals,				\
 	.sighand	= &init_sighand,				\
-	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
+	.pending	= {						\
+		.list = LIST_HEAD_INIT(tsk.pending.list),		\
+		.signal = {{0}}},					\
 	.blocked	= {{0}},					\
-	 .posix_timers	 = LIST_HEAD_INIT(tsk.posix_timers),		   \
+	.posix_timers	 = LIST_HEAD_INIT(tsk.posix_timers),		\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
diff -urN -X dontdiff linux-2.5.70.orig/include/linux/sched.h linux-2.5.70/include/linux/sched.h
--- linux-2.5.70.orig/include/linux/sched.h	Fri May 30 15:47:56 2003
+++ linux-2.5.70/include/linux/sched.h	Mon Jun  2 09:15:11 2003
@@ -317,6 +317,7 @@
 	unsigned long it_incr;		/* interval specified in jiffies */
 	struct task_struct *it_process;	/* process to send signal to */
 	struct timer_list it_timer;
+	struct sigqueue *sigq;		/* signal queue entry. */
 };
 
 
@@ -571,6 +572,10 @@
 extern int kill_pg(pid_t, int, int);
 extern int kill_sl(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
+extern struct sigqueue *sigqueue_alloc(void);
+extern void sigqueue_free(struct sigqueue *);
+extern int send_sigqueue(int, struct sigqueue *,  struct task_struct *);
+extern int send_group_sigqueue(int, struct sigqueue *,  struct task_struct *);
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
diff -urN -X dontdiff linux-2.5.70.orig/include/linux/signal.h linux-2.5.70/include/linux/signal.h
--- linux-2.5.70.orig/include/linux/signal.h	Fri May 30 15:47:56 2003
+++ linux-2.5.70/include/linux/signal.h	Mon Jun  2 12:45:36 2003
@@ -3,6 +3,7 @@
 
 #include <asm/signal.h>
 #include <asm/siginfo.h>
+#include <linux/list.h>
 
 #ifdef __KERNEL__
 /*
@@ -10,12 +11,17 @@
  */
 
 struct sigqueue {
-	struct sigqueue *next;
+	struct list_head list;
+	spinlock_t *lock;
+	int flags;
 	siginfo_t info;
 };
 
+/* flags values. */
+#define SIGQUEUE_PREALLOC	1
+
 struct sigpending {
-	struct sigqueue *head, **tail;
+	struct list_head list;
 	sigset_t signal;
 };
 
@@ -197,8 +203,7 @@
 static inline void init_sigpending(struct sigpending *sig)
 {
 	sigemptyset(&sig->signal);
-	sig->head = NULL;
-	sig->tail = &sig->head;
+	INIT_LIST_HEAD(&sig->list);
 }
 
 extern long do_sigpending(void __user *, unsigned long);
diff -urN -X dontdiff linux-2.5.70.orig/kernel/posix-timers.c linux-2.5.70/kernel/posix-timers.c
--- linux-2.5.70.orig/kernel/posix-timers.c	Fri May 30 15:47:56 2003
+++ linux-2.5.70/kernel/posix-timers.c	Mon Jun  2 11:29:06 2003
@@ -288,46 +288,32 @@
 
 static void timer_notify_task(struct k_itimer *timr)
 {
-	struct siginfo info;
 	int ret;
 
-	memset(&info, 0, sizeof (info));
+	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
 
 	/* Send signal to the process that owns this timer. */
-	info.si_signo = timr->it_sigev_signo;
-	info.si_errno = 0;
-	info.si_code = SI_TIMER;
-	info.si_tid = timr->it_id;
-	info.si_value = timr->it_sigev_value;
+	timr->sigq->info.si_signo = timr->it_sigev_signo;
+	timr->sigq->info.si_errno = 0;
+	timr->sigq->info.si_code = SI_TIMER;
+	timr->sigq->info.si_tid = timr->it_id;
+	timr->sigq->info.si_value = timr->it_sigev_value;
 	if (timr->it_incr)
-		info.si_sys_private = ++timr->it_requeue_pending;
+		timr->sigq->info.si_sys_private = ++timr->it_requeue_pending;
 
 	if (timr->it_sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV)
-		ret = send_sig_info(info.si_signo, &info, timr->it_process);
+		ret = send_sigqueue(timr->it_sigev_signo, timr->sigq,
+			timr->it_process);
 	else
-		ret = send_group_sig_info(info.si_signo, &info, 
-					  timr->it_process);
-	switch (ret) {
-
-	default:
-		/*
-		 * Signal was not sent.  May or may not need to
-		 * restart the timer.
-		 */
-		printk(KERN_WARNING "sending signal failed: %d\n", ret);
-	case 1:
+		ret = send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
+			timr->it_process);
+	if (ret) {
 		/*
-		 * signal was not sent because of sig_ignor or,
-		 * possibly no queue memory OR will be sent but,
+		 * signal was not sent because of sig_ignor
 		 * we will not get a call back to restart it AND
 		 * it should be restarted.
 		 */
 		schedule_next_timer(timr);
-	case 0:
-		/*
-		 * all's well new signal queued
-		 */
-		break;
 	}
 }
 
@@ -379,7 +365,11 @@
 	struct k_itimer *tmr;
 	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
 	memset(tmr, 0, sizeof (struct k_itimer));
-
+	tmr->it_id = (timer_t)-1;
+	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
+		kmem_cache_free(posix_timers_cache, tmr);
+		tmr = 0;
+	}
 	return tmr;
 }
 
@@ -390,6 +380,7 @@
 		idr_remove(&posix_timers_id, tmr->it_id);
 		spin_unlock_irq(&idr_lock);
 	}
+	sigqueue_free(tmr->sigq);
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
diff -urN -X dontdiff linux-2.5.70.orig/kernel/signal.c linux-2.5.70/kernel/signal.c
--- linux-2.5.70.orig/kernel/signal.c	Fri May 30 15:47:56 2003
+++ linux-2.5.70/kernel/signal.c	Mon Jun  2 20:37:11 2003
@@ -4,6 +4,10 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
  *  1997-11-02  Modified for POSIX.1b signals by Richard Henderson
+ *
+ *  2003-06-02  Jim Houston - Concurrent Computer Corp.
+ *		Changes to use preallocated sigqueue structures
+ *		to allow signals to be sent reliably.
  */
 
 #define __KERNEL_SYSCALLS__
@@ -258,20 +262,38 @@
 	return sig;
 }
 
+struct sigqueue *__sigqueue_alloc(void)
+{
+	struct sigqueue *q = 0;
+
+	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
+	if (q) {
+		atomic_inc(&nr_queued_signals);
+		INIT_LIST_HEAD(&q->list);
+		q->flags = 0;
+		q->lock = 0;
+	}
+	return(q);
+}
+
+static inline void __sigqueue_free(struct sigqueue *q)
+{
+	if (q->flags & SIGQUEUE_PREALLOC)
+		return;
+	kmem_cache_free(sigqueue_cachep, q);
+	atomic_dec(&nr_queued_signals);
+}
+
 static void flush_sigqueue(struct sigpending *queue)
 {
-	struct sigqueue *q, *n;
+	struct sigqueue *q;
 
 	sigemptyset(&queue->signal);
-	q = queue->head;
-	queue->head = NULL;
-	queue->tail = &queue->head;
-
-	while (q) {
-		n = q->next;
-		kmem_cache_free(sigqueue_cachep, q);
-		atomic_dec(&nr_queued_signals);
-		q = n;
+	while (!list_empty(&queue->list)) {
+		q = list_entry(queue->list.next, struct sigqueue , list);
+		list_del_init(&q->list);
+		__sigqueue_free(q);
 	}
 }
 
@@ -411,15 +433,32 @@
 
 static inline int collect_signal(int sig, struct sigpending *list, siginfo_t *info)
 {
-	if (sigismember(&list->signal, sig)) {
-		/* Collect the siginfo appropriate to this signal.  */
-		struct sigqueue *q, **pp;
-		pp = &list->head;
-		while ((q = *pp) != NULL) {
-			if (q->info.si_signo == sig)
-				goto found_it;
-			pp = &q->next;
+	struct sigqueue *q, *first = 0;
+	int still_pending = 0;
+
+	if (unlikely(!sigismember(&list->signal, sig)))
+		return 0;
+
+	/*
+	 * Collect the siginfo appropriate to this signal.  Check if
+	 * there is another siginfo for the same signal.
+	*/
+	list_for_each_entry(q, &list->list, list) {
+		if (q->info.si_signo == sig) {
+			if (first) {
+				still_pending = 1;
+				break;
+			}
+			first = q;
 		}
+	}
+	if (first) {
+		list_del_init(&first->list);
+		copy_siginfo(info, &first->info);
+		__sigqueue_free(first);
+		if (!still_pending)
+			sigdelset(&list->signal, sig);
+	} else {
 
 		/* Ok, it wasn't in the queue.  This must be
 		   a fast-pathed signal or we must have been
@@ -431,31 +470,8 @@
 		info->si_code = 0;
 		info->si_pid = 0;
 		info->si_uid = 0;
-		return 1;
-
-found_it:
-		if ((*pp = q->next) == NULL)
-			list->tail = pp;
-
-		/* Copy the sigqueue information and free the queue entry */
-		copy_siginfo(info, &q->info);
-		kmem_cache_free(sigqueue_cachep,q);
-		atomic_dec(&nr_queued_signals);
-
-		/* Non-RT signals can exist multiple times.. */
-		if (sig >= SIGRTMIN) {
-			while ((q = *pp) != NULL) {
-				if (q->info.si_signo == sig)
-					goto found_another;
-				pp = &q->next;
-			}
-		}
-
-		sigdelset(&list->signal, sig);
-found_another:
-		return 1;
 	}
-	return 0;
+	return 1;
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
@@ -544,25 +560,18 @@
  */
 static int rm_from_queue(unsigned long mask, struct sigpending *s)
 {
-	struct sigqueue *q, **pp;
+	struct sigqueue *q, *n;
 
 	if (!sigtestsetmask(&s->signal, mask))
 		return 0;
 
 	sigdelsetmask(&s->signal, mask);
-
-	pp = &s->head;
-
-	while ((q = *pp) != NULL) {
+	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (q->info.si_signo < SIGRTMIN &&
-		    (mask & sigmask (q->info.si_signo))) {
-			if ((*pp = q->next) == NULL)
-				s->tail = pp;
-			kmem_cache_free(sigqueue_cachep,q);
-			atomic_dec(&nr_queued_signals);
-			continue;
+		    (mask & sigmask(q->info.si_signo))) {
+			list_del_init(&q->list);
+			__sigqueue_free(q);
 		}
-		pp = &q->next;
 	}
 	return 1;
 }
@@ -695,9 +704,8 @@
 
 	if (q) {
 		atomic_inc(&nr_queued_signals);
-		q->next = NULL;
-		*signals->tail = q;
-		signals->tail = &q->next;
+		q->flags = 0;
+		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
 		case 0:
 			q->info.si_signo = sig;
@@ -827,49 +835,11 @@
 	 && !((p)->flags & PF_EXITING)			\
 	 && (task_curr(p) || !signal_pending(p)))
 
-static inline int
-__group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+
+static inline void
+__group_complete_signal(int sig, struct task_struct *p, unsigned int mask)
 {
 	struct task_struct *t;
-	unsigned int mask;
-	int ret = 0;
-
-#ifdef CONFIG_SMP
-	if (!spin_is_locked(&p->sighand->siglock))
-		BUG();
-#endif
-	handle_stop_signal(sig, p);
-
-	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
-		/*
-		 * Set up a return to indicate that we dropped the signal.
-		 */
-		ret = info->si_sys_private;
-
-	/* Short-circuit ignored signals.  */
-	if (sig_ignored(p, sig))
-		return ret;
-
-	if (LEGACY_QUEUE(&p->signal->shared_pending, sig))
-		/* This is a non-RT signal and we already have one queued.  */
-		return ret;
-
-	/*
-	 * Don't bother zombies and stopped tasks (but
-	 * SIGKILL will punch through stopped state)
-	 */
-	mask = TASK_DEAD | TASK_ZOMBIE;
-	if (sig != SIGKILL)
-		mask |= TASK_STOPPED;
-
-	/*
-	 * Put this signal on the shared-pending queue, or fail with EAGAIN.
-	 * We always use the shared queue for process-wide signals,
-	 * to avoid several races.
-	 */
-	ret = send_signal(sig, info, &p->signal->shared_pending);
-	if (unlikely(ret))
-		return ret;
 
 	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
@@ -884,7 +854,7 @@
 		 * There is just one thread and it does not need to be woken.
 		 * It will dequeue unblocked signals before it runs again.
 		 */
-		return 0;
+		return;
 	else {
 		/*
 		 * Otherwise try to find a suitable thread.
@@ -903,7 +873,7 @@
 				 * Any eligible threads will see
 				 * the signal in the queue soon.
 				 */
-				return 0;
+				return;
 		}
 		p->signal->curr_target = t;
 	}
@@ -934,7 +904,7 @@
 				signal_wake_up(t, 1);
 				t = next_thread(t);
 			} while (t != p);
-			return 0;
+			return;
 		}
 
 		/*
@@ -958,7 +928,7 @@
 			t = next_thread(t);
 		} while (t != p);
 		wake_up_process(p->signal->group_exit_task);
-		return 0;
+		return;
 	}
 
 	/*
@@ -966,6 +936,53 @@
 	 * Tell the chosen thread to wake up and dequeue it.
 	 */
 	signal_wake_up(t, sig == SIGKILL);
+	return;
+}
+
+static inline int
+__group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+{
+	unsigned int mask;
+	int ret = 0;
+
+#ifdef CONFIG_SMP
+	if (!spin_is_locked(&p->sighand->siglock))
+		BUG();
+#endif
+	handle_stop_signal(sig, p);
+
+	if (((unsigned long)info > 2) && (info->si_code == SI_TIMER))
+		/*
+		 * Set up a return to indicate that we dropped the signal.
+		 */
+		ret = info->si_sys_private;
+
+	/* Short-circuit ignored signals.  */
+	if (sig_ignored(p, sig))
+		return ret;
+
+	if (LEGACY_QUEUE(&p->signal->shared_pending, sig))
+		/* This is a non-RT signal and we already have one queued.  */
+		return ret;
+
+	/*
+	 * Don't bother zombies and stopped tasks (but
+	 * SIGKILL will punch through stopped state)
+	 */
+	mask = TASK_DEAD | TASK_ZOMBIE;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
+	 * Put this signal on the shared-pending queue, or fail with EAGAIN.
+	 * We always use the shared queue for process-wide signals,
+	 * to avoid several races.
+	 */
+	ret = send_signal(sig, info, &p->signal->shared_pending);
+	if (unlikely(ret))
+		return ret;
+
+	__group_complete_signal(sig, p, mask);
 	return 0;
 }
 
@@ -1195,6 +1212,142 @@
 }
 
 /*
+ * These functions support sending signals using preallocated sigqueue
+ * structures.  This is needed "because realtime applications cannot
+ * afford to lose notifications of asynchronous events, like timer
+ * expirations or I/O completions".  In the case of Posix Timers 
+ * we allocate the sigqueue structure from the timer_create.  If this
+ * allocation fails we are able to report the failure to the application
+ * with an EAGAIN error.
+ */
+ 
+struct sigqueue *sigqueue_alloc(void)
+{
+	struct sigqueue *q;
+
+	if ((q = __sigqueue_alloc()))
+		q->flags |= SIGQUEUE_PREALLOC;
+	return(q);
+}
+
+void sigqueue_free(struct sigqueue *q)
+{
+	unsigned long flags;
+	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	/*
+	 * If the signal is still pending remove it from the
+	 * pending queue.
+	 */
+	if (unlikely(!list_empty(&q->list))) {
+		read_lock(&tasklist_lock);  
+		spin_lock_irqsave(q->lock, flags);
+		if (!list_empty(&q->list))
+			list_del_init(&q->list);
+		spin_unlock_irqrestore(q->lock, flags);
+		read_unlock(&tasklist_lock);
+	}
+	q->flags &= ~SIGQUEUE_PREALLOC;
+	__sigqueue_free(q);
+}
+
+int
+send_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * We need the tasklist lock even for the specific
+	 * thread case (when we don't need to follow the group
+	 * lists) in order to avoid races with "p->sighand"
+	 * going away or changing from under us.
+	 */
+	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	read_lock(&tasklist_lock);  
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	
+	if (unlikely(!list_empty(&q->list))) {
+		/*
+		 * If an SI_TIMER entry is already queue just increment
+		 * the overrun count.
+		 */
+		if (q->info.si_code != SI_TIMER)
+			BUG();
+		q->info.si_overrun++;
+		goto out;
+	} 
+	/* Short-circuit ignored signals.  */
+	if (sig_ignored(p, sig)) {
+		ret = 1;
+		goto out;
+	}
+
+	q->lock = &p->sighand->siglock;
+	list_add_tail(&q->list, &p->pending.list);
+	sigaddset(&p->pending.signal, sig);
+	if (!sigismember(&p->blocked, sig))
+		signal_wake_up(p, sig == SIGKILL);
+
+out:
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	read_unlock(&tasklist_lock);
+	return(ret);
+}
+
+int
+send_group_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
+{
+	unsigned long flags;
+	unsigned int mask;
+	int ret = 0;
+
+	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	read_lock(&tasklist_lock);
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	handle_stop_signal(sig, p);
+
+	/* Short-circuit ignored signals.  */
+	if (sig_ignored(p, sig)) {
+		ret = 1;
+		goto out;
+	}
+
+	if (unlikely(!list_empty(&q->list))) {
+		/*
+		 * If an SI_TIMER entry is already queue just increment
+		 * the overrun count.  Other uses should not try to
+		 * send the signal multiple times.
+		 */
+		if (q->info.si_code != SI_TIMER)
+			BUG();
+		q->info.si_overrun++;
+		goto out;
+	} 
+	/*
+	 * Don't bother zombies and stopped tasks (but
+	 * SIGKILL will punch through stopped state)
+	 */
+	mask = TASK_DEAD | TASK_ZOMBIE;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
+	 * Put this signal on the shared-pending queue.
+	 * We always use the shared queue for process-wide signals,
+	 * to avoid several races.
+	 */
+	q->lock = &p->sighand->siglock;
+	list_add_tail(&q->list, &p->signal->shared_pending.list);
+	sigaddset(&p->signal->shared_pending.signal, sig);
+
+	__group_complete_signal(sig, p, mask);
+out:
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	read_unlock(&tasklist_lock);
+	return(ret);
+}
+
+/*
  * Joy. Or not. Pthread wants us to wake up every thread
  * in our parent group.
  */
@@ -1646,6 +1799,10 @@
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(send_group_sig_info);
+EXPORT_SYMBOL(sigqueue_alloc);
+EXPORT_SYMBOL(sigqueue_free);
+EXPORT_SYMBOL(send_sigqueue);
+EXPORT_SYMBOL(send_group_sigqueue);
 EXPORT_SYMBOL(sigprocmask);
 EXPORT_SYMBOL(block_all_signals);
 EXPORT_SYMBOL(unblock_all_signals);
