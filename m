Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVAJOrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVAJOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVAJOrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:47:09 -0500
Received: from ozlabs.org ([203.10.76.45]:11677 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262279AbVAJOrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:47:02 -0500
Date: Tue, 11 Jan 2005 01:43:39 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Fix rtas_set_indicator(9005)
Message-ID: <20050110144339.GW14239@krispykreme.ozlabs.ibm.com>
References: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com> <20050110134120.GU14239@krispykreme.ozlabs.ibm.com> <20050110143536.GV14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110143536.GV14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It turns out we were passing in the wrong thing to the
rtas_set_indicator call. Luckily we got away with it because it looks
like firmware does not check arguments and just inserts or removes the
current cpu from the global server group.

Fix it.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pSeries_smp.c~fix_gqirm_set_indicator arch/ppc64/kernel/pSeries_smp.c
--- foobar2/arch/ppc64/kernel/pSeries_smp.c~fix_gqirm_set_indicator	2005-01-11 00:03:35.491865383 +1100
+++ foobar2-anton/arch/ppc64/kernel/pSeries_smp.c	2005-01-11 00:03:35.521863094 +1100
@@ -265,7 +265,8 @@ static void __devinit smp_xics_setup_cpu
 	 * necessary from a secondary thread as the OF start-cpu interface
 	 * performs this function for us on primary threads.
 	 */
-	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE, default_distrib_server, 1);
+	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
 #endif
 }
 
diff -puN arch/ppc64/kernel/xics.c~fix_gqirm_set_indicator arch/ppc64/kernel/xics.c
--- foobar2/arch/ppc64/kernel/xics.c~fix_gqirm_set_indicator	2005-01-11 00:03:35.496865001 +1100
+++ foobar2-anton/arch/ppc64/kernel/xics.c	2005-01-11 00:03:35.524862865 +1100
@@ -91,6 +91,7 @@ static int xics_irq_8259_cascade_real = 
 static unsigned int default_server = 0xFF;
 /* also referenced in smp.c... */
 unsigned int default_distrib_server = 0;
+unsigned int interrupt_server_size = 8;
 
 /*
  * XICS only has a single IPI, so encode the messages per CPU
@@ -511,6 +512,10 @@ nextnode:
 				default_server = ireg[0];
 				default_distrib_server = ireg[i-1]; /* take last element */
 			}
+			ireg = (uint *)get_property(np,
+					"ibm,interrupt-server#-size", NULL);
+			if (ireg)
+				interrupt_server_size = *ireg;
 			break;
 		}
 	}
@@ -650,9 +655,9 @@ void xics_migrate_irqs_away(void)
 	ops->cppr_info(cpu, 0);
 	iosync();
 
-	/* Refuse any new interrupts... */
+	/* remove ourselves from the global interrupt queue */
 	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
-				    hard_smp_processor_id(), 0);
+		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
 	WARN_ON(status != 0);
 
 	/* Allow IPIs again... */
diff -puN include/asm-ppc64/xics.h~fix_gqirm_set_indicator include/asm-ppc64/xics.h
--- foobar2/include/asm-ppc64/xics.h~fix_gqirm_set_indicator	2005-01-11 00:03:35.502864543 +1100
+++ foobar2-anton/include/asm-ppc64/xics.h	2005-01-11 00:03:35.525862789 +1100
@@ -31,5 +31,6 @@ struct xics_ipi_struct {
 extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
 
 extern unsigned int default_distrib_server;
+extern unsigned int interrupt_server_size;
 
 #endif /* _PPC64_KERNEL_XICS_H */
_
