Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUKPBiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUKPBiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKPBiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:38:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42455 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261745AbUKPBiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:38:16 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: john stultz <johnstul@us.ibm.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
Content-Type: text/plain
Message-Id: <1100569104.21267.58.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Nov 2004 17:38:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-15 at 16:23, dean gaudet wrote:
> i've heard other folks have independently run into this problem -- in fact 
> i see the most recent fc2 kernels already do this.  i'd like this to be 
> accepted into the main kernel though.
> 
> the x86 PM Timer is an order of magnitude slower than the TSC for 
> gettimeofday calls.  i'm seeing 8%+ of the time spent doing gettimeofday 
> in someworkloads... and apparently kernel.org was seeing 80% of its time 
> go to gettimeofday during the fc3-release overload.  PM timer is also less 
> accurate than TSC.
> 
> i can see a vague argument around cpufreq / tsc troubles, but i'm having a 
> hell of a time getting a centrino box to show any TSC troubles even while 
> i induce workloads that cause cpufreq to bounce the frequency around.  
> maybe someone could give an example of it failing...

I understand your frustration. 

While there are a great number of systems that can use the TSC, cpufreq
scaling laptops, and a number of SMP and NUMA systems cannot use it as a
time source. Additinoally its difficult to detect when its wrong as
there are a reasonable number of systems that frequently miss timer
ticks. Although it is much slower, ACPI PM is just more reliable across
the broad spectrum of systems. 

With your patch, ACPI PM would never be selected (as TSC always wins
when available, and it will be available on all ACPI enabled i386
systems). So its just the same as disabling CONFIG_X86_PM_TIMER, so why
not just do that?

Do note, using the "clock=tsc" boot option, you can easily force the
system to use the TSC.

> note:  when timer_tsc discovers inaccuracy after boot it falls back to 
> timer_pit ... timer_pit is twice as expensive as timer_pm, and it'd be 
> cool if timer_tsc could fall back to timer_pm... but by that point in time 
> all the __init stuff is gone, so i can't see how to init timer_pm.  this 
> would be a more ideal solution.

Well, the lost-ticks/pit fallback code isn't all that robust. We have
two unreliable time sources where we try to sort out which one is wrong
by using the other. I worry we'd have to implement something like NTP in
the kernel in order to correctly choose the best working time source.

I would however, support a patch that selected the TSC over the ACPI PM
time source when CONFIG_CPUFREQ and CONFIG_SMP were N. That's fairly
safe. 

thanks
-john

