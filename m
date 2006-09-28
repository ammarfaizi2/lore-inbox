Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031288AbWI1A2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031288AbWI1A2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWI1A2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:28:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56009 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965173AbWI1A2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:28:55 -0400
Subject: Re: [RFC] exponential update_wall_time
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609280128330.6761@scrub.home>
References: <1159385734.29040.9.camel@localhost>
	 <Pine.LNX.4.64.0609280031550.6761@scrub.home>
	 <1159398793.7297.9.camel@localhost>
	 <Pine.LNX.4.64.0609280128330.6761@scrub.home>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 17:28:52 -0700
Message-Id: <1159403333.7297.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 01:40 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 27 Sep 2006, john stultz wrote:
> 
> > > This is the wrong approach, second_overflow() should be called every HZ
> > > increment steps and your patch breaks this.
> > 
> > First, forgive me, since I've got a bit of a head cold, so I'm even
> > slower then usual. I just don't see how this patch changes the behavior.
> > Every second we will call second_overflow. But in the case where we
> > skipped 100 ticks, we don't loop 100 times. Could you explain this a bit
> > more?
> 
> second_overflow() changes the tick length, but the new tick length is now 
> applied to varying number of ticks with your patch, which is bad for 
> correct timekeeping.

Hmm.. Ok, I can see that. Thanks for the clarification.

> > > There are other approaches oo accommodate dyntick. 
> > > 1. You could make HZ in ntp_update_frequency() dynamic and thus reduce the 
> > > frequency with which update_wall_time() needs to be called (Note that 
> > > other clock variables like cycle_interval have to be adjusted as well). 
> > 
> > I'm not sure how this is functionally different from what this patch
> > does.
> > 
> > 
> > > 2. If dynticks stops the timer interrupt for a long time, it could 
> > > precalculate a few things, e.g. it could complete the second and then 
> > > advance the time in full seconds.
> > 
> > Not following this one at all.
> 
> You have to keep in mind that ntp time is basically advanced in 1 second 
> steps (or HZ ticks or freq cycles to be precise) and you have to keep that 
> property. You can slice that second however you like, but it still has to 
> add up to 1 second. Right now we slice it into HZ steps, but this can be 
> rather easily changed now.

Right off, it seems it would then make sense to make the ntp "ticks" one
second in length. And set the interval values accordingly.

However, there might be clocksources that are incapable of running
freely for a full second w/o overflowing. In that case we would need to
set the interval values and the ntp tick length accordingly. It seems we
need some sort of interface to ntp to define that base tick length.
Would that be ok by you?

thanks
-john

