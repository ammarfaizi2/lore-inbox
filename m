Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288776AbSAIVF0>; Wed, 9 Jan 2002 16:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSAIVFL>; Wed, 9 Jan 2002 16:05:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2491 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288776AbSAIVE5>;
	Wed, 9 Jan 2002 16:04:57 -0500
Date: Thu, 10 Jan 2002 00:02:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201091212380.7845-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201092351570.9339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Linus Torvalds wrote:

> Not a way in hell should "nice 19" cause the throughput to improve
> like that. It looks like this is a result of "nice 19" simply doing
> _different_ scheduling, possibly more batch-like, and as such those
> numbers cannot sanely be compared to anything else.

yes, this is what happens. The difference is that the load estimator
'punishes' tasks to have lower priority, while the recalc-based method
gives a 'bonus'. If run with nice +19 then the process cannot be punished
anymore, all the tasks will run on the same priority level - and none can
cause a preemption of the other one. The priority limit is set right at
the nice +19 level.

is this an intended thing with nice +19 tasks? I think so, at least for
some usages. It could be fixed by adding some more priority space (+13
levels) they could explore into (but which couldnt be set as the default
priority). So by having a ceiling it really behaves differently, very
batch-like - but that's what such benchmarks are asking for anyway ... I
think it's an intended effect for CPU hogs as well - we do not want them
to preempt each other, they should each use up their timeslices fully and
roundrobin nicely.

> (And if they _are_ comparable, then you should be able to get the good
> numbers even without "nice 19". Quite frankly it sounds to me like the
> whole chat benchmark is another "dbench", ie doing unbalanced
> scheduling _helps_ it performance-wise, which implies that it's
> probably a bad benchmark to look at numbers for).

yes, agreed. It's not really unbalanced scheduling, the scheduler is still
fair. What doesnt happen is priority based preemption.

i think it could be a bonus to have such a scheduler mode - people dont
run shells at +19 niceness level, it's the known CPU hogs that get started
up with nice +19. It's a kind of SCHED_IDLE - everything can preempt it
and it will preempt nothing, without the priority inheritance problems of
SCHED_IDLE.

	Ingo

