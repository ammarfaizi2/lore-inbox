Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbULMUpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbULMUpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULMUmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:42:35 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62863 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262297AbULMUd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:33:58 -0500
Subject: Re: dynamic-hz
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213191249.GB1052@elf.ucw.cz>
References: <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <20041212234331.GO16322@dualathlon.random>
	 <cone.1102897095.171542.10669.502@pc.kolivas.org>
	 <20041213002751.GP16322@dualathlon.random>
	 <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
	 <20041213112853.GS16322@dualathlon.random>
	 <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
	 <20041213125844.GY16322@dualathlon.random>
	 <20041213191249.GB1052@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1102970039.1281.415.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Dec 2004 12:34:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 11:12, Pavel Machek wrote:
> Hi!
> 
> > > But that does not matter, right? Yes, one-shot timer will not fire
> > > exactly at right place, but as long as you are reading TSC and basing
> > > next shot on current time, error should not accumulate.
> > 
> > As said in the rest of the message, the error (or some other error)
> > accumulates heavily today in the tick-loss compensation/adjustment
> > algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical
> > about
> 
> I do not see how it should accumulate. Lets have working TSC. You want
> to emulate fixed-period timer with single-shot timer.

Its caused by the fact that we don't use the the TSC to accumulate time.
We are instead interpolating between timer ticks and the TSC, where the
timer tick is what really accumulates time, and the TSC is used for
inter-tick time keeping (with the exception of the lost tick
compensation code).

Unfortunately interrupt delay and queueing can cause situations where a
tick appears to be lost, but then immediately after a second one
appears. In this case we add two, compensating for the loss, and then
add one more.

One could try to catch these early-seeming ticks w/ similar compensation
code, but due to TSC calibration error there are sure to be holes where
more time inconsistencies could poke through. 

My feeling is that we need to stop interpolating and just trust one time
source (ie: the TSC or ACPIPM or HPET or whatever). Check out my
timeofday patches for more details.

thanks
-john



