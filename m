Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUJWDFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUJWDFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJWDCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:02:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:16829 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269283AbUJWCoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:44:37 -0400
Subject: [PATCH] ppc64: Rewrite the openpic driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1098499363.6029.139.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 12:42:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch replaces the open_pic IRQ controller driver with a new
version rewritten from scratch, called "mpic" (this is the name of
IBM's open_pic implementation and also the only one actually used
on any platform).

It is smaller, hopefully more readable, supports the various variants
of the cell in a single driver (open_pic_u3.c is gone), and adds
optional support for the workaround of U3 mpic beeing used along with
IO-APICs on HyperTransport (the eval board will uses that, among
others).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc64/kernel/mpic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/mpic.h	2004-10-23 11:44:03.010689312 +1000
@@ -0,0 +1,267 @@
+#include <linux/irq.h>
+
+/*
+ * Global registers
+ */
+
+#define MPIC_GREG_BASE			0x01000
+
+#define MPIC_GREG_FEATURE_0		0x00000
+#define		MPIC_GREG_FEATURE_LAST_SRC_MASK		0x07ff0000
+#define		MPIC_GREG_FEATURE_LAST_SRC_SHIFT	16
+#define		MPIC_GREG_FEATURE_LAST_CPU_MASK		0x00001f00
+#define		MPIC_GREG_FEATURE_LAST_CPU_SHIFT	8
+#define		MPIC_GREG_FEATURE_VERSION_MASK		0xff
+#define MPIC_GREG_FEATURE_1		0x00010
+#define MPIC_GREG_GLOBAL_CONF_0		0x00020
+#define		MPIC_GREG_GCONF_RESET			0x80000000
+#define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
+#define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
+#define MPIC_GREG_GLOBAL_CONF_1		0x00030
+#define MPIC_GREG_VENDOR_0		0x00040
+#define MPIC_GREG_VENDOR_1		0x00050
+#define MPIC_GREG_VENDOR_2		0x00060
+#define MPIC_GREG_VENDOR_3		0x00070
+#define MPIC_GREG_VENDOR_ID		0x00080
+#define 	MPIC_GREG_VENDOR_ID_STEPPING_MASK	0x00ff0000
+#define 	MPIC_GREG_VENDOR_ID_STEPPING_SHIFT	16
+#define 	MPIC_GREG_VENDOR_ID_DEVICE_ID_MASK	0x0000ff00
+#define 	MPIC_GREG_VENDOR_ID_DEVICE_ID_SHIFT	8
+#define 	MPIC_GREG_VENDOR_ID_VENDOR_ID_MASK	0x000000ff
+#define MPIC_GREG_PROCESSOR_INIT	0x00090
+#define MPIC_GREG_IPI_VECTOR_PRI_0	0x000a0
+#define MPIC_GREG_IPI_VECTOR_PRI_1	0x000b0
+#define MPIC_GREG_IPI_VECTOR_PRI_2	0x000c0
+#define MPIC_GREG_IPI_VECTOR_PRI_3	0x000d0
+#define MPIC_GREG_SPURIOUS		0x000e0
+#define MPIC_GREG_TIMER_FREQ		0x000f0
+
+/*
+ *
+ * Timer registers
+ */
+#define MPIC_TIMER_BASE			0x01100
+#define MPIC_TIMER_STRIDE		0x40
+
+#define MPIC_TIMER_CURRENT_CNT		0x00000
+#define MPIC_TIMER_BASE_CNT		0x00010
+#define MPIC_TIMER_VECTOR_PRI		0x00020
+#define MPIC_TIMER_DESTINATION		0x00030
+
+/*
+ * Per-Processor registers
+ */
+
+#define MPIC_CPU_THISBASE		0x00000
+#define MPIC_CPU_BASE			0x20000
+#define MPIC_CPU_STRIDE			0x01000
+
+#define MPIC_CPU_IPI_DISPATCH_0		0x00040
+#define MPIC_CPU_IPI_DISPATCH_1		0x00050
+#define MPIC_CPU_IPI_DISPATCH_2		0x00060
+#define MPIC_CPU_IPI_DISPATCH_3		0x00070
+#define MPIC_CPU_CURRENT_TASK_PRI	0x00080
+#define 	MPIC_CPU_TASKPRI_MASK			0x0000000f
+#define MPIC_CPU_WHOAMI			0x00090
+#define 	MPIC_CPU_WHOAMI_MASK			0x0000001f
+#define MPIC_CPU_INTACK			0x000a0
+#define MPIC_CPU_EOI			0x000b0
+
+/*
+ * Per-source registers
+ */
+
+#define MPIC_IRQ_BASE			0x10000
+#define MPIC_IRQ_STRIDE			0x00020
+#define MPIC_IRQ_VECTOR_PRI		0x00000
+#define 	MPIC_VECPRI_MASK			0x80000000
+#define 	MPIC_VECPRI_ACTIVITY			0x40000000	/* Read Only */
+#define 	MPIC_VECPRI_PRIORITY_MASK		0x000f0000
+#define 	MPIC_VECPRI_PRIORITY_SHIFT		16
+#define 	MPIC_VECPRI_VECTOR_MASK			0x000007ff
+#define 	MPIC_VECPRI_POLARITY_POSITIVE		0x00800000
+#define 	MPIC_VECPRI_POLARITY_NEGATIVE		0x00000000
+#define 	MPIC_VECPRI_POLARITY_MASK		0x00800000
+#define 	MPIC_VECPRI_SENSE_LEVEL			0x00400000
+#define 	MPIC_VECPRI_SENSE_EDGE			0x00000000
+#define 	MPIC_VECPRI_SENSE_MASK			0x00400000
+#define MPIC_IRQ_DESTINATION		0x00010
+
+#define MPIC_MAX_IRQ_SOURCES	2048
+#define MPIC_MAX_CPUS		32
+#define MPIC_MAX_ISU		32
+
+/*
+ * Special vector numbers (internal use only)
+ */
+#define MPIC_VEC_SPURRIOUS	255
+#define MPIC_VEC_IPI_3		254
+#define MPIC_VEC_IPI_2		253
+#define MPIC_VEC_IPI_1		252
+#define MPIC_VEC_IPI_0		251
+
+/* unused */
+#define MPIC_VEC_TIMER_3	250
+#define MPIC_VEC_TIMER_2	249
+#define MPIC_VEC_TIMER_1	248
+#define MPIC_VEC_TIMER_0	247
+
+/* Type definition of the cascade handler */
+typedef int (*mpic_cascade_t)(struct pt_regs *regs, void *data);
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+/* Fixup table entry */
+struct mpic_irq_fixup
+{
+	u8 __iomem	*base;
+	unsigned int   irq;
+};
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+
+/* The instance data of a given MPIC */
+struct mpic
+{
+	/* The "linux" controller struct */
+	hw_irq_controller	hc_irq;
+#ifdef CONFIG_SMP
+	hw_irq_controller	hc_ipi;
+#endif
+	const char		*name;
+	/* Flags */
+	unsigned int		flags;
+	/* How many irq sources in a given ISU */
+	unsigned int		isu_size;
+	unsigned int		isu_shift;
+	unsigned int		isu_mask;
+	/* Offset of irq vector numbers */
+	unsigned int		irq_offset;	
+	unsigned int		irq_count;
+	/* Offset of ipi vector numbers */
+	unsigned int		ipi_offset;
+	/* Number of sources */
+	unsigned int		num_sources;
+	/* Number of CPUs */
+	unsigned int		num_cpus;
+	/* cascade handler */
+	mpic_cascade_t		cascade;
+	void			*cascade_data;
+	unsigned int		cascade_vec;
+	/* senses array */
+	unsigned char		*senses;
+	unsigned int		senses_count;
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+	/* The fixup table */
+	struct mpic_irq_fixup	*fixups;
+	spinlock_t		fixup_lock;
+#endif
+
+	/* The various ioremap'ed bases */
+	volatile u32 __iomem	*gregs;
+	volatile u32 __iomem	*tmregs;
+	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
+	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+
+	/* link */
+	struct mpic		*next;
+};
+
+/* This is the primary controller, only that one has IPIs and
+ * has afinity control. A non-primary MPIC always uses CPU0
+ * registers only
+ */
+#define MPIC_PRIMARY			0x00000001
+/* Set this for a big-endian MPIC */
+#define MPIC_BIG_ENDIAN			0x00000002
+/* Broken U3 MPIC */
+#define MPIC_BROKEN_U3			0x00000004
+/* Broken IPI registers (autodetected) */
+#define MPIC_BROKEN_IPI			0x00000008
+/* MPIC wants a reset */
+#define MPIC_WANTS_RESET		0x00000010
+
+/* Allocate the controller structure and setup the linux irq descs
+ * for the range if interrupts passed in. No HW initialization is
+ * actually performed.
+ * 
+ * @phys_addr:	physial base address of the MPIC
+ * @flags:	flags, see constants above
+ * @isu_size:	number of interrupts in an ISU. Use 0 to use a
+ *              standard ISU-less setup (aka powermac)
+ * @irq_offset: first irq number to assign to this mpic
+ * @irq_count:  number of irqs to use with this mpic IRQ sources. Pass 0
+ *	        to match the number of sources
+ * @ipi_offset: first irq number to assign to this mpic IPI sources,
+ *		used only on primary mpic
+ * @senses:	array of sense values
+ * @senses_num: number of entries in the array
+ *
+ * Note about the sense array. If none is passed, all interrupts are
+ * setup to be level negative unless MPIC_BROKEN_U3 is set in which
+ * case they are edge positive (and the array is ignored anyway).
+ * The values in the array start at the first source of the MPIC,
+ * that is senses[0] correspond to linux irq "irq_offset".
+ */
+extern struct mpic *mpic_alloc(unsigned long phys_addr,
+			       unsigned int flags,
+			       unsigned int isu_size,
+			       unsigned int irq_offset,
+			       unsigned int irq_count,
+			       unsigned int ipi_offset,
+			       unsigned char *senses,
+			       unsigned int senses_num,
+			       const char *name);
+
+/* Assign ISUs, to call before mpic_init()
+ *
+ * @mpic:	controller structure as returned by mpic_alloc()
+ * @isu_num:	ISU number
+ * @phys_addr:	physical address of the ISU
+ */
+extern void mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
+			    unsigned long phys_addr);
+
+/* Initialize the controller. After this has been called, none of the above
+ * should be called again for this mpic
+ */
+extern void mpic_init(struct mpic *mpic);
+
+/* Setup a cascade. Currently, only one cascade is supported this
+ * way, though you can always do a normal request_irq() and add
+ * other cascades this way. You should call this _after_ having
+ * added all the ISUs
+ *
+ * @irq_no:	"linux" irq number of the cascade (that is offset'ed vector)
+ * @handler:	cascade handler function
+ */
+extern void mpic_setup_cascade(unsigned int irq_no, mpic_cascade_t hanlder,
+			       void *data);
+
+/*
+ * All of the following functions must only be used after the
+ * ISUs have been assigned and the controller fully initialized
+ * with mpic_init()
+ */
+
+
+/* Change/Read the priority of an interrupt. Default is 8 for irqs and
+ * 10 for IPIs. You can call this on both IPIs and IRQ numbers, but the
+ * IPI number is then the offset'ed (linux irq number mapped to the IPI)
+ */
+extern void mpic_irq_set_priority(unsigned int irq, unsigned int pri);
+extern unsigned int mpic_irq_get_priority(unsigned int irq);
+
+/* Setup a non-boot CPU */
+extern void mpic_setup_this_cpu(void);
+
+/* Request IPIs on primary mpic */
+extern void mpic_request_ipis(void);
+
+/* Send an IPI (non offseted number 0..3) */
+extern void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask);
+
+/* Fetch interrupt from a given mpic */
+extern int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs);
+/* This one gets to the primary mpic */
+extern int mpic_get_irq(struct pt_regs *regs);
Index: linux-work/arch/ppc64/kernel/mpic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/mpic.c	2004-10-23 11:44:03.014688704 +1000
@@ -0,0 +1,859 @@
+/*
+ *  arch/ppc64/kernel/mpic.c
+ *
+ *  Driver for interrupt controllers following the OpenPIC standard, the
+ *  common implementation beeing IBM's MPIC. This driver also can deal
+ *  with various broken implementations of this HW.
+ *
+ *  Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+
+#include <asm/ptrace.h>
+#include <asm/signal.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/machdep.h>
+
+#include "mpic.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+static struct mpic *mpics;
+static struct mpic *mpic_primary;
+static spinlock_t mpic_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*
+ * Register accessor functions
+ */
+
+
+static inline u32 _mpic_read(unsigned int be, volatile u32 __iomem *base,
+			    unsigned int reg)
+{
+	if (be)
+		return in_be32(base + (reg >> 2));
+	else
+		return in_le32(base + (reg >> 2));
+}
+
+static inline void _mpic_write(unsigned int be, volatile u32 __iomem *base,
+			      unsigned int reg, u32 value)
+{
+	if (be)
+		out_be32(base + (reg >> 2), value);
+	else
+		out_le32(base + (reg >> 2), value);
+}
+
+static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
+{
+	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
+	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+
+	if (mpic->flags & MPIC_BROKEN_IPI)
+		be = !be;
+	return _mpic_read(be, mpic->gregs, offset);
+}
+
+static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
+{
+	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+
+	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);
+}
+
+static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
+{
+	unsigned int cpu = 0;
+
+	if (mpic->flags & MPIC_PRIMARY)
+		cpu = hard_smp_processor_id();
+
+	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->cpuregs[cpu], reg);
+}
+
+static inline void _mpic_cpu_write(struct mpic *mpic, unsigned int reg, u32 value)
+{
+	unsigned int cpu = 0;
+
+	if (mpic->flags & MPIC_PRIMARY)
+		cpu = hard_smp_processor_id();
+
+	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->cpuregs[cpu], reg, value);
+}
+
+static inline u32 _mpic_irq_read(struct mpic *mpic, unsigned int src_no, unsigned int reg)
+{
+	unsigned int	isu = src_no >> mpic->isu_shift;
+	unsigned int	idx = src_no & mpic->isu_mask;
+
+	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
+			  reg + (idx * MPIC_IRQ_STRIDE));
+}
+
+static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
+				   unsigned int reg, u32 value)
+{
+	unsigned int	isu = src_no >> mpic->isu_shift;
+	unsigned int	idx = src_no & mpic->isu_mask;
+
+	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
+		    reg + (idx * MPIC_IRQ_STRIDE), value);
+}
+
+#define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
+#define mpic_write(b,r,v)	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN,(b),(r),(v))
+#define mpic_ipi_read(i)	_mpic_ipi_read(mpic,(i))
+#define mpic_ipi_write(i,v)	_mpic_ipi_write(mpic,(i),(v))
+#define mpic_cpu_read(i)	_mpic_cpu_read(mpic,(i))
+#define mpic_cpu_write(i,v)	_mpic_cpu_write(mpic,(i),(v))
+#define mpic_irq_read(s,r)	_mpic_irq_read(mpic,(s),(r))
+#define mpic_irq_write(s,r,v)	_mpic_irq_write(mpic,(s),(r),(v))
+
+
+/*
+ * Low level utility functions
+ */
+
+
+
+/* Check if we have one of those nice broken MPICs with a flipped endian on
+ * reads from IPI registers
+ */
+static void __init mpic_test_broken_ipi(struct mpic *mpic)
+{
+	u32 r;
+
+	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0, MPIC_VECPRI_MASK);
+	r = mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+
+	if (r == le32_to_cpu(MPIC_VECPRI_MASK)) {
+		printk(KERN_INFO "mpic: Detected reversed IPI registers\n");
+		mpic->flags |= MPIC_BROKEN_IPI;
+	}
+}
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+
+/* Test if an interrupt is sourced from HyperTransport (used on broken U3s)
+ * to force the edge setting on the MPIC and do the ack workaround.
+ */
+static inline int mpic_is_ht_interrupt(struct mpic *mpic, unsigned int source_no)
+{
+	if (source_no >= 128 || !mpic->fixups)
+		return 0;
+	return mpic->fixups[source_no].base != NULL;
+}
+
+static inline void mpic_apic_end_irq(struct mpic *mpic, unsigned int source_no)
+{
+	struct mpic_irq_fixup *fixup = &mpic->fixups[source_no];
+	u32 tmp;
+
+	spin_lock(&mpic->fixup_lock);
+	writeb(0x11 + 2 * fixup->irq, fixup->base);
+	tmp = readl(fixup->base + 2);
+	writel(tmp | 0x80000000ul, fixup->base + 2);
+	/* config writes shouldn't be posted but let's be safe ... */
+	(void)readl(fixup->base + 2);
+	spin_unlock(&mpic->fixup_lock);
+}
+
+
+static void __init mpic_amd8111_read_irq(struct mpic *mpic, u8 __iomem *devbase)
+{
+	int i, irq;
+	u32 tmp;
+
+	printk(KERN_INFO "mpic:    - Workarounds on AMD 8111 @ %p\n", devbase);
+
+	for (i=0; i < 24; i++) {
+		writeb(0x10 + 2*i, devbase + 0xf2);
+		tmp = readl(devbase + 0xf4);
+		if ((tmp & 0x1) || !(tmp & 0x20))
+			continue;
+		irq = (tmp >> 16) & 0xff;
+		mpic->fixups[irq].irq = i;
+		mpic->fixups[irq].base = devbase + 0xf2;
+	}
+}
+ 
+static void __init mpic_amd8131_read_irq(struct mpic *mpic, u8 __iomem *devbase)
+{
+	int i, irq;
+	u32 tmp;
+
+	printk(KERN_INFO "mpic:    - Workarounds on AMD 8131 @ %p\n", devbase);
+
+	for (i=0; i < 4; i++) {
+		writeb(0x10 + 2*i, devbase + 0xba);
+		tmp = readl(devbase + 0xbc);
+		if ((tmp & 0x1) || !(tmp & 0x20))
+			continue;
+		irq = (tmp >> 16) & 0xff;
+		mpic->fixups[irq].irq = i;
+		mpic->fixups[irq].base = devbase + 0xba;
+	}
+}
+ 
+static void __init mpic_scan_ioapics(struct mpic *mpic)
+{
+	unsigned int devfn;
+	u8 __iomem *cfgspace;
+
+	printk(KERN_INFO "mpic: Setting up IO-APICs workarounds for U3\n");
+
+	/* Allocate fixups array */
+	mpic->fixups = alloc_bootmem(128 * sizeof(struct mpic_irq_fixup));
+	BUG_ON(mpic->fixups == NULL);
+	memset(mpic->fixups, 0, 128 * sizeof(struct mpic_irq_fixup));
+
+	/* Init spinlock */
+	spin_lock_init(&mpic->fixup_lock);
+
+	/* Map u3 config space. We assume all IO-APICs are on the primary bus
+	 * and slot will never be above "0xf" so we only need to map 32k
+	 */
+	cfgspace = (unsigned char __iomem *)ioremap(0xf2000000, 0x8000);
+	BUG_ON(cfgspace == NULL);
+
+	/* Now we scan all slots. We do a very quick scan, we read the header type,
+	 * vendor ID and device ID only, that's plenty enough
+	 */
+	for (devfn = 0; devfn < PCI_DEVFN(0x10,0); devfn ++) {
+		u8 __iomem *devbase = cfgspace + (devfn << 8);
+		u8 hdr_type = readb(devbase + PCI_HEADER_TYPE);
+		u32 l = readl(devbase + PCI_VENDOR_ID);
+		u16 vendor_id, device_id;
+		int multifunc = 0;
+
+		DBG("devfn %x, l: %x\n", devfn, l);
+
+		/* If no device, skip */
+		if (l == 0xffffffff || l == 0x00000000 ||
+		    l == 0x0000ffff || l == 0xffff0000)
+			goto next;
+
+		/* Check if it's a multifunction device (only really used
+		 * to function 0 though
+		 */
+		multifunc = !!(hdr_type & 0x80);
+		vendor_id = l & 0xffff;
+		device_id = (l >> 16) & 0xffff;
+
+		/* If a known device, go to fixup setup code */
+		if (vendor_id == PCI_VENDOR_ID_AMD && device_id == 0x7460)
+			mpic_amd8111_read_irq(mpic, devbase);
+		if (vendor_id == PCI_VENDOR_ID_AMD && device_id == 0x7450)
+			mpic_amd8131_read_irq(mpic, devbase);
+	next:
+		/* next device, if function 0 */
+		if ((PCI_FUNC(devfn) == 0) && !multifunc)
+			devfn += 7;
+	}
+}
+
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+
+/* Find an mpic associated with a given linux interrupt */
+static struct mpic *mpic_find(unsigned int irq, unsigned int *is_ipi)
+{
+	struct mpic *mpic = mpics;
+
+	while(mpic) {
+		/* search IPIs first since they may override the main interrupts */
+		if (irq >= mpic->ipi_offset && irq < (mpic->ipi_offset + 4)) {
+			if (is_ipi)
+				*is_ipi = 1;
+			return mpic;
+		}
+		if (irq >= mpic->irq_offset &&
+		    irq < (mpic->irq_offset + mpic->irq_count)) {
+			if (is_ipi)
+				*is_ipi = 0;
+			return mpic;
+		}
+		mpic = mpic -> next;
+	}
+	return NULL;
+}
+
+/* Convert a cpu mask from logical to physical cpu numbers. */
+static inline u32 mpic_physmask(u32 cpumask)
+{
+	int i;
+	u32 mask = 0;
+
+	for (i = 0; i < NR_CPUS; ++i, cpumask >>= 1)
+		mask |= (cpumask & 1) << get_hard_smp_processor_id(i);
+	return mask;
+}
+
+#ifdef CONFIG_SMP
+/* Get the mpic structure from the IPI number */
+static inline struct mpic * mpic_from_ipi(unsigned int ipi)
+{
+	return container_of(irq_desc[ipi].handler, struct mpic, hc_ipi);
+}
+#endif
+
+/* Get the mpic structure from the irq number */
+static inline struct mpic * mpic_from_irq(unsigned int irq)
+{
+	return container_of(irq_desc[irq].handler, struct mpic, hc_irq);
+}
+
+/* Send an EOI */
+static inline void mpic_eoi(struct mpic *mpic)
+{
+	mpic_cpu_write(MPIC_CPU_EOI, 0);
+	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+}
+
+#ifdef CONFIG_SMP
+static irqreturn_t mpic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mpic *mpic = dev_id;
+
+	smp_message_recv(irq - mpic->ipi_offset, regs);
+	return IRQ_HANDLED;
+}
+#endif /* CONFIG_SMP */
+
+/*
+ * Linux descriptor level callbacks
+ */
+
+
+static void mpic_enable_irq(unsigned int irq)
+{
+	unsigned int loops = 100000;
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	DBG("%s: enable_irq: %d (src %d)\n", mpic->name, irq, src);
+
+	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
+		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & ~MPIC_VECPRI_MASK);
+
+	/* make sure mask gets to controller before we return to user */
+	do {
+		if (!loops--) {
+			printk(KERN_ERR "mpic_enable_irq timeout\n");
+			break;
+		}
+	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
+}
+
+static void mpic_disable_irq(unsigned int irq)
+{
+	unsigned int loops = 100000;
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
+
+	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
+		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) | MPIC_VECPRI_MASK);
+
+	/* make sure mask gets to controller before we return to user */
+	do {
+		if (!loops--) {
+			printk(KERN_ERR "mpic_enable_irq timeout\n");
+			break;
+		}
+	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+}
+
+static void mpic_end_irq(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_irq(irq);
+
+	DBG("%s: end_irq: %d\n", mpic->name, irq);
+
+	/* We always EOI on end_irq() even for edge interrupts since that
+	 * should only lower the priority, the MPIC should have properly
+	 * latched another edge interrupt coming in anyway
+	 */
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+	if (mpic->flags & MPIC_BROKEN_U3) {
+		unsigned int src = irq - mpic->irq_offset;
+		if (mpic_is_ht_interrupt(mpic, src))
+			mpic_apic_end_irq(mpic, src);
+	}
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+	mpic_eoi(mpic);
+}
+
+#ifdef CONFIG_SMP
+
+static void mpic_enable_ipi(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_ipi(irq);
+	unsigned int src = irq - mpic->ipi_offset;
+
+	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
+	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
+}
+
+static void mpic_disable_ipi(unsigned int irq)
+{
+	/* NEVER disable an IPI... that's just plain wrong! */
+}
+
+static void mpic_end_ipi(unsigned int irq)
+{
+	struct mpic *mpic = mpic_from_ipi(irq);
+
+	/*
+	 * IPIs are marked IRQ_PER_CPU. This has the side effect of
+	 * preventing the IRQ_PENDING/IRQ_INPROGRESS logic from
+	 * applying to them. We EOI them late to avoid re-entering.
+	 * We mark IPI's with SA_INTERRUPT as they must run with
+	 * irqs disabled.
+	 */
+	mpic_eoi(mpic);
+}
+
+#endif /* CONFIG_SMP */
+
+static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
+{
+	struct mpic *mpic = mpic_from_irq(irq);
+
+	cpumask_t tmp;
+
+	cpus_and(tmp, cpumask, cpu_online_map);
+
+	mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_DESTINATION,
+		       mpic_physmask(cpus_addr(tmp)[0]));	
+}
+
+
+/*
+ * Exported functions
+ */
+
+
+struct mpic * __init mpic_alloc(unsigned long phys_addr,
+				unsigned int flags,
+				unsigned int isu_size,
+				unsigned int irq_offset,
+				unsigned int irq_count,
+				unsigned int ipi_offset,
+				unsigned char *senses,
+				unsigned int senses_count,
+				const char *name)
+{
+	struct mpic	*mpic;
+	u32		reg;
+	const char	*vers;
+	int		i;
+
+	mpic = (struct mpic *)alloc_bootmem(sizeof(struct mpic));
+	if (mpic == NULL)
+		return NULL;
+	
+	memset(mpic, 0, sizeof(struct mpic));
+	mpic->name = name;
+
+	mpic->hc_irq.typename = name;
+	mpic->hc_irq.enable = mpic_enable_irq;
+	mpic->hc_irq.disable = mpic_disable_irq;
+	mpic->hc_irq.end = mpic_end_irq;
+	if (flags & MPIC_PRIMARY)
+		mpic->hc_irq.set_affinity = mpic_set_affinity;
+#ifdef CONFIG_SMP
+	mpic->hc_ipi.typename = name;
+	mpic->hc_ipi.enable = mpic_enable_ipi;
+	mpic->hc_ipi.disable = mpic_disable_ipi;
+	mpic->hc_ipi.end = mpic_end_ipi;
+#endif /* CONFIG_SMP */
+
+	mpic->flags = flags;
+	mpic->isu_size = isu_size;
+	mpic->irq_offset = irq_offset;
+	mpic->irq_count = irq_count;
+	mpic->ipi_offset = ipi_offset;
+	mpic->num_sources = 0; /* so far */
+	mpic->senses = senses;
+	mpic->senses_count = senses_count;
+
+	/* Map the global registers */
+	mpic->gregs = ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
+	mpic->tmregs = mpic->gregs + (MPIC_TIMER_BASE >> 2);
+	BUG_ON(mpic->gregs == NULL);
+
+	/* Reset */
+	if (flags & MPIC_WANTS_RESET) {
+		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
+			   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+			   | MPIC_GREG_GCONF_RESET);
+		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		       & MPIC_GREG_GCONF_RESET)
+			mb();
+	}
+
+	/* Read feature register, calculate num CPUs and, for non-ISU
+	 * MPICs, num sources as well. On ISU MPICs, sources are counted
+	 * as ISUs are added
+	 */
+	reg = mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	mpic->num_cpus = ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
+			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
+	if (isu_size == 0)
+		mpic->num_sources = ((reg & MPIC_GREG_FEATURE_LAST_SRC_MASK)
+				     >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
+
+	/* Map the per-CPU registers */
+	for (i = 0; i < mpic->num_cpus; i++) {
+		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_CPU_BASE +
+					   i * MPIC_CPU_STRIDE, 0x1000);
+		BUG_ON(mpic->cpuregs[i] == NULL);
+	}
+
+	/* Initialize main ISU if none provided */
+	if (mpic->isu_size == 0) {
+		mpic->isu_size = mpic->num_sources;
+		mpic->isus[0] = ioremap(phys_addr + MPIC_IRQ_BASE,
+					MPIC_IRQ_STRIDE * mpic->isu_size);
+		BUG_ON(mpic->isus[0] == NULL);
+	}
+	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
+	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
+
+	/* Display version */
+	switch (reg & MPIC_GREG_FEATURE_VERSION_MASK) {
+	case 1:
+		vers = "1.0";
+		break;
+	case 2:
+		vers = "1.2";
+		break;
+	case 3:
+		vers = "1.3";
+		break;
+	default:
+		vers = "<unknown>";
+		break;
+	}
+	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %lx, max %d CPUs\n",
+	       name, vers, phys_addr, mpic->num_cpus);
+	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n", mpic->isu_size,
+	       mpic->isu_shift, mpic->isu_mask);
+
+	mpic->next = mpics;
+	mpics = mpic;
+
+	if (flags & MPIC_PRIMARY)
+		mpic_primary = mpic;
+
+	return mpic;
+}
+
+void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
+			    unsigned long phys_addr)
+{
+	BUG_ON(isu_num >= MPIC_MAX_ISU);
+
+	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
+	if ((isu_num + mpic->isu_size) > mpic->num_sources)
+		mpic->num_sources = isu_num + mpic->isu_size;
+}
+
+void __init mpic_setup_cascade(unsigned int irq, mpic_cascade_t handler,
+			       void *data)
+{
+	struct mpic *mpic = mpic_find(irq, NULL);
+	unsigned long flags;
+
+	/* Synchronization here is a bit dodgy, so don't try to replace cascade
+	 * interrupts on the fly too often ... but normally it's set up at boot.
+	 */
+	spin_lock_irqsave(&mpic_lock, flags);
+	if (mpic->cascade)	       
+		mpic_disable_irq(mpic->cascade_vec + mpic->irq_offset);
+	mpic->cascade = NULL;
+	wmb();
+	mpic->cascade_vec = irq - mpic->irq_offset;
+	mpic->cascade_data = data;
+	wmb();
+	mpic->cascade = handler;
+	mpic_enable_irq(irq);
+	spin_unlock_irqrestore(&mpic_lock, flags);
+}
+
+void __init mpic_init(struct mpic *mpic)
+{
+	int i;
+
+	BUG_ON(mpic->num_sources == 0);
+
+	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
+
+	/* Set current processor priority to max */
+	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+
+	/* Initialize timers: just disable them all */
+	for (i = 0; i < 4; i++) {
+		mpic_write(mpic->tmregs,
+			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_DESTINATION, 0);
+		mpic_write(mpic->tmregs,
+			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_VECTOR_PRI,
+			   MPIC_VECPRI_MASK |
+			   (MPIC_VEC_TIMER_0 + i));
+	}
+
+	/* Initialize IPIs to our reserved vectors and mark them disabled for now */
+	mpic_test_broken_ipi(mpic);
+	for (i = 0; i < 4; i++) {
+		mpic_ipi_write(i,
+			       MPIC_VECPRI_MASK |
+			       (10 << MPIC_VECPRI_PRIORITY_SHIFT) |
+			       (MPIC_VEC_IPI_0 + i));
+#ifdef CONFIG_SMP
+		if (!(mpic->flags & MPIC_PRIMARY))
+			continue;
+		irq_desc[mpic->ipi_offset+i].status |= IRQ_PER_CPU;
+		irq_desc[mpic->ipi_offset+i].handler = &mpic->hc_ipi;
+		
+#endif /* CONFIG_SMP */
+	}
+
+	/* Initialize interrupt sources */
+	if (mpic->irq_count == 0)
+		mpic->irq_count = mpic->num_sources;
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+	/* Do the ioapic fixups on U3 broken mpic */
+	DBG("MPIC flags: %x\n", mpic->flags);
+	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
+		mpic_scan_ioapics(mpic);
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+	for (i = 0; i < mpic->num_sources; i++) {
+		/* start with vector = source number, and masked */
+		u32 vecpri = MPIC_VECPRI_MASK | i | (8 << MPIC_VECPRI_PRIORITY_SHIFT);
+		int level = 0;
+		
+		/* if it's an IPI, we skip it */
+		if ((mpic->irq_offset + i) >= (mpic->ipi_offset + i) &&
+		    (mpic->irq_offset + i) <  (mpic->ipi_offset + i + 4))
+			continue;
+
+		/* do senses munging */
+		if (mpic->senses && i < mpic->senses_count) {
+			if (mpic->senses[i] & IRQ_SENSE_LEVEL)
+				vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+			if (mpic->senses[i] & IRQ_POLARITY_POSITIVE)
+				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+		} else
+			vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+
+		/* remember if it was a level interrupts */
+		level = (vecpri & MPIC_VECPRI_SENSE_LEVEL);
+
+		/* deal with broken U3 */
+		if (mpic->flags & MPIC_BROKEN_U3) {
+#ifdef CONFIG_MPIC_BROKEN_U3
+			if (mpic_is_ht_interrupt(mpic, i)) {
+				vecpri &= ~(MPIC_VECPRI_SENSE_MASK |
+					    MPIC_VECPRI_POLARITY_MASK);
+				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+			}
+#else
+			printk(KERN_ERR "mpic: BROKEN_U3 set, but CONFIG doesn't match\n");
+#endif
+		}
+
+		DBG("setup source %d, vecpri: %08x, level: %d\n", i, vecpri,
+		    (level != 0));
+
+		/* init hw */
+		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
+		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+			       1 << get_hard_smp_processor_id(boot_cpuid));
+
+		/* init linux descriptors */
+		if (i < mpic->irq_count) {
+			irq_desc[mpic->irq_offset+i].status = level ? IRQ_LEVEL : 0;
+			irq_desc[mpic->irq_offset+i].handler = &mpic->hc_irq;
+		}
+	}
+	
+	/* Init spurrious vector */
+	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+
+	/* Disable 8259 passthrough */
+	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
+		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+
+	/* Set current processor priority to 0 */
+	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+}
+
+
+
+void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
+{
+	int is_ipi;
+	struct mpic *mpic = mpic_find(irq, &is_ipi);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mpic_lock, flags);
+	if (is_ipi) {
+		reg = mpic_ipi_read(irq - mpic->ipi_offset) & MPIC_VECPRI_PRIORITY_MASK;
+		mpic_ipi_write(irq - mpic->ipi_offset,
+			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
+	} else {
+		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI)
+			& MPIC_VECPRI_PRIORITY_MASK;
+		mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI,
+			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
+	}
+	spin_unlock_irqrestore(&mpic_lock, flags);
+}
+
+unsigned int mpic_irq_get_priority(unsigned int irq)
+{
+	int is_ipi;
+	struct mpic *mpic = mpic_find(irq, &is_ipi);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mpic_lock, flags);
+	if (is_ipi)
+		reg = mpic_ipi_read(irq - mpic->ipi_offset);
+	else
+		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI);
+	spin_unlock_irqrestore(&mpic_lock, flags);
+	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;
+}
+
+void mpic_setup_this_cpu(void)
+{
+#ifdef CONFIG_SMP
+	struct mpic *mpic = mpic_primary;
+	unsigned long flags;
+#ifdef CONFIG_IRQ_ALL_CPUS
+	u32 msk = 1 << hard_smp_processor_id();
+	unsigned int i;
+#endif
+
+	BUG_ON(mpic == NULL);
+
+	DBG("%s: setup_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
+
+	spin_lock_irqsave(&mpic_lock, flags);
+
+#ifdef CONFIG_IRQ_ALL_CPUS
+ 	/* let the mpic know we want intrs. default affinity is 0xffffffff
+	 * until changed via /proc. That's how it's done on x86. If we want
+	 * it differently, then we should make sure we also change the default
+	 * values of irq_affinity in irq.c.
+ 	 */
+ 	for (i = 0; i < mpic->num_sources ; i++)
+		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+			mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
+#endif /* CONFIG_IRQ_ALL_CPUS */
+
+	/* Set current processor priority to 0 */
+	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+
+	spin_unlock_irqrestore(&mpic_lock, flags);
+#endif /* CONFIG_SMP */
+}
+
+void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask)
+{
+	struct mpic *mpic = mpic_primary;
+
+	BUG_ON(mpic == NULL);
+
+	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
+
+	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
+}
+
+int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs)
+{
+	u32 irq;
+
+	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
+
+	if (mpic->cascade && irq == mpic->cascade_vec) {
+		DBG("%s: cascading ...\n", mpic->name);
+		irq = mpic->cascade(regs, mpic->cascade_data);
+		mpic_eoi(mpic);
+		return irq;
+	}
+	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
+		return -1;
+	if (irq < MPIC_VEC_IPI_0) 
+		return irq + mpic->irq_offset;
+       	DBG("%s: ipi %d !\n", mpic->name, irq - MPIC_VEC_IPI_0);
+	return irq - MPIC_VEC_IPI_0 + mpic->ipi_offset;
+}
+
+int mpic_get_irq(struct pt_regs *regs)
+{
+	struct mpic *mpic = mpic_primary;
+
+	BUG_ON(mpic == NULL);
+
+	return mpic_get_one_irq(mpic, regs);
+}
+
+
+#ifdef CONFIG_SMP
+void mpic_request_ipis(void)
+{
+	struct mpic *mpic = mpic_primary;
+
+	BUG_ON(mpic == NULL);
+	
+	printk("requesting IPIs ... \n");
+
+	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
+	request_irq(mpic->ipi_offset+0, mpic_ipi_action, SA_INTERRUPT,
+		    "IPI0 (call function)", mpic);
+	request_irq(mpic->ipi_offset+1, mpic_ipi_action, SA_INTERRUPT,
+		   "IPI1 (reschedule)", mpic);
+	request_irq(mpic->ipi_offset+2, mpic_ipi_action, SA_INTERRUPT,
+		   "IPI2 (unused)", mpic);
+	request_irq(mpic->ipi_offset+3, mpic_ipi_action, SA_INTERRUPT,
+		   "IPI3 (debugger break)", mpic);
+
+	printk("IPIs requested... \n");
+}
+#endif /* CONFIG_SMP */
Index: linux-work/include/asm-ppc64/irq.h
===================================================================
--- linux-work.orig/include/asm-ppc64/irq.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-ppc64/irq.h	2004-10-23 11:44:19.389199400 +1000
@@ -20,6 +20,19 @@
 /* this number is used when no interrupt has been assigned */
 #define NO_IRQ			(-1)
 
+/*
+ * These constants are used for passing information about interrupt
+ * signal polarity and level/edge sensing to the low-level PIC chip
+ * drivers.
+ */
+#define IRQ_SENSE_MASK		0x1
+#define IRQ_SENSE_LEVEL		0x1	/* interrupt on active level */
+#define IRQ_SENSE_EDGE		0x0	/* interrupt triggered by edge */
+
+#define IRQ_POLARITY_MASK	0x2
+#define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
+#define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
+
 #define get_irq_desc(irq) (&irq_desc[(irq)])
 
 /* Define a way to iterate across irqs. */
Index: linux-work/arch/ppc64/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/Makefile	2004-10-17 12:07:04.000000000 +1000
+++ linux-work/arch/ppc64/kernel/Makefile	2004-10-23 11:44:03.016688400 +1000
@@ -28,7 +28,7 @@
 			     mf.o HvLpEvent.o iSeries_proc.o iSeries_htab.o \
 			     iSeries_iommu.o
 
-obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o open_pic.o i8259.o prom_init.o prom.o
+obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o i8259.o prom_init.o prom.o mpic.o
 
 obj-$(CONFIG_PPC_PSERIES) += pSeries_pci.o pSeries_lpar.o pSeries_hvCall.o \
 			     eeh.o pSeries_nvram.o rtasd.o ras.o \
@@ -47,8 +47,8 @@
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
-				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
-				   open_pic_u3.o
+				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
+
 obj-$(CONFIG_U3_DART)		+= u3_iommu.o
 
 ifdef CONFIG_SMP
Index: linux-work/arch/ppc64/kernel/open_pic_defs.h
===================================================================
--- linux-work.orig/arch/ppc64/kernel/open_pic_defs.h	2004-10-17 12:07:05.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,283 +0,0 @@
-/*
- *  linux/openpic.h -- OpenPIC definitions
- *
- *  Copyright (C) 1997 Geert Uytterhoeven
- *
- *  This file is based on the following documentation:
- *
- *	The Open Programmable Interrupt Controller (PIC)
- *	Register Interface Specification Revision 1.2
- *
- *	Issue Date: October 1995
- *
- *	Issued jointly by Advanced Micro Devices and Cyrix Corporation
- *
- *	AMD is a registered trademark of Advanced Micro Devices, Inc.
- *	Copyright (C) 1995, Advanced Micro Devices, Inc. and Cyrix, Inc.
- *	All Rights Reserved.
- *
- *  To receive a copy of this documentation, send an email to openpic@amd.com.
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive
- *  for more details.
- */
-
-#ifndef _LINUX_OPENPIC_H
-#define _LINUX_OPENPIC_H
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
-
-/*
- *  OpenPIC supports up to 2048 interrupt sources and up to 32 processors
- */
-
-#define OPENPIC_MAX_SOURCES	2048
-#define OPENPIC_MAX_PROCESSORS	32
-#define OPENPIC_MAX_ISU		32
-
-#define OPENPIC_NUM_TIMERS	4
-#define OPENPIC_NUM_IPI		4
-#define OPENPIC_NUM_PRI		16
-#define OPENPIC_NUM_VECTORS	OPENPIC_MAX_SOURCES
-
-/*
- *  OpenPIC Registers are 32 bits and aligned on 128 bit boundaries
- */
-
-typedef struct _OpenPIC_Reg {
-	u_int Reg;					/* Little endian! */
-	char Pad[0xc];
-} OpenPIC_Reg;
-
-
-/*
- *  Per Processor Registers
- */
-
-typedef struct _OpenPIC_Processor {
-	/*
-	 *  Private Shadow Registers (for SLiC backwards compatibility)
-	 */
-	u_int IPI0_Dispatch_Shadow;			/* Write Only */
-	char Pad1[0x4];
-	u_int IPI0_Vector_Priority_Shadow;		/* Read/Write */
-	char Pad2[0x34];
-	/*
-	 *  Interprocessor Interrupt Command Ports
-	 */
-	OpenPIC_Reg _IPI_Dispatch[OPENPIC_NUM_IPI];	/* Write Only */
-	/*
-	 *  Current Task Priority Register
-	 */
-	OpenPIC_Reg _Current_Task_Priority;		/* Read/Write */
-	char Pad3[0x10];
-	/*
-	 *  Interrupt Acknowledge Register
-	 */
-	OpenPIC_Reg _Interrupt_Acknowledge;		/* Read Only */
-	/*
-	 *  End of Interrupt (EOI) Register
-	 */
-	OpenPIC_Reg _EOI;				/* Read/Write */
-	char Pad5[0xf40];
-} OpenPIC_Processor;
-
-
-    /*
-     *  Timer Registers
-     */
-
-typedef struct _OpenPIC_Timer {
-	OpenPIC_Reg _Current_Count;			/* Read Only */
-	OpenPIC_Reg _Base_Count;			/* Read/Write */
-	OpenPIC_Reg _Vector_Priority;			/* Read/Write */
-	OpenPIC_Reg _Destination;			/* Read/Write */
-} OpenPIC_Timer;
-
-
-    /*
-     *  Global Registers
-     */
-
-typedef struct _OpenPIC_Global {
-	/*
-	 *  Feature Reporting Registers
-	 */
-	OpenPIC_Reg _Feature_Reporting0;		/* Read Only */
-	OpenPIC_Reg _Feature_Reporting1;		/* Future Expansion */
-	/*
-	 *  Global Configuration Registers
-	 */
-	OpenPIC_Reg _Global_Configuration0;		/* Read/Write */
-	OpenPIC_Reg _Global_Configuration1;		/* Future Expansion */
-	/*
-	 *  Vendor Specific Registers
-	 */
-	OpenPIC_Reg _Vendor_Specific[4];
-	/*
-	 *  Vendor Identification Register
-	 */
-	OpenPIC_Reg _Vendor_Identification;		/* Read Only */
-	/*
-	 *  Processor Initialization Register
-	 */
-	OpenPIC_Reg _Processor_Initialization;		/* Read/Write */
-	/*
-	 *  IPI Vector/Priority Registers
-	 */
-	OpenPIC_Reg _IPI_Vector_Priority[OPENPIC_NUM_IPI]; /* Read/Write */
-	/*
-	 *  Spurious Vector Register
-	 */
-	OpenPIC_Reg _Spurious_Vector;			/* Read/Write */
-	/*
-	 *  Global Timer Registers
-	 */
-	OpenPIC_Reg _Timer_Frequency;			/* Read/Write */
-	OpenPIC_Timer Timer[OPENPIC_NUM_TIMERS];
-	char Pad1[0xee00];
-} OpenPIC_Global;
-
-
-    /*
-     *  Interrupt Source Registers
-     */
-
-typedef struct _OpenPIC_Source {
-	OpenPIC_Reg _Vector_Priority;			/* Read/Write */
-	OpenPIC_Reg _Destination;			/* Read/Write */
-} OpenPIC_Source, *OpenPIC_SourcePtr;
-
-
-    /*
-     *  OpenPIC Register Map
-     */
-
-struct OpenPIC {
-	char Pad1[0x1000];
-	/*
-	 *  Global Registers
-	 */
-	OpenPIC_Global Global;
-	/*
-	 *  Interrupt Source Configuration Registers
-	 */
-	OpenPIC_Source Source[OPENPIC_MAX_SOURCES];
-	/*
-	 *  Per Processor Registers
-	 */
-	OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
-};
-
-
-/*
- *  Current Task Priority Register
- */
-
-#define OPENPIC_CURRENT_TASK_PRIORITY_MASK	0x0000000f
-
-/*
- *  Who Am I Register
- */
-
-#define OPENPIC_WHO_AM_I_ID_MASK		0x0000001f
-
-/*
- *  Feature Reporting Register 0
- */
-
-#define OPENPIC_FEATURE_LAST_SOURCE_MASK	0x07ff0000
-#define OPENPIC_FEATURE_LAST_SOURCE_SHIFT	16
-#define OPENPIC_FEATURE_LAST_PROCESSOR_MASK	0x00001f00
-#define OPENPIC_FEATURE_LAST_PROCESSOR_SHIFT	8
-#define OPENPIC_FEATURE_VERSION_MASK		0x000000ff
-
-/*
- *  Global Configuration Register 0
- */
-
-#define OPENPIC_CONFIG_RESET			0x80000000
-#define OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE	0x20000000
-#define OPENPIC_CONFIG_BASE_MASK		0x000fffff
-
-/*
- *  Vendor Identification Register
- */
-
-#define OPENPIC_VENDOR_ID_STEPPING_MASK		0x00ff0000
-#define OPENPIC_VENDOR_ID_STEPPING_SHIFT	16
-#define OPENPIC_VENDOR_ID_DEVICE_ID_MASK	0x0000ff00
-#define OPENPIC_VENDOR_ID_DEVICE_ID_SHIFT	8
-#define OPENPIC_VENDOR_ID_VENDOR_ID_MASK	0x000000ff
-
-/*
- *  Vector/Priority Registers
- */
-
-#define OPENPIC_MASK				0x80000000
-#define OPENPIC_ACTIVITY			0x40000000	/* Read Only */
-#define OPENPIC_PRIORITY_MASK			0x000f0000
-#define OPENPIC_PRIORITY_SHIFT			16
-#define OPENPIC_VECTOR_MASK			0x000007ff
-
-
-/*
- *  Interrupt Source Registers
- */
-
-#define OPENPIC_POLARITY_POSITIVE		0x00800000
-#define OPENPIC_POLARITY_NEGATIVE		0x00000000
-#define OPENPIC_POLARITY_MASK			0x00800000
-#define OPENPIC_SENSE_LEVEL			0x00400000
-#define OPENPIC_SENSE_EDGE			0x00000000
-#define OPENPIC_SENSE_MASK			0x00400000
-
-
-/*
- *  Timer Registers
- */
-
-#define OPENPIC_COUNT_MASK			0x7fffffff
-#define OPENPIC_TIMER_TOGGLE			0x80000000
-#define OPENPIC_TIMER_COUNT_INHIBIT		0x80000000
-
-
-/*
- *  Aliases to make life simpler
- */
-
-/* Per Processor Registers */
-#define IPI_Dispatch(i)			_IPI_Dispatch[i].Reg
-#define Current_Task_Priority		_Current_Task_Priority.Reg
-#define Interrupt_Acknowledge		_Interrupt_Acknowledge.Reg
-#define EOI				_EOI.Reg
-
-/* Global Registers */
-#define Feature_Reporting0		_Feature_Reporting0.Reg
-#define Feature_Reporting1		_Feature_Reporting1.Reg
-#define Global_Configuration0		_Global_Configuration0.Reg
-#define Global_Configuration1		_Global_Configuration1.Reg
-#define Vendor_Specific(i)		_Vendor_Specific[i].Reg
-#define Vendor_Identification		_Vendor_Identification.Reg
-#define Processor_Initialization	_Processor_Initialization.Reg
-#define IPI_Vector_Priority(i)		_IPI_Vector_Priority[i].Reg
-#define Spurious_Vector			_Spurious_Vector.Reg
-#define Timer_Frequency			_Timer_Frequency.Reg
-
-/* Timer Registers */
-#define Current_Count			_Current_Count.Reg
-#define Base_Count			_Base_Count.Reg
-#define Vector_Priority			_Vector_Priority.Reg
-#define Destination			_Destination.Reg
-
-/* Interrupt Source Registers */
-#define Vector_Priority			_Vector_Priority.Reg
-#define Destination			_Destination.Reg
-
-
-#endif /* __KERNEL__ */
-
-#endif /* _LINUX_OPENPIC_H */
Index: linux-work/arch/ppc64/kernel/open_pic.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/open_pic.c	2004-10-17 12:07:05.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,886 +0,0 @@
-/*
- *  arch/ppc/kernel/open_pic.c -- OpenPIC Interrupt Handling
- *
- *  Copyright (C) 1997 Geert Uytterhoeven
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <asm/ptrace.h>
-#include <asm/signal.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-
-#include <asm/machdep.h>
-
-#include "open_pic.h"
-#include "open_pic_defs.h"
-#include "i8259.h"
-#include <asm/ppcdebug.h>
-
-void* OpenPIC_Addr;
-static volatile struct OpenPIC *OpenPIC = NULL;
-u_int OpenPIC_NumInitSenses __initdata = 0;
-u_char *OpenPIC_InitSenses __initdata = NULL;
-
-/*
- *  Local (static) OpenPIC Operations
- */
-
-
-/* Global Operations */
-static void openpic_reset(void);
-static void openpic_enable_8259_pass_through(void);
-static void openpic_disable_8259_pass_through(void);
-static u_int openpic_irq(void);
-static void openpic_eoi(void);
-static u_int openpic_get_priority(void);
-static void openpic_set_priority(u_int pri);
-static u_int openpic_get_spurious(void);
-static void openpic_set_spurious(u_int vector);
-
-#ifdef CONFIG_SMP
-/* Interprocessor Interrupts */
-static void openpic_initipi(u_int ipi, u_int pri, u_int vector);
-static irqreturn_t openpic_ipi_action(int cpl, void *dev_id,
-					struct pt_regs *regs);
-#endif
-
-/* Timer Interrupts */
-static void openpic_inittimer(u_int timer, u_int pri, u_int vector);
-static void openpic_maptimer(u_int timer, u_int cpumask);
-
-/* Interrupt Sources */
-static void openpic_enable_irq(u_int irq);
-static void openpic_disable_irq(u_int irq);
-static void openpic_initirq(u_int irq, u_int pri, u_int vector, int polarity,
-			    int is_level);
-static void openpic_mapirq(u_int irq, u_int cpumask);
-
-static void find_ISUs(void);
-
-static u_int NumProcessors;
-static u_int NumSources;
-static int NumISUs;
-static int open_pic_irq_offset;
-static volatile unsigned char* chrp_int_ack_special;
-
-OpenPIC_SourcePtr ISU[OPENPIC_MAX_ISU];
-
-static void openpic_end_irq(unsigned int irq_nr);
-static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
-
-struct hw_interrupt_type open_pic = {
-	" OpenPIC  ",
-	NULL,
-	NULL,
-	openpic_enable_irq,
-	openpic_disable_irq,
-	NULL,
-	openpic_end_irq,
-	openpic_set_affinity
-};
-
-#ifdef CONFIG_SMP
-static void openpic_end_ipi(unsigned int irq_nr);
-static void openpic_enable_ipi(unsigned int irq_nr);
-static void openpic_disable_ipi(unsigned int irq_nr);
-
-struct hw_interrupt_type open_pic_ipi = {
-	" OpenPIC  ",
-	NULL,
-	NULL,
-	openpic_enable_ipi,
-	openpic_disable_ipi,
-	NULL,
-	openpic_end_ipi,
-	NULL
-};
-#endif /* CONFIG_SMP */
-
-unsigned int openpic_vec_ipi;
-unsigned int openpic_vec_timer;
-unsigned int openpic_vec_spurious;
-
-/*
- *  Accesses to the current processor's openpic registers
- */
-#ifdef CONFIG_SMP
-#define THIS_CPU		Processor[cpu]
-#define DECL_THIS_CPU		int cpu = hard_smp_processor_id()
-#define CHECK_THIS_CPU		check_arg_cpu(cpu)
-#else
-#define THIS_CPU		Processor[hard_smp_processor_id()]
-#define DECL_THIS_CPU
-#define CHECK_THIS_CPU
-#endif /* CONFIG_SMP */
-
-#if 0
-#define check_arg_ipi(ipi) \
-    if (ipi < 0 || ipi >= OPENPIC_NUM_IPI) \
-	printk(KERN_ERR "open_pic.c:%d: invalid ipi %d\n", __LINE__, ipi);
-#define check_arg_timer(timer) \
-    if (timer < 0 || timer >= OPENPIC_NUM_TIMERS) \
-	printk(KERN_ERR "open_pic.c:%d: invalid timer %d\n", __LINE__, timer);
-#define check_arg_vec(vec) \
-    if (vec < 0 || vec >= OPENPIC_NUM_VECTORS) \
-	printk(KERN_ERR "open_pic.c:%d: invalid vector %d\n", __LINE__, vec);
-#define check_arg_pri(pri) \
-    if (pri < 0 || pri >= OPENPIC_NUM_PRI) \
-	printk(KERN_ERR "open_pic.c:%d: invalid priority %d\n", __LINE__, pri);
-/*
- * Print out a backtrace if it's out of range, since if it's larger than NR_IRQ's
- * data has probably been corrupted and we're going to panic or deadlock later
- * anyway --Troy
- */
-#define check_arg_irq(irq) \
-    if (irq < open_pic_irq_offset || irq >= (NumSources+open_pic_irq_offset)){ \
-      printk(KERN_ERR "open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
-      dump_stack(); }
-#define check_arg_cpu(cpu) \
-    if (cpu < 0 || cpu >= OPENPIC_MAX_PROCESSORS){ \
-	printk(KERN_ERR "open_pic.c:%d: invalid cpu %d\n", __LINE__, cpu); \
-	dump_stack(); }
-#else
-#define check_arg_ipi(ipi)	do {} while (0)
-#define check_arg_timer(timer)	do {} while (0)
-#define check_arg_vec(vec)	do {} while (0)
-#define check_arg_pri(pri)	do {} while (0)
-#define check_arg_irq(irq)	do {} while (0)
-#define check_arg_cpu(cpu)	do {} while (0)
-#endif
-
-#define GET_ISU(source)	ISU[(source) >> 4][(source) & 0xf]
-
-void __init pSeries_init_openpic(void)
-{
-        struct device_node *np;
-        int i;
-        unsigned int *addrp;
-        unsigned char* chrp_int_ack_special = NULL;
-        unsigned char init_senses[NR_IRQS - NUM_ISA_INTERRUPTS];
-        int nmi_irq = -1;
-#if defined(CONFIG_VT) && defined(CONFIG_ADB_KEYBOARD) && defined(XMON)
-        struct device_node *kbd;
-#endif
-
-        if (!(np = of_find_node_by_name(NULL, "pci"))
-            || !(addrp = (unsigned int *)
-                 get_property(np, "8259-interrupt-acknowledge", NULL)))
-                printk(KERN_ERR "Cannot find pci to get ack address\n");
-        else
-		chrp_int_ack_special = (unsigned char *)
-			__ioremap(addrp[prom_n_addr_cells(np)-1], 1, _PAGE_NO_CACHE);
-        /* hydra still sets OpenPIC_InitSenses to a static set of values */
-        if (OpenPIC_InitSenses == NULL) {
-                prom_get_irq_senses(init_senses, NUM_ISA_INTERRUPTS, NR_IRQS);
-                OpenPIC_InitSenses = init_senses;
-                OpenPIC_NumInitSenses = NR_IRQS - NUM_ISA_INTERRUPTS;
-        }
-        openpic_init(1, NUM_ISA_INTERRUPTS, chrp_int_ack_special, nmi_irq);
-        for (i = 0; i < NUM_ISA_INTERRUPTS; i++)
-                irq_desc[i].handler = &i8259_pic;
-	of_node_put(np);
-}
-
-static inline u_int openpic_read(volatile u_int *addr)
-{
-	u_int val;
-
-	val = in_le32(addr);
-	return val;
-}
-
-static inline void openpic_write(volatile u_int *addr, u_int val)
-{
-	out_le32(addr, val);
-}
-
-static inline u_int openpic_readfield(volatile u_int *addr, u_int mask)
-{
-	u_int val = openpic_read(addr);
-	return val & mask;
-}
-
-static inline void openpic_writefield(volatile u_int *addr, u_int mask,
-			       u_int field)
-{
-	u_int val = openpic_read(addr);
-	openpic_write(addr, (val & ~mask) | (field & mask));
-}
-
-static inline void openpic_clearfield(volatile u_int *addr, u_int mask)
-{
-	openpic_writefield(addr, mask, 0);
-}
-
-static inline void openpic_setfield(volatile u_int *addr, u_int mask)
-{
-	openpic_writefield(addr, mask, mask);
-}
-
-static void openpic_safe_writefield(volatile u_int *addr, u_int mask,
-				    u_int field)
-{
-	unsigned int loops = 100000;
-
-	openpic_setfield(addr, OPENPIC_MASK);
-	while (openpic_read(addr) & OPENPIC_ACTIVITY) {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_safe_writefield timeout\n");
-			break;
-		}
-	}
-	openpic_writefield(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
-}
-
-#ifdef CONFIG_SMP
-
-static int broken_ipi_registers;
-
-static u_int openpic_read_IPI(volatile u_int* addr)
-{
-        u_int val = 0;
-
-	if (broken_ipi_registers)
-		/* yes this is right ... bug, feature, you decide! -- tgall */
-		val = in_be32(addr);
-	else
-		val = in_le32(addr);
-
-        return val;
-}
-
-static void openpic_test_broken_IPI(void)
-{
-	u_int t;
-
-	openpic_write(&OpenPIC->Global.IPI_Vector_Priority(0), OPENPIC_MASK);
-	t = openpic_read(&OpenPIC->Global.IPI_Vector_Priority(0));
-	if (t == le32_to_cpu(OPENPIC_MASK)) {
-		printk(KERN_INFO "OpenPIC reversed IPI registers detected\n");
-		broken_ipi_registers = 1;
-	}
-}
-
-/* because of the power3 be / le above, this is needed */
-static inline void openpic_writefield_IPI(volatile u_int* addr, u_int mask, u_int field)
-{
-        u_int  val = openpic_read_IPI(addr);
-        openpic_write(addr, (val & ~mask) | (field & mask));
-}
-
-static inline void openpic_clearfield_IPI(volatile u_int *addr, u_int mask)
-{
-        openpic_writefield_IPI(addr, mask, 0);
-}
-
-static inline void openpic_setfield_IPI(volatile u_int *addr, u_int mask)
-{
-        openpic_writefield_IPI(addr, mask, mask);
-}
-
-static void openpic_safe_writefield_IPI(volatile u_int *addr, u_int mask, u_int field)
-{
-	unsigned int loops = 100000;
-
-        openpic_setfield_IPI(addr, OPENPIC_MASK);
-
-        /* wait until it's not in use */
-        /* BenH: Is this code really enough ? I would rather check the result
-         *       and eventually retry ...
-         */
-        while(openpic_read_IPI(addr) & OPENPIC_ACTIVITY) {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_safe_writefield timeout\n");
-			break;
-		}
-	}
-
-        openpic_writefield_IPI(addr, mask, field | OPENPIC_MASK);
-}
-#endif /* CONFIG_SMP */
-
-void __init openpic_init(int main_pic, int offset, unsigned char* chrp_ack,
-			 int programmer_switch_irq)
-{
-	u_int t, i;
-	u_int timerfreq;
-	const char *version;
-
-	if (!OpenPIC_Addr) {
-		printk(KERN_INFO "No OpenPIC found !\n");
-		return;
-	}
-	OpenPIC = (volatile struct OpenPIC *)OpenPIC_Addr;
-
-	ppc64_boot_msg(0x20, "OpenPic Init");
-
-	t = openpic_read(&OpenPIC->Global.Feature_Reporting0);
-	switch (t & OPENPIC_FEATURE_VERSION_MASK) {
-	case 1:
-		version = "1.0";
-		break;
-	case 2:
-		version = "1.2";
-		break;
-	case 3:
-		version = "1.3";
-		break;
-	default:
-		version = "?";
-		break;
-	}
-	NumProcessors = ((t & OPENPIC_FEATURE_LAST_PROCESSOR_MASK) >>
-			 OPENPIC_FEATURE_LAST_PROCESSOR_SHIFT) + 1;
-	NumSources = ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
-		      OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1;
-	printk(KERN_INFO "OpenPIC Version %s (%d CPUs and %d IRQ sources) at %p\n",
-	       version, NumProcessors, NumSources, OpenPIC);
-	timerfreq = openpic_read(&OpenPIC->Global.Timer_Frequency);
-	if (timerfreq)
-		printk(KERN_INFO "OpenPIC timer frequency is %d.%06d MHz\n",
-		       timerfreq / 1000000, timerfreq % 1000000);
-
-	if (!main_pic)
-		return;
-
-	open_pic_irq_offset = offset;
-	chrp_int_ack_special = (volatile unsigned char*)chrp_ack;
-
-	find_ISUs();
-
-	/* Initialize timer interrupts */
-	for (i = 0; i < OPENPIC_NUM_TIMERS; i++) {
-		/* Disabled, Priority 0 */
-		openpic_inittimer(i, 0, openpic_vec_timer+i);
-		/* No processor */
-		openpic_maptimer(i, 0);
-	}
-
-#ifdef CONFIG_SMP
-	/* Initialize IPI interrupts */
-	openpic_test_broken_IPI();
-	for (i = 0; i < OPENPIC_NUM_IPI; i++) {
-		/* Disabled, Priority 10..13 */
-		openpic_initipi(i, 10+i, openpic_vec_ipi+i);
-		/* IPIs are per-CPU */
-		irq_desc[openpic_vec_ipi+i].status |= IRQ_PER_CPU;
-		irq_desc[openpic_vec_ipi+i].handler = &open_pic_ipi;
-	}
-#endif
-
-	/* Initialize external interrupts */
-	openpic_set_priority(0xf);
-
-	/* SIOint (8259 cascade) is special */
-	if (offset) {
-		openpic_initirq(0, 8, offset, 1, 1);
-		openpic_mapirq(0, 1 << get_hard_smp_processor_id(boot_cpuid));
-	}
-
-	/* Init all external sources */
-	for (i = 0; i < NumSources; i++) {
-		int pri, sense;
-
-		/* skip cascade if any */
-		if (offset && i == 0)
-			continue;
-		/* the bootloader may have left it enabled (bad !) */
-		openpic_disable_irq(i+offset);
-
-		pri = (i == programmer_switch_irq)? 9: 8;
-		sense = (i < OpenPIC_NumInitSenses)? OpenPIC_InitSenses[i]: 1;
-		if (sense)
-			irq_desc[i+offset].status = IRQ_LEVEL;
-
-		/* Enabled, Priority 8 or 9 */
-		openpic_initirq(i, pri, i+offset, !sense, sense);
-		/* Processor 0 */
-		openpic_mapirq(i, 1 << get_hard_smp_processor_id(boot_cpuid));
-	}
-
-	/* Init descriptors */
-	for (i = offset; i < NumSources + offset; i++)
-		irq_desc[i].handler = &open_pic;
-
-	/* Initialize the spurious interrupt */
-	openpic_set_spurious(openpic_vec_spurious);
-
-	openpic_set_priority(0);
-	openpic_disable_8259_pass_through();
-
-	ppc64_boot_msg(0x25, "OpenPic Done");
-}
-
-/* 
- * We cant do this in init_IRQ because we need the memory subsystem up for
- * request_irq()
- */
-static int __init openpic_setup_i8259(void)
-{
-	if (systemcfg->platform == PLATFORM_POWERMAC)
-		return 0;
-
-	if (naca->interrupt_controller == IC_OPEN_PIC) {
-		/* Initialize the cascade */
-		if (request_irq(NUM_ISA_INTERRUPTS, no_action, SA_INTERRUPT,
-				"82c59 cascade", NULL))
-			printk(KERN_ERR "Unable to get OpenPIC IRQ 0 for cascade\n");
-		i8259_init();
-	}
-
-	return 0;
-}
-arch_initcall(openpic_setup_i8259);
-
-void openpic_setup_ISU(int isu_num, unsigned long addr)
-{
-	if (isu_num >= OPENPIC_MAX_ISU)
-		return;
-	ISU[isu_num] = (OpenPIC_SourcePtr) __ioremap(addr, 0x400, _PAGE_NO_CACHE);
-	if (isu_num >= NumISUs)
-		NumISUs = isu_num + 1;
-}
-
-void find_ISUs(void)
-{
-	/* For PowerMac, setup ISUs on base openpic */
-	if (systemcfg->platform == PLATFORM_POWERMAC) {
-		int i;
-		for (i=0; i<128; i+=0x10) {
-			ISU[i>>4] = &((struct OpenPIC *)OpenPIC_Addr)->Source[i];
-			NumISUs++;
-		}
-	}
-        /* Use /interrupt-controller/reg and
-         * /interrupt-controller/interrupt-ranges from OF device tree
-	 * the ISU array is setup in chrp_pci.c in ibm_add_bridges
-	 * as a result
-	 * -- tgall
-         */
-
-	/* basically each ISU is a bus, and this assumes that
-	 * open_pic_isu_count interrupts per bus are possible 
-	 * ISU == Interrupt Source
-	 *
-	 * On G5, we keep the original NumSources provided by the controller,
-	 * it's below 128, so we have room to stuff the IPIs and timers like darwin
-	 * does. We put the spurrious vector up at 0xff though.
-	 */
-	if (systemcfg->platform == PLATFORM_POWERMAC) {
-		openpic_vec_ipi = NumSources;
-		openpic_vec_timer = openpic_vec_ipi + 4; 
-		openpic_vec_spurious = 0xff;
-	} else {
-		NumSources = NumISUs * 0x10;
-
-		openpic_vec_ipi = NumSources + open_pic_irq_offset;
-		openpic_vec_timer = openpic_vec_ipi + OPENPIC_NUM_IPI; 
-		openpic_vec_spurious = openpic_vec_timer + OPENPIC_NUM_TIMERS;
-	}
-}
-
-static inline void openpic_reset(void)
-{
-	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
-			 OPENPIC_CONFIG_RESET);
-}
-
-static inline void openpic_enable_8259_pass_through(void)
-{
-	openpic_clearfield(&OpenPIC->Global.Global_Configuration0,
-			   OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
-}
-
-static void openpic_disable_8259_pass_through(void)
-{
-	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
-			 OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
-}
-
-/*
- *  Find out the current interrupt
- */
-static u_int openpic_irq(void)
-{
-	u_int vec;
-	DECL_THIS_CPU;
-
-	CHECK_THIS_CPU;
-	vec = openpic_readfield(&OpenPIC->THIS_CPU.Interrupt_Acknowledge,
-				OPENPIC_VECTOR_MASK);
-	return vec;
-}
-
-static void openpic_eoi(void)
-{
-	DECL_THIS_CPU;
-
-	CHECK_THIS_CPU;
-	openpic_write(&OpenPIC->THIS_CPU.EOI, 0);
-	/* Handle PCI write posting */
-	(void)openpic_read(&OpenPIC->THIS_CPU.EOI);
-}
-
-
-static inline u_int openpic_get_priority(void)
-{
-	DECL_THIS_CPU;
-
-	CHECK_THIS_CPU;
-	return openpic_readfield(&OpenPIC->THIS_CPU.Current_Task_Priority,
-				 OPENPIC_CURRENT_TASK_PRIORITY_MASK);
-}
-
-static void openpic_set_priority(u_int pri)
-{
-	DECL_THIS_CPU;
-
-	CHECK_THIS_CPU;
-	check_arg_pri(pri);
-	openpic_writefield(&OpenPIC->THIS_CPU.Current_Task_Priority,
-			   OPENPIC_CURRENT_TASK_PRIORITY_MASK, pri);
-}
-
-/*
- *  Get/set the spurious vector
- */
-static inline u_int openpic_get_spurious(void)
-{
-	return openpic_readfield(&OpenPIC->Global.Spurious_Vector,
-				 OPENPIC_VECTOR_MASK);
-}
-
-static void openpic_set_spurious(u_int vec)
-{
-	check_arg_vec(vec);
-	openpic_writefield(&OpenPIC->Global.Spurious_Vector, OPENPIC_VECTOR_MASK,
-			   vec);
-}
-
-/*
- * Convert a cpu mask from logical to physical cpu numbers.
- */
-static inline u32 physmask(u32 cpumask)
-{
-	int i;
-	u32 mask = 0;
-
-	for (i = 0; i < NR_CPUS; ++i, cpumask >>= 1)
-		mask |= (cpumask & 1) << get_hard_smp_processor_id(i);
-	return mask;
-}
-
-void openpic_init_processor(u_int cpumask)
-{
-	openpic_write(&OpenPIC->Global.Processor_Initialization,
-		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
-}
-
-#ifdef CONFIG_SMP
-/*
- *  Initialize an interprocessor interrupt (and disable it)
- *
- *  ipi: OpenPIC interprocessor interrupt number
- *  pri: interrupt source priority
- *  vec: the vector it will produce
- */
-static void __init openpic_initipi(u_int ipi, u_int pri, u_int vec)
-{
-	check_arg_ipi(ipi);
-	check_arg_pri(pri);
-	check_arg_vec(vec);
-	openpic_safe_writefield_IPI(&OpenPIC->Global.IPI_Vector_Priority(ipi),
-				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK,
-				(pri << OPENPIC_PRIORITY_SHIFT) | vec);
-}
-
-/*
- *  Send an IPI to one or more CPUs
- *  
- *  Externally called, however, it takes an IPI number (0...OPENPIC_NUM_IPI)
- *  and not a system-wide interrupt number
- */
-void openpic_cause_IPI(u_int ipi, u_int cpumask)
-{
-	DECL_THIS_CPU;
-
-	CHECK_THIS_CPU;
-	check_arg_ipi(ipi);
-	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
-		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
-}
-
-void openpic_request_IPIs(void)
-{
-	int i;
-	
-	/*
-	 * Make sure this matches what is defined in smp.c for 
-	 * smp_message_{pass|recv}() or what shows up in 
-	 * /proc/interrupts will be wrong!!! --Troy */
-	
-	if (OpenPIC == NULL)
-		return;
-
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(openpic_vec_ipi, openpic_ipi_action, SA_INTERRUPT,
-		    "IPI0 (call function)", NULL);
-	request_irq(openpic_vec_ipi+1, openpic_ipi_action, SA_INTERRUPT,
-		   "IPI1 (reschedule)", NULL);
-	request_irq(openpic_vec_ipi+2, openpic_ipi_action, SA_INTERRUPT,
-		   "IPI2 (unused)", NULL);
-	request_irq(openpic_vec_ipi+3, openpic_ipi_action, SA_INTERRUPT,
-		   "IPI3 (debugger break)", NULL);
-
-	for ( i = 0; i < OPENPIC_NUM_IPI ; i++ )
-		openpic_enable_ipi(openpic_vec_ipi+i);
-}
-
-/*
- * Do per-cpu setup for SMP systems.
- *
- * Get IPI's working and start taking interrupts.
- *   -- Cort
- */
-static spinlock_t openpic_setup_lock __devinitdata = SPIN_LOCK_UNLOCKED;
-
-void __devinit do_openpic_setup_cpu(void)
-{
-#ifdef CONFIG_IRQ_ALL_CPUS
- 	int i;
-	u32 msk = 1 << hard_smp_processor_id();
-#endif
-
-	spin_lock(&openpic_setup_lock);
-
-#ifdef CONFIG_IRQ_ALL_CPUS
- 	/* let the openpic know we want intrs. default affinity
- 	 * is 0xffffffff until changed via /proc
- 	 * That's how it's done on x86. If we want it differently, then
- 	 * we should make sure we also change the default values of irq_affinity
- 	 * in irq.c.
- 	 */
- 	for (i = 0; i < NumSources ; i++)
-		openpic_mapirq(i, openpic_read(&GET_ISU(i).Destination) | msk);
-#endif /* CONFIG_IRQ_ALL_CPUS */
- 	openpic_set_priority(0);
-
-	spin_unlock(&openpic_setup_lock);
-}
-#endif /* CONFIG_SMP */
-
-/*
- *  Initialize a timer interrupt (and disable it)
- *
- *  timer: OpenPIC timer number
- *  pri: interrupt source priority
- *  vec: the vector it will produce
- */
-static void __init openpic_inittimer(u_int timer, u_int pri, u_int vec)
-{
-	check_arg_timer(timer);
-	check_arg_pri(pri);
-	check_arg_vec(vec);
-	openpic_safe_writefield(&OpenPIC->Global.Timer[timer].Vector_Priority,
-				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK,
-				(pri << OPENPIC_PRIORITY_SHIFT) | vec);
-}
-
-/*
- *  Map a timer interrupt to one or more CPUs
- */
-static void __init openpic_maptimer(u_int timer, u_int cpumask)
-{
-	check_arg_timer(timer);
-	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
-		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
-}
-
-
-/*
- *
- * All functions below take an offset'ed irq argument
- *
- */
-
-
-/*
- *  Enable/disable an external interrupt source
- *
- *  Externally called, irq is an offseted system-wide interrupt number
- */
-static void openpic_enable_irq(u_int irq)
-{
-	unsigned int loops = 100000;
-	check_arg_irq(irq);
-
-	openpic_clearfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority, OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_enable_irq timeout\n");
-			break;
-		}
-
-		mb(); /* sync is probably useless here */
-	} while(openpic_readfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority,
-			OPENPIC_MASK));
-}
-
-static void openpic_disable_irq(u_int irq)
-{
-	u32 vp;
-	unsigned int loops = 100000;
-	
-	check_arg_irq(irq);
-
-	openpic_setfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority, OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_disable_irq timeout\n");
-			break;
-		}
-
-		mb();  /* sync is probably useless here */
-		vp = openpic_readfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority,
-    			OPENPIC_MASK | OPENPIC_ACTIVITY);
-	} while((vp & OPENPIC_ACTIVITY) && !(vp & OPENPIC_MASK));
-}
-
-#ifdef CONFIG_SMP
-/*
- *  Enable/disable an IPI interrupt source
- *  
- *  Externally called, irq is an offseted system-wide interrupt number
- */
-void openpic_enable_ipi(u_int irq)
-{
-	irq -= openpic_vec_ipi;
-	check_arg_ipi(irq);
-	openpic_clearfield_IPI(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);
-
-}
-void openpic_disable_ipi(u_int irq)
-{
-   /* NEVER disable an IPI... that's just plain wrong! */
-}
-
-#endif
-
-/*
- *  Initialize an interrupt source (and disable it!)
- *
- *  irq: OpenPIC interrupt number
- *  pri: interrupt source priority
- *  vec: the vector it will produce
- *  pol: polarity (1 for positive, 0 for negative)
- *  sense: 1 for level, 0 for edge
- */
-static void openpic_initirq(u_int irq, u_int pri, u_int vec, int pol, int sense)
-{
-	openpic_safe_writefield(&GET_ISU(irq).Vector_Priority,
-				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK |
-				OPENPIC_SENSE_MASK | OPENPIC_POLARITY_MASK,
-				(pri << OPENPIC_PRIORITY_SHIFT) | vec |
-				(pol ? OPENPIC_POLARITY_POSITIVE :
-			    		OPENPIC_POLARITY_NEGATIVE) |
-				(sense ? OPENPIC_SENSE_LEVEL : OPENPIC_SENSE_EDGE));
-}
-
-/*
- *  Map an interrupt source to one or more CPUs
- */
-static void openpic_mapirq(u_int irq, u_int physmask)
-{
-	openpic_write(&GET_ISU(irq).Destination, physmask);
-}
-
-/*
- *  Set the sense for an interrupt source (and disable it!)
- *
- *  sense: 1 for level, 0 for edge
- */
-#if 0	/* not used */
-static void openpic_set_sense(u_int irq, int sense)
-{
-	openpic_safe_writefield(&GET_ISU(irq).Vector_Priority,
-				OPENPIC_SENSE_LEVEL,
-				(sense ? OPENPIC_SENSE_LEVEL : 0));
-}
-
-static int openpic_get_sense(u_int irq)
-{
-	return openpic_readfield(&GET_ISU(irq).Vector_Priority,
-				 OPENPIC_SENSE_LEVEL) != 0;
-}
-#endif
-
-static void openpic_end_irq(unsigned int irq_nr)
-{
-	openpic_eoi();
-}
-
-static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask)
-{
-	cpumask_t tmp;
-
-	cpus_and(tmp, cpumask, cpu_online_map);
-	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_addr(tmp)[0]));
-}
-
-#ifdef CONFIG_SMP
-static void openpic_end_ipi(unsigned int irq_nr)
-{
-	/*
-	 * IPIs are marked IRQ_PER_CPU. This has the side effect of
-	 * preventing the IRQ_PENDING/IRQ_INPROGRESS logic from
-	 * applying to them. We EOI them late to avoid re-entering.
-	 * We mark IPI's with SA_INTERRUPT as they must run with
-	 * irqs disabled.
-	 */
-	openpic_eoi();
-}
-
-static irqreturn_t openpic_ipi_action(int cpl, void *dev_id,
-					struct pt_regs *regs)
-{
-	smp_message_recv(cpl-openpic_vec_ipi, regs);
-	return IRQ_HANDLED;
-}
-
-#endif /* CONFIG_SMP */
-
-int openpic_get_irq(struct pt_regs *regs)
-{
-	extern int i8259_irq(int cpu);
-
-	int irq = openpic_irq();
-
-        if (open_pic_irq_offset && irq == open_pic_irq_offset) {
-                /*
-                 * This magic address generates a PCI IACK cycle.
-                 */
-		if ( chrp_int_ack_special )
-			irq = *chrp_int_ack_special;
-		else
-			irq = i8259_irq( smp_processor_id() );
-		openpic_eoi();
-        }
-	if (irq == openpic_vec_spurious)
-		irq = -1;
-	return irq;
-}
Index: linux-work/arch/ppc64/kernel/open_pic_u3.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/open_pic_u3.c	2004-10-17 12:07:06.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,348 +0,0 @@
-/*
- *  arch/ppc/kernel/open_pic.c -- OpenPIC Interrupt Handling
- *
- *  Copyright (C) 1997 Geert Uytterhoeven
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <asm/ptrace.h>
-#include <asm/signal.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-
-#include <asm/machdep.h>
-
-#include "open_pic.h"
-#include "open_pic_defs.h"
-
-void* OpenPIC2_Addr;
-static volatile struct OpenPIC *OpenPIC2 = NULL;
-
-extern u_int OpenPIC_NumInitSenses;
-extern u_char *OpenPIC_InitSenses;
-
-static u_int NumSources;
-static int NumISUs;
-static int open_pic2_irq_offset;
-
-static OpenPIC_SourcePtr ISU2[OPENPIC_MAX_ISU];
-
-unsigned int openpic2_vec_spurious;
-
-/*
- *  Accesses to the current processor's openpic registers
- *  U3 secondary openpic has only one output
- */
-#define THIS_CPU		Processor[0]
-#define DECL_THIS_CPU
-#define CHECK_THIS_CPU
-
-#define GET_ISU(source)	ISU2[(source) >> 4][(source) & 0xf]
-
-static inline u_int openpic2_read(volatile u_int *addr)
-{
-	u_int val;
-
-	val = in_be32(addr);
-	return val;
-}
-
-static inline void openpic2_write(volatile u_int *addr, u_int val)
-{
-	out_be32(addr, val);
-}
-
-static inline u_int openpic2_readfield(volatile u_int *addr, u_int mask)
-{
-	u_int val = openpic2_read(addr);
-	return val & mask;
-}
-
-static inline void openpic2_writefield(volatile u_int *addr, u_int mask,
-			       u_int field)
-{
-	u_int val = openpic2_read(addr);
-	openpic2_write(addr, (val & ~mask) | (field & mask));
-}
-
-static inline void openpic2_clearfield(volatile u_int *addr, u_int mask)
-{
-	openpic2_writefield(addr, mask, 0);
-}
-
-static inline void openpic2_setfield(volatile u_int *addr, u_int mask)
-{
-	openpic2_writefield(addr, mask, mask);
-}
-
-static void openpic2_safe_writefield(volatile u_int *addr, u_int mask,
-				    u_int field)
-{
-	unsigned int loops = 100000;
-
-	openpic2_setfield(addr, OPENPIC_MASK);
-	while (openpic2_read(addr) & OPENPIC_ACTIVITY) {
-		if (!loops--) {
-			printk(KERN_ERR "openpic2_safe_writefield timeout\n");
-			break;
-		}
-	}
-	openpic2_writefield(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
-}
-
-
-static inline void openpic2_reset(void)
-{
-	openpic2_setfield(&OpenPIC2->Global.Global_Configuration0,
-			 OPENPIC_CONFIG_RESET);
-}
-
-static void openpic2_disable_8259_pass_through(void)
-{
-	openpic2_setfield(&OpenPIC2->Global.Global_Configuration0,
-			 OPENPIC_CONFIG_8259_PASSTHROUGH_DISABLE);
-}
-
-/*
- *  Find out the current interrupt
- */
-static u_int openpic2_irq(void)
-{
-	u_int vec;
-	DECL_THIS_CPU;
-	CHECK_THIS_CPU;
-	vec = openpic2_readfield(&OpenPIC2->THIS_CPU.Interrupt_Acknowledge,
-				 OPENPIC_VECTOR_MASK);
-	return vec;
-}
-
-static void openpic2_eoi(void)
-{
-	DECL_THIS_CPU;
-	CHECK_THIS_CPU;
-	openpic2_write(&OpenPIC2->THIS_CPU.EOI, 0);
-	/* Handle PCI write posting */
-	(void)openpic2_read(&OpenPIC2->THIS_CPU.EOI);
-}
-
-
-static inline u_int openpic2_get_priority(void)
-{
-	DECL_THIS_CPU;
-	CHECK_THIS_CPU;
-	return openpic2_readfield(&OpenPIC2->THIS_CPU.Current_Task_Priority,
-				  OPENPIC_CURRENT_TASK_PRIORITY_MASK);
-}
-
-static void openpic2_set_priority(u_int pri)
-{
-	DECL_THIS_CPU;
-	CHECK_THIS_CPU;
-	openpic2_writefield(&OpenPIC2->THIS_CPU.Current_Task_Priority,
-			    OPENPIC_CURRENT_TASK_PRIORITY_MASK, pri);
-}
-
-/*
- *  Get/set the spurious vector
- */
-static inline u_int openpic2_get_spurious(void)
-{
-	return openpic2_readfield(&OpenPIC2->Global.Spurious_Vector,
-				  OPENPIC_VECTOR_MASK);
-}
-
-static void openpic2_set_spurious(u_int vec)
-{
-	openpic2_writefield(&OpenPIC2->Global.Spurious_Vector, OPENPIC_VECTOR_MASK,
-			    vec);
-}
-
-/*
- *  Enable/disable an external interrupt source
- *
- *  Externally called, irq is an offseted system-wide interrupt number
- */
-static void openpic2_enable_irq(u_int irq)
-{
-	unsigned int loops = 100000;
-
-	openpic2_clearfield(&GET_ISU(irq - open_pic2_irq_offset).Vector_Priority, OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_enable_irq timeout\n");
-			break;
-		}
-
-		mb(); /* sync is probably useless here */
-	} while(openpic2_readfield(&GET_ISU(irq - open_pic2_irq_offset).Vector_Priority,
-			OPENPIC_MASK));
-}
-
-static void openpic2_disable_irq(u_int irq)
-{
-	u32 vp;
-	unsigned int loops = 100000;
-	
-	openpic2_setfield(&GET_ISU(irq - open_pic2_irq_offset).Vector_Priority,
-			  OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		if (!loops--) {
-			printk(KERN_ERR "openpic_disable_irq timeout\n");
-			break;
-		}
-
-		mb();  /* sync is probably useless here */
-		vp = openpic2_readfield(&GET_ISU(irq - open_pic2_irq_offset).Vector_Priority,
-    			OPENPIC_MASK | OPENPIC_ACTIVITY);
-	} while((vp & OPENPIC_ACTIVITY) && !(vp & OPENPIC_MASK));
-}
-
-/*
- *  Initialize an interrupt source (and disable it!)
- *
- *  irq: OpenPIC interrupt number
- *  pri: interrupt source priority
- *  vec: the vector it will produce
- *  pol: polarity (1 for positive, 0 for negative)
- *  sense: 1 for level, 0 for edge
- */
-static void openpic2_initirq(u_int irq, u_int pri, u_int vec, int pol, int sense)
-{
-	openpic2_safe_writefield(&GET_ISU(irq).Vector_Priority,
-				 OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK |
-				 OPENPIC_SENSE_MASK | OPENPIC_POLARITY_MASK,
-				 (pri << OPENPIC_PRIORITY_SHIFT) | vec |
-				 (pol ? OPENPIC_POLARITY_POSITIVE :
-				  OPENPIC_POLARITY_NEGATIVE) |
-				 (sense ? OPENPIC_SENSE_LEVEL : OPENPIC_SENSE_EDGE));
-}
-
-/*
- *  Map an interrupt source to one or more CPUs
- */
-static void openpic2_mapirq(u_int irq, u_int physmask)
-{
-	openpic2_write(&GET_ISU(irq).Destination, physmask);
-}
-
-/*
- *  Set the sense for an interrupt source (and disable it!)
- *
- *  sense: 1 for level, 0 for edge
- */
-static inline void openpic2_set_sense(u_int irq, int sense)
-{
-	openpic2_safe_writefield(&GET_ISU(irq).Vector_Priority,
-				 OPENPIC_SENSE_LEVEL,
-				 (sense ? OPENPIC_SENSE_LEVEL : 0));
-}
-
-static void openpic2_end_irq(unsigned int irq_nr)
-{
-	openpic2_eoi();
-}
-
-int openpic2_get_irq(struct pt_regs *regs)
-{
-	int irq = openpic2_irq();
-
-	if (irq == openpic2_vec_spurious)
-		return -1;
-	return irq + open_pic2_irq_offset;
-}
-
-struct hw_interrupt_type open_pic2 = {
-	" OpenPIC2 ",
-	NULL,
-	NULL,
-	openpic2_enable_irq,
-	openpic2_disable_irq,
-	NULL,
-	openpic2_end_irq,
-};
-
-void __init openpic2_init(int offset)
-{
-	u_int t, i;
-	const char *version;
-
-	if (!OpenPIC2_Addr) {
-		printk(KERN_INFO "No OpenPIC2 found !\n");
-		return;
-	}
-	OpenPIC2 = (volatile struct OpenPIC *)OpenPIC2_Addr;
-
-	ppc64_boot_msg(0x20, "OpenPic U3 Init");
-
-	t = openpic2_read(&OpenPIC2->Global.Feature_Reporting0);
-	switch (t & OPENPIC_FEATURE_VERSION_MASK) {
-	case 1:
-		version = "1.0";
-		break;
-	case 2:
-		version = "1.2";
-		break;
-	case 3:
-		version = "1.3";
-		break;
-	default:
-		version = "?";
-		break;
-	}
-	printk(KERN_INFO "OpenPIC (U3) Version %s\n", version);
-
-	open_pic2_irq_offset = offset;
-
-	for (i=0; i<128; i+=0x10) {
-		ISU2[i>>4] = &((struct OpenPIC *)OpenPIC2_Addr)->Source[i];
-		NumISUs++;
-	}
-	NumSources = NumISUs * 0x10;
-	openpic2_vec_spurious = NumSources;
-
-	openpic2_set_priority(0xf);
-
-	/* Init all external sources */
-	for (i = 0; i < NumSources; i++) {
-		int pri, sense;
-
-		/* the bootloader may have left it enabled (bad !) */
-		openpic2_disable_irq(i+offset);
-
-		pri = 8;
-		sense = (i < OpenPIC_NumInitSenses) ? OpenPIC_InitSenses[i]: 1;
-		if (sense)
-			irq_desc[i+offset].status = IRQ_LEVEL;
-
-		/* Enabled, Priority 8 or 9 */
-		openpic2_initirq(i, pri, i, !sense, sense);
-		/* Processor 0 */
-		openpic2_mapirq(i, 0x1);
-	}
-
-	/* Init descriptors */
-	for (i = offset; i < NumSources + offset; i++)
-		irq_desc[i].handler = &open_pic2;
-
-	/* Initialize the spurious interrupt */
-	openpic2_set_spurious(openpic2_vec_spurious);
-
-	openpic2_set_priority(0);
-	openpic2_disable_8259_pass_through();
-
-	ppc64_boot_msg(0x25, "OpenPic U3 Done");
-}
Index: linux-work/arch/ppc64/kernel/open_pic.h
===================================================================
--- linux-work.orig/arch/ppc64/kernel/open_pic.h	2004-10-17 12:07:05.000000000 +1000
+++ /dev/null1970-01-01 00:00:00.000000000 +0000
@@ -1,42 +0,0 @@
-/*
- *  arch/ppc/kernel/open_pic.h -- OpenPIC Interrupt Handling
- *
- *  Copyright (C) 1997 Geert Uytterhoeven
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive
- *  for more details.
- *  
- */
-
-#ifndef _PPC64_KERNEL_OPEN_PIC_H
-#define _PPC64_KERNEL_OPEN_PIC_H
-
-#include <linux/config.h>
-#include <linux/cpumask.h>
-#include <linux/irq.h>
-
-#define OPENPIC_SIZE	0x40000
-
-/* OpenPIC IRQ controller structure */
-extern struct hw_interrupt_type open_pic;
-
-/* OpenPIC IPI controller structure */
-#ifdef CONFIG_SMP
-extern struct hw_interrupt_type open_pic_ipi;
-#endif /* CONFIG_SMP */
-
-extern u_int OpenPIC_NumInitSenses;
-extern u_char *OpenPIC_InitSenses;
-extern void* OpenPIC_Addr;
-
-/* Exported functions */
-extern void openpic_init(int, int, unsigned char *, int);
-extern void openpic_request_IPIs(void);
-extern void do_openpic_setup_cpu(void);
-extern int openpic_get_irq(struct pt_regs *regs);
-extern void openpic_init_processor(u_int cpumask);
-extern void openpic_setup_ISU(int isu_num, unsigned long addr);
-extern void openpic_cause_IPI(u_int ipi, u_int cpumask);
-
-#endif /* _PPC64_KERNEL_OPEN_PIC_H */
Index: linux-work/include/asm-ppc64/smp.h
===================================================================
--- linux-work.orig/include/asm-ppc64/smp.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-ppc64/smp.h	2004-10-23 11:44:03.024687184 +1000
@@ -67,6 +67,10 @@
 
 extern int smt_enabled_at_boot;
 
+extern int smp_mpic_probe(void);
+extern void smp_mpic_setup_cpu(int cpu);
+extern void smp_mpic_message_pass(int target, int msg);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* !(_PPC64_SMP_H) */
Index: linux-work/arch/ppc64/kernel/pSeries_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_pci.c	2004-10-23 11:43:59.660198664 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_pci.c	2004-10-23 11:44:03.026686880 +1000
@@ -42,7 +42,7 @@
 #include <asm/iommu.h>
 #include <asm/rtas.h>
 
-#include "open_pic.h"
+#include "mpic.h"
 #include "pci.h"
 
 /* RTAS tokens */
@@ -54,6 +54,7 @@
 static int s7a_workaround;
 
 extern unsigned long pci_probe_only;
+extern struct mpic *pSeries_mpic;
 
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
@@ -399,9 +400,9 @@
 		pci_process_bridge_OF_ranges(phb, node);
 		pci_setup_phb_io(phb, index == 0);
 
-		if (naca->interrupt_controller == IC_OPEN_PIC) {
+		if (naca->interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
 			int addr = root_size_cells * (index + 2) - 1;
-			openpic_setup_ISU(index, opprop[addr]); 
+			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
 		}
 
 		index++;
Index: linux-work/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2004-10-23 08:45:23.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom_init.c	2004-10-23 11:44:03.028686576 +1000
@@ -51,7 +51,6 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
-#include "open_pic.h"
 
 #ifdef CONFIG_LOGO_LINUX_CLUT224
 #include <linux/linux_logo.h>
Index: linux-work/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_setup.c	2004-10-23 11:43:59.651200032 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_setup.c	2004-10-23 11:44:03.029686424 +1000
@@ -61,19 +61,18 @@
 #include <asm/nvram.h>
 
 #include "i8259.h"
-#include "open_pic.h"
 #include <asm/xics.h>
 #include <asm/ppcdebug.h>
 #include <asm/cputable.h>
 
+#include "mpic.h"
+
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
 #define DBG(fmt...)
 #endif
 
-extern void pSeries_init_openpic(void);
-
 extern void find_and_init_phbs(void);
 extern void pSeries_final_fixup(void);
 
@@ -93,6 +92,9 @@
 extern unsigned long ppc_proc_freq;
 extern unsigned long ppc_tb_freq;
 
+static volatile void __iomem * chrp_int_ack_special;
+struct mpic *pSeries_mpic;
+
 void pSeries_get_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -122,15 +124,86 @@
 		fwnmi_active = 1;
 }
 
-static void __init pSeries_setup_arch(void)
+static int pSeries_irq_cascade(struct pt_regs *regs, void *data)
+{
+	if (chrp_int_ack_special)
+		return readb(chrp_int_ack_special);
+	else
+		return i8259_irq(smp_processor_id());
+}
+
+static void __init pSeries_init_mpic(void)
+{
+        unsigned int *addrp;
+        unsigned char* chrp_int_ack_special = NULL;
+	struct device_node *np;
+        int i;
+
+	/* All ISUs are setup, complete initialization */
+	mpic_init(pSeries_mpic);
+
+	/* Check what kind of cascade ACK we have */
+        if (!(np = of_find_node_by_name(NULL, "pci"))
+            || !(addrp = (unsigned int *)
+                 get_property(np, "8259-interrupt-acknowledge", NULL)))
+                printk(KERN_ERR "Cannot find pci to get ack address\n");
+        else
+		chrp_int_ack_special = (unsigned char *) 
+			ioremap(addrp[prom_n_addr_cells(np)-1], 1);
+	of_node_put(np);
+
+	/* Setup the legacy interrupts & controller */
+        for (i = 0; i < NUM_ISA_INTERRUPTS; i++)
+                irq_desc[i].handler = &i8259_pic;
+	i8259_init(0);
+
+	/* Hook cascade to mpic */
+	mpic_setup_cascade(NUM_ISA_INTERRUPTS, pSeries_irq_cascade, NULL);
+}
+
+static void __init pSeries_setup_mpic(void)
 {
-	struct device_node *root;
 	unsigned int *opprop;
+	unsigned long openpic_addr = 0;
+        unsigned char senses[NR_IRQS - NUM_ISA_INTERRUPTS];
+        struct device_node *root;
+	int irq_count;
+
+	/* Find the Open PIC if present */
+	root = of_find_node_by_path("/");
+	opprop = (unsigned int *) get_property(root, "platform-open-pic", NULL);
+	if (opprop != 0) {
+		int n = prom_n_addr_cells(root);
+
+		for (openpic_addr = 0; n > 0; --n)
+			openpic_addr = (openpic_addr << 32) + *opprop++;
+		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
+	}
+	of_node_put(root);
 
+	BUG_ON(openpic_addr == 0);
+
+	/* Get the sense values from OF */
+	prom_get_irq_senses(senses, NUM_ISA_INTERRUPTS, NR_IRQS);
+	
+	/* Setup the openpic driver */
+	irq_count = NR_IRQS - NUM_ISA_INTERRUPTS - 4; /* leave room for IPIs */
+	pSeries_mpic = mpic_alloc(openpic_addr, MPIC_PRIMARY,
+				  16, 16, irq_count, /* isu size, irq offset, irq count */ 
+				  NR_IRQS - 4, /* ipi offset */
+				  senses, irq_count, /* sense & sense size */
+				  " MPIC     ");
+}
+
+static void __init pSeries_setup_arch(void)
+{
 	/* Fixup ppc_md depending on the type of interrupt controller */
 	if (naca->interrupt_controller == IC_OPEN_PIC) {
-		ppc_md.init_IRQ       = pSeries_init_openpic; 
-		ppc_md.get_irq        = openpic_get_irq;
+		ppc_md.init_IRQ       = pSeries_init_mpic; 
+		ppc_md.get_irq        = mpic_get_irq;
+		/* Allocate the mpic now, so that find_and_init_phbs() can
+		 * fill the ISUs */
+		pSeries_setup_mpic();
 	} else {
 		ppc_md.init_IRQ       = xics_init_IRQ;
 		ppc_md.get_irq        = xics_get_irq;
@@ -158,21 +231,6 @@
 	eeh_init();
 	find_and_init_phbs();
 
-	/* Find the Open PIC if present */
-	root = of_find_node_by_path("/");
-	opprop = (unsigned int *) get_property(root,
-				"platform-open-pic", NULL);
-	if (opprop != 0) {
-		int n = prom_n_addr_cells(root);
-		unsigned long openpic;
-
-		for (openpic = 0; n > 0; --n)
-			openpic = (openpic << 32) + *opprop++;
-		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic);
-		OpenPIC_Addr = __ioremap(openpic, 0x40000, _PAGE_NO_CACHE);
-	}
-	of_node_put(root);
-
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
Index: linux-work/arch/ppc64/kernel/pmac_smp.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_smp.c	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac_smp.c	2004-10-23 11:47:24.420070432 +1000
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/irq.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -48,14 +49,13 @@
 #include <asm/cacheflush.h>
 #include <asm/keylargo.h>
 
-#include "open_pic.h"
+#include "mpic.h"
+
 
 extern void pmac_secondary_start_1(void);
 extern void pmac_secondary_start_2(void);
 extern void pmac_secondary_start_3(void);
 
-extern void smp_openpic_message_pass(int target, int msg);
-
 extern struct smp_ops_t *smp_ops;
 
 static int __init smp_core99_probe(void)
@@ -75,7 +75,7 @@
 	printk(KERN_INFO "PowerMac SMP probe found %d cpus\n", ncpus);
 
 	if (ncpus > 1)
-		openpic_request_IPIs();
+		mpic_request_ipis();
 
 	return ncpus;
 }
@@ -138,8 +138,8 @@
 
 static void __init smp_core99_setup_cpu(int cpu_nr)
 {
-	/* Setup openpic */
-	do_openpic_setup_cpu();
+	/* Setup MPIC */
+	mpic_setup_this_cpu();
 
 	if (cpu_nr == 0) {
 		extern void g5_phy_disable_cpu1(void);
@@ -157,7 +157,7 @@
 extern void smp_generic_take_timebase(void);
 
 struct smp_ops_t core99_smp_ops __pmacdata = {
-	.message_pass	= smp_openpic_message_pass,
+	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
 	.kick_cpu	= smp_core99_kick_cpu,
 	.setup_cpu	= smp_core99_setup_cpu,
Index: linux-work/arch/ppc64/kernel/prom.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom.c	2004-10-23 11:44:03.032685968 +1000
@@ -52,7 +52,6 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
-#include "open_pic.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1092,8 +1091,7 @@
  * Work out the sense (active-low level / active-high edge)
  * of each interrupt from the device tree.
  */
-void __init
-prom_get_irq_senses(unsigned char *senses, int off, int max)
+void __init prom_get_irq_senses(unsigned char *senses, int off, int max)
 {
 	struct device_node *np;
 	int i, j;
@@ -1105,7 +1103,9 @@
 		for (j = 0; j < np->n_intrs; j++) {
 			i = np->intrs[j].line;
 			if (i >= off && i < max)
-				senses[i-off] = np->intrs[j].sense;
+				senses[i-off] = np->intrs[j].sense ?
+					IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE :
+					IRQ_SENSE_EDGE | IRQ_POLARITY_POSITIVE;
 		}
 	}
 }
Index: linux-work/arch/ppc64/kernel/pmac_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_setup.c	2004-10-23 11:43:59.652199880 +1000
+++ linux-work/arch/ppc64/kernel/pmac_setup.c	2004-10-23 11:44:03.034685664 +1000
@@ -72,6 +72,7 @@
 #include <asm/lmb.h>
 
 #include "pmac.h"
+#include "mpic.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -319,29 +320,9 @@
 	DBG(" <- pmac_init_early\n");
 }
 
-extern void* OpenPIC_Addr;
-extern void* OpenPIC2_Addr;
-extern u_int OpenPIC_NumInitSenses;
-extern u_char *OpenPIC_InitSenses;
-extern void openpic_init(int main_pic, int offset, unsigned char* chrp_ack,
-			 int programmer_switch_irq);
-extern void openpic2_init(int offset);
-extern int openpic_get_irq(struct pt_regs *regs);
-extern int openpic2_get_irq(struct pt_regs *regs);
-
-static int pmac_cascade_irq = -1;
-
-static irqreturn_t pmac_u3_do_cascade(int cpl, void *dev_id, struct pt_regs *regs)
-{
-	int irq;
-
-	for (;;) {
-		irq = openpic2_get_irq(regs);
-		if (irq == -1)
-			break;
-		ppc_irq_dispatch_handler(regs, irq);
-	}
-	return IRQ_HANDLED;
+static int pmac_u3_cascade(struct pt_regs *regs, void *data)
+{
+	return mpic_get_one_irq((struct mpic *)data, regs);
 }
 
 static __init void pmac_init_IRQ(void)
@@ -349,6 +330,7 @@
         struct device_node *irqctrler  = NULL;
         struct device_node *irqctrler2 = NULL;
 	struct device_node *np = NULL;
+	struct mpic *mpic1, *mpic2;
 
 	/* We first try to detect Apple's new Core99 chipset, since mac-io
 	 * is quite different on those machines and contains an IBM MPIC2.
@@ -368,44 +350,37 @@
 		       (unsigned int)irqctrler->addrs[0].address);
 
 		prom_get_irq_senses(senses, 0, 128);
-		OpenPIC_InitSenses = senses;
-		OpenPIC_NumInitSenses = 128;
-		OpenPIC_Addr = ioremap(irqctrler->addrs[0].address,
-				       irqctrler->addrs[0].size);
-		openpic_init(1, 0, NULL, -1);
+		mpic1 = mpic_alloc(irqctrler->addrs[0].address,
+				   MPIC_PRIMARY | MPIC_WANTS_RESET,
+				   0, 0, 128, 256, senses, 128, " K2-MPIC  ");
+		BUG_ON(mpic1 == NULL);
+		mpic_init(mpic1);		
 
 		if (irqctrler2 != NULL && irqctrler2->n_intrs > 0 &&
 		    irqctrler2->n_addrs > 0) {
 			printk(KERN_INFO "Slave OpenPIC at 0x%08x hooked on IRQ %d\n",
 			       (u32)irqctrler2->addrs[0].address,
 			       irqctrler2->intrs[0].line);
+
 			pmac_call_feature(PMAC_FTR_ENABLE_MPIC, irqctrler2, 0, 0);
-			OpenPIC2_Addr = ioremap(irqctrler2->addrs[0].address,
-						irqctrler2->addrs[0].size);
 			prom_get_irq_senses(senses, 128, 128 + 128);
-			OpenPIC_InitSenses = senses;
-			OpenPIC_NumInitSenses = 128;
-			openpic2_init(128);
-			pmac_cascade_irq = irqctrler2->intrs[0].line;
+
+			/* We don't need to set MPIC_BROKEN_U3 here since we don't have
+			 * hypertransport interrupts routed to it
+			 */
+			mpic2 = mpic_alloc(irqctrler2->addrs[0].address,
+					   MPIC_BIG_ENDIAN | MPIC_WANTS_RESET,
+					   0, 128, 128, 0, senses, 128, " U3-MPIC  ");
+			BUG_ON(mpic2 == NULL);
+			mpic_init(mpic2);
+			mpic_setup_cascade(irqctrler2->intrs[0].line,
+					   pmac_u3_cascade, mpic2);
 		}
 	}
 	of_node_put(irqctrler);
 	of_node_put(irqctrler2);
 }
 
-/* We cannot do request_irq too early ... Right now, we get the
- * cascade as a core_initcall, which should be fine for our needs
- */
-static int __init pmac_irq_cascade_init(void)
-{
-	if (request_irq(pmac_cascade_irq, pmac_u3_do_cascade, 0,
-			"U3->K2 Cascade", NULL))
-		printk(KERN_ERR "Unable to get OpenPIC IRQ for cascade\n");
-	return 0;
-}
-
-core_initcall(pmac_irq_cascade_init);
-
 static void __init pmac_progress(char *s, unsigned short hex)
 {
 	if (sccdbg) {
@@ -472,7 +447,7 @@
 	.init_early		= pmac_init_early,
        	.get_cpuinfo		= pmac_show_cpuinfo,
 	.init_IRQ		= pmac_init_IRQ,
-	.get_irq		= openpic_get_irq,
+	.get_irq		= mpic_get_irq,
 	.pcibios_fixup		= pmac_pcibios_fixup,
 	.restart		= pmac_restart,
 	.power_off		= pmac_power_off,
Index: linux-work/arch/ppc64/kernel/smp.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/smp.c	2004-10-23 11:43:59.760183464 +1000
+++ linux-work/arch/ppc64/kernel/smp.c	2004-10-23 11:44:03.035685512 +1000
@@ -48,11 +48,12 @@
 #include <asm/iSeries/HvCallCfg.h>
 #include <asm/time.h>
 #include <asm/ppcdebug.h>
-#include "open_pic.h"
 #include <asm/machdep.h>
 #include <asm/xics.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
+
+#include "mpic.h"
 #include <asm/rtas.h>
 #include <asm/plpar_wrappers.h>
 
@@ -194,7 +195,7 @@
 #endif
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-void smp_openpic_message_pass(int target, int msg)
+void smp_mpic_message_pass(int target, int msg)
 {
 	/* make sure we're sending something that translates to an IPI */
 	if ( msg > 0x3 ){
@@ -205,33 +206,36 @@
 	switch ( target )
 	{
 	case MSG_ALL:
-		openpic_cause_IPI(msg, 0xffffffff);
+		mpic_send_ipi(msg, 0xffffffff);
 		break;
 	case MSG_ALL_BUT_SELF:
-		openpic_cause_IPI(msg,
-				  0xffffffff & ~(1 << smp_processor_id()));
+		mpic_send_ipi(msg, 0xffffffff & ~(1 << smp_processor_id()));
 		break;
 	default:
-		openpic_cause_IPI(msg, 1<<target);
+		mpic_send_ipi(msg, 1 << target);
 		break;
 	}
 }
 
-static int __init smp_openpic_probe(void)
+int __init smp_mpic_probe(void)
 {
 	int nr_cpus;
 
+	DBG("smp_mpic_probe()...\n");
+
 	nr_cpus = cpus_weight(cpu_possible_map);
 
+	DBG("nr_cpus: %d\n", nr_cpus);
+
 	if (nr_cpus > 1)
-		openpic_request_IPIs();
+		mpic_request_ipis();
 
 	return nr_cpus;
 }
 
-static void __devinit smp_openpic_setup_cpu(int cpu)
+void __devinit smp_mpic_setup_cpu(int cpu)
 {
-	do_openpic_setup_cpu();
+	mpic_setup_this_cpu();
 }
 
 #endif /* CONFIG_PPC_MULTIPLATFORM */
@@ -532,11 +536,11 @@
 	spin_unlock(&timebase_lock);
 }
 
-static struct smp_ops_t pSeries_openpic_smp_ops = {
-	.message_pass	= smp_openpic_message_pass,
-	.probe		= smp_openpic_probe,
+static struct smp_ops_t pSeries_mpic_smp_ops = {
+	.message_pass	= smp_mpic_message_pass,
+	.probe		= smp_mpic_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_openpic_setup_cpu,
+	.setup_cpu	= smp_mpic_setup_cpu,
 };
 
 static struct smp_ops_t pSeries_xics_smp_ops = {
@@ -554,7 +558,7 @@
 	DBG(" -> smp_init_pSeries()\n");
 
 	if (naca->interrupt_controller == IC_OPEN_PIC)
-		smp_ops = &pSeries_openpic_smp_ops;
+		smp_ops = &pSeries_mpic_smp_ops;
 	else
 		smp_ops = &pSeries_xics_smp_ops;
 
Index: linux-work/arch/ppc64/kernel/i8259.h
===================================================================
--- linux-work.orig/arch/ppc64/kernel/i8259.h	2004-10-17 12:07:05.000000000 +1000
+++ linux-work/arch/ppc64/kernel/i8259.h	2004-10-23 11:44:03.035685512 +1000
@@ -11,7 +11,7 @@
 
 extern struct hw_interrupt_type i8259_pic;
 
-void i8259_init(void);
-int i8259_irq(int);
+extern void i8259_init(int offset);
+extern int i8259_irq(int);
 
 #endif /* _PPC_KERNEL_i8259_H */
Index: linux-work/arch/ppc64/kernel/i8259.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/i8259.c	2004-10-17 12:07:05.000000000 +1000
+++ linux-work/arch/ppc64/kernel/i8259.c	2004-10-23 11:44:03.036685360 +1000
@@ -23,7 +23,8 @@
 
 static spinlock_t i8259_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
-int i8259_pic_irq_offset;
+static int i8259_pic_irq_offset;
+static int i8259_present;
 
 int i8259_irq(int cpu)
 {
@@ -140,11 +141,13 @@
         NULL
 };
 
-void __init i8259_init(void)
+void __init i8259_init(int offset)
 {
 	unsigned long flags;
 	
 	spin_lock_irqsave(&i8259_lock, flags);
+	i8259_pic_irq_offset = offset;
+	i8259_present = 1;
         /* init master interrupt controller */
         outb(0x11, 0x20); /* Start init sequence */
         outb(0x00, 0x21); /* Vector base */
@@ -160,7 +163,18 @@
         outb(cached_A1, 0xA1);
         outb(cached_21, 0x21);
 	spin_unlock_irqrestore(&i8259_lock, flags);
+        
+}
+
+static int i8259_request_cascade(void)
+{
+	if (!i8259_present)
+		return -ENODEV;
+
         request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
                      "82c59 secondary cascade", NULL );
-        
+
+	return 0;
 }
+
+arch_initcall(i8259_request_cascade);
Index: linux-work/arch/ppc64/kernel/xics.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/xics.c	2004-10-22 10:35:46.000000000 +1000
+++ linux-work/arch/ppc64/kernel/xics.c	2004-10-23 11:44:03.037685208 +1000
@@ -578,7 +578,7 @@
 				no_action, 0, "8259 cascade", NULL))
 			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
 					"cascade\n");
-		i8259_init();
+		i8259_init(0);
 	}
 	return 0;
 }


