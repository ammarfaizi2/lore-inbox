Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVCOBNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVCOBNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCOBNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:13:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:42886 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262191AbVCOBLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:11:10 -0500
Subject: [topic change] jiffies as a time value
From: john stultz <johnstul@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Matt Mackall <mpm@selenic.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <423620EA.3040205@mvista.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <423620EA.3040205@mvista.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 17:11:02 -0800
Message-Id: <1110849062.30498.450.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 15:40 -0800, George Anzinger wrote:
> john stultz wrote:
> > On Sat, 2005-03-12 at 16:49 -0800, Matt Mackall wrote:
> >>>+	/* finally, update legacy time values */
> >>>+	write_seqlock_irqsave(&xtime_lock, x_flags);
> >>>+	xtime = ns2timespec(system_time + wall_time_offset);
> >>>+	wall_to_monotonic = ns2timespec(wall_time_offset);
> >>>+	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
> >>>+	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
> >>>+	/* XXX - should jiffies be updated here? */
> >>
> >>Excellent question. 
> > 
> > Indeed.  Currently jiffies is used as both a interrupt counter and a
> > time unit, and I'm trying make it just the former. If I emulate it then
> > it stops functioning as a interrupt counter, and if I don't then I'll
> > probably break assumptions about jiffies being a time unit. So I'm not
> > sure which is the easiest path to go until all the users of jiffies are
> > audited for intent. 
> 
> Really?  Who counts interrupts???  The timer code treats jiffies as a unit of 
> time.  You will need to rewrite that to make it otherwise.  

Ug. I'm thin on time this week, so I was hoping to save this discussion
for later, but I guess we can get into it now.

Well, assuming timer interrupts actually occur HZ times a second, yes
one could (and current practice, one does) implicitly interpret jiffies
as being a valid notion of time.  However with SMIs, bad drivers that
disable interrupts for too long, and virtualization the reality is that
that assumption doesn't hold. 

We do have the lost-ticks compensation code that tries to help this, but
that conflicts with some virtualization implementations. Suspend/resume
tries to compensate jiffies for ticks missed over time suspended, but
I'm not sure how accurate it really is (additionally, looking at it now,
it assumes jiffies is only 32bits).

Adding to that, the whole jiffies doesn't really increment at HZ, but
ACTHZ confusion, or bad drivers that assume HZ=100, we get a fair amount
of trouble stemming from folks using jiffies as a time value.  Because
in reality, it is just a interrupt counter.

So now, if new timeofday code emulates jiffies, we have to decide if it
emulates jiffies at HZ or ACTHZ? Also there could be issues with jiffies
possibly jittering from it being incremented every tick and then set to
the proper time when the timekeeping code runs. 

I'm not sure which is the best way to go, but it sounds that emulating
it is probably the easiest. I just deferred the question with a comment
until now because its not completely obvious. Any suggestions on the
above questions (I'm guessing the answers are: use ACTHZ, and the jitter
won't hurt that bad). 

> But then you have 
> another problem.  To correctly function, times need to expire on time (hay how 
> bout that) not some time later.  To do this we need an interrupt source.  To 
> this point in time, the jiffies interrupt has been the indication that one or 
> more timer may have expired.  While we don't need to "count" the interrupts, we 
> DO need them to expire the timers AND they need to be on time.

Well, something Nish Aravamudan has been working on is converting the
common users of jiffies (drivers) to start using human time units. These
very well understood units (which avoid HZ/ACTHZ/HZ=100 assumptions) can
then be accurately changed to jiffies (or possibly some other time unit)
internally. It would even be possible for soft-timers to expire based
upon the actual high-res time value, rather then the low-res tick-
counter(which is something else Nish has been playing with). When that
occurs we can easily start doing other interesting things that I believe
you've already been working on in your HRT code, such as changing the
timer interrupt frequency dynamically, or working with multiple timer
interrupt sources. 

So basically, lots of interesting questions and possibilities and I very
much look forward to your input and suggestions. 

thanks
-john

