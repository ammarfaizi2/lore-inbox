Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVE0WLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVE0WLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVE0WLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:11:04 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:15538 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262619AbVE0WJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:09:47 -0400
Date: Fri, 27 May 2005 17:09:19 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, rvinson@mvista.com
Subject: [PATCH] ppc32: Add soft reset to MPC834x
Message-ID: <Pine.LNX.4.61.0505271708380.25368@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows mpc83xx_restart to issue a software reset.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1a0a26adb3ef9323ac3e17e14af6c2b138f1656a
tree ec5c9971711cdd5ce074c2798a16cc12d35318ee
parent 2c6dd281d28694239de9e453541ed3b937d11e25
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 09:35:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 27 May 2005 09:35:28 -0500

 ppc/platforms/83xx/mpc834x_sys.h |    6 ++++++
 ppc/syslib/ppc83xx_setup.c       |   28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ ec5c9971711cdd5ce074c2798a16cc12d35318ee/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -28,6 +28,12 @@
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
+#define BCSR_MISC_REG2_OFF	0x07
+#define BCSR_MISC_REG2_PORESET	0x01
+
+#define BCSR_MISC_REG3_OFF	0x08
+#define BCSR_MISC_REG3_CNFLOCK	0x80
+
 #ifdef CONFIG_PCI
 /* PCI interrupt controller */
 #define PIRQA        MPC83xx_IRQ_IRQ4
Index: arch/ppc/syslib/ppc83xx_setup.c
===================================================================
--- 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
+++ ec5c9971711cdd5ce074c2798a16cc12d35318ee/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
@@ -29,6 +29,7 @@
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
+#include <asm/delay.h>
 
 #include <syslib/ppc83xx_setup.h>
 
@@ -117,7 +118,34 @@
 void
 mpc83xx_restart(char *cmd)
 {
+	volatile unsigned char __iomem *reg;
+	unsigned char tmp;
+
+	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+
 	local_irq_disable();
+
+	/*
+	 * Unlock the BCSR bits so a PRST will update the contents.
+	 * Otherwise the reset asserts but doesn't clear.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG3_OFF);
+	tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
+	out_8(reg + BCSR_MISC_REG3_OFF, tmp);
+
+	/*
+	 * Trigger a reset via a low->high transition of the
+	 * PORESET bit.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG2_OFF);
+	tmp &= ~BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
+	udelay(1);
+
+	tmp |= BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
 	for(;;);
 }
 
