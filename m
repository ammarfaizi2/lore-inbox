Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270980AbUJUVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbUJUVYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270971AbUJUVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:22:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:45458 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S270969AbUJUVPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:15:48 -0400
Subject: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain
Message-Id: <1098393346.7157.112.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 16:15:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_pte_range should not mark non-uptodate pages dirty

Doing O_DIRECT writes to an mmapped file caused pages in the page cache to
be marked dirty but not uptodate.  This led to a bug in mpage_writepage.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Signed-off-by: Andrea Arcangeli <andrea@novell.com>

diff -urp linux-2.6.9/mm/memory.c linux/mm/memory.c
--- linux-2.6.9/mm/memory.c	2004-10-21 10:49:26.598031488 -0500
+++ linux/mm/memory.c	2004-10-21 16:01:44.902376232 -0500
@@ -414,7 +414,15 @@ static void zap_pte_range(struct mmu_gat
 			    && linear_page_index(details->nonlinear_vma,
 					address+offset) != page->index)
 				set_pte(ptep, pgoff_to_pte(page->index));
-			if (pte_dirty(pte))
+			/*
+			 * PG_uptodate can be cleared by
+			 * invalidate_inode_pages2, so we must not try to write
+			 * not uptodate pages.  Otherwise we risk invalidating
+			 * underlying O_DIRECT writes, and secondly because
+			 * pdflush would BUG().  Coherency of mmaps against
+			 * O_DIRECT still cannot be guaranteed though.
+			 */
+			if (pte_dirty(pte) && PageUptodate(page))
 				set_page_dirty(page);
 			if (pte_young(pte) && !PageAnon(page))
 				mark_page_accessed(page);


