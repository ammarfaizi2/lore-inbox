Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVAWXZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVAWXZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVAWXZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:25:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261374AbVAWXXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:23:50 -0500
Date: Sun, 23 Jan 2005 15:23:44 -0800
Message-Id: <200501232323.j0NNNihf006482@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 2/7] posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for thread and process CPU time clocks in
the POSIX clock interface.  Both the existing utime and utime+stime
information (already available via getrusage et al) can be used, as well
as a new (potentially) more precise and accurate clock (which cannot
distinguish user from system time).  The clock used is that provided by
the `sched_clock' function already used internally by the scheduler.
This gives a way for platforms to provide the highest-resolution CPU
time tracking that is available cheaply, and some already do so (such as
x86 using TSC).  Because this clock is already sampled internally by the
scheduler, this new tracking adds only the tiniest new overhead to
accomplish the bookkeeping.

Some notes:

This allows per-thread clocks to be accessed only by other threads in
the same process.  The only POSIX calls that access these are defined
only for in-process use, and having this check is necessary for the
userland implementations of the POSIX clock functions to robustly refuse
stale clockid_t's in the face of potential PID reuse.

This makes no constraint on who can see whose per-process clocks.  This
information is already available for the VIRT and PROF (i.e. utime and
stime) information via /proc.  I am open to suggestions on if/how
security constraints on who can see whose clocks should be imposed.

The SCHED clock information is now available only via clock_* syscalls.
This means that per-thread information is not available outside the process.
Perhaps /proc should show sched_time as well?  This would let ps et al
show this more-accurate information.

When this code is merged, it will be supported in glibc.
I have written the support and added some test programs for glibc, 
which are what I mainly used to test the new kernel code.
You can get those here:
	http://people.redhat.com/roland/glibc/kernel-cpuclocks.patch


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/posix-timers.h
+++ linux-2.6/include/linux/posix-timers.h
@@ -4,6 +4,23 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#define CPUCLOCK_PID(clock)	((pid_t) ~((clock) >> 3))
+#define CPUCLOCK_PERTHREAD(clock) \
+	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+#define CPUCLOCK_PID_MASK	7
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PROF		0
+#define CPUCLOCK_VIRT		1
+#define CPUCLOCK_SCHED		2
+#define CPUCLOCK_MAX		3
+
+#define MAKE_PROCESS_CPUCLOCK(pid, clock) \
+	((~(clockid_t) (pid) << 3) | (clockid_t) (clock))
+#define MAKE_THREAD_CPUCLOCK(tid, clock) \
+	MAKE_PROCESS_CPUCLOCK((tid), (clock) | CPUCLOCK_PERTHREAD_MASK)
+
 /* POSIX.1b interval timer structure. */
 struct k_itimer {
 	struct list_head list;		/* free/ allocate list */
@@ -72,5 +89,18 @@ struct now_struct {
                   (timr)->it_overrun += orun;				\
               }								\
             }while (0)
-#endif
 
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *);
+int posix_cpu_clock_get(clockid_t which_clock, struct timespec *);
+int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp);
+int posix_cpu_timer_create(struct k_itimer *);
+int posix_cpu_nsleep(clockid_t, int, struct timespec *);
+#define posix_cpu_timer_create do_posix_clock_notimer_create
+#define posix_cpu_nsleep do_posix_clock_nonanosleep
+int posix_cpu_timer_set(struct k_itimer *, int,
+			struct itimerspec *, struct itimerspec *);
+int posix_cpu_timer_del(struct k_itimer *);
+void posix_cpu_timer_get(struct k_itimer *, struct itimerspec *);
+
+
+#endif
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -320,6 +320,14 @@ struct signal_struct {
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 
 	/*
+	 * Cumulative ns of scheduled CPU time for dead threads in the
+	 * group, not including a zombie group leader.  (This only differs
+	 * from jiffies_to_ns(utime + stime) if sched_clock uses something
+	 * other than jiffies.)
+	 */
+	unsigned long long sched_time;
+
+	/*
 	 * We don't bother to synchronize most readers of this at all,
 	 * because there is no reader checking a limit that actually needs
 	 * to get both rlim_cur and rlim_max atomically, and either one
@@ -540,6 +548,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
+	unsigned long long sched_time; /* sched_clock time spent running */
 	int activated;
 
 	unsigned long policy;
@@ -749,6 +758,7 @@ static inline int set_cpus_allowed(task_
 #endif
 
 extern unsigned long long sched_clock(void);
+extern unsigned long long current_sched_time(const task_t *current_task);
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -752,6 +752,7 @@ static inline int copy_signal(unsigned l
 	sig->utime = sig->stime = sig->cutime = sig->cstime = cputime_zero;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
+	sig->sched_time = 0;
 
 	task_lock(current->group_leader);
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
@@ -880,6 +881,7 @@ static task_t *copy_process(unsigned lon
 
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
+ 	p->sched_time = 0;
 	p->rchar = 0;		/* I/O counter: bytes read */
 	p->wchar = 0;		/* I/O counter: bytes written */
 	p->syscr = 0;		/* I/O counter: read syscalls */
--- linux-2.6/kernel/Makefile
+++ linux-2.6/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -0,0 +1,288 @@
+/*
+ * Implement CPU time clocks for the POSIX clock interface.
+ */
+
+#include <linux/sched.h>
+#include <linux/posix-timers.h>
+#include <asm/uaccess.h>
+#include <linux/errno.h>
+
+union cpu_time_count {
+	cputime_t cpu;
+	unsigned long long sched;
+};
+
+static int check_clock(clockid_t which_clock)
+{
+	int error = 0;
+	struct task_struct *p;
+	const pid_t pid = CPUCLOCK_PID(which_clock);
+
+	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
+		return -EINVAL;
+
+	if (pid == 0)
+		return 0;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (!p || (CPUCLOCK_PERTHREAD(which_clock) ?
+		   p->tgid != current->tgid : p->tgid != pid)) {
+		error = -EINVAL;
+	}
+	read_unlock(&tasklist_lock);
+
+	return error;
+}
+
+static void sample_to_timespec(clockid_t which_clock,
+			       union cpu_time_count cpu,
+			       struct timespec *tp)
+{
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		tp->tv_sec = div_long_long_rem(cpu.sched,
+					       NSEC_PER_SEC, &tp->tv_nsec);
+	} else {
+		cputime_to_timespec(cpu.cpu, tp);
+	}
+}
+
+static inline cputime_t prof_ticks(struct task_struct *p)
+{
+	return cputime_add(p->utime, p->stime);
+}
+static inline cputime_t virt_ticks(struct task_struct *p)
+{
+	return p->utime;
+}
+static inline unsigned long long sched_ns(struct task_struct *p)
+{
+	return (p == current) ? current_sched_time(p) : p->sched_time;
+}
+
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	int error = check_clock(which_clock);
+	if (!error) {
+		tp->tv_sec = 0;
+		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
+		if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+			/*
+			 * If sched_clock is using a cycle counter, we
+			 * don't have any idea of its true resolution
+			 * exported, but it is much more than 1s/HZ.
+			 */
+			tp->tv_nsec = 1;
+		}
+	}
+	return error;
+}
+
+int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp)
+{
+	/*
+	 * You can never reset a CPU clock, but we check for other errors
+	 * in the call before failing with EPERM.
+	 */
+	int error = check_clock(which_clock);
+	if (error == 0) {
+		error = -EPERM;
+	}
+	return error;
+}
+
+
+/*
+ * Sample a per-thread clock for the given task.
+ */
+static int cpu_clock_sample(clockid_t which_clock, struct task_struct *p,
+			    union cpu_time_count *cpu)
+{
+	switch (CPUCLOCK_WHICH(which_clock)) {
+	default:
+		return -EINVAL;
+	case CPUCLOCK_PROF:
+		cpu->cpu = prof_ticks(p);
+		break;
+	case CPUCLOCK_VIRT:
+		cpu->cpu = virt_ticks(p);
+		break;
+	case CPUCLOCK_SCHED:
+		cpu->sched = sched_ns(p);
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Sample a process (thread group) clock for the given group_leader task.
+ * Must be called with tasklist_lock held for reading.
+ */
+static int cpu_clock_sample_group(clockid_t which_clock,
+				  struct task_struct *p,
+				  union cpu_time_count *cpu)
+{
+	struct task_struct *t = p;
+	unsigned long flags;
+	switch (CPUCLOCK_WHICH(which_clock)) {
+	default:
+		return -EINVAL;
+	case CPUCLOCK_PROF:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		cpu->cpu = cputime_add(p->signal->utime, p->signal->stime);
+		do {
+			cpu->cpu = cputime_add(cpu->cpu, prof_ticks(t));
+			t = next_thread(t);
+		} while (t != p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	case CPUCLOCK_VIRT:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		cpu->cpu = p->signal->utime;
+		do {
+			cpu->cpu = cputime_add(cpu->cpu, virt_ticks(t));
+			t = next_thread(t);
+		} while (t != p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	case CPUCLOCK_SCHED:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		cpu->sched = p->signal->sched_time;
+		/* Add in each other live thread.  */
+		while ((t = next_thread(t)) != p) {
+			cpu->sched += t->sched_time;
+		}
+		if (p->tgid == current->tgid) {
+			/*
+			 * We're sampling ourselves, so include the
+			 * cycles not yet banked.  We still omit
+			 * other threads running on other CPUs,
+			 * so the total can always be behind as
+			 * much as max(nthreads-1,ncpus) * (NSEC_PER_SEC/HZ).
+			 */
+			cpu->sched += current_sched_time(current);
+		} else {
+			cpu->sched += p->sched_time;
+		}
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	}
+	return 0;
+}
+
+
+int posix_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+{
+	const pid_t pid = CPUCLOCK_PID(which_clock);
+	int error = -EINVAL;
+	union cpu_time_count rtn;
+
+	if (pid == 0) {
+		/*
+		 * Special case constant value for our own clocks.
+		 * We don't have to do any lookup to find ourselves.
+		 */
+		if (CPUCLOCK_PERTHREAD(which_clock)) {
+			/*
+			 * Sampling just ourselves we can do with no locking.
+			 */
+			error = cpu_clock_sample(which_clock,
+						 current, &rtn);
+		} else {
+			read_lock(&tasklist_lock);
+			error = cpu_clock_sample_group(which_clock,
+						       current, &rtn);
+			read_unlock(&tasklist_lock);
+		}
+	} else {
+		/*
+		 * Find the given PID, and validate that the caller
+		 * should be able to see it.
+		 */
+		struct task_struct *p;
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(pid);
+		if (p) {
+			if (CPUCLOCK_PERTHREAD(which_clock)) {
+				if (p->tgid == current->tgid) {
+					error = cpu_clock_sample(which_clock,
+								 p, &rtn);
+				}
+			} else if (p->tgid == pid && p->signal) {
+				error = cpu_clock_sample_group(which_clock,
+							       p, &rtn);
+			}
+		}
+		read_unlock(&tasklist_lock);
+	}
+
+	if (error)
+		return error;
+	sample_to_timespec(which_clock, rtn, tp);
+	return 0;
+}
+
+/*
+ * These can't be called, since timer_create never works.
+ */
+int posix_cpu_timer_set(struct k_itimer *timer, int flags,
+			struct itimerspec *old, struct itimerspec *new)
+{
+	BUG();
+	return -EINVAL;
+}
+int posix_cpu_timer_del(struct k_itimer *timer)
+{
+	BUG();
+	return -EINVAL;
+}
+void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec *spec)
+{
+	BUG();
+}
+
+
+#define PROCESS_CLOCK	MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED)
+#define THREAD_CLOCK	MAKE_THREAD_CPUCLOCK(0, CPUCLOCK_SCHED)
+
+static int process_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	return posix_cpu_clock_getres(PROCESS_CLOCK, tp);
+}
+static int process_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+{
+	return posix_cpu_clock_get(PROCESS_CLOCK, tp);
+}
+static int thread_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	return posix_cpu_clock_getres(THREAD_CLOCK, tp);
+}
+static int thread_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+{
+	return posix_cpu_clock_get(THREAD_CLOCK, tp);
+}
+
+
+static __init int init_posix_cpu_timers(void)
+{
+	struct k_clock process = {
+		.clock_getres = process_cpu_clock_getres,
+		.clock_get = process_cpu_clock_get,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep,
+	};
+	struct k_clock thread = {
+		.clock_getres = thread_cpu_clock_getres,
+		.clock_get = thread_cpu_clock_get,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep,
+	};
+
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &thread);
+
+	return 0;
+}
+__initcall(init_posix_cpu_timers);
--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -200,13 +200,15 @@ static inline void unlock_timer(struct k
 
 #ifdef CLOCK_DISPATCH_DIRECT
 #define CLOCK_DISPATCH(clock, call, arglist) \
-	((*posix_clocks[clock].call) arglist)
+	((clock) < 0 ? posix_cpu_##call arglist : \
+	 (*posix_clocks[clock].call) arglist)
 #define DEFHOOK(name)	if (clock->name == NULL) clock->name = common_##name
 #define COMMONDEFN	static
 #else
 #define CLOCK_DISPATCH(clock, call, arglist) \
-	(posix_clocks[clock].call != NULL \
-	 ? (*posix_clocks[clock].call) arglist : common_##call arglist)
+	((clock) < 0 ? posix_cpu_##call arglist : \
+	 (posix_clocks[clock].call != NULL \
+	  ? (*posix_clocks[clock].call) arglist : common_##call arglist))
 #define DEFHOOK(name)		(void) 0 /* Nothing here.  */
 #define COMMONDEFN	static inline
 #endif
@@ -277,6 +279,8 @@ static inline void common_default_hooks(
  */
 static inline int invalid_clockid(clockid_t which_clock)
 {
+	if (which_clock < 0)	/* CPU clock, posix_cpu_* will check it */
+		return 0;
 	if ((unsigned) which_clock >= MAX_CLOCKS)
 		return 1;
 	if (posix_clocks[which_clock].clock_getres != NULL)
--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2235,6 +2235,32 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 EXPORT_PER_CPU_SYMBOL(kstat);
 
 /*
+ * This is called on clock ticks and on context switches.
+ * Bank in p->sched_time the ns elapsed since the last tick or switch.
+ */
+static inline void update_cpu_clock(task_t *p, runqueue_t *rq,
+				    unsigned long long now)
+{
+	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
+	p->sched_time += now - last;
+}
+
+/*
+ * Return current->sched_time plus any more ns on the sched_clock
+ * that have not yet been banked.
+ */
+unsigned long long current_sched_time(const task_t *tsk)
+{
+	unsigned long long ns;
+	unsigned long flags;
+	local_irq_save(flags);
+	ns = max(tsk->timestamp, task_rq(tsk)->timestamp_last_tick);
+	ns = tsk->sched_time + (sched_clock() - ns);
+	local_irq_restore(flags);
+	return ns;
+}
+
+/*
  * We place interactive tasks back into the active array, if possible.
  *
  * To guarantee that this does not starve expired tasks we ignore the
@@ -2408,8 +2434,11 @@ void scheduler_tick(void)
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	unsigned long long now = sched_clock();
+
+	update_cpu_clock(p, rq, now);
 
-	rq->timestamp_last_tick = sched_clock();
+	rq->timestamp_last_tick = now;
 
 	if (p == rq->idle) {
 		if (wake_priority_sleeper(rq))
@@ -2793,6 +2822,8 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
+	update_cpu_clock(prev, rq, now);
+
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -381,6 +381,7 @@ void __exit_signal(struct task_struct *t
 		sig->maj_flt += tsk->maj_flt;
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
+		sig->sched_time += tsk->sched_time;
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
