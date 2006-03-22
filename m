Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWCVGqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWCVGqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWCVGh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:37:56 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22913 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750881AbWCVGhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:43 -0500
Message-Id: <20060322063759.420340000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 24/35] subarch support for mask value for irq nubmers
Content-Disposition: inline; filename=23-i386-irq-mask
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the mask value for irq numbers into subarch-specific headers.
Xen extends the IRQ numbering space to include room for dynamically
allocated virtual interrupts (in the range 256-511), which requires a
more permissive mask value.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/irq.c                      |    2 +-
 include/asm-i386/mach-default/irq_vectors.h |    2 ++
 include/asm-i386/mach-visws/irq_vectors.h   |    2 ++
 include/asm-i386/mach-voyager/irq_vectors.h |    2 ++
 include/asm-i386/mach-xen/irq_vectors.h     |    8 ++++++--
 5 files changed, 13 insertions(+), 3 deletions(-)

--- xen-subarch-2.6.orig/arch/i386/kernel/irq.c
+++ xen-subarch-2.6/arch/i386/kernel/irq.c
@@ -54,7 +54,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
 fastcall unsigned int do_IRQ(struct pt_regs *regs)
 {	
 	/* high bits used in ret_from_ code */
-	int irq = regs->orig_eax & 0xff;
+	int irq = regs->orig_eax & DO_IRQ_MASK;
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
--- xen-subarch-2.6.orig/include/asm-i386/mach-default/irq_vectors.h
+++ xen-subarch-2.6/include/asm-i386/mach-default/irq_vectors.h
@@ -86,6 +86,8 @@
 
 #include "irq_vectors_limits.h"
 
+#define DO_IRQ_MASK		255
+
 #define FPU_IRQ			13
 
 #define	FIRST_VM86_IRQ		3
--- xen-subarch-2.6.orig/include/asm-i386/mach-visws/irq_vectors.h
+++ xen-subarch-2.6/include/asm-i386/mach-visws/irq_vectors.h
@@ -53,6 +53,8 @@
 #define NR_IRQS 224
 #define NR_IRQ_VECTORS NR_IRQS
 
+#define DO_IRQ_MASK		255
+
 #define FPU_IRQ			13
 
 #define	FIRST_VM86_IRQ		3
--- xen-subarch-2.6.orig/include/asm-i386/mach-voyager/irq_vectors.h
+++ xen-subarch-2.6/include/asm-i386/mach-voyager/irq_vectors.h
@@ -59,6 +59,8 @@
 #define NR_IRQS 224
 #define NR_IRQ_VECTORS NR_IRQS
 
+#define DO_IRQ_MASK 			255
+
 #define FPU_IRQ				13
 
 #define	FIRST_VM86_IRQ		3
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/irq_vectors.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/irq_vectors.h
@@ -109,14 +109,18 @@
  */
 
 #define PIRQ_BASE		0
-#define NR_PIRQS		256
+#define PIRQ_BITS		8
+#define NR_PIRQS		(1 << PIRQ_BITS)
 
 #define DYNIRQ_BASE		(PIRQ_BASE + NR_PIRQS)
-#define NR_DYNIRQS		256
+#define DYNIRQ_BITS		8
+#define NR_DYNIRQS		(1 << DYNIRQ_BITS)
 
 #define NR_IRQS			(NR_PIRQS + NR_DYNIRQS)
 #define NR_IRQ_VECTORS		NR_IRQS
 
+#define DO_IRQ_MASK		__IRQ_MASK(PIRQ_BITS + DYNIRQ_BITS)
+
 #define pirq_to_irq(_x)		((_x) + PIRQ_BASE)
 #define irq_to_pirq(_x)		((_x) - PIRQ_BASE)
 

--
