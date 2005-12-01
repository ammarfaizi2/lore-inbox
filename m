Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVLAAMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVLAAMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVLAAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:12:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43426
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751290AbVK3X53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:29 -0500
Subject: [patch 09/43] Make clock selectors in posix-timers const
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:05 +0100
Message-Id: <1133395385.32542.452.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (posix-timer-const-overhaul.patch)
- add const arguments to the posix-timers.h API functions

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/posix-timers.h |   22 +++++++++++-----------
 kernel/posix-cpu-timers.c    |   40 ++++++++++++++++++++++------------------
 kernel/posix-timers.c        |   38 +++++++++++++++++++++-----------------
 3 files changed, 54 insertions(+), 46 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/posix-timers.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/posix-timers.h
+++ linux-2.6.15-rc2-rework/include/linux/posix-timers.h
@@ -72,12 +72,12 @@ struct k_clock_abs {
 };
 struct k_clock {
 	int res;		/* in nano seconds */
-	int (*clock_getres) (clockid_t which_clock, struct timespec *tp);
+	int (*clock_getres) (const clockid_t which_clock, struct timespec *tp);
 	struct k_clock_abs *abs_struct;
-	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
-	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
+	int (*clock_set) (const clockid_t which_clock, struct timespec * tp);
+	int (*clock_get) (const clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *);
+	int (*nsleep) (const clockid_t which_clock, int flags, struct timespec *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -87,12 +87,12 @@ struct k_clock {
 			   struct itimerspec * cur_setting);
 };
 
-void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock);
+void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock);
 
 /* Error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *);
-int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
+int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *);
+int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
@@ -117,11 +117,11 @@ struct now_struct {
               }								\
             }while (0)
 
-int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *);
-int posix_cpu_clock_get(clockid_t which_clock, struct timespec *);
-int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp);
+int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *);
+int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *);
+int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *tp);
 int posix_cpu_timer_create(struct k_itimer *);
-int posix_cpu_nsleep(clockid_t, int, struct timespec *);
+int posix_cpu_nsleep(const clockid_t, int, struct timespec *);
 int posix_cpu_timer_set(struct k_itimer *, int,
 			struct itimerspec *, struct itimerspec *);
 int posix_cpu_timer_del(struct k_itimer *);
Index: linux-2.6.15-rc2-rework/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-cpu-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-cpu-timers.c
@@ -7,7 +7,7 @@
 #include <asm/uaccess.h>
 #include <linux/errno.h>
 
-static int check_clock(clockid_t which_clock)
+static int check_clock(const clockid_t which_clock)
 {
 	int error = 0;
 	struct task_struct *p;
@@ -31,7 +31,7 @@ static int check_clock(clockid_t which_c
 }
 
 static inline union cpu_time_count
-timespec_to_sample(clockid_t which_clock, const struct timespec *tp)
+timespec_to_sample(const clockid_t which_clock, const struct timespec *tp)
 {
 	union cpu_time_count ret;
 	ret.sched = 0;		/* high half always zero when .cpu used */
@@ -43,7 +43,7 @@ timespec_to_sample(clockid_t which_clock
 	return ret;
 }
 
-static void sample_to_timespec(clockid_t which_clock,
+static void sample_to_timespec(const clockid_t which_clock,
 			       union cpu_time_count cpu,
 			       struct timespec *tp)
 {
@@ -55,7 +55,7 @@ static void sample_to_timespec(clockid_t
 	}
 }
 
-static inline int cpu_time_before(clockid_t which_clock,
+static inline int cpu_time_before(const clockid_t which_clock,
 				  union cpu_time_count now,
 				  union cpu_time_count then)
 {
@@ -65,7 +65,7 @@ static inline int cpu_time_before(clocki
 		return cputime_lt(now.cpu, then.cpu);
 	}
 }
-static inline void cpu_time_add(clockid_t which_clock,
+static inline void cpu_time_add(const clockid_t which_clock,
 				union cpu_time_count *acc,
 			        union cpu_time_count val)
 {
@@ -75,7 +75,7 @@ static inline void cpu_time_add(clockid_
 		acc->cpu = cputime_add(acc->cpu, val.cpu);
 	}
 }
-static inline union cpu_time_count cpu_time_sub(clockid_t which_clock,
+static inline union cpu_time_count cpu_time_sub(const clockid_t which_clock,
 						union cpu_time_count a,
 						union cpu_time_count b)
 {
@@ -151,7 +151,7 @@ static inline unsigned long long sched_n
 	return (p == current) ? current_sched_time(p) : p->sched_time;
 }
 
-int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *tp)
 {
 	int error = check_clock(which_clock);
 	if (!error) {
@@ -169,7 +169,7 @@ int posix_cpu_clock_getres(clockid_t whi
 	return error;
 }
 
-int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp)
+int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *tp)
 {
 	/*
 	 * You can never reset a CPU clock, but we check for other errors
@@ -186,7 +186,7 @@ int posix_cpu_clock_set(clockid_t which_
 /*
  * Sample a per-thread clock for the given task.
  */
-static int cpu_clock_sample(clockid_t which_clock, struct task_struct *p,
+static int cpu_clock_sample(const clockid_t which_clock, struct task_struct *p,
 			    union cpu_time_count *cpu)
 {
 	switch (CPUCLOCK_WHICH(which_clock)) {
@@ -259,7 +259,7 @@ static int cpu_clock_sample_group_locked
  * Sample a process (thread group) clock for the given group_leader task.
  * Must be called with tasklist_lock held for reading.
  */
-static int cpu_clock_sample_group(clockid_t which_clock,
+static int cpu_clock_sample_group(const clockid_t which_clock,
 				  struct task_struct *p,
 				  union cpu_time_count *cpu)
 {
@@ -273,7 +273,7 @@ static int cpu_clock_sample_group(clocki
 }
 

-int posix_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *tp)
 {
 	const pid_t pid = CPUCLOCK_PID(which_clock);
 	int error = -EINVAL;
@@ -1410,7 +1410,7 @@ void set_process_cpu_timer(struct task_s
 
 static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
 
-int posix_cpu_nsleep(clockid_t which_clock, int flags,
+int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 		     struct timespec *rqtp)
 {
 	struct restart_block *restart_block =
@@ -1514,11 +1514,13 @@ posix_cpu_clock_nanosleep_restart(struct
 #define PROCESS_CLOCK	MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED)
 #define THREAD_CLOCK	MAKE_THREAD_CPUCLOCK(0, CPUCLOCK_SCHED)
 
-static int process_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+static int process_cpu_clock_getres(const clockid_t which_clock,
+				    struct timespec *tp)
 {
 	return posix_cpu_clock_getres(PROCESS_CLOCK, tp);
 }
-static int process_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+static int process_cpu_clock_get(const clockid_t which_clock,
+				 struct timespec *tp)
 {
 	return posix_cpu_clock_get(PROCESS_CLOCK, tp);
 }
@@ -1527,16 +1529,18 @@ static int process_cpu_timer_create(stru
 	timer->it_clock = PROCESS_CLOCK;
 	return posix_cpu_timer_create(timer);
 }
-static int process_cpu_nsleep(clockid_t which_clock, int flags,
+static int process_cpu_nsleep(const clockid_t which_clock, int flags,
 			      struct timespec *rqtp)
 {
 	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp);
 }
-static int thread_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
+static int thread_cpu_clock_getres(const clockid_t which_clock,
+				   struct timespec *tp)
 {
 	return posix_cpu_clock_getres(THREAD_CLOCK, tp);
 }
-static int thread_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
+static int thread_cpu_clock_get(const clockid_t which_clock,
+				struct timespec *tp)
 {
 	return posix_cpu_clock_get(THREAD_CLOCK, tp);
 }
@@ -1545,7 +1549,7 @@ static int thread_cpu_timer_create(struc
 	timer->it_clock = THREAD_CLOCK;
 	return posix_cpu_timer_create(timer);
 }
-static int thread_cpu_nsleep(clockid_t which_clock, int flags,
+static int thread_cpu_nsleep(const clockid_t which_clock, int flags,
 			      struct timespec *rqtp)
 {
 	return -EINVAL;
Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
@@ -151,7 +151,7 @@ static void posix_timer_fn(unsigned long
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
-static int do_posix_clock_monotonic_get(clockid_t, struct timespec *tp);
+static int do_posix_clock_monotonic_get(const clockid_t, struct timespec *tp);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -176,7 +176,7 @@ static inline void unlock_timer(struct k
  * the function pointer CALL in struct k_clock.
  */
 
-static inline int common_clock_getres(clockid_t which_clock,
+static inline int common_clock_getres(const clockid_t which_clock,
 				      struct timespec *tp)
 {
 	tp->tv_sec = 0;
@@ -184,13 +184,15 @@ static inline int common_clock_getres(cl
 	return 0;
 }
 
-static inline int common_clock_get(clockid_t which_clock, struct timespec *tp)
+static inline int common_clock_get(const clockid_t which_clock,
+				   struct timespec *tp)
 {
 	getnstimeofday(tp);
 	return 0;
 }
 
-static inline int common_clock_set(clockid_t which_clock, struct timespec *tp)
+static inline int common_clock_set(const clockid_t which_clock,
+				   struct timespec *tp)
 {
 	return do_sys_settimeofday(tp, NULL);
 }
@@ -207,7 +209,7 @@ static inline int common_timer_create(st
 /*
  * These ones are defined below.
  */
-static int common_nsleep(clockid_t, int flags, struct timespec *t);
+static int common_nsleep(const clockid_t, int flags, struct timespec *t);
 static void common_timer_get(struct k_itimer *, struct itimerspec *);
 static int common_timer_set(struct k_itimer *, int,
 			    struct itimerspec *, struct itimerspec *);
@@ -216,7 +218,7 @@ static int common_timer_del(struct k_iti
 /*
  * Return nonzero iff we know a priori this clockid_t value is bogus.
  */
-static inline int invalid_clockid(clockid_t which_clock)
+static inline int invalid_clockid(const clockid_t which_clock)
 {
 	if (which_clock < 0)	/* CPU clock, posix_cpu_* will check it */
 		return 0;
@@ -522,7 +524,7 @@ static inline struct task_struct * good_
 	return rtn;
 }
 
-void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock)
+void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock)
 {
 	if ((unsigned) clock_id >= MAX_CLOCKS) {
 		printk("POSIX clock register failed for clock_id %d\n",
@@ -568,7 +570,7 @@ static void release_posix_timer(struct k
 /* Create a POSIX.1b interval timer. */
 
 asmlinkage long
-sys_timer_create(clockid_t which_clock,
+sys_timer_create(const clockid_t which_clock,
 		 struct sigevent __user *timer_event_spec,
 		 timer_t __user * created_timer_id)
 {
@@ -1195,7 +1197,8 @@ static u64 do_posix_clock_monotonic_gett
 	return jiff;
 }
 
-static int do_posix_clock_monotonic_get(clockid_t clock, struct timespec *tp)
+static int do_posix_clock_monotonic_get(const clockid_t clock,
+					struct timespec *tp)
 {
 	struct timespec wall_to_mono;
 
@@ -1212,7 +1215,7 @@ int do_posix_clock_monotonic_gettime(str
 	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
 }
 
-int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
+int do_posix_clock_nosettime(const clockid_t clockid, struct timespec *tp)
 {
 	return -EINVAL;
 }
@@ -1224,7 +1227,8 @@ int do_posix_clock_notimer_create(struct
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
 
-int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t)
+int do_posix_clock_nonanosleep(const clockid_t clock, int flags,
+			       struct timespec *t)
 {
 #ifndef ENOTSUP
 	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
@@ -1234,8 +1238,8 @@ int do_posix_clock_nonanosleep(clockid_t
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_nonanosleep);
 
-asmlinkage long
-sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
+asmlinkage long sys_clock_settime(const clockid_t which_clock,
+				  const struct timespec __user *tp)
 {
 	struct timespec new_tp;
 
@@ -1248,7 +1252,7 @@ sys_clock_settime(clockid_t which_clock,
 }
 
 asmlinkage long
-sys_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
+sys_clock_gettime(const clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec kernel_tp;
 	int error;
@@ -1265,7 +1269,7 @@ sys_clock_gettime(clockid_t which_clock,
 }
 
 asmlinkage long
-sys_clock_getres(clockid_t which_clock, struct timespec __user *tp)
+sys_clock_getres(const clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec rtn_tp;
 	int error;
@@ -1387,7 +1391,7 @@ void clock_was_set(void)
 long clock_nanosleep_restart(struct restart_block *restart_block);
 
 asmlinkage long
-sys_clock_nanosleep(clockid_t which_clock, int flags,
+sys_clock_nanosleep(const clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
 		    struct timespec __user *rmtp)
 {
@@ -1419,7 +1423,7 @@ sys_clock_nanosleep(clockid_t which_cloc
 }
 

-static int common_nsleep(clockid_t which_clock,
+static int common_nsleep(const clockid_t which_clock,
 			 int flags, struct timespec *tsave)
 {
 	struct timespec t, dum;

--

