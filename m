Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUIQOWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUIQOWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbUIQOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:22:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30117 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268771AbUIQOTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:19:22 -0400
Date: Fri, 17 Sep 2004 14:53:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917125334.GA4954@elte.hu>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917103945.GA19861@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the attached patch is a simplified variant of the remove-bkl patch i
> sent two days ago: it doesnt do the ->cpus_allowed trick.
> 
> The question is, is there any BKL-using kernel code that relies on the
> task not migrating to another CPU within the BLK critical section?

the attached debug patch is ontop of the above patch and prints warnings
if code uses smp_processor_id() in a preemptible section of code. The
patch gets rid of a number of common false positives but more false
positives are more than likely.

The patch has already uncovered a bug: softirq invocation had a softirq
invocation race possibly leading to (<1msec) softirq processing delays
in the PREEMPT case. But more importantly it has found no BKL user so
far that relied on smp_processor_id(), which makes me hopeful that the
problem is not widespread at all and we could opt for the simpler,
semaphore-based BKS design.

(patch tested on x86 and x64, should work on all architectures.)

	Ingo


--- linux/arch/i386/lib/delay.c	
+++ linux/arch/i386/lib/delay.c	
@@ -34,7 +34,7 @@ inline void __const_udelay(unsigned long
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy * (HZ/4)));
+		:"1" (xloops),"0" (boot_cpu_data.loops_per_jiffy * (HZ/4)));
         __delay(++xloops);
 }
 
--- linux/arch/x86_64/lib/delay.c	
+++ linux/arch/x86_64/lib/delay.c	
@@ -34,7 +34,7 @@ void __delay(unsigned long loops)
 
 inline void __const_udelay(unsigned long xloops)
 {
-        __delay(((xloops * current_cpu_data.loops_per_jiffy) >> 32) * HZ);
+        __delay(((xloops * boot_cpu_data.loops_per_jiffy) >> 32) * HZ);
 }
 
 void __udelay(unsigned long usecs)
--- linux/include/asm-i386/smp.h	
+++ linux/include/asm-i386/smp.h	
@@ -50,7 +50,7 @@ extern u8 x86_cpu_to_apicid[];
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define smp_processor_id() (current_thread_info()->cpu)
+#define __smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
 #define cpu_possible_map cpu_callout_map
--- linux/include/asm-x86_64/smp.h	
+++ linux/include/asm-x86_64/smp.h	
@@ -66,7 +66,7 @@ static inline int num_booting_cpus(void)
 	return cpus_weight(cpu_callout_map);
 }
 
-#define smp_processor_id() read_pda(cpunumber)
+#define __smp_processor_id() read_pda(cpunumber)
 
 extern __inline int hard_smp_processor_id(void)
 {
--- linux/include/linux/smp.h	
+++ linux/include/linux/smp.h	
@@ -95,8 +95,11 @@ void smp_prepare_boot_cpu(void);
 /*
  *	These macros fold the SMP functionality into a single CPU system
  */
- 
-#define smp_processor_id()			0
+
+#if !defined(__smp_processor_id) || !defined(CONFIG_PREEMPT)
+# define smp_processor_id()			0
+
+#endif
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
@@ -107,6 +110,17 @@ static inline void smp_send_reschedule(i
 
 #endif /* !SMP */
 
+#ifdef __smp_processor_id 
+# ifdef CONFIG_PREEMPT
+   extern unsigned int smp_processor_id(void);
+# else
+#  define smp_processor_id() __smp_processor_id()
+# endif
+# define _smp_processor_id() __smp_processor_id()
+#else
+# define _smp_processor_id() smp_processor_id()
+#endif
+
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
--- linux/include/net/route.h	
+++ linux/include/net/route.h	
@@ -105,7 +105,7 @@ struct rt_cache_stat 
 
 extern struct rt_cache_stat *rt_cache_stat;
 #define RT_CACHE_STAT_INC(field)					  \
-		(per_cpu_ptr(rt_cache_stat, smp_processor_id())->field++)
+		(per_cpu_ptr(rt_cache_stat, _smp_processor_id())->field++)
 
 extern struct ip_rt_acct *ip_rt_acct;
 
--- linux/include/net/snmp.h	
+++ linux/include/net/snmp.h	
@@ -128,18 +128,18 @@ struct linux_mib {
 #define SNMP_STAT_USRPTR(name)	(name[1])
 
 #define SNMP_INC_STATS_BH(mib, field) 	\
-	(per_cpu_ptr(mib[0], smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field]++)
 #define SNMP_INC_STATS_OFFSET_BH(mib, field, offset)	\
-	(per_cpu_ptr(mib[0], smp_processor_id())->mibs[field + (offset)]++)
+	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field + (offset)]++)
 #define SNMP_INC_STATS_USER(mib, field) \
-	(per_cpu_ptr(mib[1], smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[1], _smp_processor_id())->mibs[field]++)
 #define SNMP_INC_STATS(mib, field) 	\
-	(per_cpu_ptr(mib[!in_softirq()], smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[!in_softirq()], _smp_processor_id())->mibs[field]++)
 #define SNMP_DEC_STATS(mib, field) 	\
-	(per_cpu_ptr(mib[!in_softirq()], smp_processor_id())->mibs[field]--)
+	(per_cpu_ptr(mib[!in_softirq()], _smp_processor_id())->mibs[field]--)
 #define SNMP_ADD_STATS_BH(mib, field, addend) 	\
-	(per_cpu_ptr(mib[0], smp_processor_id())->mibs[field] += addend)
+	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field] += addend)
 #define SNMP_ADD_STATS_USER(mib, field, addend) 	\
-	(per_cpu_ptr(mib[1], smp_processor_id())->mibs[field] += addend)
+	(per_cpu_ptr(mib[1], _smp_processor_id())->mibs[field] += addend)
 
 #endif
--- linux/kernel/printk.c	
+++ linux/kernel/printk.c	
@@ -641,8 +641,9 @@ void release_console_sem(void)
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
 		call_console_drivers(_con_start, _log_end);
+		local_irq_restore(flags);
 	}
 	console_locked = 0;
 	console_may_schedule = 0;
--- linux/kernel/sched.c	
+++ linux/kernel/sched.c	
@@ -2288,6 +2288,56 @@ static inline int dependent_sleeper(int 
 }
 #endif
 
+#if defined(CONFIG_PREEMPT) && defined(__smp_processor_id)
+/*
+ * Debugging check.
+ */
+unsigned int smp_processor_id(void)
+{
+	unsigned long preempt_count = preempt_count();
+	int this_cpu = __smp_processor_id();
+	cpumask_t this_mask;
+
+	if (likely(preempt_count))
+		goto out;
+
+	if (irqs_disabled())
+		goto out;
+
+	/*
+	 * Kernel threads bound to a single CPU can safely use
+	 * smp_processor_id():
+	 */
+	this_mask = cpumask_of_cpu(this_cpu);
+
+	if (cpus_equal(current->cpus_allowed, this_mask))
+		goto out;
+
+	/*
+	 * It is valid to assume CPU-locality during early bootup:
+	 */
+	if (system_state != SYSTEM_RUNNING)
+		goto out;
+
+	/*
+	 * Avoid recursion:
+	 */
+	preempt_disable();
+
+	if (!printk_ratelimit())
+		goto out_enable;
+		
+	printk(KERN_ERR "using smp_processor_id() in preemptible code: %s/%d\n",
+		current->comm, current->pid);
+	dump_stack();
+
+out_enable:
+	preempt_enable_no_resched();
+out:
+	return this_cpu;
+}
+#endif
+
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
 /*
@@ -3406,7 +3456,7 @@ EXPORT_SYMBOL(yield);
  */
 void __sched io_schedule(void)
 {
-	struct runqueue *rq = this_rq();
+	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 
 	atomic_inc(&rq->nr_iowait);
 	schedule();
@@ -3417,7 +3467,7 @@ EXPORT_SYMBOL(io_schedule);
 
 long __sched io_schedule_timeout(long timeout)
 {
-	struct runqueue *rq = this_rq();
+	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
 	long ret;
 
 	atomic_inc(&rq->nr_iowait);
--- linux/kernel/softirq.c	
+++ linux/kernel/softirq.c	
@@ -137,12 +137,19 @@ EXPORT_SYMBOL(do_softirq);
 
 void local_bh_enable(void)
 {
-	__local_bh_enable();
 	WARN_ON(irqs_disabled());
-	if (unlikely(!in_interrupt() &&
-		     local_softirq_pending()))
+	if (unlikely(!in_interrupt() && local_softirq_pending())) {
+		/*
+		 * Keep preemption disabled until we are done with
+		 * softirq processing:
+	 	 */
+		preempt_count() -= SOFTIRQ_OFFSET - 1;
 		invoke_softirq();
-	preempt_check_resched();
+		preempt_enable();
+	} else {
+		__local_bh_enable();
+		preempt_check_resched();
+	}
 }
 EXPORT_SYMBOL(local_bh_enable);
 
