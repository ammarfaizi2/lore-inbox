Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWFVTSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWFVTSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWFVTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:18:10 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:42894 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751887AbWFVTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:18:09 -0400
Date: Thu, 22 Jun 2006 22:18:07 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 1/4] slab freeing consolidation
In-Reply-To: <20060619184656.23130.69473.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222211370.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184656.23130.69473.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Mon, 19 Jun 2006, Christoph Lameter wrote:
> Add a new function drop_freelist that removes slabs with objects
> that are already free and use that in various places.

I think you mean drain_freelist().  Anyway, looks good.  Some 
minor comments below.

> -static int __node_shrink(struct kmem_cache *cachep, int node)
> +/*
> + * Remove slabs from the list of free slabs.
> + * Specify the number of slabs to drain in tofree.
> + *
> + * Returns the actual number of slabs released.
> + */
> +static int long drain_freelist(struct kmem_cache *cachep,
> +		struct kmem_list3 *l3, int tofree)

I have been trying to slowly kill the 'p' prefix so I'd appreciate if you 
could just call the parameter 'cache'.  Also, l3 could be 'lists'.

> +	nr_freed = 0;
> +	while (nr_freed < tofree && !list_empty(&l3->slabs_free)) {
>  
> -		p = l3->slabs_free.prev;
> -		if (p == &l3->slabs_free)
> -			break;
> +		spin_lock_irq(&l3->list_lock);
> +		p = l3->slabs_free.next;
> +		if (p == &(l3->slabs_free)) {

Please drop the redundant parenthesis.

> +			spin_unlock_irq(&l3->list_lock);
> +			return nr_freed;
> +		}

Goto to the bottom would be nicer than return here, maybe.

>  
> -		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
> +		slabp = list_entry(p, struct slab, list);
>  #if DEBUG
>  		BUG_ON(slabp->inuse);
>  #endif
>  		list_del(&slabp->list);
> -
> +		/*
> +		 * Safe to drop the lock. The slab is no longer linked
> +		 * to the cache.
> +		 */
>  		l3->free_objects -= cachep->num;
>  		spin_unlock_irq(&l3->list_lock);
>  		slab_destroy(cachep, slabp);
> -		spin_lock_irq(&l3->list_lock);
> -	}
> -	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
> -	return ret;
> +		nr_freed ++;

Redundant whitespace.

> +	};

Redundant semicolon.

> +		else {
> +			int x;

nr_freed, would be better.

>  
> -			slabp = list_entry(p, struct slab, list);
> -			BUG_ON(slabp->inuse);
> -			list_del(&slabp->list);
> -			STATS_INC_REAPED(searchp);
> -
> -			/*
> -			 * Safe to drop the lock. The slab is no longer linked
> -			 * to the cache. searchp cannot disappear, we hold
> -			 * cache_chain_lock
> -			 */
> -			l3->free_objects -= searchp->num;
> -			spin_unlock_irq(&l3->list_lock);
> -			slab_destroy(searchp, slabp);
> -		} while (--tofree > 0);
> +			x = drain_freelist(searchp, l3, (l3->free_limit +
> +				5 * searchp->num - 1) / (5 * searchp->num));
> +			STATS_ADD_REAPED(searchp, x);

Maybe extract a local variable 'to_free' for readability.

						Pekka
