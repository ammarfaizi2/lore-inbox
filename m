Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTHJRMA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 13:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHJRMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 13:12:00 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:7951 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S270022AbTHJRL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 13:11:56 -0400
Date: Sun, 10 Aug 2003 19:06:17 +0200
Message-Id: <200308101706.h7AH6Hd21642@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Paul Clements <Paul.Clements@SteelEye.com>
Subject: Re: [PATCH 2.4.22-pre] nbd: fix race conditions
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-Reply-To: <iKef.8c1.15@gated-at.bofh.it>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <iKef.8c1.15@gated-at.bofh.it> you wrote:
> This patch is similar to one I posted yesterday for 2.6. It fixes the
> following race conditions in nbd:
>  
> 1) adds locking and properly orders the code in NBD_CLEAR_SOCK to
> eliminate races with other code

This is not so clear as for the 2.6 code.  There's no ref_count in the
2.4 request struct, so you have no standard way to mark a request as
in-flight, and hence no standard way to get clr_queue to skip it for the
moment.  You are using something else as a marker, but I'm not quite
clear what.  Can you say?

To summarise - the patch below appears to me not to do what you say it
does, though it does cure races between setting and unsetting lo->file
and lo->sock. It doesn't appear to cure races between clearing requests and
doing them.

> 2) adds an lo->sock check to nbd_clear_que to eliminate races between
> do_nbd_request and nbd_clear_que, which resulted in the dequeuing of
> active requests
>  
> 3) adds an lo->sock check to NBD_DO_IT to eliminate races with
> NBD_CLEAR_SOCK, which caused an Oops when "nbd-client -d" was called
>  

All these are for the same thing - the metadataraces. 

> --- linux-2.4.21-PRISTINE/drivers/block/nbd.c	Fri Jun 13 10:51:32 2003
> +++ linux-2.4.21/drivers/block/nbd.c	Sat Aug  9 13:25:49 2003
> @@ -428,23 +428,24 @@ static int nbd_ioctl(struct inode *inode
>                  return 0 ;
>   
>  	case NBD_CLEAR_SOCK:
> +		error = 0;
> +		down(&lo->tx_lock);
> +		lo->sock = NULL;
> +		up(&lo->tx_lock);

Unggg .. you mark lo->sock as null, atomically.

> +		spin_lock(&lo->queue_lock);
> +		file = lo->file;
> +		lo->file = NULL;
> +		spin_unlock(&lo->queue_lock);

You save lo->file and mark it null, atomically.

>  		nbd_clear_que(lo);
>  		spin_lock(&lo->queue_lock);
>  		if (!list_empty(&lo->queue_head)) {
> -			spin_unlock(&lo->queue_lock);
> -			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
> -			return -EBUSY;
> -		}

You remove the code that gave up on trying to clear socket if the queue is
nonempty. Why? What's wrong with getting userspace to retry until OK?
Oh, I see ...

> -		file = lo->file;
> -		if (!file) {
> -			spin_unlock(&lo->queue_lock);
> -			return -EINVAL;
> +			printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
> +			error = -EBUSY;
>  		}

... it looks as though if the queue is nonempty, we now still return
busy. So what you did was remove the test on lo->file. Now we don't
care about the lo->file state. Why?


> -		lo->file = NULL;
> -		lo->sock = NULL;
>  		spin_unlock(&lo->queue_lock);
> -		fput(file);
> -		return 0;
> +		if (file)
> +			fput(file);
> +		return error;

Well, that was harmless. 

>  	case NBD_SET_SOCK:
>  		if (lo->file)
>  			return -EBUSY;
> @@ -491,9 +492,12 @@ static int nbd_ioctl(struct inode *inode
>  		 * there should be a more generic interface rather than
>  		 * calling socket ops directly here */
>  		down(&lo->tx_lock);
> -		printk(KERN_WARNING "nbd: shutting down socket\n");
> -		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
> -		lo->sock = NULL;
> +		if (lo->sock) {
> +			printk(KERN_WARNING "nbd: shutting down socket\n");
> +			lo->sock->ops->shutdown(lo->sock,
> +				SEND_SHUTDOWN|RCV_SHUTDOWN);
> +			lo->sock = NULL;
> +		}

Harmless.

>  		up(&lo->tx_lock);
>  		spin_lock(&lo->queue_lock);
>  		file = lo->file;
> @@ -505,6 +509,13 @@ static int nbd_ioctl(struct inode *inode
>  			fput(file);
>  		return lo->harderror;
>  	case NBD_CLEAR_QUE:
> +		down(&lo->tx_lock);
> +		if (lo->sock) {
> +			up(&lo->tx_lock);
> +			return 0; /* probably should be error, but that would
> +				   * break "nbd-client -d", so just return 0 */
> +		}
> +		up(&lo->tx_lock);

You don't clear queue while lo->sock is nonzero. This means that one
must have cleared socket beforehand.

>  		nbd_clear_que(lo);
>  		return 0;
>  #ifdef PARANOIA

I don't see any race conditions going away. Except possibly a race
between set sock and clear sock to set lo->sock. The setting of
lo->file is also a little more atomic now, and that's OK. But surely
the race condition you cured in 2.6 was not this at all, but a race
between clearing the queue and doing the requests?

Peter
