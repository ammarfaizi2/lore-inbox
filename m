Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTAMBym>; Sun, 12 Jan 2003 20:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267764AbTAMBym>; Sun, 12 Jan 2003 20:54:42 -0500
Received: from havoc.daloft.com ([64.213.145.173]:56540 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267761AbTAMByk>;
	Sun, 12 Jan 2003 20:54:40 -0500
Date: Sun, 12 Jan 2003 21:03:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] fixup loop blkdev, add module_get
Message-ID: <20030113020325.GA18756@gtf.org>
References: <20030112035620.GA25648@gtf.org> <20030113011128.8150C2C05A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113011128.8150C2C05A@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 11:55:47AM +1100, Rusty Russell wrote:
> In message <20030112035620.GA25648@gtf.org> you write:
> > Sometimes, we are absolutely certain that we have at least one module
> > reference "locked open" for us.  Loop is an example of such a case:  the
> > set-fd and clear-fd struct block_device_operations ioctls already have a
> > module reference from simply the block device being opened.
> > 
> > Therefore, we can just unconditionally increment the module refcount.
> > I added module_get to do this.
> 
> Hi Jeff,
> 
> 	We may yet want such a primitive, but I've been resisting it
> for the moment.
> 
> 	Firstly, because it's a very specialized and rare case which
> lends itself to being abused, and secondly because if I "rmmod --wait"
> the module, then such operations which try to hold the module in place
> *should* fail.  Not doing so is impolite, at least.

Eh...  You are trying to chase infinity with 'rmmod --wait'.

More below...


> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/block/loop.c working-2.5-bk-loop/drivers/block/loop.c
> --- linux-2.5-bk/drivers/block/loop.c	2003-01-02 12:45:18.000000000 +1100
> +++ working-2.5-bk-loop/drivers/block/loop.c	2003-01-13 11:49:21.000000000 +1100
> @@ -642,7 +642,9 @@ static int loop_set_fd(struct loop_devic
>  	int		lo_flags = 0;
>  	int		error;
>  
> -	MOD_INC_USE_COUNT;
> +	if (!try_module_get(THIS_MODULE))
> +		/* I'm going away: pretend I'm not here. */
> +		return -EBUSY;
>  
>  	error = -EBUSY;
>  	if (lo->lo_state != Lo_unbound)

I disagree:

1) we do not prevent root from shooting themselves in the foot,

2) moreover we do not prevent them from doing something that may be
perfectly reasonable,

3) and this kind of code just adds error handling for no reason, when
_not_ handling the error keeps the code more clean.

In general this is just caring way too much about an obscure corner
case.  Is the increased complexity of error handling when we _know_ the
refcnt is locked for worth it?

Note that Linus turned off the 'deprecated' warning because MOD.*COUNT
users are just too frequent, still.

	Jeff



