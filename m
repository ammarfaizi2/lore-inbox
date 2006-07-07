Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWGGLDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWGGLDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGGLDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:03:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4805 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932130AbWGGLDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:03:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Olson <olson@unixfolk.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/25] x86_64 irq: Remove the msi assumption that irq == vector
References: <Pine.LNX.4.61.0606222331090.1213@osa.unixfolk.com>
Date: Fri, 07 Jul 2006 05:02:42 -0600
In-Reply-To: <Pine.LNX.4.61.0606222331090.1213@osa.unixfolk.com> (Dave Olson's
	message of "Thu, 22 Jun 2006 23:34:20 -0700 (PDT)")
Message-ID: <m1ac7lwuct.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@unixfolk.com> writes:

> Eric and I had a brief side discussion, which we thought should
> be shared with the other folks interested in this issue.

Dave.  Can you play with the patch below?
It is against 2.6.17-mm6.

It is just about a working version of a generic ht irq patch.

No callbacks yet but that should be terribly hard to add.

If you could adapt the ipath driver and give me some feedback
that would be great.

I have another more standard test case that I will be looking at
in just a bit.

Eric


diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 70b5962..6ab4a33 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2532,6 +2532,96 @@ struct msi_ops arch_msi_ops = {
 
 #endif /* CONFIG_PCI_MSI */
 
+/*
+ * Hypertransport interrupt support
+ */
+#ifdef CONFIG_HT_IRQ
+
+#ifdef CONFIG_SMP
+
+static void target_ht_irq(unsigned int irq, unsigned int dest)
+{
+	u32 low, high;
+	low  = read_ht_irq_low(irq);
+	high = read_ht_irq_high(irq);
+
+	low  &= ~(HT_IRQ_LOW_DEST_ID_MASK);
+	high &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
+
+	low  |= HT_IRQ_LOW_DEST_ID(dest);
+	high |= HT_IRQ_HIGH_DEST_ID(dest);
+
+	write_ht_irq_low(irq, low);
+	write_ht_irq_high(irq, high);
+}
+
+static void set_ht_irq_affinity(unsigned int irq, cpumask_t mask)
+{
+	unsigned int dest;
+	cpumask_t tmp;
+	int vector;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
+
+	cpus_and(mask, tmp, CPU_MASK_ALL);
+
+	dest = cpu_mask_to_apicid(mask);
+
+	target_ht_irq(irq, dest);
+	set_native_irq_info(irq, mask);
+}
+#endif
+
+static struct hw_interrupt_type ht_irq_chip = {
+	.name		= "PCI-HT",
+	.mask		= mask_ht_irq,
+	.unmask		= unmask_ht_irq,
+	.ack		= ack_apic_edge,
+#ifdef CONFIG_SMP
+	.set_affinity	= set_ht_irq_affinity,
+#endif	
+	.retrigger	= ioapic_retrigger_irq,
+};
+
+int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)
+{
+	int vector;
+
+	vector = assign_irq_vector(irq, TARGET_CPUS);
+	if (vector >= 0) {
+		u32 low, high;
+		unsigned dest;
+		cpumask_t tmp;
+
+		cpus_clear(tmp);
+		cpu_set(vector >> 8, tmp);
+		dest = cpu_mask_to_apicid(tmp);
+
+		high = 	HT_IRQ_HIGH_DEST_ID(dest);
+
+		low =	HT_IRQ_LOW_BASE | 
+			HT_IRQ_LOW_DEST_ID(dest) | 
+			HT_IRQ_LOW_VECTOR(vector) |
+			((INT_DEST_MODE == 0) ?
+				HT_IRQ_LOW_DM_PHYSICAL :
+				HT_IRQ_LOW_DM_PHYSICAL) |
+			HT_IRQ_LOW_RQEOI_EDGE |
+			((INT_DELIVERY_MODE != dest_LowestPrio) ?
+				HT_IRQ_LOW_MT_FIXED :
+				HT_IRQ_LOW_MT_ARBITRATED) |
+			HT_IRQ_LOW_IRQ_MASKED;
+
+		write_ht_irq_low(irq, low);
+		write_ht_irq_high(irq, high);
+
+		set_irq_chip_and_handler(irq, &ht_irq_chip, handle_edge_irq);
+	}
+	return vector;
+}
+#endif /* CONFIG_HT_IRQ */
+
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7e46935..9f3e167 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -249,9 +249,9 @@ static void __init mpic_scan_ht_pic(stru
 	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
 	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
 		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
-		if (id == PCI_CAP_ID_HT_IRQCONF) {
+		if (id == PCI_CAP_ID_HT) {
 			id = readb(devbase + pos + 3);
-			if (id == 0x80)
+			if (id == HT_CAPTYPE_IRQ)
 				break;
 		}
 	}
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 8d030b4..84eeaf8 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -42,6 +42,7 @@ #include <asm/acpi.h>
 #include <asm/dma.h>
 #include <asm/nmi.h>
 #include <asm/msidef.h>
+#include <asm/hypertransport.h>
 
 static int assign_irq_vector(int irq, cpumask_t mask);
 
@@ -2093,6 +2094,98 @@ struct msi_ops arch_msi_ops = {
 
 #endif
 
+/*
+ * Hypertransport interrupt support
+ */
+#ifdef CONFIG_HT_IRQ
+
+#ifdef CONFIG_SMP
+
+static void target_ht_irq(unsigned int irq, unsigned int dest, u8 vector)
+{
+	u32 low, high;
+	low  = read_ht_irq_low(irq);
+	high = read_ht_irq_high(irq);
+
+	low  &= ~(HT_IRQ_LOW_VECTOR_MASK | HT_IRQ_LOW_DEST_ID_MASK);
+	high &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
+
+	low  |= HT_IRQ_LOW_VECTOR(vector) | HT_IRQ_LOW_DEST_ID(dest);
+	high |= HT_IRQ_HIGH_DEST_ID(dest);
+
+	write_ht_irq_low(irq, low);
+	write_ht_irq_high(irq, high);
+}
+
+static void set_ht_irq_affinity(unsigned int irq, cpumask_t mask)
+{
+	unsigned int dest;
+	cpumask_t tmp;
+	int vector;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
+
+	cpus_and(mask, tmp, CPU_MASK_ALL);
+
+	vector = assign_irq_vector(irq, mask);
+	if (vector < 0)
+		return;
+
+	cpus_clear(tmp);
+	cpu_set(vector >> 8, tmp);
+	dest = cpu_mask_to_apicid(tmp);
+
+	target_ht_irq(irq, dest, vector & 0xff);
+	set_native_irq_info(irq, mask);
+}
+#endif
+
+static struct hw_interrupt_type ht_irq_chip = {
+	.name		= "PCI-HT",
+	.mask		= mask_ht_irq,
+	.unmask		= unmask_ht_irq,
+	.ack		= ack_apic_edge,
+#ifdef CONFIG_SMP
+	.set_affinity	= set_ht_irq_affinity,
+#endif	
+	.retrigger	= ioapic_retrigger_irq,
+};
+
+int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)
+{
+	int vector;
+
+	vector = assign_irq_vector(irq, TARGET_CPUS);
+	if (vector >= 0) {
+		u32 low, high;
+		unsigned dest;
+		cpumask_t tmp;
+
+		cpus_clear(tmp);
+		cpu_set(vector >> 8, tmp);
+		dest = cpu_mask_to_apicid(tmp);
+
+		high = 	HT_IRQ_HIGH_DEST_ID(dest);
+
+		low =	HT_IRQ_LOW_BASE | 
+			HT_IRQ_LOW_DEST_ID(dest) | 
+			HT_IRQ_LOW_VECTOR(vector) |
+			((INT_DEST_MODE == 0) ?
+				HT_IRQ_LOW_DM_PHYSICAL :
+				HT_IRQ_LOW_DM_PHYSICAL) |
+			HT_IRQ_LOW_RQEOI_EDGE |
+			((INT_DELIVERY_MODE != dest_LowestPrio) ?
+				HT_IRQ_LOW_MT_FIXED :
+				HT_IRQ_LOW_MT_ARBITRATED);
+
+		set_irq_chip_and_handler(irq, &ht_irq_chip, handle_edge_irq);
+	}
+	return vector;
+}
+#endif /* CONFIG_HT_IRQ */
+
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4d762fc..bcae7f3 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -27,3 +27,12 @@ config PCI_DEBUG
 
 	  When in doubt, say N.
 
+config HT_IRQ
+	bool "Interrupts on hypertransport devices"
+	depends on PCI
+	depends on X86_LOCAL_APIC && X86_IO_APIC
+	help
+	   This allows native hypertransport devices to use interrupts.
+
+	   If unsure say Y.
+           
\ No newline at end of file
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 983d0f8..2752c57 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
+obj-$(CONFIG_HT_IRQ) += htirq.o
 
 msiobj-y := msi.o
 msiobj-$(CONFIG_IA64) += msi-apic.o
diff --git a/drivers/pci/htirq.c b/drivers/pci/htirq.c
new file mode 100644
index 0000000..56fbab6
--- /dev/null
+++ b/drivers/pci/htirq.c
@@ -0,0 +1,188 @@
+/*
+ * File:	htirq.c
+ * Purpose:	Hypertransport Interrupt Capability
+ *
+ * Copyright (C) 2006 Linux Networx
+ * Copyright (C) Eric Biederman <ebiederman@lnxi.com>
+ */
+
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/gfp.h>
+
+/* Global ht irq lock.  
+ *
+ * This is needed to serialize access to the data port in hypertransport
+ * irq capability.
+ *
+ * With multiple simultaneous hypertransport irq devices it might pay
+ * to make this more fine grained.  But start with simple, stupid, and correct.
+ */
+static DEFINE_SPINLOCK(ht_irq_lock);
+
+struct ht_irq_cfg {
+	struct pci_dev *dev;
+	unsigned pos;
+	unsigned idx;
+};
+
+void write_ht_irq_low(unsigned int irq, u32 data)
+{
+	struct ht_irq_cfg *cfg = get_irq_data(irq);
+	unsigned long flags;
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+}
+
+void write_ht_irq_high(unsigned int irq, u32 data)
+{
+	struct ht_irq_cfg *cfg = get_irq_data(irq);
+	unsigned long flags;
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
+	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+}
+
+u32 read_ht_irq_low(unsigned int irq)
+{
+	struct ht_irq_cfg *cfg = get_irq_data(irq);
+	unsigned long flags;
+	u32 data;
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+	return data;
+}
+
+
+u32 read_ht_irq_high(unsigned int irq)
+{
+	struct ht_irq_cfg *cfg = get_irq_data(irq);
+	unsigned long flags;
+	u32 data;
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
+	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+	return data;
+}
+
+void mask_ht_irq(unsigned int irq)
+{
+	struct ht_irq_cfg *cfg;
+	unsigned long flags;
+	u32 data;
+
+	cfg = get_irq_data(irq);
+
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
+	data |= 1;
+	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+}
+
+void unmask_ht_irq(unsigned int irq)
+{
+	struct ht_irq_cfg *cfg;
+	unsigned long flags;
+	u32 data;
+
+	cfg = get_irq_data(irq);
+
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
+	data &= ~1;
+	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+}
+
+/**
+ * ht_create_irq - create an irq and attach it to a device.
+ * @dev: The hypertransport device to find the irq capability on.
+ * @idx: Which of the possible irqs to attach to.
+ *
+ * ht_create_irq is needs to be called for all hypertransport devices
+ * that generate irqs.
+ * 
+ * The irq number of the new irq or a negative error value is returned.
+ */
+int ht_create_irq(struct pci_dev *dev, int idx)
+{
+	struct ht_irq_cfg *cfg;
+	unsigned long flags;
+	u32 data;
+	int max_irq;
+	int pos;
+	int irq;
+	pos = pci_find_capability(dev, PCI_CAP_ID_HT);
+	while (pos) {
+		u8 subtype;
+		pci_read_config_byte(dev, pos + 3, &subtype);
+		if (subtype != HT_CAPTYPE_IRQ)
+			pci_find_next_capability(dev, pos, PCI_CAP_ID_HT);
+	}
+	if (!pos)
+		return -EINVAL;
+
+	/* Verify the idx I want to use is in range */
+	spin_lock_irqsave(&ht_irq_lock, flags);
+	pci_write_config_byte(dev, pos + 2, 1);
+	pci_read_config_dword(dev, pos + 4, &data);
+	spin_unlock_irqrestore(&ht_irq_lock, flags);
+
+	max_irq = (data >> 16) & 0xff;
+	if ( idx > max_irq) 
+		return -EINVAL;
+
+	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	cfg->dev = dev;
+	cfg->pos = pos;
+	cfg->idx = 0x10 + (idx * 2);
+		
+	irq = create_irq();
+	if (irq < 0) {
+		kfree(cfg);
+		return -EBUSY;
+	}
+	set_irq_data(irq, cfg);
+
+	if (arch_setup_ht_irq(irq, dev) < 0) {
+		ht_destroy_irq(irq);
+		return -EBUSY;
+	}
+
+	return irq;
+}
+
+/**
+ * ht_destroy_irq - destroy an irq created with ht_create_irq
+ *
+ * This reverses ht_create_irq removing the specified irq from
+ * existence.  The irq should be free before this happens.
+ */
+void ht_destroy_irq(unsigned int irq)
+{
+	struct ht_irq_cfg *cfg;
+
+	cfg = get_irq_data(irq);
+	set_irq_chip(irq, NULL);
+	set_irq_data(irq, NULL);
+	destroy_irq(irq);
+
+	kfree(cfg);
+}
+
+EXPORT_SYMBOL(ht_create_irq);
+EXPORT_SYMBOL(ht_destroy_irq);
diff --git a/include/asm-i386/hypertransport.h b/include/asm-i386/hypertransport.h
new file mode 100644
index 0000000..c16c6ff
--- /dev/null
+++ b/include/asm-i386/hypertransport.h
@@ -0,0 +1,42 @@
+#ifndef ASM_HYPERTRANSPORT_H
+#define ASM_HYPERTRANSPORT_H
+
+/*
+ * Constants for x86 Hypertransport Interrupts.
+ */
+
+#define HT_IRQ_LOW_BASE			0xf8000000
+
+#define HT_IRQ_LOW_VECTOR_SHIFT		16
+#define  HT_IRQ_LOW_VECTOR_MASK		0x00ff0000
+#define  HT_IRQ_LOW_VECTOR(v)		(((v) << HT_IRQ_LOW_VECTOR_SHIFT) & HT_IRQ_LOW_VECTOR_MASK)
+
+#define HT_IRQ_LOW_DEST_ID_SHIFT	8
+#define  HT_IRQ_LOW_DEST_ID_MASK	0x0000ff00
+#define  HT_IRQ_LOW_DEST_ID(v)		(((v) << HT_IRQ_LOW_DEST_ID_SHIFT) & HT_IRQ_LOW_DEST_ID_MASK)
+
+#define HT_IRQ_LOW_DM_PHYSICAL		0x0000000
+#define HT_IRQ_LOW_DM_LOGICAL		0x0000040
+
+#define HT_IRQ_LOW_RQEOI_EDGE		0x0000000
+#define HT_IRQ_LOW_RQEOI_LEVEL		0x0000020
+
+
+#define HT_IRQ_LOW_MT_FIXED		0x0000000
+#define HT_IRQ_LOW_MT_ARBITRATED	0x0000004
+#define HT_IRQ_LOW_MT_SMI		0x0000008
+#define HT_IRQ_LOW_MT_NMI		0x000000c
+#define HT_IRQ_LOW_MT_INIT		0x0000010
+#define HT_IRQ_LOW_MT_STARTUP		0x0000014
+#define HT_IRQ_LOW_MT_EXTINT		0x0000018
+#define HT_IRQ_LOW_MT_LINT1		0x000008c
+#define HT_IRQ_LOW_MT_LINT0		0x0000098
+
+#define HT_IRQ_LOW_IRQ_MASKED		0x0000001
+
+
+#define HT_IRQ_HIGH_DEST_ID_SHIFT	0
+#define  HT_IRQ_HIGH_DEST_ID_MASK	0x00ffffff
+#define  HT_IRQ_HIGH_DEST_ID(v)		((((v) >> 8) << HT_IRQ_HIGH_DEST_ID_SHIFT) & HT_IRQ_HIGH_DEST_ID_MASK)
+
+#endif /* ASM_HYPERTRANSPORT_H */
diff --git a/include/asm-x86_64/hypertransport.h b/include/asm-x86_64/hypertransport.h
new file mode 100644
index 0000000..c16c6ff
--- /dev/null
+++ b/include/asm-x86_64/hypertransport.h
@@ -0,0 +1,42 @@
+#ifndef ASM_HYPERTRANSPORT_H
+#define ASM_HYPERTRANSPORT_H
+
+/*
+ * Constants for x86 Hypertransport Interrupts.
+ */
+
+#define HT_IRQ_LOW_BASE			0xf8000000
+
+#define HT_IRQ_LOW_VECTOR_SHIFT		16
+#define  HT_IRQ_LOW_VECTOR_MASK		0x00ff0000
+#define  HT_IRQ_LOW_VECTOR(v)		(((v) << HT_IRQ_LOW_VECTOR_SHIFT) & HT_IRQ_LOW_VECTOR_MASK)
+
+#define HT_IRQ_LOW_DEST_ID_SHIFT	8
+#define  HT_IRQ_LOW_DEST_ID_MASK	0x0000ff00
+#define  HT_IRQ_LOW_DEST_ID(v)		(((v) << HT_IRQ_LOW_DEST_ID_SHIFT) & HT_IRQ_LOW_DEST_ID_MASK)
+
+#define HT_IRQ_LOW_DM_PHYSICAL		0x0000000
+#define HT_IRQ_LOW_DM_LOGICAL		0x0000040
+
+#define HT_IRQ_LOW_RQEOI_EDGE		0x0000000
+#define HT_IRQ_LOW_RQEOI_LEVEL		0x0000020
+
+
+#define HT_IRQ_LOW_MT_FIXED		0x0000000
+#define HT_IRQ_LOW_MT_ARBITRATED	0x0000004
+#define HT_IRQ_LOW_MT_SMI		0x0000008
+#define HT_IRQ_LOW_MT_NMI		0x000000c
+#define HT_IRQ_LOW_MT_INIT		0x0000010
+#define HT_IRQ_LOW_MT_STARTUP		0x0000014
+#define HT_IRQ_LOW_MT_EXTINT		0x0000018
+#define HT_IRQ_LOW_MT_LINT1		0x000008c
+#define HT_IRQ_LOW_MT_LINT0		0x0000098
+
+#define HT_IRQ_LOW_IRQ_MASKED		0x0000001
+
+
+#define HT_IRQ_HIGH_DEST_ID_SHIFT	0
+#define  HT_IRQ_HIGH_DEST_ID_MASK	0x00ffffff
+#define  HT_IRQ_HIGH_DEST_ID(v)		((((v) >> 8) << HT_IRQ_HIGH_DEST_ID_SHIFT) & HT_IRQ_HIGH_DEST_ID_MASK)
+
+#endif /* ASM_HYPERTRANSPORT_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aeebe36..69c55a9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -676,6 +676,23 @@ extern int msi_register(struct msi_ops *
 
 #endif
 
+#ifdef CONFIG_HT_IRQ
+/* Helper functions.. */
+void write_ht_irq_low(unsigned int irq, u32 data);
+void write_ht_irq_high(unsigned int irq, u32 data);
+u32  read_ht_irq_low(unsigned int irq);
+u32  read_ht_irq_high(unsigned int irq);
+void mask_ht_irq(unsigned int irq);
+void unmask_ht_irq(unsigned int irq);
+
+/* The functions a driver should call */
+int  ht_create_irq(struct pci_dev *dev, int idx);
+void ht_destroy_irq(unsigned int irq);
+
+/* The arch hook for getting things started */
+int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev);
+#endif /* CONFIG_HT_IRQ */
+
 extern void pci_block_user_cfg_access(struct pci_dev *dev);
 extern void pci_unblock_user_cfg_access(struct pci_dev *dev);
 
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index 6bce4a2..7a5dcc2 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -12,6 +12,11 @@
  *	PCI Local Bus Specification
  *	PCI to PCI Bridge Specification
  *	PCI System Design Guide
+ *
+ * 	For hypertransport information, please consult the following manuals 
+ * 	from http://www.hypertranposrt.org
+ *
+ *	The Hypertransport I/O Link Specification
  */
 
 #ifndef LINUX_PCI_REGS_H
@@ -196,7 +201,7 @@ #define  PCI_CAP_ID_SLOTID	0x04	/* Slot 
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
-#define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
+#define  PCI_CAP_ID_HT		0x08	/* HyperTransport Capability */
 #define  PCI_CAP_ID_VNDR	0x09	/* Vendor specific capability */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
@@ -447,4 +452,20 @@ #define  PCI_PWR_DATA_RAIL(x)	(((x) >> 1
 #define PCI_PWR_CAP		12	/* Capability */
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 
+/* Hypertransport sub capability types */
+#define HT_CAPTYPE_SLAVE	0x00	/* Slave/Primary link configuration */
+#define HT_CAPTYPE_HOST		0x20	/* Host/Secondary link configuration */
+#define HT_CAPTYPE_IRQ		0x80	/* IRQ Configuration */
+#define HT_CAPTYPE_REMAPPING_40	0xA0	/* 40 bit address remapping */
+#define HT_CAPTYPE_REMAPPING_64 0xA2	/* 64 bit address remapping */
+#define HT_CAPTYPE_UNITID_CLUMP	0x90	/* Unit ID clumping */
+#define HT_CAPTYPE_EXTCONF	0x98	/* Extended Configuration Space Access */
+#define HT_CAPTYPE_MSI_MAPPING	0xA8	/* MSI Mapping Capability */
+#define HT_CAPTYPE_DIRECT_ROUTE	0xB0	/* Direct routing configuration */
+#define HT_CAPTYPE_VCSET	0xB8	/* Virtual Channel configuration */
+#define HT_CAPTYPE_ERROR_RETRY	0xC0	/* Retry on error configuration */
+#define HT_CAPTYPE_GEN3		0xD0	/* Generation 3 hypertransport configuration */
+#define HT_CAPTYPE_PM		0xE0	/* Hypertransport powermanagement configuration */
+
+
 #endif /* LINUX_PCI_REGS_H */



