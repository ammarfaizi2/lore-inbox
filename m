Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDAAqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUDAAp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:45:59 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23742
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261439AbUDAAp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:45:29 -0500
Date: Thu, 1 Apr 2004 02:45:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040401004528.GU2143@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331172851.GJ2143@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 07:28:51PM +0200, Andrea Arcangeli wrote:
> if they run into trouble I'll return to the pagecache API adding the
> GFP_KERNEL and check for oom failure.

there were troubles with the header indeed. So I went back to the
pagecache version (now fixed with GFP_KERNEL and oom retval checking).

the oops I've got with the header trouble was weird (but at least the
previous radix_tree_delete crash is gone), so it's not completely clear
if this will be enough to make it work as well as it was working before
the -mm writeback changes. I tried to reproduce but apparently acpi is
doing nothing here for a echo 4 > sleep :/.

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/page_io.c x/mm/page_io.c
--- x-ref/mm/page_io.c	2004-04-01 02:09:53.846664248 +0200
+++ x/mm/page_io.c	2004-04-01 02:11:41.526294456 +0200
@@ -139,7 +139,7 @@ struct address_space_operations swap_aop
 
 /*
  * A scruffy utility function to read or write an arbitrary swap page
- * and wait on the I/O.
+ * and wait on the I/O.  The caller must have a ref on the page.
  */
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
@@ -151,8 +151,11 @@ int rw_swap_page_sync(int rw, swp_entry_
 	lock_page(page);
 
 	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
+	if (unlikely(ret)) {
+		unlock_page(page);
+		return ret;
+	}
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +164,12 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
-	page->mapping = NULL;
+
+	lock_page(page);
+	remove_from_page_cache(page);
+	unlock_page(page);
+	page_cache_release(page);	/* For add_to_page_cache() */
+
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
