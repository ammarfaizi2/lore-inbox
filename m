Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVF3Pmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVF3Pmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVF3Pmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:42:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4484 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262782AbVF3Pmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:42:45 -0400
Date: Thu, 30 Jun 2005 08:43:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630154304.GA1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630070709.GA26239@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630070709.GA26239@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 09:07:09AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > However, on a UP system, I have to agree with Kristian's choice of 
> > configuration.  An embedded system developer running on a UP system 
> > would naturally use a UP Linux kernel build, so it makes sense to 
> > benchmark a UP kernel on a UP system.
> 
> sure.
> 
> keeping that in mind, PREEMPT_RT is quite similar to the SMP kernel (it 
> in fact activates much of the SMP code), so if you want to isolate the 
> overhead coming from the non-locking portions of PREEMPT_RT, you'd 
> compare to the SMP kernel. I do that frequently.

Agreed!  For someone working on making PREEMPT_RT better, comparing to
SMP code running on a UP kernel is extremely useful, since it gives an
idea on where to focus.  But someone who was wanting to build a realtime
application might not care so much.

Me, I would like to see an SMP-kernel comparison on a 2-CPU or 4-CPU
system, though probably not too many applications want SMP realtime
quite yet.  My guess is that SMP realtime will be increasingly
important, though.

> another point is that this test is measuring the overhead of PREEMPT_RT, 
> without measuring the benefit of the cost: RT-task scheduling latencies.  
> We know since the rtirq patch (to which i-pipe is quite similar) that we 
> can achieve good irq-service latencies via relatively simple means, but 
> that's not what PREEMPT_RT attempts to do. (PREEMPT_RT necessarily has 
> to have good irq-response times too, but much of the focus went to the 
> other aspects of RT task scheduling.)

Agreed, a PREEMPT_RT-to-IPIPE comparison will never be an apples-to-apples
comparison.  Raw data will never be a substitute for careful thought,
right?  ;-)

> were the wakeup latencies of true RT tasks tested, you could see which 
> technique does what. But all that is being tested here is pure overhead 
> to non-RT tasks, and the worst-case latency of raw interrupt handling.  
> While they are important and necessary components of the whole picture, 
> they are not the whole picture. This is a test that is pretty much 
> guaranteed to show -RT as having higher costs - in fact i'm surprised it 
> held up this well :)

Me too!  ;-)  For me, the real surprise was that I-PIPE's and PREEMPT_RT's
worst-case irq latencies were roughly comparable.  I would have guessed
that I-PIPE would have been 2x-3x better than PREEMPT_RT.

And I expect that there are a number of applications where it is worth
paying the extra system-call cost in order to gain the better latencies,
particularly those that spend most of their time executing in user mode.
As you continue your work reducing the costs, more and more applications
would see the benefit.

Other applications might need the low-cost system calls badly enough
that they want to deal with the greater complexity of the non-unified
I-PIPE programming model.

Still others might be satisfied with the less-good realtime latency of
a straight CONFIG_PREEMPT kernel.  Or even of a non-CONFIG_PREEMPT
kernel.

> so in that sense, this test is like running an SMP kernel on an UP box 
> and comparing it against the UP kernel (or running an SMP kernel on an 
> SMP box but only running a single task to measure performance), and 
> concluding that it has higher costs. It is a technically correct 
> conclusion, but obviously misses the whole picture, and totally misses 
> the point behind the SMP kernel.

Agreed, this experiment would not be useful to an user -- after all,
if the user has a single-threaded application, they should just buy
a UP box, run a UP kernel on it, and not bother with the experiment.
This experiment -might- be useful to a developer who is working on
either the SMP kernel or on the hardware, and who wants to measure the
overhead of SMP -- in fact, I did this sort of experiment (among others,
of course!) in my RCU dissertation.

I also agree that Kristian's and Karim's benchmark does not show the
full picture.  No set of benchmark data, no matter how carefully designed
and collected, will ever be a substitute for careful consideration of
all aspects of the problem.  The realtime latency and the added overhead
are important, but they are not the only important things.

But, for the moment, I need to get back to an RCU implementation that
I owe you.  It is at least limping, which is better than I would have
expect, but needs quite a bit more work.  ;-)

						Thanx, Paul
