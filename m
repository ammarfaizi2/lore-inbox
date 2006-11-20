Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966330AbWKTSOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966330AbWKTSOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKTSNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:13:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:22266 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934280AbWKTSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:03 -0500
Message-Id: <20061120180524.546658000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:06 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 12/22] spufs: always map local store non-guarded
Content-Disposition: inline; filename=spufs-map-nonguarded.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing spufs to map the 'mem' file backing store cacheable,
I incorrectly set the physical mapping to use both cache-inhibited
and guarded mapping, which resulted in a serious performance
degradation.

Debugged-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -105,11 +105,11 @@ spufs_mem_mmap_nopage(struct vm_area_str
 
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

--

