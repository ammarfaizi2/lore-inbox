Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVDLUXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVDLUXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVDLUVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:21:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:17608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262130AbVDLKbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:24 -0400
Message-Id: <200504121031.j3CAVD6u005268@shell0.pdx.osdl.net>
Subject: [patch 036/198] ppc32: Fix mpc8xx watchdog
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org,
       carjay@gmx.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tom Rini <trini@kernel.crashing.org>

The CONFIG_8xx_WDT option got broken in the generic hardirq update as ppc32
had its own different request_irq that worked when other arches used
setup_irq.  This is the trivial fix for the problem.

From: Carsten Juttner <carjay@gmx.net>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/syslib/m8xx_wdt.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN arch/ppc/syslib/m8xx_wdt.c~ppc32-fix-mpc8xx-watchdog arch/ppc/syslib/m8xx_wdt.c
--- 25/arch/ppc/syslib/m8xx_wdt.c~ppc32-fix-mpc8xx-watchdog	2005-04-12 03:21:12.059303608 -0700
+++ 25-akpm/arch/ppc/syslib/m8xx_wdt.c	2005-04-12 03:21:12.062303152 -0700
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/8xx_immap.h>
@@ -18,6 +19,12 @@
 
 static int wdt_timeout;
 
+static irqreturn_t m8xx_wdt_interrupt(int, void *, struct pt_regs *);
+static struct irqaction m8xx_wdt_irqaction = {
+	.handler = m8xx_wdt_interrupt,
+	.name = "watchdog",
+};
+
 void m8xx_wdt_reset(void)
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
@@ -84,8 +91,8 @@ void __init m8xx_wdt_handler_install(bd_
 	imap->im_sit.sit_piscr =
 	    (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE;
 
-	if (request_irq(PIT_INTERRUPT, m8xx_wdt_interrupt, 0, "watchdog", NULL))
-		panic("m8xx_wdt: could not allocate watchdog irq!");
+	if (setup_irq(PIT_INTERRUPT, &m8xx_wdt_irqaction))
+		panic("m8xx_wdt: error setting up the watchdog irq!");
 
 	printk(KERN_NOTICE
 	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);
_
