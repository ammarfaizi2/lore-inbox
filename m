Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULHTWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULHTWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULHTWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:22:03 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:36283 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261326AbULHTV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:21:56 -0500
Date: Wed, 8 Dec 2004 11:20:30 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102533066.1281.81.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
 <1102533066.1281.81.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, john stultz wrote:

> > > Points I'm glossing over for now:
> > > ====================================================
> > >
> > > o ntp_scale(ns):  scales ns by NTP scaling factor
> > > 	- see ntp.c for details
> > > 	- costly, but correct.
> >
> > Please do not call this function from monotonic_clock but provide some
> > sort of scaling factor that is adjusted from time to time.
>
> You're going to have to expand on this. I had considered only NTP
> scaling the wall time, but for consistency it made more sense to me that
> we also apply NTP scaling to the monotonic clock. This avoids different
> notions of nanoseconds, one being the inaccurate unajusted system
> nanoseconds and the other being the accurately ntp scaled wall time
> nanoseconds. Trying to keep things sane.

It certainly is more consistent but its a big performance hit if that
scaling is done on every invocation of clock_gettime or gettimeofday().

With the improved scaling factor one should be able to come very close to
ntp scaled time without invoking ntp_scale itself. Tick processing will
then update time to be ntp scaled by fine tuning the scaling factor (with
the bit shifting we can get very fine tuning) and eventually skip a few
nanoseconds. Its basically some piece of interpolator logic in there so
that the heavyweight calculations can just be done once in a while.

> > In that case maybe the "ticks" are the timesource and not really tick
> > processing per se.
>
> If I understand you, yes. In this case the timer interrupt counter
> (jiffies) is used as a free running counter.
>
> > There could be a separation between "increment counter" and tick processing.
>
> Could you expand on this?

The timesource is really a memory location incremented by "increment
counter" and not part of tick processing.  Logically these are seperate.
"increment counter" could happen apart from tick processing.
They are just conflated in the current tick implementation.
