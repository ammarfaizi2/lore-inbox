Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWJWEhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWJWEhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWJWEhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:37:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29134 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751349AbWJWEhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:37:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] x86_64 irq: Only look at per_cpu data for online cpus.
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
	<m1psck21fc.fsf@ebiederm.dsl.xmission.com>
	<20061022085216.GQ5211@rhun.haifa.ibm.com>
	<m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 22 Oct 2006 22:35:34 -0600
In-Reply-To: <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 22 Oct 2006 22:32:07 -0600")
Message-ID: <m1k62ry7hl.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I generalized __assign_irq_vector I failed to pay attention
to what happens when you access a per cpu data structure for
a cpu that is not online.   It is an undefined case making any
code that does it have undefined behavior as well.

The code still needs to be able to allocate a vector across cpus
that are not online to properly handle combinations like lowest
priority interrupt delivery and cpu_hotplug.  Not that we can do
that today but the infrastructure shouldn't prevent it.

So this patch updates the places where we touch per cpu data
to only touch online cpus, it makes cpu vector allocation
an atomic operation with respect to cpu hotplug, and it updates
the cpu start code to properly initialize vector_irq so we
don't have inconsistencies.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   42 +++++++++++++++++++++++++++++++++++++-----
 arch/x86_64/kernel/smpboot.c |    7 ++++++-
 include/asm-x86_64/hw_irq.h  |    2 ++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 0e89ae7..df33383 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -63,7 +63,7 @@ int timer_over_8254 __initdata = 1;
 static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
 static DEFINE_SPINLOCK(ioapic_lock);
-static DEFINE_SPINLOCK(vector_lock);
+DEFINE_SPINLOCK(vector_lock);
 
 /*
  * # of IRQ routing registers
@@ -618,6 +618,9 @@ static int __assign_irq_vector(int irq, 
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
+	/* Only try and allocate irqs on cpus that are present */
+	cpus_and(mask, mask, cpu_online_map);
+
 	if (irq_vector[irq] > 0)
 		old_vector = irq_vector[irq];
 	if (old_vector > 0) {
@@ -627,11 +630,12 @@ static int __assign_irq_vector(int irq, 
 	}
 
 	for_each_cpu_mask(cpu, mask) {
-		cpumask_t domain;
+		cpumask_t domain, new_mask;
 		int new_cpu;
 		int vector, offset;
 
 		domain = vector_allocation_domain(cpu);
+		cpus_and(new_mask, domain, cpu_online_map);
 
 		vector = current_vector;
 		offset = current_offset;
@@ -646,18 +650,20 @@ next:
 			continue;
 		if (vector == IA32_SYSCALL_VECTOR)
 			goto next;
-		for_each_cpu_mask(new_cpu, domain)
+		for_each_cpu_mask(new_cpu, new_mask)
 			if (per_cpu(vector_irq, new_cpu)[vector] != -1)
 				goto next;
 		/* Found one! */
 		current_vector = vector;
 		current_offset = offset;
 		if (old_vector >= 0) {
+			cpumask_t old_mask;
 			int old_cpu;
-			for_each_cpu_mask(old_cpu, irq_domain[irq])
+			cpus_and(old_mask, irq_domain[irq], cpu_online_map);
+			for_each_cpu_mask(old_cpu, old_mask)
 				per_cpu(vector_irq, old_cpu)[old_vector] = -1;
 		}
-		for_each_cpu_mask(new_cpu, domain)
+		for_each_cpu_mask(new_cpu, new_mask)
 			per_cpu(vector_irq, new_cpu)[vector] = irq;
 		irq_vector[irq] = vector;
 		irq_domain[irq] = domain;
@@ -678,6 +684,32 @@ static int assign_irq_vector(int irq, cp
 	return vector;
 }
 
+void __setup_vector_irq(int cpu)
+{
+	/* Initialize vector_irq on a new cpu */
+	/* This function must be called with vector_lock held */
+	unsigned long flags;
+	int irq, vector;
+	
+
+	/* Mark the inuse vectors */
+	for (irq = 0; irq < NR_IRQ_VECTORS; ++irq) {
+		if (!cpu_isset(cpu, irq_domain[irq]))
+			continue;
+		vector = irq_vector[irq];
+		per_cpu(vector_irq, cpu)[vector] = irq;
+	}
+	/* Mark the free vectors */
+	for (vector = 0; vector < NR_VECTORS; ++vector) {
+		irq = per_cpu(vector_irq, cpu)[vector];
+		if (irq < 0)
+			continue;
+		if (!cpu_isset(cpu, irq_domain[irq]))
+			per_cpu(vector_irq, cpu)[vector] = -1;
+	}
+}
+
+
 extern void (*interrupt[NR_IRQS])(void);
 
 static struct irq_chip ioapic_chip;
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index 7b7a687..62c2e74 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -581,12 +581,16 @@ void __cpuinit start_secondary(void)
 	 * smp_call_function().
 	 */
 	lock_ipi_call_lock();
+	spin_lock(&vector_lock);
 
+	/* Setup the per cpu irq handling data structures */
+	__setup_vector_irq(smp_processor_id());
 	/*
 	 * Allow the master to continue.
 	 */
 	cpu_set(smp_processor_id(), cpu_online_map);
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+	spin_unlock(&vector_lock);
 	unlock_ipi_call_lock();
 
 	cpu_idle();
@@ -799,7 +803,6 @@ static int __cpuinit do_boot_cpu(int cpu
 				cpu, node);
 	}
 
-
 	alternatives_smp_switch(1);
 
 	c_idle.idle = get_idle_for_cpu(cpu);
@@ -1246,8 +1249,10 @@ int __cpu_disable(void)
 	local_irq_disable();
 	remove_siblinginfo(cpu);
 
+	spin_lock(&vector_lock);
 	/* It's now safe to remove this processor from the online map */
 	cpu_clear(cpu, cpu_online_map);
+	spin_unlock(&vector_lock);
 	remove_cpu_from_maps();
 	fixup_irqs(cpu_online_map);
 	return 0;
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
index 792dd52..179cce7 100644
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -76,6 +76,8 @@ #define FIRST_SYSTEM_VECTOR	0xef   /* du
 #ifndef __ASSEMBLY__
 typedef int vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
+extern void __setup_vector_irq(int cpu);
+extern spinlock_t vector_lock;
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
-- 
1.4.2.rc3.g7e18e-dirty

