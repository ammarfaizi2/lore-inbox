Return-Path: <linux-kernel-owner+w=401wt.eu-S1752486AbWLXT17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWLXT17 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 14:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLXT17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 14:27:59 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:22021 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbWLXT16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 14:27:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFe9LBRNpg5iK1uKFHQVNBIxV23QJH2zVcOhh6a0VB4NhiCrJ5JSVqOCC8FDmuouUd5IoxS7lS+yOCBCGuSwE6rYyEM0UHwCjs49/272gTQkM9N+mqOAyqNNnATYVG9oW7g4lgCDP8KDdtNJ9WeMtPKHwo6KWMY0tG1zVhOaR1s=
Message-ID: <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com>
Date: Sun, 24 Dec 2006 12:27:57 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Andrei Popa" <andrei.popa@i-neo.ro>, "Andrew Morton" <akpm@osdl.org>,
       "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <1166793952.32117.29.camel@twins>
	 <20061222192027.GJ4229@deprecation.cyrius.com>
	 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <20061224005752.937493c8.akpm@osdl.org>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/06, Linus Torvalds <torvalds@osdl.org> wrote:

> How about this particularly stupid diff? (please test with something that
> _would_ cause corruption normally).
>
> It is _entirely_ untested, but what it tries to do is to simply serialize
> any writeback in progress with any process that tries to re-map a shared
> page into its address space and dirty it. I haven't tested it, and maybe
> it misses some case, but it looks likea good way to try to avoid races
> with marking pages dirty and the writeback phase ..

The apt cache files (/var/cache/apt/*.bin) still get corrupted with
this patch and 2.6.19.

Gordon

diff -Naupr linux-2.6.19.orig/fs/buffer.c linux-2.6.19/fs/buffer.c
--- linux-2.6.19.orig/fs/buffer.c       2006-11-29 14:57:37.000000000 -0700
+++ linux-2.6.19/fs/buffer.c    2006-12-21 01:16:31.000000000 -0700
@@ -2832,7 +2832,7 @@ int try_to_free_buffers(struct page *pag
        int ret = 0;

        BUG_ON(!PageLocked(page));
-       if (PageWriteback(page))
+       if (PageDirty(page) || PageWriteback(page))
                return 0;

        if (mapping == NULL) {          /* can this still happen? */
@@ -2843,17 +2843,6 @@ int try_to_free_buffers(struct page *pag
        spin_lock(&mapping->private_lock);
        ret = drop_buffers(page, &buffers_to_free);
        spin_unlock(&mapping->private_lock);
-       if (ret) {
-               /*
-                * If the filesystem writes its buffers by hand (eg ext3)
-                * then we can have clean buffers against a dirty page.  We
-                * clean the page here; otherwise later reattachment of buffers
-                * could encounter a non-uptodate page, which is unresolvable.
-                * This only applies in the rare case where try_to_free_buffers
-                * succeeds but the page is not freed.
-                */
-               clear_page_dirty(page);
-       }
 out:
        if (buffers_to_free) {
                struct buffer_head *bh = buffers_to_free;
diff -Naupr linux-2.6.19.orig/fs/hugetlbfs/inode.c
linux-2.6.19/fs/hugetlbfs/inode.c
--- linux-2.6.19.orig/fs/hugetlbfs/inode.c      2006-11-29
14:57:37.000000000 -0700
+++ linux-2.6.19/fs/hugetlbfs/inode.c   2006-12-21 01:15:21.000000000 -0700
@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct

 static void truncate_huge_page(struct page *page)
 {
-       clear_page_dirty(page);
+       cancel_dirty_page(page, /* No IO accounting for huge pages? */0);
        ClearPageUptodate(page);
        remove_from_page_cache(page);
        put_page(page);
diff -Naupr linux-2.6.19.orig/include/linux/page-flags.h
linux-2.6.19/include/linux/page-flags.h
--- linux-2.6.19.orig/include/linux/page-flags.h        2006-11-29
14:57:37.000000000 -0700
+++ linux-2.6.19/include/linux/page-flags.h     2006-12-21
01:15:21.000000000 -0700
@@ -253,15 +253,11 @@ static inline void SetPageUptodate(struc

 struct page;   /* forward declaration */

-int test_clear_page_dirty(struct page *page);
+extern void cancel_dirty_page(struct page *page, unsigned int account_size);
+
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);

-static inline void clear_page_dirty(struct page *page)
-{
-       test_clear_page_dirty(page);
-}
-
 static inline void set_page_writeback(struct page *page)
 {
        test_set_page_writeback(page);
diff -Naupr linux-2.6.19.orig/mm/memory.c linux-2.6.19/mm/memory.c
--- linux-2.6.19.orig/mm/memory.c       2006-11-29 14:57:37.000000000 -0700
+++ linux-2.6.19/mm/memory.c    2006-12-24 11:04:03.000000000 -0700
@@ -1534,6 +1534,7 @@ static int do_wp_page(struct mm_struct *
                        if (!pte_same(*page_table, orig_pte))
                                goto unlock;
                }
+               wait_on_page_writeback(old_page);
                dirty_page = old_page;
                get_page(dirty_page);
                reuse = 1;
@@ -1832,6 +1833,33 @@ void unmap_mapping_range(struct address_
 }
 EXPORT_SYMBOL(unmap_mapping_range);

+static void check_last_page(struct address_space *mapping, loff_t size)
+{
+       pgoff_t index;
+       unsigned int offset;
+       struct page *page;
+
+       if (!mapping)
+               return;
+       offset = size & ~PAGE_MASK;
+       if (!offset)
+               return;
+       index = size >> PAGE_SHIFT;
+       page = find_lock_page(mapping, index);
+       if (page) {
+               unsigned int check = 0;
+               unsigned char *kaddr = kmap_atomic(page, KM_USER0);
+               do {
+                       check += kaddr[offset++];
+               } while (offset < PAGE_SIZE);
+               kunmap_atomic(kaddr,KM_USER0);
+               unlock_page(page);
+               page_cache_release(page);
+               if (check)
+                       printk("%s: BADNESS: truncate check %u\n",
current->comm, check);
+       }
+}
+
 /**
  * vmtruncate - unmap mappings "freed" by truncate() syscall
  * @inode: inode of the file used
@@ -1865,6 +1893,7 @@ do_expand:
                goto out_sig;
        if (offset > inode->i_sb->s_maxbytes)
                goto out_big;
+       check_last_page(mapping, inode->i_size);
        i_size_write(inode, offset);

 out_truncate:
@@ -2206,6 +2235,7 @@ retry:
                                page_cache_release(new_page);
                                return VM_FAULT_SIGBUS;
                        }
+                       wait_on_page_writeback(new_page);
                }
        }

diff -Naupr linux-2.6.19.orig/mm/page-writeback.c
linux-2.6.19/mm/page-writeback.c
--- linux-2.6.19.orig/mm/page-writeback.c       2006-11-29
14:57:37.000000000 -0700
+++ linux-2.6.19/mm/page-writeback.c    2006-12-21 01:26:53.000000000 -0700
@@ -843,39 +843,6 @@ int set_page_dirty_lock(struct page *pag
 EXPORT_SYMBOL(set_page_dirty_lock);

 /*
- * Clear a page's dirty flag, while caring for dirty memory accounting.
- * Returns true if the page was previously dirty.
- */
-int test_clear_page_dirty(struct page *page)
-{
-       struct address_space *mapping = page_mapping(page);
-       unsigned long flags;
-
-       if (mapping) {
-               write_lock_irqsave(&mapping->tree_lock, flags);
-               if (TestClearPageDirty(page)) {
-                       radix_tree_tag_clear(&mapping->page_tree,
-                                               page_index(page),
-                                               PAGECACHE_TAG_DIRTY);
-                       write_unlock_irqrestore(&mapping->tree_lock, flags);
-                       /*
-                        * We can continue to use `mapping' here because the
-                        * page is locked, which pins the address_space
-                        */
-                       if (mapping_cap_account_dirty(mapping)) {
-                               page_mkclean(page);
-                               dec_zone_page_state(page, NR_FILE_DIRTY);
-                       }
-                       return 1;
-               }
-               write_unlock_irqrestore(&mapping->tree_lock, flags);
-               return 0;
-       }
-       return TestClearPageDirty(page);
-}
-EXPORT_SYMBOL(test_clear_page_dirty);
-
-/*
  * Clear a page's dirty flag, while caring for dirty memory accounting.
  * Returns true if the page was previously dirty.
  *
diff -Naupr linux-2.6.19.orig/mm/rmap.c linux-2.6.19/mm/rmap.c
--- linux-2.6.19.orig/mm/rmap.c 2006-11-29 14:57:37.000000000 -0700
+++ linux-2.6.19/mm/rmap.c      2006-12-22 23:25:09.000000000 -0700
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page
 {
        struct mm_struct *mm = vma->vm_mm;
        unsigned long address;
-       pte_t *pte, entry;
+       pte_t *pte;
        spinlock_t *ptl;
        int ret = 0;

@@ -444,17 +444,18 @@ static int page_mkclean_one(struct page
        if (!pte)
                goto out;

-       if (!pte_dirty(*pte) && !pte_write(*pte))
-               goto unlock;
+       if (pte_dirty(*pte) || pte_write(*pte)) {
+               pte_t entry;

-       entry = ptep_get_and_clear(mm, address, pte);
-       entry = pte_mkclean(entry);
-       entry = pte_wrprotect(entry);
-       ptep_establish(vma, address, pte, entry);
-       lazy_mmu_prot_update(entry);
-       ret = 1;
+               flush_cache_page(vma, address, pte_pfn(*pte));
+               entry = ptep_clear_flush(vma, address, pte);
+               entry = pte_wrprotect(entry);
+               entry = pte_mkclean(entry);
+               set_pte_at(vma, address, pte, entry);
+               lazy_mmu_prot_update(entry);
+               ret = 1;
+       }

-unlock:
        pte_unmap_unlock(pte, ptl);
 out:
        return ret;
@@ -489,6 +490,8 @@ int page_mkclean(struct page *page)
                if (mapping)
                        ret = page_mkclean_file(mapping, page);
        }
+       if (page_test_and_clear_dirty(page))
+               ret = 1;

        return ret;
 }
@@ -587,8 +590,6 @@ void page_remove_rmap(struct page *page)
                 * Leaving it set also helps swapoff to reinstate ptes
                 * faster for those pages still in swapcache.
                 */
-               if (page_test_and_clear_dirty(page))
-                       set_page_dirty(page);
                __dec_zone_page_state(page,
                                PageAnon(page) ? NR_ANON_PAGES :
NR_FILE_MAPPED);
        }
@@ -607,6 +608,7 @@ static int try_to_unmap_one(struct page
        pte_t pteval;
        spinlock_t *ptl;
        int ret = SWAP_AGAIN;
+       struct page *dirty_page = NULL;

        address = vma_address(page, vma);
        if (address == -EFAULT)
@@ -633,7 +635,7 @@ static int try_to_unmap_one(struct page

        /* Move the dirty bit to the physical page now the pte is gone. */
        if (pte_dirty(pteval))
-               set_page_dirty(page);
+               dirty_page = page;

        /* Update high watermark before we lower rss */
        update_hiwater_rss(mm);
@@ -684,6 +686,8 @@ static int try_to_unmap_one(struct page

 out_unmap:
        pte_unmap_unlock(pte, ptl);
+       if (dirty_page)
+               set_page_dirty(dirty_page);
 out:
        return ret;
 }
@@ -915,6 +919,9 @@ int try_to_unmap(struct page *page, int
        else
                ret = try_to_unmap_file(page, migration);

+       if (page_test_and_clear_dirty(page))
+               set_page_dirty(page);
+
        if (!page_mapped(page))
                ret = SWAP_SUCCESS;
        return ret;
diff -Naupr linux-2.6.19.orig/mm/truncate.c linux-2.6.19/mm/truncate.c
--- linux-2.6.19.orig/mm/truncate.c     2006-11-29 14:57:37.000000000 -0700
+++ linux-2.6.19/mm/truncate.c  2006-12-23 13:21:42.000000000 -0700
@@ -50,6 +50,21 @@ static inline void truncate_partial_page
                do_invalidatepage(page, partial);
 }

+void cancel_dirty_page(struct page *page, unsigned int account_size)
+{
+       /* If we're cancelling the page, it had better not be mapped
any more */+       if (page_mapped(page)) {
+               static unsigned int warncount;
+
+               WARN_ON(++warncount < 5);
+       }
+
+       if (TestClearPageDirty(page) && account_size &&
+                       mapping_cap_account_dirty(page->mapping))
+               dec_zone_page_state(page, NR_FILE_DIRTY);
+}
+
+
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
@@ -66,10 +81,11 @@ truncate_complete_page(struct address_sp
        if (page->mapping != mapping)
                return;

+       cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
        if (PagePrivate(page))
                do_invalidatepage(page, 0);

-       clear_page_dirty(page);
        ClearPageUptodate(page);
        ClearPageMappedToDisk(page);
        remove_from_page_cache(page);
@@ -348,7 +364,6 @@ int invalidate_inode_pages2_range(struct
                for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
                        struct page *page = pvec.pages[i];
                        pgoff_t page_index;
-                       int was_dirty;

                        lock_page(page);
                        if (page->mapping != mapping) {
@@ -384,12 +399,8 @@ int invalidate_inode_pages2_range(struct
                                          PAGE_CACHE_SIZE, 0);
                                }
                        }
-                       was_dirty = test_clear_page_dirty(page);
-                       if (!invalidate_complete_page2(mapping, page)) {
-                               if (was_dirty)
-                                       set_page_dirty(page);
+                       if (!invalidate_complete_page2(mapping, page))
                                ret = -EIO;
-                       }
                        unlock_page(page);
                }
                pagevec_release(&pvec);


-- 
Gordon Farquharson
