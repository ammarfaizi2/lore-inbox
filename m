Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRBYTEm>; Sun, 25 Feb 2001 14:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbRBYTEd>; Sun, 25 Feb 2001 14:04:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:22276 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129589AbRBYTEM>;
	Sun, 25 Feb 2001 14:04:12 -0500
Message-ID: <20010225200040.A3186@bug.ucw.cz>
Date: Sun, 25 Feb 2001 20:00:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Steve Whitehouse <Steve@ChyGwyn.com>, andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: NBD Hangs
In-Reply-To: <200102251217.MAA19785@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102251217.MAA19785@gw.chygwyn.com>; from Steve Whitehouse on Sun, Feb 25, 2001 at 12:17:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've been having some NBD hangs with the 2.4.2 kernel. It appears that
> block devices which don't use plugging will not have their request
> functions called when the request is queued. I propose the following
> patch to ll_rw_blk.c which seems to do the trick for me. Also I have
> done a small amount of tidying in nbd.c.

Thanx for nbd cleanups. All but two changes look good. Please submit
them to Linus and tell him I approved.

								Pavel

> Btw, do you know what the deadlock problem is when plugging is enabled
> on nbd ? I had a good look through the code and did some tests and there
> certainly are problems with deadlocks with plugging enabled but I couldn't
> quite pin down the source. I guessed it might have something to do with 
> blocking in the request function.

Sorry, no clues.


> diff -u -r linux-2.4.2-zc1/drivers/block/nbd.c linux/drivers/block/nbd.c
> --- linux-2.4.2-zc1/drivers/block/nbd.c	Mon Oct 30 22:30:33 2000
> +++ linux/drivers/block/nbd.c	Sun Feb 25 11:23:45 2001
> @@ -174,8 +175,11 @@
>  }
>  
>  #define HARDFAIL( s ) { printk( KERN_ERR "NBD: " s "(result %d)\n", result ); lo->harderror = result; return NULL; }
> +
> +/* 
> + * NULL returned = something went wrong, inform userspace
> + */ 
>  struct request *nbd_read_stat(struct nbd_device *lo)
> -		/* NULL returned = something went wrong, inform userspace       */ 
>  {
>  	int result;
>  	struct nbd_reply reply;

I do not like this one. Comment before function should describe what
it does.

> @@ -493,9 +493,7 @@
>  		       MAJOR_NR);
>  		return -EIO;
>  	}
> -#ifdef MODULE
>  	printk("nbd: registered device at major %d\n", MAJOR_NR);
> -#endif
>  	blksize_size[MAJOR_NR] = nbd_blksizes;
>  	blk_size[MAJOR_NR] = nbd_sizes;
>  	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request);

Keep this ifdef module. I want module to say something, but not to
pollute kernel messages.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
