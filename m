Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUAHBcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUAHBcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:32:23 -0500
Received: from dp.samba.org ([66.70.73.150]:4248 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263015AbUAHBcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:32:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: shutdown panic in mm_release (really flush_tlb_others?) 
In-reply-to: Your message of "Tue, 06 Jan 2004 22:13:10 -0800."
             <12800000.1073455988@[10.10.2.4]> 
Date: Thu, 08 Jan 2004 12:04:55 +1100
Message-Id: <20040108013207.059D72C122@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <12800000.1073455988@[10.10.2.4]> you write:
> There doesn't seem to be anything locking cpu_online_map, AFAICS,
> so presumably stop_this_cpu is futzing with it whilst we try to
> shove tlb stuff out to other people.

These attempts to bring the CPUs down at shutdown are optimistic.  The
hotplug CPU code does a superset of this, and we (particularly Vatsa)
found all kinds of races in x86.

Here's part of the patch from the hotplug CPU code, which might
provide some inspiration.  It passes fairly serious stress testing.

Points:
1) skip_call_ipi is to effectively clear IPIs when a cpu first comes
   back up, which you don't care about.

2) cpu_active_map is a superset of cpu_online_map: when a CPU is in
   the process of going down, cpu_online() is false, but the
   cpu_active_map is only cleared once the CPU actually stops taking
   interrupts (ie. really dead).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6045-2.6.1-rc2-bk1-hotcpu-i386.pre/arch/i386/kernel/smp.c .6045-2.6.1-rc2-bk1-hotcpu-i386/arch/i386/kernel/smp.c
--- .6045-2.6.1-rc2-bk1-hotcpu-i386.pre/arch/i386/kernel/smp.c	2003-09-22 10:27:28.000000000 +1000
+++ .6045-2.6.1-rc2-bk1-hotcpu-i386/arch/i386/kernel/smp.c	2004-01-07 16:28:14.000000000 +1100
@@ -26,6 +26,8 @@
 #include <mach_ipi.h>
 #include <mach_apic.h>
 
+DECLARE_PER_CPU(int, skip_call_ipi);
+
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
  *
@@ -355,11 +357,15 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	BUG_ON(cpus_empty(cpumask));
 
-	cpus_and(tmp, cpumask, cpu_online_map);
+	cpus_and(tmp, cpumask, cpu_callout_map);
 	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
+	cpus_and(cpumask, cpumask, cpu_active_map);
+	if (cpus_empty(cpumask))
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -387,9 +393,11 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (!cpus_empty(flush_cpumask))
-		/* nothing. lockup detection does not belong here */
+	do {
 		mb();
+		tmp = flush_cpumask;
+		cpus_and(tmp, tmp, cpu_active_map);
+	} while (!cpus_empty(tmp));
 
 	flush_mm = NULL;
 	flush_va = 0;
@@ -486,8 +494,8 @@ static spinlock_t call_lock = SPIN_LOCK_
 struct call_data_struct {
 	void (*func) (void *info);
 	void *info;
-	atomic_t started;
-	atomic_t finished;
+	cpumask_t not_started;
+	cpumask_t not_finished;
 	int wait;
 };
 
@@ -514,32 +522,44 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	cpumask_t mask;
+	int cpu;
 
-	if (!cpus)
-		return 0;
+	spin_lock(&call_lock);
 
+	cpu = smp_processor_id();
 	data.func = func;
 	data.info = info;
-	atomic_set(&data.started, 0);
+	data.not_started = cpu_active_map;
+	cpu_clear(cpu, data.not_started);
+	if (cpus_empty(data.not_started))
+		goto out_unlock;
+
 	data.wait = wait;
 	if (wait)
-		atomic_set(&data.finished, 0);
+		data.not_finished = data.not_started;
 
-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();
 	
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(data.not_started, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
-		barrier();
+	do {
+		mb();
+		mask = data.not_started;
+		cpus_and(mask, mask, cpu_active_map);
+	} while(!cpus_empty(mask));
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
-			barrier();
+		do {
+			mb();
+			mask = data.not_finished;
+			cpus_and(mask, mask, cpu_active_map);
+		} while(!cpus_empty(mask));
+
+out_unlock:
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -551,6 +571,7 @@ static void stop_this_cpu (void * dummy)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
+	cpu_clear(smp_processor_id(), cpu_active_map);
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
@@ -583,17 +604,33 @@ asmlinkage void smp_reschedule_interrupt
 
 asmlinkage void smp_call_function_interrupt(void)
 {
-	void (*func) (void *info) = call_data->func;
-	void *info = call_data->info;
-	int wait = call_data->wait;
+	void (*func) (void *info);
+	void *info;
+	int wait;
+	int cpu = smp_processor_id();
 
 	ack_APIC_irq();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (__get_cpu_var(skip_call_ipi)) {
+		printk ("Ignoring Queueed IPI \n");
+		__get_cpu_var(skip_call_ipi) = 0;
+		return;
+	}
+#endif
+
+	func = call_data->func;
+	info = call_data->info;
+	wait = call_data->wait;
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
 	 */
-	mb();
-	atomic_inc(&call_data->started);
+	smp_mb__before_clear_bit();
+	cpu_clear(cpu, call_data->not_started);
+	smp_mb__after_clear_bit();
+
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
@@ -602,8 +638,9 @@ asmlinkage void smp_call_function_interr
 	irq_exit();
 
 	if (wait) {
-		mb();
-		atomic_inc(&call_data->finished);
+		smp_mb__before_clear_bit();
+		cpu_clear(cpu, call_data->not_finished);
+		smp_mb__after_clear_bit();
 	}
 }
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
