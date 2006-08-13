Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWHMJEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWHMJEy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 05:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHMJEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 05:04:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30102 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750757AbWHMJEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 05:04:53 -0400
Date: Sun, 13 Aug 2006 13:04:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Carr <basilarchia@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take8 1/2] kevent: Core files.
Message-ID: <20060813090405.GA14960@2ka.mipt.ru>
References: <11552856103972@2ka.mipt.ru> <44DE779D.8060609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44DE779D.8060609@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 13 Aug 2006 13:04:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 05:51:41PM -0700, Jeff Carr (basilarchia@gmail.com) wrote:
> On 08/11/06 01:40, Evgeniy Polyakov wrote:
> 
> > +/*
> > + * Inode events.
> > + */
> > +#define	KEVENT_INODE_CREATE	0x1
> > +#define	KEVENT_INODE_REMOVE	0x2
> 
> It would be useful to have gnome/kde notification when hard drives start
> failing. There was some talk in the past about how to implement that
> with kobjects. Perhaps you could add for this purpose:
> 
> #define	KEVENT_BLOCK_CREATE	0x1
> #define	KEVENT_BLOCK_REMOVE	0x2
> #define	KEVENT_BLOCK_ERROR	0x4

Do we want it to be on top of kobject (like in your patch), or based on
gendisk? I think the latter is better, since kobject reperesents almost
any kind of devices, so we will create noticeble overhead for those who
do not know about kevents.

> AFAICT:
> The conversation concluded this is the best way to handle ioerrors:
> 
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -108,6 +108,8 @@ static void buffer_io_error(struct buffe
>  	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
>  			bdevname(bh->b_bdev, b),
>  			(unsigned long long)bh->b_blocknr);
> +
> +	kevent_block_error(&bh->b_bdev->bd_disk->kobj);
>  }
> 
>  /*
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -252,8 +252,11 @@ static void finished_one_bio(struct dio
>  				transferred = dio->i_size - offset;
> 
>  			/* check for error in completion path */
> -			if (dio->io_error)
> +			if (dio->io_error) {
>  				transferred = dio->io_error;
> +				kevent_block_error(
> +				&dio->bio->bi_bdev->bd_disk->kobj);
> +			}
> 
>  			dio_complete(dio, offset, transferred);

-- 
	Evgeniy Polyakov
