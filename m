Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282103AbRKWJts>; Fri, 23 Nov 2001 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282098AbRKWJtP>; Fri, 23 Nov 2001 04:49:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19146 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282104AbRKWJsl>;
	Fri, 23 Nov 2001 04:48:41 -0500
Date: Fri, 23 Nov 2001 12:46:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <Pine.LNX.4.10.10111221926130.31054-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0111231240320.3988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Mark Hahn wrote:

> only that it's nontrivial to estimate the migration costs, I think. at
> one point, around 2.3.3*, there was some effort at doing this - or
> something like it.  specifically, the scheduler kept track of how long
> a process ran on average, and was slightly more willing to migrate a
> short-slice process than a long-slice.  "short" was defined relative
> to cache size and a WAG at dram bandwidth.

yes. I added the avg_slice code, and i removed it as well - it was
hopeless to get it right and it was causing bad performance for certain
application sloads. Current CPUs simply do not support any good way of
tracking cache footprint of processes. There are methods that are an
approximation (eg. uninterrupted runtime and cache footprint are in a
monotonic relationship), but none of the methods (including cache traffic
machine counters) are good enough to cover all the important corner cases,
due to cache aliasing, MESI-invalidation and other effects.

> the rationale was that if you run for only 100 us, you probably don't
> have a huge working set.  that justification is pretty thin, and
> perhaps that's why the code gradually disappeared.

yes.

> hmm, you really want to monitor things like paging and cache misses,
> but both might be tricky, and would be tricky to use sanely. a really
> simple, and appealing heuristic is to migrate a process that hasn't
> run for a long while - any cache state it may have had is probably
> gone by now, so there *should* be no affinity.

well it doesnt take much for a process to populate the whole L1 cache with
dirty cachelines. (which then have to be cross-invalidated if this process
is moved to another CPU.)

	Ingo

