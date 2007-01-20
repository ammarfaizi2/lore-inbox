Return-Path: <linux-kernel-owner+w=401wt.eu-S965275AbXATQIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbXATQIa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXATQIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:08:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:55196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965275AbXATQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:08:29 -0500
X-Authenticated: #20450766
Date: Sat, 20 Jan 2007 17:08:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>
Subject: Re: [patch 3/3] clockevent driver for arm/pxa2xx
In-Reply-To: <1169235221.6271.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0701201655020.4223@poirot.grange>
References: <20070109100957.259649000@localhost.localdomain> 
 <20070109101307.715996000@localhost.localdomain>  <Pine.LNX.4.60.0701192010490.5127@poirot.grange>
 <1169235221.6271.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Thomas Gleixner wrote:

> On Fri, 2007-01-19 at 20:13 +0100, Guennadi Liakhovetski wrote:
> > > +static u32 clockevent_mode = 0;
> > > +
> > > +static void pxa_set_next_event(unsigned long evt,
> > > +				  struct clock_event_device *unused)
> > > +{
> > > +	OSMR0 = OSCR + evt;
> > > +}
> > 
> > This doesn't work for me in various nasty ways. Please, check for a 
> > minimum delay or loop to get ahead of time. See code in the "old" timer 
> > ISR. See how it unconditionally adds at least 10 ticks...
> 
> I added support for match register based devices and you want to do
> something like this:
> 
> static int hpet_next_event(unsigned long delta,
>                            struct clock_event_device *evt)
> {
>         unsigned long cnt;
> 
>         cnt = hpet_readl(HPET_COUNTER);
>         cnt += delta;
>         hpet_writel(cnt, HPET_T0_CMP);
> 
>         return ((long)(hpet_readl(HPET_COUNTER) - cnt ) > 0);
> }
> 
> The generic code takes care of the already expired event.

The thing is - 2.6.20-rc5-rt3 didn't provide clockevent on PXA, so, I took 
Sascha's patch instead of my own, which I've been using with 2.6.18, as 
his patches were already submitted to various lists and had chances to 
become mainline. And strait away it didn't work. The code above seems to 
be doing something close to Sascha's patch, so, I expect it would behave 
in the same way. And until I introduced a minimum increment for the match 
register, it didn't work. I either got hangs, or WARN_ON dumps about "time 
warp detected". I think, any timer related code for PXA has to be tested 
on real hardware under significant (real-time) load before going upstream. 
Haven't tested -rt7 though, so, maybe it is already handled there?

Thanks
Guennadi
---
Guennadi Liakhovetski
