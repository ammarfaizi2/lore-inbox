Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271297AbRHORJ6>; Wed, 15 Aug 2001 13:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271304AbRHORJr>; Wed, 15 Aug 2001 13:09:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39317 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271297AbRHORJk>; Wed, 15 Aug 2001 13:09:40 -0400
Date: Wed, 15 Aug 2001 11:09:12 -0600
Message-Id: <200108151709.f7FH9Ch26989@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "Kevin P. Fleming" <kevin@labsysgrp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: need help debugging a weird md/devfs problem...
In-Reply-To: <15226.568.747760.467691@notabene.cse.unsw.edu.au>
In-Reply-To: <022901c124dc$ee5138f0$6baaa8c0@kevin>
	<15226.568.747760.467691@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Tuesday August 14, kevin@labsysgrp.com wrote:
> > 
> > Anyone have any suggesting as to where to continue looking to find the
> > problem? I can put a workaround in to get my machine working, but there's
> > definitely something very weird going on here. Too bad I can't just tell the
> > kernel to notify me when that particular memory location gets modified...
> 
> The arrays in the "struct gendisk" are only allocated big enough to
> hold any drives that were found.  See init_gendisk in
> drivers/ide/ide-probe.c
> 
> In your situation device 3,67 is being referenced, which is hdb3.  As
> hdb was not detected, the arrays, particularly the partition array is
> not big enough to refer to that.  So when disk_name does:
>       hd->part[minor].de
> is it indexing off the end of an array an getting garbage.
> 

I haven't looked at the closely, but if you're right, other code is
going to fall off the ends of arrays as well.

> If I am right, the following patch should fix it for you.
> 
> NeilBrown
> 
> --- fs/partitions/check.c	2001/08/15 04:56:57	1.1
> +++ fs/partitions/check.c	2001/08/15 04:57:47
> @@ -101,7 +101,7 @@
>  	int unit = (minor >> hd->minor_shift) + 'a';
>  
>  	part = minor & ((1 << hd->minor_shift) - 1);
> -	if (hd->part[minor].de) {
> +	if (unit < hd->nr_real && hd->part[minor].de) {

This is definately wrong, since unit is not an index, but an ASCII
character. See the "+ 'a'" in there?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
