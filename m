Return-Path: <linux-kernel-owner+w=401wt.eu-S965290AbXATPc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbXATPc1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbXATPc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:32:27 -0500
Received: from www.osadl.org ([213.239.205.134]:32962 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965290AbXATPc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:32:26 -0500
Subject: Re: [patch 3/3] clockevent driver for arm/pxa2xx
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>
In-Reply-To: <Pine.LNX.4.60.0701192010490.5127@poirot.grange>
References: <20070109100957.259649000@localhost.localdomain>
	 <20070109101307.715996000@localhost.localdomain>
	 <Pine.LNX.4.60.0701192010490.5127@poirot.grange>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 20:33:40 +0100
Message-Id: <1169235221.6271.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 20:13 +0100, Guennadi Liakhovetski wrote:
> > +static u32 clockevent_mode = 0;
> > +
> > +static void pxa_set_next_event(unsigned long evt,
> > +				  struct clock_event_device *unused)
> > +{
> > +	OSMR0 = OSCR + evt;
> > +}
> 
> This doesn't work for me in various nasty ways. Please, check for a 
> minimum delay or loop to get ahead of time. See code in the "old" timer 
> ISR. See how it unconditionally adds at least 10 ticks...

I added support for match register based devices and you want to do
something like this:

static int hpet_next_event(unsigned long delta,
                           struct clock_event_device *evt)
{
        unsigned long cnt;

        cnt = hpet_readl(HPET_COUNTER);
        cnt += delta;
        hpet_writel(cnt, HPET_T0_CMP);

        return ((long)(hpet_readl(HPET_COUNTER) - cnt ) > 0);
}

The generic code takes care of the already expired event.

	tglx


	

