Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTGFVlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTGFVlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:41:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:54020 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263859AbTGFVlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:41:47 -0400
Date: Sun, 6 Jul 2003 17:55:53 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Paul Clements <Paul.Clements@steeleye.com>, akpm@digeo.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.5.74-mm2] nbd: make nbd and block layer agree about
 device and  block sizes
In-Reply-To: <3F0896E4.4070003@pobox.com>
Message-ID: <Pine.LNX.4.10.10307061750040.764-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Jeff Garzik wrote:

> Paul Clements wrote:
> >  	case NBD_SET_BLKSIZE:
> > -		if ((arg & (arg-1)) || (arg < 512) || (arg > PAGE_SIZE))
> > -			return -EINVAL;
> >  		lo->blksize = arg;
> > -		lo->bytesize &= ~(lo->blksize-1); 
> > +		lo->bytesize &= ~(lo->blksize-1);
> > +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> > +		set_blocksize(inode->i_bdev, lo->blksize);
> >  		set_capacity(lo->disk, lo->bytesize >> 9);
> >  		return 0;
> >  	case NBD_SET_SIZE:
> > -		lo->bytesize = arg & ~(lo->blksize-1); 
> > +		lo->bytesize = arg & ~(lo->blksize-1);
> > +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> > +		set_blocksize(inode->i_bdev, lo->blksize);
> >  		set_capacity(lo->disk, lo->bytesize >> 9);
> >  		return 0;
> >  	case NBD_SET_SIZE_BLOCKS:
> >  		lo->bytesize = ((u64) arg) * lo->blksize;
> > +		inode->i_bdev->bd_inode->i_size = lo->bytesize;
> > +		set_blocksize(inode->i_bdev, lo->blksize);
> >  		set_capacity(lo->disk, lo->bytesize >> 9);
> >  		return 0;
> >  	case NBD_DO_IT:
> 
> 
> Thanks.  You forgot to check set_blocksize's return value for errors, 
> though.
> 
> Also, I wonder if you found a bug/oversight in set_blocksize -- it sets 
> bd_inode->i_blkbits but not bd_inode->i_size.  I think it should set 
> i_size also.  Maybe Andrew or Al can confirm/refute this assertion.

OK, I'll wait for a response on this, and then redo the patch as appropriate...

--
Paul

