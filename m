Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUIGIJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUIGIJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIGIJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:09:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267696AbUIGIDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:03:34 -0400
Date: Tue, 7 Sep 2004 10:02:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907080223.GF6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06 2004, Jesper Juhl wrote:
> 
> Hi,
> 
> Here's a patch to ensure that the return value from __copy_to_user() gets 
> checked in cdrom_read_cdda_old().
> I assume that returning -EFAULT if the copy fails to copy all bytes is an 
> appropriate action, but please correct me if I'm wrong.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.9-rc1-bk13-orig/drivers/cdrom/cdrom.c linux-2.6.9-rc1-bk13/drivers/cdrom/cdrom.c
> --- linux-2.6.9-rc1-bk13-orig/drivers/cdrom/cdrom.c	2004-08-24 20:44:01.000000000 +0200
> +++ linux-2.6.9-rc1-bk13/drivers/cdrom/cdrom.c	2004-09-06 23:41:20.000000000 +0200
> @@ -1959,7 +1959,10 @@ static int cdrom_read_cdda_old(struct cd
>  		ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
>  		if (ret)
>  			break;
> -		__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr);
> +		if (__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr)) {
> +			kfree(cgc.buffer);
> +			return -EFAULT;
> +		}
>  		ubuf += CD_FRAMESIZE_RAW * nr;
>  		nframes -= nr;
>  		lba += nr;

__copy_to_user is the unchecking version of copy_to_user.

-- 
Jens Axboe

