Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbULHXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbULHXgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbULHXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:36:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35541 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261405AbULHXge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:36:34 -0500
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
In-Reply-To: <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
	 <1102533066.1281.81.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
	 <1102535891.1281.148.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102549009.1281.267.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 15:36:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 12:14, Christoph Lameter wrote:
> On Wed, 8 Dec 2004, john stultz wrote:
> > > With the improved scaling factor one should be able to come very close to
> > > ntp scaled time without invoking ntp_scale itself. Tick processing will
> > > then update time to be ntp scaled by fine tuning the scaling factor (with
> > > the bit shifting we can get very fine tuning) and eventually skip a few
> > > nanoseconds. Its basically some piece of interpolator logic in there so
> > > that the heavyweight calculations can just be done once in a while.
> >
> > No. I agree ntp_scale() is a performance concern. However I'm not sure
> > how your suggestion of just slowing or tweaking the timesource
> > mult/shift frequency values will allow us to implement the expected
> > behavior of adjtimex().  We need to be able to implement the following
> > adjustments within a single tick:
> >
> > 1. Adjust the frequency by 500ppm for 10usecs
> > 2. After that adjust the frequency by 30ppm for the rest of the tick.
> 
> Frequency adjustments just means an adjustment of the scaling factor.
> Am I missing something?
> 
> > We can see how much of this can be fudged or generalized, but I'm
> > hesitant to be too flippant about changing the NTP behavior for fear
> > that the astronomers who so dearly care about leap seconds and minute
> > time adjustments will "forget" to mention the asteroid heading towards
> > my home. :)
> 
> I am not sure what NTP behavior needs to be fudged. Sorry about my limited
> NTP knowledge. Could you elaborate on what the problem is?

Take a look at the adjtimex man page as well as the ntp.c file from the
timeofday core patch. There are number of different types of adjustments
that are made, possibly at the same time. Briefly, they are (to my
understanding - I'm going off my notes from awhile ago): 
o tick adjustments
	how much time should pass in a _user_ tick
o frequency adjustments
	long term adjustment to correct for constant drift), 
o offset adjustments
	additional ppm adjustment to correct for current offset from the ntp
server
o single shot offset adjustments 
	old style adjtime functionality

Tick, frequency and offset adjustments can be precalculated and summed
to a single ppm adjustment. This is similar to the style of adjustment
you propose directly onto the time source frequency values. 

However, there is also this short term single shot adjustments. These
adjustments are made by applying the MAX_SINGLESHOT_ADJ (500ppm) scaling
for an amount of time (offset_len) which would compensate for the
offset. This style is difficult because we cannot precompute it and
apply it to an entire tick. Instead it needs to be applied for just a
specific amount of time which may be only a fraction of a tick. When we
start talking about systems with irregular tick frequency (via
virtualization, or tickless systems) it becomes even more problematic. 

If this can be fudged then it becomes less of an issue. Or at worse, we
have to do two mult/shift operations on two "parts" of the time interval
using different adjustments.

Its starting to look doable, but its not necessarily the simplest thing
(for me at least). I'll put it on my list, but patches would be more
then welcome. 

thanks
-john



