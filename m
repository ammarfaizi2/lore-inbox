Return-Path: <linux-kernel-owner+w=401wt.eu-S1422954AbWLUOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbWLUOHA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbWLUOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:07:00 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:34893 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422891AbWLUOG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:06:59 -0500
X-Greylist: delayed 2331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 09:06:58 EST
Message-ID: <458A8BC9.1040801@fatbob.nu>
Date: Thu, 21 Dec 2006 14:27:37 +0100
From: Martin Johansson <martin@fatbob.nu>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mm: fix page_mkclean_one (was: 2.6.19 file content corruption
 on ext3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > On Wed, 20 Dec 2006, Linus Torvalds wrote:
 > Martin, Andrei, does this make any difference for your corruption cases?

Hi!
I've been watching this issue since I'm experiencing rtorrent corruption 
since 2.6.19.

Details: i386, UP, no preempt:
kungen:/proc# zgrep PREEMPT config.gz
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
kungen:/proc# uname -a
Linux kungen.fatbob.nu 2.6.19.1 #3 Thu Dec 21 13:18:06 CET 2006 i686 
GNU/Linux

Corruption is still present with the patch below (patched against 
2.6.19.1 and removed task_io_account_cancelled_write call)

/Martin

[Not subscribed to the list]

 > ---
 > diff --git a/fs/buffer.c b/fs/buffer.c
 > index d1f1b54..263f88e 100644
 > --- a/fs/buffer.c
 > +++ b/fs/buffer.c
 > @@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
 >      int ret = 0;
 >  
 >      BUG_ON(!PageLocked(page));
 > -    if (PageWriteback(page))
 > +    if (PageDirty(page) || PageWriteback(page))
 >          return 0;
 >  
 >      if (mapping == NULL) {        /* can this still happen? */
 > @@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
 >      spin_lock(&mapping->private_lock);
 >      ret = drop_buffers(page, &buffers_to_free);
 >      spin_unlock(&mapping->private_lock);
 > -    if (ret) {
 > -        /*
 > -         * If the filesystem writes its buffers by hand (eg ext3)
 > -         * then we can have clean buffers against a dirty page.  We
 > -         * clean the page here; otherwise later reattachment of buffers
 > -         * could encounter a non-uptodate page, which is unresolvable.
 > -         * This only applies in the rare case where try_to_free_buffers
 > -         * succeeds but the page is not freed.
 > -         *
 > -         * Also, during truncate, discard_buffer will have marked all
 > -         * the page's buffers clean.  We discover that here and clean
 > -         * the page also.
 > -         */
 > -        if (test_clear_page_dirty(page))
 > -            task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 > -    }
 >  out:
 >      if (buffers_to_free) {
 >          struct buffer_head *bh = buffers_to_free;
 > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
 > index ed2c223..4f4cd13 100644
 > --- a/fs/hugetlbfs/inode.c
 > +++ b/fs/hugetlbfs/inode.c
 > @@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct file *file,
 >  
 >  static void truncate_huge_page(struct page *page)
 >  {
 > -    clear_page_dirty(page);
 > +    cancel_dirty_page(page, /* No IO accounting for huge pages? */0);
 >      ClearPageUptodate(page);
 >      remove_from_page_cache(page);
 >      put_page(page);
 > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
 > index 4830a3b..350878a 100644
 > --- a/include/linux/page-flags.h
 > +++ b/include/linux/page-flags.h
 > @@ -253,15 +253,11 @@ static inline void SetPageUptodate(struct page 
*page)
 >  
 >  struct page;    /* forward declaration */
 >  
 > -int test_clear_page_dirty(struct page *page);
 > +extern void cancel_dirty_page(struct page *page, unsigned int 
account_size);
 > +
 >  int test_clear_page_writeback(struct page *page);
 >  int test_set_page_writeback(struct page *page);
 >  
 > -static inline void clear_page_dirty(struct page *page)
 > -{
 > -    test_clear_page_dirty(page);
 > -}
 > -
 >  static inline void set_page_writeback(struct page *page)
 >  {
 >      test_set_page_writeback(page);
 > diff --git a/mm/memory.c b/mm/memory.c
 > index c00bac6..79cecab 100644
 > --- a/mm/memory.c
 > +++ b/mm/memory.c
 > @@ -1842,6 +1842,33 @@ void unmap_mapping_range(struct address_space 
*mapping,
 >  }
 >  EXPORT_SYMBOL(unmap_mapping_range);
 >  
 > +static void check_last_page(struct address_space *mapping, loff_t size)
 > +{
 > +    pgoff_t index;
 > +    unsigned int offset;
 > +    struct page *page;
 > +
 > +    if (!mapping)
 > +        return;
 > +    offset = size & ~PAGE_MASK;
 > +    if (!offset)
 > +        return;
 > +    index = size >> PAGE_SHIFT;
 > +    page = find_lock_page(mapping, index);
 > +    if (page) {
 > +        unsigned int check = 0;
 > +        unsigned char *kaddr = kmap_atomic(page, KM_USER0);
 > +        do {
 > +            check += kaddr[offset++];
 > +        } while (offset < PAGE_SIZE);
 > +        kunmap_atomic(kaddr,KM_USER0);
 > +        unlock_page(page);
 > +        page_cache_release(page);
 > +        if (check)
 > +            printk("%s: BADNESS: truncate check %u\n", 
current->comm, check);
 > +    }
 > +}
 > +
 >  /**
 >   * vmtruncate - unmap mappings "freed" by truncate() syscall
 >   * @inode: inode of the file used
 > @@ -1875,6 +1902,7 @@ do_expand:
 >          goto out_sig;
 >      if (offset > inode->i_sb->s_maxbytes)
 >          goto out_big;
 > +    check_last_page(mapping, inode->i_size);
 >      i_size_write(inode, offset);
 >  
 >  out_truncate:
 > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
 > index 237107c..b3a198c 100644
 > --- a/mm/page-writeback.c
 > +++ b/mm/page-writeback.c
 > @@ -845,38 +845,6 @@ int set_page_dirty_lock(struct page *page)
 >  EXPORT_SYMBOL(set_page_dirty_lock);
 >  
 >  /*
 > - * Clear a page's dirty flag, while caring for dirty memory accounting.
 > - * Returns true if the page was previously dirty.
 > - */
 > -int test_clear_page_dirty(struct page *page)
 > -{
 > -    struct address_space *mapping = page_mapping(page);
 > -    unsigned long flags;
 > -
 > -    if (!mapping)
 > -        return TestClearPageDirty(page);
 > -
 > -    write_lock_irqsave(&mapping->tree_lock, flags);
 > -    if (TestClearPageDirty(page)) {
 > -        radix_tree_tag_clear(&mapping->page_tree,
 > -                page_index(page), PAGECACHE_TAG_DIRTY);
 > -        write_unlock_irqrestore(&mapping->tree_lock, flags);
 > -        /*
 > -         * We can continue to use `mapping' here because the
 > -         * page is locked, which pins the address_space
 > -         */
 > -        if (mapping_cap_account_dirty(mapping)) {
 > -            page_mkclean(page);
 > -            dec_zone_page_state(page, NR_FILE_DIRTY);
 > -        }
 > -        return 1;
 > -    }
 > -    write_unlock_irqrestore(&mapping->tree_lock, flags);
 > -    return 0;
 > -}
 > -EXPORT_SYMBOL(test_clear_page_dirty);
 > -
 > -/*
 >   * Clear a page's dirty flag, while caring for dirty memory accounting.
 >   * Returns true if the page was previously dirty.
 >   *
 > diff --git a/mm/truncate.c b/mm/truncate.c
 > index 9bfb8e8..bf9e296 100644
 > --- a/mm/truncate.c
 > +++ b/mm/truncate.c
 > @@ -51,6 +51,20 @@ static inline void truncate_partial_page(struct 
page *page, unsigned partial)
 >          do_invalidatepage(page, partial);
 >  }
 >  
 > +void cancel_dirty_page(struct page *page, unsigned int account_size)
 > +{
 > +    /* If we're cancelling the page, it had better not be mapped any 
more */
 > +    if (page_mapped(page)) {
 > +        static unsigned int warncount;
 > +
 > +        WARN_ON(++warncount < 5);
 > +    }
 > +        
 > +    if (TestClearPageDirty(page) && account_size)
 > +        task_io_account_cancelled_write(account_size);
 > +}
 > +
 > +
 >  /*
 >   * If truncate cannot remove the fs-private metadata from the page, 
the page
 >   * becomes anonymous.  It will be left on the LRU and may even be 
mapped into
 > @@ -70,8 +84,8 @@ truncate_complete_page(struct address_space 
*mapping, struct page *page)
 >      if (PagePrivate(page))
 >          do_invalidatepage(page, 0);
 >  
 > -    if (test_clear_page_dirty(page))
 > -        task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 > +    cancel_dirty_page(page, PAGE_CACHE_SIZE);
 > +
 >      ClearPageUptodate(page);
 >      ClearPageMappedToDisk(page);
 >      remove_from_page_cache(page);
 > @@ -350,7 +364,6 @@ int invalidate_inode_pages2_range(struct 
address_space *mapping,
 >          for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 >              struct page *page = pvec.pages[i];
 >              pgoff_t page_index;
 > -            int was_dirty;
 >  
 >              lock_page(page);
 >              if (page->mapping != mapping) {
 > @@ -386,12 +399,8 @@ int invalidate_inode_pages2_range(struct 
address_space *mapping,
 >                        PAGE_CACHE_SIZE, 0);
 >                  }
 >              }
 > -            was_dirty = test_clear_page_dirty(page);
 > -            if (!invalidate_complete_page2(mapping, page)) {
 > -                if (was_dirty)
 > -                    set_page_dirty(page);
 > +            if (!invalidate_complete_page2(mapping, page))
 >                  ret = -EIO;
 > -            }
 >              unlock_page(page);
 >          }
 >          pagevec_release(&pvec);
 > -
 > To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
