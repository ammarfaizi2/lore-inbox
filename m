Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUCRU4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUCRU4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:56:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40905 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262948AbUCRU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:56:46 -0500
Subject: [PATCH] linux-2.6.5-rc1_cpukhz-fix_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Cc: Karol Kozimor <sziwan@hell.org.pl>, dtor_core@ameritech.net,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040317095033.GA14983@dominikbrodowski.de>
References: <20040316182257.GA2734@dreamland.darkstar.lan>
	 <20040316194805.GC20014@picchio.gall.it>
	 <20040316214239.GA28289@hell.org.pl>
	 <1079479694.5408.47.camel@cog.beaverton.ibm.com>
	 <20040316233334.GA9001@dominikbrodowski.de>
	 <1079484413.5408.56.camel@cog.beaverton.ibm.com>
	 <20040317095033.GA14983@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1079643353.5408.62.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 12:55:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 01:50, Dominik Brodowski wrote:
> On Tue, Mar 16, 2004 at 04:46:54PM -0800, john stultz wrote:
> > On Tue, 2004-03-16 at 15:33, Dominik Brodowski wrote:
> > > On Tue, Mar 16, 2004 at 03:28:15PM -0800, john stultz wrote:
> > > > On Tue, 2004-03-16 at 13:42, Karol Kozimor wrote:
> > > > > Thus wrote Daniele Venzano:
> > > > > > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > > > > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > > > > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > > > > > issue seems cosmetic only, CPU frequency changes (watching
> > > > > > > temperature/battery life).
> > > > > > I can confirm, I'm seeing the same behavior. Please note that the
> > > > > > bogomips count gets updated, it's only the frequency that doesn't
> > > > > > change.
> > > > > 
> > > > > Same here with a P4-M, follow-up to John and Dmitry.
> > > > 
> > > > Hmm. This is untested, but I think this should do the trick.
> > > > 
> > > > Dominik: Is there any reason I'm not seeing why cpu_khz should only be
> > > > updated when using the TSC?
> > > 
> > > Is cpu_khz always correct (or, at least, nonzero) when we're reaching this 
> > > code path?
> > 
> > Using the PIT time source, cpu_khz is zero, so maybe it should be
> > conditional on if(cpu_khz)?
> 
> That will do the trick.

Patch below.

This small patch insures that cpu_khz is adjusted on cpufreq
notifications even when the tsc timesource is not in use. It fixes the
mostly cosmetic issue when using the ACPI PM timesource of /proc/cpuinfo
not being properly updated when cpu frequency was lowered. 

Please let me know if you have any additional feedback.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Mar 18 12:50:08 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Mar 18 12:50:08 2004
@@ -360,8 +360,9 @@
 		if (variable_tsc)
 			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 #ifndef CONFIG_SMP
-		if (use_tsc) {
+		if(cpu_khz)
 			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		if (use_tsc) {
 			if (variable_tsc) {
 				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
 				set_cyc2ns_scale(cpu_khz/1000);


