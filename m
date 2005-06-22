Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVFVUYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVFVUYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVFVUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:24:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47493 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262146AbVFVUXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:23:31 -0400
Date: Wed, 22 Jun 2005 22:22:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622202242.GA17301@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9C777.8040202@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > with lpptest (PREEMPT_RT's built-in parallel-port latency driver) that's 
> > possible, as it polls the target with interrupts disabled, eliminating 
> > much of the logger-side latencies. The main effect is that it's now only 
> > a single worst-case latency that is measured, instead of having to have 
> > two worst-cases meet.
> > 
> > Here's a rough calculation to show what the stakes are: if there's a 
> > 1:100000 chance to trigger a worst-case irq handling latency, and you 
> > have 600000 samples, then with lpptest you'll see an average of 6 events 
> > during the measurement. With lrtfb (the one Karim used) the chance to 
> > see both of these worst-case latencies on both sides of the measurement 
> > is 1:10000000000, and you'd see 0.00006 of them during the measurement.  
> > I.e. the chances of seeing the true max latency are pretty slim.
> 
> If indeed there are 6 events on a single-side which are worst-case, 
> then you would have to also factor in the probability of obtaining an 
> average or below average result on the other side. So again, if all 
> runs were measuring average on each side, one would expect that at 
> least one of the runs would have a bump over the 55us mark. Yet, they 
> all have the same maximum.

if your likelyhood of getting a 'combo max' event is 1:10000000000 then 
you'll basically never see the max! What you will see are combinations 
of lower-order critical paths - i.e. a worst-case path of 35 usecs 
combined with another, more likely critical path of 20 usecs. You'll 
still have the statistical appearance of having found a 'max'.

your only hope to have valid results would be if the likelyhood of the 
maximum path is much higher than the one in my example. But even then, 
you've significantly reduced the likelyhood of seeing an actual 
worst-case latency total.

>From all the test i've done, 600,000 samples are not enough to trigger 
the worst-case latency - even with the polling method! Also, your tests 
dont really load the system, so you have a fundamentally lower chance of 
seeing worst-case latencies. My tests do a dd test, a flood ping, an 
LTP-40-copies test, an rtc_wakeup 8192 Hz test and an infinite loop of 
hackbench test all in parallel, and even in such circumstances and with 
a polling approach i need above 1 million samples to hit the worst-case 
path! (which i cannot know for sure to be the worst-case path, but which 
i'm reasonably confident about, based on the distribution of the 
latencies and having done tens of millions of samples in overnight 
tests.) Obviously it's a much bigger constraint on the IRQ subsystem if 
_all_ interrupt _and_ DMA sources in the system are as active as 
possible.

so ... give the -50-12 -RT tree a try and report back the lpptest 
results you are getting. [ I know the results i am seeing, but i wont 
post them as a counter-point because i'm obviously biased :-) I'll let 
people without an axe to grind do the measurements. ]

	Ingo
