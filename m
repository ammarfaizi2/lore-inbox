Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUDUPbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUDUPbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbUDUPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:31:54 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:9224 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263162AbUDUPbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:31:51 -0400
Date: Wed, 21 Apr 2004 16:31:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421163148.B7211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040421144948.GJ2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040421144948.GJ2951@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Apr 21, 2004 at 04:49:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ linux-2.6-s390/include/linux/rcupdate.h	Wed Apr 21 16:29:41 2004
> @@ -121,6 +121,34 @@
>  		return 0;
>  }
>  
> +#ifdef CONFIG_NO_IDLE_HZ
> +
> +extern cpumask_t idle_cpu_mask;
> +
> +/* 
> + * RCU is build for ticking systems. Without the HZ timer 
> + * we have not enought state changes which may result in a 
> + * never finished RCU request.
> + * In a tickless system we don't want to wake idle CPUs just 
> + * to finish the RCU request. That is possible because the 
> + * idle CPUs satisfy the quiescilant RCU condition anyway.          
> + */
> +static inline void rcu_set_active_cpu_map(cpumask_t *mask)
> +{
> +	cpumask_t active = idle_cpu_mask;
> +	cpus_complement(active);
> +	cpus_and(*mask, cpu_online_map, active);
> +}
> +
> +#else
> +
> +static inline void rcu_set_active_cpu_map(cpumask_t *mask)
> +{
> +	*mask = cpu_online_map;
> +}
> +
> +#endif

This is a bit ugly.  What about inlining the CONFIG_NO_IDLE_HZ case
of this function in it's only caller and define idle_cpu_mask to
an empty cpu mask for all other arches?

> --- linux-2.6/include/linux/sysctl.h	Wed Apr 21 16:29:19 2004
> +++ linux-2.6-s390/include/linux/sysctl.h	Wed Apr 21 16:29:41 2004
> @@ -132,6 +132,7 @@
>  	KERN_PTY=62,		/* dir: pty driver */
>  	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
>  	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
> +	KERN_S390_HZ_TIMER=64,  /* int: hz timer on or off */

Kill the S390, this seems usefull for a bunch of other architectures.

> --- linux-2.6/include/linux/timer.h	Sun Apr  4 05:37:37 2004
> +++ linux-2.6-s390/include/linux/timer.h	Wed Apr 21 16:29:41 2004
> @@ -65,6 +65,10 @@
>  extern int __mod_timer(struct timer_list *timer, unsigned long expires);
>  extern int mod_timer(struct timer_list *timer, unsigned long expires);
>  
> +#ifdef CONFIG_NO_IDLE_HZ
> +extern unsigned long next_timer_interrupt(void);
> +#endif

kill the ifdef.  externs don't need to be cpp'ed away.

> --- linux-2.6/kernel/sysctl.c	Wed Apr 21 16:29:19 2004
> +++ linux-2.6-s390/kernel/sysctl.c	Wed Apr 21 16:29:41 2004
> @@ -108,6 +108,10 @@
>  extern int sysctl_userprocess_debug;
>  #endif
>  
> +#ifdef CONFIG_NO_IDLE_HZ
> +extern int sysctl_hz_timer;

dito.  

