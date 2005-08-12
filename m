Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVHLSxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVHLSxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVHLStV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:21 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:29607 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750902AbVHLStC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:02 -0400
Subject: [patch 37/39] remap_file_pages protection support: wrong "historical" code for review - 1
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:34 +0200
Message-Id: <20050812183634.6588124E7F2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This "fast-path" was contained in the original
remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch from Ingo Molnar*; I think this
code is wrong, but I'm sending it for review anyway, because I'm unsure (and
in fact, in the end I found the reason for this).

What I think is that this patch (done only for filemap_populate, not for
shmem_populate) calls zap_page_range() when installing mappings with PROT_NONE
protection. The purpose is to avoid an useless page lookup; but the PTE's will
be simply marked as absent, not as _PAGE_NONE. So, with this fastpath, pages
would be remapped again in their "default" position.

In this case, probably a possible fix is to add yet another param in
"zap_details" to mark all PTE's as PROT_NONE ones. Using
details->nonlinear_vma has the inconvenient of using
details->{first,last}_index and of leaving file entries unchanged.

* available at
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm1/dropped/remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/filemap.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN mm/filemap.c~rfp-wrong2 mm/filemap.c
--- linux-2.6.git/mm/filemap.c~rfp-wrong2	2005-08-12 18:31:32.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-12 18:31:32.000000000 +0200
@@ -1495,6 +1495,15 @@ int filemap_populate(struct vm_area_stru
 	struct page *page;
 	int err;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_NONE))) {
+		zap_page_range(vma, addr, len, NULL);
+		return 0;
+	}
+
 	if (!nonblock)
 		force_page_cache_readahead(mapping, vma->vm_file,
 					pgoff, len >> PAGE_CACHE_SHIFT);
_
