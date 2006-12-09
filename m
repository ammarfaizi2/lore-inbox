Return-Path: <linux-kernel-owner+w=401wt.eu-S1759074AbWLIFqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074AbWLIFqi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 00:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759076AbWLIFqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 00:46:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47429 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759064AbWLIFqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 00:46:37 -0500
Date: Fri, 8 Dec 2006 21:46:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] group xtime, xtime_lock, wall_to_monotonic, avenrun,
 calc_load_count fields together in ktimed
Message-Id: <20061208214625.90e010ae.akpm@osdl.org>
In-Reply-To: <200612081752.09749.dada1@cosmosbay.com>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<457849E2.3080909@garzik.org>
	<20061207095715.0cafffb9.akpm@osdl.org>
	<200612081752.09749.dada1@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 17:52:09 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> This patch introduces a new structure called ktimed (Kernel Time Data), where 
> some time keeping related variables are put together to share as few cache 
> lines as possible. This avoid some false sharing, (since linker could put 
> calc_load_count in a *random* cache line for example)
> 
> I also optimized calc_load() to not always call count_active_tasks() :
> It should call it only once every 5 seconds (LOAD_FREQ=5*HZ)
> 
> Note : x86_64 was using an arch specific placement of __xtime and __xtime_lock 
> (see arch/x86_64/kernel/vmlinux.lds.S). (vsyscall stuff)
> It is now using a specific placement of __ktimed, since xtime and xtime_lock 
> are now fields from __ktimed.
> 
> Note : I failed to move jiffies64 as well in ktimed : too many changes needed 
> because of jiffies aliasing (and endianess), but it could be done.
> 

Sounds like you have about three patches there.

<save attachment, read from file, s/^/> />

>  
> -extern struct timespec xtime;
> -extern struct timespec wall_to_monotonic;
> -extern seqlock_t xtime_lock;
> +/*
> + * define a structure to keep all fields close to each others.
> + */
> +struct ktimed_struct {
> +	struct timespec _xtime;
> +	struct timespec wall_to_monotonic;
> +	seqlock_t lock;
> +	unsigned long avenrun[3];
> +	int calc_load_count;
> +};

crappy name, but I guess it doesn't matter as nobody will use it at this
stage.  But...

> +extern struct ktimed_struct ktimed;
> +#define xtime             ktimed._xtime
> +#define wall_to_monotonic ktimed.wall_to_monotonic
> +#define xtime_lock        ktimed.lock
> +#define avenrun           ktimed.avenrun

They'll use these instead.

Frankly, I think we'd be better off removing these macros and, longer-term,
use

	write_seqlock(time_data.xtime_lock);

The approach you have here would be a good transition-period thing.

>  void timekeeping_init(void);
>  
> --- linux-2.6.19/kernel/timer.c	2006-12-08 11:50:11.000000000 +0100
> +++ linux-2.6.19-ed/kernel/timer.c	2006-12-08 18:13:24.000000000 +0100
> @@ -570,11 +570,13 @@ found:
>   * however, we will ALWAYS keep the tv_nsec part positive so we can use
>   * the usual normalization.
>   */
> -struct timespec xtime __attribute__ ((aligned (16)));
> -struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
> -
> -EXPORT_SYMBOL(xtime);
> -
> +#ifndef ARCH_HAVE_KTIMED

argh, another ARCH_HAVE_MESS.  Due to the x86_64 vsyscall code.

Could you please see if we can nuke this by making
kernel/timer.c:xtime_lock use attribute(weak)?  In a separate patch ;)

> +struct ktimed_struct ktimed __cacheline_aligned = {
> +	.lock = __SEQLOCK_UNLOCKED(ktimed.lock),
> +	.calc_load_count = LOAD_FREQ,
> +};
> +EXPORT_SYMBOL(ktimed);
> +#endif
>  
>  /* XXX - all of this timekeeping code should be later moved to time.c */
>  #include <linux/clocksource.h>
> @@ -995,9 +997,6 @@ static unsigned long count_active_tasks(
>   *
>   * Requires xtime_lock to access.
>   */
> -unsigned long avenrun[3];
> -
> -EXPORT_SYMBOL(avenrun);
>  
>  /*
>   * calc_load - given tick count, update the avenrun load estimates.
> @@ -1006,27 +1005,21 @@ EXPORT_SYMBOL(avenrun);
>  static inline void calc_load(unsigned long ticks)
>  {
>  	unsigned long active_tasks; /* fixed-point */
> -	static int count = LOAD_FREQ;
>  
> -	active_tasks = count_active_tasks();
> -	for (count -= ticks; count < 0; count += LOAD_FREQ) {
> -		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> -		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> -		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> +	ktimed.calc_load_count -= ticks;
> +
> +	if (unlikely(ktimed.calc_load_count < 0)) {
> +		active_tasks = count_active_tasks();
> +		do {
> +			ktimed.calc_load_count += LOAD_FREQ;
> +			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
> +			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
> +			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
> +		} while (ktimed.calc_load_count < 0);
>  	}
>  }
>  
> ...
>
> +extern struct ktimed_struct __ktimed;
> +#define __xtime_lock __ktimed.lock
> +#define __xtime      __ktimed._xtime
>  
>  /* kernel space (writeable) */
>  extern struct vxtime_data vxtime;
>  extern int vgetcpu_mode;
>  extern struct timezone sys_tz;
>  extern int sysctl_vsyscall;
> -extern seqlock_t xtime_lock;
>  
> -extern int sysctl_vsyscall;
> -
> -#define ARCH_HAVE_XTIME_LOCK 1
> +#define ARCH_HAVE_KTIMED 1
>  

hm, the patch seems to transform a mess into a mess.  I guess it's a messy
problem.

I agree that aggregating all the time-related things into a struct like
this makes some sense.  As does aggregating them all into a similar-looking
namespace, but that'd probably be too intrusive - too late for that.


