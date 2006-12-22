Return-Path: <linux-kernel-owner+w=401wt.eu-S1945926AbWLVEUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWLVEUj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 23:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945927AbWLVEUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 23:20:39 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:24761 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945926AbWLVEUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 23:20:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/iW9kFn0u6eJLi6/yFQROck1W9B354NA8lMmGcxH3dyqzLxjkqN8znLt7Ry1xWQ+/7X8lAsEEMjStOUkEoYk+MZEPrDVw6v+EkebQqNQJo5wdJtfhePoGNnzGaj9KhxYDezCQD5LBsf6Nor/UWqLKHdXSUeK9pwjmIlsfLL9Ek=
Message-ID: <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
Date: Thu, 21 Dec 2006 21:20:37 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <20061221012721.68f3934b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Andrew Morton <akpm@osdl.org> wrote:

> > Can the call to task_io_account_cancelled_write() simply be removed
> > from cancel_dirty_page() for testing the patch with 2.6.19 (since
> > 2.6.19 doesn't seem to have the task I/O accounting) ?
>
> Yes.

I tested 2.6.19 with a version of Linus's patch that applies cleanly
to 2.6.19 (patch appended to the end of this email) on ARM and apt-get
failed. It did not segfault this time, but instead got stuck for about
20 to 30 minutes and was accessing the hard drive frequently.

Here is some background about the problem we see with apt which may
help somebody with knowledge of the apt source code analyse the
problem in the context of the patch. When apt-get is first run, it
generates pkgcache.bin and srcpkgcache.bin in /var/cache/apt. We have
found that these are the files that get corrupted when we apply the
patch "mm: tracking shared dirty pages" [1] to 2.6.18. The corruption
of these files is what causes apt-get to segfault. I have observed
that the normal operation of apt-get is that while apt-get is
generating these files, pkgcache.bin grows to 12582912 bytes, and when
apt-get finishes, pkgcache.bin is 6425533 bytes and srcpkgcache.bin is
64254483 bytes. This time, when apt-get exited, it had only created
pkgcache.bin which was still 12582912 bytes. Also, the patch caused
apt to slow down a lot. I ran apt-get -f install after apt had exited,
and it took so long that I killed it before it had finished.

I did not try 2.6.20-git, but I presume that this version is what
Martin tried earlier. Maybe Linus's patch doesn't work with 2.6.19,
because 2.6.19 is missing some other patch.

Gordon

[1] http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d08b3851da41d0ee60851f2c75b118e1f7a5fc89

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
+++ linux-2.6.19/mm/memory.c    2006-12-21 01:15:21.000000000 -0700
@@ -1832,6 +1832,33 @@ void unmap_mapping_range(struct address_
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
@@ -1865,6 +1892,7 @@ do_expand:
                goto out_sig;
        if (offset > inode->i_sb->s_maxbytes)
                goto out_big;
+       check_last_page(mapping, inode->i_size);
        i_size_write(inode, offset);

 out_truncate:
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
diff -Naupr linux-2.6.19.orig/mm/truncate.c linux-2.6.19/mm/truncate.c
--- linux-2.6.19.orig/mm/truncate.c     2006-11-29 14:57:37.000000000 -0700
+++ linux-2.6.19/mm/truncate.c  2006-12-21 15:58:18.000000000 -0700
@@ -50,6 +50,17 @@ static inline void truncate_partial_page
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
+}
+
+
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
@@ -69,7 +80,8 @@ truncate_complete_page(struct address_sp
        if (PagePrivate(page))
                do_invalidatepage(page, 0);

-       clear_page_dirty(page);
+       cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
        ClearPageUptodate(page);
        ClearPageMappedToDisk(page);
        remove_from_page_cache(page);
@@ -348,7 +360,6 @@ int invalidate_inode_pages2_range(struct
                for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
                        struct page *page = pvec.pages[i];
                        pgoff_t page_index;
-                       int was_dirty;

                        lock_page(page);
                        if (page->mapping != mapping) {
@@ -384,12 +395,8 @@ int invalidate_inode_pages2_range(struct
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
