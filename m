Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315759AbSEDBB3>; Fri, 3 May 2002 21:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSEDBB3>; Fri, 3 May 2002 21:01:29 -0400
Received: from Expansa.sns.it ([192.167.206.189]:12 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S315759AbSEDBB2>;
	Fri, 3 May 2002 21:01:28 -0400
Date: Sat, 4 May 2002 03:01:26 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 related,two oops with 2.5.12 on ATA66 disk.
In-Reply-To: <3CD2F92D.6B3C1648@zip.com.au>
Message-ID: <Pine.LNX.4.44.0205040301130.10739-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, will test this on montday ;)


On Fri, 3 May 2002, Andrew Morton wrote:

> Luigi Genoni wrote:
> >
> > HI,
> >
> > this morning, going at work, I found those two oops (repeated a lto of
> > times), on the Pentium III 512MB ram, i810 chipset, Maxtor 32049H2 ATA66
> > disk.
> >
> > buffer layer error at buffer.c:1380
> >
>
> Yup, thanks.  dirty, uptodate, unmapped buffer outside
> i_size.  I have a few fixes in the works; the below
> one should make this go away.
>
>
> --- 2.5.13/mm/page-writeback.c~writepage-versus-set_page_dirty	Fri May  3 00:48:13 2002
> +++ 2.5.13-akpm/mm/page-writeback.c	Fri May  3 00:48:13 2002
> @@ -475,8 +475,13 @@ int __set_page_dirty_buffers(struct page
>  		struct buffer_head *bh = head;
>
>  		do {
> -			if (buffer_uptodate(bh))
> +			if (buffer_uptodate(bh)) {
> +				if (!buffer_mapped(bh))
> +					buffer_error();
>  				set_buffer_dirty(bh);
> +			} else {
> +				buffer_error();
> +			}
>  			bh = bh->b_this_page;
>  		} while (bh != head);
>  	}
> --- 2.5.13/fs/buffer.c~writepage-versus-set_page_dirty	Fri May  3 00:48:13 2002
> +++ 2.5.13-akpm/fs/buffer.c	Fri May  3 00:48:43 2002
> @@ -1290,6 +1290,16 @@ static int __block_write_full_page(struc
>  					(1 << BH_Dirty)|(1 << BH_Uptodate));
>  	}
>
> +	/*
> +	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
> +	 * here, and the (potentially unmapped) buffers may become dirty at
> +	 * any time.  If a buffer becomes dirty here after we've inspected it
> +	 * then we just miss that fact, and the page stays dirty.
> +	 *
> +	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
> +	 * handle that here by just cleaning them.
> +	 */
> +
>  	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
>  	head = page_buffers(page);
>  	bh = head;
> @@ -1300,8 +1310,7 @@ static int __block_write_full_page(struc
>  	 */
>  	do {
>  		if (block > last_block) {
> -			if (buffer_dirty(bh))
> -				buffer_error();
> +			clear_buffer_dirty(bh);
>  			if (buffer_mapped(bh))
>  				buffer_error();
>  			/*
> @@ -1329,11 +1338,9 @@ static int __block_write_full_page(struc
>
>  	do {
>  		get_bh(bh);
> -		if (buffer_dirty(bh)) {
> +		if (buffer_mapped(bh) && buffer_dirty(bh)) {
>  			lock_buffer(bh);
> -			if (buffer_dirty(bh)) {
> -				if (!buffer_mapped(bh))
> -					buffer_error();
> +			if (test_clear_buffer_dirty(bh)) {
>  				if (!buffer_uptodate(bh))
>  					buffer_error();
>  				set_buffer_async_io(bh);
> @@ -1355,7 +1362,6 @@ static int __block_write_full_page(struc
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async(bh)) {
> -			clear_buffer_dirty(bh);
>  			submit_bh(WRITE, bh);
>  			nr_underway++;
>  		}
>

