Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWANWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWANWxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWANWxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:53:41 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:8835 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751346AbWANWxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:53:36 -0500
Date: Sun, 15 Jan 2006 00:53:29 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sh: IRQ handler updates.
Message-ID: <20060114225329.GF4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the various IRQ controller drivers into a new subdirectory,
and also extends the INTC2 IRQ handler to also deal with SH7760 and
SH7780 interrupts, rather than just ST-40.

The old CONFIG_SH_GENERIC has also been removed from the IRQ definitions,
as new ports are expected to be based off of CONFIG_SH_UNKNOWN. Since
there are plenty of incompatible machvecs, CONFIG_SH_GENERIC doesn't make
sense anymore.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/cpu/Makefile        |    9 
 arch/sh/kernel/cpu/irq/Makefile    |    7 
 arch/sh/kernel/cpu/irq/imask.c     |  110 +++++++++++
 arch/sh/kernel/cpu/irq/intc2.c     |  284 ++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/irq/ipr.c       |  206 +++++++++++++++++++++
 arch/sh/kernel/cpu/irq/pint.c      |  169 +++++++++++++++++
 arch/sh/kernel/cpu/irq_imask.c     |  116 ------------
 arch/sh/kernel/cpu/irq_ipr.c       |  339 -----------------------------------
 arch/sh/kernel/cpu/sh4/irq_intc2.c |  222 -----------------------
 arch/sh/kernel/irq.c               |   64 ++----
 include/asm-sh/irq-sh73180.h       |   16 -
 include/asm-sh/irq-sh7780.h        |  349 +++++++++++++++++++++++++++++++++++++
 include/asm-sh/irq.h               |  143 ++++++++-------
 13 files changed, 1240 insertions(+), 794 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/Makefile sh-2.6.15/arch/sh/kernel/cpu/Makefile
--- linux-2.6.15/arch/sh/kernel/cpu/Makefile	2004-08-14 20:27:37.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/cpu/Makefile	2006-01-07 22:13:59.118151154 +0200
@@ -2,15 +2,12 @@
 # Makefile for the Linux/SuperH CPU-specifc backends.
 #
 
-obj-y	:= irq_ipr.o irq_imask.o init.o bus.o
+obj-y	+= irq/ init.o bus.o clock.o
 
 obj-$(CONFIG_CPU_SH2)		+= sh2/
 obj-$(CONFIG_CPU_SH3)		+= sh3/
 obj-$(CONFIG_CPU_SH4)		+= sh4/
 
-obj-$(CONFIG_SH_RTC)            += rtc.o
+obj-$(CONFIG_SH_RTC)		+= rtc.o
 obj-$(CONFIG_UBC_WAKEUP)	+= ubc.o
-obj-$(CONFIG_SH_ADC)            += adc.o
-
-USE_STANDARD_AS_RULE := true
-
+obj-$(CONFIG_SH_ADC)		+= adc.o

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq/Makefile sh-2.6.15/arch/sh/kernel/cpu/irq/Makefile
--- linux-2.6.15/arch/sh/kernel/cpu/irq/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq/Makefile	2006-01-07 22:13:59.123150761 +0200
@@ -0,0 +1,7 @@
+#
+# Makefile for the Linux/SuperH CPU-specifc IRQ handlers.
+#
+obj-y	+= ipr.o imask.o
+
+obj-$(CONFIG_CPU_HAS_PINT_IRQ)	+= pint.o
+obj-$(CONFIG_CPU_HAS_INTC2_IRQ)	+= intc2.o
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq/imask.c sh-2.6.15/arch/sh/kernel/cpu/irq/imask.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq/imask.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq/imask.c	2006-01-07 22:13:59.127150447 +0200
@@ -0,0 +1,110 @@
+/*
+ * arch/sh/kernel/cpu/irq/imask.c
+ *
+ * Copyright (C) 1999, 2000  Niibe Yutaka
+ *
+ * Simple interrupt handling using IMASK of SR register.
+ *
+ */
+/* NOTE: Will not work on level 15 */
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/kernel_stat.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+#include <linux/irq.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+
+/* Bitmap of IRQ masked */
+static unsigned long imask_mask = 0x7fff;
+static int interrupt_priority = 0;
+
+static void enable_imask_irq(unsigned int irq);
+static void disable_imask_irq(unsigned int irq);
+static void shutdown_imask_irq(unsigned int irq);
+static void mask_and_ack_imask(unsigned int);
+static void end_imask_irq(unsigned int irq);
+
+#define IMASK_PRIORITY	15
+
+static unsigned int startup_imask_irq(unsigned int irq)
+{
+	/* Nothing to do */
+	return 0; /* never anything pending */
+}
+
+static struct hw_interrupt_type imask_irq_type = {
+	.typename = "SR.IMASK",
+	.startup = startup_imask_irq,
+	.shutdown = shutdown_imask_irq,
+	.enable = enable_imask_irq,
+	.disable = disable_imask_irq,
+	.ack = mask_and_ack_imask,
+	.end = end_imask_irq
+};
+
+void static inline set_interrupt_registers(int ip)
+{
+	unsigned long __dummy;
+
+	asm volatile("ldc	%2, r6_bank\n\t"
+		     "stc	sr, %0\n\t"
+		     "and	#0xf0, %0\n\t"
+		     "shlr2	%0\n\t"
+		     "cmp/eq	#0x3c, %0\n\t"
+		     "bt/s	1f	! CLI-ed\n\t"
+		     " stc	sr, %0\n\t"
+		     "and	%1, %0\n\t"
+		     "or	%2, %0\n\t"
+		     "ldc	%0, sr\n"
+		     "1:"
+		     : "=&z" (__dummy)
+		     : "r" (~0xf0), "r" (ip << 4)
+		     : "t");
+}
+
+static void disable_imask_irq(unsigned int irq)
+{
+	clear_bit(irq, &imask_mask);
+	if (interrupt_priority < IMASK_PRIORITY - irq)
+		interrupt_priority = IMASK_PRIORITY - irq;
+
+	set_interrupt_registers(interrupt_priority);
+}
+
+static void enable_imask_irq(unsigned int irq)
+{
+	set_bit(irq, &imask_mask);
+	interrupt_priority = IMASK_PRIORITY - ffz(imask_mask);
+
+	set_interrupt_registers(interrupt_priority);
+}
+
+static void mask_and_ack_imask(unsigned int irq)
+{
+	disable_imask_irq(irq);
+}
+
+static void end_imask_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_imask_irq(irq);
+}
+
+static void shutdown_imask_irq(unsigned int irq)
+{
+	/* Nothing to do */
+}
+
+void make_imask_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	irq_desc[irq].handler = &imask_irq_type;
+	enable_irq(irq);
+}
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq/intc2.c sh-2.6.15/arch/sh/kernel/cpu/irq/intc2.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq/intc2.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq/intc2.c	2006-01-07 22:13:59.133149975 +0200
@@ -0,0 +1,284 @@
+/*
+ * Interrupt handling for INTC2-based IRQ.
+ *
+ * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
+ * Copyright (C) 2005, 2006 Paul Mundt (lethal@linux-sh.org)
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ * These are the "new Hitachi style" interrupts, as present on the
+ * Hitachi 7751, the STM ST40 STB1, SH7760, and SH7780.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machvec.h>
+
+struct intc2_data {
+	unsigned char msk_offset;
+	unsigned char msk_shift;
+
+	int (*clear_irq) (int);
+};
+
+static struct intc2_data intc2_data[NR_INTC2_IRQS];
+
+static void enable_intc2_irq(unsigned int irq);
+static void disable_intc2_irq(unsigned int irq);
+
+/* shutdown is same as "disable" */
+#define shutdown_intc2_irq disable_intc2_irq
+
+static void mask_and_ack_intc2(unsigned int);
+static void end_intc2_irq(unsigned int irq);
+
+static unsigned int startup_intc2_irq(unsigned int irq)
+{
+	enable_intc2_irq(irq);
+	return 0; /* never anything pending */
+}
+
+static struct hw_interrupt_type intc2_irq_type = {
+	.typename	= "INTC2-IRQ",
+	.startup	= startup_intc2_irq,
+	.shutdown	= shutdown_intc2_irq,
+	.enable		= enable_intc2_irq,
+	.disable	= disable_intc2_irq,
+	.ack		= mask_and_ack_intc2,
+	.end		= end_intc2_irq
+};
+
+static void disable_intc2_irq(unsigned int irq)
+{
+	int irq_offset = irq - INTC2_FIRST_IRQ;
+	int msk_shift, msk_offset;
+
+	/* Sanity check */
+	if (unlikely(irq_offset < 0 || irq_offset >= NR_INTC2_IRQS))
+		return;
+
+	msk_shift = intc2_data[irq_offset].msk_shift;
+	msk_offset = intc2_data[irq_offset].msk_offset;
+
+	ctrl_outl(1 << msk_shift,
+		  INTC2_BASE + INTC2_INTMSK_OFFSET + msk_offset);
+}
+
+static void enable_intc2_irq(unsigned int irq)
+{
+	int irq_offset = irq - INTC2_FIRST_IRQ;
+	int msk_shift, msk_offset;
+
+	/* Sanity check */
+	if (unlikely(irq_offset < 0 || irq_offset >= NR_INTC2_IRQS))
+		return;
+
+	msk_shift = intc2_data[irq_offset].msk_shift;
+	msk_offset = intc2_data[irq_offset].msk_offset;
+
+	ctrl_outl(1 << msk_shift,
+		  INTC2_BASE + INTC2_INTMSKCLR_OFFSET + msk_offset);
+}
+
+static void mask_and_ack_intc2(unsigned int irq)
+{
+	disable_intc2_irq(irq);
+}
+
+static void end_intc2_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_intc2_irq(irq);
+
+	if (unlikely(intc2_data[irq - INTC2_FIRST_IRQ].clear_irq))
+		intc2_data[irq - INTC2_FIRST_IRQ].clear_irq(irq);
+}
+
+/*
+ * Setup an INTC2 style interrupt.
+ * NOTE: Unlike IPR interrupts, parameters are not shifted by this code,
+ * allowing the use of the numbers straight out of the datasheet.
+ * For example:
+ *    PIO1 which is INTPRI00[19,16] and INTMSK00[13]
+ * would be:               ^     ^             ^  ^
+ *                         |     |             |  |
+ *    make_intc2_irq(84,   0,   16,            0, 13);
+ */
+void make_intc2_irq(unsigned int irq,
+		    unsigned int ipr_offset, unsigned int ipr_shift,
+		    unsigned int msk_offset, unsigned int msk_shift,
+		    unsigned int priority)
+{
+	int irq_offset = irq - INTC2_FIRST_IRQ;
+	unsigned int flags;
+	unsigned long ipr;
+
+	if (unlikely(irq_offset < 0 || irq_offset >= NR_INTC2_IRQS))
+		return;
+
+	disable_irq_nosync(irq);
+
+	/* Fill the data we need */
+	intc2_data[irq_offset].msk_offset = msk_offset;
+	intc2_data[irq_offset].msk_shift  = msk_shift;
+	intc2_data[irq_offset].clear_irq = NULL;
+
+	/* Set the priority level */
+	local_irq_save(flags);
+
+	ipr = ctrl_inl(INTC2_BASE + INTC2_INTPRI_OFFSET + ipr_offset);
+	ipr &= ~(0xf << ipr_shift);
+	ipr |= priority << ipr_shift;
+	ctrl_outl(ipr, INTC2_BASE + INTC2_INTPRI_OFFSET + ipr_offset);
+
+	local_irq_restore(flags);
+
+	irq_desc[irq].handler = &intc2_irq_type;
+
+	disable_intc2_irq(irq);
+}
+
+static struct intc2_init {
+	unsigned short irq;
+	unsigned char ipr_offset, ipr_shift;
+	unsigned char msk_offset, msk_shift;
+	unsigned char priority;
+} intc2_init_data[]  __initdata = {
+#if defined(CONFIG_CPU_SUBTYPE_ST40)
+	{64,  0,  0, 0,  0, 13},	/* PCI serr */
+	{65,  0,  4, 0,  1, 13},	/* PCI err */
+	{66,  0,  4, 0,  2, 13},	/* PCI ad */
+	{67,  0,  4, 0,  3, 13},	/* PCI pwd down */
+	{72,  0,  8, 0,  5, 13},	/* DMAC INT0 */
+	{73,  0,  8, 0,  6, 13},	/* DMAC INT1 */
+	{74,  0,  8, 0,  7, 13},	/* DMAC INT2 */
+	{75,  0,  8, 0,  8, 13},	/* DMAC INT3 */
+	{76,  0,  8, 0,  9, 13},	/* DMAC INT4 */
+	{78,  0,  8, 0, 11, 13},	/* DMAC ERR */
+	{80,  0, 12, 0, 12, 13},	/* PIO0 */
+	{84,  0, 16, 0, 13, 13},	/* PIO1 */
+	{88,  0, 20, 0, 14, 13},	/* PIO2 */
+	{112, 4,  0, 4,  0, 13},	/* Mailbox */
+ #ifdef CONFIG_CPU_SUBTYPE_ST40GX1
+	{116, 4,  4, 4,  4, 13},	/* SSC0 */
+	{120, 4,  8, 4,  8, 13},	/* IR Blaster */
+	{124, 4, 12, 4, 12, 13},	/* USB host */
+	{128, 4, 16, 4, 16, 13},	/* Video processor BLITTER */
+	{132, 4, 20, 4, 20, 13},	/* UART0 */
+	{134, 4, 20, 4, 22, 13},	/* UART2 */
+	{136, 4, 24, 4, 24, 13},	/* IO_PIO0 */
+	{140, 4, 28, 4, 28, 13},	/* EMPI */
+	{144, 8,  0, 8,  0, 13},	/* MAFE */
+	{148, 8,  4, 8,  4, 13},	/* PWM */
+	{152, 8,  8, 8,  8, 13},	/* SSC1 */
+	{156, 8, 12, 8, 12, 13},	/* IO_PIO1 */
+	{160, 8, 16, 8, 16, 13},	/* USB target */
+	{164, 8, 20, 8, 20, 13},	/* UART1 */
+	{168, 8, 24, 8, 24, 13},	/* Teletext */
+	{172, 8, 28, 8, 28, 13},	/* VideoSync VTG */
+	{173, 8, 28, 8, 29, 13},	/* VideoSync DVP0 */
+	{174, 8, 28, 8, 30, 13},	/* VideoSync DVP1 */
+#endif
+#elif defined(CONFIG_CPU_SUBTYPE_SH7760)
+/*
+ * SH7760 INTC2-Style interrupts, vectors IRQ48-111 INTEVT 0x800-0xFE0
+ */
+	/* INTPRIO0 | INTMSK0 */
+	{48,  0, 28, 0, 31,  3},	/* IRQ 4 */
+	{49,  0, 24, 0, 30,  3},	/* IRQ 3 */
+	{50,  0, 20, 0, 29,  3},	/* IRQ 2 */
+	{51,  0, 16, 0, 28,  3},	/* IRQ 1 */
+	/* 52-55 (INTEVT 0x880-0x8E0) unused/reserved */
+	/* INTPRIO4 | INTMSK0 */
+	{56,  4, 28, 0, 25,  3},	/* HCAN2_CHAN0 */
+	{57,  4, 24, 0, 24,  3},	/* HCAN2_CHAN1 */
+	{58,  4, 20, 0, 23,  3},	/* I2S_CHAN0   */
+	{59,  4, 16, 0, 22,  3},	/* I2S_CHAN1   */
+	{60,  4, 12, 0, 21,  3},	/* AC97_CHAN0  */
+	{61,  4,  8, 0, 20,  3},	/* AC97_CHAN1  */
+	{62,  4,  4, 0, 19,  3},	/* I2C_CHAN0   */
+	{63,  4,  0, 0, 18,  3},	/* I2C_CHAN1   */
+	/* INTPRIO8 | INTMSK0 */
+	{52,  8, 16, 0, 11,  3},	/* SCIF0_ERI_IRQ */
+	{53,  8, 16, 0, 10,  3},	/* SCIF0_RXI_IRQ */
+	{54,  8, 16, 0,  9,  3},	/* SCIF0_BRI_IRQ */
+	{55,  8, 16, 0,  8,  3},	/* SCIF0_TXI_IRQ */
+	{64,  8, 28, 0, 17,  3},	/* USBHI_IRQ */
+	{65,  8, 24, 0, 16,  3},	/* LCDC      */
+	/* 66, 67 unused */
+	{68,  8, 20, 0, 14, 13},	/* DMABRGI0_IRQ */
+	{69,  8, 20, 0, 13, 13},	/* DMABRGI1_IRQ */
+	{70,  8, 20, 0, 12, 13},	/* DMABRGI2_IRQ */
+	/* 71 unused */
+	{72,  8, 12, 0,  7,  3},	/* SCIF1_ERI_IRQ */
+	{73,  8, 12, 0,  6,  3},	/* SCIF1_RXI_IRQ */
+	{74,  8, 12, 0,  5,  3},	/* SCIF1_BRI_IRQ */
+	{75,  8, 12, 0,  4,  3},	/* SCIF1_TXI_IRQ */
+	{76,  8,  8, 0,  3,  3},	/* SCIF2_ERI_IRQ */
+	{77,  8,  8, 0,  2,  3},	/* SCIF2_RXI_IRQ */
+	{78,  8,  8, 0,  1,  3},	/* SCIF2_BRI_IRQ */
+	{79,  8,  8, 0,  0,  3},	/* SCIF2_TXI_IRQ */
+	/*          | INTMSK4 */
+	{80,  8,  4, 4, 23,  3},	/* SIM_ERI */
+	{81,  8,  4, 4, 22,  3},	/* SIM_RXI */
+	{82,  8,  4, 4, 21,  3},	/* SIM_TXI */
+	{83,  8,  4, 4, 20,  3},	/* SIM_TEI */
+	{84,  8,  0, 4, 19,  3},	/* HSPII */
+	/* INTPRIOC | INTMSK4 */
+	/* 85-87 unused/reserved */
+	{88, 12, 20, 4, 18,  3},	/* MMCI0 */
+	{89, 12, 20, 4, 17,  3},	/* MMCI1 */
+	{90, 12, 20, 4, 16,  3},	/* MMCI2 */
+	{91, 12, 20, 4, 15,  3},	/* MMCI3 */
+	{92, 12, 12, 4,  6,  3},	/* MFI (unsure, bug? in my 7760 manual*/
+	/* 93-107 reserved/undocumented */
+	{108,12,  4, 4,  1,  3},	/* ADC  */
+	{109,12,  0, 4,  0,  3},	/* CMTI */
+	/* 110-111 reserved/unused */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+	{ TIMER_IRQ, 0, 24, 0, INTC_TMU0_MSK, 2},
+#ifdef CONFIG_SH_RTC
+	{ RTC_IRQ, 4, 0, 0, INTC_RTC_MSK, TIMER_PRIORITY },
+#endif
+	{ SCIF0_ERI_IRQ, 8, 24, 0, INTC_SCIF0_MSK, SCIF0_PRIORITY },
+	{ SCIF0_RXI_IRQ, 8, 24, 0, INTC_SCIF0_MSK, SCIF0_PRIORITY },
+	{ SCIF0_BRI_IRQ, 8, 24, 0, INTC_SCIF0_MSK, SCIF0_PRIORITY },
+	{ SCIF0_TXI_IRQ, 8, 24, 0, INTC_SCIF0_MSK, SCIF0_PRIORITY },
+
+	{ SCIF1_ERI_IRQ, 8, 16, 0, INTC_SCIF1_MSK, SCIF1_PRIORITY },
+	{ SCIF1_RXI_IRQ, 8, 16, 0, INTC_SCIF1_MSK, SCIF1_PRIORITY },
+	{ SCIF1_BRI_IRQ, 8, 16, 0, INTC_SCIF1_MSK, SCIF1_PRIORITY },
+	{ SCIF1_TXI_IRQ, 8, 16, 0, INTC_SCIF1_MSK, SCIF1_PRIORITY },
+
+	{ PCIC0_IRQ, 0x10,  8, 0, INTC_PCIC0_MSK, PCIC0_PRIORITY },
+	{ PCIC1_IRQ, 0x10,  0, 0, INTC_PCIC1_MSK, PCIC1_PRIORITY },
+	{ PCIC2_IRQ, 0x14, 24, 0, INTC_PCIC2_MSK, PCIC2_PRIORITY },
+	{ PCIC3_IRQ, 0x14, 16, 0, INTC_PCIC3_MSK, PCIC3_PRIORITY },
+	{ PCIC4_IRQ, 0x14,  8, 0, INTC_PCIC4_MSK, PCIC4_PRIORITY },
+#endif
+};
+
+void __init init_IRQ_intc2(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(intc2_init_data); i++) {
+		struct intc2_init *p = intc2_init_data + i;
+		make_intc2_irq(p->irq, p->ipr_offset, p->ipr_shift,
+			       p-> msk_offset, p->msk_shift, p->priority);
+	}
+}
+
+/* Adds a termination callback to the interrupt */
+void intc2_add_clear_irq(int irq, int (*fn)(int))
+{
+	if (unlikely(irq < INTC2_FIRST_IRQ))
+		return;
+
+	intc2_data[irq - INTC2_FIRST_IRQ].clear_irq = fn;
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq/ipr.c sh-2.6.15/arch/sh/kernel/cpu/irq/ipr.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq/ipr.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq/ipr.c	2006-01-07 22:13:59.139149503 +0200
@@ -0,0 +1,206 @@
+/*
+ * arch/sh/kernel/cpu/irq/ipr.c
+ *
+ * Copyright (C) 1999  Niibe Yutaka & Takeshi Yaegashi
+ * Copyright (C) 2000  Kazumoto Kojima
+ * Copyright (C) 2003 Takashi Kusuda <kusuda-takashi@hitachi-ul.co.jp>
+ *
+ * Interrupt handling for IPR-based IRQ.
+ *
+ * Supported system:
+ *	On-chip supporting modules (TMU, RTC, etc.).
+ *	On-chip supporting modules for SH7709/SH7709A/SH7729/SH7300.
+ *	Hitachi SolutionEngine external I/O:
+ *		MS7709SE01, MS7709ASE01, and MS7750SE01
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machvec.h>
+
+struct ipr_data {
+	unsigned int addr;	/* Address of Interrupt Priority Register */
+	int shift;		/* Shifts of the 16-bit data */
+	int priority;		/* The priority */
+};
+static struct ipr_data ipr_data[NR_IRQS];
+
+static void enable_ipr_irq(unsigned int irq);
+static void disable_ipr_irq(unsigned int irq);
+
+/* shutdown is same as "disable" */
+#define shutdown_ipr_irq disable_ipr_irq
+
+static void mask_and_ack_ipr(unsigned int);
+static void end_ipr_irq(unsigned int irq);
+
+static unsigned int startup_ipr_irq(unsigned int irq)
+{
+	enable_ipr_irq(irq);
+	return 0; /* never anything pending */
+}
+
+static struct hw_interrupt_type ipr_irq_type = {
+	.typename = "IPR-IRQ",
+	.startup = startup_ipr_irq,
+	.shutdown = shutdown_ipr_irq,
+	.enable = enable_ipr_irq,
+	.disable = disable_ipr_irq,
+	.ack = mask_and_ack_ipr,
+	.end = end_ipr_irq
+};
+
+static void disable_ipr_irq(unsigned int irq)
+{
+	unsigned long val, flags;
+	unsigned int addr = ipr_data[irq].addr;
+	unsigned short mask = 0xffff ^ (0x0f << ipr_data[irq].shift);
+
+	/* Set the priority in IPR to 0 */
+	local_irq_save(flags);
+	val = ctrl_inw(addr);
+	val &= mask;
+	ctrl_outw(val, addr);
+	local_irq_restore(flags);
+}
+
+static void enable_ipr_irq(unsigned int irq)
+{
+	unsigned long val, flags;
+	unsigned int addr = ipr_data[irq].addr;
+	int priority = ipr_data[irq].priority;
+	unsigned short value = (priority << ipr_data[irq].shift);
+
+	/* Set priority in IPR back to original value */
+	local_irq_save(flags);
+	val = ctrl_inw(addr);
+	val |= value;
+	ctrl_outw(val, addr);
+	local_irq_restore(flags);
+}
+
+static void mask_and_ack_ipr(unsigned int irq)
+{
+	disable_ipr_irq(irq);
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
+	/* This is needed when we use edge triggered setting */
+	/* XXX: Is it really needed? */
+	if (IRQ0_IRQ <= irq && irq <= IRQ5_IRQ) {
+		/* Clear external interrupt request */
+		int a = ctrl_inb(INTC_IRR0);
+		a &= ~(1 << (irq - IRQ0_IRQ));
+		ctrl_outb(a, INTC_IRR0);
+	}
+#endif
+}
+
+static void end_ipr_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_ipr_irq(irq);
+}
+
+void make_ipr_irq(unsigned int irq, unsigned int addr, int pos,
+		  int priority, int maskpos)
+{
+	disable_irq_nosync(irq);
+	ipr_data[irq].addr = addr;
+	ipr_data[irq].shift = pos*4; /* POSition (0-3) x 4 means shift */
+	ipr_data[irq].priority = priority;
+
+	irq_desc[irq].handler = &ipr_irq_type;
+	disable_ipr_irq(irq);
+}
+
+void __init init_IRQ(void)
+{
+#ifndef CONFIG_CPU_SUBTYPE_SH7780
+	make_ipr_irq(TIMER_IRQ, TIMER_IPR_ADDR, TIMER_IPR_POS, TIMER_PRIORITY, 0);
+	make_ipr_irq(TIMER1_IRQ, TIMER1_IPR_ADDR, TIMER1_IPR_POS, TIMER1_PRIORITY, 0);
+#if defined(CONFIG_SH_RTC)
+	make_ipr_irq(RTC_IRQ, RTC_IPR_ADDR, RTC_IPR_POS, RTC_PRIORITY, 0);
+#endif
+
+#ifdef SCI_ERI_IRQ
+	make_ipr_irq(SCI_ERI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
+	make_ipr_irq(SCI_RXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
+	make_ipr_irq(SCI_TXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY, 0);
+#endif
+
+#ifdef SCIF1_ERI_IRQ
+	make_ipr_irq(SCIF1_ERI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
+	make_ipr_irq(SCIF1_RXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
+	make_ipr_irq(SCIF1_BRI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
+	make_ipr_irq(SCIF1_TXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY, 0);
+#endif
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7300)
+	make_ipr_irq(SCIF0_IRQ, SCIF0_IPR_ADDR, SCIF0_IPR_POS, SCIF0_PRIORITY, 0);
+	make_ipr_irq(DMTE2_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY, 0);
+	make_ipr_irq(DMTE3_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY, 0);
+	make_ipr_irq(VIO_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY, 0);
+#endif
+
+#ifdef SCIF_ERI_IRQ
+	make_ipr_irq(SCIF_ERI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
+	make_ipr_irq(SCIF_RXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
+	make_ipr_irq(SCIF_BRI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
+	make_ipr_irq(SCIF_TXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY, 0);
+#endif
+
+#ifdef IRDA_ERI_IRQ
+	make_ipr_irq(IRDA_ERI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
+	make_ipr_irq(IRDA_RXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
+	make_ipr_irq(IRDA_BRI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
+	make_ipr_irq(IRDA_TXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY, 0);
+#endif
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
+	/*
+	 * Initialize the Interrupt Controller (INTC)
+	 * registers to their power on values
+	 */
+
+	/*
+	 * Enable external irq (INTC IRQ mode).
+	 * You should set corresponding bits of PFC to "00"
+	 * to enable these interrupts.
+	 */
+	make_ipr_irq(IRQ0_IRQ, IRQ0_IPR_ADDR, IRQ0_IPR_POS, IRQ0_PRIORITY, 0);
+	make_ipr_irq(IRQ1_IRQ, IRQ1_IPR_ADDR, IRQ1_IPR_POS, IRQ1_PRIORITY, 0);
+	make_ipr_irq(IRQ2_IRQ, IRQ2_IPR_ADDR, IRQ2_IPR_POS, IRQ2_PRIORITY, 0);
+	make_ipr_irq(IRQ3_IRQ, IRQ3_IPR_ADDR, IRQ3_IPR_POS, IRQ3_PRIORITY, 0);
+	make_ipr_irq(IRQ4_IRQ, IRQ4_IPR_ADDR, IRQ4_IPR_POS, IRQ4_PRIORITY, 0);
+	make_ipr_irq(IRQ5_IRQ, IRQ5_IPR_ADDR, IRQ5_IPR_POS, IRQ5_PRIORITY, 0);
+#endif
+#endif
+
+#ifdef CONFIG_CPU_HAS_PINT_IRQ
+	init_IRQ_pint();
+#endif
+
+#ifdef CONFIG_CPU_HAS_INTC2_IRQ
+	init_IRQ_intc2();
+#endif
+	/* Perform the machine specific initialisation */
+	if (sh_mv.mv_init_irq != NULL)
+		sh_mv.mv_init_irq();
+}
+
+#if !defined(CONFIG_CPU_HAS_PINT_IRQ)
+int ipr_irq_demux(int irq)
+{
+	return irq;
+}
+#endif
+
+EXPORT_SYMBOL(make_ipr_irq);
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq/pint.c sh-2.6.15/arch/sh/kernel/cpu/irq/pint.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq/pint.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq/pint.c	2006-01-07 22:13:59.144149110 +0200
@@ -0,0 +1,169 @@
+/*
+ * arch/sh/kernel/cpu/irq/pint.c - Interrupt handling for PINT-based IRQs.
+ *
+ * Copyright (C) 1999  Niibe Yutaka & Takeshi Yaegashi
+ * Copyright (C) 2000  Kazumoto Kojima
+ * Copyright (C) 2003 Takashi Kusuda <kusuda-takashi@hitachi-ul.co.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machvec.h>
+
+static unsigned char pint_map[256];
+static unsigned long portcr_mask;
+
+static void enable_pint_irq(unsigned int irq);
+static void disable_pint_irq(unsigned int irq);
+
+/* shutdown is same as "disable" */
+#define shutdown_pint_irq disable_pint_irq
+
+static void mask_and_ack_pint(unsigned int);
+static void end_pint_irq(unsigned int irq);
+
+static unsigned int startup_pint_irq(unsigned int irq)
+{
+	enable_pint_irq(irq);
+	return 0; /* never anything pending */
+}
+
+static struct hw_interrupt_type pint_irq_type = {
+	.typename = "PINT-IRQ",
+	.startup = startup_pint_irq,
+	.shutdown = shutdown_pint_irq,
+	.enable = enable_pint_irq,
+	.disable = disable_pint_irq,
+	.ack = mask_and_ack_pint,
+	.end = end_pint_irq
+};
+
+static void disable_pint_irq(unsigned int irq)
+{
+	unsigned long val, flags;
+
+	local_irq_save(flags);
+	val = ctrl_inw(INTC_INTER);
+	val &= ~(1 << (irq - PINT_IRQ_BASE));
+	ctrl_outw(val, INTC_INTER);	/* disable PINTn */
+	portcr_mask &= ~(3 << (irq - PINT_IRQ_BASE)*2);
+	local_irq_restore(flags);
+}
+
+static void enable_pint_irq(unsigned int irq)
+{
+	unsigned long val, flags;
+
+	local_irq_save(flags);
+	val = ctrl_inw(INTC_INTER);
+	val |= 1 << (irq - PINT_IRQ_BASE);
+	ctrl_outw(val, INTC_INTER);	/* enable PINTn */
+	portcr_mask |= 3 << (irq - PINT_IRQ_BASE)*2;
+	local_irq_restore(flags);
+}
+
+static void mask_and_ack_pint(unsigned int irq)
+{
+	disable_pint_irq(irq);
+}
+
+static void end_pint_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_pint_irq(irq);
+}
+
+void make_pint_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	irq_desc[irq].handler = &pint_irq_type;
+	disable_pint_irq(irq);
+}
+
+void __init init_IRQ_pint(void)
+{
+	int i;
+
+	make_ipr_irq(PINT0_IRQ, PINT0_IPR_ADDR, PINT0_IPR_POS, PINT0_PRIORITY);
+	make_ipr_irq(PINT8_IRQ, PINT8_IPR_ADDR, PINT8_IPR_POS, PINT8_PRIORITY);
+
+	enable_irq(PINT0_IRQ);
+	enable_irq(PINT8_IRQ);
+
+	for(i = 0; i < 16; i++)
+		make_pint_irq(PINT_IRQ_BASE + i);
+
+	for(i = 0; i < 256; i++) {
+		if (i & 1)
+			pint_map[i] = 0;
+		else if (i & 2)
+			pint_map[i] = 1;
+		else if (i & 4)
+			pint_map[i] = 2;
+		else if (i & 8)
+			pint_map[i] = 3;
+		else if (i & 0x10)
+			pint_map[i] = 4;
+		else if (i & 0x20)
+			pint_map[i] = 5;
+		else if (i & 0x40)
+			pint_map[i] = 6;
+		else if (i & 0x80)
+			pint_map[i] = 7;
+	}
+}
+
+int ipr_irq_demux(int irq)
+{
+	unsigned long creg, dreg, d, sav;
+
+	if (irq == PINT0_IRQ) {
+#if defined(CONFIG_CPU_SUBTYPE_SH7707)
+		creg = PORT_PACR;
+		dreg = PORT_PADR;
+#else
+		creg = PORT_PCCR;
+		dreg = PORT_PCDR;
+#endif
+		sav = ctrl_inw(creg);
+		ctrl_outw(sav | portcr_mask, creg);
+		d = (~ctrl_inb(dreg) ^ ctrl_inw(INTC_ICR2)) &
+			ctrl_inw(INTC_INTER) & 0xff;
+		ctrl_outw(sav, creg);
+
+		if (d == 0)
+			return irq;
+
+		return PINT_IRQ_BASE + pint_map[d];
+	} else if (irq == PINT8_IRQ) {
+#if defined(CONFIG_CPU_SUBTYPE_SH7707)
+		creg = PORT_PBCR;
+		dreg = PORT_PBDR;
+#else
+		creg = PORT_PFCR;
+		dreg = PORT_PFDR;
+#endif
+		sav = ctrl_inw(creg);
+		ctrl_outw(sav | (portcr_mask >> 16), creg);
+		d = (~ctrl_inb(dreg) ^ (ctrl_inw(INTC_ICR2) >> 8)) &
+			(ctrl_inw(INTC_INTER) >> 8) & 0xff;
+		ctrl_outw(sav, creg);
+
+		if (d == 0)
+			return irq;
+
+		return PINT_IRQ_BASE + 8 + pint_map[d];
+	}
+
+	return irq;
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq_imask.c sh-2.6.15/arch/sh/kernel/cpu/irq_imask.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq_imask.c	2005-11-12 20:17:23.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq_imask.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,116 +0,0 @@
-/* $Id: irq_imask.c,v 1.1.2.1 2002/11/17 10:53:43 mrbrown Exp $
- *
- * linux/arch/sh/kernel/irq_imask.c
- *
- * Copyright (C) 1999, 2000  Niibe Yutaka
- *
- * Simple interrupt handling using IMASK of SR register.
- *
- */
-
-/* NOTE: Will not work on level 15 */
-
-
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/bitops.h>
-
-#include <asm/system.h>
-#include <asm/irq.h>
-
-#include <linux/spinlock.h>
-#include <linux/cache.h>
-#include <linux/irq.h>
-
-/* Bitmap of IRQ masked */
-static unsigned long imask_mask = 0x7fff;
-static int interrupt_priority = 0;
-
-static void enable_imask_irq(unsigned int irq);
-static void disable_imask_irq(unsigned int irq);
-static void shutdown_imask_irq(unsigned int irq);
-static void mask_and_ack_imask(unsigned int);
-static void end_imask_irq(unsigned int irq);
-
-#define IMASK_PRIORITY	15
-
-static unsigned int startup_imask_irq(unsigned int irq)
-{ 
-	/* Nothing to do */
-	return 0; /* never anything pending */
-}
-
-static struct hw_interrupt_type imask_irq_type = {
-	.typename = "SR.IMASK",
-	.startup = startup_imask_irq,
-	.shutdown = shutdown_imask_irq,
-	.enable = enable_imask_irq,
-	.disable = disable_imask_irq,
-	.ack = mask_and_ack_imask,
-	.end = end_imask_irq
-};
-
-void static inline set_interrupt_registers(int ip)
-{
-	unsigned long __dummy;
-
-	asm volatile("ldc	%2, r6_bank\n\t"
-		     "stc	sr, %0\n\t"
-		     "and	#0xf0, %0\n\t"
-		     "shlr2	%0\n\t"
-		     "cmp/eq	#0x3c, %0\n\t"
-		     "bt/s	1f	! CLI-ed\n\t"
-		     " stc	sr, %0\n\t"
-		     "and	%1, %0\n\t"
-		     "or	%2, %0\n\t"
-		     "ldc	%0, sr\n"
-		     "1:"
-		     : "=&z" (__dummy)
-		     : "r" (~0xf0), "r" (ip << 4)
-		     : "t");
-}
-
-static void disable_imask_irq(unsigned int irq)
-{
-	clear_bit(irq, &imask_mask);
-	if (interrupt_priority < IMASK_PRIORITY - irq)
-		interrupt_priority = IMASK_PRIORITY - irq;
-
-	set_interrupt_registers(interrupt_priority);
-}
-
-static void enable_imask_irq(unsigned int irq)
-{
-	set_bit(irq, &imask_mask);
-	interrupt_priority = IMASK_PRIORITY - ffz(imask_mask);
-
-	set_interrupt_registers(interrupt_priority);
-}
-
-static void mask_and_ack_imask(unsigned int irq)
-{
-	disable_imask_irq(irq);
-}
-
-static void end_imask_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_imask_irq(irq);
-}
-
-static void shutdown_imask_irq(unsigned int irq)
-{
-	/* Nothing to do */
-}
-
-void make_imask_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	irq_desc[irq].handler = &imask_irq_type;
-	enable_irq(irq);
-}
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/irq_ipr.c sh-2.6.15/arch/sh/kernel/cpu/irq_ipr.c
--- linux-2.6.15/arch/sh/kernel/cpu/irq_ipr.c	2005-11-12 20:17:23.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/irq_ipr.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,339 +0,0 @@
-/* $Id: irq_ipr.c,v 1.1.2.1 2002/11/17 10:53:43 mrbrown Exp $
- *
- * linux/arch/sh/kernel/irq_ipr.c
- *
- * Copyright (C) 1999  Niibe Yutaka & Takeshi Yaegashi
- * Copyright (C) 2000  Kazumoto Kojima
- * Copyright (C) 2003 Takashi Kusuda <kusuda-takashi@hitachi-ul.co.jp>
- *
- * Interrupt handling for IPR-based IRQ.
- *
- * Supported system:
- *	On-chip supporting modules (TMU, RTC, etc.).
- *	On-chip supporting modules for SH7709/SH7709A/SH7729/SH7300.
- *	Hitachi SolutionEngine external I/O:
- *		MS7709SE01, MS7709ASE01, and MS7750SE01
- *
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/machvec.h>
-
-struct ipr_data {
-	unsigned int addr;	/* Address of Interrupt Priority Register */
-	int shift;		/* Shifts of the 16-bit data */
-	int priority;		/* The priority */
-};
-static struct ipr_data ipr_data[NR_IRQS];
-
-static void enable_ipr_irq(unsigned int irq);
-static void disable_ipr_irq(unsigned int irq);
-
-/* shutdown is same as "disable" */
-#define shutdown_ipr_irq disable_ipr_irq
-
-static void mask_and_ack_ipr(unsigned int);
-static void end_ipr_irq(unsigned int irq);
-
-static unsigned int startup_ipr_irq(unsigned int irq)
-{
-	enable_ipr_irq(irq);
-	return 0; /* never anything pending */
-}
-
-static struct hw_interrupt_type ipr_irq_type = {
-	.typename = "IPR-IRQ",
-	.startup = startup_ipr_irq,
-	.shutdown = shutdown_ipr_irq,
-	.enable = enable_ipr_irq,
-	.disable = disable_ipr_irq,
-	.ack = mask_and_ack_ipr,
-	.end = end_ipr_irq
-};
-
-static void disable_ipr_irq(unsigned int irq)
-{
-	unsigned long val, flags;
-	unsigned int addr = ipr_data[irq].addr;
-	unsigned short mask = 0xffff ^ (0x0f << ipr_data[irq].shift);
-
-	/* Set the priority in IPR to 0 */
-	local_irq_save(flags);
-	val = ctrl_inw(addr);
-	val &= mask;
-	ctrl_outw(val, addr);
-	local_irq_restore(flags);
-}
-
-static void enable_ipr_irq(unsigned int irq)
-{
-	unsigned long val, flags;
-	unsigned int addr = ipr_data[irq].addr;
-	int priority = ipr_data[irq].priority;
-	unsigned short value = (priority << ipr_data[irq].shift);
-
-	/* Set priority in IPR back to original value */
-	local_irq_save(flags);
-	val = ctrl_inw(addr);
-	val |= value;
-	ctrl_outw(val, addr);
-	local_irq_restore(flags);
-}
-
-static void mask_and_ack_ipr(unsigned int irq)
-{
-	disable_ipr_irq(irq);
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
-	/* This is needed when we use edge triggered setting */
-	/* XXX: Is it really needed? */
-	if (IRQ0_IRQ <= irq && irq <= IRQ5_IRQ) {
-		/* Clear external interrupt request */
-		int a = ctrl_inb(INTC_IRR0);
-		a &= ~(1 << (irq - IRQ0_IRQ));
-		ctrl_outb(a, INTC_IRR0);
-	}
-#endif
-}
-
-static void end_ipr_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_ipr_irq(irq);
-}
-
-void make_ipr_irq(unsigned int irq, unsigned int addr, int pos, int priority)
-{
-	disable_irq_nosync(irq);
-	ipr_data[irq].addr = addr;
-	ipr_data[irq].shift = pos*4; /* POSition (0-3) x 4 means shift */
-	ipr_data[irq].priority = priority;
-
-	irq_desc[irq].handler = &ipr_irq_type;
-	disable_ipr_irq(irq);
-}
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7709)
-static unsigned char pint_map[256];
-static unsigned long portcr_mask = 0;
-
-static void enable_pint_irq(unsigned int irq);
-static void disable_pint_irq(unsigned int irq);
-
-/* shutdown is same as "disable" */
-#define shutdown_pint_irq disable_pint_irq
-
-static void mask_and_ack_pint(unsigned int);
-static void end_pint_irq(unsigned int irq);
-
-static unsigned int startup_pint_irq(unsigned int irq)
-{
-	enable_pint_irq(irq);
-	return 0; /* never anything pending */
-}
-
-static struct hw_interrupt_type pint_irq_type = {
-	.typename = "PINT-IRQ",
-	.startup = startup_pint_irq,
-	.shutdown = shutdown_pint_irq,
-	.enable = enable_pint_irq,
-	.disable = disable_pint_irq,
-	.ack = mask_and_ack_pint,
-	.end = end_pint_irq
-};
-
-static void disable_pint_irq(unsigned int irq)
-{
-	unsigned long val, flags;
-
-	local_irq_save(flags);
-	val = ctrl_inw(INTC_INTER);
-	val &= ~(1 << (irq - PINT_IRQ_BASE));
-	ctrl_outw(val, INTC_INTER);	/* disable PINTn */
-	portcr_mask &= ~(3 << (irq - PINT_IRQ_BASE)*2);
-	local_irq_restore(flags);
-}
-
-static void enable_pint_irq(unsigned int irq)
-{
-	unsigned long val, flags;
-
-	local_irq_save(flags);
-	val = ctrl_inw(INTC_INTER);
-	val |= 1 << (irq - PINT_IRQ_BASE);
-	ctrl_outw(val, INTC_INTER);	/* enable PINTn */
-	portcr_mask |= 3 << (irq - PINT_IRQ_BASE)*2;
-	local_irq_restore(flags);
-}
-
-static void mask_and_ack_pint(unsigned int irq)
-{
-	disable_pint_irq(irq);
-}
-
-static void end_pint_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_pint_irq(irq);
-}
-
-void make_pint_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	irq_desc[irq].handler = &pint_irq_type;
-	disable_pint_irq(irq);
-}
-#endif
-
-void __init init_IRQ(void)
-{
-#if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7709)
-	int i;
-#endif
-
-	make_ipr_irq(TIMER_IRQ, TIMER_IPR_ADDR, TIMER_IPR_POS, TIMER_PRIORITY);
-	make_ipr_irq(TIMER1_IRQ, TIMER1_IPR_ADDR, TIMER1_IPR_POS, TIMER1_PRIORITY);
-#if defined(CONFIG_SH_RTC)
-	make_ipr_irq(RTC_IRQ, RTC_IPR_ADDR, RTC_IPR_POS, RTC_PRIORITY);
-#endif
-
-#ifdef SCI_ERI_IRQ
-	make_ipr_irq(SCI_ERI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
-	make_ipr_irq(SCI_RXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
-	make_ipr_irq(SCI_TXI_IRQ, SCI_IPR_ADDR, SCI_IPR_POS, SCI_PRIORITY);
-#endif
-
-#ifdef SCIF1_ERI_IRQ
-	make_ipr_irq(SCIF1_ERI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
-	make_ipr_irq(SCIF1_RXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
-	make_ipr_irq(SCIF1_BRI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
-	make_ipr_irq(SCIF1_TXI_IRQ, SCIF1_IPR_ADDR, SCIF1_IPR_POS, SCIF1_PRIORITY);
-#endif
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7300)
-	make_ipr_irq(SCIF0_IRQ, SCIF0_IPR_ADDR, SCIF0_IPR_POS, SCIF0_PRIORITY);
-	make_ipr_irq(DMTE2_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY);
-	make_ipr_irq(DMTE3_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY);
-	make_ipr_irq(VIO_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY);
-#endif
-
-#ifdef SCIF_ERI_IRQ
-	make_ipr_irq(SCIF_ERI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
-	make_ipr_irq(SCIF_RXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
-	make_ipr_irq(SCIF_BRI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
-	make_ipr_irq(SCIF_TXI_IRQ, SCIF_IPR_ADDR, SCIF_IPR_POS, SCIF_PRIORITY);
-#endif
-
-#ifdef IRDA_ERI_IRQ
-	make_ipr_irq(IRDA_ERI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
-	make_ipr_irq(IRDA_RXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
-	make_ipr_irq(IRDA_BRI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
-	make_ipr_irq(IRDA_TXI_IRQ, IRDA_IPR_ADDR, IRDA_IPR_POS, IRDA_PRIORITY);
-#endif
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
-	/*
-	 * Initialize the Interrupt Controller (INTC)
-	 * registers to their power on values
-	 */
-
-	/*
-	 * Enable external irq (INTC IRQ mode).
-	 * You should set corresponding bits of PFC to "00"
-	 * to enable these interrupts.
-	 */
-	make_ipr_irq(IRQ0_IRQ, IRQ0_IPR_ADDR, IRQ0_IPR_POS, IRQ0_PRIORITY);
-	make_ipr_irq(IRQ1_IRQ, IRQ1_IPR_ADDR, IRQ1_IPR_POS, IRQ1_PRIORITY);
-	make_ipr_irq(IRQ2_IRQ, IRQ2_IPR_ADDR, IRQ2_IPR_POS, IRQ2_PRIORITY);
-	make_ipr_irq(IRQ3_IRQ, IRQ3_IPR_ADDR, IRQ3_IPR_POS, IRQ3_PRIORITY);
-	make_ipr_irq(IRQ4_IRQ, IRQ4_IPR_ADDR, IRQ4_IPR_POS, IRQ4_PRIORITY);
-	make_ipr_irq(IRQ5_IRQ, IRQ5_IPR_ADDR, IRQ5_IPR_POS, IRQ5_PRIORITY);
-#if !defined(CONFIG_CPU_SUBTYPE_SH7300)
-	make_ipr_irq(PINT0_IRQ, PINT0_IPR_ADDR, PINT0_IPR_POS, PINT0_PRIORITY);
-	make_ipr_irq(PINT8_IRQ, PINT8_IPR_ADDR, PINT8_IPR_POS, PINT8_PRIORITY);
-	enable_ipr_irq(PINT0_IRQ);
-	enable_ipr_irq(PINT8_IRQ);
-
-	for(i = 0; i < 16; i++)
-		make_pint_irq(PINT_IRQ_BASE + i);
-	for(i = 0; i < 256; i++)
-	{
-		if(i & 1) pint_map[i] = 0;
-		else if(i & 2) pint_map[i] = 1;
-		else if(i & 4) pint_map[i] = 2;
-		else if(i & 8) pint_map[i] = 3;
-		else if(i & 0x10) pint_map[i] = 4;
-		else if(i & 0x20) pint_map[i] = 5;
-		else if(i & 0x40) pint_map[i] = 6;
-		else if(i & 0x80) pint_map[i] = 7;
-	}
-#endif /* !CONFIG_CPU_SUBTYPE_SH7300 */
-#endif /* CONFIG_CPU_SUBTYPE_SH7707 || CONFIG_CPU_SUBTYPE_SH7709  || CONFIG_CPU_SUBTYPE_SH7300*/
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40
-	init_IRQ_intc2();
-#endif
-
-	/* Perform the machine specific initialisation */
-	if (sh_mv.mv_init_irq != NULL) {
-		sh_mv.mv_init_irq();
-	}
-}
-#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
-int ipr_irq_demux(int irq)
-{
-#if !defined(CONFIG_CPU_SUBTYPE_SH7300)
-	unsigned long creg, dreg, d, sav;
-
-	if(irq == PINT0_IRQ)
-	{
-#if defined(CONFIG_CPU_SUBTYPE_SH7707)
-		creg = PORT_PACR;
-		dreg = PORT_PADR;
-#else
-		creg = PORT_PCCR;
-		dreg = PORT_PCDR;
-#endif
-		sav = ctrl_inw(creg);
-		ctrl_outw(sav | portcr_mask, creg);
-		d = (~ctrl_inb(dreg) ^ ctrl_inw(INTC_ICR2)) & ctrl_inw(INTC_INTER) & 0xff;
-		ctrl_outw(sav, creg);
-		if(d == 0) return irq;
-		return PINT_IRQ_BASE + pint_map[d];
-	}
-	else if(irq == PINT8_IRQ)
-	{
-#if defined(CONFIG_CPU_SUBTYPE_SH7707)
-		creg = PORT_PBCR;
-		dreg = PORT_PBDR;
-#else
-		creg = PORT_PFCR;
-		dreg = PORT_PFDR;
-#endif
-		sav = ctrl_inw(creg);
-		ctrl_outw(sav | (portcr_mask >> 16), creg);
-		d = (~ctrl_inb(dreg) ^ (ctrl_inw(INTC_ICR2) >> 8)) & (ctrl_inw(INTC_INTER) >> 8) & 0xff;
-		ctrl_outw(sav, creg);
-		if(d == 0) return irq;
-		return PINT_IRQ_BASE + 8 + pint_map[d];
-	}
-#endif
-	return irq;
-}
-#endif
-
-EXPORT_SYMBOL(make_ipr_irq);
-

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/irq_intc2.c sh-2.6.15/arch/sh/kernel/cpu/sh4/irq_intc2.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/irq_intc2.c	2005-11-12 20:17:23.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/irq_intc2.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,222 +0,0 @@
-/*
- * linux/arch/sh/kernel/irq_intc2.c
- *
- * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.                            
- *
- * Interrupt handling for INTC2-based IRQ.
- *
- * These are the "new Hitachi style" interrupts, as present on the 
- * Hitachi 7751 and the STM ST40 STB1.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/machvec.h>
-
-
-struct intc2_data {
-	unsigned char msk_offset;
-	unsigned char msk_shift;
-#ifdef CONFIG_CPU_SUBTYPE_ST40
-	int (*clear_irq) (int);
-#endif
-};
-
-
-static struct intc2_data intc2_data[NR_INTC2_IRQS];
-
-static void enable_intc2_irq(unsigned int irq);
-static void disable_intc2_irq(unsigned int irq);
-
-/* shutdown is same as "disable" */
-#define shutdown_intc2_irq disable_intc2_irq
-
-static void mask_and_ack_intc2(unsigned int);
-static void end_intc2_irq(unsigned int irq);
-
-static unsigned int startup_intc2_irq(unsigned int irq)
-{ 
-	enable_intc2_irq(irq);
-	return 0; /* never anything pending */
-}
-
-static struct hw_interrupt_type intc2_irq_type = {
-	.typename = "INTC2-IRQ",
-	.startup = startup_intc2_irq,
-	.shutdown = shutdown_intc2_irq,
-	.enable = enable_intc2_irq,
-	.disable = disable_intc2_irq,
-	.ack = mask_and_ack_intc2,
-	.end = end_intc2_irq
-};
-
-static void disable_intc2_irq(unsigned int irq)
-{
-	int irq_offset = irq - INTC2_FIRST_IRQ;
-	int msk_shift, msk_offset;
-
-	// Sanity check
-	if((irq_offset<0) || (irq_offset>=NR_INTC2_IRQS))
-		return;
-
-	msk_shift = intc2_data[irq_offset].msk_shift;
-	msk_offset = intc2_data[irq_offset].msk_offset;
-
-	ctrl_outl(1<<msk_shift,
-		  INTC2_BASE+INTC2_INTMSK_OFFSET+msk_offset);
-}
-
-static void enable_intc2_irq(unsigned int irq)
-{
-	int irq_offset = irq - INTC2_FIRST_IRQ;
-	int msk_shift, msk_offset;
-
-	/* Sanity check */
-	if((irq_offset<0) || (irq_offset>=NR_INTC2_IRQS))
-		return;
-
-	msk_shift = intc2_data[irq_offset].msk_shift;
-	msk_offset = intc2_data[irq_offset].msk_offset;
-
-	ctrl_outl(1<<msk_shift,
-		  INTC2_BASE+INTC2_INTMSKCLR_OFFSET+msk_offset);
-}
-
-static void mask_and_ack_intc2(unsigned int irq)
-{
-	disable_intc2_irq(irq);
-}
-
-static void end_intc2_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_intc2_irq(irq);
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40
-	if (intc2_data[irq - INTC2_FIRST_IRQ].clear_irq)
-		intc2_data[irq - INTC2_FIRST_IRQ].clear_irq (irq);
-#endif
-}
-
-/*
- * Setup an INTC2 style interrupt.
- * NOTE: Unlike IPR interrupts, parameters are not shifted by this code,
- * allowing the use of the numbers straight out of the datasheet.
- * For example:
- *    PIO1 which is INTPRI00[19,16] and INTMSK00[13]
- * would be:               ^     ^             ^  ^
- *                         |     |             |  |
- *    make_intc2_irq(84,   0,   16,            0, 13);
- */
-void make_intc2_irq(unsigned int irq,
-		    unsigned int ipr_offset, unsigned int ipr_shift,
-		    unsigned int msk_offset, unsigned int msk_shift,
-		    unsigned int priority)
-{
-	int irq_offset = irq - INTC2_FIRST_IRQ;
-	unsigned int flags;
-	unsigned long ipr;
-
-	if((irq_offset<0) || (irq_offset>=NR_INTC2_IRQS))
-		return;
-
-	disable_irq_nosync(irq);
-
-	/* Fill the data we need */
-	intc2_data[irq_offset].msk_offset = msk_offset;
-	intc2_data[irq_offset].msk_shift  = msk_shift;
-#ifdef CONFIG_CPU_SUBTYPE_ST40
-	intc2_data[irq_offset].clear_irq = NULL;
-#endif
-		
-	/* Set the priority level */
-	local_irq_save(flags);
-
-	ipr=ctrl_inl(INTC2_BASE+INTC2_INTPRI_OFFSET+ipr_offset);
-	ipr&=~(0xf<<ipr_shift);
-	ipr|=(priority)<<ipr_shift;
-	ctrl_outl(ipr, INTC2_BASE+INTC2_INTPRI_OFFSET+ipr_offset);
-
-	local_irq_restore(flags);
-
-	irq_desc[irq].handler=&intc2_irq_type;
-
-	disable_intc2_irq(irq);
-}
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40
-
-struct intc2_init {
-	unsigned short irq;
-	unsigned char ipr_offset, ipr_shift;
-	unsigned char msk_offset, msk_shift;
-};
-
-static struct intc2_init intc2_init_data[]  __initdata = {
-	{64,  0,  0, 0,  0},	/* PCI serr */
-	{65,  0,  4, 0,  1},	/* PCI err */
-	{66,  0,  4, 0,  2},	/* PCI ad */
-	{67,  0,  4, 0,  3},	/* PCI pwd down */
-	{72,  0,  8, 0,  5},	/* DMAC INT0 */
-	{73,  0,  8, 0,  6},	/* DMAC INT1 */
-	{74,  0,  8, 0,  7},	/* DMAC INT2 */
-	{75,  0,  8, 0,  8},	/* DMAC INT3 */
-	{76,  0,  8, 0,  9},	/* DMAC INT4 */
-	{78,  0,  8, 0, 11},	/* DMAC ERR */
-	{80,  0, 12, 0, 12},	/* PIO0 */
-	{84,  0, 16, 0, 13},	/* PIO1 */
-	{88,  0, 20, 0, 14},	/* PIO2 */
-	{112, 4,  0, 4,  0},	/* Mailbox */
-#ifdef CONFIG_CPU_SUBTYPE_ST40GX1
-	{116, 4,  4, 4,  4},	/* SSC0 */
-	{120, 4,  8, 4,  8},	/* IR Blaster */
-	{124, 4, 12, 4, 12},	/* USB host */
-	{128, 4, 16, 4, 16},	/* Video processor BLITTER */
-	{132, 4, 20, 4, 20},	/* UART0 */
-	{134, 4, 20, 4, 22},	/* UART2 */
-	{136, 4, 24, 4, 24},	/* IO_PIO0 */
-	{140, 4, 28, 4, 28},	/* EMPI */
-	{144, 8,  0, 8,  0},	/* MAFE */
-	{148, 8,  4, 8,  4},	/* PWM */
-	{152, 8,  8, 8,  8},	/* SSC1 */
-	{156, 8, 12, 8, 12},	/* IO_PIO1 */
-	{160, 8, 16, 8, 16},	/* USB target */
-	{164, 8, 20, 8, 20},	/* UART1 */
-	{168, 8, 24, 8, 24},	/* Teletext */
-	{172, 8, 28, 8, 28},	/* VideoSync VTG */
-	{173, 8, 28, 8, 29},	/* VideoSync DVP0 */
-	{174, 8, 28, 8, 30},	/* VideoSync DVP1 */
-#endif
-};
-
-void __init init_IRQ_intc2(void)
-{
-	struct intc2_init *p;
-
-	printk(KERN_ALERT "init_IRQ_intc2\n");
-
-	for (p = intc2_init_data;
-	     p<intc2_init_data+ARRAY_SIZE(intc2_init_data);
-	     p++) {
-		make_intc2_irq(p->irq, p->ipr_offset, p->ipr_shift,
-			       p-> msk_offset, p->msk_shift, 13);
-	}
-}
-
-/* Adds a termination callback to the interrupt */
-void intc2_add_clear_irq(int irq, int (*fn)(int))
-{
-	if (irq < INTC2_FIRST_IRQ)
-		return;
-
-	intc2_data[irq - INTC2_FIRST_IRQ].clear_irq = fn;
-}
-
-#endif /* CONFIG_CPU_SUBTYPE_ST40 */

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/irq.c sh-2.6.15/arch/sh/kernel/irq.c
--- linux-2.6.15/arch/sh/kernel/irq.c	2005-06-20 22:45:19.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/irq.c	2006-01-07 22:13:59.229142425 +0200
@@ -8,38 +8,13 @@
  * SuperH version:  Copyright (C) 1999  Niibe Yutaka
  */
 
-/*
- * IRQs are in fact implemented a bit like signal handlers for the kernel.
- * Naturally it's not a 1:1 relation, but there are similarities.
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
+#include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
-#include <linux/kallsyms.h>
-#include <linux/bitops.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/pgalloc.h>
-#include <asm/delay.h>
 #include <asm/irq.h>
-#include <linux/irq.h>
-
+#include <asm/processor.h>
+#include <asm/cpu/mmu_context.h>
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -66,7 +41,7 @@
 		seq_putc(p, '\n');
 	}
 
-	if (i < ACTUAL_NR_IRQS) {
+	if (i < NR_IRQS) {
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
 		if (!action)
@@ -86,19 +61,32 @@
 }
 #endif
 
+
 asmlinkage int do_IRQ(unsigned long r4, unsigned long r5,
 		      unsigned long r6, unsigned long r7,
 		      struct pt_regs regs)
-{	
-	int irq;
+{
+	int irq = r4;
 
 	irq_enter();
-	asm volatile("stc	r2_bank, %0\n\t"
-		     "shlr2	%0\n\t"
-		     "shlr2	%0\n\t"
-		     "shlr	%0\n\t"
-		     "add	#-16, %0\n\t"
-		     :"=z" (irq));
+
+#ifdef CONFIG_CPU_HAS_INTEVT
+	__asm__ __volatile__ (
+#ifdef CONFIG_CPU_HAS_SR_RB
+		"stc	r2_bank, %0\n\t"
+#else
+		"mov.l	@%1, %0\n\t"
+#endif
+		"shlr2	%0\n\t"
+		"shlr2	%0\n\t"
+		"shlr	%0\n\t"
+		"add	#-16, %0\n\t"
+		: "=z" (irq), "=r" (r4)
+		: "1" (INTEVT)
+		: "memory"
+	);
+#endif
+
 	irq = irq_demux(irq);
 	__do_IRQ(irq, &regs);
 	irq_exit();

diff -urN -X exclude linux-2.6.15/include/asm-sh/irq-sh73180.h sh-2.6.15/include/asm-sh/irq-sh73180.h
--- linux-2.6.15/include/asm-sh/irq-sh73180.h	2004-12-26 05:37:56.000000000 +0200
+++ sh-2.6.15/include/asm-sh/irq-sh73180.h	2006-01-04 00:15:30.000000000 +0200
@@ -12,14 +12,14 @@
 #undef INTC_IPRC
 #undef INTC_IPRD
 
-#undef DMTE0_IRQ
-#undef DMTE1_IRQ
-#undef DMTE2_IRQ
-#undef DMTE3_IRQ
-#undef DMTE4_IRQ
-#undef DMTE5_IRQ
-#undef DMTE6_IRQ
-#undef DMTE7_IRQ
+#undef DMTE0_IRQ	
+#undef DMTE1_IRQ	
+#undef DMTE2_IRQ	
+#undef DMTE3_IRQ	
+#undef DMTE4_IRQ	
+#undef DMTE5_IRQ	
+#undef DMTE6_IRQ	
+#undef DMTE7_IRQ	
 #undef DMAE_IRQ
 #undef DMA_IPR_ADDR
 #undef DMA_IPR_POS
diff -urN -X exclude linux-2.6.15/include/asm-sh/irq-sh7780.h sh-2.6.15/include/asm-sh/irq-sh7780.h
--- linux-2.6.15/include/asm-sh/irq-sh7780.h	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/include/asm-sh/irq-sh7780.h	2006-01-07 22:13:59.261139909 +0200
@@ -0,0 +1,349 @@
+#ifndef __ASM_SH_IRQ_SH7780_H
+#define __ASM_SH_IRQ_SH7780_H
+
+/*
+ * linux/include/asm-sh/irq-sh7780.h
+ *
+ * Copyright (C) 2004 Takashi SHUDO <shudo@hitachi-ul.co.jp>
+ */
+
+#ifdef CONFIG_IDE
+# ifndef IRQ_CFCARD
+#  define IRQ_CFCARD	14
+# endif
+# ifndef IRQ_PCMCIA
+#  define IRQ_PCMCIA	15
+# endif
+#endif
+
+#define INTC_BASE	0xffd00000
+#define INTC_ICR0	(INTC_BASE+0x0)
+#define INTC_ICR1	(INTC_BASE+0x1c)
+#define INTC_INTPRI	(INTC_BASE+0x10)
+#define INTC_INTREQ	(INTC_BASE+0x24)
+#define INTC_INTMSK0	(INTC_BASE+0x44)
+#define INTC_INTMSK1	(INTC_BASE+0x48)
+#define INTC_INTMSK2	(INTC_BASE+0x40080)
+#define INTC_INTMSKCLR0	(INTC_BASE+0x64)
+#define INTC_INTMSKCLR1	(INTC_BASE+0x68)
+#define INTC_INTMSKCLR2	(INTC_BASE+0x40084)
+#define INTC_NMIFCR	(INTC_BASE+0xc0)
+#define INTC_USERIMASK	(INTC_BASE+0x30000)
+
+#define	INTC_INT2PRI0	(INTC_BASE+0x40000)
+#define	INTC_INT2PRI1	(INTC_BASE+0x40004)
+#define	INTC_INT2PRI2	(INTC_BASE+0x40008)
+#define	INTC_INT2PRI3	(INTC_BASE+0x4000c)
+#define	INTC_INT2PRI4	(INTC_BASE+0x40010)
+#define	INTC_INT2PRI5	(INTC_BASE+0x40014)
+#define	INTC_INT2PRI6	(INTC_BASE+0x40018)
+#define	INTC_INT2PRI7	(INTC_BASE+0x4001c)
+#define	INTC_INT2A0	(INTC_BASE+0x40030)
+#define	INTC_INT2A1	(INTC_BASE+0x40034)
+#define	INTC_INT2MSKR	(INTC_BASE+0x40038)
+#define	INTC_INT2MSKCR	(INTC_BASE+0x4003c)
+#define	INTC_INT2B0	(INTC_BASE+0x40040)
+#define	INTC_INT2B1	(INTC_BASE+0x40044)
+#define	INTC_INT2B2	(INTC_BASE+0x40048)
+#define	INTC_INT2B3	(INTC_BASE+0x4004c)
+#define	INTC_INT2B4	(INTC_BASE+0x40050)
+#define	INTC_INT2B5	(INTC_BASE+0x40054)
+#define	INTC_INT2B6	(INTC_BASE+0x40058)
+#define	INTC_INT2B7	(INTC_BASE+0x4005c)
+#define	INTC_INT2GPIC	(INTC_BASE+0x40090)
+/*
+  NOTE:
+  *_IRQ = (INTEVT2 - 0x200)/0x20
+*/
+/* IRQ 0-7 line external int*/
+#define IRQ0_IRQ	2
+#define IRQ0_IPR_ADDR	INTC_INTPRI
+#define IRQ0_IPR_POS	7
+#define IRQ0_PRIORITY	2
+
+#define IRQ1_IRQ	4
+#define IRQ1_IPR_ADDR	INTC_INTPRI
+#define IRQ1_IPR_POS	6
+#define IRQ1_PRIORITY	2
+
+#define IRQ2_IRQ	6
+#define IRQ2_IPR_ADDR	INTC_INTPRI
+#define IRQ2_IPR_POS	5
+#define IRQ2_PRIORITY	2
+
+#define IRQ3_IRQ	8
+#define IRQ3_IPR_ADDR	INTC_INTPRI
+#define IRQ3_IPR_POS	4
+#define IRQ3_PRIORITY	2
+
+#define IRQ4_IRQ	10
+#define IRQ4_IPR_ADDR	INTC_INTPRI
+#define IRQ4_IPR_POS	3
+#define IRQ4_PRIORITY	2
+
+#define IRQ5_IRQ	12
+#define IRQ5_IPR_ADDR	INTC_INTPRI
+#define IRQ5_IPR_POS	2
+#define IRQ5_PRIORITY	2
+
+#define IRQ6_IRQ	14
+#define IRQ6_IPR_ADDR	INTC_INTPRI
+#define IRQ6_IPR_POS	1
+#define IRQ6_PRIORITY	2
+
+#define IRQ7_IRQ	0
+#define IRQ7_IPR_ADDR	INTC_INTPRI
+#define IRQ7_IPR_POS	0
+#define IRQ7_PRIORITY	2
+
+/* TMU */
+/* ch0 */
+#define TMU_IRQ		28
+#define	TMU_IPR_ADDR	INTC_INT2PRI0
+#define	TMU_IPR_POS	3
+#define TMU_PRIORITY	2
+
+#define TIMER_IRQ	28
+#define	TIMER_IPR_ADDR	INTC_INT2PRI0
+#define	TIMER_IPR_POS	3
+#define TIMER_PRIORITY	2
+
+/* ch 1*/
+#define TMU_CH1_IRQ		29
+#define	TMU_CH1_IPR_ADDR	INTC_INT2PRI0
+#define	TMU_CH1_IPR_POS		2
+#define TMU_CH1_PRIORITY	2
+
+#define TIMER1_IRQ	29
+#define	TIMER1_IPR_ADDR	INTC_INT2PRI0
+#define	TIMER1_IPR_POS	2
+#define TIMER1_PRIORITY	2
+
+/* ch 2*/
+#define TMU_CH2_IRQ		30
+#define	TMU_CH2_IPR_ADDR	INTC_INT2PRI0
+#define	TMU_CH2_IPR_POS		1
+#define TMU_CH2_PRIORITY	2
+/* ch 2 Input capture */
+#define TMU_CH2IC_IRQ		31
+#define	TMU_CH2IC_IPR_ADDR	INTC_INT2PRI0
+#define	TMU_CH2IC_IPR_POS	0
+#define TMU_CH2IC_PRIORITY	2
+/* ch 3 */
+#define TMU_CH3_IRQ		96
+#define	TMU_CH3_IPR_ADDR	INTC_INT2PRI1
+#define	TMU_CH3_IPR_POS		3
+#define TMU_CH3_PRIORITY	2
+/* ch 4 */
+#define TMU_CH4_IRQ		97
+#define	TMU_CH4_IPR_ADDR	INTC_INT2PRI1
+#define	TMU_CH4_IPR_POS		2
+#define TMU_CH4_PRIORITY	2
+/* ch 5*/
+#define TMU_CH5_IRQ		98
+#define	TMU_CH5_IPR_ADDR	INTC_INT2PRI1
+#define	TMU_CH5_IPR_POS		1
+#define TMU_CH5_PRIORITY	2
+
+#define	RTC_IRQ		22
+#define	RTC_IPR_ADDR	INTC_INT2PRI1
+#define	RTC_IPR_POS	0
+#define	RTC_PRIORITY	TIMER_PRIORITY
+
+/* SCIF0 */
+#define SCIF0_ERI_IRQ	40
+#define SCIF0_RXI_IRQ	41
+#define SCIF0_BRI_IRQ	42
+#define SCIF0_TXI_IRQ	43
+#define	SCIF0_IPR_ADDR	INTC_INT2PRI2
+#define	SCIF0_IPR_POS	3
+#define SCIF0_PRIORITY	3
+
+/* SCIF1 */
+#define SCIF1_ERI_IRQ	76
+#define SCIF1_RXI_IRQ	77
+#define SCIF1_BRI_IRQ	78
+#define SCIF1_TXI_IRQ	79
+#define	SCIF1_IPR_ADDR	INTC_INT2PRI2
+#define	SCIF1_IPR_POS	2
+#define SCIF1_PRIORITY	3
+
+#define	WDT_IRQ		27
+#define	WDT_IPR_ADDR	INTC_INT2PRI2
+#define	WDT_IPR_POS	1
+#define	WDT_PRIORITY	2
+
+/* DMAC(0) */
+#define	DMINT0_IRQ	34
+#define	DMINT1_IRQ	35
+#define	DMINT2_IRQ	36
+#define	DMINT3_IRQ	37
+#define	DMINT4_IRQ	44
+#define	DMINT5_IRQ	45
+#define	DMINT6_IRQ	46
+#define	DMINT7_IRQ	47
+#define	DMAE_IRQ	38
+#define	DMA0_IPR_ADDR	INTC_INT2PRI3
+#define	DMA0_IPR_POS	2
+#define	DMA0_PRIORITY	7
+
+/* DMAC(1) */
+#define	DMINT8_IRQ	92
+#define	DMINT9_IRQ	93
+#define	DMINT10_IRQ	94
+#define	DMINT11_IRQ	95
+#define	DMA1_IPR_ADDR	INTC_INT2PRI3
+#define	DMA1_IPR_POS	1
+#define	DMA1_PRIORITY	7
+
+#define	DMTE0_IRQ	DMINT0_IRQ
+#define	DMTE4_IRQ	DMINT4_IRQ
+#define	DMA_IPR_ADDR	DMA0_IPR_ADDR
+#define	DMA_IPR_POS	DMA0_IPR_POS
+#define	DMA_PRIORITY	DMA0_PRIORITY
+
+/* CMT */
+#define	CMT_IRQ		56
+#define	CMT_IPR_ADDR	INTC_INT2PRI4
+#define	CMT_IPR_POS	3
+#define	CMT_PRIORITY	0
+
+/* HAC */
+#define	HAC_IRQ		60
+#define	HAC_IPR_ADDR	INTC_INT2PRI4
+#define	HAC_IPR_POS	2
+#define	CMT_PRIORITY	0
+
+/* PCIC(0) */
+#define	PCIC0_IRQ	64
+#define	PCIC0_IPR_ADDR	INTC_INT2PRI4
+#define	PCIC0_IPR_POS	1
+#define	PCIC0_PRIORITY	2
+
+/* PCIC(1) */
+#define	PCIC1_IRQ	65
+#define	PCIC1_IPR_ADDR	INTC_INT2PRI4
+#define	PCIC1_IPR_POS	0
+#define	PCIC1_PRIORITY	2
+
+/* PCIC(2) */
+#define	PCIC2_IRQ	66
+#define	PCIC2_IPR_ADDR	INTC_INT2PRI5
+#define	PCIC2_IPR_POS	3
+#define	PCIC2_PRIORITY	2
+
+/* PCIC(3) */
+#define	PCIC3_IRQ	67
+#define	PCIC3_IPR_ADDR	INTC_INT2PRI5
+#define	PCIC3_IPR_POS	2
+#define	PCIC3_PRIORITY	2
+
+/* PCIC(4) */
+#define	PCIC4_IRQ	68
+#define	PCIC4_IPR_ADDR	INTC_INT2PRI5
+#define	PCIC4_IPR_POS	1
+#define	PCIC4_PRIORITY	2
+
+/* PCIC(5) */
+#define	PCICERR_IRQ	69
+#define	PCICPWD3_IRQ	70
+#define	PCICPWD2_IRQ	71
+#define	PCICPWD1_IRQ	72
+#define	PCICPWD0_IRQ	73
+#define	PCIC5_IPR_ADDR	INTC_INT2PRI5
+#define	PCIC5_IPR_POS	0
+#define	PCIC5_PRIORITY	2
+
+/* SIOF */
+#define	SIOF_IRQ	80
+#define	SIOF_IPR_ADDR	INTC_INT2PRI6
+#define	SIOF_IPR_POS	3
+#define	SIOF_PRIORITY	3
+
+/* HSPI */
+#define	HSPI_IRQ	84
+#define	HSPI_IPR_ADDR	INTC_INT2PRI6
+#define	HSPI_IPR_POS	2
+#define	HSPI_PRIORITY	3
+
+/* MMCIF */
+#define	MMCIF_FSTAT_IRQ	88
+#define	MMCIF_TRAN_IRQ	89
+#define	MMCIF_ERR_IRQ	90
+#define	MMCIF_FRDY_IRQ	91
+#define	MMCIF_IPR_ADDR	INTC_INT2PRI6
+#define	MMCIF_IPR_POS	1
+#define	HSPI_PRIORITY	3
+
+/* SSI */
+#define	SSI_IRQ		100
+#define	SSI_IPR_ADDR	INTC_INT2PRI6
+#define	SSI_IPR_POS	0
+#define	SSI_PRIORITY	3
+
+/* FLCTL */
+#define	FLCTL_FLSTE_IRQ		104
+#define	FLCTL_FLTEND_IRQ	105
+#define	FLCTL_FLTRQ0_IRQ	106
+#define	FLCTL_FLTRQ1_IRQ	107
+#define	FLCTL_IPR_ADDR		INTC_INT2PRI7
+#define	FLCTL_IPR_POS		3
+#define	FLCTL_PRIORITY		3
+
+/* GPIO */
+#define	GPIO0_IRQ	108
+#define	GPIO1_IRQ	109
+#define	GPIO2_IRQ	110
+#define	GPIO3_IRQ	111
+#define	GPIO_IPR_ADDR	INTC_INT2PRI7
+#define	GPIO_IPR_POS	2
+#define	GPIO_PRIORITY	3
+
+/* ONCHIP_NR_IRQS */
+#define NR_IRQS 150	/* 111 + 16 */
+
+/* In a generic kernel, NR_IRQS is an upper bound, and we should use
+ * ACTUAL_NR_IRQS (which uses the machine vector) to get the correct value.
+ */
+#define ACTUAL_NR_IRQS NR_IRQS
+
+extern void disable_irq(unsigned int);
+extern void disable_irq_nosync(unsigned int);
+extern void enable_irq(unsigned int);
+
+/*
+ * Simple Mask Register Support
+ */
+extern void make_maskreg_irq(unsigned int irq);
+extern unsigned short *irq_mask_register;
+
+/*
+ * Function for "on chip support modules".
+ */
+extern void make_imask_irq(unsigned int irq);
+
+#define	INTC_TMU0_MSK	0
+#define	INTC_TMU3_MSK	1
+#define	INTC_RTC_MSK	2
+#define	INTC_SCIF0_MSK	3
+#define	INTC_SCIF1_MSK	4
+#define	INTC_WDT_MSK	5
+#define	INTC_HUID_MSK	7
+#define	INTC_DMAC0_MSK	8
+#define	INTC_DMAC1_MSK	9
+#define	INTC_CMT_MSK	12
+#define	INTC_HAC_MSK	13
+#define	INTC_PCIC0_MSK	14
+#define	INTC_PCIC1_MSK	15
+#define	INTC_PCIC2_MSK	16
+#define	INTC_PCIC3_MSK	17
+#define	INTC_PCIC4_MSK	18
+#define	INTC_PCIC5_MSK	19
+#define	INTC_SIOF_MSK	20
+#define	INTC_HSPI_MSK	21
+#define	INTC_MMCIF_MSK	22
+#define	INTC_SSI_MSK	23
+#define	INTC_FLCTL_MSK	24
+#define	INTC_GPIO_MSK	25
+
+#endif /* __ASM_SH_IRQ_SH7780_H */
diff -urN -X exclude linux-2.6.15/include/asm-sh/irq.h sh-2.6.15/include/asm-sh/irq.h
--- linux-2.6.15/include/asm-sh/irq.h	2005-11-12 20:18:07.000000000 +0200
+++ sh-2.6.15/include/asm-sh/irq.h	2006-01-07 22:13:59.279138493 +0200
@@ -15,13 +15,20 @@
 #include <asm/machvec.h>
 #include <asm/ptrace.h>		/* for pt_regs */
 
-#if defined(CONFIG_SH_HP600) || \
+#if defined(CONFIG_SH_HP6XX) || \
     defined(CONFIG_SH_RTS7751R2D) || \
     defined(CONFIG_SH_HS7751RVOIP) || \
-    defined(CONFIG_SH_SH03)
+    defined(CONFIG_SH_HS7751RVOIP) || \
+    defined(CONFIG_SH_SH03) || \
+    defined(CONFIG_SH_R7780RP) || \
+    defined(CONFIG_SH_LANDISK)
 #include <asm/mach/ide.h>
 #endif
 
+#ifndef CONFIG_CPU_SUBTYPE_SH7780
+
+#define INTC_DMAC0_MSK	0
+
 #if defined(CONFIG_CPU_SH3)
 #define INTC_IPRA	0xfffffee2UL
 #define INTC_IPRB	0xfffffee4UL
@@ -235,8 +242,9 @@
 #define SCIF1_IPR_ADDR	INTC_IPRB
 #define SCIF1_IPR_POS	1
 #define SCIF1_PRIORITY	3
-#endif
-#endif
+#endif /* ST40STB1 */
+
+#endif /* 775x / SH4-202 / ST40STB1 */
 
 /* NR_IRQS is made from three components:
  *   1. ONCHIP_NR_IRQS - number of IRLS + on-chip peripherial modules
@@ -245,37 +253,35 @@
  */
 
 /* 1. ONCHIP_NR_IRQS */
-#ifdef CONFIG_SH_GENERIC
+#if defined(CONFIG_CPU_SUBTYPE_SH7604)
+# define ONCHIP_NR_IRQS 24	// Actually 21
+#elif defined(CONFIG_CPU_SUBTYPE_SH7707)
+# define ONCHIP_NR_IRQS 64
+# define PINT_NR_IRQS   16
+#elif defined(CONFIG_CPU_SUBTYPE_SH7708)
+# define ONCHIP_NR_IRQS 32
+#elif defined(CONFIG_CPU_SUBTYPE_SH7709) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7705)
+# define ONCHIP_NR_IRQS 64	// Actually 61
+# define PINT_NR_IRQS   16
+#elif defined(CONFIG_CPU_SUBTYPE_SH7750)
+# define ONCHIP_NR_IRQS 48	// Actually 44
+#elif defined(CONFIG_CPU_SUBTYPE_SH7751)
+# define ONCHIP_NR_IRQS 72
+#elif defined(CONFIG_CPU_SUBTYPE_SH7760)
+# define ONCHIP_NR_IRQS 112	/* XXX */
+#elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
+# define ONCHIP_NR_IRQS 72
+#elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
+# define ONCHIP_NR_IRQS 144
+#elif defined(CONFIG_CPU_SUBTYPE_SH7300)
+# define ONCHIP_NR_IRQS 109
+#elif defined(CONFIG_SH_UNKNOWN)	/* Most be last */
 # define ONCHIP_NR_IRQS 144
-#else
-# if defined(CONFIG_CPU_SUBTYPE_SH7604)
-#  define ONCHIP_NR_IRQS 24	// Actually 21
-# elif defined(CONFIG_CPU_SUBTYPE_SH7707)
-#  define ONCHIP_NR_IRQS 64
-#  define PINT_NR_IRQS   16
-# elif defined(CONFIG_CPU_SUBTYPE_SH7708)
-#  define ONCHIP_NR_IRQS 32
-# elif defined(CONFIG_CPU_SUBTYPE_SH7709) || \
-       defined(CONFIG_CPU_SUBTYPE_SH7705)
-#  define ONCHIP_NR_IRQS 64	// Actually 61
-#  define PINT_NR_IRQS   16
-# elif defined(CONFIG_CPU_SUBTYPE_SH7750)
-#  define ONCHIP_NR_IRQS 48	// Actually 44
-# elif defined(CONFIG_CPU_SUBTYPE_SH7751)
-#  define ONCHIP_NR_IRQS 72
-# elif defined(CONFIG_CPU_SUBTYPE_SH7760)
-#  define ONCHIP_NR_IRQS 110
-# elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
-#  define ONCHIP_NR_IRQS 72
-# elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
-#  define ONCHIP_NR_IRQS 144
-# elif defined(CONFIG_CPU_SUBTYPE_SH7300)
-#  define ONCHIP_NR_IRQS 109
-# endif
 #endif
 
 /* 2. PINT_NR_IRQS */
-#ifdef CONFIG_SH_GENERIC
+#ifdef CONFIG_SH_UNKNOWN
 # define PINT_NR_IRQS 16
 #else
 # ifndef PINT_NR_IRQS
@@ -288,22 +294,22 @@
 #endif
 
 /* 3. OFFCHIP_NR_IRQS */
-#ifdef CONFIG_SH_GENERIC
+#if defined(CONFIG_HD64461)
+# define OFFCHIP_NR_IRQS 18
+#elif defined (CONFIG_SH_BIGSUR) /* must be before CONFIG_HD64465 */
+# define OFFCHIP_NR_IRQS 48
+#elif defined(CONFIG_HD64465)
 # define OFFCHIP_NR_IRQS 16
+#elif defined (CONFIG_SH_EC3104)
+# define OFFCHIP_NR_IRQS 16
+#elif defined (CONFIG_SH_DREAMCAST)
+# define OFFCHIP_NR_IRQS 96
+#elif defined (CONFIG_SH_TITAN)
+# define OFFCHIP_NR_IRQS 4
+#elif defined(CONFIG_SH_UNKNOWN)
+# define OFFCHIP_NR_IRQS 16	/* Must also be last */
 #else
-# if defined(CONFIG_HD64461)
-#  define OFFCHIP_NR_IRQS 18
-# elif defined (CONFIG_SH_BIGSUR) /* must be before CONFIG_HD64465 */
-#  define OFFCHIP_NR_IRQS 48
-# elif defined(CONFIG_HD64465)
-#  define OFFCHIP_NR_IRQS 16
-# elif defined (CONFIG_SH_EC3104)
-#  define OFFCHIP_NR_IRQS 16
-# elif defined (CONFIG_SH_DREAMCAST)
-#  define OFFCHIP_NR_IRQS 96
-# else
-#  define OFFCHIP_NR_IRQS 0
-# endif
+# define OFFCHIP_NR_IRQS 0
 #endif
 
 #if OFFCHIP_NR_IRQS > 0
@@ -313,16 +319,6 @@
 /* NR_IRQS. 1+2+3 */
 #define NR_IRQS (ONCHIP_NR_IRQS + PINT_NR_IRQS + OFFCHIP_NR_IRQS)
 
-/* In a generic kernel, NR_IRQS is an upper bound, and we should use
- * ACTUAL_NR_IRQS (which uses the machine vector) to get the correct value.
- */
-#ifdef CONFIG_SH_GENERIC
-# define ACTUAL_NR_IRQS (sh_mv.mv_nr_irqs)
-#else
-# define ACTUAL_NR_IRQS NR_IRQS
-#endif
-
-
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
@@ -542,9 +538,6 @@
 
 extern int ipr_irq_demux(int irq);
 #define __irq_demux(irq) ipr_irq_demux(irq)
-
-#else
-#define __irq_demux(irq) irq
 #endif /* CONFIG_CPU_SUBTYPE_SH7707 || CONFIG_CPU_SUBTYPE_SH7709 */
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7750) || defined(CONFIG_CPU_SUBTYPE_SH7751) || \
@@ -557,18 +550,35 @@
 #define INTC_ICR_IRLM	(1<<7)
 #endif
 
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
+#else
+#include <asm/irq-sh7780.h>
+#endif
 
+/* SH with INTC2-style interrupts */
+#ifdef CONFIG_CPU_HAS_INTC2_IRQ
+#if defined(CONFIG_CPU_SUBTYPE_ST40STB1)
+#define INTC2_BASE	0xfe080000
 #define INTC2_FIRST_IRQ 64
-#define NR_INTC2_IRQS 25
-
+#define INTC2_INTREQ_OFFSET	0x20
+#define INTC2_INTMSK_OFFSET	0x40
+#define INTC2_INTMSKCLR_OFFSET	0x60
+#define NR_INTC2_IRQS	25
+#elif defined(CONFIG_CPU_SUBTYPE_SH7760)
 #define INTC2_BASE	0xfe080000
-#define INTC2_INTC2MODE	(INTC2_BASE+0x80)
-
-#define INTC2_INTPRI_OFFSET	0x00
+#define INTC2_FIRST_IRQ 48	/* INTEVT 0x800 */
 #define INTC2_INTREQ_OFFSET	0x20
 #define INTC2_INTMSK_OFFSET	0x40
 #define INTC2_INTMSKCLR_OFFSET	0x60
+#define NR_INTC2_IRQS	64
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+#define INTC2_BASE	0xffd40000
+#define INTC2_FIRST_IRQ	22
+#define INTC2_INTMSK_OFFSET	(0x38)
+#define INTC2_INTMSKCLR_OFFSET	(0x3c)
+#define NR_INTC2_IRQS	60
+#endif
+
+#define INTC2_INTPRI_OFFSET	0x00
 
 void make_intc2_irq(unsigned int irq,
 		    unsigned int ipr_offset, unsigned int ipr_shift,
@@ -577,13 +587,16 @@
 void init_IRQ_intc2(void);
 void intc2_add_clear_irq(int irq, int (*fn)(int));
 
-#endif	/* CONFIG_CPU_SUBTYPE_ST40STB1 */
+#endif
 
 static inline int generic_irq_demux(int irq)
 {
 	return irq;
 }
 
+#ifndef __irq_demux
+#define __irq_demux(irq)	(irq)
+#endif
 #define irq_canonicalize(irq)	(irq)
 #define irq_demux(irq)		__irq_demux(sh_mv.mv_irq_demux(irq))
