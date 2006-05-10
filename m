Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWEJDbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWEJDbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWEJDbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:31:39 -0400
Received: from ozlabs.org ([203.10.76.45]:2696 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964782AbWEJDbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:31:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 13:30:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
CC: linux-arch@vger.kernel.org
Subject: [PATCH] Define __raw_get_cpu_var and use it
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several instances of per_cpu(foo, raw_smp_processor_id()),
which is semantically equivalent to __get_cpu_var(foo) but without the
warning that smp_processor_id() can give if CONFIG_DEBUG_PREEMPT is
enabled.  For those architectures with optimized per-cpu
implementations, namely ia64, powerpc, s390, sparc64 and x86_64,
per_cpu() turns into more and slower code than __get_cpu_var(), so it
would be preferable to use __get_cpu_var on those platforms.

This defines a __raw_get_cpu_var(x) macro which turns into
per_cpu(x, raw_smp_processor_id()) on architectures that use the
generic per-cpu implementation, and turns into __get_cpu_var(x) on
the architectures that have an optimized per-cpu implementation.
    
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c0caf43..c745211 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -14,6 +14,7 @@ #define DEFINE_PER_CPU(type, name) \
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+#define __raw_get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
@@ -30,6 +31,7 @@ #define DEFINE_PER_CPU(type, name) \
 
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __raw_get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
 
diff --git a/include/asm-ia64/percpu.h b/include/asm-ia64/percpu.h
index 2b14dee..4bfbeb4 100644
--- a/include/asm-ia64/percpu.h
+++ b/include/asm-ia64/percpu.h
@@ -43,6 +43,7 @@ DECLARE_PER_CPU(unsigned long, local_per
 
 #define per_cpu(var, cpu)  (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
+#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 
 extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
 extern void setup_per_cpu_areas (void);
@@ -52,6 +53,7 @@ #else /* ! SMP */
 
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __raw_get_cpu_var(var)			per_cpu__##var
 #define per_cpu_init()				(__phys_per_cpu_start)
 
 #endif	/* SMP */
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
index 184a7a4..faa1fc7 100644
--- a/include/asm-powerpc/percpu.h
+++ b/include/asm-powerpc/percpu.h
@@ -22,6 +22,7 @@ #define DEFINE_PER_CPU(type, name) \
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
+#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
@@ -41,6 +42,7 @@ #define DEFINE_PER_CPU(type, name) \
 
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __raw_get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
 
diff --git a/include/asm-s390/percpu.h b/include/asm-s390/percpu.h
index 436d216..d9a8cca 100644
--- a/include/asm-s390/percpu.h
+++ b/include/asm-s390/percpu.h
@@ -40,6 +40,7 @@ #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
 #define __get_cpu_var(var) __reloc_hide(var,S390_lowcore.percpu_offset)
+#define __raw_get_cpu_var(var) __reloc_hide(var,S390_lowcore.percpu_offset)
 #define per_cpu(var,cpu) __reloc_hide(var,__per_cpu_offset[cpu])
 
 /* A macro to avoid #include hell... */
@@ -57,6 +58,7 @@ #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
 #define __get_cpu_var(var) __reloc_hide(var,0)
+#define __raw_get_cpu_var(var) __reloc_hide(var,0)
 #define per_cpu(var,cpu) __reloc_hide(var,0)
 
 #endif /* SMP */
diff --git a/include/asm-sparc64/percpu.h b/include/asm-sparc64/percpu.h
index baef13b..a6ece06 100644
--- a/include/asm-sparc64/percpu.h
+++ b/include/asm-sparc64/percpu.h
@@ -21,6 +21,7 @@ register unsigned long __local_per_cpu_o
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __local_per_cpu_offset))
+#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __local_per_cpu_offset))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
@@ -37,6 +38,7 @@ #define DEFINE_PER_CPU(type, name) \
 
 #define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __raw_get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
 
diff --git a/include/asm-x86_64/percpu.h b/include/asm-x86_64/percpu.h
index 7f33aaf..549eb92 100644
--- a/include/asm-x86_64/percpu.h
+++ b/include/asm-x86_64/percpu.h
@@ -21,6 +21,7 @@ #define DEFINE_PER_CPU(type, name) \
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
+#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
@@ -40,6 +41,7 @@ #define DEFINE_PER_CPU(type, name) \
 
 #define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __raw_get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
 
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index b7f0388..63626be 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -572,7 +572,7 @@ void hrtimer_init(struct hrtimer *timer,
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
-	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
+	bases = __raw_get_cpu_var(hrtimer_bases);
 
 	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_ABS)
 		clock_id = CLOCK_MONOTONIC;
@@ -594,7 +594,7 @@ int hrtimer_get_res(const clockid_t whic
 {
 	struct hrtimer_base *bases;
 
-	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
+	bases = __raw_get_cpu_var(hrtimer_bases);
 	*tp = ktime_to_timespec(bases[which_clock].resolution);
 
 	return 0;
diff --git a/kernel/sched.c b/kernel/sched.c
index 4c64f85..cf904dd 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4168,7 +4168,7 @@ EXPORT_SYMBOL(yield);
  */
 void __sched io_schedule(void)
 {
-	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
+	struct runqueue *rq = &__raw_get_cpu_var(runqueues);
 
 	atomic_inc(&rq->nr_iowait);
 	schedule();
@@ -4179,7 +4179,7 @@ EXPORT_SYMBOL(io_schedule);
 
 long __sched io_schedule_timeout(long timeout)
 {
-	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
+	struct runqueue *rq = &__raw_get_cpu_var(runqueues);
 	long ret;
 
 	atomic_inc(&rq->nr_iowait);
diff --git a/kernel/softlockup.c b/kernel/softlockup.c
index 14c7faf..2c1be11 100644
--- a/kernel/softlockup.c
+++ b/kernel/softlockup.c
@@ -36,7 +36,7 @@ static struct notifier_block panic_block
 
 void touch_softlockup_watchdog(void)
 {
-	per_cpu(touch_timestamp, raw_smp_processor_id()) = jiffies;
+	__raw_get_cpu_var(touch_timestamp) = jiffies;
 }
 EXPORT_SYMBOL(touch_softlockup_watchdog);
 
diff --git a/kernel/timer.c b/kernel/timer.c
index 67eaf0f..4afc9f1 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -146,7 +146,7 @@ static void internal_add_timer(tvec_base
 void fastcall init_timer(struct timer_list *timer)
 {
 	timer->entry.next = NULL;
-	timer->base = per_cpu(tvec_bases, raw_smp_processor_id());
+	timer->base = __raw_get_cpu_var(tvec_bases);
 }
 EXPORT_SYMBOL(init_timer);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cc9423d..60b11ae 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -244,7 +244,7 @@ static unsigned int		rt_hash_rnd;
 
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
 #define RT_CACHE_STAT_INC(field) \
-	(per_cpu(rt_cache_stat, raw_smp_processor_id()).field++)
+	(__raw_get_cpu_var(rt_cache_stat).field++)
 
 static int rt_intern_hash(unsigned hash, struct rtable *rth,
 				struct rtable **res);
