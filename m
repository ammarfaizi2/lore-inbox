Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTAKMxK>; Sat, 11 Jan 2003 07:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTAKMxK>; Sat, 11 Jan 2003 07:53:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3336 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262871AbTAKMxI>; Sat, 11 Jan 2003 07:53:08 -0500
Date: Sat, 11 Jan 2003 13:01:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030111130151.A21505@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <m3iswv27o3.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3iswv27o3.fsf@averell.firstfloor.org>; from ak@muc.de on Sat, Jan 11, 2003 at 01:27:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.56-work/drivers/char/tty_io.c-o	2003-01-02 05:13:12.000000000 +0100
> +++ linux-2.5.56-work/drivers/char/tty_io.c	2003-01-11 13:23:15.000000000 +0100
> @@ -1329,6 +1329,8 @@
>  		int major, minor;
>  		struct tty_driver *driver;
>  
> +		lock_kernel(); 
> +

Deadlock.  chrdev_open() calls lock_kernel() and then the fops->open
method, which is tty_open().

>  		/* find a device that is not in use. */
>  		retval = -1;
>  		for ( major = 0 ; major < UNIX98_NR_MAJORS ; major++ ) {
> @@ -1340,6 +1342,8 @@
>  				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
>  			}
>  		}
> +
> +		unlock_kernel();
>  		return -EIO; /* no free ptys */
>  	ptmx_found:
>  		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
> @@ -1357,6 +1361,8 @@
>  #endif  /* CONFIG_UNIX_98_PTYS */
>  	}
>  
> +	lock_kernel();
> +

Deadlock.  See chrdev_open() note above.

>  	retval = init_dev(device, &tty);
>  	if (retval)
>  		return retval;
> @@ -1389,6 +1395,8 @@
>  #endif
>  
>  		release_dev(filp);
> +
> +		unlock_kernel(); 
>  		if (retval != -ERESTARTSYS)
>  			return retval;
>  		if (signal_pending(current))
> @@ -1397,6 +1405,7 @@
>  		/*
>  		 * Need to reset f_op in case a hangup happened.
>  		 */
> +		lock_kernel();

Deadlock.  See chrdev_open() note above.

>  		filp->f_op = &tty_fops;
>  		goto retry_open;
>  	}
> @@ -1424,6 +1433,7 @@
>  			nr_warns++;
>  		}
>  	}
> +	unlock_kernel();
>  	return 0;
>  }
>  
> @@ -1444,8 +1454,13 @@
>  	if (tty_paranoia_check(tty, filp->f_dentry->d_inode->i_rdev, "tty_poll"))
>  		return 0;
>  
> -	if (tty->ldisc.poll)
> -		return (tty->ldisc.poll)(tty, filp, wait);
> +	if (tty->ldisc.poll) { 
> +		int ret;
> +		lock_kernel();
> +		ret = (tty->ldisc.poll)(tty, filp, wait);
> +		unlock_kernel();
> +		return ret;
> +	}

This one needs deeper review.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

