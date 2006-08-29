Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWH2ABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWH2ABn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWH2ABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:01:43 -0400
Received: from helium.samage.net ([83.149.67.129]:58339 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S964905AbWH2ABm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:01:42 -0400
Message-ID: <3994.81.207.0.53.1156809691.squirrel@81.207.0.53>
In-Reply-To: <1156786344.23000.47.camel@twins>
References: <20060825153946.24271.42758.sendpatchset@twins> 
    <20060825153957.24271.6856.sendpatchset@twins> 
    <1396.81.207.0.53.1156559843.squirrel@81.207.0.53> 
    <1156760564.23000.31.camel@twins> 
    <3720.81.207.0.53.1156780999.squirrel@81.207.0.53>
    <1156786344.23000.47.camel@twins>
Date: Tue, 29 Aug 2006 02:01:31 +0200 (CEST)
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, August 28, 2006 19:32, Peter Zijlstra said:
> Also, I'm really past caring what the thing
> is called ;-) But if ppl object I guess its easy enough to run yet
> another sed command over the patches.

True, same here.

>> >> You can get rid of the memalloc_reserve and vmio_request_queues variables
>> >> if you want, they aren't really needed for anything. If using them reduces
>> >> the total code size I'd keep them though.
>> >
>> > I find my version easier to read, but that might just be the way my
>> > brain works.
>>
>> Maybe true, but I believe my version is more natural in the sense that it makes
>> more clear what the code is doing. Less bookkeeping, more real work, so to speak.
>
> Ok, I'll have another look at it, perhaps my gray matter has shifted ;-)

I don't care either way, just providing an alternative. I'd compile both and see
which one is smaller.


> Ah, no accident there, I'm fully aware that there would need to be a
> spinlock in adjust_memalloc_reserve() if there were another caller.
> (I even had it there for some time) - added comment.

Good that you're aware of it. Thing is, how much sense does the split-up into
adjust_memalloc_reserve() and sk_adjust_memalloc() make at this point? Why not
merge the code of adjust_memalloc_reserve() with sk_adjust_memalloc() and only
add adjust_memalloc_reserve() when it's really needed? It saves an export.

Feedback on the 28-Aug-2006 19:24 version from
programming.kicks-ass.net/kernel-patches/vm_deadlock/current/


> +void setup_per_zone_pages_min(void)
> +{
> +	static DEFINE_SPINLOCK(lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&lock, flags);
> +	__setup_per_zone_pages_min();
> +	spin_unlock_irqrestore(&lock, flags);
> +}

Better to put the lock next to min_free_kbytes, both for readability and
cache behaviour. And it satisfies the "lock data, not code" mantra.


> +static inline void * emergency_rx_alloc(size_t size, gfp_t gfp_mask)
> +{
> +	void * page = NULL;
> +
> +	if (size > PAGE_SIZE)
> +		return page;
> +
> +	if (atomic_add_unless(&emergency_rx_pages_used, 1, RX_RESERVE_PAGES)) {
> +		page = (void *)__get_free_page(gfp_mask);
> +		if (!page) {
> +			WARN_ON(1);
> +			atomic_dec(&emergency_rx_pages_used);
> +		}
> +	}
> +
> +	return page;
> +}

If you prefer to avoid cmpxchg (which is often used in atomic_add_unless
and can be expensive) then you can use something like:

static inline void * emergency_rx_alloc(size_t size, gfp_t gfp_mask)
{
	void * page;

	if (size > PAGE_SIZE)
		return NULL;

	if (atomic_inc_return(&emergency_rx_pages_used) == RX_RESERVE_PAGES)
		goto out;
	page = (void *)__get_free_page(gfp_mask);
	if (page)
		return page;
	WARN_ON(1);
out:
	atomic_dec(&emergency_rx_pages_used);
	return NULL;
}

The tiny race should be totally harmless. Both versions are a bit big
to inline though.


> @@ -195,6 +196,86 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
>  /* Maximal space eaten by iovec or ancilliary data plus some space */
>  int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
>
> +static DEFINE_SPINLOCK(memalloc_lock);
> +static int memalloc_reserve;
> +static unsigned int vmio_request_queues;
> +
> +atomic_t vmio_socks;
> +atomic_t emergency_rx_pages_used;
> +EXPORT_SYMBOL_GPL(vmio_socks);

Is this export needed? It's only used in net/core/skbuff.c and net/core/sock.c,
which are compiled into one module.

> +EXPORT_SYMBOL_GPL(emergency_rx_pages_used);

Same here. It's only used by code in sock.c and skbuff.c, and no external
code calls emergency_rx_alloc(), nor emergency_rx_free().

--

I think I depleted my usefulness, there isn't much left to say for me.
It's up to the big guys to decide about the merrit of this patch.
If Evgeniy's network allocator fixes all deadlocks and also has other
advantages, then great.

IMHO:

- This patch isn't really a framework, more a minimal fix for one specific,
though important problem. But it's small and doesn't have much impact
(numbers would be nice, e.g. vmlinux/modules size before and after, and
some network benchmark results).

- If Evgeniy's network allocator is as good as it looks, then why can't it
replace the existing one? Just adding private subsystem specific memory
allocators seems wrong. I might be missing the big picture, but it looks
like memory allocator things should be at least synchronized and discussed
with Christoph Lameter and his "modular slab allocator" patch.

All in all it seems it will take a while until Evgeniy's code will be merged,
so I think applying Peter's patch soonish and removing it again the moment it
becomes unnecessary is reasonable.

Greetings,

Indan


