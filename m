Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbULHT6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbULHT6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbULHT6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:58:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63139 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261341AbULHT6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:58:11 -0500
Subject: Re: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
	 <1102533066.1281.81.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102535891.1281.148.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 11:58:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 11:20, Christoph Lameter wrote:
> On Wed, 8 Dec 2004, john stultz wrote:
> 
> > > > Points I'm glossing over for now:
> > > > ====================================================
> > > >
> > > > o ntp_scale(ns):  scales ns by NTP scaling factor
> > > > 	- see ntp.c for details
> > > > 	- costly, but correct.
> > >
> > > Please do not call this function from monotonic_clock but provide some
> > > sort of scaling factor that is adjusted from time to time.
> >
> > You're going to have to expand on this. I had considered only NTP
> > scaling the wall time, but for consistency it made more sense to me that
> > we also apply NTP scaling to the monotonic clock. This avoids different
> > notions of nanoseconds, one being the inaccurate unajusted system
> > nanoseconds and the other being the accurately ntp scaled wall time
> > nanoseconds. Trying to keep things sane.
> 
> It certainly is more consistent but its a big performance hit if that
> scaling is done on every invocation of clock_gettime or gettimeofday().
> 
> With the improved scaling factor one should be able to come very close to
> ntp scaled time without invoking ntp_scale itself. Tick processing will
> then update time to be ntp scaled by fine tuning the scaling factor (with
> the bit shifting we can get very fine tuning) and eventually skip a few
> nanoseconds. Its basically some piece of interpolator logic in there so
> that the heavyweight calculations can just be done once in a while.

No. I agree ntp_scale() is a performance concern. However I'm not sure
how your suggestion of just slowing or tweaking the timesource
mult/shift frequency values will allow us to implement the expected
behavior of adjtimex().  We need to be able to implement the following
adjustments within a single tick:

1. Adjust the frequency by 500ppm for 10usecs 
2. After that adjust the frequency by 30ppm for the rest of the tick.

We can see how much of this can be fudged or generalized, but I'm
hesitant to be too flippant about changing the NTP behavior for fear
that the astronomers who so dearly care about leap seconds and minute
time adjustments will "forget" to mention the asteroid heading towards
my home. :) 

I may have asked this before, but w/ 32 bit mult and shifts, how
granular can these adjustments be?

Also additional complications arise when we have multiple things (like
cpufreq) playing with the timesource frequency values as well. 


thanks again for the thorough review!
-john


