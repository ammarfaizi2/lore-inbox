Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbULHX4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbULHX4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbULHX4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:56:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51432 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261410AbULHXzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:55:55 -0500
Date: Wed, 8 Dec 2004 15:53:58 -0800 (PST)
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
In-Reply-To: <1102549009.1281.267.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com> 
 <1102533066.1281.81.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com> 
 <1102535891.1281.148.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
 <1102549009.1281.267.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, john stultz wrote:

> Take a look at the adjtimex man page as well as the ntp.c file from the
> timeofday core patch. There are number of different types of adjustments
> that are made, possibly at the same time. Briefly, they are (to my
> understanding - I'm going off my notes from awhile ago):
> o tick adjustments
> 	how much time should pass in a _user_ tick
> o frequency adjustments
> 	long term adjustment to correct for constant drift),
> o offset adjustments
> 	additional ppm adjustment to correct for current offset from the ntp
> server
> o single shot offset adjustments
> 	old style adjtime functionality
>
> Tick, frequency and offset adjustments can be precalculated and summed
> to a single ppm adjustment. This is similar to the style of adjustment
> you propose directly onto the time source frequency values.
>
> However, there is also this short term single shot adjustments. These
> adjustments are made by applying the MAX_SINGLESHOT_ADJ (500ppm) scaling
> for an amount of time (offset_len) which would compensate for the
> offset. This style is difficult because we cannot precompute it and
> apply it to an entire tick. Instead it needs to be applied for just a
> specific amount of time which may be only a fraction of a tick. When we
> start talking about systems with irregular tick frequency (via
> virtualization, or tickless systems) it becomes even more problematic.

We would need to schedule a special tick like event at a certain time but
otherwise I do not see a problem. Is there a requirement that these
"specific amounts of time" are less than 1 ms? The timer hardware (such as
the RTC clock) can generate an event in <200ns that could be used to
change the scaling. For a tickless system we would need to have such
scheduled events anyways.

> If this can be fudged then it becomes less of an issue. Or at worse, we
> have to do two mult/shift operations on two "parts" of the time interval
> using different adjustments.

That looks troublesome. Better avoid that.

> Its starting to look doable, but its not necessarily the simplest thing
> (for me at least). I'll put it on my list, but patches would be more
> then welcome.

I am still suffering from my limited NTP knowlege but will see what I can
do about this.
