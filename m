Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316654AbSFFBoL>; Wed, 5 Jun 2002 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFFBoK>; Wed, 5 Jun 2002 21:44:10 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:24325 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S316654AbSFFBoI>; Wed, 5 Jun 2002 21:44:08 -0400
Message-ID: <3CFEBF5D.9E415F75@zip.com.au>
Date: Wed, 05 Jun 2002 18:48:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: colpatch@us.ibm.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's 
 bigger than queue could handle
In-Reply-To: <200206060122.SAA00693@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ...
> >***generic_make_request: bio_sectors(bio) = 8, q->max_sectors = 64
> >***generic_make_request: bio_sectors(bio) = 96, q->max_sectors = 64
> >kernel BUG at ll_rw_blk.c:1602!
> [...]
> >>>EIP; c01bb604 <generic_make_request+d4/130>   <=====
> >Trace; c01bb6dc <submit_bio+5c/70>
> >Trace; c0152aa1 <mpage_bio_submit+31/40>
> >Trace; c0152dee <do_mpage_readpage+2ee/340>
> >Trace; c019ae75 <radix_tree_insert+15/30>
> >Trace; c012809e <__add_to_page_cache+1e/a0>
> >Trace; c01281bd <add_to_page_cache_unique+3d/60>
> >Trace; c0152eaa <mpage_readpages+6a/b0>
> >Trace; c01620a0 <ext2_get_block+0/400>
> [...]
> 
>         I think your kernel panic is proably related to the
> same problem that I addressed in ll_rw_kio, but, in fs/mpage.c
> as Andrew Moreton suggested:

Yes, same thing.

It looks like BIO_MAX_FOO needs to become an API function.
Question is: what should it return? Number of sectors, number
of bytes or number of pages?

For my purposes, I'd prefer number of pages.  ie: the vector
count which gets passed into bio_alloc:

	unsigned bio_max_iovecs(struct block_device *bdev);

	nr_iovecs = bio_max_iovecs(bdev);
	bio = bio_alloc(GFP_KERNEL, nr_iovecs);

would suit.

And if, via this, we can submit BIOs which are larger than 64k
for the common "it's just a disk" case then that is icing.

-
