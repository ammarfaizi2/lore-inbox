Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUC2Wk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUC2Wk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:40:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:63953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263192AbUC2Wke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:40:34 -0500
Date: Mon, 29 Mar 2004 14:42:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040329144243.393d21a8.akpm@osdl.org>
In-Reply-To: <20040329223900.GK3808@dualathlon.random>
References: <20040325225919.GL20019@dualathlon.random>
	<Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
	<20040326075343.GB12484@dualathlon.random>
	<Pine.LNX.4.58.0403261013480.672@ruby.engin.umich.edu>
	<20040326175842.GC9604@dualathlon.random>
	<Pine.GSO.4.58.0403271448120.28539@sapphire.engin.umich.edu>
	<20040329172248.GR3808@dualathlon.random>
	<Pine.GSO.4.58.0403291240040.14450@eecs2340u20.engin.umich.edu>
	<20040329180109.GW3808@dualathlon.random>
	<20040329124027.36335d93.akpm@osdl.org>
	<20040329223900.GK3808@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Mon, Mar 29, 2004 at 12:40:27PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > There's now also a screwup in the writeback -mm changes for swapsuspend,
> > > it bugs out in radix tree tag, I believe it's because it doesn't
> > > insert the page in the radix tree before doing writeback I/O on it.
> > 
> > hmm, yes, we have pages which satisfy PageSwapCache(), but which are not
> > actually in swapcache.
> 
> exactly.
> 
> > How about we use the normal pagecache APIs for this?
> 
> should work fine too and it exposes less internal vm details. I will
> propose your fix for testing too.

As Hugh points out, it was missing a page_cache_release().


 25-akpm/mm/page_io.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN mm/page_io.c~rw_swap_page_sync-fix mm/page_io.c
--- 25/mm/page_io.c~rw_swap_page_sync-fix	Mon Mar 29 14:41:08 2004
+++ 25-akpm/mm/page_io.c	Mon Mar 29 14:41:28 2004
@@ -139,7 +139,7 @@ struct address_space_operations swap_aop
 
 /*
  * A scruffy utility function to read or write an arbitrary swap page
- * and wait on the I/O.
+ * and wait on the I/O.  The caller must have a ref on the page.
  */
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
@@ -151,8 +151,7 @@ int rw_swap_page_sync(int rw, swp_entry_
 	lock_page(page);
 
 	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+	add_to_page_cache(page, &swapper_space, entry.val, GFP_NOIO);
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +160,12 @@ int rw_swap_page_sync(int rw, swp_entry_
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

_

