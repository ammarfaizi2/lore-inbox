Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWC0Spy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWC0Spy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWC0Spy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:45:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42454 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750830AbWC0Spy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:45:54 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: sho@tnes.nec.co.jp, kiran@scalex86.org, akpm@osdl.org
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, Laurent.Vivier@bull.net
In-Reply-To: <20060325223358sho@rifu.tnes.nec.co.jp>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 27 Mar 2006 10:45:47 -0800
Message-Id: <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am wondering if we have (or plan to have) "long long " type of percpu
counters?  Andrew, Kiran, do you know?  

It seems right now the percpu counters are used mostly by ext2/3 for
filesystem free blocks accounting. Right now the counter is "long" type,
which is not enough if we want to extend the filesystem limit from 2**31
to 2**32 on 32 bit machine.

The patch from Takashi copies the whole percpu_count.h  and create a new
percpu_llcounter.h to support longlong type percpu counters. I am
wondering is there any better way for this?

Mingming

On Sat, 2006-03-25 at 22:33 +0900, sho@tnes.nec.co.jp wrote:

> As you said, the previous patches were broken because of my mailer,
> and part of them would be rejected.
> I'm re-sending them;  I have not changed them other than the mailer.
> Could you try new patches and check what happened?
> I have run fsx with these patches several times and the problems
> weren't reproduced.
> 
> Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
> ---
> diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/balloc.c linux-2.6.16-rc6-4g/fs/e
> xt3/balloc.c
> --- linux-2.6.16-rc6.org/fs/ext3/balloc.c	2006-03-14 09:09:00.000000000 +0900
> +++ linux-2.6.16-rc6-4g/fs/ext3/balloc.c	2006-03-14 09:29:01.000000000 +0900
> @@ -36,7 +36,6 @@
>   * when a file system is mounted (see ext3_read_super).
>   */
>  
> -
>  #define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
>  
>  struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
> @@ -467,7 +466,7 @@ do_more:
>  		cpu_to_le16(le16_to_cpu(desc->bg_free_blocks_count) +
>  			group_freed);
>  	spin_unlock(sb_bgl_lock(sbi, block_group));
> -	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
> +	percpu_llcounter_mod(&sbi->s_freeblocks_counter, count);
>  
>  	/* We dirtied the bitmap block */
>  	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
> @@ -1118,9 +1117,10 @@ out:

[...]
> diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/include/linux/percpu_llcounter.h linux-2.
> 6.16-rc6-4g/include/linux/percpu_llcounter.h
> --- linux-2.6.16-rc6.org/include/linux/percpu_llcounter.h	1970-01-01 09:00:00.000000000 +0900
> +++ linux-2.6.16-rc6-4g/include/linux/percpu_llcounter.h	2006-03-14 13:50:54.000000000 +0900
> @@ -0,0 +1,113 @@
> +#ifndef _LINUX_LLPERCPU_COUNTER_H
> +#define _LINUX_LLPERCPU_COUNTER_H
> +/*
> + * A simple "approximate counter" for use in ext2 and ext3 superblocks.
> + *
> + * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +#include <linux/threads.h>
> +#include <linux/percpu.h>
> +
> +#ifdef CONFIG_SMP
> +
> +struct percpu_llcounter {
> +	spinlock_t lock;
> +	long long count;
> +	long long *counters;
> +};
> +
> +#if NR_CPUS >= 16
> +#define FBC_BATCH	(NR_CPUS*2)
> +#else
> +#define FBC_BATCH	(NR_CPUS*4)
> +#endif
> +
> +static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
> +{
> +	spin_lock_init(&fbc->lock);
> +	fbc->count = 0;
> +	fbc->counters = alloc_percpu(long long);
> +}
> +
> +static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
> +{
> +	free_percpu(fbc->counters);
> +}
> +
> +void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount);
> +long long percpu_llcounter_sum(struct percpu_llcounter *fbc);
> +
> +static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
> +{
> +	return fbc->count;
> +}
> +
> +/*
> + * It is possible for the percpu_llcounter_read() to return a small negative
> + * number for some counter which should never be negative.
> + */
> +static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
> +{
> +	long long ret = fbc->count;
> +
> +	barrier();		/* Prevent reloads of fbc->count */
> +	if (ret > 0)
> +		return ret;
> +	return 1;
> +}
> +
> +#else
> +
> +struct percpu_llcounter {
> +	long long count;
> +};
> +
> +static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
> +{
> +	fbc->count = 0;
> +}
> +
> +static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
> +{
> +}
> +
> +static inline void
> +percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
> +{
> +	preempt_disable();
> +	fbc->count += amount;
> +	preempt_enable();
> +}
> +
> +static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
> +{
> +	return fbc->count;
> +}
> +
> +static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
> +{
> +	return fbc->count;
> +}
> +
> +static inline long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
> +{
> +	return percpu_llcounter_read_positive(fbc);
> +}
> +
> +#endif	/* CONFIG_SMP */
> +
> +static inline void percpu_llcounter_inc(struct percpu_llcounter *fbc)
> +{
> +	percpu_llcounter_mod(fbc, 1);
> +}
> +
> +static inline void percpu_llcounter_dec(struct percpu_llcounter *fbc)
> +{
> +	percpu_llcounter_mod(fbc, -1);
> +}
> +
> +#endif /* _LINUX_LLPERCPU_COUNTER_H */
> diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/mm/swap.c linux-2.6.16-rc6-4g/mm/swap.c
> --- linux-2.6.16-rc6.org/mm/swap.c	2006-03-14 09:09:07.000000000 +0900
> +++ linux-2.6.16-rc6-4g/mm/swap.c	2006-03-14 13:47:18.000000000 +0900
> @@ -26,6 +26,7 @@
>  #include <linux/buffer_head.h>	/* for try_to_release_page() */
>  #include <linux/module.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/percpu_llcounter.h>
>  #include <linux/percpu.h>
>  #include <linux/cpu.h>
>  #include <linux/notifier.h>
> @@ -498,6 +499,27 @@ void percpu_counter_mod(struct percpu_co
>  }
>  EXPORT_SYMBOL(percpu_counter_mod);
>  
> +void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
> +{
> +	long long count;
> +	long long *pcount;
> +	int cpu = get_cpu();
> +
> +	pcount = per_cpu_ptr(fbc->counters, cpu);
> +	count = *pcount + amount;
> +	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
> +		spin_lock(&fbc->lock);
> +		fbc->count += count;
> +		*pcount = 0;
> +		spin_unlock(&fbc->lock);
> +	} else {
> +		*pcount = count;
> +	}
> +	put_cpu();
> +}
> +EXPORT_SYMBOL(percpu_llcounter_mod);
> +
> +
>  /*
>   * Add up all the per-cpu counts, return the result.  This is a more accurate
>   * but much slower version of percpu_counter_read_positive()
> @@ -517,6 +539,26 @@ long percpu_counter_sum(struct percpu_co
>  	return ret < 0 ? 0 : ret;
>  }
>  EXPORT_SYMBOL(percpu_counter_sum);
> +
> +/*
> + * Add up all the per-cpu counts, return the result.  This is a more accurate
> + * but much slower version of percpu_llcounter_read_positive()
> + */
> +long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
> +{
> +	long long ret;
> +	int cpu;
> +
> +	spin_lock(&fbc->lock);
> +	ret = fbc->count;
> +	for_each_cpu(cpu) {
> +		long long *pcount = per_cpu_ptr(fbc->counters, cpu);
> +		ret += *pcount;
> +	}
> +	spin_unlock(&fbc->lock);
> +	return ret < 0 ? 0 : ret;
> +}
> +EXPORT_SYMBOL(percpu_llcounter_sum);
>  #endif
>  
>  /*
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

