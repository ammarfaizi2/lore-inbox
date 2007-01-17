Return-Path: <linux-kernel-owner+w=401wt.eu-S932304AbXAQLFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbXAQLFz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 06:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbXAQLFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 06:05:55 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:55601 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbXAQLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 06:05:53 -0500
Date: Wed, 17 Jan 2007 03:05:22 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       suresh.b.siddha@intel.com, kenneth.w.chen@intel.com,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sched: improve sched_clock() on i686
Message-ID: <20070117110522.GD18499@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061222104306.GC1895@frankl.hpl.hp.com> <20061222121920.GA3809@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222121920.GA3809@elte.hu>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I see that this patch made it into -mm, so i am hoping it will
also show up in mainline fairly soon.

Thanks.


On Fri, Dec 22, 2006 at 01:19:20PM +0100, Ingo Molnar wrote:
> 
> * Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > The perfmon subsystems needs to compute per-CPU duration. It is using 
> > sched_clock() to provide this information. However, it seems they are 
> > big variations in the way sched_clock() is implemented for each 
> > architectures, especially in the accuracy of the returned value (going 
> > from TSC to jiffies).
> > 
> > Looking at the i386 implementation, it is not so clear to me what the 
> > actual goal of the function is. I was under the impression that this 
> > function was meant to compute per-CPU time deltas. This is how the 
> > scheduler seems to use it.
> > 
> > The x86-64 and i386 implementations are quite different. The i386 
> > comment about NUMA seems to contradict the initial goal of the 
> > function. Why is that?
> 
> it's purely historic - the i686 sched_clock() implementation predates 
> the scheduler's ability to deal with non-synchronous per-CPU clocks. I 
> tried to fix that (a year ago) and it didnt work out - but i've reviewed 
> my old patch and now realize what the mistake was - the patch below 
> should work better.
> 
> 	Ingo
> 
> ---------------------->
> Subject: [patch] sched: improve sched_clock() on i686
> From: Ingo Molnar <mingo@elte.hu>
> 
> this patch cleans up sched_clock() on i686: it will use the TSC if 
> available and falls back to jiffies only if the user asked for it to be 
> disabled via notsc or the CPU calibration code didnt figure out the 
> right cpu_khz.
> 
> this generally makes the scheduler timestamps more finegrained, on all 
> hardware. (the current scheduler is pretty resistant against 
> asynchronous sched_clock() values on different CPUs, it will allow at 
> most up to a jiffy of jitter.)
> 
> also simplify sched_clock()'s check for TSC availability: propagate the 
> desire and ability to use the TSC into the tsc_disable flag, previously 
> this flag only indicated whether the notsc option was passed. This makes 
> the rare low-res sched_clock() codepath a single branch off a 
> read-mostly flag.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/i386/kernel/tsc.c |   22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> Index: linux/arch/i386/kernel/tsc.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/tsc.c
> +++ linux/arch/i386/kernel/tsc.c
> @@ -108,13 +108,10 @@ unsigned long long sched_clock(void)
>  	unsigned long long this_offset;
>  
>  	/*
> -	 * in the NUMA case we dont use the TSC as they are not
> -	 * synchronized across all CPUs.
> +	 * Fall back to jiffies if there's no TSC available:
>  	 */
> -#ifndef CONFIG_NUMA
> -	if (!cpu_khz || check_tsc_unstable())
> -#endif
> -		/* no locking but a rare wrong value is not a big deal */
> +	if (unlikely(tsc_disable))
> +		/* No locking but a rare wrong value is not a big deal: */
>  		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
>  
>  	/* read the Time Stamp Counter: */
> @@ -194,13 +191,13 @@ EXPORT_SYMBOL(recalibrate_cpu_khz);
>  void __init tsc_init(void)
>  {
>  	if (!cpu_has_tsc || tsc_disable)
> -		return;
> +		goto out_no_tsc;
>  
>  	cpu_khz = calculate_cpu_khz();
>  	tsc_khz = cpu_khz;
>  
>  	if (!cpu_khz)
> -		return;
> +		goto out_no_tsc;
>  
>  	printk("Detected %lu.%03lu MHz processor.\n",
>  				(unsigned long)cpu_khz / 1000,
> @@ -208,6 +205,15 @@ void __init tsc_init(void)
>  
>  	set_cyc2ns_scale(cpu_khz);
>  	use_tsc_delay();
> +	return;
> +
> +out_no_tsc:
> +	/*
> +	 * Set the tsc_disable flag if there's no TSC support, this
> +	 * makes it a fast flag for the kernel to see whether it
> +	 * should be using the TSC.
> +	 */
> +	tsc_disable = 1;
>  }
>  
>  #ifdef CONFIG_CPU_FREQ

-- 

-Stephane
