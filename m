Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSJIKYs>; Wed, 9 Oct 2002 06:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261564AbSJIKYr>; Wed, 9 Oct 2002 06:24:47 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:51144 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261563AbSJIKYj> convert rfc822-to-8bit; Wed, 9 Oct 2002 06:24:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Christoph Hellwig <hch@sgi.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Wed, 9 Oct 2002 12:29:10 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200210072209.41880.efocht@ess.nec.de> <200210081933.06677.efocht@ess.nec.de> <20021008211513.A28583@sgi.com>
In-Reply-To: <20021008211513.A28583@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091229.10346.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

thanks for looking at this and the comments. Replies are below.

On Wednesday 09 October 2002 03:15, Christoph Hellwig wrote:
> On Tue, Oct 08, 2002 at 07:33:06PM +0200, Erich Focht wrote:
> diff -urNp a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
> --- a/arch/i386/kernel/smpboot.c	Fri Sep 27 23:49:54 2002
> +++ b/arch/i386/kernel/smpboot.c	Tue Oct  8 11:37:56 2002
> @@ -1194,6 +1194,11 @@ int __devinit __cpu_up(unsigned int cpu)
>  void __init smp_cpus_done(unsigned int max_cpus)
>  {
>  	zap_low_mappings();
> +#ifdef CONFIG_NUMA
> +	pooldata_lock();
> +	bld_pools();
> +	pooldata_unlock();
> +#endif
>
> All callers of bld_pools() need the pooldata lock - taking
> it inside that function makes the code a little more readable..
> Also I'd suggest to rename bld_pools() to build_pools() ;)
The separation is due to the needs of CPU hot-add. When integrating
with Kimi's CPU hotplug patch within the Atlas project, we found that
there was more to do in the scheduler blocked phase when adding one CPU
to the running system (besides recomputing the pools). Looking too far
into the future here...

> -	cache_decay_ticks = 10;	/* XXX base this on PAL info and cache-bandwidth
> estimate */ +	cache_decay_ticks = 8;	/* XXX base this on PAL info and
> cache-bandwidth estimate */
>
> Could you explain this change?  And it's affect on non-NUMA IA64
> machines?

At some stage I looked up the minimal timeslice and found it to be 10.
This means that when you have two tasks on a runqueue and zero on
another, you might see both tasks as absolutely cache-hot and cannot
steal any of them. The cache_decay_ticks is anyway a very rough
approximation. With the task_to_steal() selection from the patch this
change should have no significant impact because we make a ranking
and select the cache coolest task which slept more than 8ms. The default
O(1) behavior is to select the first task which slept more than 10ms,
without the ranking.

>  /**
> + * atomic_inc_return - increment atomic variable and return new value
> + * @v: pointer of type atomic_t
> + *
> + * Atomically increments @v by 1 and return it's new value.  Note that
> + * the guaranteed useful range of an atomic_t is only 24 bits.
> + */
> +static inline int atomic_inc_return(atomic_t *v){
> +	atomic_inc(v);
> +	return v->counter;
> +}
>
> Who do you guarantee this is atomic?  Please make it fit
> Documentation/CodyingStyle, btw..

This code comes from a port of the node affine scheduler done by
somebody from IBM for the 2.4.18 version. On IA64 we have really atomic
stuff for this operation. It's a quick hack for now. I not good in ia32
assembler and don't know how to replace it.

> +int numpools, pool_ptr[MAX_NUMNODES+1], pool_cpus[NR_CPUS],
> pool_nr_cpus[MAX_NUMNODES]; +unsigned long pool_mask[MAX_NUMNODES];
>
> Hmm, shouldn't those [MAX_NUMNODES] arrays be in some per-node array
> to avoid cacheline-bouncing?

They could be replicated but I don't think this is necessary. They
populate cachelines on each CPU. As these arrays are never changed,
there is no need for bouncing them. The cachelines on every CPU are
only invalidated when some CPU changes these array, which just doesn't
happen after boot (except you add a CPU, which you'll do rarely).

> +void pooldata_lock(void)
> +{
> +	int i;
> + retry:
> +	while (atomic_read(&pool_lock));
> +	if (atomic_inc_return(&pool_lock) > 1) {
> +		atomic_dec(&pool_lock);
> +		goto retry;
> +	}
>
> Why not a simple spin_lock()?

Actually we need something like write_lock and read_lock. But read_lock
counts the readers, therefore changes the lock and we get
cacheline-bouncing.

A spinlock here would be ok. Then the readers would need to do something
like  "while (spin_is_locked(pool_lock));". This only reads the lock
and (if nobody changes it) avoids cacheline bouncing. We still need to
check that all readers went out of the section where the pool data is
accessed (following ugly block)...

> +	/*
> +	 * Wait a while, any loops using pool data should finish
> +	 * in between. This is VERY ugly and should be replaced
> +	 * by some real RCU stuff. [EF]
> +	 */
> +	for (i=0; i<100; i++)
> +		udelay(1000);
>
> Urgg.  I'd suggest you switch to RCU now and make your patch apply
> ontop of it - another reason to apply the RCU core patch..

I agree (see the comment). I didn't replace it by RCU because RCU is
not in the mainline and it is easier to develop with an ugly but portable
replacement. But add this to the list of potential users of RCU.

> +void pooldata_unlock(void)
> +{
> +	atomic_dec(&pool_lock);
> +}
>
> Dito for spin_unlock.
>
> +	/* avoid deadlock by timer interrupt on own cpu */
> +	if (atomic_read(&pool_lock)) return;
>
> spin_trylock..
No! No trylock here, that would change the lock and lead to cacheline
bouncing! We don't need the lock, just make sure that the pooldata is not
beeing changed right now.

> All in all your code doesn't seem to be very cachelign-friendly,
> lots of global bouncing.  Do you have any numbers on what your
> patch changes for normal SMP configurations?

Once again: once the address of pool_lock is in the cache, I don't
expect any bouncing. The value of that lock almost never changes (except
in the boot phase and when you want to hot-add/remove a CPU), therefore
there is no reason for cache-line bouncing. The same applies for the
pool variables.

As you see, I thought a lot about cacheline bouncing and tried to avoid
it. I'll replace the pool_lock with a spin_lock, as the atomic_inc_return
for ia32 isn't really atomic, you're absolutely right here. As the
load balancing code is called pretty rarely (at most every 1ms, normally
every 250ms per CPU), additional cycles invested here are ok if the
benefit for NUMA is reasonable. If CONFIG_NUMA is undefined, the code
should be optimized by the compiler such that it looks like normal SMP
code. Still need some changes to get there, but that's not the big
problem.

Regards,
Erich

