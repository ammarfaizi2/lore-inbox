Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286734AbRLVJDb>; Sat, 22 Dec 2001 04:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286735AbRLVJDV>; Sat, 22 Dec 2001 04:03:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:26281 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286734AbRLVJDL>;
	Sat, 22 Dec 2001 04:03:11 -0500
Date: Sat, 22 Dec 2001 12:00:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ashok Raj <ashokr2@attbi.com>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: softirq question...
In-Reply-To: <PPENJLMFIMGBGDDHEPBBEEJFCAAA.ashokr2@attbi.com>
Message-ID: <Pine.LNX.4.33.0112221101340.3285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Dec 2001, Ashok Raj wrote:

> 1. Why does softirqd run at very low priority? is there a reason why
> this was choosen to run that low priority? since the tasklets that do
> deferred processing require quicker attention to avoid latency issues
> right? Iam sure you folks had a good reason, iam trying to evaluate
> why.

the reason is that by design, softirqd should only run when softirq load
is so high that IRQ contexts are not able to handle it all.

The current softirq code is quite bad for high-IRQ-rate device performance
because it has a wide window to 'miss' pending softirqs that got activated
while softirqs were running, and those pending softirqs will only be
processed in the next IRQ tick, or whenever we happen to schedule to
softirqd. I've demonstrated this problem numerous times (and others have
as well), it's easy to trigger. It does not take any high load to trigger
this situation, it just needs two successive fast IRQs from a fast device,
where the second one hits the softirq handler.

I provided two separate solutions for the softirq performance problems:

   1) to loop a few times so that the number of schedules towards softirqd
      decreases dramatically in RL situations. This solution is very
      simple - and while it's not a 'complete' solution, it's a practical
      solution.

   2) to loop until done in the softirq code, and limit hardirq load
      automatically at the hardirq level - this can be done pretty
      cheaply. In the future, limit irq load via a variant of explicit
      device-throttling, worked on by some people, 'NAPI'. NAPI is
      designed for networking-only use, so other subsystems might still
      rely on hardirq-level throttling.

(both solutions were posted as working patches.)

People have reported 10-20% performance drop for certain gigabit cards due
to the non-processing of softirqs & softirqd. But it's not only about
performance, it's also the latency of IRQ processing, even with
highest-priority softirqd, the latency to get softirqs done can be
significantly delayed by process-context activities.

softirqd is a (valid) attempt to solve the latency problem created by the
broken design of softirqs, which design inherited some of the breakage of
the original BHs, and which breakage results from a hard problem: the
desire to avoid softirq-related overloads and lockups. Softirqd is fixing
the symptom, and it obviously hurts performance - we should not push IRQ
load to process context as easily as we do today.

Increasing the priority of softirqd does not help the performance problems
either - the fundamental problem is that process contexts are simply not
suited for IRQ-type processing. (Even with its current priority, usually
softirqd does not use up as much timeslices as it has available, and thus
it gets the highest dynamic priority.)

Right now, if you care about performance, you are best off if you avoid
both softirqs and tasklets, and do as much processing in the hardirq
context as possible.

Waiting for the networking folks to fix this obvious problem is also a
solution, but i'm not betting on it, in fact they have trouble admitting
that there is a problem to begin with (check out the archives). This is
usually not a good start to get things fixed. Paradoxically, the same
people are calling the kettle black (both patch variants i offered), while
my kettle actually helps performance and avoids lockups, while their
kettle (the current mess of softirq code) hurts performance so obviously,
and in fact it does not even solve the "slow i486 router locks up under
100mbit load" problem.

so you might have noticed from the tone of my email that i'm not happy
about the current state of the Linux softirq (and tasklet) subsystem :-)

	Ingo

