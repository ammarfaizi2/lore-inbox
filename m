Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJ3Kou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTJ3Kou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:44:50 -0500
Received: from ltgp.iram.es ([150.214.224.138]:10631 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262315AbTJ3Kos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:44:48 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 30 Oct 2003 11:39:07 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-ID: <20031030103907.GB2722@iram.es>
References: <20031027234447.GA7417@rudolph.ccur.com> <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org> <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org> <20031029100745.GA6674@iram.es> <20031029113850.047282c4.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029113850.047282c4.shemminger@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 11:38:50AM -0800, Stephen Hemminger wrote:
> On Wed, 29 Oct 2003 11:07:45 +0100
> Gabriel Paubert <paubert@iram.es> wrote:
> 
> 
> > Consider the following:
> > 
> > - t-2: interrupt A arrives and starts being serviced
> > - t-1: interrupt B arrives but delayed in the APIC
> > - t: timer interrupt arrives (it is delayed too)
> > - t+x1: return from interrupt A
> > - t+x2: interrupt B serviced
> > - gettimeofday for time stamping, the returned value will actually 
> >   be frozen at t-1 for HZ=1000 or t-5 for HZ=100, while the actual
> >   time is t+something with something maybe up to a few tens of
> >   microseconds, instead of t+x2-1 or t+x2-5 which would be 
> >   clearly better.
> > - t+x3: timer interrupt, time steps suddenly now (or in
> >   the following BH, can't remember) from t-1 to the correct
> >   value, creating a fairly large discontinuity.
> > 
> > So what I'm asking you is to change the code so that the discontinuities
> > are minimized. That's quite important for some applications; actually
> > in my case the out-of-order gettimeofday don't matter as long as the
> > steps are small because I don't sample fast enough to be affected
> > by them, but getting the timestamp wrong by tens of microseconds is bad 
> > for evaluating the derivatives of the value read from a position encoder, 
> > as needed for servo loops for example.
> 
> The suggestion of using time interpolation (like ia64) would make the discontinuities
> smaller, but still relying on fine grain gettimeofday for controlling servo loops
> with NTP running seems risky. Perhaps what you want to use is the monotonic_clock
> which gives better resolution (nanoseconds) and doesn't get hit by NTP. 

When you control a telescope, you'll always have to go back to UT sooner
or later. Monotonic just does not cut it... And yes, I'm aware that the 
code will currently break around leap seconds, but I am still looking for 
a clean, not too bloated, solution to the problem.

Besides that I also need several machines to be synchronized for data
acquisition, and NTP provides me what I need (in the millisecond range),
monotonic can't. It is true that we have set things carefully up here:
we have our own redundant set of NTP stratum 0 (reference) clocks and 
everything which needs to be precisely synchronized is on a rather small 
LAN. Under these conditions what I have seen is that NTP steps the clock 
once at boot to set it, before I start any important program which might 
be affected by this, and then it never ever steps it again. The number 
of machines multiplied by the uptime is about 50 years now and counting, 
that's reliable enough for me.

> 
> A bigger possible change would be for the timer->offset functions to return nanoseconds,
> then the offset adjustment code could smooth it out. It would save a divide.

I believe that it is needed in the long term, but we'll see when 2.7 opens.

	Gabriel
