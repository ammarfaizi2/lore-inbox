Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281292AbRKETi4>; Mon, 5 Nov 2001 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281291AbRKETiq>; Mon, 5 Nov 2001 14:38:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55054 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281290AbRKETi0>; Mon, 5 Nov 2001 14:38:26 -0500
Date: Mon, 5 Nov 2001 14:55:42 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc: Kernel Janitor Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] net/core/dev.c jiffies cleanup
Message-ID: <20011105145542.F1731@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org,
	Kernel Janitor Project <kernel-janitor-discuss@lists.sourceforge.net>
In-Reply-To: <20011103162914.A12523@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011103162914.A12523@lynx.no>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 03, 2001 at 04:29:15PM -0700, Andreas Dilger escreveu:
> Linus, Alan,
> here is the first of the jiffies cleanups, this one of the files that
> Tim Schmielau flagged as "suspicious" users of jiffies.  Yes, I'm
> selfish, I'll only be sending patches for now for drivers/subsystems
> that I actually use.  The jiffies audit should probably become an
> item on the kernel janitor list of things to do (Arnaldo CC'd).

Sure, I'm CCing this message to the kjp mailing list so that volunteers can
work on this.
 
> Some places in the network code are hairy users of jiffies values,
> and it is not always clear that they are being used safely, but I
> can only do my best.
> 
> Where possible, I've also moved end-time calculations outside the
> loop and removed some confusing uses of "now".
> 
> Cheers, Andreas
> =========================================================================
> --- linux/net/core/dev.c.orig	Thu Oct 25 02:55:57 2001
> +++ linux/net/core/dev.c	Fri Nov  2 22:47:49 2001
> @@ -1407,7 +1407,7 @@
>  {
>  	int this_cpu = smp_processor_id();
>  	struct softnet_data *queue = &softnet_data[this_cpu];
> -	unsigned long start_time = jiffies;
> +	unsigned long end_time = jiffies + 1;
>  	int bugdet = netdev_max_backlog;
>  
>  	br_read_lock(BR_NETPROTO_LOCK);
> @@ -1504,7 +1504,7 @@
>  
>  		dev_put(rx_dev);
>  
> -		if (bugdet-- < 0 || jiffies - start_time > 1)
> +		if (bugdet-- < 0 || time_after(jiffies, end_time))
>  			goto softnet_break;
>  
>  #ifdef CONFIG_NET_HW_FLOWCONTROL
> @@ -2585,7 +2585,7 @@
>  
>  int unregister_netdevice(struct net_device *dev)
>  {
> -	unsigned long now, warning_time;
> +	unsigned long notify_time, warning_time;
>  	struct net_device *d, **dp;
>  
>  	/* If device is running, close it first. */
> @@ -2686,20 +2686,21 @@
>  
>  	 */
>  
> -	now = warning_time = jiffies;
> +	notify_time = jiffies + 1*HZ;
> +	warning_time = jiffies + 10*HZ;
>  	while (atomic_read(&dev->refcnt) != 1) {
> -		if ((jiffies - now) > 1*HZ) {
> +		if (time_after(jiffies, notify_time)) {
>  			/* Rebroadcast unregister notification */
>  			notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
>  		}
>  		current->state = TASK_INTERRUPTIBLE;
>  		schedule_timeout(HZ/4);
>  		current->state = TASK_RUNNING;
> -		if ((jiffies - warning_time) > 10*HZ) {
> -			printk(KERN_EMERG "unregister_netdevice: waiting for %s to "
> -					"become free. Usage count = %d\n",
> +		if (time_after(jiffies, warning_time)) {
> +			printk(KERN_EMERG "unregister_netdevice: waiting for %s"
> +					" to become free. Usage count = %d\n",
>  					dev->name, atomic_read(&dev->refcnt));
> -			warning_time = jiffies;
> +			warning_time = jiffies + 10*HZ;
>  		}
>  	}
>  	dev_put(dev);
> --
> Andreas Dilger
