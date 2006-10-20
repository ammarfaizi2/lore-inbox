Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWJTBhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWJTBhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWJTBhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:37:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:50877 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751664AbWJTBhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:37:19 -0400
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <45377ED3.9030001@bplan-gmbh.de>
References: <20061019122802.GA26637@aepfle.de>
	 <45377ED3.9030001@bplan-gmbh.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:37:01 +1000
Message-Id: <1161308221.10524.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On CHRP with only a 8259, make sure it's set as the default host.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Can you test this patch ?

Index: linux-cell/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/chrp/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/chrp/setup.c	2006-10-20 11:31:05.000000000 +1000
@@ -477,8 +477,10 @@ static void __init chrp_find_8259(void)
 		       " address, polling\n");
 
 	i8259_init(pic, chrp_int_ack);
-	if (ppc_md.get_irq == NULL)
+	if (ppc_md.get_irq == NULL) {
 		ppc_md.get_irq = i8259_irq;
+		irq_set_default_host(i8259_get_host());
+	}
 	if (chrp_mpic != NULL) {
 		cascade_irq = irq_of_parse_and_map(pic, 0);
 		if (cascade_irq == NO_IRQ)
Index: linux-cell/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/i8259.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/i8259.c	2006-10-20 11:32:07.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/prom.h>
@@ -224,6 +225,12 @@ static struct irq_host_ops i8259_host_op
 	.xlate = i8259_host_xlate,
 };
 
+struct irq_host *i8259_get_host(void)
+{
+	return i8259_host;
+}
+EXPORT_SYMBOL(i8259_get_host);
+
 /**
  * i8259_init - Initialize the legacy controller
  * @node: device node of the legacy PIC (can be NULL, but then, it will match
Index: linux-cell/include/asm-powerpc/i8259.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/i8259.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-cell/include/asm-powerpc/i8259.h	2006-10-20 11:30:19.000000000 +1000
@@ -7,6 +7,7 @@
 #ifdef CONFIG_PPC_MERGE
 extern void i8259_init(struct device_node *node, unsigned long intack_addr);
 extern unsigned int i8259_irq(void);
+extern struct irq_host *i8259_get_host(void);
 #else
 extern void i8259_init(unsigned long intack_addr, int offset);
 extern int i8259_irq(void);


