Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUFBULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUFBULX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUFBULX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:11:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50766 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264022AbUFBULC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:11:02 -0400
Date: Wed, 2 Jun 2004 21:10:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] get_user_pages vs. try_to_unmap
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022109250.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli's fix to an ironic weakness with get_user_pages.
try_to_unmap_one must check page_count against page->mapcount before
unmapping a swapcache page: because the raised pagecount by which
get_user_pages ensures the page cannot be freed, will cause any write
fault to see that page as not exclusively owned, and therefore a copy
page will be substituted for it - the reverse of what's intended.

rmap.c was entirely free of such page_count heuristics before, I tried
hard to avoid putting this in.  But Andrea's fix rarely gives a false
positive; and although it might be nicer to change exclusive_swap_page
etc. to rely on page->mapcount instead, it seems likely that we'll want
to get rid of page->mapcount later, so better not to entrench its use.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/rmap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

--- 2.6.7-rc2/mm/rmap.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/rmap.c	2004-06-02 16:32:06.492313384 +0100
@@ -485,6 +485,23 @@ static int try_to_unmap_one(struct page 
 		goto out_unmap;
 	}
 
+	/*
+	 * Don't pull an anonymous page out from under get_user_pages.
+	 * GUP carefully breaks COW and raises page count (while holding
+	 * page_table_lock, as we have here) to make sure that the page
+	 * cannot be freed.  If we unmap that page here, a user write
+	 * access to the virtual address will bring back the page, but
+	 * its raised count will (ironically) be taken to mean it's not
+	 * an exclusive swap page, do_wp_page will replace it by a copy
+	 * page, and the user never get to see the data GUP was holding
+	 * the original page for.
+	 */
+	if (PageSwapCache(page) &&
+	    page_count(page) != page->mapcount + 2) {
+		ret = SWAP_FAIL;
+		goto out_unmap;
+	}
+
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address);
 	pteval = ptep_clear_flush(vma, address, pte);

