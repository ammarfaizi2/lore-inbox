Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVKVMBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVKVMBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKVMBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:01:40 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:40603 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964905AbVKVMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:01:39 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 22 Nov 2005 12:00:45 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Neil Brown <neilb@suse.de>
cc: Andrew Morton <akpm@osdl.org>, sander@humilis.net,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm
 --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
In-Reply-To: <17282.35980.613583.592130@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0511221153430.2763@hermes-1.csi.cam.ac.uk>
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au>
 <20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org>
 <17275.48113.533555.948181@cse.unsw.edu.au> <20051117075041.GA5563@favonius>
 <20051117101251.GA2883@favonius> <20051117101511.GB2883@favonius>
 <17282.21309.229128.930997@cse.unsw.edu.au> <20051121155144.62bedaab.akpm@osdl.org>
 <17282.35980.613583.592130@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Neil Brown wrote:
> On Monday November 21, akpm@osdl.org wrote:
> > Neil Brown <neilb@suse.de> wrote:
> > >
> > > Help ???
> > 
> > Indeed.  tmpfs is crackpottery.
> 
> Ok, that explains a lot... :-)
> 
> > >  Any advice would be most welcome!
> > 
> > Skip the writepage if !mapping_cap_writeback_dirty(page->mapping), I guess.
> > Or, if appropriate, just sync the file.  Use filemap_fdatawrite() or even
> > refactor do_fsync() and use most of that.
> 
> Uhm, what would you think of testing mapping_cap_writeback_dirty in
> write_one_page??  If you don't like it, I can take it into write_page.
> 
> > Also, write_page() doesn't need to run set_page_dirty(); ->commit_write()
> > will do that.
> 
> Ok.... but I think I'm dropping prepare_write / commit_write.

That is a good idea given some file systems do not implement them.

> > Several kmap()s in there which can become kmap_atomic().
> 
> I've made them all kmap_atomic.

Except you did it wrong...  See below...

> > bitmap_init_from_disk() might be leaking bitmap->filemap on kmalloc-failed
> > error path.
> 
> It looks that way, but actually not.  bitmap_create requires that
> bitmap_destroy always be called afterwards, even on an error.  Not the
> best interface I'd agree...
> 
> > bitmap->filemap_attr can be allocated with kzalloc() now.
> Yes, thanks.
> 
> So Sander, could you try this patch for main against reiser4?  It
> seems to work on ext3 and tmpfs and has some chance of not mucking up
> on reiser4.
> 
> Thanks,
> NeilBrown
> 
> ===File /home/src/mm/.patches/applied/014MdBitmapFix========
> Status: devel
> 
> Hopefully make md/bitmaps work on files other than ext3
> 
> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./drivers/md/bitmap.c |   64 +++++++++++++++++++-------------------------------
>  ./mm/page-writeback.c |    4 +++
>  2 files changed, 29 insertions(+), 39 deletions(-)
> 
> diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
> --- ./drivers/md/bitmap.c~current~	2005-11-22 14:06:53.000000000 +1100
> +++ ./drivers/md/bitmap.c	2005-11-22 14:07:05.000000000 +1100
> @@ -310,7 +310,6 @@ static int write_sb_page(mddev_t *mddev,
>   */
>  static int write_page(struct bitmap *bitmap, struct page *page, int wait)
>  {
> -	int ret = -ENOMEM;
>  
>  	if (bitmap->file == NULL)
>  		return write_sb_page(bitmap->mddev, bitmap->offset, page, wait);
> @@ -326,15 +325,6 @@ static int write_page(struct bitmap *bit
>  		}
>  	}
>  
> -	ret = page->mapping->a_ops->prepare_write(bitmap->file, page, 0, PAGE_SIZE);
> -	if (!ret)
> -		ret = page->mapping->a_ops->commit_write(bitmap->file, page, 0,
> -			PAGE_SIZE);
> -	if (ret) {
> -		unlock_page(page);
> -		return ret;
> -	}
> -
>  	set_page_dirty(page); /* force it to be written out */
>  
>  	if (!wait) {
> @@ -406,11 +396,11 @@ int bitmap_update_sb(struct bitmap *bitm
>  		return 0;
>  	}
>  	spin_unlock_irqrestore(&bitmap->lock, flags);
> -	sb = (bitmap_super_t *)kmap(bitmap->sb_page);
> +	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
>  	sb->events = cpu_to_le64(bitmap->mddev->events);
>  	if (!bitmap->mddev->degraded)
>  		sb->events_cleared = cpu_to_le64(bitmap->mddev->events);
> -	kunmap(bitmap->sb_page);
> +	kunmap_atomic(bitmap->sb_page, KM_USER0);

You need to pass in the address not the page, i.e.:

	kunmap_atomic(sb, KM_USER0);

>  	return write_page(bitmap, bitmap->sb_page, 1);
>  }
>  
> @@ -421,7 +411,7 @@ void bitmap_print_sb(struct bitmap *bitm
>  
>  	if (!bitmap || !bitmap->sb_page)
>  		return;
> -	sb = (bitmap_super_t *)kmap(bitmap->sb_page);
> +	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
>  	printk(KERN_DEBUG "%s: bitmap file superblock:\n", bmname(bitmap));
>  	printk(KERN_DEBUG "         magic: %08x\n", le32_to_cpu(sb->magic));
>  	printk(KERN_DEBUG "       version: %d\n", le32_to_cpu(sb->version));
> @@ -440,7 +430,7 @@ void bitmap_print_sb(struct bitmap *bitm
>  	printk(KERN_DEBUG "     sync size: %llu KB\n",
>  			(unsigned long long)le64_to_cpu(sb->sync_size)/2);
>  	printk(KERN_DEBUG "max write behind: %d\n", le32_to_cpu(sb->write_behind));
> -	kunmap(bitmap->sb_page);
> +	kunmap_atomic(bitmap->sb_page, KM_USER0);

Again, this should be:

	kunmap_atomic(sb, KM_USER0);

>  }
>  
>  /* read the superblock from the bitmap file and initialize some bitmap fields */
> @@ -466,7 +456,7 @@ static int bitmap_read_sb(struct bitmap 
>  		return err;
>  	}
>  
> -	sb = (bitmap_super_t *)kmap(bitmap->sb_page);
> +	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
>  
>  	if (bytes_read < sizeof(*sb)) { /* short read */
>  		printk(KERN_INFO "%s: bitmap file superblock truncated\n",
> @@ -535,7 +525,7 @@ success:
>  		bitmap->events_cleared = bitmap->mddev->events;
>  	err = 0;
>  out:
> -	kunmap(bitmap->sb_page);
> +	kunmap_atomic(bitmap->sb_page, KM_USER0);

Again:	kunmap_atomic(sb, KM_USER0);

>  	if (err)
>  		bitmap_print_sb(bitmap);
>  	return err;
> @@ -560,7 +550,7 @@ static void bitmap_mask_state(struct bit
>  	}
>  	page_cache_get(bitmap->sb_page);
>  	spin_unlock_irqrestore(&bitmap->lock, flags);
> -	sb = (bitmap_super_t *)kmap(bitmap->sb_page);
> +	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
>  	switch (op) {
>  		case MASK_SET: sb->state |= bits;
>  				break;
> @@ -568,7 +558,7 @@ static void bitmap_mask_state(struct bit
>  				break;
>  		default: BUG();
>  	}
> -	kunmap(bitmap->sb_page);
> +	kunmap_atomic(bitmap->sb_page, KM_USER0);

Again:	kunmap_atomic(sb, KM_USER0);

>  	page_cache_release(bitmap->sb_page);
>  }
>  
> @@ -621,8 +611,7 @@ static void bitmap_file_unmap(struct bit
>  	spin_unlock_irqrestore(&bitmap->lock, flags);
>  
>  	while (pages--)
> -		if (map[pages]->index != 0) /* 0 is sb_page, release it below */
> -			page_cache_release(map[pages]);
> +		page_cache_release(map[pages]);
>  	kfree(map);
>  	kfree(attr);
>  
> @@ -771,7 +760,7 @@ static void bitmap_file_set_bit(struct b
>  		set_bit(bit, kaddr);
>  	else
>  		ext2_set_bit(bit, kaddr);
> -	kunmap_atomic(kaddr, KM_USER0);
> +	kunmap_atomic(page, KM_USER0);

This one was correct, you broke it.  (-:

>  	PRINTK("set file bit %lu page %lu\n", bit, page->index);
>  
>  	/* record page number so it gets flushed to disk when unplug occurs */
> @@ -854,6 +843,7 @@ static int bitmap_init_from_disk(struct 
>  	unsigned long bytes, offset, dummy;
>  	int outofdate;
>  	int ret = -ENOSPC;
> +	void *paddr;
>  
>  	chunks = bitmap->chunks;
>  	file = bitmap->file;
> @@ -887,12 +877,10 @@ static int bitmap_init_from_disk(struct 
>  	if (!bitmap->filemap)
>  		goto out;
>  
> -	bitmap->filemap_attr = kmalloc(sizeof(long) * num_pages, GFP_KERNEL);
> +	bitmap->filemap_attr = kzalloc(sizeof(long) * num_pages, GFP_KERNEL);
>  	if (!bitmap->filemap_attr)
>  		goto out;
>  
> -	memset(bitmap->filemap_attr, 0, sizeof(long) * num_pages);
> -
>  	oldindex = ~0L;
>  
>  	for (i = 0; i < chunks; i++) {
> @@ -901,8 +889,6 @@ static int bitmap_init_from_disk(struct 
>  		bit = file_page_offset(i);
>  		if (index != oldindex) { /* this is a new page, read it in */
>  			/* unmap the old page, we're done with it */
> -			if (oldpage != NULL)
> -				kunmap(oldpage);
>  			if (index == 0) {
>  				/*
>  				 * if we're here then the superblock page
> @@ -910,6 +896,7 @@ static int bitmap_init_from_disk(struct 
>  				 * we've already read it in, so just use it
>  				 */
>  				page = bitmap->sb_page;
> +				page_cache_get(page);
>  				offset = sizeof(bitmap_super_t);
>  			} else if (file) {
>  				page = read_page(file, index, &dummy);
> @@ -925,18 +912,18 @@ static int bitmap_init_from_disk(struct 
>  
>  			oldindex = index;
>  			oldpage = page;
> -			kmap(page);
>  
>  			if (outofdate) {
>  				/*
>  				 * if bitmap is out of date, dirty the
>  			 	 * whole page and write it out
>  				 */
> -				memset(page_address(page) + offset, 0xff,
> +				paddr = kmap_atomic(page, KM_USER0);
> +				memset(paddr + offset, 0xff,
>  				       PAGE_SIZE - offset);
> +				kunmap_atomic(page, KM_USER0);

Again:				kunmap_atomic(paddr, KM_USER0);

>  				ret = write_page(bitmap, page, 1);
>  				if (ret) {
> -					kunmap(page);
>  					/* release, page not in filemap yet */
>  					page_cache_release(page);
>  					goto out;
> @@ -945,10 +932,12 @@ static int bitmap_init_from_disk(struct 
>  
>  			bitmap->filemap[bitmap->file_pages++] = page;
>  		}
> +		paddr = kmap_atomic(page, KM_USER0);
>  		if (bitmap->flags & BITMAP_HOSTENDIAN)
> -			b = test_bit(bit, page_address(page));
> +			b = test_bit(bit, paddr);
>  		else
> -			b = ext2_test_bit(bit, page_address(page));
> +			b = ext2_test_bit(bit, paddr);
> +		kunmap_atomic(page, KM_USER0);

Again:		kunmap_atomic(paddr, KM_USER0);

>  		if (b) {
>  			/* if the disk bit is set, set the memory bit */
>  			bitmap_set_memory_bits(bitmap, i << CHUNK_BLOCK_SHIFT(bitmap),
> @@ -963,9 +952,6 @@ static int bitmap_init_from_disk(struct 
>  	ret = 0;
>  	bitmap_mask_state(bitmap, BITMAP_STALE, MASK_UNSET);
>  
> -	if (page) /* unmap the last page */
> -		kunmap(page);
> -
>  	if (bit_cnt) { /* Kick recovery if any bits were set */
>  		set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
>  		md_wakeup_thread(bitmap->mddev->thread);
> @@ -1021,6 +1007,7 @@ int bitmap_daemon_work(struct bitmap *bi
>  	int err = 0;
>  	int blocks;
>  	int attr;
> +	void *paddr;
>  
>  	if (bitmap == NULL)
>  		return 0;
> @@ -1077,14 +1064,12 @@ int bitmap_daemon_work(struct bitmap *bi
>  					set_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
>  					spin_unlock_irqrestore(&bitmap->lock, flags);
>  				}
> -				kunmap(lastpage);
>  				page_cache_release(lastpage);
>  				if (err)
>  					bitmap_file_kick(bitmap);
>  			} else
>  				spin_unlock_irqrestore(&bitmap->lock, flags);
>  			lastpage = page;
> -			kmap(page);
>  /*
>  			printk("bitmap clean at page %lu\n", j);
>  */
> @@ -1107,10 +1092,12 @@ int bitmap_daemon_work(struct bitmap *bi
>  						  -1);
>  
>  				/* clear the bit */
> +				paddr = kmap_atomic(page, KM_USER0);
>  				if (bitmap->flags & BITMAP_HOSTENDIAN)
> -					clear_bit(file_page_offset(j), page_address(page));
> +					clear_bit(file_page_offset(j), paddr);
>  				else
> -					ext2_clear_bit(file_page_offset(j), page_address(page));
> +					ext2_clear_bit(file_page_offset(j), paddr);
> +				kunmap_atomic(page, KM_USER0);

Again:				kunmap_atomic(paddr, KM_USER0);

>  			}
>  		}
>  		spin_unlock_irqrestore(&bitmap->lock, flags);
> @@ -1118,7 +1105,6 @@ int bitmap_daemon_work(struct bitmap *bi
>  
>  	/* now sync the final page */
>  	if (lastpage != NULL) {
> -		kunmap(lastpage);
>  		spin_lock_irqsave(&bitmap->lock, flags);
>  		if (get_page_attr(bitmap, lastpage) &BITMAP_PAGE_NEEDWRITE) {
>  			clear_page_attr(bitmap, lastpage, BITMAP_PAGE_NEEDWRITE);
> 
> diff ./mm/page-writeback.c~current~ ./mm/page-writeback.c
> --- ./mm/page-writeback.c~current~	2005-11-22 14:06:53.000000000 +1100
> +++ ./mm/page-writeback.c	2005-11-22 14:07:05.000000000 +1100
> @@ -583,6 +583,10 @@ int write_one_page(struct page *page, in
>  	};
>  
>  	BUG_ON(!PageLocked(page));
> +	if (!mapping_cap_writeback_dirty(mapping)) {
> +		unlock_page(page);
> +		return ret;
> +	}
>  
>  	if (wait)
>  		wait_on_page_writeback(page);

Hope this helps.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
