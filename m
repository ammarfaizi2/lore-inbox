Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUDUWAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUDUWAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUDUWAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:00:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43915 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261786AbUDUWAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:00:40 -0400
Date: Thu, 22 Apr 2004 03:28:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421215823.GB5014@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040421185206.GB7781@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421185206.GB7781@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:52:06PM +0200, Martin Schwidefsky wrote:
> diff -urN linux-2.6/kernel/rcupdate.c linux-2.6-s390/kernel/rcupdate.c
> --- linux-2.6/kernel/rcupdate.c	Wed Apr 21 20:25:10 2004
> +++ linux-2.6-s390/kernel/rcupdate.c	Wed Apr 21 20:25:33 2004
> @@ -96,6 +96,10 @@
>  	}
>  }
>  
> +#ifndef __ARCH_HAS_IDLE_CPU_MASK
> +#define idle_cpu_mask CPU_MASK_NONE
> +#endif
> +
>  /*
>   * Register a new batch of callbacks, and start it up if there is currently no
>   * active batch and the batch to be registered has not already occurred.
> @@ -111,7 +115,10 @@
>  		return;
>  	}
>  	/* Can't change, since spin lock held. */
> -	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
> +	rcu_ctrlblk.rcu_cpu_mask = idle_cpu_mask;
> +	cpus_complement(rcu_ctrlblk.rcu_cpu_mask);
> +	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map,
> +		 rcu_ctrlblk.rcu_cpu_mask);
>  }

Defining idle_cpu_mask in the middle of RCU code is really not a good idea.
A cleaner solution would be to define idle_cpu_mask in sched.c
and initialize it to CPU_MASK_NONE there. You could put it in 
sched.h, but then there is the likelyhood of people using
idle_cpu_mask for things other than initialization in which
case NR_CPUS > 64 compilation will fail.

Thanks
Dipankar
