Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbUKPW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUKPW5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUKPWyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:54:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49162 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261877AbUKPWw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:52:29 -0500
Date: Tue, 16 Nov 2004 22:52:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10-rc2: parport_pc is broken
Message-ID: <20041116225224.I22425@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041116125842.A20648@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041116125842.A20648@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Nov 16, 2004 at 12:58:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes these build errors on machines with CONFIG_PCI=n:

drivers/parport/parport_pc.c:3199: error: `parport_init_mode' undeclared (first use in this function)
drivers/parport/parport_pc.c:3199: error: (Each undeclared identifier is reported only once
drivers/parport/parport_pc.c:3199: error: for each function it appears in.)

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- orig/drivers/parport/parport_pc.c	Mon Nov 15 09:16:18 2004
+++ linux/drivers/parport/parport_pc.c	Tue Nov 16 22:48:22 2004
@@ -3154,6 +3154,7 @@ static int __init parport_parse_dma(cons
 				     PARPORT_DMA_NONE, PARPORT_DMA_NOFIFO);
 }
 
+#ifdef CONFIG_PCI
 static int __init parport_init_mode_setup(const char *str) {
 
 	printk(KERN_DEBUG "parport_pc.c: Specified parameter parport_init_mode=%s\n", str);
@@ -3170,6 +3171,7 @@ static int __init parport_init_mode_setu
 		parport_init_mode=5;
 	return 1;
 }
+#endif
 
 #ifdef MODULE
 static const char *irq[PARPORT_PC_MAX_PORTS];
@@ -3189,16 +3191,20 @@ module_param_array(dma, charp, NULL, 0);
 MODULE_PARM_DESC(verbose_probing, "Log chit-chat during initialisation");
 module_param(verbose_probing, int, 0644);
 #endif
+#ifdef CONFIG_PCI
 MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
 MODULE_PARM(init_mode, "s");
+#endif
 
 static int __init parse_parport_params(void)
 {
 	unsigned int i;
 	int val;
 
+#ifdef CONFIG_PCI
 	if (init_mode)
 		parport_init_mode_setup(init_mode);
+#endif
 
 	for (i = 0; i < PARPORT_PC_MAX_PORTS && io[i]; i++) {
 		if (parport_parse_irq(irq[i], &val))
@@ -3313,9 +3319,9 @@ __setup ("parport=", parport_setup);
  *
  * parport_init_mode=[spp|ps2|epp|ecp|ecpepp]
  */
-
+#ifdef CONFIG_PCI
 __setup("parport_init_mode=",parport_init_mode_setup);
-
+#endif
 #endif
 
 /* "Parser" ends here */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
