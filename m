Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276670AbRJaAMF>; Tue, 30 Oct 2001 19:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277001AbRJaAL5>; Tue, 30 Oct 2001 19:11:57 -0500
Received: from t02-12.ra.uc.edu ([129.137.228.36]:33413 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S276761AbRJaALp>;
	Tue, 30 Oct 2001 19:11:45 -0500
Date: Tue, 30 Oct 2001 19:11:52 -0500
To: Robert Kuebel <kuebelr@email.uc.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too thread termination
Message-ID: <20011030191152.A898@cartman>
In-Reply-To: <20011029232508.A305@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011029232508.A305@cartman>
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, i am wondering if i have made a mistake.  this patch will make the
kernel thread die when tp->time_to_die is true.  tp is kmalloc()'ed
inside of alloc_etherdev.  i didn't initialize time_to_die to 0, but
this patch has been working perfectly for me.  am i just lucky or are
kmalloc()'ed regions zero'ed out?  i know there is stuff like
get_zeroed_page(), but i don't think that applies here.  i guess it
doesn't hurt to set the flag to zero myself.

can someone clue me in?

thanks.
rob.

On Mon, Oct 29, 2001 at 11:25:08PM -0500, Robert Kuebel wrote:
> this patch stops the 8139too kernel thread from dying on any signal.
> now, it will only terminate when the driver is closed.
> 
> the patch is agains 2.4.13.
> 
> thanks.
> rob.
> 
> --- drivers/net/8139too.orig.c	Mon Oct 29 22:59:15 2001
> +++ drivers/net/8139too.c	Mon Oct 29 23:07:32 2001
> @@ -80,6 +80,8 @@
>  
>  		Kalle Olavi Niemitalo - Wake-on-LAN ioctls
>  
> +		Robert Kuebel - Save kernel thread from dying on any signal.
> +
>  	Submitting bug reports:
>  
>  		"rtl8139-diag -mmmaaavvveefN" output
> @@ -616,6 +618,7 @@
>  	struct completion thr_exited;
>  	u32 rx_config;
>  	struct rtl_extra_stats xstats;
> +	int time_to_die;
>  };
>  
>  MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
> @@ -1669,7 +1672,13 @@
>  			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
>  		} while (!signal_pending (current) && (timeout > 0));
>  
> -		if (signal_pending (current))
> +		if (signal_pending (current)) {
> +			spin_lock_irq(&current->sigmask_lock);
> +			flush_signals(current);
> +			spin_unlock_irq(&current->sigmask_lock);
> +		}
> +
> +		if (tp->time_to_die)
>  			break;
>  
>  		rtnl_lock ();
> @@ -2200,6 +2209,8 @@
>  	netif_stop_queue (dev);
>  
>  	if (tp->thr_pid >= 0) {
> +		tp->time_to_die = 1;
> +		wmb();
>  		ret = kill_proc (tp->thr_pid, SIGTERM, 1);
>  		if (ret) {
>  			printk (KERN_ERR "%s: unable to signal thread\n", dev->name);
