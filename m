Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVHZRCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVHZRCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVHZRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:01:59 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:26517 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965114AbVHZRBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:40 -0400
Subject: [patch 14/18] remap_file_pages protection support: avoid lookup and I/O of pages for PROT_NONE remapping
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:52 +0200
Message-Id: <20050826165353.1C42E254853@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

This optimization avoid looking up pages for PROT_NONE mappings, and instead
simply clear the page tables. This code was taken straight from Ingo's patch.

However, this code is only correct if we disallow having VMA with protections
!= PROT_NONE; on a VM_READ vma, for instance, the cleared PTE would be faulted
in again, which is wrong.

We could (in order of preference)
*) use the subsequent patch; you may feel it's a bit intrusive, but it's not
too much, and may further be simplified.
*) drop this optimization
*) additionally check that the VMA is PROT_NONE in this optimization (but we
would have to disallow mprotect() on the VMA or specify the mappings get in an
"unspecified" state)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/filemap.c |   14 ++++++++++++++
 linux-2.6.git-paolo/mm/shmem.c   |    9 +++++++++
 2 files changed, 23 insertions(+)

diff -puN mm/filemap.c~rfp-avoid-lookup-miss-mapping-base mm/filemap.c
--- linux-2.6.git/mm/filemap.c~rfp-avoid-lookup-miss-mapping-base	2005-08-25 13:01:32.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-25 13:01:32.000000000 +0200
@@ -1495,6 +1495,20 @@ int filemap_populate(struct vm_area_stru
 	struct page *page;
 	int err;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(__S000))) {
+		/* Still do error-checking! */
+		size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+		if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
+			return -EINVAL;
+
+		zap_page_range(vma, addr, len, NULL);
+		return 0;
+	}
+
 	if (!nonblock)
 		force_page_cache_readahead(mapping, vma->vm_file,
 					pgoff, len >> PAGE_CACHE_SHIFT);
diff -puN mm/shmem.c~rfp-avoid-lookup-miss-mapping-base mm/shmem.c
--- linux-2.6.git/mm/shmem.c~rfp-avoid-lookup-miss-mapping-base	2005-08-25 13:01:32.000000000 +0200
+++ linux-2.6.git-paolo/mm/shmem.c	2005-08-25 13:01:32.000000000 +0200
@@ -1186,6 +1186,15 @@ static int shmem_populate(struct vm_area
 	if (pgoff >= size || pgoff + (len >> PAGE_SHIFT) > size)
 		return -EINVAL;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(__S000))) {
+		zap_page_range(vma, addr, len, NULL);
+		return 0;
+	}
+
 	while ((long) len > 0) {
 		struct page *page = NULL;
 		int err;
_
