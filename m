Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbULND6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbULND6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 22:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULND6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 22:58:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261387AbULNDzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:55:23 -0500
Date: Mon, 13 Dec 2004 19:55:07 -0800
Message-Id: <200412140355.iBE3t7KL008040@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>, Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX clock_* syscalls
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

This replaces the support contributed by Christoph Lameter, with the same
goals.  It improves on that support in these ways:

1. The ABI encoding of clockid_t for CPU time clocks is changed.
   The current code encodes PID_MAX_LIMIT as part of the ABI; this is a
   poor ABI, since that has heretofore been an internal implementation
   limit never exposed directly to userland as an ABI constraint.
   The new ABI is expressed in the macros defined in <linux/posix-timers.h>.
   Note that the small-integer constants are not supported by the kernel ABI.
   Userland never wants to pass these anyway, they will always be
   translated by compatibility code in glibc.  The caller's own thread
   or process clock is expressed by using the encoding with a PID of zero.

2. Three clocks available, not one.  The PROF and VIRT clocks are the
   familiar clocks that drive the ITIMER_PROF and ITIMER_VIRTUAL itimers
   of old.  The new SCHED clock is the high-resolution one, usually
   based on CPU cycle counters (but sampled at context switches, so it
   doesn't matter whether multiple CPUs synchronize their counters or
   not).  Moreover, it counts time spent on the CPU directly, rather
   than charging a thread for the whole 1/HZ second period during which
   it was the thread running when the timer interrupt hit.  With the
   existing clocks, a thread can do most of a tick worth of work and
   then yield in time to have someone else get the interrupt, and manage
   to steadily use CPU cycles without registering any utime/stime.

3. The code is cleanly separated into the new file posix-cpu-timers.c;
   the main code punts to posix_cpu_* functions whenever the clockid_t
   has the high bit set.

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
@@ -34,8 +51,7 @@ struct k_clock {
 	int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (int which_clock, int flags,
-		       struct timespec * t);
+	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -48,7 +64,7 @@ void register_posix_clock(int clock_id, 
 
 /* Error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
+int do_posix_clock_nonanosleep(clockid_t, int, struct timespec *);
 int do_posix_clock_nosettime(struct timespec *tp);
 
 /* function to call to trigger timer event */
@@ -72,5 +88,9 @@ struct now_struct {
                   (timr)->it_overrun += orun;				\
               }								\
             }while (0)
-#endif
 
+int posix_cpu_clock_getres(clockid_t, struct timespec __user *);
+int posix_cpu_clock_gettime(clockid_t, struct timespec __user *);
+int posix_cpu_clock_settime(clockid_t, const struct timespec __user *);
+
+#endif
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -314,6 +314,14 @@ struct signal_struct {
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
@@ -526,6 +534,7 @@ struct task_struct {
 	unsigned long sleep_avg;
 	long interactive_credit;
 	unsigned long long timestamp, last_ran;
+	unsigned long long sched_time; /* sched_clock time spent running */
 	int activated;
 
 	unsigned long policy;
@@ -713,6 +722,7 @@ static inline int set_cpus_allowed(task_
 #endif
 
 extern unsigned long long sched_clock(void);
+extern unsigned long long current_sched_time(const task_t *current_task);
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
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
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -746,6 +746,7 @@ static inline int copy_signal(unsigned l
 	sig->utime = sig->stime = sig->cutime = sig->cstime = 0;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
+	sig->sched_time = 0;
 
 	task_lock(current->group_leader);
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
@@ -870,6 +871,7 @@ static task_t *copy_process(unsigned lon
 	p->real_timer.data = (unsigned long) p;
 
 	p->utime = p->stime = 0;
+	p->sched_time = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -138,6 +138,10 @@ static spinlock_t idr_lock = SPIN_LOCK_U
  *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
  *	    1/HZ resolution clock.
  *
+ * CPUTIME: These clocks have clockid_t values < -1.  All the clock
+ *	    and timer system calls here just punt to posix_cpu_*
+ *	    functions defined in posix-cpu-timers.c, which see.
+ *
  * RESOLUTION: Clock resolution is used to round up timer and interval
  *	    times, NOT to report clock times, which are reported with as
  *	    much resolution as the system can muster.  In some cases this
@@ -193,8 +197,6 @@ static int do_posix_gettime(struct k_clo
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
-static int do_posix_clock_process_gettime(struct timespec *tp);
-static int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -215,25 +217,9 @@ static __init int init_posix_timers(void
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_nosettime
 	};
-	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_thread_gettime,
-		.clock_set = do_posix_clock_nosettime,
-		.timer_create = do_posix_clock_notimer_create,
-		.nsleep = do_posix_clock_nonanosleep
-	};
-	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_process_gettime,
-		.clock_set = do_posix_clock_nosettime,
-		.timer_create = do_posix_clock_notimer_create,
-		.nsleep = do_posix_clock_nonanosleep
-	};
 
 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
-	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
-	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);
 
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -1224,65 +1210,10 @@ int do_posix_clock_notimer_create(struct
 	return -EINVAL;
 }
 
-int do_posix_clock_nonanosleep(int which_lock, int flags,struct timespec * t) {
-/* Single Unix specficiation says to return ENOTSUP but we do not have that */
-	return -EINVAL;
-}
-
-static unsigned long process_ticks(task_t *p) {
-	unsigned long ticks;
-	task_t *t;
-
-	spin_lock(&p->sighand->siglock);
-	/* The signal structure is shared between all threads */
-	ticks = p->signal->utime + p->signal->stime;
-
-	/* Add up the cpu time for all the still running threads of this process */
-	t = p;
-	do {
-		ticks += t->utime + t->stime;
-		t = next_thread(t);
-	} while (t != p);
-
-	spin_unlock(&p->sighand->siglock);
-	return ticks;
-}
-
-static inline unsigned long thread_ticks(task_t *p) {
-	return p->utime + current->stime;
-}
-
-/*
- * Single Unix Specification V3:
- *
- * Implementations shall also support the special clockid_t value
- * CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the calling
- * thread when invoking one of the clock_*() or timer_*() functions. For these
- * clock IDs, the values returned by clock_gettime() and specified by
- * clock_settime() shall represent the amount of execution time of the thread
- * associated with the clock.
- */
-static int do_posix_clock_thread_gettime(struct timespec *tp)
-{
-	jiffies_to_timespec(thread_ticks(current), tp);
-	return 0;
-}
-
-/*
- * Single Unix Specification V3:
- *
- * Implementations shall also support the special clockid_t value
- * CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
- * calling process when invoking one of the clock_*() or timer_*() functions.
- * For these clock IDs, the values returned by clock_gettime() and specified
- * by clock_settime() represent the amount of execution time of the process
- * associated with the clock.
- */
-
-static int do_posix_clock_process_gettime(struct timespec *tp)
+int do_posix_clock_nonanosleep(clockid_t which_clock, int flags,
+			       struct timespec *t)
 {
-	jiffies_to_timespec(process_ticks(current), tp);
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 asmlinkage long
@@ -1290,9 +1221,8 @@ sys_clock_settime(clockid_t which_clock,
 {
 	struct timespec new_tp;
 
-	/* Cannot set process specific clocks */
-	if (which_clock<0)
-		return -EINVAL;
+	if (which_clock < 0)
+		return posix_cpu_clock_settime(which_clock, tp);
 
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
@@ -1305,45 +1235,20 @@ sys_clock_settime(clockid_t which_clock,
 	return do_sys_settimeofday(&new_tp, NULL);
 }
 
-static int do_clock_gettime(clockid_t which_clock, struct timespec *tp)
-{
-	/* Process process specific clocks */
-	if (which_clock < 0) {
-		task_t *t;
-		int pid = -which_clock;
-
-		if (pid < PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid))) {
-				jiffies_to_timespec(process_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		if (pid < 2*PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid - PID_MAX_LIMIT))) {
-				jiffies_to_timespec(thread_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		/* More process specific clocks could follow here */
-		return -EINVAL;
-	}
-
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-					!posix_clocks[which_clock].res)
-		return -EINVAL;
-
-	return do_posix_gettime(&posix_clocks[which_clock], tp);
-}
-
 asmlinkage long
 sys_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec kernel_tp;
 	int error;
 
-	error = do_clock_gettime(which_clock, &kernel_tp);
+	if (which_clock < 0)
+		return posix_cpu_clock_gettime(which_clock, tp);
+
+	if ((unsigned) which_clock >= MAX_CLOCKS ||
+	    !posix_clocks[which_clock].res)
+		return -EINVAL;
+
+	error = do_posix_gettime(&posix_clocks[which_clock], &kernel_tp);
 	if (!error && copy_to_user(tp, &kernel_tp, sizeof (kernel_tp)))
 		error = -EFAULT;
 
@@ -1356,8 +1261,8 @@ sys_clock_getres(clockid_t which_clock, 
 {
 	struct timespec rtn_tp;
 
-	/* All process clocks have the resolution of CLOCK_PROCESS_CPUTIME_ID */
-	if (which_clock < 0 ) which_clock = CLOCK_PROCESS_CPUTIME_ID;
+	if (which_clock < 0)
+		return posix_cpu_clock_getres(which_clock, tp);
 
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
@@ -1495,6 +1400,9 @@ sys_clock_nanosleep(clockid_t which_cloc
 	    &(current_thread_info()->restart_block);
 	int ret;
 
+	if (which_clock < 0)	/* CPU time clocks */
+		return -EOPNOTSUPP;
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2259,6 +2259,32 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 EXPORT_PER_CPU_SYMBOL(kstat);
 
 /*
+ * This is called on clock ticks and on context switches.
+ * Bank in p->sched_time the ns elapsed since the last tick or switch.
+ */
+static void update_cpu_clock(task_t *p, runqueue_t *rq,
+			     unsigned long long now)
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
@@ -2287,8 +2313,11 @@ void scheduler_tick(int user_ticks, int 
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	unsigned long long now = sched_clock();
+
+	update_cpu_clock(p, rq, now);
 
-	rq->timestamp_last_tick = sched_clock();
+	rq->timestamp_last_tick = now;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
@@ -2669,6 +2698,8 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
+	update_cpu_clock(prev, rq, now);
+
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0) {
 		prev->sleep_avg = 0;
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -386,6 +386,7 @@ void __exit_signal(struct task_struct *t
 		sig->maj_flt += tsk->maj_flt;
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
+		sig->sched_time += tsk->sched_time;
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
--- /dev/null
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -0,0 +1,236 @@
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
+	unsigned long cpu;
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
+		jiffies_to_timespec(cpu.cpu, tp);
+	}
+}
+
+static int sample_to_user(clockid_t which_clock,
+			  union cpu_time_count cpu,
+			  struct timespec __user *tp)
+{
+	struct timespec ts;
+	sample_to_timespec(which_clock, cpu, &ts);
+	return copy_to_user(tp, &ts, sizeof *tp) ? -EFAULT : 0;
+}
+
+static inline unsigned long prof_ticks(struct task_struct *p)
+{
+	return p->utime + p->stime;
+}
+static inline unsigned long virt_ticks(struct task_struct *p)
+{
+	return p->utime;
+}
+static inline unsigned long long sched_ns(struct task_struct *p)
+{
+	return (p == current) ? current_sched_time(p) : p->sched_time;
+}
+
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec __user *tp)
+{
+	int error = check_clock(which_clock);
+	if (!error && tp) {
+		struct timespec rtn_tp = { 0, ((NSEC_PER_SEC + HZ - 1) / HZ) };
+		if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+			/*
+			 * If sched_clock is using a cycle counter, we
+			 * don't have any idea of its true resolution
+			 * exported, but it is much more than 1s/HZ.
+			 */
+			rtn_tp.tv_nsec = 1;
+		}
+		if (copy_to_user(tp, &rtn_tp, sizeof *tp))
+			error = -EFAULT;
+	}
+	return error;
+}
+
+int posix_cpu_clock_settime(clockid_t which_clock,
+			    const struct timespec __user *tp)
+{
+	/*
+	 * You can never reset a CPU clock, but we check for other errors
+	 * in the call before failing with EPERM.
+	 */
+	int error = check_clock(which_clock);
+	if (error == 0) {
+		struct timespec new_tp;
+		error = -EPERM;
+		if (copy_from_user(&new_tp, tp, sizeof *tp))
+			error = -EFAULT;
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
+		cpu->cpu = p->signal->utime + p->signal->stime;
+		do {
+			cpu->cpu += prof_ticks(t);
+			t = next_thread(t);
+		} while (t != p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	case CPUCLOCK_VIRT:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		cpu->cpu = p->signal->utime;
+		do {
+			cpu->cpu += virt_ticks(t);
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
+int posix_cpu_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
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
+	return sample_to_user(which_clock, rtn, tp);
+}
