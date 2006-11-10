Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423876AbWKJFKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423876AbWKJFKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424309AbWKJFKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:10:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11476 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423876AbWKJFKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:10:31 -0500
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 06:10:13 +0100
User-Agent: KMail/1.9.5
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost>
In-Reply-To: <1163121045.836.69.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100610.13957.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	current_tsc_khz = tsc_khz;
> >  		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> >  							clocksource_tsc.shift);
> > +#ifndef CONFIG_HIGH_RES_TIMERS
> >  		/* lower the rating if we already know its unstable: */
> >  		if (check_tsc_unstable())
> >  			clocksource_tsc.rating = 0;
> > -
> > +#else
> > +		/*
> > +		 * Mark TSC unsuitable for high resolution timers. TSC has so
> > +		 * many pitfalls: frequency changes, stop in idle ...  When we
> > +		 * switch to high resolution mode we can not longer detect a
> > +		 * firmware caused frequency change, as the emulated tick uses
> > +		 * TSC as reference. This results in a circular dependency.
> > +		 * Switch only to high resolution mode, if pm_timer or such
> > +		 * is available.
> > +		 */
> > +		clocksource_tsc.rating = 50;
> > +		clocksource_tsc.is_continuous = 0;
> > +#endif
> >  		init_timer(&verify_tsc_freq_timer);
> >  		verify_tsc_freq_timer.function = verify_tsc_freq;
> >  		verify_tsc_freq_timer.expires =
> 
> 
> Hmmm. I wish this patch was unnecessary, but I don't see an easy
> solution. 

Very sad. This will make a lot of people unhappy, even to the point
where they might prefer disabling noidlehz over super slow gettimeofday. 
I assume you at least have a suitable command line option for that, right?

Can we get a summary on which systems the TSC is considered unstable?
Normally we assume if it's stable enough for gettimeofday it should
be stable enough for longer delays too.

-Andi

