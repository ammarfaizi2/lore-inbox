Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSHICnE>; Thu, 8 Aug 2002 22:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSHICnE>; Thu, 8 Aug 2002 22:43:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20626 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318123AbSHICnC>;
	Thu, 8 Aug 2002 22:43:02 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
References: <1028771615.22918.188.camel@cog> 
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Aug 2002 19:30:46 -0700
Message-Id: <1028860246.1117.34.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 06:17, Alan Cox wrote:
> On Thu, 2002-08-08 at 02:53, john stultz wrote:
> > already seen on another cpu. This patch allows people compiling w/
> > 'Multi-node NUMA support' to pass "notsc" or "bad-tsc" as boot
> > parameters. "notsc" disables rdtsc calls, and forces the kernel to use
> > the PIT for gettimeofday calucluations (as normally expected w/ i386
> > compiled kernels). While "bad-tsc" forces the kernel to use the PIT for
> > gettimeofday, but does not disable TSC access. 
> 
> I've done a version of this for -ac which uses the NUMA autodetect, and
> also provides the hook so I can disable tsc on split on x86 smp with
> variable multipliers some time. The only comment I really have is please

Not sure I followed that, do you mean per-cpu TSC management for
gettimeofday? 

> use "badtsc" not "bad-tsc" - to match "notsc"

Sounds good. Changed in my tree.

 
> This is how I did it - barring the code that is -ac specific to automatically flip
> the mode when NUMA hw is detected

Interesting. See my comments below.  Auto-detection has been on my list
for the last week, so I'm eagerly awaiting a peek at the next ac release
:)


> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.20pre1/include/asm-i386/processor.h linux.20pre1-ac2/include/asm-i386/processor.h
> --- linux.20pre1/include/asm-i386/processor.h	2002-08-06 15:40:34.000000000 +0100
> +++ linux.20pre1-ac2/include/asm-i386/processor.h	2002-08-07 15:23:39.000000000 +0100
> @@ -96,7 +96,7 @@
>  
>  extern void identify_cpu(struct cpuinfo_x86 *);
>  extern void print_cpu_info(struct cpuinfo_x86 *);
> -extern void dodgy_tsc(void);
> +extern int dodgy_tsc(void);
>  
>  /*
>   * EFLAGS bits
> --- linux.vanilla/arch/i386/kernel/time.c	2002-02-25 19:37:53.000000000 +0000
> +++ linux.20pre1-ac2/arch/i386/kernel/time.c	2002-08-08 12:56:48.000000000 +0100
> @@ -666,9 +666,7 @@
>   	 *	moaned if you have the only one in the world - you fix it!
>   	 */
>   
> - 	dodgy_tsc();
> - 	
> -	if (cpu_has_tsc) {
> +	if (!dodgy_tsc()) {
>  		unsigned long tsc_quotient = calibrate_tsc();
>  		if (tsc_quotient) {
>  			fast_gettimeoffset_quotient = tsc_quotient;


Hmmm. Putting some of the checks into dodgy_tsc does clean some of this
up, maybe a new name is needed for it? Also by not executing this block
of code when we have TSCs that are not synced, we don't calculate
cpu_khz, which is used by the O(1) sched in 2.5 for cpu affinity. True
the TSCs could be wack (and really, we're only using one of them), but
can't we still trust them enough for this rough estimate?


> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.20pre1/arch/i386/kernel/setup.c linux.20pre1-ac2/arch/i386/kernel/setup.c
> --- linux.20pre1/arch/i386/kernel/setup.c	2002-08-06 15:41:42.000000000 +0100
> +++ linux.20pre1-ac2/arch/i386/kernel/setup.c	2002-08-07 15:23:29.000000000 +0100
> @@ -1193,19 +1126,51 @@
>  }
>  __setup("cachesize=", cachesize_setup);
>  
> -
>  #ifndef CONFIG_X86_TSC
> +
>  static int tsc_disable __initdata = 0;
>  
> -static int __init tsc_setup(char *str)
> +void disable_tsc(void)
> +{
> +	if(tsc_disable == 0)
> +	{
> +		printk(KERN_INFO "Disabling use of TSC for time counting.\n");
> +		tsc_disable = 1;
> +	}
> +}
> +
> +/* Disable TSC on processor and also for get time of day */
> +
> +static int __init notsc_setup(char *str)
> +{
> +	tsc_disable = 2;
> +	return 1;
> +}
> +
> +__setup("notsc", notsc_setup);

Overloading the tsc_disable variable does let us have one less variable
around, but makes the code a little less intuitive. Looking over the
patch I get mixed up which value means what. Maybe just an enum might
help?


> +/* Allow TSC use but don't use it for gettimeofday  */
> +
> +static int __init badtsc_setup(char *str)
>  {
>  	tsc_disable = 1;
>  	return 1;
>  }
>  
> -__setup("notsc", tsc_setup);
> +__setup("badtsc", badtsc_setup);
> +
> +#else
> +
> +#define tsc_disable	0
> +
> +void disable_tsc(void)
> +{
> +	panic("Time stamp counter required by this kernel, but not supported by the hardware.\n");
> +}
> +
>  #endif

Hmm, I kind of like this. I'm thinking there should also be some sort of
error when the user passes bad/notsc to an optimized the kernel, rather
then just ignoring the boot option. I'll add that to my tree.
 

Thanks for all the feedback! Can't wait to see the next -ac.
-john


