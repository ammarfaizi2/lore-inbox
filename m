Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSKOKur>; Fri, 15 Nov 2002 05:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266093AbSKOKur>; Fri, 15 Nov 2002 05:50:47 -0500
Received: from holomorphy.com ([66.224.33.161]:19150 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266091AbSKOKuo>;
	Fri, 15 Nov 2002 05:50:44 -0500
Date: Fri, 15 Nov 2002 02:54:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: privatize various functions in sched.h
Message-ID: <20021115105403.GS22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a bunch of inlines used only in isolated places from sched.h
sched.h has too bad of a reputation as a "garbage can" header, so this
aims to trim down the noise by taking functions that are private, making
them private, and removing them from sched.h

There are some other rarely used macros and inlines that could also very
well stand to simply be open-coded at the two or three callsites.

(1) task_cpu() / set_task_cpu()
	used only by sched.c and proc_pid_stat(), so privatize to sched.c
	and open-code task->thread_info->cpu in proc_pid_stat(), the sole
	user of task_cpu() outside sched.h
(2) has_pending_signals() is used only in signal.c
	privatize it
(3) eldest_child(), youngest_child(), elder_sibling(), younger_sibling()
	used only in sched.c, except for youngest_child(), which is
	completely unused
	privatize them and remove youngest_child() completely

 fs/proc/array.c       |    2 -
 include/linux/sched.h |   82 --------------------------------------------------
 kernel/sched.c        |   32 +++++++++++++++++++
 kernel/signal.c       |   30 ++++++++++++++++++
 4 files changed, 63 insertions(+), 83 deletions(-)


diff -urpN mm3-2.5.47/fs/proc/array.c cleanup-2.5.47-1/fs/proc/array.c
--- mm3-2.5.47/fs/proc/array.c	2002-11-10 19:28:18.000000000 -0800
+++ cleanup-2.5.47-1/fs/proc/array.c	2002-11-15 01:36:33.000000000 -0800
@@ -389,7 +389,7 @@ int proc_pid_stat(struct task_struct *ta
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task_cpu(task),
+		task->thread_info->cpu,
 		task->rt_priority,
 		task->policy);
 	if(mm)
diff -urpN mm3-2.5.47/include/linux/sched.h cleanup-2.5.47-1/include/linux/sched.h
--- mm3-2.5.47/include/linux/sched.h	2002-11-10 19:28:04.000000000 -0800
+++ cleanup-2.5.47-1/include/linux/sched.h	2002-11-15 01:50:53.000000000 -0800
@@ -545,36 +545,6 @@ extern int kill_proc(pid_t, int, int);
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t *, stack_t *, unsigned long);
 
-/*
- * Re-calculate pending state from the set of locally pending
- * signals, globally pending signals, and blocked signals.
- */
-static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
-{
-	unsigned long ready;
-	long i;
-
-	switch (_NSIG_WORDS) {
-	default:
-		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
-			ready |= signal->sig[i] &~ blocked->sig[i];
-		break;
-
-	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
-		ready |= signal->sig[2] &~ blocked->sig[2];
-		ready |= signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
-	}
-	return ready !=	0;
-}
-
 /* True if we are on the alternate signal stack.  */
 
 static inline int on_sig_stack(unsigned long sp)
@@ -782,30 +752,6 @@ static inline void remove_wait_queue_loc
 	add_parent(p, (p)->parent);				\
 	} while (0)
 
-static inline struct task_struct *eldest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
-}
-
-static inline struct task_struct *youngest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *older_sibling(struct task_struct *p)
-{
-	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *younger_sibling(struct task_struct *p)
-{
-	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
-}
-
 #define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
 #define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
 
@@ -979,34 +925,6 @@ static inline void cond_resched_lock(spi
 extern FASTCALL(void recalc_sigpending_tsk(struct task_struct *t));
 extern void recalc_sigpending(void);
 
-/*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
- */
-#ifdef CONFIG_SMP
-
-static inline unsigned int task_cpu(struct task_struct *p)
-{
-	return p->thread_info->cpu;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-	p->thread_info->cpu = cpu;
-}
-
-#else
-
-static inline unsigned int task_cpu(struct task_struct *p)
-{
-	return 0;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-}
-
-#endif /* CONFIG_SMP */
-
 #endif /* __KERNEL__ */
 
 #endif
diff -urpN mm3-2.5.47/kernel/sched.c cleanup-2.5.47-1/kernel/sched.c
--- mm3-2.5.47/kernel/sched.c	2002-11-14 23:42:02.000000000 -0800
+++ cleanup-2.5.47-1/kernel/sched.c	2002-11-15 01:47:13.000000000 -0800
@@ -162,6 +162,20 @@ struct runqueue {
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
+/*
+ * Wrappers for p->thread_info->cpu access. No-op on UP.
+ */
+#ifdef CONFIG_SMP
+#define task_cpu(task)		({(task)->thread_info->cpu; })
+static inline void set_task_cpu(task_t *task, int cpu)
+{
+	task->thread_info->cpu = cpu;
+}
+#else
+#define task_cpu(task)		0
+#define set_task_cpu(task)	do { } while (0)
+#endif
+
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
@@ -1844,6 +1858,24 @@ out_unlock:
 	return retval;
 }
 
+static inline struct task_struct *eldest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.next,struct task_struct,sibling);
+}
+
+static inline struct task_struct *older_sibling(struct task_struct *p)
+{
+	if (p->sibling.prev==&p->parent->children) return NULL;
+	return list_entry(p->sibling.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *younger_sibling(struct task_struct *p)
+{
+	if (p->sibling.next==&p->parent->children) return NULL;
+	return list_entry(p->sibling.next,struct task_struct,sibling);
+}
+
 static void show_task(task_t * p)
 {
 	unsigned long free = 0;
diff -urpN mm3-2.5.47/kernel/signal.c cleanup-2.5.47-1/kernel/signal.c
--- mm3-2.5.47/kernel/signal.c	2002-11-10 19:28:10.000000000 -0800
+++ cleanup-2.5.47-1/kernel/signal.c	2002-11-15 01:51:09.000000000 -0800
@@ -160,6 +160,36 @@ int max_queued_signals = 1024;
 static int
 __send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 
+/*
+ * Re-calculate pending state from the set of locally pending
+ * signals, globally pending signals, and blocked signals.
+ */
+static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
+{
+	unsigned long ready;
+	long i;
+
+	switch (_NSIG_WORDS) {
+	default:
+		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
+			ready |= signal->sig[i] &~ blocked->sig[i];
+		break;
+
+	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
+		ready |= signal->sig[2] &~ blocked->sig[2];
+		ready |= signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
+	}
+	return ready !=	0;
+}
+
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
 
 void recalc_sigpending_tsk(struct task_struct *t)
