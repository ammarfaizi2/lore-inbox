Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVFVQ3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVFVQ3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFVQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:28:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60632 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261651AbVFVQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:26:57 -0400
Date: Wed, 22 Jun 2005 09:27:19 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622162718.GD1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9845B.8030404@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:31:39AM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > Probably just my not fully understanding I-PIPE (to say nothing of
> > not fully understanding your test setup!), but I would have expected
> > I-PIPE to be able to get somewhere in the handfuls of microseconds of
> > interrupt latency.  Looks like it prevents Linux from ever disabling
> > real interrupts -- my first guess after reading your email was that
> > Linux was disabling real interrupts and keeping I-PIPE from getting
> > there in time.
> 
> Have a look at the announcement just made by Kristian about the LRTBF.
> There's a tarball with all the code for the drivers, scripts and
> configs we used.

I see that now, cool!!!  And thank you and Kristian for putting this
together!

> Nevertheless, maybe it's worth that I clarify the setup further.
> Here's what we had:
> 
>                      +----------+
>                      |   HOST   |
>                      +----------+
>                           |
>                           |
>                           | Ethernet LAN
>                           |
>                          / \
>                         /   \
>                        /     \
>                       /       \
>                      /         \
>                     /           \
>                    /             \
>             +--------+  SERIAL  +--------+
>             | LOGGER |----------| TARGET |
>             +--------+          +--------+
> 
> The logger sends an interrupt to the target every 1ms. Here's the
> path travelled by this interrupt (L for logger, T for target):
> 
> 1- L:adeos-registered handler is called at timer interrupt
> 2- L:record TSC for transmission
> 3- L:write out to parallel port
> 4- T:ipipe-registered handler called to receive interrupt
> 5- T:write out to parallel port
> 6- L:adeos-registered handler called to receive interrupt
> 7- L:record TSC for receipt
> 
> The response times obtained include all that goes on from 2 to
> 7, including all hardware-related delays. The target's true
> response time is from 3.5 to 5.5 (the .5 being the actual
> time it takes for the signal to reache the pins on the actual
> physical parallel port outside the computer.)
> 
> The time from 2 to 3.5 includes the execution time for a few
> instructions (record TSC value to RAM and outb()) and the delay
> for the hardware to put the value out on the parallel port.
> 
> The time from 5.5 to 7 includes an additional copy of adeos'
> interrupt response time. IOW, in all cases, we're at least
> recording adeos' interrupt response time at least once. Like
> we explained in our first posting (and as backed up by the
> data found in both postings) the adeos-to-adeos setup shows
> that this delay is bound. In fact, we can safely assume that
> 2*max_ipipe_delay ~= 55us and that 2*average_ipipe_delay
> ~= 14us. And therefore:
> 
> max_ipipe_delay = 27.5us
> average_ipipe_delay = 7us
> max_preempt_delay = 55us - max_ipipe_delay = 27.5us
> average_preempt_delay = 14 us - average_ipipe_delay = 7us
> 
> Presumably the 7us above should fit the "handful" you refer
> to. At least I hope.

I have big hands, so 7us could indeed qualify as a "handful".

Any insights as to what leads to the larger maximum delay?  Some guesses
include worst-case cache-miss patterns and interrupt disabling that I
missed in my quick scan of the patch.

If I understand your analysis correctly (hah!!!), your breakdown
of the maximum delay assumes that the maximum delays for the logger
and the target are correlated.  What causes this correlation?
My (probably hopelessly naive) assumption would be that there would
be no such correlation.  In absence of correlation, one might
approximate the maximum ipipe delay by subtracting the -average-
ipipe delay from the maximum preemption delay, for 55us - 7us = 48us.
Is this the case, or am I missing something here?

Of course, in the case of the -average- preemption measurements, dividing
by two to get the average ipipe delay makes perfect sense.

Whatever the answer to my maximum-delay question, the same breakdown of
the raw latency figures would apply to the CONFIG_PREEMPT_RT case, right?

						Thanx, Paul
