Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLVKtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLVKtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVLVKtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:49:40 -0500
Received: from ozlabs.org ([203.10.76.45]:34523 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750774AbVLVKtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:49:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17322.33982.22166.437385@cargo.ozlabs.ibm.com>
Date: Thu, 22 Dec 2005 21:49:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
In-Reply-To: <20051221175628.GA29363@suse.de>
References: <20051220204530.GA26351@suse.de>
	<20051220214525.GB7428@pb15.lixom.net>
	<20051221175628.GA29363@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:

> I finally managed to find the culprit.
> 
> good: 25635c71e44111a6bd48f342e144e2fc02d0a314
> bad:  f9bd170a87948a9e077149b70fb192c563770fdf
> 
> ...
> powerpc: Merge i8259.c into arch/powerpc/sysdev
> 
> This changes the parameters for i8259_init so that it takes two
> parameters: a physical address for generating an interrupt
> acknowledge cycle, and an interrupt number offset.  i8259_init
> now sets the irq_desc[] for its interrupts; all the callers
> were doing this, and that code is gone now.  This also defines
> a CONFIG_PPC_I8259 symbol to select i8259.o for inclusion, and
> makes the platforms that need it select that symbol.

Try this patch... it fixes things on the p630 at work.

Paul.

diff -urN linux-2.6/arch/powerpc/platforms/pseries/xics.c powerpc-merge/arch/powerpc/platforms/pseries/xics.c
--- linux-2.6/arch/powerpc/platforms/pseries/xics.c	2005-11-14 10:33:54.000000000 +1100
+++ powerpc-merge/arch/powerpc/platforms/pseries/xics.c	2005-12-22 13:17:53.000000000 +1100
@@ -48,11 +48,6 @@
 	.set_affinity = xics_set_affinity
 };
 
-static struct hw_interrupt_type xics_8259_pic = {
-	.typename = " XICS/8259",
-	.ack = xics_mask_and_ack_irq,
-};
-
 /* This is used to map real irq numbers to virtual */
 static struct radix_tree_root irq_map = RADIX_TREE_INIT(GFP_ATOMIC);
 
@@ -367,12 +362,7 @@
 	/* for sanity, this had better be < NR_IRQS - 16 */
 	if (vec == xics_irq_8259_cascade_real) {
 		irq = i8259_irq(regs);
-		if (irq == -1) {
-			/* Spurious cascaded interrupt.  Still must ack xics */
-			xics_end_irq(irq_offset_up(xics_irq_8259_cascade));
-
-			irq = -1;
-		}
+		xics_end_irq(irq_offset_up(xics_irq_8259_cascade));
 	} else if (vec == XICS_IRQ_SPURIOUS) {
 		irq = -1;
 	} else {
@@ -542,6 +532,7 @@
 		xics_irq_8259_cascade_real = *ireg;
 		xics_irq_8259_cascade
 			= virt_irq_create_mapping(xics_irq_8259_cascade_real);
+		i8259_init(0, 0);
 		of_node_put(np);
 	}
 
@@ -565,12 +556,7 @@
 #endif /* CONFIG_SMP */
 	}
 
-	xics_8259_pic.enable = i8259_pic.enable;
-	xics_8259_pic.disable = i8259_pic.disable;
-	xics_8259_pic.end = i8259_pic.end;
-	for (i = 0; i < 16; ++i)
-		get_irq_desc(i)->handler = &xics_8259_pic;
-	for (; i < NR_IRQS; ++i)
+	for (i = irq_offset_value(); i < NR_IRQS; ++i)
 		get_irq_desc(i)->handler = &xics_pic;
 
 	xics_setup_cpu();
@@ -590,7 +576,6 @@
 				no_action, 0, "8259 cascade", NULL))
 			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
 					"cascade\n");
-		i8259_init(0, 0);
 	}
 	return 0;
 }
