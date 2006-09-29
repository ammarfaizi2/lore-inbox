Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422788AbWI2UNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWI2UNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWI2UNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:13:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46213 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422788AbWI2UNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:13:33 -0400
Date: Fri, 29 Sep 2006 22:05:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] genirq: clean up irq-flow-type naming
Message-ID: <20060929200521.GA30660@elte.hu>
References: <20060929124042.6f03b31a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929124042.6f03b31a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: genirq: clean up irq-flow-type naming
From: Ingo Molnar <mingo@elte.hu>

introduce desc->name and eliminate the handle_irq_name() hack.
Add set_irq_chip_and_handler_name() to set the flow type and
name at once.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 arch/i386/kernel/i8259.c          |    7 +++--
 arch/i386/kernel/io_apic.c        |   17 ++++++++------
 arch/i386/kernel/irq.c            |    2 -
 arch/x86_64/kernel/i8259.c        |    7 +++--
 arch/x86_64/kernel/io_apic.c      |   15 ++++++------
 arch/x86_64/kernel/irq.c          |    2 -
 include/asm-parisc/irq-handlers.h |    7 -----
 include/linux/irq.h               |   26 +++++++++++----------
 kernel/irq/chip.c                 |   46 ++++++++++----------------------------
 9 files changed, 55 insertions(+), 74 deletions(-)

Index: linux-hrt-mm.q/arch/i386/kernel/i8259.c
===================================================================
--- linux-hrt-mm.q.orig/arch/i386/kernel/i8259.c
+++ linux-hrt-mm.q/arch/i386/kernel/i8259.c
@@ -113,7 +113,8 @@ void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
-	set_irq_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	set_irq_chip_and_handler_name(irq, &i8259A_chip, handle_level_irq,
+				      "XT");
 	enable_irq(irq);
 }
 
@@ -369,8 +370,8 @@ void __init init_ISA_irqs (void)
 			/*
 			 * 16 old-style INTA-cycle interrupts:
 			 */
-			set_irq_chip_and_handler(i, &i8259A_chip,
-						 handle_level_irq);
+			set_irq_chip_and_handler_name(i, &i8259A_chip,
+						      handle_level_irq, "XT");
 		} else {
 			/*
 			 * 'high' PCI IRQs filled in on demand
Index: linux-hrt-mm.q/arch/i386/kernel/io_apic.c
===================================================================
--- linux-hrt-mm.q.orig/arch/i386/kernel/io_apic.c
+++ linux-hrt-mm.q/arch/i386/kernel/io_apic.c
@@ -1225,11 +1225,11 @@ static void ioapic_register_intr(int irq
 {
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
-		set_irq_chip_and_handler(irq, &ioapic_chip,
-					 handle_fasteoi_irq);
+		set_irq_chip_and_handler_name(irq, &ioapic_chip,
+					 handle_fasteoi_irq, "fasteoi");
 	else
-		set_irq_chip_and_handler(irq, &ioapic_chip,
-					 handle_edge_irq);
+		set_irq_chip_and_handler_name(irq, &ioapic_chip,
+					 handle_edge_irq, "edge");
 	set_intr_gate(vector, interrupt[irq]);
 }
 
@@ -2235,7 +2235,8 @@ static inline void check_timer(void)
 	printk(KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
 
 	disable_8259A_irq(0);
-	set_irq_chip_and_handler(0, &lapic_chip, handle_fasteoi_irq);
+	set_irq_chip_and_handler_name(0, &lapic_chip, handle_fasteoi_irq,
+				      "fasteio");
 	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
@@ -2541,7 +2542,8 @@ int arch_setup_msi_irq(unsigned int irq,
 
 	write_msi_msg(irq, &msg);
 
-	set_irq_chip_and_handler(irq, &msi_chip, handle_edge_irq);
+	set_irq_chip_and_handler_name(irq, &msi_chip, handle_edge_irq,
+				      "edge");
 
 	return 0;
 }
@@ -2636,7 +2638,8 @@ int arch_setup_ht_irq(unsigned int irq, 
 		write_ht_irq_low(irq, low);
 		write_ht_irq_high(irq, high);
 
-		set_irq_chip_and_handler(irq, &ht_irq_chip, handle_edge_irq);
+		set_irq_chip_and_handler_name(irq, &ht_irq_chip,
+					      handle_edge_irq, "edge");
 	}
 	return vector;
 }
Index: linux-hrt-mm.q/arch/i386/kernel/irq.c
===================================================================
--- linux-hrt-mm.q.orig/arch/i386/kernel/irq.c
+++ linux-hrt-mm.q/arch/i386/kernel/irq.c
@@ -256,7 +256,7 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %8s", irq_desc[i].chip->name);
-		seq_printf(p, "-%s", handle_irq_name(irq_desc[i].handle_irq));
+		seq_printf(p, "-%-8s", irq_desc[i].name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
Index: linux-hrt-mm.q/arch/x86_64/kernel/i8259.c
===================================================================
--- linux-hrt-mm.q.orig/arch/x86_64/kernel/i8259.c
+++ linux-hrt-mm.q/arch/x86_64/kernel/i8259.c
@@ -178,7 +178,8 @@ void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
-	set_irq_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	set_irq_chip_and_handler_name(irq, &i8259A_chip, handle_level_irq,
+				      "XT");
 	enable_irq(irq);
 }
 
@@ -431,8 +432,8 @@ void __init init_ISA_irqs (void)
 			/*
 			 * 16 old-style INTA-cycle interrupts:
 			 */
-			set_irq_chip_and_handler(i, &i8259A_chip,
-						 handle_level_irq);
+			set_irq_chip_and_handler_name(i, &i8259A_chip,
+						      handle_level_irq, "XT");
 		} else {
 			/*
 			 * 'high' PCI IRQs filled in on demand
Index: linux-hrt-mm.q/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-hrt-mm.q.orig/arch/x86_64/kernel/io_apic.c
+++ linux-hrt-mm.q/arch/x86_64/kernel/io_apic.c
@@ -649,11 +649,11 @@ static void ioapic_register_intr(int irq
 {
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
-		set_irq_chip_and_handler(irq, &ioapic_chip,
-					 handle_fasteoi_irq);
+		set_irq_chip_and_handler_name(irq, &ioapic_chip,
+					      handle_fasteoi_irq, "fasteoi");
 	else
-		set_irq_chip_and_handler(irq, &ioapic_chip,
-					 handle_edge_irq);
+		set_irq_chip_and_handler_name(irq, &ioapic_chip,
+					      handle_edge_irq, "edge");
 }
 
 static void __init setup_IO_APIC_irqs(void)
@@ -761,7 +761,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	set_irq_chip_and_handler(0, &ioapic_chip, handle_edge_irq);
+	set_irq_chip_and_handler_name(0, &ioapic_chip, handle_edge_irq, "edge");
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -1797,7 +1797,7 @@ int arch_setup_msi_irq(unsigned int irq,
 
 	write_msi_msg(irq, &msg);
 
-	set_irq_chip_and_handler(irq, &msi_chip, handle_edge_irq);
+	set_irq_chip_and_handler_name(irq, &msi_chip, handle_edge_irq, "edge");
 
 	return 0;
 }
@@ -1898,7 +1898,8 @@ int arch_setup_ht_irq(unsigned int irq, 
 		write_ht_irq_low(irq, low);
 		write_ht_irq_high(irq, high);
 
-		set_irq_chip_and_handler(irq, &ht_irq_chip, handle_edge_irq);
+		set_irq_chip_and_handler_name(irq, &ht_irq_chip,
+					      handle_edge_irq, "edge");
 	}
 	return vector;
 }
Index: linux-hrt-mm.q/arch/x86_64/kernel/irq.c
===================================================================
--- linux-hrt-mm.q.orig/arch/x86_64/kernel/irq.c
+++ linux-hrt-mm.q/arch/x86_64/kernel/irq.c
@@ -75,7 +75,7 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %8s", irq_desc[i].chip->name);
-		seq_printf(p, "-%s", handle_irq_name(irq_desc[i].handle_irq));
+		seq_printf(p, "-%-8s", irq_desc[i].name);
 
 		seq_printf(p, "  %s", action->name);
 		for (action=action->next; action; action = action->next)
Index: linux-hrt-mm.q/include/asm-parisc/irq-handlers.h
===================================================================
--- linux-hrt-mm.q.orig/include/asm-parisc/irq-handlers.h
+++ linux-hrt-mm.q/include/asm-parisc/irq-handlers.h
@@ -6,10 +6,3 @@ HANDLE_SPECIFIC_IRQ(_ipi, cpu_ack_irq, c
 #ifdef CONFIG_IOSAPIC
 HANDLE_LEVEL_IRQ(_iosapic, cpu_ack_irq, iosapic_end_irq)
 #endif
-
-static inline char *arch_handle_irq_name(void fastcall (*handle)(unsigned int,
-							struct irq_desc *,
-							struct pt_regs *))
-{
-	return NULL;
-}
Index: linux-hrt-mm.q/include/linux/irq.h
===================================================================
--- linux-hrt-mm.q.orig/include/linux/irq.h
+++ linux-hrt-mm.q/include/linux/irq.h
@@ -135,6 +135,7 @@ struct irq_chip {
  * @pending_mask:	pending rebalanced interrupts
  * @dir:		/proc/irq/ procfs entry
  * @affinity_entry:	/proc/irq/smp_affinity procfs entry on SMP
+ * @name:		flow handler name for /proc/interrupts output
  *
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
@@ -161,8 +162,9 @@ struct irq_desc {
 	cpumask_t		pending_mask;
 #endif
 #ifdef CONFIG_PROC_FS
-	struct proc_dir_entry *dir;
+	struct proc_dir_entry	*dir;
 #endif
+	const char		*name;
 } ____cacheline_aligned;
 
 extern struct irq_desc irq_desc[NR_IRQS];
@@ -279,14 +281,6 @@ extern void fastcall
 handle_bad_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
 
 /*
- * Get a descriptive string for the highlevel handler, for
- * /proc/interrupts output:
- */
-extern const char *
-handle_irq_name(void fastcall (*handle)(unsigned int, struct irq_desc *,
-					struct pt_regs *));
-
-/*
  * Monolithic do_IRQ implementation.
  * (is an explicit fastcall, because i386 4KSTACKS calls it from assembly)
  */
@@ -340,10 +334,18 @@ set_irq_chip_and_handler(unsigned int ir
 						 struct irq_desc *,
 						 struct pt_regs *));
 extern void
+set_irq_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+			      void fastcall (*handle)(unsigned int,
+						      struct irq_desc *,
+						      struct pt_regs *),
+			      const char *name);
+
+extern void
 __set_irq_handler(unsigned int irq,
 		  void fastcall (*handle)(unsigned int, struct irq_desc *,
 					  struct pt_regs *),
-		  int is_chained);
+		  int is_chained,
+		  const char *name);
 
 /*
  * Set a highlevel flow handler for a given IRQ:
@@ -353,7 +355,7 @@ set_irq_handler(unsigned int irq,
 		void fastcall (*handle)(unsigned int, struct irq_desc *,
 					struct pt_regs *))
 {
-	__set_irq_handler(irq, handle, 0);
+	__set_irq_handler(irq, handle, 0, NULL);
 }
 
 /*
@@ -366,7 +368,7 @@ set_irq_chained_handler(unsigned int irq
 			void fastcall (*handle)(unsigned int, struct irq_desc *,
 						struct pt_regs *))
 {
-	__set_irq_handler(irq, handle, 1);
+	__set_irq_handler(irq, handle, 1, NULL);
 }
 
 /* Handle dynamic irq creation and destruction */
Index: linux-hrt-mm.q/kernel/irq/chip.c
===================================================================
--- linux-hrt-mm.q.orig/kernel/irq/chip.c
+++ linux-hrt-mm.q/kernel/irq/chip.c
@@ -549,14 +549,7 @@ out_unlock:
 HANDLE_PERCPU_IRQ(, do_ack_irq, eoi_irq)
 
 #ifdef ARCH_HAS_IRQ_HANDLERS
-#include <asm/irq-handlers.h>
-#else
-static inline char *arch_handle_irq_name(void fastcall (*handle)(unsigned int,
-							struct irq_desc *,
-							struct pt_regs *))
-{
-	return NULL;
-}
+# include <asm/irq-handlers.h>
 #endif
 
 
@@ -564,7 +557,8 @@ void
 __set_irq_handler(unsigned int irq,
 		  void fastcall (*handle)(unsigned int, irq_desc_t *,
 					  struct pt_regs *),
-		  int is_chained)
+		  int is_chained,
+		  const char *name)
 {
 	struct irq_desc *desc;
 	unsigned long flags;
@@ -605,6 +599,7 @@ __set_irq_handler(unsigned int irq,
 		desc->depth = 1;
 	}
 	desc->handle_irq = handle;
+	desc->name = name;
 
 	if (handle != handle_bad_irq && is_chained) {
 		desc->status &= ~IRQ_DISABLED;
@@ -622,31 +617,16 @@ set_irq_chip_and_handler(unsigned int ir
 						 struct pt_regs *))
 {
 	set_irq_chip(irq, chip);
-	__set_irq_handler(irq, handle, 0);
+	__set_irq_handler(irq, handle, 0, NULL);
 }
 
-/*
- * Get a descriptive string for the highlevel handler, for
- * /proc/interrupts output:
- */
-const char *
-handle_irq_name(void fastcall (*handle)(unsigned int, struct irq_desc *,
-					struct pt_regs *))
+void
+set_irq_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+			      void fastcall (*handle)(unsigned int,
+						      struct irq_desc *,
+						      struct pt_regs *),
+			      const char *name)
 {
-	if (handle == handle_level_irq)
-		return "level  ";
-	if (handle == handle_fasteoi_irq)
-		return "fasteoi";
-	if (handle == handle_edge_irq)
-		return "edge   ";
-	if (handle == handle_simple_irq)
-		return "simple ";
-#ifdef CONFIG_SMP
-	if (handle == handle_percpu_irq)
-		return "percpu ";
-#endif
-	if (handle == handle_bad_irq)
-		return "bad    ";
-
-	return arch_handle_irq_name(handle);
+	set_irq_chip(irq, chip);
+	__set_irq_handler(irq, handle, 0, name);
 }
