Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275352AbTHSGRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275358AbTHSGRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:17:21 -0400
Received: from holomorphy.com ([66.224.33.161]:62186 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275352AbTHSGRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:17:19 -0400
Date: Mon, 18 Aug 2003 23:18:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030819061822.GW1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric St-Laurent <ericstl34@sympatico.ca>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <1061261666.2094.15.camel@orbiter> <200308191413.00135.kernel@kolivas.org> <1061267029.2900.54.camel@orbiter> <1061267367.3f41a7a70f007@kolivas.org> <1061269559.5853.7.camel@orbiter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061269559.5853.7.camel@orbiter>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>> There's a scheduler implementation dating pre 1970 that does this
>> and I am led to believe someone is working on an implementation for
>> perhaps 2.7

On Tue, Aug 19, 2003 at 01:06:00AM -0400, Eric St-Laurent wrote:
> The first implementation is in 1962 with CTSS if i remember correctly.
> Multics initially had something like that too.
>  http://www.multicians.org/mult-sched.html
> Anyway that's pretty standard CS stuff. Multi-level Queues with
> feedback, exponentially longer timeslices with lower priority.
> I was reading this recently, that's why i wondered why linux calculate
> timeslice "inversed" versus what is proposed in theory.

None of the scheduling policies described there are multi-level queue
-based policies. The bottom-level scheduler was FB until ca. 1976,
when a deadline-based scheduling policy was adopted.

Multilevel queue -based policies segregate tasks into service levels
by the amount of runtime accumulated without blocking (i.e. continual
spinning interrupted only by the scheduler yanking the thing off the
cpu to run something else because it's run too long) and do some other
kind of scheduling within the levels, typically RR with quanta
determined by the level. Various hacks to elevate or lower the service
level with different kinds of I/O or device access were typically used
as interactivity heuristics and were used in the 1967-1975 Multics FB
scheduling policies as described in that webpage.

The deadline scheduler is very different in its mechanics and very
flexible; it's almost impossible to say anything about it without
knowing how the deadlines were assigned. FB is actually very well-
understood, but trivially DoS'able in real-life environments, as
looping coprocesses will monopolize the cpu. The fact device access
and other similar heuristics were required to make it behave well
in interactive environments should be a big hint that the FB design
is fundamentally inadequate.

One obviously nice thing about deadline scheduling is that it's trivial
to prevent starvation: merely assign nonzero offsets from the present
to all tasks, and the ``finger'' pointing at the current task to run
is guaranteed to advance and so cover every queued task. In essence,
deadline scheduling controls how often tasks get to run directly as
opposed to remaining at the mercy of wakeups.

The description of the Multics algorithm implies that at each wakeup
one of two quanta was assigned to the task when it got scheduled, that
one of two workclass-specific virtual deadlines was assigned, and that
the only attempt to account for service time was a distinction between
the first time the task was run and all other times, where the first
time it was run got quantum Q1 and deadline R1 and the rest quantum Q2
and deadline R2, where presumably Q1 < Q2 and R1 < R2. This obviously
does not fully exploit the expressiveness of the deadline design as
one can easily conceive of service time and priority (nice number)
dependent deadline/quanta assignments that make various kinds of sense.


-- wli
