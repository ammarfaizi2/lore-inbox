Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286475AbRLTXnM>; Thu, 20 Dec 2001 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286474AbRLTXnC>; Thu, 20 Dec 2001 18:43:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24920 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286471AbRLTXmz>; Thu, 20 Dec 2001 18:42:55 -0500
Date: Fri, 21 Dec 2001 00:42:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20011221004251.K1477@athlon.random>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200112201946.fBKJkNw01262@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 20, 2001 at 11:46:23AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 11:46:23AM -0800, Linus Torvalds wrote:
> In article <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> you write:
> >Yes, this does fix the problem.  Thank you very much!
> >
> >Hopefully something like this will make it into 2.4.18?
> 
> This does not seem quite right.
> 
> >Tachino Nobuhiro (tachino@open.nm.fujitsu.co.jp) wrote:
> >> Hello,
> >> 
> >> Following patch may fix your problem. 
> >> 
> >> diff -r -u linux-2.4.17-rc2.org/drivers/block/rd.c 
> >> linux-2.4.17-rc2/drivers/block/rd.c
> >> --- linux-2.4.17-rc2.org/drivers/block/rd.c	Thu Dec 20 20:30:57 2001
> >> +++ linux-2.4.17-rc2/drivers/block/rd.c	Thu Dec 20 20:46:53 2001
> >> @@ -194,9 +194,11 @@
> >>  static int ramdisk_readpage(struct file *file, struct page * page)
> >>  {
> >>  	if (!Page_Uptodate(page)) {
> >> -		memset(kmap(page), 0, PAGE_CACHE_SIZE);
> >> -		kunmap(page);
> >> -		flush_dcache_page(page);
> >> +		if (!page->buffers) {
> >> +			memset(kmap(page), 0, PAGE_CACHE_SIZE);
> >> +			kunmap(page);
> >> +			flush_dcache_page(page);
> >> +		}
> >>  		SetPageUptodate(page);
> >>  	}
> >>  	UnlockPage(page);
> >> 
> >> 
> >>   grow_dev_page() creates not Uptodate page which has valid 
> >> buffers, so
> >> it is wrong that ramdisk_readpage() clears whole page unconditionally.
> 
> The problem is that having buffers doesn't necessarily always mean that
> they are valid, nor that _all_ of them are valid.
> 
> Also, if the ramdisk "readpage" code is wrong, then so is the
> "prepare_write" code.  They share the same logic, which basically says
> that "if the page isn't up-to-date, then it is zero".  Which is always
> true for normal read/write accesses, but as you found out it's not true
> when parts of the page have been accessed by filesystems through the
> buffers. 

subtle, while writing and testing that code the buffercache was not
sharing the physical address space yet, so it was stable, then it kept to
work somehow till today because only metadata writes into holes would
trigger it.

> 
> So the code _should_ use a common helper, something like
> 
> 	static void ramdisk_updatepage(struct page * page)
> 	{
> 		if (!Page_Uptodate(page)) {
> 			struct buffer_head *bh = page->buffers;
> 			void * address = page_address(page);
> 			if (bh) {
> 				struct buffer_head *tmp = bh;
> 				do {
> 					if (!buffer_uptodate(tmp)) {
> 						memset(address, 0, tmp->b_size);
> 						 set_buffer_uptodate(tmp);
> 					}
> 					address += tmp->b_size;
> 					tmp = tmp->b_this_page;
> 				} while (tmp != bh);
> 			} else
> 				memset(address, 0, PAGE_SIZE);
> 			flush_dcache_page(page);
> 			SetPageUptodate(page);
> 		}
> 	}
> 
> and then ramdisk_readpage() would just be
> 
> 	kmap(page);
> 	ramdisk_updatepage(page);
> 	UnlockPage(page);
> 	kunmap(page);
> 	return 0;
> 
> while ramdisk_prepare_write() would be
> 
> 	ramdisk_updatepage(page);
> 	SetPageDirty(page);
> 	return 0;

agreed. rd_blkdev_pagecache_IO will as well do:

			err = 0;

			kmap(page);
			ramdisk_updatepage(page);
			kunmap(page);

			unlock = 1;

Andrea
