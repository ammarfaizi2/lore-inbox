Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUDCBqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUDCBqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:46:47 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:1286 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261347AbUDCBqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:46:36 -0500
Date: Sat, 03 Apr 2004 02:45:32 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Paul Jackson <pj@sgi.com>, hari@in.ibm.com, mbligh@aracnet.com,
       rddunlap@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <286840177.1080960332@[192.168.0.89]>
In-Reply-To: <20040401004251.6c36ffcf.pj@sgi.com> <20040401135752.GB3607@in.ibm.com>
References: <20040330173620.6fa69482.akpm@osdl.org>	<276260000.1080697873@flay>	<20040331044304.GA5167@in.ibm.com> <20040401004251.6c36ffcf.pj@sgi.com>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the latest version of the cpu shutdown race fix (cpu_race_R3).
Mostly a merging of some changes to in-code commentary (thanks to Randy)
and the addition of the x86_64 architecture portion (contributed by Hari).
Of course also based on Hari's original patch.

Feedback from Randy Dunlap is that this patch is at least as good as
previous solutions.  Testing on x86_64 in general would be appreciated.

Andrew, would you consider this for testing in -mm?

-apw

---
During the shutdown process cpus are taken offline.  If this process overlaps
with an ongoing TLB flush we can attempt to flush a cpu which is already
offline.  This triggers a BUG_ON in tlb_flush_others().  This occurs because
we do not remove an outgoing cpu from the VM state.

This patch does two things.  Firstly it validates the cpu mask passed
for the flush against the current online cpu mask preventing us from
flushing no longer valid cpus.  Secondly it ensures that the cpus found
to be online at this stage cannot go completely offline before the TLB
flush is complete.

---
 i386/kernel/smp.c   |   48 ++++++++++++++++++++++++++++++++++++++----------
 x86_64/kernel/smp.c |   46 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 19 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/kernel/smp.c current/arch/i386/kernel/smp.c
--- reference/arch/i386/kernel/smp.c	2004-03-11 20:47:12.000000000 +0000
+++ current/arch/i386/kernel/smp.c	2004-04-03 02:52:53.000000000 +0100
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
+	 * Sample this under the lock; cpus in the middle of going offline
+	 * will wait until there is noone in this critical section before
+	 * disabling IPI handling. */
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
+	 * Sample this under the lock; cpus in the middle of going offline
+	 * will wait until there is noone in this critical section before
+	 * disabling IPI handling. */
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
+	 * through to the cpus listed in cpu_online_map.  To ensure this
+	 * we add the requirement that they check cpu_online_map within
+	 * the IPI critical sections.  Here we remove ourselves from the
+	 * map, then ensure that all other cpus have left the relevant
+	 * critical sections since the change.  We do this by acquiring
+	 * the relevant section locks, if we have them noone else is in
+	 * them.  Once this is done we can go offline. */
+	spin_lock(&tlbstate_lock);
+	spin_unlock(&tlbstate_lock);
+	spin_lock(&call_lock);
+	spin_unlock(&call_lock);
+
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/x86_64/kernel/smp.c current/arch/x86_64/kernel/smp.c
--- reference/arch/x86_64/kernel/smp.c	2004-01-09 06:59:19.000000000 +0000
+++ current/arch/x86_64/kernel/smp.c	2004-04-03 03:14:01.000000000 +0100
@@ -243,8 +243,6 @@ static void flush_tlb_others(cpumask_t c
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(tmp, cpumask));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	if (!mm)
 		BUG();
@@ -257,21 +255,30 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	spin_lock(&tlbstate_lock);
 	
+	/* Subtle, mask the request mask with the currently online cpu's.
+	 * Sample this under the lock; cpus in the middle of going offline
+	 * will wait until there is noone in this critical section before
+	 * disabling IPI handling. */
+	cpus_and(tmp, cpumask, cpu_online_map);
+	if(cpus_empty(tmp))
+		goto out_unlock;
+
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
 	
@@ -399,11 +406,8 @@ int smp_call_function (void (*func) (voi
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
@@ -412,6 +416,15 @@ int smp_call_function (void (*func) (voi
 		atomic_set(&data.finished, 0);

 	spin_lock(&call_lock);
+
+	/* Subtle, get the current number of online cpus.
+	 * Sample this under the lock; cpus in the middle of going offline
+	 * will wait until there is noone in this critical section before
+	 * disabling IPI handling. */
+	cpus = num_online_cpus()-1;
+	if (!cpus)
+		goto out_unlock;
+
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -424,6 +437,7 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
+out_unlock:
 	spin_unlock(&call_lock);

 	return 0;
@@ -435,6 +449,20 @@ void smp_stop_cpu(void)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
+
+	/* Subtle, IPI users assume that they will be able to get IPI's
+	 * through to the cpus listed in cpu_online_map.  To ensure this
+	 * we add the requirement that they check cpu_online_map within
+	 * the IPI critical sections.  Here we remove ourselves from the
+	 * map, then ensure that all other cpus have left the relevant
+	 * critical sections since the change.  We do this by acquiring
+	 * the relevant section locks, if we have them noone else is in
+	 * them.  Once this is done we can go offline. */
+	spin_lock(&tlbstate_lock);
+	spin_unlock(&tlbstate_lock);
+	spin_lock(&call_lock);
+	spin_unlock(&call_lock);
+
 	local_irq_disable();
 	disable_local_APIC();
 	local_irq_enable();

