Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRDCJ5b>; Tue, 3 Apr 2001 05:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDCJ5L>; Tue, 3 Apr 2001 05:57:11 -0400
Received: from chiara.elte.hu ([157.181.150.200]:53771 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130940AbRDCJ5C>;
	Tue, 3 Apr 2001 05:57:02 -0400
Date: Tue, 3 Apr 2001 10:55:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <3AC93417.7B7814FC@chromium.com>
Message-ID: <Pine.LNX.4.30.0104031035271.2794-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Apr 2001, Fabio Riccardi wrote:

> I sent a message a few days ago about some limitations I found in the
> linux scheduler.
>
> In servers like Apache where a large (> 1000) number of processes can
> be running at the same time and where many of them are runnable at the
> same time, the default Linux scheduler just starts trashing and the
> machine becomes very rapidly unusable.

it is *not* a scheduler problem. This is an application design problem.
Do not expect > 1000 runnable processes to perform well. Apache's
one-process-per-parallel-client-connection application model is especially
bad for such kind of loads. The scheduler has more important priorities to
worry about than to fix application design problems.

> Indeed I've tried the patches available on the sites for the
> multi-queue scheduler and I was amazed by the performance improvement
> that I got. Both patches allow me to get to a 100% real CPU
> utilization on a two way machine running ~1500 processes.

There were many promises along the years, and none as of now met all the
requirements the scheduler has to fulfill. 'many runnable processes' is
not on the top of the list - if we are scheduling like mad then we have
lost lots of performance already.

even with such 'improvements', the many-parallel-clients performance of
one-process-per-request HTTP server designs is an order slower than what
is possible.

having said that, improving this workload is still a useful task and we
added improvements to the scheduler to improve this case. But those
patches sacrifice other functionality just to get better
many-runnable-processes performance, which is unacceptable.

> What those patches do is quite simple, instead of having the single
> global process queue present in the normal Linux scheduler, they add
> multiple queues (one per CPU). In this way the scheduling decision can
> be greatly simplified and almost made local to each CPU. No hotspots,
> no global locks (well, almost).

the problem is that the *real* scheduling complexity (and needed
functionality) shows when the number of runnable processes is in the
neighborhood of the number of processors. Running many processes just
masks eg. load-balancing deficiencies in schedulers, so obviously the
simplest and most localized scheduler 'wins'. So comparing schedulers
based on many-runnable-processes load is like comparing cars solely based
on the size of their fuel tanks.

> Although some scalability problems are still there (there still is a
> global decision to make), the performance improvement obtained and the
> simplicity of the solution are remarkable.

you can easily make the scheduler fast in the many-processes case by
sacrificing functionality in the much more realistic, few-processes case.
None of the patch i've seen so far maintained the current scheduler's
few-processes logic. But i invite you to improve the current scheduler's
many-processes behavior, without hurting its behavior in the few-processes
case.

	Ingo

