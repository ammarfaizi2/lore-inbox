Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbULNEHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbULNEHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbULNEHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:07:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261393AbULND47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:56:59 -0500
Date: Mon, 13 Dec 2004 19:56:52 -0800
Message-Id: <200412140356.iBE3uqPN008052@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] cpu-timers: CPU clock support for POSIX timers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


POSIX requires that when you claim _POSIX_CPUTIME and _POSIX_THREAD_CPUTIME,
not only the clock_* calls but also timer_* calls must support the thread
and process CPU time clocks.  This patch provides that support, building on
my recent additions to support these clocks in the POSIX clock_* interfaces.
This patch will not work without those changes, as well as the patch fixing
the timer lock-siglock deadlock problem.

The apparent pervasive changes to posix-timers.c are simply that some
fields of struct k_itimer have changed name and moved into a union.
This was appropriate since the data structures required for the existing
real-time timer support and for the new thread/process CPU-time timers are
quite different.

The glibc patches to support CPU time clocks using the new kernel support
is in http://people.redhat.com/roland/glibc/kernel-cpuclocks.patch, and
that includes tests for the timer support (if you build glibc with NPTL).


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/init_task.h
+++ linux-2.6/include/linux/init_task.h
@@ -50,6 +50,7 @@
 		.list = LIST_HEAD_INIT(sig.shared_pending.list),	\
 		.signal =  {{0}}}, \
 	.posix_timers	 = LIST_HEAD_INIT(sig.posix_timers),		\
+	.cpu_timers	= INIT_CPU_TIMERS(sig.cpu_timers),		\
 	.rlim		= INIT_RLIMITS,					\
 }
 
@@ -110,7 +111,15 @@
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 }
 
 
+#define INIT_CPU_TIMERS(cpu_timers)					\
+{									\
+	LIST_HEAD_INIT(cpu_timers[0]),					\
+	LIST_HEAD_INIT(cpu_timers[1]),					\
+	LIST_HEAD_INIT(cpu_timers[2]),					\
+}
+
 
 #endif
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -334,6 +334,8 @@
 	 * have no need to disable irqs.
 	 */
 	struct rlimit rlim[RLIM_NLIMITS];
+
+	struct list_head cpu_timers[3];
 };
 
 /*
@@ -607,6 +609,11 @@
 	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt;
+
+  	unsigned long it_prof_expires, it_virt_expires;
+	unsigned long long it_sched_expires;
+	struct list_head cpu_timers[3];
+
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -761,6 +761,9 @@
 	 */
 	tsk->it_virt_value = 0;
 	tsk->it_prof_value = 0;
+	tsk->it_virt_expires = 0;
+	tsk->it_prof_expires = 0;
+	tsk->it_sched_expires = 0;
 
 	write_unlock_irq(&tasklist_lock);
 
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -753,6 +753,9 @@
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
 	sig->sched_time = 0;
+	INIT_LIST_HEAD(&sig->cpu_timers[0]);
+	INIT_LIST_HEAD(&sig->cpu_timers[1]);
+	INIT_LIST_HEAD(&sig->cpu_timers[2]);
 
 	task_lock(current->group_leader);
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
@@ -876,6 +879,12 @@
 
 	p->utime = p->stime = 0;
 	p->sched_time = 0;
+	p->it_virt_expires = p->it_prof_expires = 0;
+	p->it_sched_expires = 0;
+	INIT_LIST_HEAD(&p->cpu_timers[0]);
+	INIT_LIST_HEAD(&p->cpu_timers[1]);
+	INIT_LIST_HEAD(&p->cpu_timers[2]);
+
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
@@ -1008,6 +1017,16 @@
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
+		if (!list_empty(&current->signal->cpu_timers[0]) ||
+		    !list_empty(&current->signal->cpu_timers[1]) ||
+		    !list_empty(&current->signal->cpu_timers[2])) {
+			/*
+			 * Have child wake up on its first tick to check
+			 * for process CPU timers.
+			 */
+			p->it_prof_expires = 1;
+		}
+
 		spin_unlock(&current->sighand->siglock);
 	}
 
--- linux-2.6/include/linux/posix-timers.h
+++ linux-2.6/include/linux/posix-timers.h
@@ -3,8 +3,21 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sched.h>
 
-#define CPUCLOCK_PID(clock)	((pid_t) ~((clock) >> 3))
+union cpu_time_count {
+	unsigned long cpu;
+	unsigned long long sched;
+};
+
+struct cpu_timer_list {
+	struct list_head entry;
+	union cpu_time_count expires, incr;
+	struct task_struct *task;
+	int firing;
+};
+
+#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
 #define CPUCLOCK_PERTHREAD(clock) \
 	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
 #define CPUCLOCK_PID_MASK	7
@@ -30,15 +43,21 @@ struct k_itimer {
 	int it_overrun;			/* overrun on pending signal  */
 	int it_overrun_last;		/* overrun on last delivered signal */
 	int it_requeue_pending;         /* waiting to requeue this timer */
+#define REQUEUE_PENDING 1
 	int it_sigev_notify;		/* notify word of sigevent struct */
 	int it_sigev_signo;		/* signo word of sigevent struct */
 	sigval_t it_sigev_value;	/* value word of sigevent struct */
-	unsigned long it_incr;		/* interval specified in jiffies */
 	struct task_struct *it_process;	/* process to send signal to */
-	struct timer_list it_timer;
 	struct sigqueue *sigq;		/* signal queue entry. */
-	struct list_head abs_timer_entry; /* clock abs_timer_list */
-	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
+	union {
+		struct {
+			struct timer_list timer;
+			struct list_head abs_timer_entry; /* clock abs_timer_list */
+			struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
+			unsigned long incr; /* interval in jiffies */
+		} real;
+		struct cpu_timer_list cpu;
+	} it;
 };
 
 struct k_clock_abs {
@@ -56,6 +75,7 @@ struct k_clock {
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
 	int (*timer_del) (struct k_itimer * timr);
+#define TIMER_RETRY 1
 	void (*timer_get) (struct k_itimer * timr,
 			   struct itimerspec * cur_setting);
 };
@@ -81,10 +101,11 @@ struct now_struct {
 #define posix_bump_timer(timr, now)					\
          do {								\
               long delta, orun;						\
-	      delta = now.jiffies - (timr)->it_timer.expires;		\
+	      delta = now.jiffies - (timr)->it.real.timer.expires;	\
               if (delta >= 0) {						\
-	           orun = 1 + (delta / (timr)->it_incr);		\
-	          (timr)->it_timer.expires += orun * (timr)->it_incr;	\
+	           orun = 1 + (delta / (timr)->it.real.incr);		\
+	          (timr)->it.real.timer.expires +=			\
+			 orun * (timr)->it.real.incr;			\
                   (timr)->it_overrun += orun;				\
               }								\
             }while (0)
@@ -92,5 +113,18 @@ struct now_struct {
 int posix_cpu_clock_getres(clockid_t, struct timespec __user *);
 int posix_cpu_clock_gettime(clockid_t, struct timespec __user *);
 int posix_cpu_clock_settime(clockid_t, const struct timespec __user *);
+int posix_cpu_clock_nanosleep(clockid_t, int, const struct timespec __user *,
+			      struct timespec __user *);
+
+int posix_cpu_timer_init(struct k_itimer *);
+int posix_cpu_timer_delete(struct k_itimer *);
+void posix_cpu_timer_gettime(struct k_itimer *, struct itimerspec *);
+int posix_cpu_timer_settime(struct k_itimer *, int,
+			    struct itimerspec *, struct itimerspec *);
+void posix_cpu_timer_schedule(struct k_itimer *);
+
+void run_posix_cpu_timers(struct task_struct *);
+void posix_cpu_timers_exit(struct task_struct *);
+void posix_cpu_timers_exit_group(struct task_struct *);
 
 #endif
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -7,11 +7,6 @@
 #include <asm/uaccess.h>
 #include <linux/errno.h>
 
-union cpu_time_count {
-	unsigned long cpu;
-	unsigned long long sched;
-};
-
 static int check_clock(clockid_t which_clock)
 {
 	int error = 0;
@@ -35,6 +30,19 @@ static int check_clock(clockid_t which_c
 	return error;
 }
 
+static inline union cpu_time_count
+timespec_to_sample(clockid_t which_clock, const struct timespec *tp)
+{
+	union cpu_time_count ret;
+	ret.sched = 0;		/* high half always zero when .cpu used */
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		ret.sched = tp->tv_sec * NSEC_PER_SEC + tp->tv_nsec;
+	} else {
+		ret.cpu = timespec_to_jiffies(tp);
+	}
+	return ret;
+}
+
 static void sample_to_timespec(clockid_t which_clock,
 			       union cpu_time_count cpu,
 			       struct timespec *tp)
@@ -56,6 +64,70 @@ static int sample_to_user(clockid_t whic
 	return copy_to_user(tp, &ts, sizeof *tp) ? -EFAULT : 0;
 }
 
+static inline int cpu_time_before(clockid_t which_clock,
+				  union cpu_time_count now,
+				  union cpu_time_count then)
+{
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		return now.sched < then.sched;
+	}  else {
+		return time_before(now.cpu, then.cpu);
+	}
+}
+static inline void cpu_time_add(clockid_t which_clock,
+				union cpu_time_count *acc,
+			        union cpu_time_count val)
+{
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		acc->sched += val.sched;
+	}  else {
+		acc->cpu += val.cpu;
+	}
+}
+static inline union cpu_time_count cpu_time_sub(clockid_t which_clock,
+						union cpu_time_count a,
+						union cpu_time_count b)
+{
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		a.sched -= b.sched;
+	}  else {
+		a.cpu -= b.cpu;
+	}
+	return a;
+}
+
+/*
+ * Update expiry time to from increment, and increase overrun count,
+ * given the current clock sample.
+ */
+static inline void bump_cpu_timer(struct k_itimer *timer,
+				  union cpu_time_count now)
+{
+	if (timer->it.cpu.incr.sched == 0)
+		return;
+
+	if (CPUCLOCK_WHICH(timer->it_clock) == CPUCLOCK_SCHED) {
+		long long delta;
+		delta = now.sched - timer->it.cpu.expires.sched;
+		if (delta >= 0) {
+			do_div(delta, timer->it.cpu.incr.sched);
+			delta++;
+			timer->it.cpu.expires.sched +=
+				delta * timer->it.cpu.incr.sched;
+			timer->it_overrun += (int) delta;
+		}
+	} else {
+		long delta, orun;
+		delta = now.cpu - timer->it.cpu.expires.cpu;
+		if (delta >= 0) {
+			orun = 1 + (delta / timer->it.cpu.incr.cpu);
+			timer->it.cpu.expires.cpu +=
+				orun * timer->it.cpu.incr.cpu;
+			timer->it_overrun += orun;
+		}
+	}
+}
+
 static inline unsigned long prof_ticks(struct task_struct *p)
 {
 	return p->utime + p->stime;
@@ -234,3 +306,1017 @@ int posix_cpu_clock_gettime(clockid_t wh
 		return error;
 	return sample_to_user(which_clock, rtn, tp);
 }
+
+
+/*
+ * Validate the clockid_t for a new CPU-clock timer, and initialize the timer.
+ * This is called from sys_timer_create with the new timer already locked.
+ */
+int posix_cpu_timer_init(struct k_itimer *new_timer)
+{
+	int ret = 0;
+	const pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
+	struct task_struct *p;
+
+	if (CPUCLOCK_WHICH(new_timer->it_clock) >= CPUCLOCK_MAX)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
+	new_timer->it.cpu.incr.sched = 0;
+	new_timer->it.cpu.expires.sched = 0;
+
+	read_lock(&tasklist_lock);
+	if (CPUCLOCK_PERTHREAD(new_timer->it_clock)) {
+		if (pid == 0) {
+			p = current;
+		} else {
+			p = find_task_by_pid(pid);
+			if (p && p->tgid != current->tgid)
+				p = NULL;
+		}
+	} else {
+		if (pid == 0) {
+			p = current->group_leader;
+		} else {
+			p = find_task_by_pid(pid);
+			if (p && p->tgid != pid)
+				p = NULL;
+		}
+	}
+	new_timer->it.cpu.task = p;
+	if (p) {
+		get_task_struct(p);
+	} else {
+		ret = -EINVAL;
+	}
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
+/*
+ * Clean up a CPU-clock timer that is about to be destroyed.
+ * This is called from timer deletion with the timer already locked.
+ * If we return TIMER_RETRY, it's necessary to release the timer's lock
+ * and try again.  (This happens when the timer is in the middle of firing.)
+ */
+int posix_cpu_timer_delete(struct k_itimer *timer)
+{
+	struct task_struct *p = timer->it.cpu.task;
+
+	if (timer->it.cpu.firing)
+		return TIMER_RETRY;
+
+	if (unlikely(p == NULL))
+		return 0;
+
+	if (!list_empty(&timer->it.cpu.entry)) {
+		read_lock(&tasklist_lock);
+		if (unlikely(p->signal == NULL)) {
+			/*
+			 * We raced with the reaping of the task.
+			 * The deletion should have cleared us off the list.
+			 */
+			BUG_ON(!list_empty(&timer->it.cpu.entry));
+		} else {
+			/*
+			 * Take us off the task's timer list.
+			 */
+			spin_lock(&p->sighand->siglock);
+			list_del(&timer->it.cpu.entry);
+			spin_unlock(&p->sighand->siglock);
+		}
+		read_unlock(&tasklist_lock);
+	}
+	put_task_struct(p);
+
+	return 0;
+}
+
+/*
+ * Clean out CPU timers still ticking when a thread exited.  The task
+ * pointer is cleared, and the expiry time is replaced with the residual
+ * time for later timer_gettime calls to return.
+ * This must be called with the siglock held.
+ */
+static void cleanup_timers(struct list_head *head,
+			   unsigned long utime, unsigned long stime,
+			   unsigned long long sched_time)
+{
+	struct cpu_timer_list *timer, *next;
+
+	list_for_each_entry_safe(timer, next, head, entry) {
+		timer->task = NULL;
+		list_del_init(&timer->entry);
+		if (timer->expires.cpu < utime + stime) {
+			timer->expires.cpu = 0;
+		} else {
+			timer->expires.cpu -= utime + stime;
+		}
+	}
+
+	++head;
+	list_for_each_entry_safe(timer, next, head, entry) {
+		timer->task = NULL;
+		list_del_init(&timer->entry);
+		if (timer->expires.cpu < utime) {
+			timer->expires.cpu = 0;
+		} else {
+			timer->expires.cpu -= utime;
+		}
+	}
+
+	++head;
+	list_for_each_entry_safe(timer, next, head, entry) {
+		timer->task = NULL;
+		list_del_init(&timer->entry);
+		if (timer->expires.sched < sched_time) {
+			timer->expires.sched = 0;
+		} else {
+			timer->expires.sched -= sched_time;
+		}
+	}
+}
+
+/*
+ * These are both called with the siglock held, when the current thread
+ * is being reaped.  When the final (leader) thread in the group is reaped,
+ * posix_cpu_timers_exit_group will be called after posix_cpu_timers_exit.
+ */
+void posix_cpu_timers_exit(struct task_struct *tsk)
+{
+	cleanup_timers(tsk->cpu_timers,
+		       tsk->utime, tsk->stime, tsk->sched_time);
+
+}
+void posix_cpu_timers_exit_group(struct task_struct *tsk)
+{
+	cleanup_timers(tsk->signal->cpu_timers,
+		       tsk->utime + tsk->signal->utime,
+		       tsk->stime + tsk->signal->stime,
+		       tsk->sched_time + tsk->signal->sched_time);
+}
+
+
+/*
+ * Set the expiry times of all the threads in the process so one of them
+ * will go off before the process cumulative expiry total is reached.
+ */
+static void
+process_timer_rebalance(struct k_itimer *timer, union cpu_time_count val)
+{
+	unsigned long ticks, left;
+	unsigned long long ns, nsleft;
+	struct task_struct *const p = timer->it.cpu.task, *t = p;
+	unsigned int nthreads = atomic_read(&p->signal->live);
+
+	switch (CPUCLOCK_WHICH(timer->it_clock)) {
+	default:
+		BUG();
+		break;
+	case CPUCLOCK_PROF:
+		left = (timer->it.cpu.expires.cpu - val.cpu) / nthreads;
+		do {
+			if (!unlikely(t->exit_state)) {
+				ticks = prof_ticks(t) + left;
+				if (t->it_prof_expires == 0 ||
+				    time_after(t->it_prof_expires, ticks)) {
+					t->it_prof_expires = ticks;
+				}
+			}
+			t = next_thread(t);
+		} while (t != p);
+		break;
+	case CPUCLOCK_VIRT:
+		left = (timer->it.cpu.expires.cpu - val.cpu) / nthreads;
+		do {
+			if (!unlikely(t->exit_state)) {
+				ticks = virt_ticks(t) + left;
+				if (t->it_virt_expires == 0 ||
+				    time_after(t->it_virt_expires, ticks)) {
+					t->it_virt_expires = ticks;
+				}
+			}
+			t = next_thread(t);
+		} while (t != p);
+		break;
+	case CPUCLOCK_SCHED:
+		nsleft = timer->it.cpu.expires.sched - val.sched;
+		do_div(nsleft, nthreads);
+		do {
+			if (!unlikely(t->exit_state)) {
+				ns = t->sched_time + nsleft;
+				if (t->it_sched_expires == 0 ||
+				    t->it_sched_expires > ns) {
+					t->it_sched_expires = ns;
+				}
+			}
+			t = next_thread(t);
+		} while (t != p);
+		break;
+	}
+}
+
+static void clear_dead_task(struct k_itimer *timer, union cpu_time_count now)
+{
+	/*
+	 * That's all for this thread or process.
+	 * We leave our residual in expires to be reported.
+	 */
+	put_task_struct(timer->it.cpu.task);
+	timer->it.cpu.task = NULL;
+	timer->it.cpu.expires = cpu_time_sub(timer->it_clock,
+					     timer->it.cpu.expires,
+					     now);
+}
+
+/*
+ * Insert the timer on the appropriate list before any timers that
+ * expire later.  This must be called with the tasklist_lock held
+ * for reading, and interrupts disabled.
+ */
+static void arm_timer(struct k_itimer *timer, union cpu_time_count now)
+{
+	struct task_struct *p = timer->it.cpu.task;
+	struct list_head *head, *listpos;
+	struct cpu_timer_list *const nt = &timer->it.cpu;
+	struct cpu_timer_list *next;
+
+	head = (CPUCLOCK_PERTHREAD(timer->it_clock) ?
+		p->cpu_timers : p->signal->cpu_timers);
+	head += CPUCLOCK_WHICH(timer->it_clock);
+
+	BUG_ON(!irqs_disabled());
+	spin_lock(&p->sighand->siglock);
+
+	listpos = head;
+	if (CPUCLOCK_WHICH(timer->it_clock) == CPUCLOCK_SCHED) {
+		list_for_each_entry(next, head, entry) {
+			if (next->expires.sched > nt->expires.sched) {
+				listpos = &next->entry;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(next, head, entry) {
+			if (time_after(next->expires.cpu, nt->expires.cpu)) {
+				listpos = &next->entry;
+				break;
+			}
+		}
+	}
+	list_add(&nt->entry, listpos);
+
+	if (listpos == head) {
+		/*
+		 * We are the new earliest-expiring timer.
+		 * If we are a thread timer, there can always
+		 * be a process timer telling us to stop earlier.
+		 */
+
+		if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+			switch (CPUCLOCK_WHICH(timer->it_clock)) {
+			default:
+				BUG();
+#define UPDATE_CLOCK(WHICH, c, n)			      		      \
+			case CPUCLOCK_##WHICH: 				      \
+				if (p->it_##c##_expires == 0 ||		      \
+				    p->it_##c##_expires > nt->expires.n) {    \
+					p->it_##c##_expires = nt->expires.n;  \
+				}					      \
+				break
+			UPDATE_CLOCK(PROF, prof, cpu);
+			UPDATE_CLOCK(VIRT, virt, cpu);
+			UPDATE_CLOCK(SCHED, sched, sched);
+#undef UPDATE_CLOCK
+			}
+		} else {
+			/*
+			 * For a process timer, we must balance
+			 * all the live threads' expirations.
+			 */
+			process_timer_rebalance(timer, now);
+		}
+	}
+
+	spin_unlock(&p->sighand->siglock);
+}
+
+/*
+ * The timer is locked, fire it and arrange for its reload.
+ */
+static void cpu_timer_fire(struct k_itimer *timer)
+{
+	if (unlikely(timer->sigq == NULL)) {
+		/*
+		 * This a special case for clock_nanosleep,
+		 * not a normal timer from sys_timer_create.
+		 */
+		wake_up_process(timer->it_process);
+		timer->it.cpu.expires.sched = 0;
+	} else if (timer->it.cpu.incr.sched == 0) {
+		/*
+		 * One-shot timer.  Clear it as soon as it's fired.
+		 */
+		posix_timer_event(timer, 0);
+		timer->it.cpu.expires.sched = 0;
+	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+		/*
+		 * The signal did not get queued because the signal
+		 * was ignored, so we won't get any callback to
+		 * reload the timer.  But we need to keep it
+		 * ticking in case the signal is deliverable next time.
+		 */
+		posix_cpu_timer_schedule(timer);
+	}
+}
+
+/*
+ * Guts of sys_timer_settime for CPU timers.
+ * This is called with the timer locked and interrupts disabled.
+ * If we return TIMER_RETRY, it's necessary to release the timer's lock
+ * and try again.  (This happens when the timer is in the middle of firing.)
+ */
+int posix_cpu_timer_settime(struct k_itimer *timer, int flags,
+			    struct itimerspec *new, struct itimerspec *old)
+{
+	struct task_struct *p = timer->it.cpu.task;
+	union cpu_time_count old_expires, new_expires, val;
+	int ret;
+
+	if (unlikely(p == NULL)) {
+		/*
+		 * Timer refers to a dead task's clock.
+		 */
+		return -ESRCH;
+	}
+
+	new_expires = timespec_to_sample(timer->it_clock, &new->it_value);
+
+	read_lock(&tasklist_lock);
+	/*
+	 * We need the tasklist_lock to protect against reaping that
+	 * clears p->signal.  If p has just been reaped, we can no
+	 * longer get any information about it at all.
+	 */
+	if (unlikely(p->signal == NULL)) {
+		read_unlock(&tasklist_lock);
+		put_task_struct(p);
+		timer->it.cpu.task = NULL;
+		return -ESRCH;
+	}
+
+	/*
+	 * Disarm any old timer after extracting its expiry time.
+	 */
+	BUG_ON(!irqs_disabled());
+	spin_lock(&p->sighand->siglock);
+	old_expires = timer->it.cpu.expires;
+	list_del_init(&timer->it.cpu.entry);
+	spin_unlock(&p->sighand->siglock);
+
+	/*
+	 * We need to sample the current value to convert the new
+	 * value from to relative and absolute, and to convert the
+	 * old value from absolute to relative.  To set a process
+	 * timer, we need a sample to balance the thread expiry
+	 * times (in arm_timer).  With an absolute time, we must
+	 * check if it's already passed.  In short, we need a sample.
+	 */
+	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+		cpu_clock_sample(timer->it_clock, p, &val);
+	} else {
+		cpu_clock_sample_group(timer->it_clock, p, &val);
+	}
+
+	if (old) {
+		if (old_expires.sched == 0) {
+			old->it_value.tv_sec = 0;
+			old->it_value.tv_nsec = 0;
+		} else {
+			/*
+			 * Update the timer in case it has
+			 * overrun already.  If it has,
+			 * we'll report it as having overrun
+			 * and with the next reloaded timer
+			 * already ticking, though we are
+			 * swallowing that pending
+			 * notification here to install the
+			 * new setting.
+			 */
+			bump_cpu_timer(timer, val);
+			if (cpu_time_before(timer->it_clock, val,
+					    timer->it.cpu.expires)) {
+				old_expires = cpu_time_sub(
+					timer->it_clock,
+					timer->it.cpu.expires, val);
+				sample_to_timespec(timer->it_clock,
+						   old_expires,
+						   &old->it_value);
+			} else {
+				old->it_value.tv_nsec = 1;
+				old->it_value.tv_sec = 0;
+			}
+		}
+	}
+
+	if (unlikely(timer->it.cpu.firing)) {
+		/*
+		 * We are colliding with the timer actually firing.
+		 * Punt after filling in the timer's old value, and
+		 * disable this firing since we are already reporting
+		 * it as an overrun (thanks to bump_cpu_timer above).
+		 */
+		read_unlock(&tasklist_lock);
+		timer->it.cpu.firing = -1;
+		ret = TIMER_RETRY;
+		goto out;
+	}
+
+	if (new_expires.sched != 0 && !(flags & TIMER_ABSTIME)) {
+		cpu_time_add(timer->it_clock, &new_expires, val);
+	}
+
+	/*
+	 * Install the new expiry time (or zero).
+	 * For a timer with no notification action, we don't actually
+	 * arm the timer (we'll just fake it for timer_gettime).
+	 */
+	timer->it.cpu.expires = new_expires;
+	if (new_expires.sched != 0 &&
+	    (timer->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE &&
+	    cpu_time_before(timer->it_clock, val, new_expires)) {
+		arm_timer(timer, val);
+	}
+
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Install the new reload setting, and
+	 * set up the signal and overrun bookkeeping.
+	 */
+	timer->it.cpu.incr = timespec_to_sample(timer->it_clock,
+						&new->it_interval);
+
+	/*
+	 * This acts as a modification timestamp for the timer,
+	 * so any automatic reload attempt will punt on seeing
+	 * that we have reset the timer manually.
+	 */
+	timer->it_requeue_pending = (timer->it_requeue_pending + 2) &
+		~REQUEUE_PENDING;
+	timer->it_overrun_last = 0;
+	timer->it_overrun = -1;
+
+	if (new_expires.sched != 0 &&
+	    (timer->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE &&
+	    !cpu_time_before(timer->it_clock, val, new_expires)) {
+		/*
+		 * The designated time already passed, so we notify
+		 * immediately, even if the thread never runs to
+		 * accumulate more time on this clock.
+		 */
+		cpu_timer_fire(timer);
+	}
+
+	ret = 0;
+ out:
+	if (old) {
+		sample_to_timespec(timer->it_clock,
+				   timer->it.cpu.incr, &old->it_interval);
+	}
+	return ret;
+}
+
+void posix_cpu_timer_gettime(struct k_itimer *timer, struct itimerspec *itp)
+{
+	union cpu_time_count now;
+	struct task_struct *p = timer->it.cpu.task;
+	int clear_dead;
+
+	/*
+	 * Easy part: convert the reload time.
+	 */
+	sample_to_timespec(timer->it_clock,
+			   timer->it.cpu.incr, &itp->it_interval);
+
+	if (timer->it.cpu.expires.sched == 0) {	/* Timer not armed at all.  */
+		itp->it_value.tv_sec = itp->it_value.tv_nsec = 0;
+		return;
+	}
+
+	if (unlikely(p == NULL)) {
+		/*
+		 * This task already died and the timer will never fire.
+		 * In this case, expires is actually the dead value.
+		 */
+	dead:
+		sample_to_timespec(timer->it_clock, timer->it.cpu.expires,
+				   &itp->it_value);
+		return;
+	}
+
+	/*
+	 * Sample the clock to take the difference with the expiry time.
+	 */
+	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+		cpu_clock_sample(timer->it_clock, p, &now);
+		clear_dead = p->exit_state;
+	} else {
+		read_lock(&tasklist_lock);
+		if (unlikely(p->signal == NULL)) {
+			/*
+			 * The process has been reaped.
+			 * We can't even collect a sample any more.
+			 * Call the timer disarmed, nothing else to do.
+			 */
+			put_task_struct(p);
+			timer->it.cpu.task = NULL;
+			timer->it.cpu.expires.sched = 0;
+			read_unlock(&tasklist_lock);
+			goto dead;
+		} else {
+			cpu_clock_sample_group(timer->it_clock, p, &now);
+			clear_dead = (unlikely(p->exit_state) &&
+				      thread_group_empty(p));
+		}
+		read_unlock(&tasklist_lock);
+	}
+
+	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
+		if (timer->it.cpu.incr.sched == 0 &&
+		    cpu_time_before(timer->it_clock,
+				    timer->it.cpu.expires, now)) {
+			/*
+			 * Do-nothing timer expired and has no reload,
+			 * so it's as if it was never set.
+			 */
+			timer->it.cpu.expires.sched = 0;
+			itp->it_value.tv_sec = itp->it_value.tv_nsec = 0;
+			return;
+		}
+		/*
+		 * Account for any expirations and reloads that should
+		 * have happened.
+		 */
+		bump_cpu_timer(timer, now);
+	}
+
+	if (unlikely(clear_dead)) {
+		/*
+		 * We've noticed that the thread is dead, but
+		 * not yet reaped.  Take this opportunity to
+		 * drop our task ref.
+		 */
+		clear_dead_task(timer, now);
+		goto dead;
+	}
+
+	if (cpu_time_before(timer->it_clock, now, timer->it.cpu.expires)) {
+		sample_to_timespec(timer->it_clock,
+				   cpu_time_sub(timer->it_clock,
+						timer->it.cpu.expires, now),
+				   &itp->it_value);
+	} else {
+		/*
+		 * The timer should have expired already, but the firing
+		 * hasn't taken place yet.  Say it's just about to expire.
+		 */
+		itp->it_value.tv_nsec = 1;
+		itp->it_value.tv_sec = 0;
+	}
+}
+
+/*
+ * Check for any per-thread CPU timers that have fired and move them off
+ * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
+ * tsk->it_*_expires values to reflect the remaining thread CPU timers.
+ */
+static void check_thread_timers(struct task_struct *tsk,
+				struct list_head *firing)
+{
+	struct list_head *timers = tsk->cpu_timers;
+
+	tsk->it_prof_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (time_before(prof_ticks(tsk), t->expires.cpu)) {
+			tsk->it_prof_expires = t->expires.cpu;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+
+	++timers;
+	tsk->it_virt_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (time_before(virt_ticks(tsk), t->expires.cpu)) {
+			tsk->it_virt_expires = t->expires.cpu;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+
+	++timers;
+	tsk->it_sched_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (tsk->sched_time < t->expires.sched) {
+			tsk->it_sched_expires = t->expires.sched;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+}
+
+/*
+ * Check for any per-thread CPU timers that have fired and move them
+ * off the tsk->*_timers list onto the firing list.  Per-thread timers
+ * have already been taken off.
+ */
+static void check_process_timers(struct task_struct *tsk,
+				 struct list_head *firing)
+{
+	struct signal_struct *const sig = tsk->signal;
+	unsigned long utime, stime, virt_expires, prof_expires;
+	unsigned long long sched_time, sched_expires;
+	struct task_struct *t;
+	struct list_head *timers = sig->cpu_timers;
+
+	/*
+	 * Don't sample the current process CPU clocks if there are no timers.
+	 */
+	if (list_empty(&timers[CPUCLOCK_PROF]) &&
+	    list_empty(&timers[CPUCLOCK_VIRT]) &&
+	    list_empty(&timers[CPUCLOCK_SCHED]))
+		return;
+
+	/*
+	 * Collect the current process totals.
+	 */
+	utime = sig->utime;
+	stime = sig->stime;
+	sched_time = sig->sched_time;
+	t = tsk;
+	do {
+		utime += t->utime;
+		stime += t->stime;
+		sched_time += t->sched_time;
+		t = next_thread(t);
+	} while (t != tsk);
+
+	prof_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (time_before(utime + stime, t->expires.cpu)) {
+			prof_expires = t->expires.cpu;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+
+	++timers;
+	virt_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (time_before(utime, t->expires.cpu)) {
+			virt_expires = t->expires.cpu;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+
+	++timers;
+	sched_expires = 0;
+	while (!list_empty(timers)) {
+		struct cpu_timer_list *t = list_entry(timers->next,
+						      struct cpu_timer_list,
+						      entry);
+		if (sched_time < t->expires.sched) {
+			sched_expires = t->expires.sched;
+			break;
+		}
+		t->firing = 1;
+		list_move_tail(&t->entry, firing);
+	}
+
+	if (prof_expires | virt_expires | sched_expires) {
+		/*
+		 * Rebalance the threads' expiry times for the remaining
+		 * process CPU timers.
+		 */
+
+		unsigned long prof_left, virt_left, ticks;
+		unsigned long long sched_left, sched;
+		const unsigned int nthreads = atomic_read(&sig->live);
+
+		prof_left = (prof_expires - (utime + stime)) / nthreads;
+		virt_left = (virt_expires - utime) / nthreads;
+		if (sched_expires) {
+			sched_left = sched_expires - sched_time;
+			do_div(sched_left, nthreads);
+		} else {
+			sched_left = 0;
+		}
+		t = tsk;
+		do {
+			ticks = t->utime + t->stime + prof_left;
+			if (prof_expires && (t->it_prof_expires == 0 ||
+					     time_after(t->it_prof_expires,
+							ticks))) {
+				t->it_prof_expires = ticks;
+			}
+
+			ticks = t->utime + virt_left;
+			if (virt_expires && (t->it_virt_expires == 0 ||
+					     time_after(t->it_virt_expires,
+							ticks))) {
+				t->it_virt_expires = ticks;
+			}
+
+			sched = t->sched_time + sched_left;
+			if (sched_expires && (t->it_sched_expires == 0 ||
+					      t->it_sched_expires > sched)) {
+				t->it_sched_expires = sched;
+			}
+
+			do {
+				t = next_thread(t);
+			} while (unlikely(t->exit_state));
+		} while (t != tsk);
+	}
+}
+
+/*
+ * This is called from the signal code (via do_schedule_next_timer)
+ * when the last timer signal was delivered and we have to reload the timer.
+ */
+void posix_cpu_timer_schedule(struct k_itimer *timer)
+{
+	struct task_struct *p = timer->it.cpu.task;
+	union cpu_time_count now;
+
+	if (unlikely(p == NULL))
+		/*
+		 * The task was cleaned up already, no future firings.
+		 */
+		return;
+
+	/*
+	 * Fetch the current sample and update the timer's expiry time.
+	 */
+	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+		cpu_clock_sample(timer->it_clock, p, &now);
+		bump_cpu_timer(timer, now);
+		if (unlikely(p->exit_state)) {
+			clear_dead_task(timer, now);
+			return;
+		}
+		read_lock(&tasklist_lock); /* arm_timer needs it.  */
+	} else {
+		read_lock(&tasklist_lock);
+		if (unlikely(p->signal == NULL)) {
+			/*
+			 * The process has been reaped.
+			 * We can't even collect a sample any more.
+			 */
+			put_task_struct(p);
+			timer->it.cpu.task = p = NULL;
+			timer->it.cpu.expires.sched = 0;
+			read_unlock(&tasklist_lock);
+			return;
+		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
+			/*
+			 * We've noticed that the thread is dead, but
+			 * not yet reaped.  Take this opportunity to
+			 * drop our task ref.
+			 */
+			clear_dead_task(timer, now);
+			read_unlock(&tasklist_lock);
+			return;
+		}
+		cpu_clock_sample_group(timer->it_clock, p, &now);
+		bump_cpu_timer(timer, now);
+		/* Leave the tasklist_lock locked for the call below.  */
+	}
+
+	/*
+	 * Now re-arm for the new expiry time.
+	 */
+	arm_timer(timer, now);
+
+	read_unlock(&tasklist_lock);
+}
+
+/*
+ * This is called from the timer interrupt handler.  The irq handler has
+ * already updated our counts.  We need to check if any timers fire now.
+ * Interrupts are disabled.
+ */
+void run_posix_cpu_timers(struct task_struct *tsk)
+{
+	LIST_HEAD(firing);
+	struct k_itimer *timer, *next;
+
+	BUG_ON(!irqs_disabled());
+
+#define UNEXPIRED(clock) \
+		(tsk->it_##clock##_expires == 0 || \
+		 time_before(clock##_ticks(tsk), tsk->it_##clock##_expires))
+
+	if (UNEXPIRED(prof) && UNEXPIRED(virt) &&
+	    (tsk->it_sched_expires == 0 ||
+	     tsk->sched_time < tsk->it_sched_expires))
+		return;
+
+#undef	UNEXPIRED
+
+	BUG_ON(tsk->exit_state);
+
+	/*
+	 * Double-check with locks held.
+	 */
+	read_lock(&tasklist_lock);
+	spin_lock(&tsk->sighand->siglock);
+
+	/*
+	 * Here we take off tsk->cpu_timers[N] and tsk->signal->cpu_timers[N]
+	 * all the timers that are firing, and put them on the firing list.
+	 */
+	check_thread_timers(tsk, &firing);
+	check_process_timers(tsk, &firing);
+
+	/*
+	 * We must release these locks before taking any timer's lock.
+	 * There is a potential race with timer deletion here, as the
+	 * siglock now protects our private firing list.  We have set
+	 * the firing flag in each timer, so that a deletion attempt
+	 * that gets the timer lock before we do will give it up and
+	 * spin until we've taken care of that timer below.
+	 */
+	spin_unlock(&tsk->sighand->siglock);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Now that all the timers on our list have the firing flag,
+	 * noone will touch their list entries but us.  We'll take
+	 * each timer's lock before clearing its firing flag, so no
+	 * timer call will interfere.
+	 */
+	list_for_each_entry_safe(timer, next, &firing, it.cpu.entry) {
+		int firing;
+		spin_lock(&timer->it_lock);
+		list_del_init(&timer->it.cpu.entry);
+		firing = timer->it.cpu.firing;
+		timer->it.cpu.firing = 0;
+		/*
+		 * The firing flag is -1 if we collided with a reset
+		 * of the timer, which already reported this
+		 * almost-firing as an overrun.  So don't generate an event.
+		 */
+		if (likely(firing >= 0)) {
+			cpu_timer_fire(timer);
+		}
+		spin_unlock(&timer->it_lock);
+	}
+}
+
+static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
+
+int posix_cpu_clock_nanosleep(clockid_t which_clock, int flags,
+			      const struct timespec __user *rqtp,
+			      struct timespec __user *rmtp)
+{
+	struct restart_block *restart_block =
+	    &current_thread_info()->restart_block;
+	struct k_itimer timer;
+	struct timespec t;
+	int error;
+
+	if (restart_block->fn == posix_cpu_clock_nanosleep_restart) {
+		/*
+		 * Interrupted by a non-delivered signal.
+		 * The expiry time is stored in arg2 and arg3.
+		 */
+		restart_block->fn = do_no_restart_syscall;
+
+		t.tv_sec = restart_block->arg2;
+		t.tv_nsec = restart_block->arg3;
+	} else {
+		if (copy_from_user(&t, rqtp, sizeof (struct timespec)))
+			return -EFAULT;
+	}
+
+	/*
+	 * Diagnose required errors first.
+	 */
+	if ((unsigned long) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+		return -EINVAL;
+
+	if (CPUCLOCK_PERTHREAD(which_clock) &&
+	    (CPUCLOCK_PID(which_clock) == 0 ||
+	     CPUCLOCK_PID(which_clock) == current->pid))
+		return -EINVAL;
+
+	/*
+	 * Set up a temporary timer and then wait for it to go off.
+	 */
+	memset(&timer, 0, sizeof timer);
+	spin_lock_init(&timer.it_lock);
+	timer.it_clock = which_clock;
+	timer.it_overrun = -1;
+	error = posix_cpu_timer_init(&timer);
+	timer.it_process = current;
+	if (!error) {
+		static struct itimerspec zero_it;
+		struct itimerspec it = { .it_value = t, .it_interval = {} };
+
+		spin_lock_irq(&timer.it_lock);
+		error = posix_cpu_timer_settime(&timer, flags, &it, NULL);
+		if (error) {
+			spin_unlock_irq(&timer.it_lock);
+			return error;
+		}
+
+		while (!signal_pending(current)) {
+			if (timer.it.cpu.expires.sched == 0) {
+				/*
+				 * Our timer fired and was reset.
+				 */
+				spin_unlock_irq(&timer.it_lock);
+				return 0;
+			}
+
+			/*
+			 * Block until cpu_timer_fire (or a signal) wakes us.
+			 */
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&timer.it_lock);
+			schedule();
+			spin_lock_irq(&timer.it_lock);
+		}
+
+		/*
+		 * We were interrupted by a signal.
+		 */
+		sample_to_timespec(which_clock, timer.it.cpu.expires, &t);
+		posix_cpu_timer_settime(&timer, 0, &zero_it, &it);
+		spin_unlock_irq(&timer.it_lock);
+
+		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
+			/*
+			 * It actually did fire already.
+			 */
+			return 0;
+		}
+
+		/*
+		 * Report back to the user the time still remaining.
+		 */
+		if (rmtp != NULL && !(flags & TIMER_ABSTIME) &&
+		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
+			return -EFAULT;
+
+		restart_block->fn = posix_cpu_clock_nanosleep_restart;
+		restart_block->arg0 = which_clock;
+		restart_block->arg1 = (unsigned long)rmtp;
+		restart_block->arg2 = t.tv_sec;
+		restart_block->arg3 = t.tv_nsec;
+
+		error = -ERESTART_RESTARTBLOCK;
+	}
+
+	return error;
+}
+
+
+static long
+posix_cpu_clock_nanosleep_restart(struct restart_block *restart_block)
+{
+	struct timespec __user *t =
+		(struct timespec __user *) restart_block->arg1;
+	int ret = posix_cpu_clock_nanosleep(restart_block->arg0,
+					    TIMER_ABSTIME, t, t);
+
+	if ((ret == -ERESTART_RESTARTBLOCK) && restart_block->arg1 &&
+	    copy_to_user((struct timespec __user *)(restart_block->arg1), &t,
+			 sizeof (t)))
+		return -EFAULT;
+	return ret;
+}
--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -96,14 +96,13 @@ static spinlock_t idr_lock = SPIN_LOCK_U
  * inactive.  It could be in the "fire" routine getting a new expire time.
  */
 #define TIMER_INACTIVE 1
-#define TIMER_RETRY 1
 
 #ifdef CONFIG_SMP
 # define timer_active(tmr) \
-		((tmr)->it_timer.entry.prev != (void *)TIMER_INACTIVE)
+		((tmr)->it.real.timer.entry.prev != (void *)TIMER_INACTIVE)
 # define set_timer_inactive(tmr) \
 		do { \
-			(tmr)->it_timer.entry.prev = (void *)TIMER_INACTIVE; \
+			(tmr)->it.real.timer.entry.prev = (void *)TIMER_INACTIVE; \
 		} while (0)
 #else
 # define timer_active(tmr) BARFY	// error to use outside of SMP
@@ -119,7 +118,6 @@ static spinlock_t idr_lock = SPIN_LOCK_U
 #endif
 
 
-#define REQUEUE_PENDING 1
 /*
  * The timer ID is turned into a timer address by idr_find().
  * Verifying a valid ID consists of:
@@ -271,9 +269,9 @@ static long add_clockset_delta(struct k_
 
 	set_normalized_timespec(&delta,
 				new_wall_to->tv_sec -
-				timr->wall_to_prev.tv_sec,
+				timr->it.real.wall_to_prev.tv_sec,
 				new_wall_to->tv_nsec -
-				timr->wall_to_prev.tv_nsec);
+				timr->it.real.wall_to_prev.tv_nsec);
 	if (likely(!(delta.tv_sec | delta.tv_nsec)))
 		return 0;
 	if (delta.tv_sec < 0) {
@@ -284,16 +282,16 @@ static long add_clockset_delta(struct k_
 		sign++;
 	}
 	tstojiffie(&delta, posix_clocks[timr->it_clock].res, &exp);
-	timr->wall_to_prev = *new_wall_to;
-	timr->it_timer.expires += (sign ? -exp : exp);
+	timr->it.real.wall_to_prev = *new_wall_to;
+	timr->it.real.timer.expires += (sign ? -exp : exp);
 	return 1;
 }
 
 static void remove_from_abslist(struct k_itimer *timr)
 {
-	if (!list_empty(&timr->abs_timer_entry)) {
+	if (!list_empty(&timr->it.real.abs_timer_entry)) {
 		spin_lock(&abs_list.lock);
-		list_del_init(&timr->abs_timer_entry);
+		list_del_init(&timr->it.real.abs_timer_entry);
 		spin_unlock(&abs_list.lock);
 	}
 }
@@ -307,7 +305,7 @@ static void schedule_next_timer(struct k
 	/*
 	 * Set up the timer for the next interval (if there is one).
 	 * Note: this code uses the abs_timer_lock to protect
-	 * wall_to_prev and must hold it until exp is set, not exactly
+	 * it.real.wall_to_prev and must hold it until exp is set, not exactly
 	 * obvious...
 
 	 * This function is used for CLOCK_REALTIME* and
@@ -317,7 +315,7 @@ static void schedule_next_timer(struct k
 	 * "other" CLOCKs "next timer" code (which, I suppose should
 	 * also be added to the k_clock structure).
 	 */
-	if (!timr->it_incr) 
+	if (!timr->it.real.incr)
 		return;
 
 	do {
@@ -326,7 +324,7 @@ static void schedule_next_timer(struct k
 		posix_get_now(&now);
 	} while (read_seqretry(&xtime_lock, seq));
 
-	if (!list_empty(&timr->abs_timer_entry)) {
+	if (!list_empty(&timr->it.real.abs_timer_entry)) {
 		spin_lock(&abs_list.lock);
 		add_clockset_delta(timr, &new_wall_to);
 
@@ -339,7 +337,7 @@ static void schedule_next_timer(struct k
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
 	++timr->it_requeue_pending;
-	add_timer(&timr->it_timer);
+	add_timer(&timr->it.real.timer);
 }
 
 /*
@@ -363,7 +361,10 @@ void do_schedule_next_timer(struct sigin
 	if (!timr || timr->it_requeue_pending != info->si_sys_private)
 		goto exit;
 
-	schedule_next_timer(timr);
+	if (timr->it_clock < 0)	/* CPU clock */
+		posix_cpu_timer_schedule(timr);
+	else
+		schedule_next_timer(timr);
 	info->si_overrun = timr->it_overrun_last;
 exit:
 	if (timr)
@@ -423,7 +424,7 @@ static void posix_timer_fn(unsigned long
 
 	spin_lock_irqsave(&timr->it_lock, flags);
  	set_timer_inactive(timr);
-	if (!list_empty(&timr->abs_timer_entry)) {
+	if (!list_empty(&timr->it.real.abs_timer_entry)) {
 		spin_lock(&abs_list.lock);
 		do {
 			seq = read_seqbegin(&xtime_lock);
@@ -431,9 +432,9 @@ static void posix_timer_fn(unsigned long
 		} while (read_seqretry(&xtime_lock, seq));
 		set_normalized_timespec(&delta,
 					new_wall_to.tv_sec -
-					timr->wall_to_prev.tv_sec,
+					timr->it.real.wall_to_prev.tv_sec,
 					new_wall_to.tv_nsec -
-					timr->wall_to_prev.tv_nsec);
+					timr->it.real.wall_to_prev.tv_nsec);
 		if (likely((delta.tv_sec | delta.tv_nsec ) == 0)) {
 			/* do nothing, timer is on time */
 		} else if (delta.tv_sec < 0) {
@@ -443,9 +444,9 @@ static void posix_timer_fn(unsigned long
 			tstojiffie(&delta,
 				   posix_clocks[timr->it_clock].res,
 				   &exp);
-			timr->wall_to_prev = new_wall_to;
-			timr->it_timer.expires += exp;
-			add_timer(&timr->it_timer);
+			timr->it.real.wall_to_prev = new_wall_to;
+			timr->it.real.timer.expires += exp;
+			add_timer(&timr->it.real.timer);
 			do_notify = 0;
 		}
 		spin_unlock(&abs_list.lock);
@@ -454,7 +455,7 @@ static void posix_timer_fn(unsigned long
 	if (do_notify)  {
 		int si_private=0;
 
-		if (timr->it_incr)
+		if (timr->it.real.incr)
 			si_private = ++timr->it_requeue_pending;
 		else {
 			remove_from_abslist(timr);
@@ -506,7 +507,7 @@ static struct k_itimer * alloc_posix_tim
 	if (!tmr)
 		return tmr;
 	memset(tmr, 0, sizeof (struct k_itimer));
-	INIT_LIST_HEAD(&tmr->abs_timer_entry);
+	INIT_LIST_HEAD(&tmr->it.real.abs_timer_entry);
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = NULL;
@@ -546,7 +547,15 @@ sys_timer_create(clockid_t which_clock,
 	sigevent_t event;
 	int it_id_set = IT_ID_NOT_SET;
 
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	if (which_clock < 0) {
+		/*
+		 * This specifies a CPU clock; check its validity.
+		 */
+		error = posix_cpu_clock_getres(which_clock, NULL);
+		if (error)
+			return error;
+	}
+	else if ((unsigned) which_clock >= MAX_CLOCKS ||
 				!posix_clocks[which_clock].res)
 		return -EINVAL;
 
@@ -579,17 +588,22 @@ sys_timer_create(clockid_t which_clock,
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_incr = 0;
 	new_timer->it_overrun = -1;
-	if (posix_clocks[which_clock].timer_create) {
+
+	if (which_clock < 0) {	/* CPU clock */
+		error = posix_cpu_timer_init(new_timer);
+		if (error)
+			goto out;
+	} else if (posix_clocks[which_clock].timer_create) {
 		error =  posix_clocks[which_clock].timer_create(new_timer);
 		if (error)
 			goto out;
-	} else {
-		init_timer(&new_timer->it_timer);
-		new_timer->it_timer.expires = 0;
-		new_timer->it_timer.data = (unsigned long) new_timer;
-		new_timer->it_timer.function = posix_timer_fn;
+	} else {		/* real time clock */
+		new_timer->it.real.incr = 0;
+		init_timer(&new_timer->it.real.timer);
+		new_timer->it.real.timer.expires = 0;
+		new_timer->it.real.timer.data = (unsigned long) new_timer;
+		new_timer->it.real.timer.function = posix_timer_fn;
 		set_timer_inactive(new_timer);
 	}
 
@@ -748,30 +762,30 @@ do_timer_gettime(struct k_itimer *timr, 
 	struct now_struct now;
 
 	do
-		expires = timr->it_timer.expires;
-	while ((volatile long) (timr->it_timer.expires) != expires);
+		expires = timr->it.real.timer.expires;
+	while ((volatile long) (timr->it.real.timer.expires) != expires);
 
 	posix_get_now(&now);
 
 	if (expires &&
 	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) &&
-	    !timr->it_incr &&
-	    posix_time_before(&timr->it_timer, &now))
-		timr->it_timer.expires = expires = 0;
+	    !timr->it.real.incr &&
+	    posix_time_before(&timr->it.real.timer, &now))
+		timr->it.real.timer.expires = expires = 0;
 	if (expires) {
 		if (timr->it_requeue_pending & REQUEUE_PENDING ||
 		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 			posix_bump_timer(timr, now);
-			expires = timr->it_timer.expires;
+			expires = timr->it.real.timer.expires;
 		}
 		else
-			if (!timer_pending(&timr->it_timer))
+			if (!timer_pending(&timr->it.real.timer))
 				expires = 0;
 		if (expires)
 			expires -= now.jiffies;
 	}
 	jiffies_to_timespec(expires, &cur_setting->it_value);
-	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
+	jiffies_to_timespec(timr->it.real.incr, &cur_setting->it_interval);
 
 	if (cur_setting->it_value.tv_sec < 0) {
 		cur_setting->it_value.tv_nsec = 1;
@@ -791,7 +805,11 @@ sys_timer_gettime(timer_t timer_id, stru
 	if (!timr)
 		return -EINVAL;
 
-	p_timer_get(&posix_clocks[timr->it_clock], timr, &cur_setting);
+	if (timr->it_clock < 0) { /* CPU clock */
+		posix_cpu_timer_gettime(timr, &cur_setting);
+	} else {
+		p_timer_get(&posix_clocks[timr->it_clock], timr, &cur_setting);
+	}
 
 	unlock_timer(timr, flags);
 
@@ -925,13 +943,13 @@ do_timer_settime(struct k_itimer *timr, 
 		do_timer_gettime(timr, old_setting);
 
 	/* disable the timer */
-	timr->it_incr = 0;
+	timr->it.real.incr = 0;
 	/*
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
 #ifdef CONFIG_SMP
-	if (timer_active(timr) && !del_timer(&timr->it_timer))
+	if (timer_active(timr) && !del_timer(&timr->it.real.timer))
 		/*
 		 * It can only be active if on an other cpu.  Since
 		 * we have cleared the interval stuff above, it should
@@ -944,7 +962,7 @@ do_timer_settime(struct k_itimer *timr, 
 
 	set_timer_inactive(timr);
 #else
-	del_timer(&timr->it_timer);
+	del_timer(&timr->it.real.timer);
 #endif
 	remove_from_abslist(timr);
 
@@ -956,29 +974,29 @@ do_timer_settime(struct k_itimer *timr, 
 	 *switch off the timer when it_value is zero
 	 */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec) {
-		timr->it_timer.expires = 0;
+		timr->it.real.timer.expires = 0;
 		return 0;
 	}
 
 	if (adjust_abs_time(clock,
 			    &new_setting->it_value, flags & TIMER_ABSTIME, 
-			    &expire_64, &(timr->wall_to_prev))) {
+			    &expire_64, &(timr->it.real.wall_to_prev))) {
 		return -EINVAL;
 	}
-	timr->it_timer.expires = (unsigned long)expire_64;	
+	timr->it.real.timer.expires = (unsigned long)expire_64;
 	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
-	timr->it_incr = (unsigned long)expire_64;
+	timr->it.real.incr = (unsigned long)expire_64;
 
 	/*
 	 * We do not even queue SIGEV_NONE timers!  But we do put them
 	 * in the abs list so we can do that right.
 	 */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
-		add_timer(&timr->it_timer);
+		add_timer(&timr->it.real.timer);
 
 	if (flags & TIMER_ABSTIME && clock->abs_struct) {
 		spin_lock(&clock->abs_struct->lock);
-		list_add_tail(&(timr->abs_timer_entry),
+		list_add_tail(&(timr->it.real.abs_timer_entry),
 			      &(clock->abs_struct->list));
 		spin_unlock(&clock->abs_struct->lock);
 	}
@@ -1011,7 +1029,9 @@ retry:
 	if (!timr)
 		return -EINVAL;
 
-	if (!posix_clocks[timr->it_clock].timer_set)
+	if (timr->it_clock < 0) /* CPU clock */
+		error = posix_cpu_timer_settime(timr, flags, &new_spec, rtn);
+	else if (!posix_clocks[timr->it_clock].timer_set)
 		error = do_timer_settime(timr, flags, &new_spec, rtn);
 	else
 	        error = posix_clocks[timr->it_clock].timer_set(timr,
@@ -1032,9 +1052,9 @@ retry:
 
 static inline int do_timer_delete(struct k_itimer *timer)
 {
-	timer->it_incr = 0;
+	timer->it.real.incr = 0;
 #ifdef CONFIG_SMP
-	if (timer_active(timer) && !del_timer(&timer->it_timer))
+	if (timer_active(timer) && !del_timer(&timer->it.real.timer))
 		/*
 		 * It can only be active if on an other cpu.  Since
 		 * we have cleared the interval stuff above, it should
@@ -1045,13 +1065,20 @@ static inline int do_timer_delete(struct
 		 */
 		return TIMER_RETRY;
 #else
-	del_timer(&timer->it_timer);
+	del_timer(&timer->it.real.timer);
 #endif
 	remove_from_abslist(timer);
 
 	return 0;
 }
 
+static inline int timer_delete_hook(struct k_itimer *timer)
+{
+	if (timer->it_clock < 0) /* CPU clock */
+		return posix_cpu_timer_delete(timer);
+	return p_timer_del(&posix_clocks[timer->it_clock], timer);
+}
+
 /* Delete a POSIX.1b interval timer. */
 asmlinkage long
 sys_timer_delete(timer_t timer_id)
@@ -1068,14 +1095,13 @@ retry_delete:
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
-
+	error = timer_delete_hook(timer);
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
 		goto retry_delete;
 	}
 #else
-	p_timer_del(&posix_clocks[timer->it_clock], timer);
+	timer_delete_hook(timer);
 #endif
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1107,14 +1133,14 @@ retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
 #ifdef CONFIG_SMP
-	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
+	error = timer_delete_hook(timer);
 
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
 		goto retry_delete;
 	}
 #else
-	p_timer_del(&posix_clocks[timer->it_clock], timer);
+	timer_delete_hook(timer);
 #endif
 	list_del(&timer->list);
 	/*
@@ -1372,13 +1398,13 @@ void clock_was_set(void)
 			break;
 		}
 		timr = list_entry(cws_list.next, struct k_itimer,
-				   abs_timer_entry);
+				  it.real.abs_timer_entry);
 
-		list_del_init(&timr->abs_timer_entry);
+		list_del_init(&timr->it.real.abs_timer_entry);
 		if (add_clockset_delta(timr, &new_wall_to) &&
-		    del_timer(&timr->it_timer))  /* timer run yet? */
-			add_timer(&timr->it_timer);
-		list_add(&timr->abs_timer_entry, &abs_list.list);
+		    del_timer(&timr->it.real.timer))  /* timer run yet? */
+			add_timer(&timr->it.real.timer);
+		list_add(&timr->it.real.abs_timer_entry, &abs_list.list);
 		spin_unlock_irq(&abs_list.lock);
 	} while (1);
 
@@ -1400,8 +1426,9 @@ sys_clock_nanosleep(clockid_t which_cloc
 	    &(current_thread_info()->restart_block);
 	int ret;
 
-	if (which_clock < 0)	/* CPU time clocks */
-		return -EOPNOTSUPP;
+	if (which_clock < 0)
+		return posix_cpu_clock_nanosleep(which_clock,
+						 flags, rqtp, rmtp);
 
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/ptrace.h>
+#include <linux/posix-timers.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -347,7 +348,9 @@ void __exit_signal(struct task_struct *t
 	if (!atomic_read(&sig->count))
 		BUG();
 	spin_lock(&sighand->siglock);
+	posix_cpu_timers_exit(tsk);
 	if (atomic_dec_and_test(&sig->count)) {
+		posix_cpu_timers_exit_group(tsk);
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
--- linux-2.6/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -30,6 +30,7 @@
 #include <linux/thread_info.h>
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 
@@ -864,6 +865,7 @@ void update_process_times(int user_tick)
 	update_one_process(p, user_tick, system, cpu);
 	run_local_timers();
 	scheduler_tick(user_tick, system);
+	run_posix_cpu_timers(p);
 }
 
 /*
