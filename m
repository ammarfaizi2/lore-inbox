Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265717AbTF2S27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbTF2S27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:28:59 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:2745 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265717AbTF2S26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:28:58 -0400
Date: Sun, 29 Jun 2003 20:42:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>, ldl@aros.net
Subject: Re: [PATCH] nbd: maintain compatibility with existing nbd tools
Message-ID: <20030629184253.GE267@elf.ucw.cz>
References: <3EFA1F7E.2080602@aros.net> <Pine.LNX.4.10.10306281315240.764-200000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10306281315240.764-200000@clements.sc.steeleye.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > [ ... ] In the meantime, the nbd-client tool currently can't correctly set 
> > the size of the device and either that needs to be worked around in the 
> > driver (I'd done that in the original jumbo patch), or the nbd-client 
> > tool needs to be updated (the patch I'd mailed out for nbd-client works 
> > around the sizing issue by re-opening the nbd). To be clear, that's not 
> > something any of the changes that have gone in so far broke nor address. 
> > It's a consequence of how bd_set_size() is called in fs/block_dev.c 
> > do_open().
> 
> And here's the (tiny) patch for nbd to maintain compatibility with the
> existing nbd-client tool. Compiled and tested on a couple machines.
> Please apply.

You are the maintainer, you can go to the linus directly. (I hope
Linus took that MAINTAINERS patch). Or you can send this to Rusty
'trivial patch monkey' russel. It seems easy enough.

								Pavel

[Aha, if you wanted *Andrew* to apply it... I guess it is better to
say directly who do you want to take it.]

> Thanks,
> Paul

Content-Description: nbd patch
> --- nbd.c.ORIG	2003-06-26 10:35:43.000000000 -0400
> +++ nbd.c	2003-06-26 17:03:08.000000000 -0400
> @@ -465,15 +468,18 @@
>  			lo->blksize_bits++;
>  			temp >>= 1;
>  		}
> -		lo->bytesize &= ~(lo->blksize-1); 
> +		lo->bytesize &= ~(lo->blksize-1);
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_SET_SIZE:
> -		lo->bytesize = arg & ~(lo->blksize-1); 
> +		lo->bytesize = arg & ~(lo->blksize-1);
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_SET_SIZE_BLOCKS:
>  		lo->bytesize = ((u64) arg) << lo->blksize_bits;
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_DO_IT:


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
