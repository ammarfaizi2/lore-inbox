Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbULIARX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbULIARX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbULIARX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:17:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55452 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261414AbULIARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:17:16 -0500
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
In-Reply-To: <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
	 <1102533066.1281.81.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
	 <1102535891.1281.148.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
	 <1102549009.1281.267.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102551441.1281.286.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 16:17:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 15:53, Christoph Lameter wrote:
> On Wed, 8 Dec 2004, john stultz wrote:
> > However, there is also this short term single shot adjustments. These
> > adjustments are made by applying the MAX_SINGLESHOT_ADJ (500ppm) scaling
> > for an amount of time (offset_len) which would compensate for the
> > offset. This style is difficult because we cannot precompute it and
> > apply it to an entire tick. Instead it needs to be applied for just a
> > specific amount of time which may be only a fraction of a tick. When we
> > start talking about systems with irregular tick frequency (via
> > virtualization, or tickless systems) it becomes even more problematic.
> 
> We would need to schedule a special tick like event at a certain time but
> otherwise I do not see a problem. Is there a requirement that these
> "specific amounts of time" are less than 1 ms? The timer hardware (such as
> the RTC clock) can generate an event in <200ns that could be used to
> change the scaling. For a tickless system we would need to have such
> scheduled events anyways.

Eh, I'd like to not to be dependent on event accuracy/frequency. Lets
see if we can do it w/o scheduling events. 

> > If this can be fudged then it becomes less of an issue. Or at worse, we
> > have to do two mult/shift operations on two "parts" of the time interval
> > using different adjustments.
> 
> That looks troublesome. Better avoid that.

Well, its not *that* bad. Similar to the ntp_scale() function, it would
look something like:

if (interval <= offset_len)
	return (interval * singleshot_mult)>>shift;
else {
	cycle_t v1,v2;
	v1 = (offset_len * singleshot_mult)>>shift;
	v2 = (interval-offset_len)*adjusted_mult)>>shift;
	return v1+v2;
}

Where:
	singleshot_mult = original_mult + ntp_adj + ss_mult
and
	adjusted_mult = original_mult + ntp_adj


> > Its starting to look doable, but its not necessarily the simplest thing
> > (for me at least). I'll put it on my list, but patches would be more
> > then welcome.
> 
> I am still suffering from my limited NTP knowlege but will see what I can
> do about this.

:) Any added NTP knowledge would be great to add to the pool. 

-john


