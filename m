Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAEAfT>; Thu, 4 Jan 2001 19:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRAEAfA>; Thu, 4 Jan 2001 19:35:00 -0500
Received: from fep04.swip.net ([130.244.199.132]:33466 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP
	id <S129415AbRAEAeq>; Thu, 4 Jan 2001 19:34:46 -0500
To: Tim Waugh <twaugh@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com> <m21yujuoew.fsf@ppro.localdomain> <20010104215210.D1148@redhat.com>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 05 Jan 2001 01:33:52 +0100
In-Reply-To: Tim Waugh's message of "Thu, 4 Jan 2001 21:52:10 +0000"
Message-ID: <m2vgruu9an.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh <twaugh@redhat.com> writes:

> On Thu, Jan 04, 2001 at 08:07:19PM +0100, Peter Osterlund wrote:
> 
> > If you do this, you should probably also return -EAGAIN if the printer
> > is out of paper, otherwise I would still lose data when the printer
> > goes out of paper. Currently it returns -ENOSPC in this situation. I
> > suppose the different return codes were meant as a way for user space
> > to be able to know why printing failed, so that it could take
> > appropriate actions, but maybe this is not used by any programs.
> 
> They were intended for that, yes, but it's probably better to stick
> with the 2.2 return codes.  Here's a patch to do that.  Look okay?

I assume you meant to return -EAGAIN, not -EIO. However, it doesn't
work if the printer is powered off and LP_ABORT is false. In that case
lp_write calls lp_check_status, which detects the error, waits 10
seconds, but then returns 0. lp_write then calls parport_write which
will happily send the data to the powered off printer, then return
success to user space and the data is lost.

> 
> Tim.
> */
> 
> 2001-01-04  Tim Waugh  <twaugh@redhat.com>
> 
> 	* drivers/char/lp.c: Follow 2.2 behaviour more closely.
> 
> --- linux-2.4.0-prerelease/drivers/char/lp.c.offline	Thu Jan  4 21:13:02 2001
> +++ linux-2.4.0-prerelease/drivers/char/lp.c	Thu Jan  4 21:42:19 2001
> @@ -207,7 +207,7 @@
>  			last = LP_POUTPA;
>  			printk(KERN_INFO "lp%d out of paper\n", minor);
>  		}
> -		error = -ENOSPC;
> +		error = -EIO;
>  	} else if (!(status & LP_PSELECD)) {
>  		if (last != LP_PSELECD) {
>  			last = LP_PSELECD;
> @@ -230,7 +230,10 @@
>  	if (last != 0)
>  		lp_error(minor);
>  
> -	return error;
> +	if (LP_F (minor) & LP_ABORT)
> +		return error;
> +
> +	return 0;
>  }
>  
>  static ssize_t lp_write(struct file * file, const char * buf,
> @@ -292,7 +295,7 @@
>  			/* incomplete write -> check error ! */
>  			int error = lp_check_status (minor);
>  
> -			if (LP_F(minor) & LP_ABORT) {
> +			if (error) {
>  				if (retv == 0)
>  					retv = error;
>  				break;

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
