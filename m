Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVD1FRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVD1FRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVD1FRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:17:18 -0400
Received: from fmr24.intel.com ([143.183.121.16]:2768 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262002AbVD1FQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:16:26 -0400
Date: Wed, 27 Apr 2005 22:15:38 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, tony.luck@intel.com, zwane@arm.linux.org.uk,
       gregkh@suse.de, hch@infradead.org
Subject: Deferred handling of writes to /proc/irq/xx/smp_affinity
Message-ID: <20050427221538.A30702@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and all

It is safe to re-program rte entries in ioapic only when an intr is pending. 
Existing code does this incorrectly by reprogamming rte entries immediatly
when a value is written to /proc/irq/xx/smp_affinity. IRQ_BALANCE code in 
kernel does this right, but /proc/irq needs to be handled the same way so that 
user mode irq_balancer wont lock up systems or loose interrupts in the race.

This is already fixed in ia64, introduced for i386 and x86_64.

since this touches 3 arch's managing in -mm for trial would be best to make
sure nothing is broken, before considering for main line.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


---
                                                                                
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

When handling writes to /proc/irq, current code is re-programming rte
entries directly. This is not recommended and could potentially cause 
chipset's to lockup, or cause missing interrupts.

CONFIG_IRQ_BALANCE does this correctly, where it re-programs only when the 
interrupt is pending. The same needs to be done for /proc/irq handling as well.
Otherwise user space irq balancers are really not doing the right thing.

- Changed pending_irq_balance_cpumask to pending_irq_migrate_cpumask for 
  lack of a generic name.
- added move_irq out of IRQ_BALANCE, and added this same to X86_64
- Added new proc handler for write, so we can do deferred write at irq
  handling time.
- Display of /proc/irq/XX/smp_affinity used to display CPU_MASKALL, instead
  it now shows only active cpu masks, or exactly what was set.
---

 linux-2.6.12-rc2-araj/arch/i386/kernel/io_apic.c   |   94 ++++++++++--
 linux-2.6.12-rc2-araj/arch/ia64/kernel/irq.c       |    1 
 linux-2.6.12-rc2-araj/arch/x86_64/kernel/io_apic.c |  152 +++++++++++++++------
 linux-2.6.12-rc2-araj/drivers/pci/msi.c            |   17 --
 linux-2.6.12-rc2-araj/drivers/pci/msi.h            |    5 
 linux-2.6.12-rc2-araj/include/asm-i386/irq.h       |    7 
 linux-2.6.12-rc2-araj/include/asm-x86_64/irq.h     |    8 +
 linux-2.6.12-rc2-araj/include/linux/irq.h          |    9 +
 linux-2.6.12-rc2-araj/kernel/irq/manage.c          |    9 +
 9 files changed, 229 insertions(+), 73 deletions(-)

diff -puN arch/i386/kernel/io_apic.c~fix_irq_affinity arch/i386/kernel/io_apic.c
--- linux-2.6.12-rc2/arch/i386/kernel/io_apic.c~fix_irq_affinity	2005-04-14 12:02:14.000000000 -0700
+++ linux-2.6.12-rc2-araj/arch/i386/kernel/io_apic.c	2005-04-26 17:37:01.000000000 -0700
@@ -31,8 +31,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
-
 #include <linux/sysdev.h>
+#include <linux/irq.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
@@ -78,9 +78,13 @@ static struct irq_pin_list {
 
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
 #ifdef CONFIG_PCI_MSI
+#define MOVE_IRQ(x)
+#define SET_IRQ_INFO(x,y)
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
+#define MOVE_IRQ(x)				move_irq(x)
+#define SET_IRQ_INFO(x,y)		set_irq_info(x,y)
 #define vector_to_irq(vector)	(vector)
 #endif
 
@@ -227,7 +231,14 @@ static void set_ioapic_affinity_irq(unsi
 	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
 	unsigned int apicid_value;
+	cpumask_t tmp;
 	
+	cpus_and(tmp, cpumask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
+
+	cpus_and(cpumask, tmp, CPU_MASK_ALL);
+
 	apicid_value = cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value = apicid_value << 24;
@@ -241,9 +252,62 @@ static void set_ioapic_affinity_irq(unsi
 			break;
 		entry = irq_2_pin + entry->next;
 	}
+	SET_IRQ_INFO(irq, cpumask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+#ifdef CONFIG_SMP
+cpumask_t __cacheline_aligned pending_irq_migrate_cpumask[NR_IRQS];
+
+/*
+ * Arch specific routine for deferred write to io_apic rte to reprogram
+ * intr destination.
+ */
+void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
+{
+	irq_desc_t	*desc = irq_descp(irq);
+	unsigned long flags;
+
+	/*
+	 * Save these away for later use. Re-progam when the
+	 * interrupt is pending
+	 */
+	spin_lock_irqsave(&desc->lock, flags);
+	pending_irq_migrate_cpumask[irq] = mask_val;
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+void move_irq(int irq)
+{
+	cpumask_t tmp;
+	irq_desc_t *desc = irq_descp(irq);
+
+	if (likely(cpus_empty(pending_irq_migrate_cpumask[irq])))
+		return;
+
+	if (unlikely(!desc->handler->set_affinity))
+		return;
+
+	/* note - we hold the desc->lock */
+	cpus_and(tmp, pending_irq_migrate_cpumask[irq], cpu_online_map);
+	/*
+	 * If there was a valid mask to work with, please
+	 * do the disable, re-program, enable sequence.
+	 * This is *not* particularly important for level triggered
+	 * but in a edge trigger case, we might be setting rte
+	 * when an active trigger is comming in. This could
+	 * cause some ioapics to mal-function.
+	 * Being paranoid i guess!
+	 */
+	if (unlikely(!cpus_empty(tmp))) {
+		desc->handler->disable(irq);
+		desc->handler->set_affinity(irq,tmp);
+		desc->handler->enable(irq);
+	}
+	cpus_clear(pending_irq_migrate_cpumask[irq]);
+}
+#endif
+
 #if defined(CONFIG_IRQBALANCE)
 # include <asm/processor.h>	/* kernel_thread() */
 # include <linux/kernel_stat.h>	/* kstat */
@@ -258,7 +322,6 @@ static void set_ioapic_affinity_irq(unsi
 #  define Dprintk(x...) 
 # endif
 
-cpumask_t __cacheline_aligned pending_irq_balance_cpumask[NR_IRQS];
 
 #define IRQBALANCE_CHECK_ARCH -999
 static int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
@@ -331,7 +394,7 @@ static inline void balance_irq(int cpu, 
 		unsigned long flags;
 
 		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_balance_cpumask[irq] = cpumask_of_cpu(new_cpu);
+		pending_irq_migrate_cpumask[irq] = cpumask_of_cpu(new_cpu);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -534,7 +597,7 @@ tryanotherirq:
 				selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_balance_cpumask[selected_irq] =
+		pending_irq_migrate_cpumask[selected_irq] =
 					cpumask_of_cpu(min_loaded);
 		spin_unlock_irqrestore(&desc->lock, flags);
 		/* Since we made a change, come back sooner to 
@@ -567,7 +630,7 @@ static int balanced_irq(void *unused)
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++) {
-		pending_irq_balance_cpumask[i] = cpumask_of_cpu(0);
+		pending_irq_migrate_cpumask[i] = cpumask_of_cpu(0);
 	}
 
 	for ( ; ; ) {
@@ -646,19 +709,7 @@ int __init irqbalance_disable(char *str)
 
 __setup("noirqbalance", irqbalance_disable);
 
-static inline void move_irq(int irq)
-{
-	/* note - we hold the desc->lock */
-	if (unlikely(!cpus_empty(pending_irq_balance_cpumask[irq]))) {
-		set_ioapic_affinity_irq(irq, pending_irq_balance_cpumask[irq]);
-		cpus_clear(pending_irq_balance_cpumask[irq]);
-	}
-}
-
 late_initcall(balanced_irq_init);
-
-#else /* !CONFIG_IRQBALANCE */
-static inline void move_irq(int irq) { }
 #endif /* CONFIG_IRQBALANCE */
 
 #ifndef CONFIG_SMP
@@ -1247,6 +1298,7 @@ static void __init setup_IO_APIC_irqs(vo
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
 		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
+		set_irq_info(irq, TARGET_CPUS);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
 	}
@@ -1861,7 +1913,7 @@ static unsigned int startup_edge_ioapic_
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
-	move_irq(irq);
+	MOVE_IRQ(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					== (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1894,7 +1946,7 @@ static void end_level_ioapic_irq (unsign
 	unsigned long v;
 	int i;
 
-	move_irq(irq);
+	MOVE_IRQ(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
@@ -1941,6 +1993,7 @@ static void ack_edge_ioapic_vector(unsig
 {
 	int irq = vector_to_irq(vector);
 
+	move_irq(vector);
 	ack_edge_ioapic_irq(irq);
 }
 
@@ -1955,6 +2008,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
+	move_irq(vector);
 	end_level_ioapic_irq(irq);
 }
 
@@ -1977,6 +2031,7 @@ static void set_ioapic_affinity_vector (
 {
 	int irq = vector_to_irq(vector);
 
+	set_irq_info(vector, cpu_mask);
 	set_ioapic_affinity_irq(irq, cpu_mask);
 }
 #endif
@@ -2566,6 +2621,7 @@ int io_apic_set_pci_routing (int ioapic,
 	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
 	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
+	set_irq_info(entry.vector, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
diff -puN include/asm-i386/irq.h~fix_irq_affinity include/asm-i386/irq.h
--- linux-2.6.12-rc2/include/asm-i386/irq.h~fix_irq_affinity	2005-04-14 13:30:19.000000000 -0700
+++ linux-2.6.12-rc2-araj/include/asm-i386/irq.h	2005-04-14 14:24:52.000000000 -0700
@@ -42,4 +42,11 @@ extern int irqbalance_disable(char *str)
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+#ifdef CONFIG_SMP
+extern void move_irq(int irq);
+extern cpumask_t pending_irq_migrate_cpumask[NR_IRQS];
+#else
+#define move_irq(x)
+#endif
+
 #endif /* _ASM_IRQ_H */
diff -puN drivers/pci/msi.c~fix_irq_affinity drivers/pci/msi.c
--- linux-2.6.12-rc2/drivers/pci/msi.c~fix_irq_affinity	2005-04-14 13:53:52.000000000 -0700
+++ linux-2.6.12-rc2-araj/drivers/pci/msi.c	2005-04-26 15:49:38.000000000 -0700
@@ -91,6 +91,7 @@ static void set_msi_affinity(unsigned in
 {
 	struct msi_desc *entry;
 	struct msg_address address;
+	unsigned int irq = vector;
 
 	entry = (struct msi_desc *)msi_desc[vector];
 	if (!entry || !entry->dev)
@@ -112,6 +113,7 @@ static void set_msi_affinity(unsigned in
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
 		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
 			address.lo_address.value);
+		set_irq_info(irq, cpu_mask);
 		break;
 	}
 	case PCI_CAP_ID_MSIX:
@@ -125,22 +127,13 @@ static void set_msi_affinity(unsigned in
 			MSI_TARGET_CPU_SHIFT);
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
 		writel(address.lo_address.value, entry->mask_base + offset);
+		set_irq_info(irq, cpu_mask);
 		break;
 	}
 	default:
 		break;
 	}
 }
-
-#ifdef CONFIG_IRQBALANCE
-static inline void move_msi(int vector)
-{
-	if (!cpus_empty(pending_irq_balance_cpumask[vector])) {
-		set_msi_affinity(vector, pending_irq_balance_cpumask[vector]);
-		cpus_clear(pending_irq_balance_cpumask[vector]);
-	}
-}
-#endif /* CONFIG_IRQBALANCE */
 #endif /* CONFIG_SMP */
 
 static void mask_MSI_irq(unsigned int vector)
@@ -182,7 +175,7 @@ static void disable_msi_irq_wo_maskbit(u
 static void ack_msi_irq_wo_maskbit(unsigned int vector) {}
 static void end_msi_irq_wo_maskbit(unsigned int vector)
 {
-	move_msi(vector);
+	move_irq(vector);
 	ack_APIC_irq();
 }
 
@@ -211,7 +204,7 @@ static unsigned int startup_msi_irq_w_ma
 
 static void end_msi_irq_w_maskbit(unsigned int vector)
 {
-	move_msi(vector);
+	move_irq(vector);
 	unmask_MSI_irq(vector);
 	ack_APIC_irq();
 }
diff -puN drivers/pci/msi.h~fix_irq_affinity drivers/pci/msi.h
--- linux-2.6.12-rc2/drivers/pci/msi.h~fix_irq_affinity	2005-04-14 13:56:23.000000000 -0700
+++ linux-2.6.12-rc2-araj/drivers/pci/msi.h	2005-04-14 13:57:59.000000000 -0700
@@ -19,7 +19,6 @@
 #define NR_HP_RESERVED_VECTORS 	20
 
 extern int vector_irq[NR_VECTORS];
-extern cpumask_t pending_irq_balance_cpumask[NR_IRQS];
 extern void (*interrupt[NR_IRQS])(void);
 extern int pci_vector_resources(int last, int nr_released);
 
@@ -29,10 +28,6 @@ extern int pci_vector_resources(int last
 #define set_msi_irq_affinity	NULL
 #endif
 
-#ifndef CONFIG_IRQBALANCE
-static inline void move_msi(int vector) {}
-#endif
-
 /*
  * MSI-X Address Register
  */
diff -puN include/linux/irq.h~fix_irq_affinity include/linux/irq.h
--- linux-2.6.12-rc2/include/linux/irq.h~fix_irq_affinity	2005-04-14 14:39:29.000000000 -0700
+++ linux-2.6.12-rc2-araj/include/linux/irq.h	2005-04-15 10:14:49.000000000 -0700
@@ -71,6 +71,14 @@ typedef struct irq_desc {
 
 extern irq_desc_t irq_desc [NR_IRQS];
 
+/* Return a pointer to the irq descriptor for IRQ.  */
+static inline irq_desc_t *
+irq_descp (int irq)
+{
+	return irq_desc + irq;
+}
+
+
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 extern int setup_irq(unsigned int irq, struct irqaction * new);
@@ -88,6 +96,7 @@ extern void report_bad_irq(unsigned int 
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 extern void init_irq_proc(void);
+extern void set_irq_info(unsigned int irq, cpumask_t cpumask);
 #endif
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
diff -puN kernel/irq/manage.c~fix_irq_affinity kernel/irq/manage.c
--- linux-2.6.12-rc2/kernel/irq/manage.c~fix_irq_affinity	2005-04-14 16:27:53.000000000 -0700
+++ linux-2.6.12-rc2-araj/kernel/irq/manage.c	2005-04-27 21:52:32.000000000 -0700
@@ -17,6 +17,11 @@
 
 cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 
+void set_irq_info(unsigned int irq, cpumask_t mask)
+{
+	irq_affinity[irq] = mask;
+}
+
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *
@@ -36,6 +41,10 @@ void synchronize_irq(unsigned int irq)
 
 EXPORT_SYMBOL(synchronize_irq);
 
+#else
+void set_irq_info(unsigned int irq, cpumask_t mask)
+{
+}
 #endif
 
 /**
diff -puN arch/ia64/kernel/irq.c~fix_irq_affinity arch/ia64/kernel/irq.c
--- linux-2.6.12-rc2/arch/ia64/kernel/irq.c~fix_irq_affinity	2005-04-15 10:15:25.000000000 -0700
+++ linux-2.6.12-rc2-araj/arch/ia64/kernel/irq.c	2005-04-15 10:15:44.000000000 -0700
@@ -116,6 +116,7 @@ void set_irq_affinity_info (unsigned int
 
 	if (irq < NR_IRQS) {
 		irq_affinity[irq] = mask;
+		set_irq_info(irq, mask);
 		irq_redir[irq] = (char) (redir & 0xff);
 	}
 }
diff -puN arch/x86_64/kernel/io_apic.c~fix_irq_affinity arch/x86_64/kernel/io_apic.c
--- linux-2.6.12-rc2/arch/x86_64/kernel/io_apic.c~fix_irq_affinity	2005-04-15 13:36:08.000000000 -0700
+++ linux-2.6.12-rc2-araj/arch/x86_64/kernel/io_apic.c	2005-04-26 17:31:23.000000000 -0700
@@ -69,10 +69,118 @@ static struct irq_pin_list {
 
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
 #ifdef CONFIG_PCI_MSI
+#define MOVE_IRQ(x)
+#define SET_IRQ_INFO(x,y)
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
 #define vector_to_irq(vector)	(vector)
+#define MOVE_IRQ(x)			move_irq(x)
+#define SET_IRQ_INFO(x,y)	set_irq_info(x,y)
+#endif
+
+#define __DO_ACTION(R, ACTION, FINAL)					\
+									\
+{									\
+	int pin;							\
+	struct irq_pin_list *entry = irq_2_pin + irq;			\
+									\
+	for (;;) {							\
+		unsigned int reg;					\
+		pin = entry->pin;					\
+		if (pin == -1)						\
+			break;						\
+		reg = io_apic_read(entry->apic, 0x10 + R + pin*2);	\
+		reg ACTION;						\
+		io_apic_modify(entry->apic, reg);			\
+		if (!entry->next)					\
+			break;						\
+		entry = irq_2_pin + entry->next;			\
+	}								\
+	FINAL;								\
+}
+
+#ifdef CONFIG_SMP
+cpumask_t __cacheline_aligned pending_irq_migrate_cpumask[NR_IRQS];
+
+void move_irq(int irq)
+{
+	cpumask_t tmp;
+	irq_desc_t *desc = irq_descp(irq);
+
+	if (likely(cpus_empty(pending_irq_migrate_cpumask[irq])))
+		return;
+
+	if (unlikely(!desc->handler->set_affinity))
+		return;
+
+	/* note - we hold the desc->lock */
+	cpus_and(tmp, pending_irq_migrate_cpumask[irq], cpu_online_map);
+
+	/*
+	 * If there was a valid mask to work with, please
+	 * do the disable, re-program, enable sequence.
+	 * This is *not* particularly important for level triggered
+	 * but in a edge trigger case, we might be setting rte
+	 * when an active trigger is comming in. This could
+	 * cause some ioapics to mal-function.
+	 * Being paranoid i guess!
+	 */
+	if (unlikely(!cpus_empty(tmp))) {
+		desc->handler->disable(irq);
+		desc->handler->set_affinity(irq, tmp);
+		desc->handler->enable(irq);
+	}
+	cpus_clear(pending_irq_migrate_cpumask[irq]);
+}
+
+/*
+ * Arch specific routine for deferred write to io_apic rte to reprogram
+ * intr destination.
+ */
+void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
+{
+	irq_desc_t	*desc = irq_descp(irq);
+	unsigned long flags;
+
+	/*
+	 * Save these away for later use. Re-progam when the
+	 * interrupt is pending
+	 */
+	spin_lock_irqsave(&desc->lock, flags);
+	pending_irq_migrate_cpumask[irq] = mask_val;
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
+{
+	unsigned long flags;
+	unsigned int dest;
+	cpumask_t tmp;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
+
+	cpus_and(mask, tmp, CPU_MASK_ALL);
+
+	dest = cpu_mask_to_apicid(mask);
+
+	/*
+	 * Only the high 8 bits are valid.
+	 */
+	dest = SET_APIC_LOGICAL_ID(dest);
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__DO_ACTION(1, = dest, )
+	SET_IRQ_INFO(irq, mask);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+#else
+static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
+{
+	return;
+}
 #endif
 
 /*
@@ -98,26 +206,6 @@ static void add_pin_to_irq(unsigned int 
 	entry->pin = pin;
 }
 
-#define __DO_ACTION(R, ACTION, FINAL)					\
-									\
-{									\
-	int pin;							\
-	struct irq_pin_list *entry = irq_2_pin + irq;			\
-									\
-	for (;;) {							\
-		unsigned int reg;					\
-		pin = entry->pin;					\
-		if (pin == -1)						\
-			break;						\
-		reg = io_apic_read(entry->apic, 0x10 + R + pin*2);	\
-		reg ACTION;						\
-		io_apic_modify(entry->apic, reg);			\
-		if (!entry->next)					\
-			break;						\
-		entry = irq_2_pin + entry->next;			\
-	}								\
-	FINAL;								\
-}
 
 #define DO_ACTION(name,R,ACTION, FINAL)					\
 									\
@@ -764,6 +852,7 @@ static void __init setup_IO_APIC_irqs(vo
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
 		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
+		set_irq_info(irq, TARGET_CPUS);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
 	}
@@ -1312,6 +1401,7 @@ static unsigned int startup_edge_ioapic_
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
+	MOVE_IRQ(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					== (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1341,26 +1431,10 @@ static unsigned int startup_level_ioapic
 
 static void end_level_ioapic_irq (unsigned int irq)
 {
+	MOVE_IRQ(irq);
 	ack_APIC_irq();
 }
 
-static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
-{
-	unsigned long flags;
-	unsigned int dest;
-
-	dest = cpu_mask_to_apicid(mask);
-
-	/*
-	 * Only the high 8 bits are valid.
-	 */
-	dest = SET_APIC_LOGICAL_ID(dest);
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = dest, )
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-}
-
 #ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
@@ -1373,6 +1447,7 @@ static void ack_edge_ioapic_vector(unsig
 {
 	int irq = vector_to_irq(vector);
 
+	move_irq(vector);
 	ack_edge_ioapic_irq(irq);
 }
 
@@ -1387,6 +1462,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
+	move_irq(vector);
 	end_level_ioapic_irq(irq);
 }
 
@@ -1409,6 +1485,7 @@ static void set_ioapic_affinity_vector (
 {
 	int irq = vector_to_irq(vector);
 
+	set_irq_info(vector, cpu_mask);
 	set_ioapic_affinity_irq(irq, cpu_mask);
 }
 #endif
@@ -1979,6 +2056,7 @@ int io_apic_set_pci_routing (int ioapic,
 	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
 	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
+	set_irq_info(entry.vector, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
diff -puN include/asm-x86_64/irq.h~fix_irq_affinity include/asm-x86_64/irq.h
--- linux-2.6.12-rc2/include/asm-x86_64/irq.h~fix_irq_affinity	2005-04-15 14:03:46.000000000 -0700
+++ linux-2.6.12-rc2-araj/include/asm-x86_64/irq.h	2005-04-18 14:08:50.000000000 -0700
@@ -52,4 +52,12 @@ struct irqaction;
 struct pt_regs;
 int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
+#ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+extern void move_irq(int irq);
+extern cpumask_t pending_irq_migrate_cpumask[NR_IRQS];
+#else
+#define move_irq(x)
+#endif
+
 #endif /* _ASM_IRQ_H */
_
