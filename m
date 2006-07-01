Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751903AbWGAPLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWGAPLG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWGAO5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:21 -0400
Received: from www.osadl.org ([213.239.205.134]:33956 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751544AbWGAO5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:06 -0400
Message-Id: <20060701145224.719975000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:34 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, ralf@linux-mips.org
Subject: [RFC][patch 13/44] MIPS: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-mips.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/mips/au1000/common/dbdma.c                          |    2 +-
 arch/mips/au1000/common/irq.c                            |    2 +-
 arch/mips/au1000/common/usbdev.c                         |    8 ++++----
 arch/mips/basler/excite/excite_iodev.c                   |    2 +-
 arch/mips/dec/setup.c                                    |    4 ++--
 arch/mips/gt64120/common/time.c                          |    2 +-
 arch/mips/kernel/rtlx.c                                  |    2 +-
 arch/mips/kernel/smp-mt.c                                |    4 ++--
 arch/mips/kernel/smtc.c                                  |    2 +-
 arch/mips/kernel/time.c                                  |    2 +-
 arch/mips/momentum/jaguar_atx/irq.c                      |    2 +-
 arch/mips/momentum/ocelot_3/irq.c                        |    2 +-
 arch/mips/momentum/ocelot_c/irq.c                        |    4 ++--
 arch/mips/momentum/ocelot_g/gt-irq.c                     |    2 +-
 arch/mips/philips/pnx8550/common/int.c                   |    4 ++--
 arch/mips/sgi-ip22/ip22-int.c                            |   10 +++++-----
 arch/mips/sgi-ip27/ip27-irq.c                            |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c                          |    2 +-
 arch/mips/sgi-ip32/ip32-irq.c                            |   12 ++++++------
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |    2 +-
 include/asm-mips/mach-generic/floppy.h                   |    2 +-
 include/asm-mips/mach-jazz/floppy.h                      |    2 +-
 include/asm-mips/signal.h                                |   11 -----------
 23 files changed, 38 insertions(+), 49 deletions(-)

Index: linux-2.6.git/include/asm-mips/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-mips/signal.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-mips/signal.h	2006-07-01 16:51:34.000000000 +0200
@@ -64,7 +64,6 @@ typedef unsigned long old_sigset_t;		/* 
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -84,7 +83,6 @@ typedef unsigned long old_sigset_t;		/* 
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000	/* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000	/* Only for o32 */
 
@@ -99,15 +97,6 @@ typedef unsigned long old_sigset_t;		/* 
 
 #ifdef __KERNEL__
 
-/*
- * These values of sa_flags are used only by the kernel as part of the
- * irq handling routines.
- *
- * SA_INTERRUPT is also used by the irq handling routines.
- * SA_SHIRQ flag is for shared interrupt support on PCI and EISA.
- */
-#define SA_SAMPLE_RANDOM	SA_RESTART
-
 #ifdef CONFIG_TRAD_SIGNALS
 #define sig_uses_siginfo(ka)	((ka)->sa.sa_flags & SA_SIGINFO)
 #else
Index: linux-2.6.git/include/asm-mips/mach-generic/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-mips/mach-generic/floppy.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-mips/mach-generic/floppy.h	2006-07-01 16:51:34.000000000 +0200
@@ -98,7 +98,7 @@ static inline void fd_disable_irq(void)
 static inline int fd_request_irq(void)
 {
 	return request_irq(FLOPPY_IRQ, floppy_interrupt,
-	                   SA_INTERRUPT, "floppy", NULL);
+	                   IRQF_DISABLED, "floppy", NULL);
 }
 
 static inline void fd_free_irq(void)
Index: linux-2.6.git/include/asm-mips/mach-jazz/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-mips/mach-jazz/floppy.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-mips/mach-jazz/floppy.h	2006-07-01 16:51:34.000000000 +0200
@@ -90,7 +90,7 @@ static inline void fd_disable_irq(void)
 static inline int fd_request_irq(void)
 {
 	return request_irq(FLOPPY_IRQ, floppy_interrupt,
-	                   SA_INTERRUPT, "floppy", NULL);
+	                   IRQF_DISABLED, "floppy", NULL);
 }
 
 static inline void fd_free_irq(void)
Index: linux-2.6.git/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-2.6.git.orig/arch/mips/au1000/common/dbdma.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/au1000/common/dbdma.c	2006-07-01 16:51:34.000000000 +0200
@@ -892,7 +892,7 @@ static void au1xxx_dbdma_init(void)
 	#error Unknown Au1x00 SOC
 #endif
 
-	if (request_irq(irq_nr, dbdma_interrupt, SA_INTERRUPT,
+	if (request_irq(irq_nr, dbdma_interrupt, IRQF_DISABLED,
 			"Au1xxx dbdma", (void *)dbdma_gptr))
 		printk("Can't get 1550 dbdma irq");
 }
Index: linux-2.6.git/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/au1000/common/irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/au1000/common/irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -309,7 +309,7 @@ void startup_match20_interrupt(irqreturn
 	 * can avoid it.  --cgray
 	*/
 	action.dev_id = handler;
-	action.flags = SA_INTERRUPT;
+	action.flags = IRQF_DISABLED;
 	cpus_clear(action.mask);
 	action.name = "Au1xxx TOY";
 	action.handler = handler;
Index: linux-2.6.git/arch/mips/au1000/common/usbdev.c
===================================================================
--- linux-2.6.git.orig/arch/mips/au1000/common/usbdev.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/au1000/common/usbdev.c	2006-07-01 16:51:34.000000000 +0200
@@ -1465,14 +1465,14 @@ usbdev_init(struct usb_device_descriptor
 	 */
 
 	/* request the USB device transfer complete interrupt */
-	if (request_irq(AU1000_USB_DEV_REQ_INT, req_sus_intr, SA_INTERRUPT,
+	if (request_irq(AU1000_USB_DEV_REQ_INT, req_sus_intr, IRQF_DISABLED,
 			"USBdev req", &usbdev)) {
 		err("Can't get device request intr");
 		ret = -ENXIO;
 		goto out;
 	}
 	/* request the USB device suspend interrupt */
-	if (request_irq(AU1000_USB_DEV_SUS_INT, req_sus_intr, SA_INTERRUPT,
+	if (request_irq(AU1000_USB_DEV_SUS_INT, req_sus_intr, IRQF_DISABLED,
 			"USBdev sus", &usbdev)) {
 		err("Can't get device suspend intr");
 		ret = -ENXIO;
@@ -1483,7 +1483,7 @@ usbdev_init(struct usb_device_descriptor
 	if ((ep0->indma = request_au1000_dma(ep_dma_id[0].id,
 					     ep_dma_id[0].str,
 					     dma_done_ep0_intr,
-					     SA_INTERRUPT,
+					     IRQF_DISABLED,
 					     &usbdev)) < 0) {
 		err("Can't get %s DMA", ep_dma_id[0].str);
 		ret = -ENXIO;
@@ -1516,7 +1516,7 @@ usbdev_init(struct usb_device_descriptor
 				request_au1000_dma(ep_dma_id[ep->address].id,
 						   ep_dma_id[ep->address].str,
 						   dma_done_ep_intr,
-						   SA_INTERRUPT,
+						   IRQF_DISABLED,
 						   &usbdev);
 			if (ep->indma < 0) {
 				err("Can't get %s DMA",
Index: linux-2.6.git/arch/mips/basler/excite/excite_iodev.c
===================================================================
--- linux-2.6.git.orig/arch/mips/basler/excite/excite_iodev.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/basler/excite/excite_iodev.c	2006-07-01 16:51:34.000000000 +0200
@@ -113,7 +113,7 @@ static int __exit iodev_remove(struct de
 
 static int iodev_open(struct inode *i, struct file *f)
 {
-	return request_irq(iodev_irq, iodev_irqhdl, SA_INTERRUPT,
+	return request_irq(iodev_irq, iodev_irqhdl, IRQF_DISABLED,
 			   iodev_name, &miscdev);
 }
 
Index: linux-2.6.git/arch/mips/dec/setup.c
===================================================================
--- linux-2.6.git.orig/arch/mips/dec/setup.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/dec/setup.c	2006-07-01 16:51:34.000000000 +0200
@@ -105,7 +105,7 @@ static struct irqaction fpuirq = {
 };
 
 static struct irqaction busirq = {
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.name = "bus error",
 };
 
@@ -124,7 +124,7 @@ static void __init dec_be_init(void)
 	case MACH_DS23100:	/* DS2100/DS3100 Pmin/Pmax */
 		board_be_handler = dec_kn01_be_handler;
 		busirq.handler = dec_kn01_be_interrupt;
-		busirq.flags |= SA_SHIRQ;
+		busirq.flags |= IRQF_SHARED;
 		dec_kn01_be_init();
 		break;
 	case MACH_DS5000_1XX:	/* DS5000/1xx 3min */
Index: linux-2.6.git/arch/mips/gt64120/common/time.c
===================================================================
--- linux-2.6.git.orig/arch/mips/gt64120/common/time.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/gt64120/common/time.c	2006-07-01 16:51:34.000000000 +0200
@@ -77,7 +77,7 @@ void gt64120_time_init(void)
 	 * the values to the correct interrupt line.
 	 */
 	timer.handler = gt64120_irq;
-	timer.flags = SA_SHIRQ | SA_INTERRUPT;
+	timer.flags = IRQF_SHARED | IRQF_DISABLED;
 	timer.name = "timer";
 	timer.dev_id = NULL;
 	timer.next = NULL;
Index: linux-2.6.git/arch/mips/kernel/rtlx.c
===================================================================
--- linux-2.6.git.orig/arch/mips/kernel/rtlx.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/kernel/rtlx.c	2006-07-01 16:51:34.000000000 +0200
@@ -487,7 +487,7 @@ static struct file_operations rtlx_fops 
 
 static struct irqaction rtlx_irq = {
 	.handler	= rtlx_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "RTLX",
 };
 
Index: linux-2.6.git/arch/mips/kernel/smp-mt.c
===================================================================
--- linux-2.6.git.orig/arch/mips/kernel/smp-mt.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/kernel/smp-mt.c	2006-07-01 16:51:34.000000000 +0200
@@ -130,13 +130,13 @@ irqreturn_t ipi_call_interrupt(int irq, 
 
 static struct irqaction irq_resched = {
 	.handler	= ipi_resched_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "IPI_resched"
 };
 
 static struct irqaction irq_call = {
 	.handler	= ipi_call_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "IPI_call"
 };
 
Index: linux-2.6.git/arch/mips/kernel/smtc.c
===================================================================
--- linux-2.6.git.orig/arch/mips/kernel/smtc.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/kernel/smtc.c	2006-07-01 16:51:34.000000000 +0200
@@ -1002,7 +1002,7 @@ void setup_cross_vpe_interrupts(void)
 	set_vi_handler(MIPS_CPU_IPI_IRQ, ipi_irq_dispatch);
 
 	irq_ipi.handler = ipi_interrupt;
-	irq_ipi.flags = SA_INTERRUPT;
+	irq_ipi.flags = IRQF_DISABLED;
 	irq_ipi.name = "SMTC_IPI";
 
 	setup_irq_smtc(cpu_ipi_irq, &irq_ipi, (0x100 << MIPS_CPU_IPI_IRQ));
Index: linux-2.6.git/arch/mips/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/mips/kernel/time.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/kernel/time.c	2006-07-01 16:51:34.000000000 +0200
@@ -579,7 +579,7 @@ unsigned int mips_hpt_frequency;
 
 static struct irqaction timer_irqaction = {
 	.handler = timer_interrupt,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.name = "timer",
 };
 
Index: linux-2.6.git/arch/mips/momentum/jaguar_atx/irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/momentum/jaguar_atx/irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/momentum/jaguar_atx/irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -71,7 +71,7 @@ asmlinkage void plat_irq_dispatch(struct
 }
 
 static struct irqaction cascade_mv64340 = {
-	no_action, SA_INTERRUPT, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
+	no_action, IRQF_DISABLED, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6.git/arch/mips/momentum/ocelot_3/irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/momentum/ocelot_3/irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/momentum/ocelot_3/irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -54,7 +54,7 @@
 #include <asm/system.h>
 
 static struct irqaction cascade_mv64340 = {
-	no_action, SA_INTERRUPT, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
+	no_action, IRQF_DISABLED, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6.git/arch/mips/momentum/ocelot_c/irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/momentum/ocelot_c/irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/momentum/ocelot_c/irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -52,11 +52,11 @@ extern void uart_irq_init(void);
 extern void cpci_irq_init(void);
 
 static struct irqaction cascade_fpga = {
-	no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade via FPGA", NULL, NULL
+	no_action, IRQF_DISABLED, CPU_MASK_NONE, "cascade via FPGA", NULL, NULL
 };
 
 static struct irqaction cascade_mv64340 = {
-	no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade via MV64340", NULL, NULL
+	no_action, IRQF_DISABLED, CPU_MASK_NONE, "cascade via MV64340", NULL, NULL
 };
 
 extern void ll_uart_irq(struct pt_regs *regs);
Index: linux-2.6.git/arch/mips/momentum/ocelot_g/gt-irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/momentum/ocelot_g/gt-irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/momentum/ocelot_g/gt-irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -173,7 +173,7 @@ void gt64240_time_init(void)
 	 * the values to the correct interrupt line.
 	 */
 	timer.handler = &gt64240_p0int_irq;
-	timer.flags = SA_SHIRQ | SA_INTERRUPT;
+	timer.flags = IRQF_SHARED | IRQF_DISABLED;
 	timer.name = "timer";
 	timer.dev_id = NULL;
 	timer.next = NULL;
Index: linux-2.6.git/arch/mips/philips/pnx8550/common/int.c
===================================================================
--- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/int.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/philips/pnx8550/common/int.c	2006-07-01 16:51:34.000000000 +0200
@@ -219,13 +219,13 @@ static struct hw_interrupt_type level_ir
 
 static struct irqaction gic_action = {
 	.handler =	no_action,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"GIC",
 };
 
 static struct irqaction timer_action = {
 	.handler =	no_action,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"Timer",
 };
 
Index: linux-2.6.git/arch/mips/sgi-ip22/ip22-int.c
===================================================================
--- linux-2.6.git.orig/arch/mips/sgi-ip22/ip22-int.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/sgi-ip22/ip22-int.c	2006-07-01 16:51:34.000000000 +0200
@@ -272,32 +272,32 @@ static void indy_buserror_irq(struct pt_
 
 static struct irqaction local0_cascade = {
 	.handler	= no_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "local0 cascade",
 };
 
 static struct irqaction local1_cascade = {
 	.handler	= no_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "local1 cascade",
 };
 
 static struct irqaction buserr = {
 	.handler	= no_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "Bus Error",
 };
 
 static struct irqaction map0_cascade = {
 	.handler	= no_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "mapable0 cascade",
 };
 
 #ifdef USE_LIO3_IRQ
 static struct irqaction map1_cascade = {
 	.handler	= no_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.name		= "mapable1 cascade",
 };
 #define SGI_INTERRUPTS	SGINT_END
Index: linux-2.6.git/arch/mips/sgi-ip27/ip27-irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/sgi-ip27/ip27-irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/sgi-ip27/ip27-irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -118,7 +118,7 @@ static int ms1bit(unsigned long x)
 }
 
 /*
- * This code is unnecessarily complex, because we do SA_INTERRUPT
+ * This code is unnecessarily complex, because we do IRQF_DISABLED
  * intr enabling. Basically, once we grab the set of intrs we need
  * to service, we must mask _all_ these interrupts; firstly, to make
  * sure the same intr does not intr again, causing recursion that
Index: linux-2.6.git/arch/mips/sgi-ip27/ip27-timer.c
===================================================================
--- linux-2.6.git.orig/arch/mips/sgi-ip27/ip27-timer.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/sgi-ip27/ip27-timer.c	2006-07-01 16:51:34.000000000 +0200
@@ -217,7 +217,7 @@ static struct hw_interrupt_type rt_irq_t
 
 static struct irqaction rt_irqaction = {
 	.handler	= ip27_rt_timer_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_NONE,
 	.name		= "timer"
 };
Index: linux-2.6.git/arch/mips/sgi-ip32/ip32-irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/sgi-ip32/ip32-irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/sgi-ip32/ip32-irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -125,9 +125,9 @@ extern irqreturn_t crime_memerr_intr (in
 extern irqreturn_t crime_cpuerr_intr (int irq, void *dev_id,
 				      struct pt_regs *regs);
 
-struct irqaction memerr_irq = { crime_memerr_intr, SA_INTERRUPT,
+struct irqaction memerr_irq = { crime_memerr_intr, IRQF_DISABLED,
 			CPU_MASK_NONE, "CRIME memory error", NULL, NULL };
-struct irqaction cpuerr_irq = { crime_cpuerr_intr, SA_INTERRUPT,
+struct irqaction cpuerr_irq = { crime_cpuerr_intr, IRQF_DISABLED,
 			CPU_MASK_NONE, "CRIME CPU error", NULL, NULL };
 
 /*
@@ -316,9 +316,9 @@ static struct hw_interrupt_type ip32_mac
 				 MACEISA_KEYB_POLL_INT |	\
 				 MACEISA_MOUSE_INT |		\
 				 MACEISA_MOUSE_POLL_INT |	\
-				 MACEISA_TIMER0_INT |		\
-				 MACEISA_TIMER1_INT |		\
-				 MACEISA_TIMER2_INT)
+				 MACEIIRQF_TIMER0_INT |		\
+				 MACEIIRQF_TIMER1_INT |		\
+				 MACEIIRQF_TIMER2_INT)
 #define MACEISA_SUPERIO_INT	(MACEISA_PARALLEL_INT |		\
 				 MACEISA_PAR_CTXA_INT |		\
 				 MACEISA_PAR_CTXB_INT |		\
@@ -349,7 +349,7 @@ static void enable_maceisa_irq (unsigned
 	case MACEISA_AUDIO_SW_IRQ ... MACEISA_AUDIO3_MERR_IRQ:
 		crime_int = MACE_AUDIO_INT;
 		break;
-	case MACEISA_RTC_IRQ ... MACEISA_TIMER2_IRQ:
+	case MACEISA_RTC_IRQ ... MACEIIRQF_TIMER2_IRQ:
 		crime_int = MACE_MISC_INT;
 		break;
 	case MACEISA_PARALLEL_IRQ ... MACEISA_SERIAL2_RDMAOR_IRQ:
Index: linux-2.6.git/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- linux-2.6.git.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-07-01 16:51:34.000000000 +0200
@@ -337,7 +337,7 @@ int toshiba_rbtx4927_irq_nested(int sw_i
 }
 
 //#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
-#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, SA_SHIRQ, CPU_MASK_NONE, s, NULL, NULL }
+#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, IRQF_SHARED, CPU_MASK_NONE, s, NULL, NULL }
 static struct irqaction toshiba_rbtx4927_irq_ioc_action =
 TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_IOC_NAME);
 #ifdef CONFIG_TOSHIBA_FPCIB0

--

