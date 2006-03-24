Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWCXStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWCXStt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCXStt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:49:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19690 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932507AbWCXSts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:49:48 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] spufs: Fix endless protection fault on LS writes by SPE.
Date: Fri, 24 Mar 2006 19:49:27 +0100
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <abergman@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
In-Reply-To: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241949.28218.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an SPE attempts a DMA put to a local store after already doing
a get, the kernel must update the HW PTE to allow the write access.
This case was not being handled correctly.

From: Mike Kistler <mkistler@us.ibm.com>
Signed-off-by: Mike Kistler <mkistler@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
diff -ur linux-2.6.15/arch/powerpc/platforms/cell/spu_base.c linux-2.6.15.fixed/arch/powerpc/platforms/cell/spu_base.c
--- linux-2.6.15/arch/powerpc/platforms/cell/spu_base.c	2006-03-22 12:30:07.000000000 -0600
+++ linux-2.6.15.fixed/arch/powerpc/platforms/cell/spu_base.c	2006-03-22 10:21:26.000000000 -0600
@@ -486,14 +486,13 @@
 
 	ea = spu->dar;
 	dsisr = spu->dsisr;
-	if (dsisr & MFC_DSISR_PTE_NOT_FOUND) {
+	if (dsisr & (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED)) {
 		access = (_PAGE_PRESENT | _PAGE_USER);
 		access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
 		if (hash_page(ea, access, 0x300) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
 	}
-	if ((error & CLASS1_ENABLE_STORAGE_FAULT_INTR) ||
-	    (dsisr & MFC_DSISR_ACCESS_DENIED)) {
+	if (error & CLASS1_ENABLE_STORAGE_FAULT_INTR) {
 		if ((ret = spu_handle_mm_fault(spu)) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
 		else
