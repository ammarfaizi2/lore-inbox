Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUKPDVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUKPDVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 22:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKPDVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 22:21:33 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:33473 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261764AbUKPDVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 22:21:25 -0500
Date: Mon, 15 Nov 2004 19:21:24 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] prefer TSC over PM Timer
In-Reply-To: <1100569104.21267.58.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0411151843190.22091@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, john stultz wrote:

> I understand your frustration. 
> 
> While there are a great number of systems that can use the TSC, cpufreq
> scaling laptops, and a number of SMP and NUMA systems cannot use it as a
> time source. Additinoally its difficult to detect when its wrong as
> there are a reasonable number of systems that frequently miss timer
> ticks. Although it is much slower, ACPI PM is just more reliable across
> the broad spectrum of systems. 

i'm having a difficult time getting a centrino w/cpufreq to do anything 
bad with tsc while i'm imposing loads which cause the frequency to flutter 
around (i've got ondemand governor going).  maybe i need to do something 
more detailed like have ntp running against a solid time source while i do 
all these and let it run for longer to look for drift.  suggestions 
welcome.

> With your patch, ACPI PM would never be selected (as TSC always wins
> when available, and it will be available on all ACPI enabled i386
> systems). So its just the same as disabling CONFIG_X86_PM_TIMER, so why
> not just do that?

my patch lets you use "clock=pmtmr" if you want it.

> Do note, using the "clock=tsc" boot option, you can easily force the
> system to use the TSC.

right -- except i think the default is the opposite of what it should be 
for a generic kernel.  i think more systems are served better by using tsc 
than those that need clock=pm...  NUMA systems are rare (with custom 
kernels/etc), and if my experience with the centrino is valid then newer 
laptops aren't having this tsc/cpufreq problem.


> > note:  when timer_tsc discovers inaccuracy after boot it falls back to 
> > timer_pit ... timer_pit is twice as expensive as timer_pm, and it'd be 
> > cool if timer_tsc could fall back to timer_pm... but by that point in time 
> > all the __init stuff is gone, so i can't see how to init timer_pm.  this 
> > would be a more ideal solution.
> 
> Well, the lost-ticks/pit fallback code isn't all that robust. We have
> two unreliable time sources where we try to sort out which one is wrong
> by using the other. I worry we'd have to implement something like NTP in
> the kernel in order to correctly choose the best working time source.

yeah that does sound unfortunate... it's almost like we should initialize 
timer_pm whenever it is there so it can be used for these calibration 
purposes.


> I would however, support a patch that selected the TSC over the ACPI PM
> time source when CONFIG_CPUFREQ and CONFIG_SMP were N. That's fairly
> safe. 

i'm looking for a solution that generic distribution kernels can use...

honestly my selfish motivation is to get efficeon/crusoe treated properly 
-- they support a fixed TSC rate which does not vary with frequency (which 
many people fault us for, but the reality is that fixed TSC is the only 
viable solution for a processor which can vary power consumption without 
the involvement of the kernel).  i'd advocate a patch like the one 
below... but it feels wrong.

i suppose one way to solve all this is to punt the whole thing to userland
and let someone write a tool which either uses a database or runs code
to figure out which timer is best and sticks that into grub/lilo/whatever.

-dean


Signed-off-by: dean gaudet <dean@arctic.org>

--- linux-2.6.10-rc2/arch/i386/kernel/timers/timer_pm.c.orig	2004-11-15 23:28:30.000000000 -0800
+++ linux-2.6.10-rc2/arch/i386/kernel/timers/timer_pm.c	2004-11-16 03:05:52.000000000 -0800
@@ -107,6 +107,13 @@
 	if (!cpu_has_tsc)
 		return -ENODEV;
 
+	/*
+	 * Transmeta CPUs have a fixed rate TSC, so prefer tsc
+	 * unless the user specifically requests pmtmr.
+	 */
+	if (!override[0] && boot_cpu_data.x86_vendor == X86_VENDOR_TRANSMETA)
+		return -ENODEV;
+
 	/* "verify" this timing source */
 	value1 = read_pmtmr();
 	for (i = 0; i < 10000; i++) {
