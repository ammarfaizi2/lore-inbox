Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUDAN67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUDAN67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:58:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10977 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262913AbUDAN6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:58:50 -0500
Date: Thu, 1 Apr 2004 19:27:52 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: mbligh@aracnet.com, akpm@osdl.org, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <20040401135752.GB3607@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040330173620.6fa69482.akpm@osdl.org> <276260000.1080697873@flay> <20040331044304.GA5167@in.ibm.com> <20040401004251.6c36ffcf.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401004251.6c36ffcf.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Apr 01, 2004 at 12:42:51AM -0800, Paul Jackson wrote:
> Hari,
> 
> I see code similar to what you are changing, also in the file:
> 
> 	arch/x86_64/kernel/smp.c
> 
> Do your considerations apply here as well?

I think they do. Although I can't recreate the problem to verify (no kexec
on x86_64). 

The attached patch is just an extension of Andy's patch to cover x86_64.

Regards, Hari
-
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore


diff -Naurp before/arch/i386/kernel/smp.c after/arch/i386/kernel/smp.c
--- before/arch/i386/kernel/smp.c	2004-03-30 08:55:32.000000000 +0530
+++ after/arch/i386/kernel/smp.c	2004-04-01 18:26:22.000000000 +0530
@@ -355,8 +355,6 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	BUG_ON(cpus_empty(cpumask));
 
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
@@ -367,16 +365,24 @@ static void flush_tlb_others(cpumask_t c
 	 * detected by the NMI watchdog.
 	 */
 	spin_lock(&tlbstate_lock);
+
+	/* Subtle, mask the request mask with the currently online cpu's.
+	 * Sample this under the lock; cpus in the the middle of going
+	 * offline will wait until there is noone in this critical section
+	 * before disabling IPI handling. */
+	cpus_and(tmp, cpumask, cpu_online_map);
+	if(cpus_empty(tmp))
+		goto out_unlock;
 	
 	flush_mm = mm;
 	flush_va = va;
 #if NR_CPUS <= BITS_PER_LONG
-	atomic_set_mask(cpumask, &flush_cpumask);
+	atomic_set_mask(tmp, &flush_cpumask);
 #else
 	{
 		int k;
 		unsigned long *flush_mask = (unsigned long *)&flush_cpumask;
-		unsigned long *cpu_mask = (unsigned long *)&cpumask;
+		unsigned long *cpu_mask = (unsigned long *)&tmp;
 		for (k = 0; k < BITS_TO_LONGS(NR_CPUS); ++k)
 			atomic_set_mask(cpu_mask[k], &flush_mask[k]);
 	}
@@ -385,7 +391,7 @@ static void flush_tlb_others(cpumask_t c
 	 * We have to send the IPI only to
 	 * CPUs affected.
 	 */
-	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
+	send_IPI_mask(tmp, INVALIDATE_TLB_VECTOR);
 
 	while (!cpus_empty(flush_cpumask))
 		/* nothing. lockup detection does not belong here */
@@ -393,6 +399,7 @@ static void flush_tlb_others(cpumask_t c
 
 	flush_mm = NULL;
 	flush_va = 0;
+out_unlock:
 	spin_unlock(&tlbstate_lock);
 }
 	
@@ -514,11 +521,8 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	if (!cpus)
-		return 0;
-
+	int cpus;
+       
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -527,6 +531,15 @@ int smp_call_function (void (*func) (voi
 		atomic_set(&data.finished, 0);
 
 	spin_lock(&call_lock);
+
+	/* Subtle, get the current number of online cpus.
+	 * Sample this under the lock; cpus in the the middle of going
+	 * offline will wait until there is noone in this critical section
+	 * before disabling IPI handling. */
+	cpus = num_online_cpus()-1;
+	if (!cpus)
+		goto out_unlock;
+
 	call_data = &data;
 	mb();
 	
@@ -540,6 +553,7 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
+out_unlock:
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -551,6 +565,20 @@ static void stop_this_cpu (void * dummy)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
+
+	/* Subtle, IPI users assume that they will be able to get IPI's
+	 * though to the cpus listed in cpu_online_map.  To ensure this
+	 * we add the requirement that they check cpu_online_map within
+	 * the IPI critical sections.  Here we remove ourselves from the
+	 * map, then ensure that all other cpus have left the relevant
+	 * critical sections since the change.  We do this by aquiring
+	 * the relevant section locks, if we have them none else is in 
+	 * them.  Once this is done we can go offline. */
+	spin_lock(&tlbstate_lock);
+	spin_unlock(&tlbstate_lock);
+	spin_lock(&call_lock);
+	spin_unlock(&call_lock);
+
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
diff -Naurp before/arch/x86_64/kernel/smp.c after/arch/x86_64/kernel/smp.c
--- before/arch/x86_64/kernel/smp.c	2004-03-30 08:55:37.000000000 +0530
+++ after/arch/x86_64/kernel/smp.c	2004-04-01 18:36:56.000000000 +0530
@@ -243,8 +243,6 @@ static void flush_tlb_others(cpumask_t c
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(tmp, cpumask));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	if (!mm)
 		BUG();
@@ -256,22 +254,31 @@ static void flush_tlb_others(cpumask_t c
 	 * detected by the NMI watchdog.
 	 */
 	spin_lock(&tlbstate_lock);
+
+        /* Subtle, mask the request mask with the currently online cpu's.
+         * Sample this under the lock; cpus in the the middle of going
+         * offline will wait until there is noone in this critical section
+         * before disabling IPI handling. */
+        cpus_and(tmp, cpumask, cpu_online_map);
+        if(cpus_empty(tmp))
+                goto out_unlock;
 	
 	flush_mm = mm;
 	flush_va = va;
-	cpus_or(flush_cpumask, cpumask, flush_cpumask);
+	cpus_or(flush_cpumask, tmp, flush_cpumask);
 
 	/*
 	 * We have to send the IPI only to
 	 * CPUs affected.
 	 */
-	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
+	send_IPI_mask(tmp, INVALIDATE_TLB_VECTOR);
 
 	while (!cpus_empty(flush_cpumask))
 		mb();	/* nothing. lockup detection does not belong here */;
 
 	flush_mm = NULL;
 	flush_va = 0;
+out_unlock:
 	spin_unlock(&tlbstate_lock);
 }
 	
@@ -399,10 +406,7 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	if (!cpus)
-		return 0;
+	int cpus;
 
 	data.func = func;
 	data.info = info;
@@ -412,6 +416,16 @@ int smp_call_function (void (*func) (voi
 		atomic_set(&data.finished, 0);
 
 	spin_lock(&call_lock);
+
+        /* Subtle, get the current number of online cpus.
+         * Sample this under the lock; cpus in the the middle of going
+         * offline will wait until there is noone in this critical section
+         * before disabling IPI handling. */
+        cpus = num_online_cpus()-1;
+        if (!cpus)
+                goto out_unlock;
+
+
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -424,6 +438,7 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
+out_unlock:
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -435,6 +450,20 @@ void smp_stop_cpu(void)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
+
+        /* Subtle, IPI users assume that they will be able to get IPI's
+         * though to the cpus listed in cpu_online_map.  To ensure this
+         * we add the requirement that they check cpu_online_map within
+         * the IPI critical sections.  Here we remove ourselves from the
+         * map, then ensure that all other cpus have left the relevant
+         * critical sections since the change.  We do this by aquiring
+         * the relevant section locks, if we have them none else is in
+         * them.  Once this is done we can go offline. */
+        spin_lock(&tlbstate_lock);
+        spin_unlock(&tlbstate_lock);
+        spin_lock(&call_lock);
+        spin_unlock(&call_lock);
+
 	local_irq_disable();
 	disable_local_APIC();
 	local_irq_enable(); 
