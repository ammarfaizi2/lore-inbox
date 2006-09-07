Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWIGNjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWIGNjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWIGNjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:39:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751478AbWIGNjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:39:41 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Use the generic IRQ stuff
Date: Thu, 07 Sep 2006 14:38:45 +0100
To: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060907133845.5031.87111.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make the FRV arch use the generic IRQ code rather than having its own routines
for doing so.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/Kconfig                    |    8 
 arch/frv/kernel/Makefile            |    5 
 arch/frv/kernel/irq-mb93091.c       |  157 +++++--
 arch/frv/kernel/irq-mb93093.c       |  115 +++--
 arch/frv/kernel/irq-mb93493.c       |  167 +++++---
 arch/frv/kernel/irq-routing.c       |  291 --------------
 arch/frv/kernel/irq.c               |  750 +++++------------------------------
 arch/frv/kernel/setup.c             |    1 
 arch/frv/kernel/time.c              |    1 
 arch/frv/mb93090-mb00/pci-irq.c     |    1 
 include/asm-frv/cpu-irqs.h          |   54 +--
 include/asm-frv/hardirq.h           |    5 
 include/asm-frv/irq-routing.h       |   70 ---
 include/asm-frv/irq.h               |   26 -
 include/asm-frv/mb93091-fpga-irqs.h |    6 
 include/asm-frv/mb93093-fpga-irqs.h |    6 
 include/asm-frv/mb93493-irqs.h      |    6 
 include/asm-frv/mb93493-regs.h      |    2 
 18 files changed, 450 insertions(+), 1221 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 5e6583a..130fe8f 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -27,7 +27,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_HARDIRQS
 	bool
-	default n
+	default y
 
 config GENERIC_TIME
 	bool
@@ -259,6 +259,12 @@ config MB93091_NO_MB
 endchoice
 endif
 
+config FUJITSU_MB93493
+	bool "MB93493 Multimedia chip"
+	help
+	  Select this option if the MB93493 multimedia chip is going to be
+	  used.
+
 choice
 	prompt "GP-Relative data support"
 	default GPREL_DATA_8
diff --git a/arch/frv/kernel/Makefile b/arch/frv/kernel/Makefile
index 91d380a..7c10cce 100644
--- a/arch/frv/kernel/Makefile
+++ b/arch/frv/kernel/Makefile
@@ -10,15 +10,14 @@ extra-y:= head.o init_task.o vmlinux.lds
 obj-y := $(heads-y) entry.o entry-table.o break.o switch_to.o kernel_thread.o \
 	 process.o traps.o ptrace.o signal.o dma.o \
 	 sys_frv.o time.o semaphore.o setup.o frv_ksyms.o \
-	 debug-stub.o irq.o irq-routing.o sleep.o uaccess.o atomic-ops.o
+	 debug-stub.o irq.o sleep.o uaccess.o atomic-ops.o
 
 obj-$(CONFIG_GDBSTUB)		+= gdb-stub.o gdb-io.o
 
 obj-$(CONFIG_MB93091_VDK)	+= irq-mb93091.o
-obj-$(CONFIG_MB93093_PDK)	+= irq-mb93093.o
-obj-$(CONFIG_FUJITSU_MB93493)	+= irq-mb93493.o
 obj-$(CONFIG_PM)		+= pm.o cmode.o
 obj-$(CONFIG_MB93093_PDK)	+= pm-mb93093.o
+obj-$(CONFIG_FUJITSU_MB93493)	+= irq-mb93493.o
 obj-$(CONFIG_SYSCTL)		+= sysctl.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/frv/kernel/irq-mb93091.c b/arch/frv/kernel/irq-mb93091.c
index 1381abc..635d234 100644
--- a/arch/frv/kernel/irq-mb93091.c
+++ b/arch/frv/kernel/irq-mb93091.c
@@ -24,7 +24,6 @@ #include <asm/bitops.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/irc-regs.h>
-#include <asm/irq-routing.h>
 
 #define __reg16(ADDR) (*(volatile unsigned short *)(ADDR))
 
@@ -33,83 +32,129 @@ #define __set_IMR(M)	do { __reg16(0xffc0
 #define __get_IFR()	({ __reg16(0xffc0000c); })
 #define __clr_IFR(M)	do { __reg16(0xffc0000c) = ~(M); wmb(); } while(0)
 
-static void frv_fpga_doirq(struct irq_source *source);
-static void frv_fpga_control(struct irq_group *group, int irq, int on);
 
-/*****************************************************************************/
 /*
- * FPGA IRQ multiplexor
+ * on-motherboard FPGA PIC operations
  */
-static struct irq_source frv_fpga[4] = {
-#define __FPGA(X, M)					\
-	[X] = {						\
-		.muxname	= "fpga."#X,		\
-		.irqmask	= M,			\
-		.doirq		= frv_fpga_doirq,	\
-	}
+static void frv_fpga_enable(unsigned int irq)
+{
+	uint16_t imr = __get_IMR();
 
-	__FPGA(0, 0x0028),
-	__FPGA(1, 0x0050),
-	__FPGA(2, 0x1c00),
-	__FPGA(3, 0x6386),
-};
-
-static struct irq_group frv_fpga_irqs = {
-	.first_irq	= IRQ_BASE_FPGA,
-	.control	= frv_fpga_control,
-	.sources = {
-		[ 1] = &frv_fpga[3],
-		[ 2] = &frv_fpga[3],
-		[ 3] = &frv_fpga[0],
-		[ 4] = &frv_fpga[1],
-		[ 5] = &frv_fpga[0],
-		[ 6] = &frv_fpga[1],
-		[ 7] = &frv_fpga[3],
-		[ 8] = &frv_fpga[3],
-		[ 9] = &frv_fpga[3],
-		[10] = &frv_fpga[2],
-		[11] = &frv_fpga[2],
-		[12] = &frv_fpga[2],
-		[13] = &frv_fpga[3],
-		[14] = &frv_fpga[3],
-	},
-};
+	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
 
+	__set_IMR(imr);
+}
 
-static void frv_fpga_control(struct irq_group *group, int index, int on)
+static void frv_fpga_disable(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
-	if (on)
-		imr &= ~(1 << index);
-	else
-		imr |= 1 << index;
+	imr |= 1 << (irq - IRQ_BASE_FPGA);
 
 	__set_IMR(imr);
 }
 
-static void frv_fpga_doirq(struct irq_source *source)
+static void frv_fpga_ack(unsigned int irq)
+{
+	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
+}
+
+static void frv_fpga_end(unsigned int irq)
+{
+}
+
+static struct irq_chip frv_fpga_pic = {
+	.name		= "mb93091",
+	.enable		= frv_fpga_enable,
+	.disable	= frv_fpga_disable,
+	.ack		= frv_fpga_ack,
+	.mask		= frv_fpga_disable,
+	.unmask		= frv_fpga_enable,
+	.end		= frv_fpga_end,
+};
+
+/*
+ * FPGA PIC interrupt handler
+ */
+static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
 {
-	uint16_t mask, imr;
+	uint16_t imr, mask = (unsigned long) _mask;
+	irqreturn_t iret = 0;
 
 	imr = __get_IMR();
-	mask = source->irqmask & ~imr & __get_IFR();
-	if (mask) {
-		__set_IMR(imr | mask);
-		__clr_IFR(mask);
-		distribute_irqs(&frv_fpga_irqs, mask);
-		__set_IMR(imr);
+	mask = mask & ~imr & __get_IFR();
+
+	/* poll all the triggered IRQs */
+	while (mask) {
+		int irq;
+
+		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(mask));
+		irq = 31 - irq;
+		mask &= ~(1 << irq);
+
+		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
+			iret |= IRQ_HANDLED;
 	}
+
+	return iret;
 }
 
+/*
+ * define an interrupt action for each FPGA PIC output
+ * - use dev_id to indicate the FPGA PIC input to output mappings
+ */
+static struct irqaction fpga_irq[4]  = {
+	[0] = {
+		.handler	= fpga_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "fpga.0",
+		.dev_id		= (void *) 0x0028UL,
+	},
+	[1] = {
+		.handler	= fpga_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "fpga.1",
+		.dev_id		= (void *) 0x0050UL,
+	},
+	[2] = {
+		.handler	= fpga_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "fpga.2",
+		.dev_id		= (void *) 0x1c00UL,
+	},
+	[3] = {
+		.handler	= fpga_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "fpga.3",
+		.dev_id		= (void *) 0x6386UL,
+	}
+};
+
+/*
+ * initialise the motherboard FPGA's PIC
+ */
 void __init fpga_init(void)
 {
+	int irq;
+
+	/* all PIC inputs are all set to be low-level driven, apart from the
+	 * NMI button (15) which is fixed at falling-edge
+	 */
 	__set_IMR(0x7ffe);
 	__clr_IFR(0x0000);
 
-	frv_irq_route_external(&frv_fpga[0], IRQ_CPU_EXTERNAL0);
-	frv_irq_route_external(&frv_fpga[1], IRQ_CPU_EXTERNAL1);
-	frv_irq_route_external(&frv_fpga[2], IRQ_CPU_EXTERNAL2);
-	frv_irq_route_external(&frv_fpga[3], IRQ_CPU_EXTERNAL3);
-	frv_irq_set_group(&frv_fpga_irqs);
+	for (irq = IRQ_BASE_FPGA + 1; irq <= IRQ_BASE_FPGA + 14; irq++)
+		set_irq_chip_and_handler(irq, &frv_fpga_pic, handle_level_irq);
+
+	set_irq_chip_and_handler(IRQ_FPGA_NMI, &frv_fpga_pic, handle_edge_irq);
+
+	/* the FPGA drives the first four external IRQ inputs on the CPU PIC */
+	setup_irq(IRQ_CPU_EXTERNAL0, &fpga_irq[0]);
+	setup_irq(IRQ_CPU_EXTERNAL1, &fpga_irq[1]);
+	setup_irq(IRQ_CPU_EXTERNAL2, &fpga_irq[2]);
+	setup_irq(IRQ_CPU_EXTERNAL3, &fpga_irq[3]);
 }
diff --git a/arch/frv/kernel/irq-mb93093.c b/arch/frv/kernel/irq-mb93093.c
index 48b2a64..f60db79 100644
--- a/arch/frv/kernel/irq-mb93093.c
+++ b/arch/frv/kernel/irq-mb93093.c
@@ -1,6 +1,6 @@
 /* irq-mb93093.c: MB93093 FPGA interrupt handling
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -24,7 +24,6 @@ #include <asm/bitops.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/irc-regs.h>
-#include <asm/irq-routing.h>
 
 #define __reg16(ADDR) (*(volatile unsigned short *)(__region_CS2 + (ADDR)))
 
@@ -33,66 +32,100 @@ #define __set_IMR(M)	do { __reg16(0x0a) 
 #define __get_IFR()	({ __reg16(0x02); })
 #define __clr_IFR(M)	do { __reg16(0x02) = ~(M); wmb(); } while(0)
 
-static void frv_fpga_doirq(struct irq_source *source);
-static void frv_fpga_control(struct irq_group *group, int irq, int on);
-
-/*****************************************************************************/
 /*
- * FPGA IRQ multiplexor
+ * off-CPU FPGA PIC operations
  */
-static struct irq_source frv_fpga[4] = {
-#define __FPGA(X, M)					\
-	[X] = {						\
-		.muxname	= "fpga."#X,		\
-		.irqmask	= M,			\
-		.doirq		= frv_fpga_doirq,	\
-	}
-
-	__FPGA(0, 0x0700),
-};
+static void frv_fpga_enable(unsigned int irq)
+{
+	uint16_t imr = __get_IMR();
 
-static struct irq_group frv_fpga_irqs = {
-	.first_irq	= IRQ_BASE_FPGA,
-	.control	= frv_fpga_control,
-	.sources = {
-		[ 8] = &frv_fpga[0],
-		[ 9] = &frv_fpga[0],
-		[10] = &frv_fpga[0],
-	},
-};
+	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
 
+	__set_IMR(imr);
+}
 
-static void frv_fpga_control(struct irq_group *group, int index, int on)
+static void frv_fpga_disable(unsigned int irq)
 {
 	uint16_t imr = __get_IMR();
 
-	if (on)
-		imr &= ~(1 << index);
-	else
-		imr |= 1 << index;
+	imr |= 1 << (irq - IRQ_BASE_FPGA);
 
 	__set_IMR(imr);
 }
 
-static void frv_fpga_doirq(struct irq_source *source)
+static void frv_fpga_ack(unsigned int irq)
+{
+	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
+}
+
+static void frv_fpga_end(unsigned int irq)
+{
+}
+
+static struct irq_chip frv_fpga_pic = {
+	.name		= "mb93093",
+	.enable		= frv_fpga_enable,
+	.disable	= frv_fpga_disable,
+	.ack		= frv_fpga_ack,
+	.mask		= frv_fpga_disable,
+	.unmask		= frv_fpga_enable,
+	.end		= frv_fpga_end,
+};
+
+/*
+ * FPGA PIC interrupt handler
+ */
+static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
 {
-	uint16_t mask, imr;
+	uint16_t imr, mask = (unsigned long) _mask;
+	irqreturn_t iret = 0;
 
 	imr = __get_IMR();
-	mask = source->irqmask & ~imr & __get_IFR();
-	if (mask) {
-		__set_IMR(imr | mask);
-		__clr_IFR(mask);
-		distribute_irqs(&frv_fpga_irqs, mask);
-		__set_IMR(imr);
+	mask = mask & ~imr & __get_IFR();
+
+	/* poll all the triggered IRQs */
+	while (mask) {
+		int irq;
+
+		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(mask));
+		irq = 31 - irq;
+		mask &= ~(1 << irq);
+
+		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
+			iret |= IRQ_HANDLED;
 	}
+
+	return iret;
 }
 
+/*
+ * define an interrupt action for each FPGA PIC output
+ * - use dev_id to indicate the FPGA PIC input to output mappings
+ */
+static struct irqaction fpga_irq[1]  = {
+	[0] = {
+		.handler	= fpga_interrupt,
+		.flags		= IRQF_DISABLED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "fpga.0",
+		.dev_id		= (void *) 0x0700UL,
+	}
+};
+
+/*
+ * initialise the motherboard FPGA's PIC
+ */
 void __init fpga_init(void)
 {
+	int irq;
+
+	/* all PIC inputs are all set to be edge triggered */
 	__set_IMR(0x0700);
 	__clr_IFR(0x0000);
 
-	frv_irq_route_external(&frv_fpga[0], IRQ_CPU_EXTERNAL2);
-	frv_irq_set_group(&frv_fpga_irqs);
+	for (irq = IRQ_BASE_FPGA + 8; irq <= IRQ_BASE_FPGA + 10; irq++)
+		set_irq_chip_and_handler(irq, &frv_fpga_pic, handle_edge_irq);
+
+	/* the FPGA drives external IRQ input #2 on the CPU PIC */
+	setup_irq(IRQ_CPU_EXTERNAL2, &fpga_irq[0]);
 }
diff --git a/arch/frv/kernel/irq-mb93493.c b/arch/frv/kernel/irq-mb93493.c
index 988d035..8ad9abf 100644
--- a/arch/frv/kernel/irq-mb93493.c
+++ b/arch/frv/kernel/irq-mb93493.c
@@ -1,6 +1,6 @@
 /* irq-mb93493.c: MB93493 companion chip interrupt handler
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -24,84 +24,133 @@ #include <asm/bitops.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/irc-regs.h>
-#include <asm/irq-routing.h>
 #include <asm/mb93493-irqs.h>
+#include <asm/mb93493-regs.h>
 
-static void frv_mb93493_doirq(struct irq_source *source);
+#define IRQ_ROUTE_ONE(X) (X##_ROUTE << (X - IRQ_BASE_MB93493))
+
+#define IRQ_ROUTING					\
+	(IRQ_ROUTE_ONE(IRQ_MB93493_VDC)		|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_VCC)		|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_AUDIO_OUT)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_I2C_0)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_I2C_1)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_USB)		|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_LOCAL_BUS)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_PCMCIA)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_GPIO)	|	\
+	 IRQ_ROUTE_ONE(IRQ_MB93493_AUDIO_IN))
 
-/*****************************************************************************/
 /*
- * MB93493 companion chip IRQ multiplexor
+ * daughter board PIC operations
  */
-static struct irq_source frv_mb93493[2] = {
-	[0] = {
-		.muxname		= "mb93493.0",
-		.muxdata		= __region_CS3 + 0x3d0,
-		.doirq			= frv_mb93493_doirq,
-		.irqmask		= 0x0000,
-	},
-	[1] = {
-		.muxname		= "mb93493.1",
-		.muxdata		= __region_CS3 + 0x3d4,
-		.doirq			= frv_mb93493_doirq,
-		.irqmask		= 0x0000,
-	},
-};
-
-static void frv_mb93493_control(struct irq_group *group, int index, int on)
+static void frv_mb93493_enable(unsigned int irq)
 {
-	struct irq_source *source;
 	uint32_t iqsr;
+	volatile void *piqsr;
 
-	if ((frv_mb93493[0].irqmask & (1 << index)))
-		source = &frv_mb93493[0];
+	if (IRQ_ROUTING & (1 << (irq - IRQ_BASE_MB93493)))
+		piqsr = __addr_MB93493_IQSR(1);
 	else
-		source = &frv_mb93493[1];
+		piqsr = __addr_MB93493_IQSR(0);
 
-	iqsr = readl(source->muxdata);
-	if (on)
-		iqsr |= 1 << (index + 16);
+	iqsr = readl(piqsr);
+	iqsr |= 1 << (irq - IRQ_BASE_MB93493 + 16);
+	writel(iqsr, piqsr);
+}
+
+static void frv_mb93493_disable(unsigned int irq)
+{
+	uint32_t iqsr;
+	volatile void *piqsr;
+
+	if (IRQ_ROUTING & (1 << (irq - IRQ_BASE_MB93493)))
+		piqsr = __addr_MB93493_IQSR(1);
 	else
-		iqsr &= ~(1 << (index + 16));
+		piqsr = __addr_MB93493_IQSR(0);
 
-	writel(iqsr, source->muxdata);
+	iqsr = readl(piqsr);
+	iqsr &= ~(1 << (irq - IRQ_BASE_MB93493 + 16));
+	writel(iqsr, piqsr);
 }
 
-static struct irq_group frv_mb93493_irqs = {
-	.first_irq	= IRQ_BASE_MB93493,
-	.control	= frv_mb93493_control,
-};
-
-static void frv_mb93493_doirq(struct irq_source *source)
+static void frv_mb93493_ack(unsigned int irq)
 {
-	uint32_t mask = readl(source->muxdata);
-	mask = mask & (mask >> 16) & 0xffff;
+}
 
-	if (mask)
-		distribute_irqs(&frv_mb93493_irqs, mask);
+static void frv_mb93493_end(unsigned int irq)
+{
 }
 
-static void __init mb93493_irq_route(int irq, int source)
+static struct irq_chip frv_mb93493_pic = {
+	.name		= "mb93093",
+	.enable		= frv_mb93493_enable,
+	.disable	= frv_mb93493_disable,
+	.ack		= frv_mb93493_ack,
+	.mask		= frv_mb93493_disable,
+	.unmask		= frv_mb93493_enable,
+	.end		= frv_mb93493_end,
+};
+
+/*
+ * MB93493 PIC interrupt handler
+ */
+static irqreturn_t mb93493_interrupt(int irq, void *_piqsr, struct pt_regs *regs)
 {
-	frv_mb93493[source].irqmask |= 1 << (irq - IRQ_BASE_MB93493);
-	frv_mb93493_irqs.sources[irq - IRQ_BASE_MB93493] = &frv_mb93493[source];
+	volatile void *piqsr = _piqsr;
+	irqreturn_t iret = 0;
+	uint32_t iqsr;
+
+	iqsr = readl(piqsr);
+	iqsr = iqsr & (iqsr >> 16) & 0xffff;
+
+	/* poll all the triggered IRQs */
+	while (iqsr) {
+		int irq;
+
+		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(iqsr));
+		irq = 31 - irq;
+		iqsr &= ~(1 << irq);
+
+		if (__do_IRQ(IRQ_BASE_MB93493 + irq, regs))
+			iret |= IRQ_HANDLED;
+	}
+
+	return iret;
 }
 
-void __init route_mb93493_irqs(void)
+/*
+ * define an interrupt action for each MB93493 PIC output
+ * - use dev_id to indicate the MB93493 PIC input to output mappings
+ */
+static struct irqaction mb93493_irq[2]  = {
+	[0] = {
+		.handler	= mb93493_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "mb93493.0",
+		.dev_id		= (void *) __addr_MB93493_IQSR(0),
+	},
+	[1] = {
+		.handler	= mb93493_interrupt,
+		.flags		= IRQF_DISABLED | IRQF_SHARED,
+		.mask		= CPU_MASK_NONE,
+		.name		= "mb93493.1",
+		.dev_id		= (void *) __addr_MB93493_IQSR(1),
+	}
+};
+
+/*
+ * initialise the motherboard MB93493's PIC
+ */
+void __init mb93493_init(void)
 {
-	frv_irq_route_external(&frv_mb93493[0], IRQ_CPU_MB93493_0);
-	frv_irq_route_external(&frv_mb93493[1], IRQ_CPU_MB93493_1);
-
-	frv_irq_set_group(&frv_mb93493_irqs);
-
-	mb93493_irq_route(IRQ_MB93493_VDC,		IRQ_MB93493_VDC_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_VCC,		IRQ_MB93493_VCC_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_AUDIO_IN,		IRQ_MB93493_AUDIO_IN_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_I2C_0,		IRQ_MB93493_I2C_0_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_I2C_1,		IRQ_MB93493_I2C_1_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_USB,		IRQ_MB93493_USB_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_LOCAL_BUS,	IRQ_MB93493_LOCAL_BUS_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_PCMCIA,		IRQ_MB93493_PCMCIA_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_GPIO,		IRQ_MB93493_GPIO_ROUTE);
-	mb93493_irq_route(IRQ_MB93493_AUDIO_OUT,	IRQ_MB93493_AUDIO_OUT_ROUTE);
+	int irq;
+
+	for (irq = IRQ_BASE_MB93493 + 0; irq <= IRQ_BASE_MB93493 + 10; irq++)
+		set_irq_chip_and_handler(irq, &frv_mb93493_pic, handle_edge_irq);
+
+	/* the MB93493 drives external IRQ inputs on the CPU PIC */
+	setup_irq(IRQ_CPU_MB93493_0, &mb93493_irq[0]);
+	setup_irq(IRQ_CPU_MB93493_1, &mb93493_irq[1]);
 }
diff --git a/arch/frv/kernel/irq-routing.c b/arch/frv/kernel/irq-routing.c
deleted file mode 100644
index 53886ad..0000000
--- a/arch/frv/kernel/irq-routing.c
+++ /dev/null
@@ -1,291 +0,0 @@
-/* irq-routing.c: IRQ routing
- *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/sched.h>
-#include <linux/random.h>
-#include <linux/init.h>
-#include <linux/serial_reg.h>
-#include <asm/io.h>
-#include <asm/irq-routing.h>
-#include <asm/irc-regs.h>
-#include <asm/serial-regs.h>
-#include <asm/dma.h>
-
-struct irq_level frv_irq_levels[16] = {
-	[0 ... 15] = {
-		.lock	= SPIN_LOCK_UNLOCKED,
-	}
-};
-
-struct irq_group *irq_groups[NR_IRQ_GROUPS];
-
-extern struct irq_group frv_cpu_irqs;
-
-void __init frv_irq_route(struct irq_source *source, int irqlevel)
-{
-	source->level = &frv_irq_levels[irqlevel];
-	source->next = frv_irq_levels[irqlevel].sources;
-	frv_irq_levels[irqlevel].sources = source;
-}
-
-void __init frv_irq_route_external(struct irq_source *source, int irq)
-{
-	int irqlevel = 0;
-
-	switch (irq) {
-	case IRQ_CPU_EXTERNAL0:	irqlevel = IRQ_XIRQ0_LEVEL; break;
-	case IRQ_CPU_EXTERNAL1:	irqlevel = IRQ_XIRQ1_LEVEL; break;
-	case IRQ_CPU_EXTERNAL2:	irqlevel = IRQ_XIRQ2_LEVEL; break;
-	case IRQ_CPU_EXTERNAL3:	irqlevel = IRQ_XIRQ3_LEVEL; break;
-	case IRQ_CPU_EXTERNAL4:	irqlevel = IRQ_XIRQ4_LEVEL; break;
-	case IRQ_CPU_EXTERNAL5:	irqlevel = IRQ_XIRQ5_LEVEL; break;
-	case IRQ_CPU_EXTERNAL6:	irqlevel = IRQ_XIRQ6_LEVEL; break;
-	case IRQ_CPU_EXTERNAL7:	irqlevel = IRQ_XIRQ7_LEVEL; break;
-	default: BUG();
-	}
-
-	source->level = &frv_irq_levels[irqlevel];
-	source->next = frv_irq_levels[irqlevel].sources;
-	frv_irq_levels[irqlevel].sources = source;
-}
-
-void __init frv_irq_set_group(struct irq_group *group)
-{
-	irq_groups[group->first_irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP] = group;
-}
-
-void distribute_irqs(struct irq_group *group, unsigned long irqmask)
-{
-	struct irqaction *action;
-	int irq;
-
-	while (irqmask) {
-		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(irqmask));
-		if (irq < 0 || irq > 31)
-			asm volatile("break");
-		irq = 31 - irq;
-
-		irqmask &= ~(1 << irq);
-		action = group->actions[irq];
-
-		irq += group->first_irq;
-
-		if (action) {
-			int status = 0;
-
-//			if (!(action->flags & IRQF_DISABLED))
-//				local_irq_enable();
-
-			do {
-				status |= action->flags;
-				action->handler(irq, action->dev_id, __frame);
-				action = action->next;
-			} while (action);
-
-			if (status & IRQF_SAMPLE_RANDOM)
-				add_interrupt_randomness(irq);
-			local_irq_disable();
-		}
-	}
-}
-
-/*****************************************************************************/
-/*
- * CPU UART interrupts
- */
-static void frv_cpuuart_doirq(struct irq_source *source)
-{
-//	uint8_t iir = readb(source->muxdata + UART_IIR * 8);
-//	if ((iir & 0x0f) != UART_IIR_NO_INT)
-		distribute_irqs(&frv_cpu_irqs, source->irqmask);
-}
-
-struct irq_source frv_cpuuart[2] = {
-#define __CPUUART(X, A)						\
-	[X] = {							\
-		.muxname	= "uart",			\
-		.muxdata	= (volatile void __iomem *)(unsigned long)A,\
-		.irqmask	= 1 << IRQ_CPU_UART##X,		\
-		.doirq		= frv_cpuuart_doirq,		\
-	}
-
-	__CPUUART(0, UART0_BASE),
-	__CPUUART(1, UART1_BASE),
-};
-
-/*****************************************************************************/
-/*
- * CPU DMA interrupts
- */
-static void frv_cpudma_doirq(struct irq_source *source)
-{
-	uint32_t cstr = readl(source->muxdata + DMAC_CSTRx);
-	if (cstr & DMAC_CSTRx_INT)
-		distribute_irqs(&frv_cpu_irqs, source->irqmask);
-}
-
-struct irq_source frv_cpudma[8] = {
-#define __CPUDMA(X, A)						\
-	[X] = {							\
-		.muxname	= "dma",			\
-		.muxdata	= (volatile void __iomem *)(unsigned long)A,\
-		.irqmask	= 1 << IRQ_CPU_DMA##X,		\
-		.doirq		= frv_cpudma_doirq,		\
-	}
-
-	__CPUDMA(0, 0xfe000900),
-	__CPUDMA(1, 0xfe000980),
-	__CPUDMA(2, 0xfe000a00),
-	__CPUDMA(3, 0xfe000a80),
-	__CPUDMA(4, 0xfe001000),
-	__CPUDMA(5, 0xfe001080),
-	__CPUDMA(6, 0xfe001100),
-	__CPUDMA(7, 0xfe001180),
-};
-
-/*****************************************************************************/
-/*
- * CPU timer interrupts - can't tell whether they've generated an interrupt or not
- */
-static void frv_cputimer_doirq(struct irq_source *source)
-{
-	distribute_irqs(&frv_cpu_irqs, source->irqmask);
-}
-
-struct irq_source frv_cputimer[3] = {
-#define __CPUTIMER(X)						\
-	[X] = {							\
-		.muxname	= "timer",			\
-		.muxdata	= NULL,				\
-		.irqmask	= 1 << IRQ_CPU_TIMER##X,	\
-		.doirq		= frv_cputimer_doirq,		\
-	}
-
-	__CPUTIMER(0),
-	__CPUTIMER(1),
-	__CPUTIMER(2),
-};
-
-/*****************************************************************************/
-/*
- * external CPU interrupts - can't tell directly whether they've generated an interrupt or not
- */
-static void frv_cpuexternal_doirq(struct irq_source *source)
-{
-	distribute_irqs(&frv_cpu_irqs, source->irqmask);
-}
-
-struct irq_source frv_cpuexternal[8] = {
-#define __CPUEXTERNAL(X)					\
-	[X] = {							\
-		.muxname	= "ext",			\
-		.muxdata	= NULL,				\
-		.irqmask	= 1 << IRQ_CPU_EXTERNAL##X,	\
-		.doirq		= frv_cpuexternal_doirq,	\
-	}
-
-	__CPUEXTERNAL(0),
-	__CPUEXTERNAL(1),
-	__CPUEXTERNAL(2),
-	__CPUEXTERNAL(3),
-	__CPUEXTERNAL(4),
-	__CPUEXTERNAL(5),
-	__CPUEXTERNAL(6),
-	__CPUEXTERNAL(7),
-};
-
-#define set_IRR(N,A,B,C,D) __set_IRR(N, (A << 28) | (B << 24) | (C << 20) | (D << 16))
-
-struct irq_group frv_cpu_irqs = {
-	.sources = {
-		[IRQ_CPU_UART0]		= &frv_cpuuart[0],
-		[IRQ_CPU_UART1]		= &frv_cpuuart[1],
-		[IRQ_CPU_TIMER0]	= &frv_cputimer[0],
-		[IRQ_CPU_TIMER1]	= &frv_cputimer[1],
-		[IRQ_CPU_TIMER2]	= &frv_cputimer[2],
-		[IRQ_CPU_DMA0]		= &frv_cpudma[0],
-		[IRQ_CPU_DMA1]		= &frv_cpudma[1],
-		[IRQ_CPU_DMA2]		= &frv_cpudma[2],
-		[IRQ_CPU_DMA3]		= &frv_cpudma[3],
-		[IRQ_CPU_DMA4]		= &frv_cpudma[4],
-		[IRQ_CPU_DMA5]		= &frv_cpudma[5],
-		[IRQ_CPU_DMA6]		= &frv_cpudma[6],
-		[IRQ_CPU_DMA7]		= &frv_cpudma[7],
-		[IRQ_CPU_EXTERNAL0]	= &frv_cpuexternal[0],
-		[IRQ_CPU_EXTERNAL1]	= &frv_cpuexternal[1],
-		[IRQ_CPU_EXTERNAL2]	= &frv_cpuexternal[2],
-		[IRQ_CPU_EXTERNAL3]	= &frv_cpuexternal[3],
-		[IRQ_CPU_EXTERNAL4]	= &frv_cpuexternal[4],
-		[IRQ_CPU_EXTERNAL5]	= &frv_cpuexternal[5],
-		[IRQ_CPU_EXTERNAL6]	= &frv_cpuexternal[6],
-		[IRQ_CPU_EXTERNAL7]	= &frv_cpuexternal[7],
-	},
-};
-
-/*****************************************************************************/
-/*
- * route the CPU's interrupt sources
- */
-void __init route_cpu_irqs(void)
-{
-	frv_irq_set_group(&frv_cpu_irqs);
-
-	__set_IITMR(0, 0x003f0000);	/* DMA0-3, TIMER0-2 IRQ detect levels */
-	__set_IITMR(1, 0x20000000);	/* ERR0-1, UART0-1, DMA4-7 IRQ detect levels */
-
-	/* route UART and error interrupts */
-	frv_irq_route(&frv_cpuuart[0],	IRQ_UART0_LEVEL);
-	frv_irq_route(&frv_cpuuart[1],	IRQ_UART1_LEVEL);
-
-	set_IRR(6, IRQ_GDBSTUB_LEVEL, IRQ_GDBSTUB_LEVEL, IRQ_UART1_LEVEL, IRQ_UART0_LEVEL);
-
-	/* route DMA channel interrupts */
-	frv_irq_route(&frv_cpudma[0],	IRQ_DMA0_LEVEL);
-	frv_irq_route(&frv_cpudma[1],	IRQ_DMA1_LEVEL);
-	frv_irq_route(&frv_cpudma[2],	IRQ_DMA2_LEVEL);
-	frv_irq_route(&frv_cpudma[3],	IRQ_DMA3_LEVEL);
-	frv_irq_route(&frv_cpudma[4],	IRQ_DMA4_LEVEL);
-	frv_irq_route(&frv_cpudma[5],	IRQ_DMA5_LEVEL);
-	frv_irq_route(&frv_cpudma[6],	IRQ_DMA6_LEVEL);
-	frv_irq_route(&frv_cpudma[7],	IRQ_DMA7_LEVEL);
-
-	set_IRR(4, IRQ_DMA3_LEVEL, IRQ_DMA2_LEVEL, IRQ_DMA1_LEVEL, IRQ_DMA0_LEVEL);
-	set_IRR(7, IRQ_DMA7_LEVEL, IRQ_DMA6_LEVEL, IRQ_DMA5_LEVEL, IRQ_DMA4_LEVEL);
-
-	/* route timer interrupts */
-	frv_irq_route(&frv_cputimer[0],	IRQ_TIMER0_LEVEL);
-	frv_irq_route(&frv_cputimer[1],	IRQ_TIMER1_LEVEL);
-	frv_irq_route(&frv_cputimer[2],	IRQ_TIMER2_LEVEL);
-
-	set_IRR(5, 0, IRQ_TIMER2_LEVEL, IRQ_TIMER1_LEVEL, IRQ_TIMER0_LEVEL);
-
-	/* route external interrupts */
-	frv_irq_route(&frv_cpuexternal[0], IRQ_XIRQ0_LEVEL);
-	frv_irq_route(&frv_cpuexternal[1], IRQ_XIRQ1_LEVEL);
-	frv_irq_route(&frv_cpuexternal[2], IRQ_XIRQ2_LEVEL);
-	frv_irq_route(&frv_cpuexternal[3], IRQ_XIRQ3_LEVEL);
-	frv_irq_route(&frv_cpuexternal[4], IRQ_XIRQ4_LEVEL);
-	frv_irq_route(&frv_cpuexternal[5], IRQ_XIRQ5_LEVEL);
-	frv_irq_route(&frv_cpuexternal[6], IRQ_XIRQ6_LEVEL);
-	frv_irq_route(&frv_cpuexternal[7], IRQ_XIRQ7_LEVEL);
-
-	set_IRR(2, IRQ_XIRQ7_LEVEL, IRQ_XIRQ6_LEVEL, IRQ_XIRQ5_LEVEL, IRQ_XIRQ4_LEVEL);
-	set_IRR(3, IRQ_XIRQ3_LEVEL, IRQ_XIRQ2_LEVEL, IRQ_XIRQ1_LEVEL, IRQ_XIRQ0_LEVEL);
-
-#if defined(CONFIG_MB93091_VDK)
-	__set_TM1(0x55550000);		/* XIRQ7-0 all active low */
-#elif defined(CONFIG_MB93093_PDK)
-	__set_TM1(0x15550000);		/* XIRQ7 active high, 6-0 all active low */
-#else
-#error dont know external IRQ trigger levels for this setup
-#endif
-
-} /* end route_cpu_irqs() */
diff --git a/arch/frv/kernel/irq.c b/arch/frv/kernel/irq.c
index 0896701..e1ab9f2 100644
--- a/arch/frv/kernel/irq.c
+++ b/arch/frv/kernel/irq.c
@@ -1,6 +1,6 @@
 /* irq.c: FRV IRQ handling
  *
- * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2003, 2004, 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -9,13 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-/*
- * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
- *
- * IRQs are in fact implemented a bit like signal handlers for the kernel.
- * Naturally it's not a 1:1 relation, but there are similarities.
- */
-
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
@@ -43,19 +36,16 @@ #include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/irc-regs.h>
-#include <asm/irq-routing.h>
 #include <asm/gdb-stub.h>
 
-extern void __init fpga_init(void);
-extern void __init route_mb93493_irqs(void);
-
-static void register_irq_proc (unsigned int irq);
+#define set_IRR(N,A,B,C,D) __set_IRR(N, (A << 28) | (B << 24) | (C << 20) | (D << 16))
 
-/*
- * Special irq handlers.
- */
+extern void __init fpga_init(void);
+#ifdef CONFIG_FUJITSU_MB93493
+extern void __init mb93493_init(void);
+#endif
 
-irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs) { return IRQ_HANDLED; }
+#define __reg16(ADDR) (*(volatile unsigned short *)(ADDR))
 
 atomic_t irq_err_count;
 
@@ -64,215 +54,99 @@ atomic_t irq_err_count;
  */
 int show_interrupts(struct seq_file *p, void *v)
 {
-	struct irqaction *action;
-	struct irq_group *group;
+	int i = *(loff_t *) v, cpu;
+	struct irqaction * action;
 	unsigned long flags;
-	int level, grp, ix, i, j;
-
-	i = *(loff_t *) v;
-
-	switch (i) {
-	case 0:
-		seq_printf(p, "           ");
-		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ",j);
-
-		seq_putc(p, '\n');
-		break;
 
-	case 1 ... NR_IRQ_GROUPS * NR_IRQ_ACTIONS_PER_GROUP:
-		local_irq_save(flags);
-
-		grp = (i - 1) / NR_IRQ_ACTIONS_PER_GROUP;
-		group = irq_groups[grp];
-		if (!group)
-			goto skip;
-
-		ix = (i - 1) % NR_IRQ_ACTIONS_PER_GROUP;
-		action = group->actions[ix];
-		if (!action)
-			goto skip;
-
-		seq_printf(p, "%3d: ", i - 1);
-
-#ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#else
-		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i - 1]);
-#endif
-
-		level = group->sources[ix]->level - frv_irq_levels;
-
-		seq_printf(p, " %12s@%x", group->sources[ix]->muxname, level);
-		seq_printf(p, "  %s", action->name);
-
-		for (action = action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
+	if (i == 0) {
+		char cpuname[12];
 
+		seq_printf(p, "    ");
+		for_each_present_cpu(cpu) {
+			sprintf(cpuname, "CPU%d", cpu);
+			seq_printf(p, " %10s", cpuname);
+		}
 		seq_putc(p, '\n');
-skip:
-		local_irq_restore(flags);
-		break;
+	}
 
-	case NR_IRQ_GROUPS * NR_IRQ_ACTIONS_PER_GROUP + 1:
-		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-		break;
+	if (i < NR_IRQS) {
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		action = irq_desc[i].action;
+		if (action) {
+			seq_printf(p, "%3d: ", i);
+			for_each_present_cpu(cpu)
+				seq_printf(p, "%10u ", kstat_cpu(cpu).irqs[i]);
+			seq_printf(p, " %10s", irq_desc[i].chip->name ? : "-");
+			seq_printf(p, "  %s", action->name);
+			for (action = action->next;
+			     action;
+			     action = action->next)
+				seq_printf(p, ", %s", action->name);
+
+			seq_putc(p, '\n');
+		}
 
-	default:
-		break;
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+	} else if (i == NR_IRQS) {
+		seq_printf(p, "Err: %10u\n", atomic_read(&irq_err_count));
 	}
 
 	return 0;
 }
 
-
 /*
- * Generic enable/disable code: this just calls
- * down into the PIC-specific version for the actual
- * hardware disable after having gotten the irq
- * controller lock.
+ * on-CPU PIC operations
  */
-
-/**
- *	disable_irq_nosync - disable an irq without waiting
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line.  Disables and Enables are
- *	nested.
- *	Unlike disable_irq(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
- *
- *	This function may be called from IRQ context.
- */
-
-void disable_irq_nosync(unsigned int irq)
+static void frv_cpupic_enable(unsigned int irqlevel)
 {
-	struct irq_source *source;
-	struct irq_group *group;
-	struct irq_level *level;
-	unsigned long flags;
-	int idx = irq & (NR_IRQ_ACTIONS_PER_GROUP - 1);
-
-	group = irq_groups[irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP];
-	if (!group)
-		BUG();
-
-	source = group->sources[idx];
-	if (!source)
-		BUG();
-
-	level = source->level;
-
-	spin_lock_irqsave(&level->lock, flags);
-
-	if (group->control) {
-		if (!group->disable_cnt[idx]++)
-			group->control(group, idx, 0);
-	} else if (!level->disable_count++) {
-		__set_MASK(level - frv_irq_levels);
-	}
-
-	spin_unlock_irqrestore(&level->lock, flags);
+	__clr_MASK(irqlevel);
 }
 
-EXPORT_SYMBOL(disable_irq_nosync);
-
-/**
- *	disable_irq - disable an irq and wait for completion
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line.  Enables and Disables are
- *	nested.
- *	This function waits for any pending IRQ handlers for this interrupt
- *	to complete before returning. If you use this function while
- *	holding a resource the IRQ handler may need you will deadlock.
- *
- *	This function may be called - with care - from IRQ context.
- */
-
-void disable_irq(unsigned int irq)
+static void frv_cpupic_disable(unsigned int irqlevel)
 {
-	disable_irq_nosync(irq);
-
-#ifdef CONFIG_SMP
-	if (!local_irq_count(smp_processor_id())) {
-		do {
-			barrier();
-		} while (irq_desc[irq].status & IRQ_INPROGRESS);
-	}
-#endif
+	__set_MASK(irqlevel);
 }
 
-EXPORT_SYMBOL(disable_irq);
-
-/**
- *	enable_irq - enable handling of an irq
- *	@irq: Interrupt to enable
- *
- *	Undoes the effect of one call to disable_irq().  If this
- *	matches the last disable, processing of interrupts on this
- *	IRQ line is re-enabled.
- *
- *	This function may be called from IRQ context.
- */
-
-void enable_irq(unsigned int irq)
+static void frv_cpupic_ack(unsigned int irqlevel)
 {
-	struct irq_source *source;
-	struct irq_group *group;
-	struct irq_level *level;
-	unsigned long flags;
-	int idx = irq & (NR_IRQ_ACTIONS_PER_GROUP - 1);
-	int count;
-
-	group = irq_groups[irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP];
-	if (!group)
-		BUG();
-
-	source = group->sources[idx];
-	if (!source)
-		BUG();
-
-	level = source->level;
-
-	spin_lock_irqsave(&level->lock, flags);
-
-	if (group->control)
-		count = group->disable_cnt[idx];
-	else
-		count = level->disable_count;
-
-	switch (count) {
-	case 1:
-		if (group->control) {
-			if (group->actions[idx])
-				group->control(group, idx, 1);
-		} else {
-			if (level->usage)
-				__clr_MASK(level - frv_irq_levels);
-		}
-		/* fall-through */
+	__set_MASK(irqlevel);
+	__clr_RC(irqlevel);
+	__clr_IRL();
+}
 
-	default:
-		count--;
-		break;
+static void frv_cpupic_mask(unsigned int irqlevel)
+{
+	__set_MASK(irqlevel);
+}
 
-	case 0:
-		printk("enable_irq(%u) unbalanced from %p\n", irq, __builtin_return_address(0));
-	}
+static void frv_cpupic_mask_ack(unsigned int irqlevel)
+{
+	__set_MASK(irqlevel);
+	__clr_RC(irqlevel);
+	__clr_IRL();
+}
 
-	if (group->control)
-		group->disable_cnt[idx] = count;
-	else
-		level->disable_count = count;
+static void frv_cpupic_unmask(unsigned int irqlevel)
+{
+	__clr_MASK(irqlevel);
+}
 
-	spin_unlock_irqrestore(&level->lock, flags);
+static void frv_cpupic_end(unsigned int irqlevel)
+{
+	__clr_MASK(irqlevel);
 }
 
-EXPORT_SYMBOL(enable_irq);
+static struct irq_chip frv_cpu_pic = {
+	.name		= "cpu",
+	.enable		= frv_cpupic_enable,
+	.disable	= frv_cpupic_disable,
+	.ack		= frv_cpupic_ack,
+	.mask		= frv_cpupic_mask,
+	.mask_ack	= frv_cpupic_mask_ack,
+	.unmask		= frv_cpupic_unmask,
+	.end		= frv_cpupic_end,
+};
 
-/*****************************************************************************/
 /*
  * handles all normal device IRQ's
  * - registers are referred to by the __frame variable (GR28)
@@ -281,463 +155,65 @@ EXPORT_SYMBOL(enable_irq);
  */
 asmlinkage void do_IRQ(void)
 {
-	struct irq_source *source;
-	int level, cpu;
-
 	irq_enter();
-
-	level = (__frame->tbr >> 4) & 0xf;
-	cpu = smp_processor_id();
-
-	if ((unsigned long) __frame - (unsigned long) (current + 1) < 512)
-		BUG();
-
-	__set_MASK(level);
-	__clr_RC(level);
-	__clr_IRL();
-
-	kstat_this_cpu.irqs[level]++;
-
-	for (source = frv_irq_levels[level].sources; source; source = source->next)
-		source->doirq(source);
-
-	__clr_MASK(level);
-
+	__do_IRQ(__get_IRL(), __frame);
 	irq_exit();
+}
 
-} /* end do_IRQ() */
-
-/*****************************************************************************/
 /*
  * handles all NMIs when not co-opted by the debugger
  * - registers are referred to by the __frame variable (GR28)
  */
 asmlinkage void do_NMI(void)
 {
-} /* end do_NMI() */
-
-/*****************************************************************************/
-/**
- *	request_irq - allocate an interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. From the point this
- *	call is made your handler function may be invoked. Since
- *	your handler function must clear any interrupt the board
- *	raises, you must take care both to initialise your hardware
- *	and to set up the interrupt handler in the right order.
- *
- *	Dev_id must be globally unique. Normally the address of the
- *	device data structure is used as the cookie. Since the handler
- *	receives this value it makes sense to use it.
- *
- *	If your interrupt is shared you must pass a non NULL dev_id
- *	as this is required when freeing the interrupt.
- *
- *	Flags:
- *
- *	IRQF_SHARED		Interrupt is shared
- *
- *	IRQF_DISABLED	Disable local interrupts while processing
- *
- *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
- *
- */
-
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		unsigned long irqflags,
-		const char * devname,
-		void *dev_id)
-{
-	int retval;
-	struct irqaction *action;
-
-#if 1
-	/*
-	 * Sanity-check: shared interrupts should REALLY pass in
-	 * a real dev-ID, otherwise we'll have trouble later trying
-	 * to figure out which interrupt is which (messes up the
-	 * interrupt freeing logic etc).
-	 */
-	if (irqflags & IRQF_SHARED) {
-		if (!dev_id)
-			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n",
-			       devname, (&irq)[-1]);
-	}
-#endif
-
-	if ((irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP) >= NR_IRQ_GROUPS)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-	action = (struct irqaction *) kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler = handler;
-	action->flags = irqflags;
-	action->mask = CPU_MASK_NONE;
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	retval = setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-	return retval;
-}
-
-EXPORT_SYMBOL(request_irq);
-
-/**
- *	free_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
- *
- *	Remove an interrupt handler. The handler is removed and if the
- *	interrupt line is no longer in use by any driver it is disabled.
- *	On a shared IRQ the caller must ensure the interrupt is disabled
- *	on the card it drives before calling this function. The function
- *	does not return until any executing interrupts for this IRQ
- *	have completed.
- *
- *	This function may be called from interrupt context.
- *
- *	Bugs: Attempting to free an irq in a handler for the same irq hangs
- *	      the machine.
- */
-
-void free_irq(unsigned int irq, void *dev_id)
-{
-	struct irq_source *source;
-	struct irq_group *group;
-	struct irq_level *level;
-	struct irqaction **p, **pp;
-	unsigned long flags;
-
-	if ((irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP) >= NR_IRQ_GROUPS)
-		return;
-
-	group = irq_groups[irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP];
-	if (!group)
-		BUG();
-
-	source = group->sources[irq & (NR_IRQ_ACTIONS_PER_GROUP - 1)];
-	if (!source)
-		BUG();
-
-	level = source->level;
-	p = &group->actions[irq & (NR_IRQ_ACTIONS_PER_GROUP - 1)];
-
-	spin_lock_irqsave(&level->lock, flags);
-
-	for (pp = p; *pp; pp = &(*pp)->next) {
-		struct irqaction *action = *pp;
-
-		if (action->dev_id != dev_id)
-			continue;
-
-		/* found it - remove from the list of entries */
-		*pp = action->next;
-
-		level->usage--;
-
-		if (p == pp && group->control)
-			group->control(group, irq & (NR_IRQ_ACTIONS_PER_GROUP - 1), 0);
-
-		if (level->usage == 0)
-			__set_MASK(level - frv_irq_levels);
-
-		spin_unlock_irqrestore(&level->lock,flags);
-
-#ifdef CONFIG_SMP
-		/* Wait to make sure it's not being used on another CPU */
-		while (desc->status & IRQ_INPROGRESS)
-			barrier();
-#endif
-		kfree(action);
-		return;
-	}
-}
-
-EXPORT_SYMBOL(free_irq);
-
-/*
- * IRQ autodetection code..
- *
- * This depends on the fact that any interrupt that comes in on to an
- * unassigned IRQ will cause GxICR_DETECT to be set
- */
-
-static DECLARE_MUTEX(probe_sem);
-
-/**
- *	probe_irq_on	- begin an interrupt autodetect
- *
- *	Commence probing for an interrupt. The interrupts are scanned
- *	and a mask of potential interrupt lines is returned.
- *
- */
-
-unsigned long probe_irq_on(void)
-{
-	down(&probe_sem);
-	return 0;
 }
 
-EXPORT_SYMBOL(probe_irq_on);
-
-/*
- * Return a mask of triggered interrupts (this
- * can handle only legacy ISA interrupts).
- */
-
-/**
- *	probe_irq_mask - scan a bitmap of interrupt lines
- *	@val:	mask of interrupts to consider
- *
- *	Scan the ISA bus interrupt lines and return a bitmap of
- *	active interrupts. The interrupt probe logic state is then
- *	returned to its previous value.
- *
- *	Note: we need to scan all the irq's even though we will
- *	only return ISA irq numbers - just so that we reset them
- *	all to a known state.
- */
-unsigned int probe_irq_mask(unsigned long xmask)
-{
-	up(&probe_sem);
-	return 0;
-}
-
-EXPORT_SYMBOL(probe_irq_mask);
-
 /*
- * Return the one interrupt that triggered (this can
- * handle any interrupt source).
- */
-
-/**
- *	probe_irq_off	- end an interrupt autodetect
- *	@xmask: mask of potential interrupts (unused)
- *
- *	Scans the unused interrupt lines and returns the line which
- *	appears to have triggered the interrupt. If no interrupt was
- *	found then zero is returned. If more than one interrupt is
- *	found then minus the first candidate is returned to indicate
- *	their is doubt.
- *
- *	The interrupt probe logic state is returned to its previous
- *	value.
- *
- *	BUGS: When used in a module (which arguably shouldnt happen)
- *	nothing prevents two IRQ probe callers from overlapping. The
- *	results of this are non-optimal.
+ * initialise the interrupt system
  */
-
-int probe_irq_off(unsigned long xmask)
-{
-	up(&probe_sem);
-	return -1;
-}
-
-EXPORT_SYMBOL(probe_irq_off);
-
-/* this was setup_x86_irq but it seems pretty generic */
-int setup_irq(unsigned int irq, struct irqaction *new)
-{
-	struct irq_source *source;
-	struct irq_group *group;
-	struct irq_level *level;
-	struct irqaction **p, **pp;
-	unsigned long flags;
-
-	group = irq_groups[irq >> NR_IRQ_LOG2_ACTIONS_PER_GROUP];
-	if (!group)
-		BUG();
-
-	source = group->sources[irq & (NR_IRQ_ACTIONS_PER_GROUP - 1)];
-	if (!source)
-		BUG();
-
-	level = source->level;
-
-	p = &group->actions[irq & (NR_IRQ_ACTIONS_PER_GROUP - 1)];
-
-	/*
-	 * Some drivers like serial.c use request_irq() heavily,
-	 * so we have to be careful not to interfere with a
-	 * running system.
-	 */
-	if (new->flags & IRQF_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
-
-	/* must juggle the interrupt processing stuff with interrupts disabled */
-	spin_lock_irqsave(&level->lock, flags);
-
-	/* can't share interrupts unless all parties agree to */
-	if (level->usage != 0 && !(level->flags & new->flags & IRQF_SHARED)) {
-		spin_unlock_irqrestore(&level->lock,flags);
-		return -EBUSY;
-	}
-
-	/* add new interrupt at end of irq queue */
-	pp = p;
-	while (*pp)
-		pp = &(*pp)->next;
-
-	*pp = new;
-
-	level->usage++;
-	level->flags = new->flags;
-
-	/* turn the interrupts on */
-	if (level->usage == 1)
-		__clr_MASK(level - frv_irq_levels);
-
-	if (p == pp && group->control)
-		group->control(group, irq & (NR_IRQ_ACTIONS_PER_GROUP - 1), 1);
-
-	spin_unlock_irqrestore(&level->lock, flags);
-	register_irq_proc(irq);
-	return 0;
-}
-
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir [NR_IRQS];
-
-#define HEX_DIGITS 8
-
-static unsigned int parse_hex_value (const char __user *buffer,
-				     unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
-
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	unsigned long *mask = (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
-}
-
-static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
-					unsigned long count, void *data)
-{
-	unsigned long *mask = (unsigned long *) data, full_count = count, err;
-	unsigned long new_value;
-
-	show_state();
-	err = parse_hex_value(buffer, count, &new_value);
-	if (err)
-		return err;
-
-	*mask = new_value;
-	return full_count;
-}
-
-#define MAX_NAMELEN 10
-
-static void register_irq_proc (unsigned int irq)
-{
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || irq_dir[irq])
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
-}
-
-unsigned long prof_cpu_mask = -1;
-
-void init_irq_proc (void)
+void __init init_IRQ(void)
 {
-	struct proc_dir_entry *entry;
-	int i;
+	int level;
 
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", NULL);
+	for (level = 1; level <= 14; level++)
+		set_irq_chip_and_handler(level, &frv_cpu_pic,
+					 handle_level_irq);
 
-	/* create /proc/irq/prof_cpu_mask */
-	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-	if (!entry)
-	    return;
+	set_irq_handler(IRQ_CPU_TIMER0, handle_edge_irq);
 
-	entry->nlink = 1;
-	entry->data = (void *)&prof_cpu_mask;
-	entry->read_proc = prof_cpu_mask_read_proc;
-	entry->write_proc = prof_cpu_mask_write_proc;
-
-	/*
-	 * Create entries for all existing IRQs.
+	/* set the trigger levels for internal interrupt sources
+	 * - timers all falling-edge
+	 * - ERR0 is rising-edge
+	 * - all others are high-level
 	 */
-	for (i = 0; i < NR_IRQS; i++)
-		register_irq_proc(i);
-}
+	__set_IITMR(0, 0x003f0000);	/* DMA0-3, TIMER0-2 */
+	__set_IITMR(1, 0x20000000);	/* ERR0-1, UART0-1, DMA4-7 */
+
+	/* route internal interrupts */
+	set_IRR(4, IRQ_DMA3_LEVEL, IRQ_DMA2_LEVEL, IRQ_DMA1_LEVEL,
+		IRQ_DMA0_LEVEL);
+	set_IRR(5, 0, IRQ_TIMER2_LEVEL, IRQ_TIMER1_LEVEL, IRQ_TIMER0_LEVEL);
+	set_IRR(6, IRQ_GDBSTUB_LEVEL, IRQ_GDBSTUB_LEVEL,
+		IRQ_UART1_LEVEL, IRQ_UART0_LEVEL);
+	set_IRR(7, IRQ_DMA7_LEVEL, IRQ_DMA6_LEVEL, IRQ_DMA5_LEVEL,
+		IRQ_DMA4_LEVEL);
+
+	/* route external interrupts */
+	set_IRR(2, IRQ_XIRQ7_LEVEL, IRQ_XIRQ6_LEVEL, IRQ_XIRQ5_LEVEL,
+		IRQ_XIRQ4_LEVEL);
+	set_IRR(3, IRQ_XIRQ3_LEVEL, IRQ_XIRQ2_LEVEL, IRQ_XIRQ1_LEVEL,
+		IRQ_XIRQ0_LEVEL);
+
+#if defined(CONFIG_MB93091_VDK)
+	__set_TM1(0x55550000);		/* XIRQ7-0 all active low */
+#elif defined(CONFIG_MB93093_PDK)
+	__set_TM1(0x15550000);		/* XIRQ7 active high, 6-0 all active low */
+#else
+#error dont know external IRQ trigger levels for this setup
+#endif
 
-/*****************************************************************************/
-/*
- * initialise the interrupt system
- */
-void __init init_IRQ(void)
-{
-	route_cpu_irqs();
 	fpga_init();
 #ifdef CONFIG_FUJITSU_MB93493
-	route_mb93493_irqs();
+	mb93493_init();
 #endif
-} /* end init_IRQ() */
+}
diff --git a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
index af08ccd..d96a57e 100644
--- a/arch/frv/kernel/setup.c
+++ b/arch/frv/kernel/setup.c
@@ -43,7 +43,6 @@ #include <asm/spr-regs.h>
 #include <asm/mb-regs.h>
 #include <asm/mb93493-regs.h>
 #include <asm/gdb-stub.h>
-#include <asm/irq-routing.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index 68a77fe..3d0284b 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -26,7 +26,6 @@ #include <asm/io.h>
 #include <asm/timer-regs.h>
 #include <asm/mb-regs.h>
 #include <asm/mb86943a.h>
-#include <asm/irq-routing.h>
 
 #include <linux/timex.h>
 
diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
index 2278c80..ba58752 100644
--- a/arch/frv/mb93090-mb00/pci-irq.c
+++ b/arch/frv/mb93090-mb00/pci-irq.c
@@ -15,7 +15,6 @@ #include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
-#include <asm/irq-routing.h>
 
 #include "pci-frv.h"
 
diff --git a/include/asm-frv/cpu-irqs.h b/include/asm-frv/cpu-irqs.h
index 5cd691e..478f349 100644
--- a/include/asm-frv/cpu-irqs.h
+++ b/include/asm-frv/cpu-irqs.h
@@ -14,36 +14,6 @@ #define _ASM_CPU_IRQS_H
 
 #ifndef __ASSEMBLY__
 
-#include <asm/irq-routing.h>
-
-#define IRQ_BASE_CPU		(NR_IRQ_ACTIONS_PER_GROUP * 0)
-
-/* IRQ IDs presented to drivers */
-enum {
-	IRQ_CPU__UNUSED = IRQ_BASE_CPU,
-	IRQ_CPU_UART0,
-	IRQ_CPU_UART1,
-	IRQ_CPU_TIMER0,
-	IRQ_CPU_TIMER1,
-	IRQ_CPU_TIMER2,
-	IRQ_CPU_DMA0,
-	IRQ_CPU_DMA1,
-	IRQ_CPU_DMA2,
-	IRQ_CPU_DMA3,
-	IRQ_CPU_DMA4,
-	IRQ_CPU_DMA5,
-	IRQ_CPU_DMA6,
-	IRQ_CPU_DMA7,
-	IRQ_CPU_EXTERNAL0,
-	IRQ_CPU_EXTERNAL1,
-	IRQ_CPU_EXTERNAL2,
-	IRQ_CPU_EXTERNAL3,
-	IRQ_CPU_EXTERNAL4,
-	IRQ_CPU_EXTERNAL5,
-	IRQ_CPU_EXTERNAL6,
-	IRQ_CPU_EXTERNAL7,
-};
-
 /* IRQ to level mappings */
 #define IRQ_GDBSTUB_LEVEL	15
 #define IRQ_UART_LEVEL		13
@@ -82,6 +52,30 @@ #define IRQ_XIRQ5_LEVEL		6
 #define IRQ_XIRQ6_LEVEL		7
 #define IRQ_XIRQ7_LEVEL		8
 
+/* IRQ IDs presented to drivers */
+#define IRQ_CPU__UNUSED		IRQ_BASE_CPU
+#define IRQ_CPU_UART0		(IRQ_BASE_CPU + IRQ_UART0_LEVEL)
+#define IRQ_CPU_UART1		(IRQ_BASE_CPU + IRQ_UART1_LEVEL)
+#define IRQ_CPU_TIMER0		(IRQ_BASE_CPU + IRQ_TIMER0_LEVEL)
+#define IRQ_CPU_TIMER1		(IRQ_BASE_CPU + IRQ_TIMER1_LEVEL)
+#define IRQ_CPU_TIMER2		(IRQ_BASE_CPU + IRQ_TIMER2_LEVEL)
+#define IRQ_CPU_DMA0		(IRQ_BASE_CPU + IRQ_DMA0_LEVEL)
+#define IRQ_CPU_DMA1		(IRQ_BASE_CPU + IRQ_DMA1_LEVEL)
+#define IRQ_CPU_DMA2		(IRQ_BASE_CPU + IRQ_DMA2_LEVEL)
+#define IRQ_CPU_DMA3		(IRQ_BASE_CPU + IRQ_DMA3_LEVEL)
+#define IRQ_CPU_DMA4		(IRQ_BASE_CPU + IRQ_DMA4_LEVEL)
+#define IRQ_CPU_DMA5		(IRQ_BASE_CPU + IRQ_DMA5_LEVEL)
+#define IRQ_CPU_DMA6		(IRQ_BASE_CPU + IRQ_DMA6_LEVEL)
+#define IRQ_CPU_DMA7		(IRQ_BASE_CPU + IRQ_DMA7_LEVEL)
+#define IRQ_CPU_EXTERNAL0	(IRQ_BASE_CPU + IRQ_XIRQ0_LEVEL)
+#define IRQ_CPU_EXTERNAL1	(IRQ_BASE_CPU + IRQ_XIRQ1_LEVEL)
+#define IRQ_CPU_EXTERNAL2	(IRQ_BASE_CPU + IRQ_XIRQ2_LEVEL)
+#define IRQ_CPU_EXTERNAL3	(IRQ_BASE_CPU + IRQ_XIRQ3_LEVEL)
+#define IRQ_CPU_EXTERNAL4	(IRQ_BASE_CPU + IRQ_XIRQ4_LEVEL)
+#define IRQ_CPU_EXTERNAL5	(IRQ_BASE_CPU + IRQ_XIRQ5_LEVEL)
+#define IRQ_CPU_EXTERNAL6	(IRQ_BASE_CPU + IRQ_XIRQ6_LEVEL)
+#define IRQ_CPU_EXTERNAL7	(IRQ_BASE_CPU + IRQ_XIRQ7_LEVEL)
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_CPU_IRQS_H */
diff --git a/include/asm-frv/hardirq.h b/include/asm-frv/hardirq.h
index 7581b5a..fc47515 100644
--- a/include/asm-frv/hardirq.h
+++ b/include/asm-frv/hardirq.h
@@ -26,5 +26,10 @@ #ifdef CONFIG_SMP
 #error SMP not available on FR-V
 #endif /* CONFIG_SMP */
 
+extern atomic_t irq_err_count;
+static inline void ack_bad_irq(int irq)
+{
+	atomic_inc(&irq_err_count);
+}
 
 #endif
diff --git a/include/asm-frv/irq-routing.h b/include/asm-frv/irq-routing.h
deleted file mode 100644
index ac3ab90..0000000
--- a/include/asm-frv/irq-routing.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* irq-routing.h: multiplexed IRQ routing
- *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_IRQ_ROUTING_H
-#define _ASM_IRQ_ROUTING_H
-
-#ifndef __ASSEMBLY__
-
-#include <linux/spinlock.h>
-#include <asm/irq.h>
-
-struct irq_source;
-struct irq_level;
-
-/*
- * IRQ action distribution sets
- */
-struct irq_group {
-	int			first_irq;	/* first IRQ distributed here */
-	void (*control)(struct irq_group *group, int index, int on);
-
-	struct irqaction	*actions[NR_IRQ_ACTIONS_PER_GROUP];	/* IRQ action chains */
-	struct irq_source	*sources[NR_IRQ_ACTIONS_PER_GROUP];	/* IRQ sources */
-	int			disable_cnt[NR_IRQ_ACTIONS_PER_GROUP];	/* disable counts */
-};
-
-/*
- * IRQ source manager
- */
-struct irq_source {
-	struct irq_source	*next;
-	struct irq_level	*level;
-	const char		*muxname;
-	volatile void __iomem	*muxdata;
-	unsigned long		irqmask;
-
-	void (*doirq)(struct irq_source *source);
-};
-
-/*
- * IRQ level management (per CPU IRQ priority / entry vector)
- */
-struct irq_level {
-	int			usage;
-	int			disable_count;
-	unsigned long		flags;		/* current IRQF_DISABLED and IRQF_SHARED settings */
-	spinlock_t		lock;
-	struct irq_source	*sources;
-};
-
-extern struct irq_level frv_irq_levels[16];
-extern struct irq_group *irq_groups[NR_IRQ_GROUPS];
-
-extern void frv_irq_route(struct irq_source *source, int irqlevel);
-extern void frv_irq_route_external(struct irq_source *source, int irq);
-extern void frv_irq_set_group(struct irq_group *group);
-extern void distribute_irqs(struct irq_group *group, unsigned long irqmask);
-extern void route_cpu_irqs(void);
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* _ASM_IRQ_ROUTING_H */
diff --git a/include/asm-frv/irq.h b/include/asm-frv/irq.h
index 58b6192..8fefd6b 100644
--- a/include/asm-frv/irq.h
+++ b/include/asm-frv/irq.h
@@ -1,6 +1,6 @@
 /* irq.h: FRV IRQ definitions
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -12,32 +12,22 @@
 #ifndef _ASM_IRQ_H_
 #define _ASM_IRQ_H_
 
-
-/*
- * the system has an on-CPU PIC and another PIC on the FPGA and other PICs on other peripherals,
- * so we do some routing in irq-routing.[ch] to reduce the number of false-positives seen by
- * drivers
- */
-
 /* this number is used when no interrupt has been assigned */
 #define NO_IRQ				(-1)
 
-#define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
-#define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
-#define NR_IRQ_GROUPS			4
-#define NR_IRQS				(NR_IRQ_ACTIONS_PER_GROUP * NR_IRQ_GROUPS)
+#define NR_IRQS				48
+#define IRQ_BASE_CPU			(0 * 16)
+#define IRQ_BASE_FPGA			(1 * 16)
+#define IRQ_BASE_MB93493		(2 * 16)
 
 /* probe returns a 32-bit IRQ mask:-/ */
-#define MIN_PROBE_IRQ	(NR_IRQS - 32)
+#define MIN_PROBE_IRQ			(NR_IRQS - 32)
 
+#ifndef __ASSEMBLY__
 static inline int irq_canonicalize(int irq)
 {
 	return irq;
 }
-
-extern void disable_irq_nosync(unsigned int irq);
-extern void disable_irq(unsigned int irq);
-extern void enable_irq(unsigned int irq);
-
+#endif
 
 #endif /* _ASM_IRQ_H_ */
diff --git a/include/asm-frv/mb93091-fpga-irqs.h b/include/asm-frv/mb93091-fpga-irqs.h
index 341bfc5..19778c5 100644
--- a/include/asm-frv/mb93091-fpga-irqs.h
+++ b/include/asm-frv/mb93091-fpga-irqs.h
@@ -12,11 +12,9 @@
 #ifndef _ASM_MB93091_FPGA_IRQS_H
 #define _ASM_MB93091_FPGA_IRQS_H
 
-#ifndef __ASSEMBLY__
-
-#include <asm/irq-routing.h>
+#include <asm/irq.h>
 
-#define IRQ_BASE_FPGA		(NR_IRQ_ACTIONS_PER_GROUP * 1)
+#ifndef __ASSEMBLY__
 
 /* IRQ IDs presented to drivers */
 enum {
diff --git a/include/asm-frv/mb93093-fpga-irqs.h b/include/asm-frv/mb93093-fpga-irqs.h
index 1e0f11c..590266b 100644
--- a/include/asm-frv/mb93093-fpga-irqs.h
+++ b/include/asm-frv/mb93093-fpga-irqs.h
@@ -12,11 +12,9 @@
 #ifndef _ASM_MB93093_FPGA_IRQS_H
 #define _ASM_MB93093_FPGA_IRQS_H
 
-#ifndef __ASSEMBLY__
-
-#include <asm/irq-routing.h>
+#include <asm/irq.h>
 
-#define IRQ_BASE_FPGA		(NR_IRQ_ACTIONS_PER_GROUP * 1)
+#ifndef __ASSEMBLY__
 
 /* IRQ IDs presented to drivers */
 enum {
diff --git a/include/asm-frv/mb93493-irqs.h b/include/asm-frv/mb93493-irqs.h
index 15096e7..82c7aed 100644
--- a/include/asm-frv/mb93493-irqs.h
+++ b/include/asm-frv/mb93493-irqs.h
@@ -12,11 +12,9 @@
 #ifndef _ASM_MB93493_IRQS_H
 #define _ASM_MB93493_IRQS_H
 
-#ifndef __ASSEMBLY__
-
-#include <asm/irq-routing.h>
+#include <asm/irq.h>
 
-#define IRQ_BASE_MB93493	(NR_IRQ_ACTIONS_PER_GROUP * 2)
+#ifndef __ASSEMBLY__
 
 /* IRQ IDs presented to drivers */
 enum {
diff --git a/include/asm-frv/mb93493-regs.h b/include/asm-frv/mb93493-regs.h
index c54aa9d..8a1f6aa 100644
--- a/include/asm-frv/mb93493-regs.h
+++ b/include/asm-frv/mb93493-regs.h
@@ -15,6 +15,7 @@ #define _ASM_MB93493_REGS_H
 #include <asm/mb-regs.h>
 #include <asm/mb93493-irqs.h>
 
+#define __addr_MB93493(X)	((volatile unsigned long *)(__region_CS3 + (X)))
 #define __get_MB93493(X)	({ *(volatile unsigned long *)(__region_CS3 + (X)); })
 
 #define __set_MB93493(X,V)						\
@@ -26,6 +27,7 @@ #define __get_MB93493_STSR(X)	__get_MB93
 #define __set_MB93493_STSR(X,V)	__set_MB93493(0x3c0 + (X) * 4, (V))
 #define MB93493_STSR_EN
 
+#define __addr_MB93493_IQSR(X)	__addr_MB93493(0x3d0 + (X) * 4)
 #define __get_MB93493_IQSR(X)	__get_MB93493(0x3d0 + (X) * 4)
 #define __set_MB93493_IQSR(X,V)	__set_MB93493(0x3d0 + (X) * 4, (V))
 
