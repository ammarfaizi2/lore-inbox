Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUJTVt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUJTVt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268892AbUJTVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:44:33 -0400
Received: from fmr11.intel.com ([192.55.52.31]:23761 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S268919AbUJTVnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:43:37 -0400
Subject: Re: gradual timeofday overhaul
From: Len Brown <len.brown@intel.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <1098292168.1429.96.camel@krustophenia.net>
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
	 <1098258460.26595.4320.camel@d845pe>
	 <1098292168.1429.96.camel@krustophenia.net>
Content-Type: text/plain
Organization: 
Message-Id: <1098308547.26605.4360.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 17:42:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:09, Lee Revell wrote:
> On Wed, 2004-10-20 at 03:47, Len Brown wrote:
> > The current design with HZ=1000 gives us 1ms = 1000usec between
> > clock ticks.  But some platforms take nearly that long just
> > to enter/exit low power states; which means that on Linux
> > the hardware pays a long idle state exit latency
> > (performance hit) but gets little or no power savings
> > from the time it resides in that idle state.
> 
> My testing shows that the timer interrupt runs for about 21 usec.
> That's 2.1% of its time just running the timer ISR!  No wonder this
> causes PM issues, 2.1% cpu load is not exactly an idle machine.  This
> is a 600Mhz C3, so on a slower embedded system this might be 5%.
> 
> So, any solution that would allow high res timers with Hz = 100 would
> be welcome.

5% residency in the clock tick handler is likely more of a problem when
we're _not_ idle -- a 5% performance hit.  When we're idle we've got
nothing better to do with the processor than run these instructions for
5% of the time and run no instructions 95% of the time -- so tick
handler residency isn't the problem in idle, tick frequency is the
problem.

When an interrupt occurrs, the hardware needs to ramp up its voltages,
resume its clocks and all the stuff it need to do to get out of the
power saving state to run the code that services the interrupt.  This
"exit latency" can take a long time.  On a volume Centrino system today
it is up to 185usec.  On other hardware it is as high as 1000 usec. 
Time spent in this exit latency is a double penalty -- we're not saving
power and we're delaying before the processor starts executing
instructions -- so we want to pay this price only when necessary.

-Len

