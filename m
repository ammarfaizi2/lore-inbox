Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGFVYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTGFVYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:24:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40836 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263637AbTGFVYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:24:23 -0400
Message-ID: <3F0896E4.4070003@pobox.com>
Date: Sun, 06 Jul 2003 17:38:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.5.74-mm2] nbd: make nbd and block layer agree about
 device and  block sizes
References: <3F089177.1A58BFE0@SteelEye.com> <3F089281.5BED1A25@SteelEye.com>
In-Reply-To: <3F089281.5BED1A25@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:
>  	case NBD_SET_BLKSIZE:
> -		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
> -			return -EINVAL;
>  		lo->blksize = arg;
> -		lo->bytesize &= ~(lo->blksize-1); 
> +		lo->bytesize &= ~(lo->blksize-1);
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> +		set_blocksize(inode->i_bdev, lo->blksize);
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_SET_SIZE:
> -		lo->bytesize = arg & ~(lo->blksize-1); 
> +		lo->bytesize = arg & ~(lo->blksize-1);
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> +		set_blocksize(inode->i_bdev, lo->blksize);
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_SET_SIZE_BLOCKS:
>  		lo->bytesize = ((u64) arg) * lo->blksize;
> +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> +		set_blocksize(inode->i_bdev, lo->blksize);
>  		set_capacity(lo->disk, lo->bytesize >> 9);
>  		return 0;
>  	case NBD_DO_IT:


Thanks.  You forgot to check set_blocksize's return value for errors, 
though.

Also, I wonder if you found a bug/oversight in set_blocksize -- it sets 
bd_inode->i_blkbits but not bd_inode->i_size.  I think it should set 
i_size also.  Maybe Andrew or Al can confirm/refute this assertion.

	Jeff



