Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQJ3UfE>; Mon, 30 Oct 2000 15:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQJ3Uey>; Mon, 30 Oct 2000 15:34:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61111 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129416AbQJ3Ueq>;
	Mon, 30 Oct 2000 15:34:46 -0500
Date: Mon, 30 Oct 2000 15:34:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.LNX.4.10.10010301128380.5551-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0010301505590.1177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Linus Torvalds wrote:

> 
> Ok, this one contains at least a preliminary fix for the problem with
> truncate together with a concurrent page access - the bug that causes
> oopses in block_read_full_page() and filemap_nopage().
> 
> This is a fairly minimal fix, and I'll still have to verify that I caught
> all the relevant places, but I wanted people who have seen this problem to
> please test this out asap - I'll make a real test10 later once I've
> integrated some further patches from Alan and Jeff, but this should fix
> the major show-stopper bug.

Unfortunately, it doesn't fix the thing. ->sync_page() is called when we
do not own the page lock and nfs_sync_page() uses page->mapping. Yes, we
check it before calling the bloody thing, but we don't own the lock.
Problem only for NFS, but I'm not sure what to do about it - the whole
point of ->sync_page() seems to be (if I understood Trond's intentions
right) in forcing the ->readpage() in progress.

Another place you've missed is in read_cache_page(). That one is easy - we've
just locked the page and we should just repeat the whole thing if it's out
of cache.

One more is in filemap_swapout() - dunno, I just shifted the check to
filemap_write_page().

One more: check in do_generic_file_read() for ->mapping->i_shared_mmap.
Fix: trivial.

The last one is in deactivate_page_nolock() - there we check the ->mapping
without pagecache_lock and without page lock. Hell knows whether it's a
bug or not. Rik?

Minimal patch (against -pre7) follows. It still leaves sync_page() problem
open - any suggestions on that one are very welcome. Other than that and
deactivate_page_nolock() we should be safe wrt. ->mapping. Please, apply -
after that we will be in sync. nfs_sync_page() is still a problem and if
somebody (Trond?) might tell WTF it is supposed to be...
							Cheers,
								Al

--- filemap.c	Mon Oct 30 18:46:17 2000
+++ filemap.c.new	Mon Oct 30 18:54:05 2000
@@ -981,7 +981,7 @@
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
 		 */
-		if (page->mapping->i_mmap_shared != NULL)
+		if (mapping->i_mmap_shared != NULL)
 			flush_dcache_page(page);
 
 		/*
@@ -1473,7 +1473,8 @@
 	 * vma/file is guaranteed to exist in the unmap/sync cases because
 	 * mmap_sem is held.
 	 */
-	return page->mapping->a_ops->writepage(file, page);
+	/* Nothing to do if somebody truncated the page from under us.. */
+	return page->mapping?page->mapping->a_ops->writepage(file, page):0;
 }
 
 
@@ -1544,9 +1545,7 @@
 	lock_page(page);
 
 	error = 0;
-	/* Nothing to do if somebody truncated the page from under us.. */
-	if (page->mapping)
-		error = filemap_write_page(vma->vm_file, page, 1);
+	error = filemap_write_page(vma->vm_file, page, 1);
 
 	UnlockPage(page);
 	page_cache_free(page);
@@ -2313,13 +2312,20 @@
 				int (*filler)(void *,struct page*),
 				void *data)
 {
-	struct page *page = __read_cache_page(mapping, index, filler, data);
+	struct page *page;
+retry:
+	page = __read_cache_page(mapping, index, filler, data);
 	int err;
 
 	if (IS_ERR(page) || Page_Uptodate(page))
 		goto out;
 
 	lock_page(page);
+	if (!page->mapping) {
+		UnlockPage(page);
+		page_cache_release(page);
+		goto retry;
+	}
 	if (Page_Uptodate(page)) {
 		UnlockPage(page);
 		goto out;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
