Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbULNTYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbULNTYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULNTYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:24:04 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50869 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261608AbULNTX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:23:59 -0500
Subject: Re: dynamic-hz
From: john stultz <johnstul@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041214024625.GU16322@dualathlon.random>
References: <41BCD5F3.80401@kolivas.org>
	 <20041212234331.GO16322@dualathlon.random>
	 <cone.1102897095.171542.10669.502@pc.kolivas.org>
	 <20041213002751.GP16322@dualathlon.random>
	 <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
	 <20041213112853.GS16322@dualathlon.random>
	 <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
	 <20041213125844.GY16322@dualathlon.random>
	 <20041213191249.GB1052@elf.ucw.cz>
	 <1102970039.1281.415.camel@cog.beaverton.ibm.com>
	 <20041214024625.GU16322@dualathlon.random>
Content-Type: text/plain
Message-Id: <1103052246.1281.502.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 14 Dec 2004 11:24:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 18:46, Andrea Arcangeli wrote:
> On Mon, Dec 13, 2004 at 12:34:00PM -0800, john stultz wrote:
> > source (ie: the TSC or ACPIPM or HPET or whatever). Check out my
> 
> How long is the TSC calibration going to last before introducing visible
> errors? Is there any error introduced while we transfer the accuracy of
> the pit to the acuracy of the TSC during calibration? It would be much
> simpler to only use the TSC to provide system time, but I assume we
> would be already doing it, if it wasn't for the lost accuracy.

Well, the TSC is a terrible time source. Currently when interpolating,
the error between the TSC and the PIT allows for time inconsistencies. 
When using it as the sole timesource, accurate calibration does become
much more important, because we do accumulate the error.  However, NTP
or other methods of correcting for poor calibration or drift could be
used. 

I realize not everything can use NTP, but George Anzinger has some code
that would use the PIT to measure and adjust the TSC frequency values.
Unfortunately I haven't gotten around to looking at it yet.


> Plus are you already handling cpufreq changed every second by
> powersaved? Doesn't that introduce further inaccuracy in the system
> time?

Yea, my code currently doesn't have cpufreq hooks, but the cpufreq
notifier would act as an interrupt which would save off the accumulated
time at the old frequency and update the time source with the new
frequency.


> As for the lost-tick compensation, it's not working at all, my system
> goes as fast in the future as it would go in the past by disabling it.
> So the only effect I get by the lost tick compensation is that it's
> moving in the future instead of in the past, but the magnitude of the
> error is the same and in turn it's not working at all. The real bug is
> the USB irq handler that takes 3/4msec to execute and I get a constant
> load of those irqs from the adsl modem.

I agree. Fixing the irq handler is right solution.

thanks
-john

