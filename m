Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWFTWcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFTWcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFTWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:31:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43485 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751336AbWFTW3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:24 -0400
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
Subject: [PATCH 21/25] x86_64 irq: Make the external irq handlers report their vector, not the irq number.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:34 -0600
Message-Id: <11508425254020-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425253581-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com> <11508425253581-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small pessimization but it paves the way for making this information
per cpu.  Which allows the the maximum number of IRQS to become NR_CPUS*224.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/i8259.c   |   62 +++++++++++++++++-------------------------
 arch/x86_64/kernel/io_apic.c |    4 +--
 arch/x86_64/kernel/irq.c     |    7 +++--
 include/asm-x86_64/hw_irq.h  |    1 +
 4 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index 4749954..c3e737a 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -44,19 +44,11 @@ #define BUILD_16_IRQS(x) \
 	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
 	BI(x,c) BI(x,d) BI(x,e) BI(x,f)
 
-#define BUILD_15_IRQS(x) \
-	BI(x,0) BI(x,1) BI(x,2) BI(x,3) \
-	BI(x,4) BI(x,5) BI(x,6) BI(x,7) \
-	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
-	BI(x,c) BI(x,d) BI(x,e)
-
 /*
  * ISA PIC or low IO-APIC triggered (INTA-cycle or APIC) interrupts:
  * (these are usually mapped to vectors 0x20-0x2f)
  */
-BUILD_16_IRQS(0x0)
 
-#ifdef CONFIG_X86_LOCAL_APIC
 /*
  * The IO-APIC gives us many more interrupt sources. Most of these 
  * are unused but an SMP system is supposed to have enough memory ...
@@ -67,19 +59,13 @@ #ifdef CONFIG_X86_LOCAL_APIC
  *
  * (these are usually mapped into the 0x30-0xff vector range)
  */
-		   BUILD_16_IRQS(0x1) BUILD_16_IRQS(0x2) BUILD_16_IRQS(0x3)
+				      BUILD_16_IRQS(0x2) BUILD_16_IRQS(0x3)
 BUILD_16_IRQS(0x4) BUILD_16_IRQS(0x5) BUILD_16_IRQS(0x6) BUILD_16_IRQS(0x7)
 BUILD_16_IRQS(0x8) BUILD_16_IRQS(0x9) BUILD_16_IRQS(0xa) BUILD_16_IRQS(0xb)
-BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
+BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd) BUILD_16_IRQS(0xe) BUILD_16_IRQS(0xf) 
 
-#ifdef CONFIG_PCI_MSI
-	BUILD_15_IRQS(0xe)
-#endif
-
-#endif
 
 #undef BUILD_16_IRQS
-#undef BUILD_15_IRQS
 #undef BI
 
 
@@ -92,31 +78,15 @@ #define IRQLIST_16(x) \
 	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
 	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
 
-#define IRQLIST_15(x) \
-	IRQ(x,0), IRQ(x,1), IRQ(x,2), IRQ(x,3), \
-	IRQ(x,4), IRQ(x,5), IRQ(x,6), IRQ(x,7), \
-	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
-	IRQ(x,c), IRQ(x,d), IRQ(x,e)
-
 void (*interrupt[NR_IRQS])(void) = {
-	IRQLIST_16(0x0),
-
-#ifdef CONFIG_X86_IO_APIC
-			 IRQLIST_16(0x1), IRQLIST_16(0x2), IRQLIST_16(0x3),
+					  IRQLIST_16(0x2), IRQLIST_16(0x3),
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
-	IRQLIST_16(0xc), IRQLIST_16(0xd)
-
-#ifdef CONFIG_PCI_MSI
-	, IRQLIST_15(0xe)
-#endif
-
-#endif
+	IRQLIST_16(0xc), IRQLIST_16(0xd), IRQLIST_16(0xe), IRQLIST_16(0xf)
 };
 
 #undef IRQ
 #undef IRQLIST_16
-#undef IRQLIST_14
 
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
@@ -424,6 +394,26 @@ device_initcall(i8259A_init_sysfs);
  */
 
 static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+int vector_irq[NR_VECTORS] __read_mostly = {
+	[0 ... FIRST_EXTERNAL_VECTOR - 1] = -1,
+	[FIRST_EXTERNAL_VECTOR + 0] = 0,
+	[FIRST_EXTERNAL_VECTOR + 1] = 1,
+	[FIRST_EXTERNAL_VECTOR + 2] = 2,
+	[FIRST_EXTERNAL_VECTOR + 3] = 3,
+	[FIRST_EXTERNAL_VECTOR + 4] = 4,
+	[FIRST_EXTERNAL_VECTOR + 5] = 5,
+	[FIRST_EXTERNAL_VECTOR + 6] = 6,
+	[FIRST_EXTERNAL_VECTOR + 7] = 7,
+	[FIRST_EXTERNAL_VECTOR + 8] = 8,
+	[FIRST_EXTERNAL_VECTOR + 9] = 9,
+	[FIRST_EXTERNAL_VECTOR + 10] = 10,
+	[FIRST_EXTERNAL_VECTOR + 11] = 11,
+	[FIRST_EXTERNAL_VECTOR + 12] = 12,
+	[FIRST_EXTERNAL_VECTOR + 13] = 13,
+	[FIRST_EXTERNAL_VECTOR + 14] = 14,
+	[FIRST_EXTERNAL_VECTOR + 15] = 15,
+	[FIRST_EXTERNAL_VECTOR + 16 ... NR_VECTORS - 1] = -1
+};
 
 void __init init_ISA_irqs (void)
 {
@@ -523,8 +513,6 @@ void __init init_IRQ(void)
 	 */
 	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
-		if (i >= NR_IRQS)
-			break;
 		if (vector != IA32_SYSCALL_VECTOR)
 			set_intr_gate(vector, interrupt[i]);
 	}
@@ -534,7 +522,7 @@ #ifdef CONFIG_SMP
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
+	vector_irq[FIRST_DEVICE_VECTOR] = 0;
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 1a63a0e..3ff5606 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -850,6 +850,7 @@ next:
 	}
 
 	vector = current_vector;
+	vector_irq[vector] = irq;
 	IO_APIC_VECTOR(irq) = vector;
 
 	return vector;
@@ -884,7 +885,6 @@ static void ioapic_register_intr(int irq
 	else
 		set_irq_chip_and_handler(irq, &ioapic_chip,
 					 handle_edge_irq);
-	set_intr_gate(vector, interrupt[irq]);
 }
 
 static void __init setup_IO_APIC_irqs(void)
@@ -1727,7 +1727,6 @@ static inline void check_timer(void)
 	 */
 	disable_8259A_irq(0);
 	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -1988,7 +1987,6 @@ int create_irq(void)
 	spin_unlock_irqrestore(&vector_lock, flags);
 
 	if (irq >= 0) {
-		set_intr_gate(vector, interrupt[irq]);
 		dynamic_irq_init(irq);
 	}
 	return irq;
diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index c2d27d3..dd8d79a 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -93,12 +93,15 @@ #endif
 asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
 {	
 	/* high bit used in ret_from_ code  */
-	unsigned irq = ~regs->orig_rax;
+	unsigned vector = ~regs->orig_rax;
+	unsigned irq;
 
 	exit_idle();
 	irq_enter();
 
-	generic_handle_irq(irq, regs);
+	irq = vector_irq[vector];
+	if (likely(irq < NR_IRQS))
+		generic_handle_irq(irq, regs);
 
 	irq_exit();
 
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
index 1a8dc18..9f6a0bf 100644
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -74,6 +74,7 @@ #define FIRST_SYSTEM_VECTOR	0xef   /* du
 
 #ifndef __ASSEMBLY__
 extern u8 irq_vector[NR_IRQ_VECTORS];
+extern int vector_irq[NR_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 /*
-- 
1.4.0.gc07e

