Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVDFSiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVDFSiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVDFSiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 14:38:01 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5280 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262280AbVDFShw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 14:37:52 -0400
Date: Wed, 6 Apr 2005 11:37:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-embedded@ozlabs.org
Cc: Carsten Juttner <carjay@gmx.net>
Subject: [PATCH 2.6.12-rc1] ppc32: Fix mpc8xx watchdog
Message-ID: <20050406183750.GD3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_8xx_WDT option got broken in the generic hardirq update as
ppc32 had its own different request_irq that worked when other arches
used setup_irq.  This is the trivial fix for the problem.

From: Carsten Juttner <carjay@gmx.net>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -Nru a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
--- a/arch/ppc/syslib/m8xx_wdt.c	2005-02-11 07:08:20 +01:00
+++ b/arch/ppc/syslib/m8xx_wdt.c	2005-02-11 07:08:20 +01:00
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
@@ -84,8 +93,8 @@
 	imap->im_sit.sit_piscr =
 	    (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE;
 
-	if (request_irq(PIT_INTERRUPT, m8xx_wdt_interrupt, 0, "watchdog", NULL))
-		panic("m8xx_wdt: could not allocate watchdog irq!");
+	if (setup_irq(PIT_INTERRUPT, &m8xx_wdt_irqaction))
+		panic("m8xx_wdt: error setting up the watchdog irq!");
 
 	printk(KERN_NOTICE
 	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);

-- 
Tom Rini
http://gate.crashing.org/~trini/
