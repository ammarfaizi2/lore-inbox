Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282404AbRK3JAE>; Fri, 30 Nov 2001 04:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283568AbRK3I7y>; Fri, 30 Nov 2001 03:59:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283354AbRK3I7v>;
	Fri, 30 Nov 2001 03:59:51 -0500
Date: Fri, 30 Nov 2001 09:59:20 +0100
From: Jens Axboe <axboe@suse.de>
To: andersg@0x63.nu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, rwhron@earthlink.net
Subject: Re: 2.5.1-pre3 FIXED (was Re: 2.5.1-pre3 DON'T USE)
Message-ID: <20011130095920.Q16796@suse.de>
In-Reply-To: <20011129091554.E5788@suse.de> <20011129121431.D10601@suse.de> <20011130095314.D21256@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130095314.D21256@h55p111.delphi.afb.lu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, andersg@0x63.nu wrote:
> On Thu, Nov 29, 2001 at 12:14:31PM +0100, Jens Axboe wrote:
> > On Thu, Nov 29 2001, Jens Axboe wrote:
> > > Hi,
> > > 
> > > Please don't use this kernel unless you can afford to loose your data.
> > > I'm looking at the problem right now.
> > 
> > Ok the problem was only on highmem machines, the copying of data was
> > just wrong. The attached patch fixes that and a few other buglets, such
> > as:
> > 
> > - BIO_HASH remnant in LVM
> 
> shouldn't line 1046 in lvm.c be:
>   bio.bi_io_vec[0].bv_len = lvm_get_blksize(bio.bi_dev);
> 
> with this patch it atleast compiles..
> 
> --- linux-2.5.1-pre4-vanilj/drivers/md/lvm.c	Fri Nov 30 09:45:31 2001
> +++ linux-2.5.1-pre4/drivers/md/lvm.c	Fri Nov 30 09:32:42 2001
> @@ -1043,7 +1043,7 @@
>  
>  	memset(&bio,0,sizeof(bio));
>  	bio.bi_dev = inode->i_rdev;
> -	bio.bi_io_vec.bv_len = lvm_get_blksize(bio.bi_dev);
> +	bio.bi_io_vec[0].bv_len = lvm_get_blksize(bio.bi_dev);
>   	bio.bi_sector = block * bio_sectors(&bio);
>  	bio.bi_rw = READ;
>  	if ((err=lvm_map(&bio)) < 0)  {

memset(bio...) and then deref bi_io_vec, not a good idea. Then leaving
it in a non-compileable state for now is preferable.

-- 
Jens Axboe

