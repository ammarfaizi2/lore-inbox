Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUENVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUENVq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUENVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:46:57 -0400
Received: from wingding.demon.nl ([82.161.27.36]:4736 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S261865AbUENVqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:46:52 -0400
Date: Fri, 14 May 2004 23:47:51 +0200
From: rutger@nospam.com
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040514214751.GA8433@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20040513173946.GA8238@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513173946.GA8238@dominikbrodowski.de>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Problem #1 is the speed measurement, as you described. As far as I
> > understand, p4-clockmod delivers the same external clock to the P4,
> > but work is not done during every clock tick. E.g. when running at
> > 12.5% of the maximum frequency, only one tick in eight something is
> > done.
> 
> Almost. The Time Stamp Counter (inside the CPU) works with a constant
> frequency, but only at e.g. each eigth tick the other parts of the CPU do
> some work.

That's what I meant.

> 
> > Ok, so if it is true that only the work is done part of the ticks,
> > then all instructions should take more ticks! Therefore, I try to
> > measure the number of ticks which the 'rdtsc' instruction itself
> > takes. I take the minimum of 10 runs, to run
> > instruction-cache-hot. See cpuclockmod.c .
> > 
> > This gives '140' cycles in the pre-modulated phase (including some
> > overhead) when running on an idle system, and 154 or 161 running on a
> > loaded system (1 thread busy looping). If clock modulation meant
> > 'skipping ticks', I would expect this number to multiply.
> 
> Not necessarily. It's not really every eigth tick where work is done, but
> more like 800 ticks where work is done, then 5600 ticks pause, and so on --
> the frequency is somewhere in the docs, I forgot the exact value... So I'm
> not 100% convinced the measurements you've done do show something broken.

Ah, ok! This makes the measurement next to impossible. Unless we
generate instructions of ~900 ticks, which should takes 900 + 5600
ticks in case of modulated clock, and 900 ticks in case of
non-modulated clock. Something to try...

> > This doesn't change a thing, which is to be expected since cpufreq
> > talks to real CPUs.
> 
> It should, something _is_ broken in this regard [and I'm working on it, just
> had sent a RFC to the cpufreq mailing list...]. Maybe this causes some
> strangeness, especially if you run a userspace cpufreq tool -- but maybe the
> p4-clockmod hardware is even more strange than I thought it to be, and is
> per _virtual_ CPU.
> 
> Can you please apply the latest cpufreq snapshot from
> http://www.codemonkey.org.uk/projects/bitkeeper/cpufreq/
> , then the attached patch, and switch the CPU frequencies of both (virtual)
> CPUs around a bit, and after each switch, 
> cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq
> 
> and check whether the values are the same you wrote into the specific CPU's
> scaling_setspeed [if using the userspace governor] file?

Ok, I applied both patches.

root@localhost /sys/devices/system/cpu/cpu0/cpufreq# cat scaling_available_frequencies 
350000 700000 1050000 1400000 1750000 2100000 2450000 2800000 
root@localhost /sys/devices/system/cpu/cpu0/cpufreq# for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat scaling_cur_freq ; done
350000
700000
1050000
1400000
1750000
2100000
2450000
2800000

Seems to work...

Some remarks:
 - scaling_governor and scaling_setspeed get length 0 after echo-ing to.
   Other files keep the virtual size of 4096.

 - scaling seems to work reliable now _if_ I repeat the scaling for
   each virtual processor and make them the same. It doesn't do
   anything useful if I only set cpu0.

 - It's far more repeatable now. If I set the speed of virtual CPU0,
   it really sets it, and only sets CPU0, and not like previously only
   in 50% of the cases or so.


However, what's the use of p4-clockmod if it doesn't have impact on
the temperature and the power consumption of the CPU?

My Asus p4p800 seems to be able to set several voltages and frequences
in the BIOS; can those be set runtime? And/or is there any
documentation on this? This would make for a much more useful driver.

Thanks!


> 
> Many thanks,
> 	Dominik

> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-05-13 16:52:02.000000000 +0200
> +++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-05-13 19:36:47.629852152 +0200
> @@ -68,11 +68,7 @@
>  	cpus_allowed = current->cpus_allowed;
>  
>  	/* only run on CPU to be set, or on its sibling */
> -#ifdef CONFIG_SMP
> -	affected_cpu_map = cpu_sibling_map[cpu];
> -#else
>  	affected_cpu_map = cpumask_of_cpu(cpu);
> -#endif
>  	set_cpus_allowed(current, affected_cpu_map);
>          BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
>  
> @@ -273,11 +269,7 @@
>  
>  	/* only run on CPU to be set, or on its sibling */
>  	cpus_allowed = current->cpus_allowed;
> -#ifdef CONFIG_SMP
> -        affected_cpu_map = cpu_sibling_map[cpu];
> -#else
>          affected_cpu_map = cpumask_of_cpu(cpu);
> -#endif
>  	set_cpus_allowed(current, affected_cpu_map);
>          BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
>  


-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
