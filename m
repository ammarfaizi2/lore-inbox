Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUJYH37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUJYH37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUJYH1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:27:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:11680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261678AbUJYHZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:40 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 5/17] Fix DRM to support 4level page tables
Message-ID: <417CAA05.mail3YH11FMWH@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DRM to support 4level page tables

Except for some ppc32 low level drivers DRM was the only code
in drivers that needed changes for 4levels.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/drivers/char/drm/drm_memory.h linux-2.6.10rc1-4level/drivers/char/drm/drm_memory.h
--- linux-2.6.10rc1/drivers/char/drm/drm_memory.h	2004-10-19 01:55:10.000000000 +0200
+++ linux-2.6.10rc1-4level/drivers/char/drm/drm_memory.h	2004-10-25 04:48:10.000000000 +0200
@@ -121,10 +121,12 @@ agp_remap (unsigned long offset, unsigne
 	return addr;
 }
 
+/* AK: looks racy */
 static inline unsigned long
 drm_follow_page (void *vaddr)
 {
-	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
+	pml4_t *pml4 = pml4_offset_k((unsigned long) vaddr); 
+	pgd_t *pgd = pml4_pgd_offset_k(pml4, (unsigned long) vaddr);
 	pmd_t *pmd = pmd_offset(pgd, (unsigned long) vaddr);
 	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
 	return pte_pfn(*ptep) << PAGE_SHIFT;
