Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWFTWhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWFTWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWFTWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:36:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57828 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751351AbWFTW3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:00 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 22/25] x86_64 irq: make vector_irq per cpu.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:35 -0600
Message-Id: <11508425262259-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425254020-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com> <11508425253581-git-send-email-ebiederm@xmission.com> <11508425254020-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the irq handling code to make the vectors
a per cpu resource so the same vector number can be simultaneously
used on multiple cpus for different irqs.

This should make systems that were hitting limits on the
total number of irqs much more livable.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/i8259.c   |    4 -
 arch/x86_64/kernel/io_apic.c |  185 +++++++++++++++++++++++++++++++-----------
 arch/x86_64/kernel/irq.c     |    2 
 include/asm-x86_64/hw_irq.h  |    5 +
 include/asm-x86_64/irq.h     |    4 -
 5 files changed, 145 insertions(+), 55 deletions(-)

diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index c3e737a..11c10f3 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -394,7 +394,7 @@ device_initcall(i8259A_init_sysfs);
  */
 
 static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
-int vector_irq[NR_VECTORS] __read_mostly = {
+DEFINE_PER_CPU(vector_irq_t, vector_irq) = { 
 	[0 ... FIRST_EXTERNAL_VECTOR - 1] = -1,
 	[FIRST_EXTERNAL_VECTOR + 0] = 0,
 	[FIRST_EXTERNAL_VECTOR + 1] = 1,
@@ -522,7 +522,7 @@ #ifdef CONFIG_SMP
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	vector_irq[FIRST_DEVICE_VECTOR] = 0;
+	__get_cpu_var(vector_irq)[FIRST_DEVICE_VECTOR] = 0;
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 3ff5606..f818d64 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -44,7 +44,7 @@ #include <asm/dma.h>
 #include <asm/nmi.h>
 #include <asm/msidef.h>
 
-static int assign_irq_vector(int irq);
+static int assign_irq_vector(int irq, cpumask_t mask);
 
 #define __apicdebuginit  __init
 
@@ -107,12 +107,36 @@ #define __DO_ACTION(R, ACTION, FINAL)			
 	FINAL;								\
 }
 
+static void __target_IO_APIC_irq(unsigned int irq, unsigned int dest, u8 vector)
+{
+	int apic, pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	BUG_ON(irq >= NR_IRQS);
+	for (;;) {
+		unsigned int reg;
+		apic = entry->apic;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		io_apic_write(apic, 0x11 + pin*2, dest);
+		reg = io_apic_read(apic, 0x10 + pin*2);
+		reg &= ~0x000000ff;
+		reg |= vector;
+		io_apic_modify(apic, reg);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
+
 #ifdef CONFIG_SMP
 static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
 {
 	unsigned long flags;
 	unsigned int dest;
 	cpumask_t tmp;
+	int vector;
 
 	cpus_and(tmp, mask, cpu_online_map);
 	if (cpus_empty(tmp))
@@ -120,7 +144,13 @@ static void set_ioapic_affinity_irq(unsi
 
 	cpus_and(mask, tmp, CPU_MASK_ALL);
 
-	dest = cpu_mask_to_apicid(mask);
+	vector = assign_irq_vector(irq, mask);
+	if (vector < 0)
+		return;
+
+	cpus_clear(tmp);
+	cpu_set(vector >> 8, tmp);
+	dest = cpu_mask_to_apicid(tmp);
 
 	/*
 	 * Only the high 8 bits are valid.
@@ -128,7 +158,7 @@ static void set_ioapic_affinity_irq(unsi
 	dest = SET_APIC_LOGICAL_ID(dest);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = dest, )
+	__target_IO_APIC_irq(irq, dest, vector & 0xff);
 	set_native_irq_info(irq, mask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
@@ -715,7 +745,7 @@ int gsi_irq_sharing(int gsi)
 
 	tries = NR_IRQS;
   try_again:
-	vector = assign_irq_vector(gsi);
+	vector = assign_irq_vector(gsi, TARGET_CPUS);
 
 	/*
 	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
@@ -826,45 +856,77 @@ static inline int IO_APIC_irq_trigger(in
 }
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
-u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
+unsigned int irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_EXTERNAL_VECTOR, 0 };
 
-static int __assign_irq_vector(int irq)
+static int __assign_irq_vector(int irq, cpumask_t mask)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	int vector;
+	/*
+	 * NOTE! The local APIC isn't very good at handling
+	 * multiple interrupts at the same interrupt level.
+	 * As the interrupt level is determined by taking the
+	 * vector number and shifting that right by 4, we
+	 * want to spread these out a bit so that they don't
+	 * all fall in the same interrupt level.
+	 *
+	 * Also, we've got to be careful not to trash gate
+	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
+	 */
+	static struct {
+		int vector;
+		int offset;
+	} pos[NR_CPUS] = { [ 0 ... NR_CPUS - 1] = {FIRST_DEVICE_VECTOR, 0} };
+	int old_vector = -1;
+	int cpu;
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
-	if (IO_APIC_VECTOR(irq) > 0) {
-		return IO_APIC_VECTOR(irq);
+	if (IO_APIC_VECTOR(irq) > 0)
+		old_vector = IO_APIC_VECTOR(irq);
+	if ((old_vector > 0) && cpu_isset(old_vector >> 8, mask)) {
+		return old_vector;
 	}
+
+	for_each_cpu_mask(cpu, mask) {
+		int vector, offset;
+		vector = pos[cpu].vector;
+		offset = pos[cpu].offset;
 next:
-	current_vector += 8;
-	if (current_vector == IA32_SYSCALL_VECTOR)
-		goto next;
-
-	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		/* If we run out of vectors on large boxen, must share them. */
-		offset = (offset + 1) % 8;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+		vector += 8;
+		if (vector >= FIRST_SYSTEM_VECTOR) {
+			/* If we run out of vectors on large boxen, must share them. */
+			offset = (offset + 1) % 8;
+			vector = FIRST_DEVICE_VECTOR + offset;
+		}
+		if (unlikely(pos[cpu].vector == vector))
+			continue;
+		if (vector == IA32_SYSCALL_VECTOR)
+			goto next;
+		if (per_cpu(vector_irq, cpu)[vector] != -1)
+			goto next;
+		/* Found one! */
+		pos[cpu].vector = vector;
+		pos[cpu].offset = offset;
+		if (old_vector >= 0) {
+			int old_cpu = old_vector >> 8;
+			old_vector &= 0xff;
+			per_cpu(vector_irq, old_cpu)[old_vector] = -1;
+		}
+		per_cpu(vector_irq, cpu)[vector] = irq;
+		vector |= cpu << 8;
+		IO_APIC_VECTOR(irq) = vector;
+		return vector;
 	}
-
-	vector = current_vector;
-	vector_irq[vector] = irq;
-	IO_APIC_VECTOR(irq) = vector;
-
-	return vector;
+	return -ENOSPC;
 }
 
-static int assign_irq_vector(int irq)
+static int assign_irq_vector(int irq, cpumask_t mask)
 {
 	int vector;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vector_lock, flags);
-	vector = __assign_irq_vector(irq);
+	vector = __assign_irq_vector(irq, mask);
 	spin_unlock_irqrestore(&vector_lock, flags);
-
 	return vector;
 }
 
@@ -934,8 +996,15 @@ static void __init setup_IO_APIC_irqs(vo
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
-			entry.vector = vector;
+			cpumask_t mask;
+			vector = assign_irq_vector(irq, TARGET_CPUS);
+			if (vector < 0)
+				continue;
+
+			cpus_clear(mask);
+			cpu_set(vector >> 8, mask);
+			entry.dest.logical.logical_dest = cpu_mask_to_apicid(mask);
+			entry.vector = vector & 0xff;
 
 			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
 			if (!apic && (irq < 16))
@@ -1514,7 +1583,14 @@ static unsigned int startup_ioapic_irq(u
 
 static int ioapic_retrigger_irq(unsigned int irq)
 {
-	send_IPI_self(IO_APIC_VECTOR(irq));
+	cpumask_t mask;
+	unsigned vector;
+
+	vector = irq_vector[irq];
+	cpus_clear(mask);
+	cpu_set(vector >> 8, mask);
+
+	send_IPI_mask(mask, vector & 0xff);
 
 	return 1;
 }
@@ -1726,7 +1802,7 @@ static inline void check_timer(void)
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
+	vector = assign_irq_vector(0, TARGET_CPUS);
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -1979,7 +2055,7 @@ int create_irq(void)
 			continue;
 		if (irq_vector[new] != 0)
 			continue;
-		vector = __assign_irq_vector(new);
+		vector = __assign_irq_vector(new, TARGET_CPUS);
 		if (likely(vector > 0))
 			irq = new;
 		break;
@@ -2015,14 +2091,14 @@ static int msi_msg_setup(struct pci_dev 
 	int vector;
 	unsigned dest;
 
-	vector = assign_irq_vector(irq);
+	vector = assign_irq_vector(irq, TARGET_CPUS);
 	if (vector >= 0) {
 		cpumask_t tmp;
-
+		
 		cpus_clear(tmp);
-		cpu_set(first_cpu(cpu_online_map), tmp);
+		cpu_set(vector >> 8, tmp);
 		dest = cpu_mask_to_apicid(tmp);
-
+		
 		msg->address_hi = MSI_ADDR_BASE_HI;
 		msg->address_lo =
 			MSI_ADDR_BASE_LO |
@@ -2055,9 +2131,13 @@ static void msi_msg_set_affinity(unsigne
 	int vector;
 	unsigned dest;
 
-	vector = assign_irq_vector(irq);
+	vector = assign_irq_vector(irq, mask);
 	if (vector > 0) {
-		dest = cpu_mask_to_apicid(mask);
+		cpumask_t tmp;
+
+		cpus_clear(tmp);
+		cpu_set(vector >> 8, tmp);
+		dest = cpu_mask_to_apicid(tmp);
 
 		msg->data &= ~MSI_DATA_VECTOR_MASK;
 		msg->data |= MSI_DATA_VECTOR(vector);
@@ -2113,6 +2193,8 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int vector;
+	cpumask_t mask;
 
 	if (!IO_APIC_IRQ(irq)) {
 		apic_printk(APIC_QUIET,KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0\n",
@@ -2120,6 +2202,21 @@ int io_apic_set_pci_routing (int ioapic,
 		return -EINVAL;
 	}
 
+	irq = gsi_irq_sharing(irq);
+	/*
+	 * IRQs < 16 are already in the irq_2_pin[] map
+	 */
+	if (irq >= 16)
+		add_pin_to_irq(irq, ioapic, pin);
+
+
+	vector = assign_irq_vector(irq, TARGET_CPUS);
+	if (vector < 0)
+		return vector;
+
+	cpus_clear(mask);
+	cpu_set(vector >> 8, mask);
+
 	/*
 	 * Generate a PCI IRQ routing entry and program the IOAPIC accordingly.
 	 * Note that we mask (disable) IRQs now -- these get enabled when the
@@ -2130,19 +2227,11 @@ int io_apic_set_pci_routing (int ioapic,
 
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(mask);
 	entry.trigger = triggering;
 	entry.polarity = polarity;
 	entry.mask = 1;					 /* Disabled (masked) */
-
-	irq = gsi_irq_sharing(irq);
-	/*
-	 * IRQs < 16 are already in the irq_2_pin[] map
-	 */
-	if (irq >= 16)
-		add_pin_to_irq(irq, ioapic, pin);
-
-	entry.vector = assign_irq_vector(irq);
+	entry.vector = vector & 0xff;
 
 	apic_printk(APIC_VERBOSE,KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
 		"IRQ %d Mode:%i Active:%i)\n", ioapic, 
diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index dd8d79a..2de92cc 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -99,7 +99,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	exit_idle();
 	irq_enter();
 
-	irq = vector_irq[vector];
+	irq = __get_cpu_var(vector_irq)[vector];
 	if (likely(irq < NR_IRQS))
 		generic_handle_irq(irq, regs);
 
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
index 9f6a0bf..2c79d03 100644
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -73,8 +73,9 @@ #define FIRST_SYSTEM_VECTOR	0xef   /* du
 
 
 #ifndef __ASSEMBLY__
-extern u8 irq_vector[NR_IRQ_VECTORS];
-extern int vector_irq[NR_VECTORS];
+extern unsigned int irq_vector[NR_IRQ_VECTORS];
+typedef int vector_irq_t[NR_VECTORS];
+DECLARE_PER_CPU(vector_irq_t, vector_irq);
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 /*
diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
index 0c8d570..d3b5790 100644
--- a/include/asm-x86_64/irq.h
+++ b/include/asm-x86_64/irq.h
@@ -31,8 +31,8 @@ #define NR_VECTORS 256
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#define NR_IRQS 224
-#define NR_IRQ_VECTORS (32 * NR_CPUS)
+#define NR_IRQS (NR_VECTORS + (32 *NR_CPUS))
+#define NR_IRQ_VECTORS NR_IRQS
 
 static __inline__ int irq_canonicalize(int irq)
 {
-- 
1.4.0.gc07e

