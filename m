Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWKBMrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWKBMrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWKBMrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:47:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:41706 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751256AbWKBMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:47:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] spufs: always map local store non-guarded
Date: Thu, 2 Nov 2006 13:46:48 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       cbe-oss-dev@ozlabs.org, michaele@au1.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021346.49473.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing spufs to map the 'mem' file backing store cacheable,
I incorrectly set the physical mapping to use both cache-inhibited
and guarded mapping, which resulted in a serious performance
degradation.

Accessing the real local store memory needs to be cache-inhibited,
in order to maintain data consistency, but since it is actual
RAM, there is no point in a guarded mapping.

Debugged-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

This fixes a regression in 2.6.19, please merge.

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -104,11 +104,11 @@ spufs_mem_mmap_nopage(struct vm_area_str
 
 	if (ctx->state == SPU_STATE_SAVED) {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-					& ~(_PAGE_NO_CACHE | _PAGE_GUARDED));
+							& ~_PAGE_NO_CACHE);
 		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
 	} else {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-					| _PAGE_NO_CACHE | _PAGE_GUARDED);
+							| _PAGE_NO_CACHE);
 		page = pfn_to_page((ctx->spu->local_store_phys + offset)
 				   >> PAGE_SHIFT);
 	}
