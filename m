Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269885AbUJTHg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269885AbUJTHg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTHdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:33:19 -0400
Received: from ozlabs.org ([203.10.76.45]:4529 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269885AbUJTHFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:05:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16758.2820.837861.36805@cargo.ozlabs.ibm.com>
Date: Wed, 20 Oct 2004 16:51:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix XICS startup function to enable as well
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the generic IRQ patch went in, it changed the behaviour of
setup_irq (compared to the previous ppc64 version) in that we now
don't call the handler's enable function if it has a startup
function.  The XICS interrupt controller has a startup function, and
so we weren't getting any interrupts through the XICS because they
never got enabled.  This patch adds a call to xics_enable_irq to
xics_startup and fixes the problem.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/xics.c test/arch/ppc64/kernel/xics.c
--- linux-2.5/arch/ppc64/kernel/xics.c	2004-08-24 07:22:47.000000000 +1000
+++ test/arch/ppc64/kernel/xics.c	2004-10-20 15:24:17.927552904 +1000
@@ -216,12 +216,15 @@
 
 static unsigned int xics_startup(unsigned int virq)
 {
-	virq = irq_offset_down(virq);
-	if (radix_tree_insert(&irq_map, virt_irq_to_real(virq),
-			      &virt_irq_to_real_map[virq]) == -ENOMEM)
+	unsigned int irq;
+
+	irq = irq_offset_down(virq);
+	if (radix_tree_insert(&irq_map, virt_irq_to_real(irq),
+			      &virt_irq_to_real_map[irq]) == -ENOMEM)
 		printk(KERN_CRIT "Out of memory creating real -> virtual"
 		       " IRQ mapping for irq %u (real 0x%x)\n",
-		       virq, virt_irq_to_real(virq));
+		       virq, virt_irq_to_real(irq));
+	xics_enable_irq(virq);
 	return 0;	/* return value is ignored */
 }
 
