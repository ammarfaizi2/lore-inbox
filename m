Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUDALhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUDALhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:37:47 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:22547 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262866AbUDALhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:37:23 -0500
Date: Thu, 01 Apr 2004 12:38:40 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: vatsa@in.ibm.com
cc: "Martin J. Bligh" <mbligh@aracnet.com>, hari@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <7621629.1080823120@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <20040401050413.GA4056@in.ibm.com>
References: <20040330173620.6fa69482.akpm@osdl.org> <276260000.1080697873@flay> <109577502.1080783067@[192.168.0.89]> <20040401050413.GA4056@in.ibm.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 01 April 2004 10:34 +0530 Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Hmm ..Doesn't it need to drop tlbstate_lock before returning?
> The second lock should be call_lock?

Yes and Yes.  I don't know how Andrew copes with 300 odd patches. 
I don't seem to be able to keep track of the versions on 3 of them?
Seems I sent out an old version.  Doh.  Explicit version numbers
from now on.

Below is tested version of the patch.  If anyone can reproduce the
issue I would be interested in knowing if this passes a reboot on
that system.

Apologies for the confusion.  And thanks for reviewing!

-apw

---
 smp.c |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff -upN reference/arch/i386/kernel/smp.c current/arch/i386/kernel/smp.c
--- reference/arch/i386/kernel/smp.c	2004-03-11 20:47:12.000000000 +0000
+++ current/arch/i386/kernel/smp.c	2004-04-01 12:35:40.000000000 +0100
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

