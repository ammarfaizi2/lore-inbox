Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270505AbUJUAdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbUJUAdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbUJUAaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:30:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8581 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270513AbUJUAZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:25:50 -0400
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4176FA29.2030208@mvista.com>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
	 <1098233967.20778.93.camel@cog.beaverton.ibm.com>
	 <41767B60.4050409@mvista.com>
	 <1098294178.20778.117.camel@cog.beaverton.ibm.com>
	 <4176FA29.2030208@mvista.com>
Content-Type: text/plain
Message-Id: <1098318323.20778.199.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 17:25:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 16:52, George Anzinger wrote:
> john stultz wrote:
> > On Wed, 2004-10-20 at 07:51, George Anzinger wrote:
> > 
> >>john stultz wrote:
> >>
> >>>I've begun to agree with you about this issue. It seems that until we
> >>>can catch every use of jiffies for time, doing one by one is going to
> >>>cause consistency problems.  So I'd support the full backout of the
> >>>do_posix_clock_monotonic_gettime changes to the proc interface. 
> >>>
> >>>George, would you protest this?
> >>
> >>It seems to me that if we do that we will stop making any changes at all.  I.e. 
> >>we will not see the rest of the "jiffies for time" code, as it will not "hurt" 
> >>any more.
> > 
> > 
> > Sorry, not sure I followed that. Could you explain further?
> 
> If we rip out the code folks will stop sending in bug reports on it.  Simple as 
> that.

So you feel that we're moving in the right direction, its just that its
going to take a few passes before everything smooths out? Thus its just
a continuation of the effort?

Tim? Is this OK with you, or you feel the immediate inconsistencies  and
bug reports aren't worth the effort?


> > So rather then every tick incrementing jiffies, instead jiffies is set
> > equal to (monotonic_clock()*HZ)/NSEC_PER_SEC. 
> 
> As mention by me (a long time ago), this assumes you have a better source for 
> the clock than the interrupt.  I would argue that on the x86 (which I admit is 
> really deficient) the best long term clock is, in fact, the PIT interrupt.  The 
> _best_ clock on the x86, IMHO, is one that used the PIT interrupt as the gold 
> standard.  Then one smooths this to eliminate interrupt latency issues and lost 
> ticks using the TSC.   The pm_timer is as good as the PIT but suffers from 
> access time issues.

Well, assuming the PIT is programmed to a value it can actually run at
accurately, you might be right. 

The only problem is I've started to arrive at the notion of
interpolation between multiple problematic timesources is just a rats
nest. When you can't trust timer interrupts to arrive and you can't
trust the TSC to run at the right frequency, there's no way to figure
out who's right.  We already have the lost-tick compensation code, but
we still get time inconsistencies. Now maybe I'm just too dim witted to
make it work, but the more I look at it, the more corner cases appear
and the uglier the code gets. 

I say pick a timesource you can trust on your machine and stick to it.
NTP is there to correct for drift, so just use it.

-john



