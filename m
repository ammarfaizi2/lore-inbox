Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVCKEQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVCKEQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVCKEI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:08:56 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:24251 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263190AbVCKEAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:00:13 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:00:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6088.509134.660700@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 4/6
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microstate accounting:  Account for time in interrupt handlers for I386.

 arch/i386/kernel/irq.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)


Index: linux-2.6-ustate/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6-ustate.orig/arch/i386/kernel/irq.c	2005-03-10 09:13:00.115606274 +1100
+++ linux-2.6-ustate/arch/i386/kernel/irq.c	2005-03-10 09:16:16.032121680 +1100
@@ -55,6 +55,8 @@
 #endif
 
 	irq_enter();
+	msa_start_irq(irq);
+	
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -101,6 +103,7 @@
 #endif
 		__do_IRQ(irq, regs);
 
+	msa_finish_irq(irq);
 	irq_exit();
 
 	return 1;
@@ -221,10 +224,18 @@
 		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
+#ifdef CONFIG_MICROSTATE
+		seq_printf(p, "%10llu", msa_irq_time(0, i));
+#endif
 #else
 		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
+			if (cpu_online(j)) {
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+#ifdef CONFIG_MICROSTATE
+				seq_printf(p, "%10llu", msa_irq_time(j, i));
+#endif
+			}
+
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
