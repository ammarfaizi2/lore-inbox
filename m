Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVEQHVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVEQHVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVEQHVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:21:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31755 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261298AbVEQHV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:21:29 -0400
Date: Tue, 17 May 2005 09:07:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] Fix root hole in raw device
Message-ID: <20050517070735.GB31163@alpha.home.local>
References: <11163046682662@kroah.com> <11163046681444@kroah.com> <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk> <20050517070305.GA31135@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517070305.GA31135@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 09:03:05AM +0200, Willy Tarreau wrote:
> On Tue, May 17, 2005 at 05:57:48AM +0100, Al Viro wrote:
> > On Mon, May 16, 2005 at 09:37:48PM -0700, Greg KH wrote:
> > > @@ -122,7 +122,7 @@
> > >  {
> > >  	struct block_device *bdev = filp->private_data;
> > >  
> > > -	return ioctl_by_bdev(bdev, command, arg);
> > > +	return blkdev_ioctl(bdev->bd_inode, filp, command, arg);
> > >  }
> > 
> > That is not quite correct.  You are passing very odd filp to ->ioctl()...
> > Old variant gave NULL, which is also not too nice, though.
> 
> 2.4 already does it in a cleaner manner :
> 
>         err = -EINVAL;
>         if (b && b->bd_inode && b->bd_op && b->bd_op->ioctl) {
>                 err = b->bd_op->ioctl(b->bd_inode, NULL, command, arg);
>         }
>         return err;
> 
> So may be something like this would be better (hand-written) :
> 
> @@ -122,7 +122,9 @@
>  {
>  	struct block_device *bdev = filp->private_data;
>  	int err = -EINVAL;
>  
> -	return ioctl_by_bdev(bdev, command, arg);
> +	if (bdev && bdev->bd_inode)
> +		err = blkdev_ioctl(bdev->bd_inode, filp, command, arg);
                                                 ^^^^^^^
Sorry, I forgot it...
I meant the same with the NULL. Is it OK ?

Willy

