Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTJ2KKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 05:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTJ2KKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 05:10:19 -0500
Received: from ltgp.iram.es ([150.214.224.138]:61317 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261890AbTJ2KKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 05:10:11 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 29 Oct 2003 11:07:45 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-ID: <20031029100745.GA6674@iram.es>
References: <20031027234447.GA7417@rudolph.ccur.com> <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org> <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028102120.01987aa4.shemminger@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 10:21:20AM -0800, Stephen Hemminger wrote:
> On Tue, 28 Oct 2003 12:55:58 +0100
> Gabriel Paubert <paubert@iram.es> wrote:
> 
> > On Mon, Oct 27, 2003 at 05:17:38PM -0800, Stephen Hemminger wrote:
> > > Arghh... the patch was being way more agressive than necessary.  
> > > tickadj which limits NTP is always 1 (for HZ=1000) so NTP will change
> > > at most 1 us per clock tick.  This meant we only had to stop time
> > > for the last us of the interval.
> > 
> > Hmm, I still don't like it. What does it do to timestamping in
> > interrupts in the kernel, especially when there is a burst of
> > interrupts?
> > 
> > If I read it correctly, the time will be frozen between the time
> > the timer interrupt should have arrived and the time it is processed.
> > So the last micosecond of the interval could extend well into the next
> > interval, or do I miss something (I also suspect that it could
> > make PPSKit behave strangely for this reason)?
> 
> The original problem all this is solving is that when NTP is slowing the clock
> there existed real cases where time appeared to go backwards. Assuming NTP was
> slowing the clock, then it would update the xtime by 999us at the next timer interrupt.
> If a program read time three times:
> 
> A:	    xtime = t0
> B: A+1000   xtime = t0 + 1000
> C: B+1	    xtime = t0 + 999
> 
> To behave correctly C > B > A; but we were returning C < B

Well, it happens almost everyday when I come back to work
and wake my laptop up from sleep and starts receiving ntp packets
(broadcastclient mode). After a few minutes, I have a time adjustment
step of of typically a few hundred milliseconds either way. It's a
once per day event, but it happens.

But anyway, I understand your point. But by doing this you potentially 
cause another problem of fairly large steps in time for interrupt handlers 
that do timestamping.

Consider the following:

- t-2: interrupt A arrives and starts being serviced
- t-1: interrupt B arrives but delayed in the APIC
- t: timer interrupt arrives (it is delayed too)
- t+x1: return from interrupt A
- t+x2: interrupt B serviced
- gettimeofday for time stamping, the returned value will actually 
  be frozen at t-1 for HZ=1000 or t-5 for HZ=100, while the actual
  time is t+something with something maybe up to a few tens of
  microseconds, instead of t+x2-1 or t+x2-5 which would be 
  clearly better.
- t+x3: timer interrupt, time steps suddenly now (or in
  the following BH, can't remember) from t-1 to the correct
  value, creating a fairly large discontinuity.

So what I'm asking you is to change the code so that the discontinuities
are minimized. That's quite important for some applications; actually
in my case the out-of-order gettimeofday don't matter as long as the
steps are small because I don't sample fast enough to be affected
by them, but getting the timestamp wrong by tens of microseconds is bad 
for evaluating the derivatives of the value read from a position encoder, 
as needed for servo loops for example.



> 
> The code does have bug if we are losing clock interrupts.  The test for
> lost interrupts needs to be after the interval clamp.

If we are really losing clock interrupts, we have more serious problems 
anyway (on x86 with classical 8253 timer, I don't know about other x86 
systems, only that PPC recovers from them rather well). This misnamed 
lost_jiffies variable is not the number of lost interrupts, but actually 
the number of jiffies for which the bottom half has not (yet) been 
performed.

> This should work better. Patch against 2.6.0-test9

Still unhappy...

	Gabriel
