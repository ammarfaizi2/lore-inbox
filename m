Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUAUEDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUAUEDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:03:05 -0500
Received: from dp.samba.org ([66.70.73.150]:22986 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261606AbUAUEC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:02:56 -0500
Date: Wed, 21 Jan 2004 14:58:56 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] vmalloc fix
Message-ID: <20040121035856.GA4372@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Paul wrote a patch to use some of the rmap infrastructure to flush TLB
entries on ppc64. When testing it we found a problem in vmalloc where it
sets up the pte -> address mapping incorrectly. We clear the top bits of
the address but then forget to pass in the full address to
pte_alloc_kernel. The end result is the address in page->index is
truncated.

I fixed it in a similar way to how zeromap_pmd_range etc does it. Im
guessing no one uses the rmap hooks on vmalloc pages yet, so havent seen
this problem.

Anton

===== mm/vmalloc.c 1.29 vs edited =====
--- 1.29/mm/vmalloc.c	Wed Oct  8 12:53:44 2003
+++ edited/mm/vmalloc.c	Wed Jan 21 14:48:23 2004
@@ -114,15 +114,16 @@
 			       unsigned long size, pgprot_t prot,
 			       struct page ***pages)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
 		if (map_area_pte(pte, address, end - address, prot, pages))
