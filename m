Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUKEX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUKEX7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUKEX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:59:40 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14842 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261246AbUKEX7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:59:23 -0500
Date: Fri, 5 Nov 2004 16:59:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: ebs@ebshome.net, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Add PPC440GX L2C error handler
Message-ID: <20041105165921.K12135@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an L2-Cache error handler. In addition,
it reenables setup of the L2 cache based on erratum
L2C0_1 now that we have been reassured that there are
no more faulty parts being shipped. If there is a
problem, the error handler will report it.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/syslib/ibm440gx_common.c 1.2 vs edited =====
--- 1.2/arch/ppc/syslib/ibm440gx_common.c	2004-10-18 22:26:41 -07:00
+++ edited/arch/ppc/syslib/ibm440gx_common.c	2004-11-05 16:28:07 -07:00
@@ -4,7 +4,7 @@
  * PPC440GX system library
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003 Zultys Technologies
+ * Copyright (c) 2003, 2004 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -97,10 +98,51 @@
 		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
 }
 
-/* Enable L2 cache (call with IRQs disabled) */
+/* Issue L2C diagnostic command */
+static inline u32 l2c_diag(u32 addr)
+{
+	mtdcr(DCRN_L2C0_ADDR, addr);
+	mtdcr(DCRN_L2C0_CMD, L2C_CMD_DIAG);
+	while (!(mfdcr(DCRN_L2C0_SR) & L2C_SR_CC)) ;
+	return mfdcr(DCRN_L2C0_DATA);
+}
+
+static irqreturn_t l2c_error_handler(int irq, void* dev, struct pt_regs* regs)
+{
+	u32 sr = mfdcr(DCRN_L2C0_SR);
+	if (sr & L2C_SR_CPE){
+		/* Read cache trapped address */
+		u32 addr = l2c_diag(0x42000000);
+		printk(KERN_EMERG "L2C: Cache Parity Error, addr[16:26] = 0x%08x\n", addr);
+	}
+	if (sr & L2C_SR_TPE){
+		/* Read tag trapped address */
+		u32 addr = l2c_diag(0x82000000) >> 16;
+		printk(KERN_EMERG "L2C: Tag Parity Error, addr[16:26] = 0x%08x\n", addr);
+	}
+	
+	/* Clear parity errors */
+	if (sr & (L2C_SR_CPE | L2C_SR_TPE)){
+		mtdcr(DCRN_L2C0_ADDR, 0);
+		mtdcr(DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
+	} else
+		printk(KERN_EMERG "L2C: LRU error\n");
+
+	return IRQ_HANDLED;
+}
+
+/* Enable L2 cache */
 void __init ibm440gx_l2c_enable(void){
 	u32 r;
-
+	unsigned long flags;
+	
+	/* Install error handler */
+	if (request_irq(87, l2c_error_handler, SA_INTERRUPT, "L2C", 0) < 0){	
+		printk(KERN_ERR "Cannot install L2C error handler, cache is not enabled\n");
+		return;
+	}
+	
+	local_irq_save(flags);
 	asm volatile ("sync" ::: "memory");
 
 	/* Disable SRAM */
@@ -137,20 +179,22 @@
 
 	/* Enable ICU/DCU ports */
 	r = mfdcr(DCRN_L2C0_CFG);
-	r &= ~(L2C_CFG_DCW_MASK | L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM
-		| L2C_CFG_PMUX_MASK | L2C_CFG_PMIM | L2C_CFG_TPEI | L2C_CFG_CPEI
-		| L2C_CFG_NAM | L2C_CFG_NBRM);
-	r |= L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_TPC | L2C_CFG_CPC | L2C_CFG_FRAN
-		| L2C_CFG_SMCM;
+	r &= ~(L2C_CFG_DCW_MASK | L2C_CFG_PMUX_MASK | L2C_CFG_PMIM | L2C_CFG_TPEI 
+		| L2C_CFG_CPEI | L2C_CFG_NAM | L2C_CFG_NBRM);
+	r |= L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_TPC | L2C_CFG_CPC | L2C_CFG_FRAN 
+		| L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM | L2C_CFG_SMCM;
 	mtdcr(DCRN_L2C0_CFG, r);
 
 	asm volatile ("sync; isync" ::: "memory");
+	local_irq_restore(flags);
 }
 
-/* Disable L2 cache (call with IRQs disabled) */
+/* Disable L2 cache */
 void __init ibm440gx_l2c_disable(void){
 	u32 r;
+	unsigned long flags;
 
+	local_irq_save(flags);
 	asm volatile ("sync" ::: "memory");
 
 	/* Disable L2C mode */
@@ -169,6 +213,7 @@
 	      SRAM_SBCR_BAS3 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
 
 	asm volatile ("sync; isync" ::: "memory");
+	local_irq_restore(flags);
 }
 
 void __init ibm440gx_l2c_setup(struct ibm44x_clocks* p)
===== arch/ppc/platforms/4xx/ocotea.c 1.10 vs edited =====
--- 1.10/arch/ppc/platforms/4xx/ocotea.c	2004-11-02 07:40:33 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-11-05 16:28:06 -07:00
@@ -145,13 +145,13 @@
 }
 
 #define PCIX_READW(offset) \
-	(readw((u32)pcix_reg_base+offset))
+	(readw(pcix_reg_base+offset))
 
 #define PCIX_WRITEW(value, offset) \
-	(writew(value, (u32)pcix_reg_base+offset))
+	(writew(value, pcix_reg_base+offset))
 
 #define PCIX_WRITEL(value, offset) \
-	(writel(value, (u32)pcix_reg_base+offset))
+	(writel(value, pcix_reg_base+offset))
 
 /*
  * FIXME: This is only here to "make it work".  This will move
@@ -321,6 +321,11 @@
 	printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
 }
 
+static void __init ocotea_init(void)
+{
+	ibm440gx_l2c_setup(&clocks);
+}
+
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
@@ -341,13 +346,12 @@
 	 */
 	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
 	ocp_sys_info.opb_bus_freq = clocks.opb;
-
-	/*
-	 * Always disable L2 cache. All revs/speeds of silicon
-	 * have parity error problems despite errata claims to
-	 * the contrary.
+	
+	/* XXX Fix L2C IRQ triggerring setting (edge-sensitive). 
+	 * Firmware (at least PIBS v1.72 OCT/28/2003) sets it incorrectly 
+	 * --ebs
 	 */
-	ibm440gx_l2c_disable();
+	mtdcr(DCRN_UIC_TR(UIC2), mfdcr(DCRN_UIC_TR(UIC2)) | 0x00000100);
 
 	ibm44x_platform_init();
 
@@ -365,4 +369,5 @@
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = ocotea_early_serial_map;
 #endif
+	ppc_md.init = ocotea_init;
 }
