Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWHGH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWHGH1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHGH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:27:09 -0400
Received: from www.osadl.org ([213.239.205.134]:37341 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751126AbWHGH1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:27:07 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, alokk@calsoftinc.com
In-Reply-To: <20060802191029.GA4958@localhost.localdomain>
References: <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
	 <1154118476.10196.5.camel@localhost.localdomain>
	 <1154118947.10196.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
	 <1154119658.10196.17.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281344410.20754@schroedinger.engr.sgi.com>
	 <20060728211227.GB3739@localhost.localdomain>
	 <1154121608.10196.24.camel@localhost.localdomain>
	 <20060802191029.GA4958@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 09:27:36 +0200
Message-Id: <1154935656.5932.262.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 12:10 -0700, Ravikiran G Thirumalai wrote:
> Here's an attempt to educate lockdep about alien cache lock. tglx, can you
> confirm if this fixes the false positive?  This is just an extension of the
> l3 lock lesson :).
> 
> Note: With this approach, lockdep forgets its education for alien caches
> if all cpus of a node go down and come back up.  But taking care of 
> that scenario will make things uglier....not sure if it is worth it.
> 
> Thanks,
> Kiran

Sorry, I did not come around to test it earlier. With this patch applied
the lockdep message is gone.

	tglx

> Place the alien array cache locks of on slab malloc slab caches on a seperate 
> lockdep class.  This avoids false positives from lockdep
> 
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.18-rc3-x460/mm/slab.c
> ===================================================================
> --- linux-2.6.18-rc3-x460.orig/mm/slab.c	2006-07-30 21:27:28.000000000 -0700
> +++ linux-2.6.18-rc3-x460/mm/slab.c	2006-08-01 18:01:51.000000000 -0700
> @@ -682,23 +682,43 @@
>   * The locking for this is tricky in that it nests within the locks
>   * of all other slabs in a few places; to deal with this special
>   * locking we put on-slab caches into a separate lock-class.
> + *
> + * We set lock class for alien array caches which are up during init.
> + * The lock annotation will be lost if all cpus of a node goes down and 
> + * then comes back up during hotplug
>   */
> -static struct lock_class_key on_slab_key;
> +static struct lock_class_key on_slab_l3_key;
> +static struct lock_class_key on_slab_alc_key;
> +
> +static inline void init_lock_keys(void)
>  
> -static inline void init_lock_keys(struct cache_sizes *s)
>  {
>  	int q;
> +	struct cache_sizes *s = malloc_sizes;
>  
> -	for (q = 0; q < MAX_NUMNODES; q++) {
> -		if (!s->cs_cachep->nodelists[q] || OFF_SLAB(s->cs_cachep))
> -			continue;
> -		lockdep_set_class(&s->cs_cachep->nodelists[q]->list_lock,
> -				  &on_slab_key);
> +	while (s->cs_size != ULONG_MAX) {
> +		for_each_node(q) {
> +			struct array_cache **alc;
> +			int r;
> +			struct kmem_list3 *l3 = s->cs_cachep->nodelists[q];
> +			if (!l3 || OFF_SLAB(s->cs_cachep))
> +				continue;
> +			lockdep_set_class(&l3->list_lock, &on_slab_l3_key);
> +			alc = l3->alien;
> +			if (!alc)
> +				continue;
> +			for_each_node(r) {
> +				if (alc[r])
> +					lockdep_set_class(&alc[r]->lock,
> +					     &on_slab_alc_key);
> +			}
> +		}
> +		s++;
>  	}
>  }
>  
>  #else
> -static inline void init_lock_keys(struct cache_sizes *s)
> +static inline void init_lock_keys()
>  {
>  }
>  #endif
> @@ -1422,7 +1442,6 @@
>  					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
>  					NULL, NULL);
>  		}
> -		init_lock_keys(sizes);
>  
>  		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
>  					sizes->cs_size,
> @@ -1495,6 +1514,10 @@
>  		mutex_unlock(&cache_chain_mutex);
>  	}
>  
> +	/* Annotate slab for lockdep -- annotate the malloc caches */
> +	init_lock_keys();
> +	
> +
>  	/* Done! */
>  	g_cpucache_up = FULL;
>  

