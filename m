Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUG0BEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUG0BEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUG0BEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:04:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:61904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266205AbUG0BED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:04:03 -0400
Date: Mon, 26 Jul 2004 18:01:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Locking optimization for cache_reap
Message-Id: <20040726180104.62c480c6.akpm@osdl.org>
In-Reply-To: <20040723190555.GB16956@sgi.com>
References: <20040723190555.GB16956@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> Here is another cache_reap optimization that reduces latency when
> applied after the 'Move cache_reap out of timer context' patch I
> submitted on 7/14 (for inclusion in -mm next week).
> 
> This applies to 2.6.8-rc2 + the above mentioned patch.

How does it "reduce latency"?

It looks like a reasonable cleanup, but afaict it will result in the
per-cache spinlock actually being held for longer periods, thus increasing
latencies???

> 
> 
> Index: linux/mm/slab.c
> ===================================================================
> --- linux.orig/mm/slab.c
> +++ linux/mm/slab.c
> @@ -2619,27 +2619,6 @@ static void enable_cpucache (kmem_cache_
>  					cachep->name, -err);
>  }
>  
> -static void drain_array(kmem_cache_t *cachep, struct array_cache *ac)
> -{
> -	int tofree;
> -
> -	check_irq_off();
> -	if (ac->touched) {
> -		ac->touched = 0;
> -	} else if (ac->avail) {
> -		tofree = (ac->limit+4)/5;
> -		if (tofree > ac->avail) {
> -			tofree = (ac->avail+1)/2;
> -		}
> -		spin_lock(&cachep->spinlock);
> -		free_block(cachep, ac_entry(ac), tofree);
> -		spin_unlock(&cachep->spinlock);
> -		ac->avail -= tofree;
> -		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
> -					sizeof(void*)*ac->avail);
> -	}
> -}
> -
>  static void drain_array_locked(kmem_cache_t *cachep,
>  				struct array_cache *ac, int force)
>  {
> @@ -2697,16 +2676,14 @@ static void cache_reap (void *unused)
>  			goto next;
>  
>  		check_irq_on();
> -		local_irq_disable();
> -		drain_array(searchp, ac_data(searchp));
>  
> -		if(time_after(searchp->lists.next_reap, jiffies))
> -			goto next_irqon;
> +		spin_lock_irq(&searchp->spinlock);
> +
> +		drain_array_locked(searchp, ac_data(searchp), 0);
>  
> -		spin_lock(&searchp->spinlock);
> -		if(time_after(searchp->lists.next_reap, jiffies)) {
> +		if(time_after(searchp->lists.next_reap, jiffies))
>  			goto next_unlock;
> -		}
> +
>  		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
>  
>  		if (searchp->lists.shared)
> @@ -2739,9 +2716,7 @@ static void cache_reap (void *unused)
>  			spin_lock_irq(&searchp->spinlock);
>  		} while(--tofree > 0);
>  next_unlock:
> -		spin_unlock(&searchp->spinlock);
> -next_irqon:
> -		local_irq_enable();
> +		spin_unlock_irq(&searchp->spinlock);
>  next:
>  		;
>  	}
