Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUCPXbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUCPXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:31:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:56977 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261824AbUCPXbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:31:38 -0500
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
From: john stultz <johnstul@us.ibm.com>
To: Karol Kozimor <sziwan@hell.org.pl>, Dominik Brodowski <linux@brodo.de>
Cc: dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040316214239.GA28289@hell.org.pl>
References: <20040316182257.GA2734@dreamland.darkstar.lan>
	 <20040316194805.GC20014@picchio.gall.it>
	 <20040316214239.GA28289@hell.org.pl>
Content-Type: text/plain
Message-Id: <1079479694.5408.47.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Mar 2004 15:28:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 13:42, Karol Kozimor wrote:
> Thus wrote Daniele Venzano:
> > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > issue seems cosmetic only, CPU frequency changes (watching
> > > temperature/battery life).
> > I can confirm, I'm seeing the same behavior. Please note that the
> > bogomips count gets updated, it's only the frequency that doesn't
> > change.
> 
> Same here with a P4-M, follow-up to John and Dmitry.

Hmm. This is untested, but I think this should do the trick.

Dominik: Is there any reason I'm not seeing why cpu_khz should only be
updated when using the TSC?

thanks
-john

===== arch/i386/kernel/timers/timer_tsc.c 1.36 vs edited =====
--- 1.36/arch/i386/kernel/timers/timer_tsc.c	Tue Feb  3 21:35:49 2004
+++ edited/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 16 15:23:49 2004
@@ -360,8 +360,8 @@
 		if (variable_tsc)
 			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 #ifndef CONFIG_SMP
+		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		if (use_tsc) {
-			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 			if (variable_tsc) {
 				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
 				set_cyc2ns_scale(cpu_khz/1000);


