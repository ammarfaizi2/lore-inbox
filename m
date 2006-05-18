Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWERVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWERVGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWERVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:06:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751200AbWERVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:06:47 -0400
Date: Thu, 18 May 2006 14:06:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
In-Reply-To: <20060518185955.GK5964@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
References: <1147849273.16827.27.camel@localhost.localdomain>
 <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain>
 <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com>
 <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int>
 <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
 <20060518185955.GK5964@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 May 2006, Andreas Dilger wrote:
>  	struct bio *bio;
> +	unsigned long long sector;
>  	int ret = 0;
>  
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
>  	BUG_ON(!bh->b_end_io);
>  
> +	/* Check if we overflow sector_t when computing the sector offset.  */
> +	sector = (unsigned long long)bh->b_blocknr * (bh->b_size >> 9);

Ok so far, looks fine.

But what the heck is this:

> +#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
> +	if (unlikely(sector != (sector_t)sector))
> +#else
> +	if (unlikely(((bh->b_blocknr >> 32) * (bh->b_size >> 9)) >=
> +		     0xffffffff00000000ULL))
> +#endif

I don't understand the #ifdef at all.

Why isn't that just a 

	if (unlikely(sector != (sector_t)sector))

and that's it? What does this have to do with CONFIG_LBD or BITS_PER_LONG, 
or anything at all?

If the sector number fits in a sector_t, we're all good.

			Linus
