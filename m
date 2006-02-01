Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWBAQ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWBAQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWBAQ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:27:42 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:21175 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964980AbWBAQ1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:27:41 -0500
Subject: Re: 2.6.16rc1-git4 slab corruption.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: manfred@colorfullife.com
Cc: Chris Mason <mason@suse.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <20060201160921.GC5875@redhat.com>
References: <20060131180319.GA18948@redhat.com>
	 <200601311408.35771.mason@suse.com> <20060131221542.GC29937@redhat.com>
	 <84144f020601312327t490dcf4fi6fb09942a0f3dd87@mail.gmail.com>
	 <20060201160921.GC5875@redhat.com>
Date: Wed, 01 Feb 2006 18:27:38 +0200
Message-Id: <1138811259.8604.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Dave Jones <davej@redhat.com> wrote:
> > > Manfred had a nice 'check all slabs before they're freed' patch, which might
> > > be worth resurrecting for some tests. It may be that we're corrupting rarely
> > > free'd slabs, making them hard to hit.

On Wed, Feb 01, 2006 at 09:27:02AM +0200, Pekka Enberg wrote:
> > Do you know where I can find that patch? I would like to try to sneak
> > that past Andrew. It seems silly not to have these useful slab
> > debugging patches within mainline.

On Wed, 2006-02-01 at 11:09 -0500, Dave Jones wrote:
> Here's the last version that I had that was rediffed against
> 2.6.13 or .14 (I forget which, it's been a while since I used it).

Thanks Dave. Manfred, is there are reason this wasn't merged with
mainline? Needs bit of cleanup but seems useful for detecting slab
corruption early.

			Pekka

>  
> diff -urNp --exclude-from=/home/davej/.exclude linux-1000/mm/slab.c linux-1010/mm/slab.c
> --- linux-1000/mm/slab.c
> +++ linux-1010/mm/slab.c
> @@ -189,7 +189,7 @@
>   */
>  
>  #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
> -#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
> +#define BUFCTL_ALLOC	(((kmem_bufctl_t)(~0U))-1)
>  #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
>  
>  /* Max number of objs-per-slab for caches which use off-slab slabs.
> @@ -355,6 +355,7 @@ struct kmem_cache_s {
>  #if DEBUG
>  	int			dbghead;
>  	int			reallen;
> +	unsigned long		redzonetest;
>  #endif
>  };
>  
> @@ -370,6 +371,7 @@ struct kmem_cache_s {
>   */
>  #define REAPTIMEOUT_CPUC	(2*HZ)
>  #define REAPTIMEOUT_LIST3	(4*HZ)
> +#define REDZONETIMEOUT		(300*HZ)
>  
>  #if STATS
>  #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
> @@ -1446,7 +1448,11 @@ next:
>  	} 
>  
>  	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
> -					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
> +					((unsigned long)cachep/L1_CACHE_BYTES)%REAPTIMEOUT_LIST3;
> +#if DEBUG
> +	cachep->redzonetest = jiffies + REDZONETIMEOUT +
> +					((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
> +#endif
>  
>  	/* Need the semaphore to access the chain. */
>  	down(&cache_chain_sem);
> @@ -2043,7 +2049,7 @@ retry:
>  			slabp->inuse++;
>  			next = slab_bufctl(slabp)[slabp->free];
>  #if DEBUG
> -			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
> +			slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
>  #endif
>  		       	slabp->free = next;
>  		}
> @@ -2181,7 +2187,7 @@ static void free_block(kmem_cache_t *cac
>  		objnr = (objp - slabp->s_mem) / cachep->objsize;
>  		check_slabp(cachep, slabp);
>  #if DEBUG
> -		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
> +		if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
>  			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
>  						cachep->name, objp);
>  			BUG();
> @@ -2409,7 +2415,7 @@ got_slabp:
>  	slabp->inuse++;
>  	next = slab_bufctl(slabp)[slabp->free];
>  #if DEBUG
> -	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
> +	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
>  #endif
>  	slabp->free = next;
>  	check_slabp(cachep, slabp);
> @@ -2615,6 +2621,94 @@ unsigned int kmem_cache_size(kmem_cache_
>  
>  EXPORT_SYMBOL(kmem_cache_size);
>  
> +#if DEBUG
> +static void check_slabuse(kmem_cache_t *cachep, struct slab *slabp)
> +{
> +	int i;
> +
> +	if (!(cachep->flags & SLAB_RED_ZONE))
> +		return;	/* no redzone data to check */
> +
> +#if CONFIG_DEBUG_PAGEALLOC
> +	/* Page alloc debugging on for this cache. Mapping & Unmapping happens
> +	 * without any locking, thus parallel checks are impossible.
> +	 */
> +	if ((cachep->objsize%PAGE_SIZE)==0 && OFF_SLAB(cachep))
> +		return;
> +#endif
> +
> +	for (i=0;i<cachep->num;i++) {
> +		void *objp = slabp->s_mem + cachep->objsize * i;
> +		unsigned long red1, red2;
> +
> +		red1 = *dbg_redzone1(cachep, objp);
> +		red2 = *dbg_redzone2(cachep, objp);
> +
> +		/* simplest case: marked as inactive */
> +		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
> +			continue;
> +
> +		/* tricky case: if the bufctl value is BUFCTL_ALLOC, then
> +		 * the object is either allocated or somewhere in a cpu
> +		 * cache. The cpu caches are lockless and there might be
> +		 * a concurrent alloc/free call, thus we must accept random
> +		 * combinations of RED_ACTIVE and _INACTIVE
> +		 */
> +		if (slab_bufctl(slabp)[i] == BUFCTL_ALLOC &&
> +				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
> +				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
> +			continue;
> +
> +		printk(KERN_ERR "slab %s: redzone mismatch in slabp %p, objp %p, bufctl 0x%x\n",
> +				cachep->name, slabp, objp, slab_bufctl(slabp)[i]);
> +		print_objinfo(cachep, objp, 2);
> +	}
> +}
> +
> +/*
> + * Perform a self test on all slabs from a cache
> + */
> +static void check_redzone(kmem_cache_t *cachep)
> +{
> +	struct list_head *q;
> +	struct slab *slabp;
> +
> +	check_spinlock_acquired(cachep);
> +
> +	list_for_each(q,&cachep->lists.slabs_full) {
> +		slabp = list_entry(q, struct slab, list);
> +
> +		if (slabp->inuse != cachep->num) {
> +			printk(KERN_INFO "slab %s: wrong slabp found in full slab chain at %p (%d/%d).\n",
> +					cachep->name, slabp, slabp->inuse, cachep->num);
> +		}
> +		check_slabp(cachep, slabp);
> +		check_slabuse(cachep, slabp);
> +	}
> +	list_for_each(q,&cachep->lists.slabs_partial) {
> +		slabp = list_entry(q, struct slab, list);
> +
> +		if (slabp->inuse == cachep->num || slabp->inuse == 0) {
> +			printk(KERN_INFO "slab %s: wrong slab found in partial chain at %p (%d/%d).\n",
> +					cachep->name, slabp, slabp->inuse, cachep->num);
> +		}
> +		check_slabp(cachep, slabp);
> +		check_slabuse(cachep, slabp);
> +	}
> +	list_for_each(q,&cachep->lists.slabs_free) {
> +		slabp = list_entry(q, struct slab, list);
> +
> +		if (slabp->inuse != 0) {
> +			printk(KERN_INFO "slab %s: wrong slab found in free chain at %p (%d/%d).\n",
> +					cachep->name, slabp, slabp->inuse, cachep->num);
> +		}
> +		check_slabp(cachep, slabp);
> +		check_slabuse(cachep, slabp);
> +	}
> +}
> +
> +#endif
> +
>  struct ccupdate_struct {
>  	kmem_cache_t *cachep;
>  	struct array_cache *new[NR_CPUS];
> @@ -2798,6 +2892,12 @@ static void cache_reap(void *unused)
>  
>  		drain_array_locked(searchp, ac_data(searchp), 0);
>  
> +#if DEBUG
> +		if(time_before(searchp->redzonetest, jiffies)) {
> +			searchp->redzonetest = jiffies + REDZONETIMEOUT;
> +			check_redzone(searchp);
> +		}
> +#endif
>  		if(time_after(searchp->lists.next_reap, jiffies))
>  			goto next_unlock;
>  
> 
> 

