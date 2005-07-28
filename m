Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVG1Smr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVG1Smr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1Smq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:42:46 -0400
Received: from [151.97.230.9] ([151.97.230.9]:21992 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261465AbVG1SmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:42:01 -0400
Subject: [patch 3/3] uml: fix tlb flushing for accessed bit
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 20:57:02 +0200
Message-Id: <20050728185702.B5CB95EFD@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark a page with _PAGE_NEWPROT on pte_mkold() to get it remapped not-readable
on the host when it is not marked as accessed, to be able to emulate correctly
the accessed bit.

This patch, as said in the comment for the previous one (fixing this for
pte_mkclean()) should be merged only after benchmarking, since the additional
costs for the read faults are very big (a lot bigger than on the host).

Possibly, increasing the timeout for scanning pages and marking them as
accessed could be useful for us.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/asm-um/pgtable.h~uml-fix-tlb-flushing-accessed include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~uml-fix-tlb-flushing-accessed	2005-07-28 20:53:57.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-07-28 20:53:57.000000000 +0200
@@ -268,6 +268,9 @@ static inline pte_t pte_mkclean(pte_t pt
 static inline pte_t pte_mkold(pte_t pte)	
 { 
 	pte_clear_bits(pte, _PAGE_ACCESSED);
+	/* We want that next flush makes this page again not-readable, so we'll
+	 * mark it as accessed again */
+	pte_set_bits(pte, _PAGE_NEWPROT);
 	return(pte);
 }
 
_
