Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWJHNuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWJHNuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWJHNuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:50:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62867 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751166AbWJHNuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:50:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] x86_64 irq:  Allocate a vector across all cpus for genapic_flat.
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<20061007175926.GN14186@rhun.haifa.ibm.com>
	<m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fydzudq8.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqomvs6l.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 08 Oct 2006 07:47:55 -0600
In-Reply-To: <m1bqomvs6l.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 08 Oct 2006 07:43:46 -0600")
Message-ID: <m17izavrzo.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem we can't take advantage of lowest priority delivery
mode if the vectors are allocated for only one cpu at a time.
Nor can we work around hardware that assumes lowest priority
delivery mode is always used with several cpus.

So this patch introduces the concept of a vector_allocation_domain.
A set of cpus that will receive an irq on the same vector.  Currently
the code for implementing this is placed in the genapic structure
so we can vary this depending on how we are using the io_apics.

This allows us to restore the previous behaviour of genapic_flat
without removing the benefits of having separate vector allocation
for large machines.

This should also fix the problem report where a hyperthreaded
cpu was receving the irq on the wrong hyperthread when in
logical delivery mode because the previous behaviour is restored.

This patch properly records our allocation of the first 16 irqs
to the first 16 available vectors on all cpus.  This should be
fine but it may run into problems with multiple interrupts at
the same interrupt level.  Except for some badly maintained comments
in the code and the behaviour of the interrupt allocator I have
no real understanding of that problem.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/genapic_cluster.c |    8 ++
 arch/x86_64/kernel/genapic_flat.c    |   24 ++++++
 arch/x86_64/kernel/io_apic.c         |  131 ++++++++++++++++++++++------------
 include/asm-x86_64/genapic.h         |    1 
 include/asm-x86_64/mach_apic.h       |    1 
 5 files changed, 117 insertions(+), 48 deletions(-)

diff --git a/arch/x86_64/kernel/genapic_cluster.c b/arch/x86_64/kernel/genapic_cluster.c
index cdb90e6..73d7630 100644
--- a/arch/x86_64/kernel/genapic_cluster.c
+++ b/arch/x86_64/kernel/genapic_cluster.c
@@ -63,6 +63,13 @@ static cpumask_t cluster_target_cpus(voi
 	return cpumask_of_cpu(0);
 }
 
+static cpumask_t cluster_vector_allocation_domain(int cpu)
+{
+	cpumask_t domain = CPU_MASK_NONE;
+	cpu_set(cpu, domain);
+	return domain;
+}
+
 static void cluster_send_IPI_mask(cpumask_t mask, int vector)
 {
 	send_IPI_mask_sequence(mask, vector);
@@ -119,6 +126,7 @@ struct genapic apic_cluster = {
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
 	.target_cpus = cluster_target_cpus,
+	.vector_allocation_domain = cluster_vector_allocation_domain,
 	.apic_id_registered = cluster_apic_id_registered,
 	.init_apic_ldr = cluster_init_apic_ldr,
 	.send_IPI_all = cluster_send_IPI_all,
diff --git a/arch/x86_64/kernel/genapic_flat.c b/arch/x86_64/kernel/genapic_flat.c
index 50ad153..0dfc223 100644
--- a/arch/x86_64/kernel/genapic_flat.c
+++ b/arch/x86_64/kernel/genapic_flat.c
@@ -22,6 +22,20 @@ static cpumask_t flat_target_cpus(void)
 	return cpu_online_map;
 }
 
+static cpumask_t flat_vector_allocation_domain(int cpu)
+{
+	/* Careful. Some cpus do not strictly honor the set of cpus
+	 * specified in the interrupt destination when using lowest
+	 * priority interrupt delivery mode.
+	 *
+	 * In particular there was a hyperthreading cpu observed to
+	 * deliver interrupts to the wrong hyperthread when only one
+	 * hyperthread was specified in the interrupt desitination.
+	 */
+	cpumask_t domain = { { [0] = APIC_ALL_CPUS, } };
+	return domain;
+}
+
 /*
  * Set up the logical destination ID.
  *
@@ -121,6 +135,7 @@ struct genapic apic_flat =  {
 	.int_delivery_mode = dest_LowestPrio,
 	.int_dest_mode = (APIC_DEST_LOGICAL != 0),
 	.target_cpus = flat_target_cpus,
+	.vector_allocation_domain = flat_vector_allocation_domain,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,
 	.send_IPI_all = flat_send_IPI_all,
@@ -141,6 +156,14 @@ static cpumask_t physflat_target_cpus(vo
 	return cpumask_of_cpu(0);
 }
 
+static cpumask_t physflat_vector_allocation_domain(int cpu)
+{
+	cpumask_t domain = CPU_MASK_NONE;
+	cpu_set(cpu, domain);
+	return domain;
+}
+
+
 static void physflat_send_IPI_mask(cpumask_t cpumask, int vector)
 {
 	send_IPI_mask_sequence(cpumask, vector);
@@ -179,6 +202,7 @@ struct genapic apic_physflat =  {
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
 	.target_cpus = physflat_target_cpus,
+	.vector_allocation_domain = physflat_vector_allocation_domain,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,/*not needed, but shouldn't hurt*/
 	.send_IPI_all = physflat_send_IPI_all,
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 9c3b9b1..771bcf7 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -47,7 +47,7 @@ #include <asm/nmi.h>
 #include <asm/msidef.h>
 #include <asm/hypertransport.h>
 
-static int assign_irq_vector(int irq, cpumask_t mask);
+static int assign_irq_vector(int irq, cpumask_t mask, cpumask_t *result);
 
 #define __apicdebuginit  __init
 
@@ -174,12 +174,10 @@ static void set_ioapic_affinity_irq(unsi
 
 	cpus_and(mask, tmp, CPU_MASK_ALL);
 
-	vector = assign_irq_vector(irq, mask);
+	vector = assign_irq_vector(irq, mask, &tmp);
 	if (vector < 0)
 		return;
 
-	cpus_clear(tmp);
-	cpu_set(vector >> 8, tmp);
 	dest = cpu_mask_to_apicid(tmp);
 
 	/*
@@ -188,7 +186,7 @@ static void set_ioapic_affinity_irq(unsi
 	dest = SET_APIC_LOGICAL_ID(dest);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__target_IO_APIC_irq(irq, dest, vector & 0xff);
+	__target_IO_APIC_irq(irq, dest, vector);
 	set_native_irq_info(irq, mask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
@@ -563,9 +561,45 @@ static inline int IO_APIC_irq_trigger(in
 }
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
-unsigned int irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_EXTERNAL_VECTOR, 0 };
+static u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = {
+	[0] = FIRST_EXTERNAL_VECTOR + 0,
+	[1] = FIRST_EXTERNAL_VECTOR + 1,
+	[2] = FIRST_EXTERNAL_VECTOR + 2,
+	[3] = FIRST_EXTERNAL_VECTOR + 3,
+	[4] = FIRST_EXTERNAL_VECTOR + 4,
+	[5] = FIRST_EXTERNAL_VECTOR + 5,
+	[6] = FIRST_EXTERNAL_VECTOR + 6,
+	[7] = FIRST_EXTERNAL_VECTOR + 7,
+	[8] = FIRST_EXTERNAL_VECTOR + 8,
+	[9] = FIRST_EXTERNAL_VECTOR + 9,
+	[10] = FIRST_EXTERNAL_VECTOR + 10,
+	[11] = FIRST_EXTERNAL_VECTOR + 11,
+	[12] = FIRST_EXTERNAL_VECTOR + 12,
+	[13] = FIRST_EXTERNAL_VECTOR + 13,
+	[14] = FIRST_EXTERNAL_VECTOR + 14,
+	[15] = FIRST_EXTERNAL_VECTOR + 15,
+};
+
+static cpumask_t irq_domain[NR_IRQ_VECTORS] __read_mostly = {
+	[0] = CPU_MASK_ALL,
+	[1] = CPU_MASK_ALL,
+	[2] = CPU_MASK_ALL,
+	[3] = CPU_MASK_ALL,
+	[4] = CPU_MASK_ALL,
+	[5] = CPU_MASK_ALL,
+	[6] = CPU_MASK_ALL,
+	[7] = CPU_MASK_ALL,
+	[8] = CPU_MASK_ALL,
+	[9] = CPU_MASK_ALL,
+	[10] = CPU_MASK_ALL,
+	[11] = CPU_MASK_ALL,
+	[12] = CPU_MASK_ALL,
+	[13] = CPU_MASK_ALL,
+	[14] = CPU_MASK_ALL,
+	[15] = CPU_MASK_ALL,
+};
 
-static int __assign_irq_vector(int irq, cpumask_t mask)
+static int __assign_irq_vector(int irq, cpumask_t mask, cpumask_t *result)
 {
 	/*
 	 * NOTE! The local APIC isn't very good at handling
@@ -589,14 +623,22 @@ static int __assign_irq_vector(int irq, 
 
 	if (irq_vector[irq] > 0)
 		old_vector = irq_vector[irq];
-	if ((old_vector > 0) && cpu_isset(old_vector >> 8, mask)) {
-		return old_vector;
+	if (old_vector > 0) {
+		cpus_and(*result, irq_domain[irq], mask);
+		if (!cpus_empty(*result))
+			return old_vector;
 	}
 
 	for_each_cpu_mask(cpu, mask) {
+		cpumask_t domain;
+		int first, new_cpu;
 		int vector, offset;
-		vector = pos[cpu].vector;
-		offset = pos[cpu].offset;
+
+		domain = vector_allocation_domain(cpu);
+		first = first_cpu(domain);
+
+		vector = pos[first].vector;
+		offset = pos[first].offset;
 next:
 		vector += 8;
 		if (vector >= FIRST_SYSTEM_VECTOR) {
@@ -604,35 +646,40 @@ next:
 			offset = (offset + 1) % 8;
 			vector = FIRST_DEVICE_VECTOR + offset;
 		}
-		if (unlikely(pos[cpu].vector == vector))
+		if (unlikely(pos[first].vector == vector))
 			continue;
 		if (vector == IA32_SYSCALL_VECTOR)
 			goto next;
-		if (per_cpu(vector_irq, cpu)[vector] != -1)
-			goto next;
+		for_each_cpu_mask(new_cpu, domain)
+			if (per_cpu(vector_irq, cpu)[vector] != -1)
+				goto next;
 		/* Found one! */
-		pos[cpu].vector = vector;
-		pos[cpu].offset = offset;
+		for_each_cpu_mask(new_cpu, domain) {
+			pos[cpu].vector = vector;
+			pos[cpu].offset = offset;
+		}
 		if (old_vector >= 0) {
-			int old_cpu = old_vector >> 8;
-			old_vector &= 0xff;
-			per_cpu(vector_irq, old_cpu)[old_vector] = -1;
+			int old_cpu;
+			for_each_cpu_mask(old_cpu, domain)
+				per_cpu(vector_irq, old_cpu)[old_vector] = -1;
 		}
-		per_cpu(vector_irq, cpu)[vector] = irq;
-		vector |= cpu << 8;
+		for_each_cpu_mask(new_cpu, domain)
+			per_cpu(vector_irq, new_cpu)[vector] = irq;
 		irq_vector[irq] = vector;
+		irq_domain[irq] = domain;
+		cpus_and(*result, domain, mask);
 		return vector;
 	}
 	return -ENOSPC;
 }
 
-static int assign_irq_vector(int irq, cpumask_t mask)
+static int assign_irq_vector(int irq, cpumask_t mask, cpumask_t *result)
 {
 	int vector;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vector_lock, flags);
-	vector = __assign_irq_vector(irq, mask);
+	vector = __assign_irq_vector(irq, mask, result);
 	spin_unlock_irqrestore(&vector_lock, flags);
 	return vector;
 }
@@ -704,14 +751,12 @@ static void __init setup_IO_APIC_irqs(vo
 
 		if (IO_APIC_IRQ(irq)) {
 			cpumask_t mask;
-			vector = assign_irq_vector(irq, TARGET_CPUS);
+			vector = assign_irq_vector(irq, TARGET_CPUS, &mask);
 			if (vector < 0)
 				continue;
 
-			cpus_clear(mask);
-			cpu_set(vector >> 8, mask);
 			entry.dest.logical.logical_dest = cpu_mask_to_apicid(mask);
-			entry.vector = vector & 0xff;
+			entry.vector = vector;
 
 			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
 			if (!apic && (irq < 16))
@@ -1430,12 +1475,13 @@ static inline void check_timer(void)
 {
 	int apic1, pin1, apic2, pin2;
 	int vector;
+	cpumask_t mask;
 
 	/*
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0, TARGET_CPUS);
+	vector = assign_irq_vector(0, TARGET_CPUS, &mask);
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -1667,6 +1713,7 @@ int create_irq(void)
 	int new;
 	int vector = 0;
 	unsigned long flags;
+	cpumask_t mask;
 
 	irq = -ENOSPC;
 	spin_lock_irqsave(&vector_lock, flags);
@@ -1675,7 +1722,7 @@ int create_irq(void)
 			continue;
 		if (irq_vector[new] != 0)
 			continue;
-		vector = __assign_irq_vector(new, TARGET_CPUS);
+		vector = __assign_irq_vector(new, TARGET_CPUS, &mask);
 		if (likely(vector > 0))
 			irq = new;
 		break;
@@ -1707,13 +1754,10 @@ static int msi_compose_msg(struct pci_de
 {
 	int vector;
 	unsigned dest;
+	cpumask_t tmp;
 
-	vector = assign_irq_vector(irq, TARGET_CPUS);
+	vector = assign_irq_vector(irq, TARGET_CPUS, &tmp);
 	if (vector >= 0) {
-		cpumask_t tmp;
-
-		cpus_clear(tmp);
-		cpu_set(vector >> 8, tmp);
 		dest = cpu_mask_to_apicid(tmp);
 
 		msg->address_hi = MSI_ADDR_BASE_HI;
@@ -1752,12 +1796,10 @@ static void set_msi_irq_affinity(unsigne
 
 	cpus_and(mask, tmp, CPU_MASK_ALL);
 
-	vector = assign_irq_vector(irq, mask);
+	vector = assign_irq_vector(irq, mask, &tmp);
 	if (vector < 0)
 		return;
 
-	cpus_clear(tmp);
-	cpu_set(vector >> 8, tmp);
 	dest = cpu_mask_to_apicid(tmp);
 
 	read_msi_msg(irq, &msg);
@@ -1844,12 +1886,10 @@ static void set_ht_irq_affinity(unsigned
 
 	cpus_and(mask, tmp, CPU_MASK_ALL);
 
-	vector = assign_irq_vector(irq, mask);
+	vector = assign_irq_vector(irq, mask, &tmp);
 	if (vector < 0)
 		return;
 
-	cpus_clear(tmp);
-	cpu_set(vector >> 8, tmp);
 	dest = cpu_mask_to_apicid(tmp);
 
 	target_ht_irq(irq, dest, vector & 0xff);
@@ -1871,15 +1911,13 @@ #endif
 int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)
 {
 	int vector;
+	cpumask_t tmp;
 
-	vector = assign_irq_vector(irq, TARGET_CPUS);
+	vector = assign_irq_vector(irq, TARGET_CPUS, &tmp);
 	if (vector >= 0) {
 		u32 low, high;
 		unsigned dest;
-		cpumask_t tmp;
 
-		cpus_clear(tmp);
-		cpu_set(vector >> 8, tmp);
 		dest = cpu_mask_to_apicid(tmp);
 
 		high = 	HT_IRQ_HIGH_DEST_ID(dest);
@@ -1945,13 +1983,10 @@ int io_apic_set_pci_routing (int ioapic,
 		add_pin_to_irq(irq, ioapic, pin);
 
 
-	vector = assign_irq_vector(irq, TARGET_CPUS);
+	vector = assign_irq_vector(irq, TARGET_CPUS, &mask);
 	if (vector < 0)
 		return vector;
 
-	cpus_clear(mask);
-	cpu_set(vector >> 8, mask);
-
 	/*
 	 * Generate a PCI IRQ routing entry and program the IOAPIC accordingly.
 	 * Note that we mask (disable) IRQs now -- these get enabled when the
diff --git a/include/asm-x86_64/genapic.h b/include/asm-x86_64/genapic.h
index 81e7146..a0e9a4b 100644
--- a/include/asm-x86_64/genapic.h
+++ b/include/asm-x86_64/genapic.h
@@ -18,6 +18,7 @@ struct genapic {
 	u32 int_dest_mode;
 	int (*apic_id_registered)(void);
 	cpumask_t (*target_cpus)(void);
+	cpumask_t (*vector_allocation_domain)(int cpu);
 	void (*init_apic_ldr)(void);
 	/* ipi */
 	void (*send_IPI_mask)(cpumask_t mask, int vector);
diff --git a/include/asm-x86_64/mach_apic.h b/include/asm-x86_64/mach_apic.h
index d334224..7b7115a 100644
--- a/include/asm-x86_64/mach_apic.h
+++ b/include/asm-x86_64/mach_apic.h
@@ -17,6 +17,7 @@ #include <asm/genapic.h>
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
 #define TARGET_CPUS	  (genapic->target_cpus())
+#define vector_allocation_domain	(genapic->vector_allocation_domain)
 #define apic_id_registered (genapic->apic_id_registered)
 #define init_apic_ldr (genapic->init_apic_ldr)
 #define send_IPI_mask (genapic->send_IPI_mask)
-- 
1.4.2.rc3.g7e18e-dirty

