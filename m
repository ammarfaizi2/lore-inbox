Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSCZJ62>; Tue, 26 Mar 2002 04:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSCZJ6K>; Tue, 26 Mar 2002 04:58:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35847 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293386AbSCZJ6G>;
	Tue, 26 Mar 2002 04:58:06 -0500
Message-ID: <3CA045BC.AA75D788@zip.com.au>
Date: Tue, 26 Mar 2002 01:56:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, velco@fadata.bg
Subject: Re: [PATCH] updated radix-tree pagecache
In-Reply-To: <20020324123414.A12686@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> I've just uploaded a new version of the radix-tree pagecache patch
> to kernel.org.  This version should fix the OOPSens in the last
> version by beeing more carefull with the page->flags handling.
> 
> I have tested the 2.4 version under varying loads for about 20 hours
> now and it seems stabel, the 2.5 version just got a compiles & boots,
> I don't really trust 2.5 in this stage..
> 



I've been through this with a toothcomb.

It is worrisome that the radix tree code is in several places doing:

	while (stuff which calls radix_tree_reserve()) {
		yield();
	}

because radix_tree_reserve() is performing atomic allocations.  These
can *completely* exhaust memory reserves.  So unless we actually have
write I/O underway, the machine will lock up because there's no way
we'll be able to start new I/O when there is no memory available at
all.

So all the yield loops were removed in favour of propagating errors
back.  Except for the one in shmem_unuse_inode().  That's only used in
the swapoff path, but really should be fixed (swapoff can cause tons of
memory pressure!).

There is a test patch which deliberately forces page allocation
failures and radix tree node failures at

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.7/

The code oopsed prettily easily because of the find_or_create_page()
problem.  With the below patch the code was given a fearsome beating on
a small-memory quad x86.  No problems.

tmpfs was tested only a tiny bit - pushing tmpfs hard livelocks the
machine in seconds.  This doesn't happen in 2.4 kernels.  It's a 2.5
bug independent of the radix-tree code.

All testing and development was on 2.5.7.  This stuff needs feeding
back into the 2.4 patch...


Details:

page_cache_read():

    We don't need to loop on memory allocation here: we can just
    drop the page and return an error.

    Change the logic in calculating the return value.  I think it
    makes more sense to only obscure the error value if it was EEXIST
    (an addition race).

find_or_create_page():

    Fix fatal bug: we need to handle the situation where adding the
    page to the radix tree failed.

__add_to_page_cache():

    Uninline it.  It's fairly large, and is not a leaf function. 
    Saves eight cachelines!

add_to_page_cache_unique():

    Random coding style consistency changes.

    Added some commentary.

add_to_swap_cache():

    If add_to_page_cache_unique() returns non-zero, we do
    INC_CACHE_INFO(exist_race).  Not correct - should only do this if
    (error == -EEXIST).

read_swap_cache_async():

    Don't go into an infinite loop if we're getting ENOMEM on the
    radix-tree node.  That loop is there purely to handle the EEXIST
    race.

swap_out():

    Commentary.

shmem_getpage_locked():

    Several random coding style consistency fixes.

    Don't loop on radix-tree node exhaustion.  We can just unwind
    and return an error code (two places).


Aside: This is not related to ratcache: shmem_getpage_locked() is
setting PG_dirty but not adding the page to mapping->dirty_pages.  Is
this intended?



=====================================

--- 2.5.7/mm/filemap.c~dallocbase-15-ratcache-fixes	Tue Mar 26 01:52:14 2002
+++ 2.5.7-akpm/mm/filemap.c	Tue Mar 26 01:52:14 2002
@@ -578,7 +578,7 @@ int filemap_fdatawait(struct address_spa
  * This adds a page to the page cache, starting out as locked,
  * owned by us, but unreferenced, not uptodate and with no errors.
  */
-static inline int __add_to_page_cache(struct page *page,
+static int __add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long offset)
 {
 	unsigned long flags;
@@ -646,25 +646,20 @@ static int page_cache_read(struct file *
 	if (!page)
 		return -ENOMEM;
 
-	error = add_to_page_cache_unique (page, mapping, offset);
-	while (error == -ENOMEM) {
-		/* Yield for kswapd, and try again */
-		yield();
-		error = add_to_page_cache_unique (page, mapping, offset);
-	}
-
+	error = add_to_page_cache_unique(page, mapping, offset);
 	if (!error) {
 		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 		return error;
 	}
+
 	/*
 	 * We arrive here in the unlikely event that someone 
 	 * raced with us and added our page to the cache first
-	 * or we are out of memory.  
+	 * or we are out of memory for radix-tree nodes.
 	 */
 	page_cache_release(page);
-	return error == -ENOMEM ? -ENOMEM : 0;
+	return error == -EEXIST ? 0 : error;
 }
 
 /*
@@ -908,7 +903,12 @@ struct page * find_or_create_page(struct
 			page = __find_lock_page(mapping, index);
 			if (likely(!page)) {
 				page = newpage;
-				__add_to_page_cache(page, mapping, index);
+				if (__add_to_page_cache(page, mapping, index)) {
+					spin_unlock(&mapping->page_lock);
+					page_cache_release(page);
+					page = NULL;
+					goto out;
+				}
 				newpage = NULL;
 			}
 			spin_unlock(&mapping->page_lock);
@@ -918,7 +918,8 @@ struct page * find_or_create_page(struct
 				page_cache_release(newpage);
 		}
 	}
-	return page;	
+out:
+	return page;
 }
 
 /*
@@ -962,11 +963,14 @@ struct page *grab_cache_page_nowait(stru
 	}
 
 	page = page_cache_alloc(mapping);
-	if ( unlikely(!page) )
+	if (unlikely(!page))
 		return NULL;	/* Failed to allocate a page */
 
-	if ( unlikely(add_to_page_cache_unique(page, mapping, index)) ) {
-		/* Someone else grabbed the page already. */
+	if (unlikely(add_to_page_cache_unique(page, mapping, index))) {
+		/*
+		 * Someone else grabbed the page already, or
+		 * failed to allocate a radix-tree node
+		 */
 		page_cache_release(page);
 		return NULL;
 	}
@@ -2392,10 +2396,11 @@ repeat:
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
-		err = add_to_page_cache_unique (cached_page, mapping, index);
+		err = add_to_page_cache_unique(cached_page, mapping, index);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err < 0) {
+			/* Presumably ENOMEM for radix tree node */
 			page_cache_release(cached_page);
 			return ERR_PTR(err);
 		}
@@ -2464,7 +2469,7 @@ repeat:
 			if (!*cached_page)
 				return NULL;
 		}
-		err = add_to_page_cache_unique (*cached_page, mapping, index);
+		err = add_to_page_cache_unique(*cached_page, mapping, index);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err == 0) {
--- 2.5.7/mm/swap_state.c~dallocbase-15-ratcache-fixes	Tue Mar 26 01:52:14 2002
+++ 2.5.7-akpm/mm/swap_state.c	Tue Mar 26 01:52:14 2002
@@ -83,7 +83,8 @@ int add_to_swap_cache(struct page *page,
 	error = add_to_page_cache_unique(page, &swapper_space, entry.val);
 	if (error != 0) {
 		swap_free(entry);
-		INC_CACHE_INFO(exist_race);
+		if (error == -EEXIST)
+			INC_CACHE_INFO(exist_race);
 		return error;
 	}
 	if (!PageLocked(page))
@@ -300,6 +301,7 @@ struct page * read_swap_cache_async(swp_
 		 * swap cache: added by a racing read_swap_cache_async,
 		 * or by try_to_swap_out (or shmem_writepage) re-using
 		 * the just freed swap entry for an existing page.
+		 * May fail (-ENOMEM) if radix-tree node allocation failed.
 		 */
 		err = add_to_swap_cache(new_page, entry);
 		if (!err) {
@@ -309,7 +311,7 @@ struct page * read_swap_cache_async(swp_
 			rw_swap_page(READ, new_page);
 			return new_page;
 		}
-	} while (err != -ENOENT);
+	} while (err != -ENOENT && err != -ENOMEM);
 
 	if (new_page)
 		page_cache_release(new_page);
--- 2.5.7/mm/vmscan.c~dallocbase-15-ratcache-fixes	Tue Mar 26 01:52:14 2002
+++ 2.5.7-akpm/mm/vmscan.c	Tue Mar 26 01:52:14 2002
@@ -138,14 +138,14 @@ drop_pte:
 		 * and uptodate bits, so we need to do it again)
 		 */
 		switch (add_to_swap_cache(page, entry)) {
-		case 0:
+		case 0:				/* Success */
 			SetPageUptodate(page);
 			set_page_dirty(page);
 			goto set_swap_pte;
-		case -ENOMEM:
-			swap_free (entry);
+		case -ENOMEM:			/* radix-tree allocation */
+			swap_free(entry);
 			goto preserve;
-		default:
+		default:			/* ENOENT: raced */
 			break;
 		}
 		/* Raced with "speculative" read_swap_cache_async */
--- 2.5.7/mm/shmem.c~dallocbase-15-ratcache-fixes	Tue Mar 26 01:52:14 2002
+++ 2.5.7-akpm/mm/shmem.c	Tue Mar 26 01:52:14 2002
@@ -488,10 +488,11 @@ static int shmem_writepage(struct page *
  */
 static struct page * shmem_getpage_locked(struct shmem_inode_info *info, struct inode * inode, unsigned long idx)
 {
-	struct address_space * mapping = inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
 	struct shmem_sb_info *sbinfo;
-	struct page * page;
+	struct page *page;
 	swp_entry_t *entry;
+	int error;
 
 repeat:
 	page = find_lock_page(mapping, idx);
@@ -547,8 +548,11 @@ repeat:
 		if (TryLockPage(page)) 
 			goto wait_retry;
 
-		if (move_from_swap_cache (page, idx, mapping))
-			goto nomem_retry;
+		error = move_from_swap_cache(page, idx, mapping);
+		if (error < 0) {
+			UnlockPage(page);
+			return ERR_PTR(error);
+		}
 
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
@@ -573,9 +577,10 @@ repeat:
 		page = page_cache_alloc(mapping);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
-		while (add_to_page_cache (page, mapping, idx) < 0) {
-			/* Yield for kswapd, and try again */
-			yield();
+		error = add_to_page_cache(page, mapping, idx);
+		if (error < 0) {
+			page_cache_release(page);
+			return ERR_PTR(-ENOMEM);
 		}
 		clear_highpage(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
@@ -593,15 +598,6 @@ wait_retry:
 	wait_on_page(page);
 	page_cache_release(page);
 	goto repeat;
-
-nomem_retry:
-	spin_unlock (&info->lock);
-	UnlockPage (page);
-	page_cache_release (page);
-
-	/* Yield for kswapd, and try again */
-	yield();
-	goto repeat;
 }
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)

-
