Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272588AbTHKHWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272589AbTHKHWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:22:36 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:35337 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272588AbTHKHWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:22:35 -0400
Date: Mon, 11 Aug 2003 08:22:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2 of 2 - Allow O_EXCL on a block device to claim exclusive use.
Message-ID: <20030811082231.A20077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neilb@cse.unsw.edu.au>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <E19m2XN-0002BU-00@notabene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19m2XN-0002BU-00@notabene>; from neilb@cse.unsw.edu.au on Mon, Aug 11, 2003 at 12:35:57PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:35:57PM +1000, NeilBrown wrote:
> diff ./fs/block_dev.c~current~ ./fs/block_dev.c
> --- ./fs/block_dev.c~current~	2003-08-11 09:01:38.000000000 +1000
> +++ ./fs/block_dev.c	2003-08-11 09:01:41.000000000 +1000
> @@ -643,6 +643,7 @@ int blkdev_get(struct block_device *bdev
>  int blkdev_open(struct inode * inode, struct file * filp)
>  {
>  	struct block_device *bdev;
> +	int res;
>  
>  	/*
>  	 * Preserve backwards compatibility and allow large file access
> @@ -655,7 +656,18 @@ int blkdev_open(struct inode * inode, st
>  	bd_acquire(inode);
>  	bdev = inode->i_bdev;
>  
> -	return do_open(bdev, inode, filp);
> +	res = do_open(bdev, inode, filp);
> +	if (res)
> +		return res;
> +
> +	if (!(filp->f_flags & O_EXCL) )
> +		return 0;
> +
> +	if (!(res = bd_claim(bdev, filp)))
> +		return 0;
> +
> +	blkdev_put(bdev, BDEV_FILE);
> +	return res;

Shouldn't you claim it before opening.  Also what is the desired
behaviour when opening partitions vs whole device with O_EXCL?

