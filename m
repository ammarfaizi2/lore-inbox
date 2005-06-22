Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVFVSsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFVSsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVFVSsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:48:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41859 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261587AbVFVSrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:47:48 -0400
Date: Wed, 22 Jun 2005 11:47:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622184748.GF1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <42B9A6D6.4060109@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9A6D6.4060109@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 01:58:46PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > I have big hands, so 7us could indeed qualify as a "handful".
> 
> :)
> 
> > Any insights as to what leads to the larger maximum delay?  Some guesses
> > include worst-case cache-miss patterns and interrupt disabling that I
> > missed in my quick scan of the patch.
> 
> Beats me. Given that PREEMPT_RT and the I-pipe get to the same maximum
> by using two entirely different approaches, I'm guessing this has more
> to do with hardware-related contention than anything inside the patches
> themselves.

Quite possible, perhaps worst-case cache state.

> > If I understand your analysis correctly (hah!!!), your breakdown
> > of the maximum delay assumes that the maximum delays for the logger
> > and the target are correlated.  What causes this correlation?
> 
> No it doesn't. I'm just inferring the maximum and average using the
> data obtained in the ipipe-to-ipipe setup. In that specific case,
> I'm assuming that the interrupt latency on both systems for the
> same type of interrupt is identical (after all, these machines are
> physically identical, albeit one has 512MB or RAM and the other
> 256.)
> 
> There is no correlation. Just the assumption that what's actually
> being measured is twice the latency of the ipipe in that specific
> setup.
> 
> Given that the interrupt latency of preempt_rt is measured using one
> machine runing adeos (read ipipe) and the other preempt_rt, I'm
> deducing the latency of preempt_rt based on the numbers obtained
> for the ipipe by looking at the ipipe-to-ipipe setup.
> 
> > My (probably hopelessly naive) assumption would be that there would
> > be no such correlation.  In absence of correlation, one might
> > approximate the maximum ipipe delay by subtracting the -average-
> > ipipe delay from the maximum preemption delay, for 55us - 7us = 48us.
> > Is this the case, or am I missing something here?
> 
> Not directly. You'd have to start by saying that the true maximum ipipe
> delay is obtained by substracting the average ipipe delay from the
> measured maximum ipipe delay (to play safe you could even substract
> the minimum.)
> 
> However such a maximum isn't correlated by the data. If indeed there
> was a difference between the maximums, averages and minimums of the
> ipipe and preempt_rt, the shear quantity of measurements would not
> have shown such latency similarities. IOW, it is expected that at
> least once in a blue moon we'll hit that case where both the target
> and the logger demonstrate their highest possible latency. That's
> what we can safely assume 55us is, again given the number of samples.
> Remember that on the first run, we sometimes observed a maximum
> ipipe-to-ipipe response time of 21us. That's because in those runs
> the blue-moon scenario didn't materialize.

Quite possible, depending on what the raw distribution of times looks
like.  If there are a smallish number of 55us events (as there would
have to be given an average of 7us), the blue-moon scenario would lead
one to expect a much larger number of ~30us events (27.5us + 3.5us).

In absence of a ~30us bulge, there would still be the possibility that
one might see an even bluer (violet?) moon that might stack up to ~100us.
Heck, there might be that possibility anyway, but such is life when
measuring latencies.  :-/

(And, yes, there are other CDFs lacking a 30us bulge that would be
consistent with a 55us "blue-moon" bulge -- so I guess I am asking
if you have the CDF or the raw latency measurements -- though the
data set might be a bit large...  And I would have to think about
how one goes about deriving individual-latency CDF(s) given a single
dual-latency CDF, assuming that this is even possible...)

> > Of course, in the case of the -average- preemption measurements, dividing
> > by two to get the average ipipe delay makes perfect sense.
> 
> There's no correlation, so I don't see this one.

You are right that there might not be a correlation, and that it might
be OK to just divide the maximum latency by two, but I can imagine
cases where dividing by two was not appropriate.

> > Whatever the answer to my maximum-delay question, the same breakdown of
> > the raw latency figures would apply to the CONFIG_PREEMPT_RT case, right?
> 
> Sure, but again see the above caveats.

Thanks for the info!

							Thanx, Paul
