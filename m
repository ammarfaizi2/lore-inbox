Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUDABU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDABU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:20:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:7042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261778AbUDABUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:20:11 -0500
Date: Wed, 31 Mar 2004 17:22:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040331172216.4df40fb3.akpm@osdl.org>
In-Reply-To: <20040401004528.GU2143@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random>
	<Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain>
	<20040331172851.GJ2143@dualathlon.random>
	<20040401004528.GU2143@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> @@ -151,8 +151,11 @@ int rw_swap_page_sync(int rw, swp_entry_
>  	lock_page(page);
>  
>  	BUG_ON(page->mapping);
> -	page->mapping = &swapper_space;
> -	page->index = entry.val;
> +	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);

Doing a __GFP_FS allocation while holding lock_page() is worrisome.  It's
OK if that page is private, but how do we know that the caller didn't pass
us some page which is on the LRU?

The only place where I think we can deadlock is if that GFP_KERNEL
allocation tries to write out the page we hold a lock on, and we hit an
error running swap_writepage() and then enter handle_write_error().

This actually cannot happen because swap_writepage() can only fail if
bio_alloc() fails, and that uses a mempool.  But ick.

Your patch seems reasonable to run with for now, but to be totally anal
about it, I'll run with the below monstrosity.



diff -puN mm/page_io.c~rw_swap_page_sync-fix mm/page_io.c
--- 25/mm/page_io.c~rw_swap_page_sync-fix	Wed Mar 31 16:55:44 2004
+++ 25-akpm/mm/page_io.c	Wed Mar 31 17:15:31 2004
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/radix-tree.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -137,9 +138,11 @@ struct address_space_operations swap_aop
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 };
 
+#if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_PM_DISK)
+
 /*
  * A scruffy utility function to read or write an arbitrary swap page
- * and wait on the I/O.
+ * and wait on the I/O.  The caller must have a ref on the page.
  */
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
@@ -148,11 +151,30 @@ int rw_swap_page_sync(int rw, swp_entry_
 		.sync_mode = WB_SYNC_ALL,
 	};
 
-	lock_page(page);
-
 	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+
+	/*
+	 * We shouldn't perform add_to_page_cache(..., GFP_KERNEL) inside
+	 * lock_page(), so here we do bizarre things to arrange for the page
+	 * to be locked while ensuring that this CPU has sufficient pooled
+	 * radix-tree nodes for a successful add_to_page_cache().
+	 */
+	for ( ; ; ) {
+		ret = radix_tree_preload(GFP_KERNEL);
+		if (ret)
+			goto out;
+		if (TestSetPageLocked(page) == 0)
+			break;
+		radix_tree_preload_end();
+		lock_page(page);
+		unlock_page(page);
+	}
+	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_ATOMIC);
+	radix_tree_preload_end();
+	if (ret) {
+		unlock_page(page);
+		goto out;
+	}
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,8 +183,15 @@ int rw_swap_page_sync(int rw, swp_entry_
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
+out:
 	return ret;
 }
+#endif

_

