Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUJZEuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUJZEuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUJZErJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:47:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:51672 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262077AbUJZEmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:42:47 -0400
Subject: [PATCH] ppc64: Fix new mpic driver on some POWER3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 14:39:40 +1000
Message-Id: <1098765580.5154.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On machines using the "ISU" mecanism for the MPIC, the new driver didn't properly
calculate the new interrupt count when an ISU was added. That would cause later on 
failure to request interrupts in the offending range.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/mpic.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/mpic.c	2004-10-26 10:32:23.000000000 +1000
+++ linux-work/arch/ppc64/kernel/mpic.c	2004-10-26 14:36:00.464755000 +1000
@@ -580,11 +580,13 @@
 void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
 			    unsigned long phys_addr)
 {
+	unsigned int isu_first = isu_num * mpic->isu_size;
+
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
 	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
-	if ((isu_num + mpic->isu_size) > mpic->num_sources)
-		mpic->num_sources = isu_num + mpic->isu_size;
+	if ((isu_first + mpic->isu_size) > mpic->num_sources)
+		mpic->num_sources = isu_first + mpic->isu_size;
 }
 
 void __init mpic_setup_cascade(unsigned int irq, mpic_cascade_t handler,


