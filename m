Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSGEOQT>; Fri, 5 Jul 2002 10:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSGEOQS>; Fri, 5 Jul 2002 10:16:18 -0400
Received: from [195.223.140.120] ([195.223.140.120]:22884 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317478AbSGEOQQ>; Fri, 5 Jul 2002 10:16:16 -0400
Date: Fri, 5 Jul 2002 16:19:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrea Arcangeli <andrea@e-mind.com>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT handling introduced a race in F_SETFL
Message-ID: <20020705141934.GI7734@dualathlon.random>
References: <20020702193019.C27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702193019.C27706@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 07:30:19PM +0100, Matthew Wilcox wrote:
> 
> I was doing some random kernel janitoring, pushing the BKL down a
> little bit, when I noticed O_DIRECT introduced a race.  If alloc_kiovec
> sleeps, we will effectively be unprotected by the BKL.  This would
> allow two processes sharing an fd both changing the FASYNC flag to
> call f_op->fasync() the wrong number of times and potentially leave
> the application erroneously believing that fasync is off when it is on,
> or vice versa.
> 
> My patch below fixes this problem by allocating the O_DIRECT kiovec
> before taking the BKL.  Any comments?  Also, should we be freeing the
> kiovec when removing the O_DIRECT attribute from the filp?
> 
> diff -urNX dontdiff linux-2.5.24/fs/fcntl.c linux-2.5.24-mm/fs/fcntl.c
> --- linux-2.5.24/fs/fcntl.c	Sun Jun  9 06:09:49 2002
> +++ linux-2.5.24-mm/fs/fcntl.c	Tue Jul  2 10:55:29 2002
> @@ -235,24 +235,11 @@
>  	if (!(arg & O_APPEND) && IS_APPEND(inode))
>  		return -EPERM;
>  
> -	/* Did FASYNC state change? */
> -	if ((arg ^ filp->f_flags) & FASYNC) {
> -		if (filp->f_op && filp->f_op->fasync) {
> -			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
> -			if (error < 0)
> -				return error;
> -		}
> -	}
> -
>  	if (arg & O_DIRECT) {
>  		/*
> -		 * alloc_kiovec() can sleep and we are only serialized by
> -		 * the big kernel lock here, so abuse the i_sem to serialize
> -		 * this case too. We of course wouldn't need to go deep down
> -		 * to the inode layer, we could stay at the file layer, but
> -		 * we don't want to pay for the memory of a semaphore in each
> -		 * file structure too and we use the inode semaphore that we just
> -		 * pay for anyways.
> +		 * alloc_kiovec() can sleep, so abuse the i_sem to serialize
> +		 * this case too.  Note we have to do this before we take the
> +		 * BKL otherwise we have a race if it sleeps.
>  		 */
>  		error = 0;
>  		down(&inode->i_sem);
> @@ -263,13 +250,26 @@
>  			return error;
>  	}
>  
> +	lock_kernel();
> +	/* Did FASYNC state change? */
> +	if ((arg ^ filp->f_flags) & FASYNC) {
> +		if (filp->f_op && filp->f_op->fasync) {
> +			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
> +			if (error < 0)
> +				goto out;
> +		}
> +	}
> +
>  	/* required for strict SunOS emulation */
>  	if (O_NONBLOCK != O_NDELAY)
>  	       if (arg & O_NDELAY)
>  		   arg |= O_NONBLOCK;
>  
>  	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
> -	return 0;
> +	error = 0;
> + out:
> +	unlock_kernel();
> +	return error;
>  }
>  
>  static long do_fcntl(unsigned int fd, unsigned int cmd,
> @@ -295,9 +295,7 @@
>  			err = filp->f_flags;
>  			break;
>  		case F_SETFL:
> -			lock_kernel();
>  			err = setfl(fd, filp, arg);
> -			unlock_kernel();
>  			break;
>  		case F_GETLK:
>  			err = fcntl_getlk(filp, (struct flock *) arg);

that's correct. Also moving the if (arg & O_DIRECT) {} right after
setting filp->f_flags would fix the race, that wouldn't require the move
the locking to the setfl, but I guess moving the locking down was your
object since the first place :). Please post it for mainline inclusion
too.

Andrea
