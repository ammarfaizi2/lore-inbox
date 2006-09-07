Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWIGWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWIGWUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWIGWUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:20:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751911AbWIGWUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:20:45 -0400
Date: Thu, 7 Sep 2006 15:20:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>
Subject: Re: Naughty ramdrives
Message-Id: <20060907152037.a4e1437b.akpm@osdl.org>
In-Reply-To: <20060907220852.GA5192@martell.zuzino.mipt.ru>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru>
	<20060907145412.db920bb5.akpm@osdl.org>
	<20060907220852.GA5192@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 02:08:53 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > So I assume udev is still madly crunching on its message backlog while
> > this is happening?
> >
> > If so, ug.
> 
> OK. I'll let it stabilize, sorry.

You shouldn't have to.

> > > This was noticed while investigating #4899
> > > http://bugme.osdl.org/show_bug.cgi?id=4899
> > > where /dev/ram0 when opened, pins module indefinitely. It seems that
> > > adding ->release() which undoes
> > >
> > > 	inode = igrab(bdev->bd_inode);
> > >
> > > should do the trick. Am I right?
> 
> > Looks right.
> >
> > I'm not sure that igrab() is needed though.  Probably bd_openers is
> > sufficient.
> >
> > I'm also not sure that rd_open() needs to play with bd_openers.
> > fs/block_dev.c:do_open() already does that.
> 
> Maybe start with closing open/open race?
> That's what drivers/char/raw.c does...
> ------------------------------------------------
> [PATCH 1/2] rd: protect rd_bdev[] with mutex
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/block/rd.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/block/rd.c
> +++ b/drivers/block/rd.c
> @@ -56,6 +56,7 @@ #include <linux/buffer_head.h>		/* for i
>  #include <linux/backing-dev.h>
>  #include <linux/blkpg.h>
>  #include <linux/writeback.h>
> +#include <linux/mutex.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -63,6 +64,7 @@ #include <asm/uaccess.h>
>   */
>  
>  static struct gendisk *rd_disks[CONFIG_BLK_DEV_RAM_COUNT];
> +static DEFINE_MUTEX(rd_mutex);

This could be static to rd_open().

>  static struct block_device *rd_bdev[CONFIG_BLK_DEV_RAM_COUNT];/* Protected device data */
>  static struct request_queue *rd_queue[CONFIG_BLK_DEV_RAM_COUNT];
>  
> @@ -343,6 +345,7 @@ static int rd_open(struct inode *inode, 
>  {
>  	unsigned unit = iminor(inode);
>  
> +	mutex_lock(&rd_mutex);

I suspect that we've inherited enough locking from the caller to not need
this.  That's if fs/block_dev.c:do_open() is the only caller.  Not sure if
that's true if someone goes and partitions a ramdisk (is that possible?).

All this gendisk/blockdev/contains/partitions/bd_inode stuff is quite
ghastly.  Every six months I spend long enough staring at it to
half-understand it and then promptly forget how it all works.


