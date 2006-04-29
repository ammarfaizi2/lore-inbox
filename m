Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWD2Aqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWD2Aqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWD2Aq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 20:46:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:57325 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030215AbWD2AqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 20:46:06 -0400
Message-Id: <20060429004327.520785000@localhost.localdomain>
References: <20060429004019.126937000@localhost.localdomain>
Date: Sat, 29 Apr 2006 02:40:21 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 2/3] spufs: Disable local interrupts for SPE hash_page calls.
Content-Disposition: inline; filename=spu-hash-page-fix-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables and saves local interrupts during
hash_page processing for SPE contexts.

We have to do it explicitly in the spu_irq_class_1_bottom
function. For the interrupt handlers, we get the behaviour
implicitly by using SA_INTERRUPT to disable interrupts while
in the handler.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -306,19 +306,19 @@ spu_request_irqs(struct spu *spu)
 
 	snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0", spu->number);
 	ret = request_irq(irq_base + spu->isrc,
-		 spu_irq_class_0, 0, spu->irq_c0, spu);
+		 spu_irq_class_0, SA_INTERRUPT, spu->irq_c0, spu);
 	if (ret)
 		goto out;
 
 	snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1", spu->number);
 	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_1, 0, spu->irq_c1, spu);
+		 spu_irq_class_1, SA_INTERRUPT, spu->irq_c1, spu);
 	if (ret)
 		goto out1;
 
 	snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2", spu->number);
 	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_2, 0, spu->irq_c2, spu);
+		 spu_irq_class_2, SA_INTERRUPT, spu->irq_c2, spu);
 	if (ret)
 		goto out2;
 	goto out;
@@ -487,10 +487,14 @@ int spu_irq_class_1_bottom(struct spu *s
 	ea = spu->dar;
 	dsisr = spu->dsisr;
 	if (dsisr & (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED)) {
+		u64 flags;
+
 		access = (_PAGE_PRESENT | _PAGE_USER);
 		access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
+		local_irq_save(flags);
 		if (hash_page(ea, access, 0x300) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
+		local_irq_restore(flags);
 	}
 	if (error & CLASS1_ENABLE_STORAGE_FAULT_INTR) {
 		if ((ret = spu_handle_mm_fault(spu)) != 0)

--

