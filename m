Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUHDXR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUHDXR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHDXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:16:53 -0400
Received: from ozlabs.org ([203.10.76.45]:20377 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267497AbUHDXQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:16:23 -0400
Date: Thu, 5 Aug 2004 09:13:26 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] [ppc64] Various XICS fixes
Message-ID: <20040804231326.GY30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove unused includes.
- Be consistent about printing irq numbers, avoid a mix of decimal and
  hexadecimal.
- Remove prototypes from xics.c, they should be in xics.h.
- Remove infinite loop on failure, and instead use panic. Panic has a chance to
  log the error message on the LED panel and reboot the box, a while(1) loop
  does not.
- xics isnt compiled for iseries any more, so no need for the
  CONFIG_PPC_PSERIES hack.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/xics.c~morexicsstuff arch/ppc64/kernel/xics.c
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/xics.c~morexicsstuff	2004-08-04 17:46:40.072888203 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/xics.c	2004-08-04 17:46:40.090885343 -0500
@@ -27,7 +27,6 @@
 #include <asm/naca.h>
 #include <asm/rtas.h>
 #include <asm/xics.h>
-#include <asm/ppcdebug.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
 
@@ -286,7 +285,7 @@ static void xics_enable_irq(unsigned int
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_set_xive "
+		printk(KERN_ERR "xics_enable_irq: irq=%d: ibm_set_xive "
 		       "returned %x\n", irq, call_status);
 		return;
 	}
@@ -294,7 +293,7 @@ static void xics_enable_irq(unsigned int
 	/* Now unmask the interrupt (often a no-op) */
 	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_int_on "
+		printk(KERN_ERR "xics_enable_irq: irq=%d: ibm_int_on "
 		       "returned %x\n", irq, call_status);
 		return;
 	}
@@ -310,7 +309,7 @@ static void xics_disable_real_irq(unsign
 
 	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_disable_real_irq: irq=%x: "
+		printk(KERN_ERR "xics_disable_real_irq: irq=%d: "
 		       "ibm_int_off returned %x\n", irq, call_status);
 		return;
 	}
@@ -319,7 +318,7 @@ static void xics_disable_real_irq(unsign
 	/* Have to set XIVE to 0xff to be able to remove a slot */
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server, 0xff);
 	if (call_status != 0) {
-		printk(KERN_ERR "xics_disable_irq: irq=%x: ibm_set_xive(0xff)"
+		printk(KERN_ERR "xics_disable_irq: irq=%d: ibm_set_xive(0xff)"
 		       " returned %x\n", irq, call_status);
 		return;
 	}
@@ -356,8 +355,6 @@ static void xics_mask_and_ack_irq(unsign
 	}
 }
 
-extern unsigned int real_irq_to_virt_slowpath(unsigned int real_irq);
-
 int xics_get_irq(struct pt_regs *regs)
 {
 	unsigned int cpu = smp_processor_id();
@@ -384,7 +381,7 @@ int xics_get_irq(struct pt_regs *regs)
 		if (irq == NO_IRQ)
 			irq = real_irq_to_virt_slowpath(vec);
 		if (irq == NO_IRQ) {
-			printk(KERN_ERR "Interrupt 0x%x (real) is invalid,"
+			printk(KERN_ERR "Interrupt %d (real) is invalid,"
 			       " disabling it.\n", vec);
 			xics_disable_real_irq(vec);
 		} else
@@ -395,8 +392,6 @@ int xics_get_irq(struct pt_regs *regs)
 
 #ifdef CONFIG_SMP
 
-extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
-
 irqreturn_t xics_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
@@ -469,11 +464,9 @@ void xics_init_IRQ(void)
 	ibm_int_off = rtas_token("ibm,int-off");
 
 	np = of_find_node_by_type(NULL, "PowerPC-External-Interrupt-Presentation");
-	if (!np) {
-		printk(KERN_WARNING "Can't find Interrupt Presentation\n");
-		udbg_printf("Can't find Interrupt Presentation\n");
-		while (1);
-	}
+	if (!np)
+		panic("xics_init_IRQ: can't find interrupt presentation");
+
 nextnode:
 	ireg = (uint *)get_property(np, "ibm,interrupt-server-ranges", NULL);
 	if (ireg) {
@@ -484,11 +477,8 @@ nextnode:
 	}
 
 	ireg = (uint *)get_property(np, "reg", &ilen);
-	if (!ireg) {
-		printk(KERN_WARNING "Can't find Interrupt Reg Property\n");
-		udbg_printf("Can't find Interrupt Reg Property\n");
-		while (1);
-	}
+	if (!ireg)
+		panic("xics_init_IRQ: can't find interrupt reg property");
 	
 	while (ilen) {
 		inodes[indx].addr = (unsigned long long)*ireg++ << 32;
@@ -528,16 +518,14 @@ nextnode:
 
 	np = of_find_node_by_type(NULL, "interrupt-controller");
 	if (!np) {
-		printk(KERN_WARNING "xics:  no ISA Interrupt Controller\n");
+		printk(KERN_WARNING "xics: no ISA interrupt controller\n");
 		xics_irq_8259_cascade_real = -1;
 		xics_irq_8259_cascade = -1;
 	} else {
 		ireg = (uint *) get_property(np, "interrupts", NULL);
-		if (!ireg) {
-			printk(KERN_WARNING "Can't find ISA Interrupts Property\n");
-			udbg_printf("Can't find ISA Interrupts Property\n");
-			while (1);
-		}
+		if (!ireg)
+			panic("xics_init_IRQ: can't find ISA interrupts property");
+
 		xics_irq_8259_cascade_real = *ireg;
 		xics_irq_8259_cascade
 			= virt_irq_create_mapping(xics_irq_8259_cascade_real);
@@ -558,13 +546,8 @@ nextnode:
 		xics_per_cpu[0] = __ioremap((ulong)intr_base, intr_size,
 					    _PAGE_NO_CACHE);
 #endif /* CONFIG_SMP */
-#ifdef CONFIG_PPC_PSERIES
-	/* actually iSeries does not use any of xics...but it has link dependencies
-	 * for now, except this new one...
-	 */
 	} else if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
 		ops = &pSeriesLP_ops;
-#endif
 	}
 
 	xics_8259_pic.enable = i8259_pic.enable;
@@ -590,7 +573,8 @@ static int __init xics_setup_i8259(void)
 	    xics_irq_8259_cascade != -1) {
 		if (request_irq(irq_offset_up(xics_irq_8259_cascade),
 				no_action, 0, "8259 cascade", NULL))
-			printk(KERN_ERR "xics_init_IRQ: couldn't get 8259 cascade\n");
+			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
+					"cascade\n");
 		i8259_init();
 	}
 	return 0;
@@ -643,7 +627,7 @@ static void xics_set_affinity(unsigned i
 				irq, newmask, xics_status[1]);
 
 	if (status) {
-		printk(KERN_ERR "xics_set_affinity irq=%d ibm,set-xive "
+		printk(KERN_ERR "xics_set_affinity: irq=%d ibm,set-xive "
 		       "returns %d\n", irq, status);
 		return;
 	}
@@ -723,7 +707,7 @@ void xics_migrate_irqs_away(void)
 		status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
 				xics_status[0], xics_status[1]);
 		if (status)
-			printk(KERN_ERR "migrate_irqs_away irq=%d "
+			printk(KERN_ERR "migrate_irqs_away: irq=%d "
 					"ibm,set-xive returns %d\n",
 					virq, status);
 
diff -puN include/asm-ppc64/irq.h~morexicsstuff include/asm-ppc64/irq.h
--- linux-2.6.8-rc2-mm2/include/asm-ppc64/irq.h~morexicsstuff	2004-08-04 17:46:40.077887409 -0500
+++ linux-2.6.8-rc2-mm2-anton/include/asm-ppc64/irq.h	2004-08-04 17:46:40.091885184 -0500
@@ -9,8 +9,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/config.h>
 #include <linux/threads.h>
-#include <asm/atomic.h>
 
 /*
  * Maximum number of interrupt sources that we can handle.
@@ -46,6 +46,8 @@ static inline unsigned int virt_irq_to_r
 	return virt_irq_to_real_map[virt_irq];
 }
 
+extern unsigned int real_irq_to_virt_slowpath(unsigned int real_irq);
+
 /*
  * Because many systems have two overlapping names spaces for
  * interrupts (ISA and XICS for example), and the ISA interrupts

_
