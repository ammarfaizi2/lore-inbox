Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSAGBJN>; Sun, 6 Jan 2002 20:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSAGBJD>; Sun, 6 Jan 2002 20:09:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27472 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289062AbSAGBIu>; Sun, 6 Jan 2002 20:08:50 -0500
Date: Mon, 7 Jan 2002 02:08:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20020107020851.D1561@athlon.random>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>, <20011221004251.K1477@athlon.random>; <20011221024910.L1477@athlon.random> <3C36B117.A56A33C4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C36B117.A56A33C4@zip.com.au>; from akpm@zip.com.au on Fri, Jan 04, 2002 at 11:53:59PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 11:53:59PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > I diffed a more advanced version of it. It's not very well tested.
> > 
> > [ your rd.c patch ]
> >
> 
> Your patch is working OK for me.  I made two changes:
> 
> - s/PAGE_SIZE/PAGE_CACHE_SIZE/ in ramdisk_updatepage()

ok

> 
> - I think there's an SMP race in rd_blkdev_pagecache_IO() - it looks up
>   the underlying page in the pagecache and if it is present, it simply
>   proceeds, assuming that the page is uptodate.   But another CPU could have
>   just added the page and may be in the middle of initialising it.
>   So I changed rd_blkdev_pagecache_IO() to always lock the page.  It
>   got simpler.

certainly it makes smp simpler agreed, so also ramdisk_updatepage always
runs on locked pages.

the reason it was not locking down the page is that before the
ramdisk_aops was introduced, a read via /dev/ram? would lock down the
pagecache page, and then start the ll_rw_block on the pagecache page,
but with the page locked, so it would deadlock with an unconditional
grab_cache_page. Now with the ramdisk_aops it should be ok because the physical
address space I/O never uses the ->make_request_fn so it shouldn't
recurse on the page lock any longer.

> Please review - I'm trying to use the rd driver to test the truncate+ENOSPC

your patch seems all right to me now (of course with ramdisk_updatepage
run unconditionally). (I'd only set -ENOMEM in the fast path, so the
oom branch becomes an out of line goto, didn't checked the asm generated
though)

Andrea
