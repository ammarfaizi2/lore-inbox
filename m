Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031251AbWI0Xkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031251AbWI0Xkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031256AbWI0Xkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:40:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60336 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1031255AbWI0Xku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:40:50 -0400
Date: Thu, 28 Sep 2006 01:40:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exponential update_wall_time
In-Reply-To: <1159398793.7297.9.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609280128330.6761@scrub.home>
References: <1159385734.29040.9.camel@localhost>  <Pine.LNX.4.64.0609280031550.6761@scrub.home>
 <1159398793.7297.9.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Sep 2006, john stultz wrote:

> > This is the wrong approach, second_overflow() should be called every HZ
> > increment steps and your patch breaks this.
> 
> First, forgive me, since I've got a bit of a head cold, so I'm even
> slower then usual. I just don't see how this patch changes the behavior.
> Every second we will call second_overflow. But in the case where we
> skipped 100 ticks, we don't loop 100 times. Could you explain this a bit
> more?

second_overflow() changes the tick length, but the new tick length is now 
applied to varying number of ticks with your patch, which is bad for 
correct timekeeping.

> > There are other approaches oo accommodate dyntick. 
> > 1. You could make HZ in ntp_update_frequency() dynamic and thus reduce the 
> > frequency with which update_wall_time() needs to be called (Note that 
> > other clock variables like cycle_interval have to be adjusted as well). 
> 
> I'm not sure how this is functionally different from what this patch
> does.
> 
> 
> > 2. If dynticks stops the timer interrupt for a long time, it could 
> > precalculate a few things, e.g. it could complete the second and then 
> > advance the time in full seconds.
> 
> Not following this one at all.

You have to keep in mind that ntp time is basically advanced in 1 second 
steps (or HZ ticks or freq cycles to be precise) and you have to keep that 
property. You can slice that second however you like, but it still has to 
add up to 1 second. Right now we slice it into HZ steps, but this can be 
rather easily changed now.

bye, Roman
