Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbTCSARp>; Tue, 18 Mar 2003 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbTCSARp>; Tue, 18 Mar 2003 19:17:45 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:9601 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S262837AbTCSARi>;
	Tue, 18 Mar 2003 19:17:38 -0500
Date: Tue, 18 Mar 2003 16:27:33 -0800
From: Jerry Cooperstein <coop@axian.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, coop@axian.com
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew problems
Message-ID: <20030319002733.GB5351@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com> <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net> <20030318205907.GB4081@p3.attbi.com> <1048022686.6291.6.camel@dell_ss3.pdx.osdl.net> <20030318214101.GA4527@p3.attbi.com> <1048025052.6294.16.camel@dell_ss3.pdx.osdl.net> <20030318222313.GA4831@p3.attbi.com> <1048027027.6297.33.camel@dell_ss3.pdx.osdl.net> <20030318225801.GC4831@p3.attbi.com> <1048030151.6297.71.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048030151.6297.71.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 03:29:11PM -0800, Stephen Hemminger wrote:
.....
> On Tue, 2003-03-18 at 14:58, Jerry Cooperstein wrote:
> > I tried turning on SpeedStep (which I didn't think I had...) and
> > I got:
> > 
> > cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
> 
> Unfortunately, Intel SpeedStep is proprietary and they won't tell Linux
> how to manage it.  The best thing might be to figure out how to force kernel
> not to use TSC on this beast.
> 
> Can you take CONFIG_X86_TSC out of your config.  Then the kernel shouldn't
> use TSC.

Well if you remove CONFIG_X86_TSC out of your .config file, the kernel
build always puts it back in (i guess it believes it knows best).  So
i just used your patch below, and indeed it does work; clock speed is
now normal as is keyboard repeat rate. Immediate problem solved 
--but case not closed. 

I have to go back and clean out the earlier patches which didn't help
on their own, but I doubt they make a difference.  I'll leave it to you
to submit this as patch to the kernel, as I'm not sure it is solving
or hiding the problem.  But it works for me:>

At any rate, there is something in the seqlock stuff that broke this
stuff.  I'll keep trying to figure out exactly what.  

Thanks for all your hard work.  I appreciate it.

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================


> 
> Or try this patch and boot with "notsclock"
> 
> diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
> --- a/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 18 15:28:10 2003
> +++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 18 15:28:10 2003
> @@ -15,6 +15,7 @@
>  #include <asm/processor.h>
>  
>  int tsc_disable __initdata = 0;
> +static int tsc_clock_disable __initdata = 0;
>  
>  extern spinlock_t i8253_lock;
>  
> @@ -241,6 +242,13 @@
>  };
>  #endif
>  
> +/* Don't use TSC for time of day clock */
> +static int __init tsc_noclock_setup(char *str)
> +{
> +	tsc_clock_disable = 1;
> +	return 1;
> +}
> +__setup("notsclock", tsc_noclock_setup);
>  
>  static int init_tsc(void)
>  {
> @@ -273,7 +281,7 @@
>  	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
>  #endif
>  
> -	if (cpu_has_tsc) {
> +	if (cpu_has_tsc && !tsc_clock_disable) {
>  		unsigned long tsc_quotient = calibrate_tsc();
>  		if (tsc_quotient) {
>  			fast_gettimeoffset_quotient = tsc_quotient;
> 
