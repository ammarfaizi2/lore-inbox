Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWIXVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWIXVfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIXVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:35:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3281 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932179AbWIXVf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:35:28 -0400
Date: Mon, 25 Sep 2006 03:05:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: debug sleep check
Message-ID: <20060924213508.GG13432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060924183509.GB22448@in.ibm.com> <20060924115646.6b5b6482.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924115646.6b5b6482.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 11:56:46AM -0700, Andrew Morton wrote:
> On Mon, 25 Sep 2006 00:05:09 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > Add a debug check for rcu read-side critical section code calling
> > a function that might sleep which is illegal. The check is enabled only
> > if CONFIG_DEBUG_SPINLOCK_SLEEP is set.
> > 
> 
> Does this actually change anything?  rcu_read_lock is preempt_disable(), and
> might_sleep() already triggers if called inside preempt_disable().

It makes a difference if CONFIG_PREEMPT=n. AFAICS, preempt_disable()
is a nop then and rcu needs its own check for sleeping while
in read-side critical section. Anyway, I need to fix the rcupreempt
part of this check, update patch is included below.

> 
> > -#define rcu_read_lock() __rcu_read_lock()
> > +#define rcu_read_lock()	\
> > +	do {	\
> > +		rcu_add_read_count();	\
> > +		__rcu_read_lock();	\
> 
> I don't have any __rcu_read_lock().  I guess this is against your
> to-be-resent RCU patches?

Yes, they are up in http://www.hill9.org/linux/kernel/patches/2.6.18-mm1/.
However I am still running some tests.

> 
> > +DEFINE_PER_CPU(int, rcu_read_count);
> 
> Can have static scope.

Done.

Thanks
Dipankar



Add a debug check for rcu read-side critical section code calling
a function that might sleep which is illegal. The check is enabled only
if CONFIG_DEBUG_SPINLOCK_SLEEP is set.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 include/linux/rcuclassic.h |   12 ++++++++++++
 include/linux/rcupdate.h   |    6 ++++++
 kernel/rcuclassic.c        |   33 +++++++++++++++++++++++++++++++++
 kernel/rcupreempt.c        |    7 +++++++
 kernel/sched.c             |    2 +-
 5 files changed, 59 insertions(+), 1 deletion(-)

diff -puN include/linux/rcupdate.h~rcu-reader-sleep-check include/linux/rcupdate.h
--- linux-2.6.18-mm1-rcu/include/linux/rcupdate.h~rcu-reader-sleep-check	2006-09-25 00:49:12.000000000 +0530
+++ linux-2.6.18-mm1-rcu-dipankar/include/linux/rcupdate.h	2006-09-25 00:56:02.000000000 +0530
@@ -64,6 +64,12 @@ struct rcu_head {
        (ptr)->next = NULL; (ptr)->func = NULL; \
 } while (0)
 
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+extern int rcu_read_in_atomic(void);
+#else
+static inline int rcu_read_in_atomic(void) { return 0;}
+#endif
+
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
  *
diff -puN kernel/sched.c~rcu-reader-sleep-check kernel/sched.c
--- linux-2.6.18-mm1-rcu/kernel/sched.c~rcu-reader-sleep-check	2006-09-25 00:49:12.000000000 +0530
+++ linux-2.6.18-mm1-rcu-dipankar/kernel/sched.c	2006-09-25 00:49:12.000000000 +0530
@@ -6974,7 +6974,7 @@ void __might_sleep(char *file, int line)
 #ifdef in_atomic
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if ((in_atomic() || irqs_disabled()) &&
+	if ((in_atomic() || irqs_disabled() || rcu_read_in_atomic()) &&
 	    system_state == SYSTEM_RUNNING && !oops_in_progress) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
diff -puN kernel/rcuclassic.c~rcu-reader-sleep-check kernel/rcuclassic.c
--- linux-2.6.18-mm1-rcu/kernel/rcuclassic.c~rcu-reader-sleep-check	2006-09-25 00:49:58.000000000 +0530
+++ linux-2.6.18-mm1-rcu-dipankar/kernel/rcuclassic.c	2006-09-25 00:51:45.000000000 +0530
@@ -545,6 +545,39 @@ void __init __rcu_init(void)
 	register_cpu_notifier(&rcu_nb);
 }
 
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+static DEFINE_PER_CPU(int, rcu_read_count);
+int rcu_read_in_atomic(void)
+{
+	int val;
+	int cpu = get_cpu();
+	val = per_cpu(rcu_read_count, cpu);
+	put_cpu();
+	return val;
+}
+
+void rcu_add_read_count(void)
+{
+	int cpu, flags;
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(rcu_read_count, cpu)++;
+	local_irq_restore(flags);
+}
+
+void rcu_sub_read_count(void)
+{
+	int cpu, flags;
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(rcu_read_count, cpu)--;
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(rcu_read_in_atomic);
+EXPORT_SYMBOL_GPL(rcu_add_read_count);
+EXPORT_SYMBOL_GPL(rcu_sub_read_count);
+#endif
+
 module_param(blimit, int, 0);
 module_param(qhimark, int, 0);
 module_param(qlowmark, int, 0);
diff -puN include/linux/rcuclassic.h~rcu-reader-sleep-check include/linux/rcuclassic.h
--- linux-2.6.18-mm1-rcu/include/linux/rcuclassic.h~rcu-reader-sleep-check	2006-09-25 00:56:24.000000000 +0530
+++ linux-2.6.18-mm1-rcu-dipankar/include/linux/rcuclassic.h	2006-09-25 02:33:03.000000000 +0530
@@ -115,25 +115,37 @@ static inline void rcu_bh_qsctr_inc(int 
 extern int rcu_pending(int cpu);
 extern int rcu_needs_cpu(int cpu);
 
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+extern void rcu_add_read_count(void);
+extern void rcu_sub_read_count(void);
+#else
+static inline void rcu_add_read_count(void) {}
+static inline void rcu_sub_read_count(void) {}
+#endif
+
 #define __rcu_read_lock() \
 	do { \
 		preempt_disable(); \
+		rcu_add_read_count(); \
 		__acquire(RCU); \
 	} while(0)
 #define __rcu_read_unlock() \
 	do { \
 		__release(RCU); \
+		rcu_sub_read_count(); \
 		preempt_enable(); \
 	} while(0)
 
 #define __rcu_read_lock_bh() \
 	do { \
 		local_bh_disable(); \
+		rcu_add_read_count(); \
 		__acquire(RCU_BH); \
 	} while(0)
 #define __rcu_read_unlock_bh() \
 	do { \
 		__release(RCU_BH); \
+		rcu_sub_read_count(); \
 		local_bh_enable(); \
 	} while(0)
 
diff -puN kernel/rcupreempt.c~rcu-reader-sleep-check kernel/rcupreempt.c
--- linux-2.6.18-mm1-rcu/kernel/rcupreempt.c~rcu-reader-sleep-check	2006-09-25 01:01:11.000000000 +0530
+++ linux-2.6.18-mm1-rcu-dipankar/kernel/rcupreempt.c	2006-09-25 01:07:36.000000000 +0530
@@ -424,6 +424,13 @@ int rcu_read_proc_ctrs_data(char *page)
 
 #endif /* #ifdef CONFIG_RCU_TRACE */
 
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+int rcu_read_in_atomic(void)
+{
+	return current->rcu_read_lock_nesting;
+}
+#endif
+
 EXPORT_SYMBOL_GPL(call_rcu);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);

_
