Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUEMRk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUEMRk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUEMRk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:40:26 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:12753 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264330AbUEMRkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:40:11 -0400
Date: Thu, 13 May 2004 19:39:46 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       rutger@tux.tmfweb.nl, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040513173946.GA8238@dominikbrodowski.de>
Mail-Followup-To: cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org, rutger@tux.tmfweb.nl, moqua@kurtenba.ch
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > So i'm not sure if throttling does work until now?
> 
> No, I think something is broken. There is something wrong, but I do
> not know what exactly. Maybe other people can help.
>
> Problem #1 is the speed measurement, as you described. As far as I
> understand, p4-clockmod delivers the same external clock to the P4,
> but work is not done during every clock tick. E.g. when running at
> 12.5% of the maximum frequency, only one tick in eight something is
> done.

Almost. The Time Stamp Counter (inside the CPU) works with a constant
frequency, but only at e.g. each eigth tick the other parts of the CPU do
some work.

> Ok, so if it is true that only the work is done part of the ticks,
> then all instructions should take more ticks! Therefore, I try to
> measure the number of ticks which the 'rdtsc' instruction itself
> takes. I take the minimum of 10 runs, to run
> instruction-cache-hot. See cpuclockmod.c .
> 
> This gives '140' cycles in the pre-modulated phase (including some
> overhead) when running on an idle system, and 154 or 161 running on a
> loaded system (1 thread busy looping). If clock modulation meant
> 'skipping ticks', I would expect this number to multiply.

Not necessarily. It's not really every eigth tick where work is done, but
more like 800 ticks where work is done, then 5600 ticks pause, and so on --
the frequency is somewhere in the docs, I forgot the exact value... So I'm
not 100% convinced the measurements you've done do show something broken.

> This doesn't change a thing, which is to be expected since cpufreq
> talks to real CPUs.

It should, something _is_ broken in this regard [and I'm working on it, just
had sent a RFC to the cpufreq mailing list...]. Maybe this causes some
strangeness, especially if you run a userspace cpufreq tool -- but maybe the
p4-clockmod hardware is even more strange than I thought it to be, and is
per _virtual_ CPU.

Can you please apply the latest cpufreq snapshot from
http://www.codemonkey.org.uk/projects/bitkeeper/cpufreq/
, then the attached patch, and switch the CPU frequencies of both (virtual)
CPUs around a bit, and after each switch, 
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq

and check whether the values are the same you wrote into the specific CPU's
scaling_setspeed [if using the userspace governor] file?

Many thanks,
	Dominik

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test_p4

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-05-13 16:52:02.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-05-13 19:36:47.629852152 +0200
@@ -68,11 +68,7 @@
 	cpus_allowed = current->cpus_allowed;
 
 	/* only run on CPU to be set, or on its sibling */
-#ifdef CONFIG_SMP
-	affected_cpu_map = cpu_sibling_map[cpu];
-#else
 	affected_cpu_map = cpumask_of_cpu(cpu);
-#endif
 	set_cpus_allowed(current, affected_cpu_map);
         BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 
@@ -273,11 +269,7 @@
 
 	/* only run on CPU to be set, or on its sibling */
 	cpus_allowed = current->cpus_allowed;
-#ifdef CONFIG_SMP
-        affected_cpu_map = cpu_sibling_map[cpu];
-#else
         affected_cpu_map = cpumask_of_cpu(cpu);
-#endif
 	set_cpus_allowed(current, affected_cpu_map);
         BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 

--lrZ03NoBR/3+SXJZ--
