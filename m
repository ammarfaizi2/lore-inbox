Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSAFBAk>; Sat, 5 Jan 2002 20:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286649AbSAFBAa>; Sat, 5 Jan 2002 20:00:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43667 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286647AbSAFBAV>;
	Sat, 5 Jan 2002 20:00:21 -0500
Date: Sun, 6 Jan 2002 03:57:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201051643050.24370-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201060349380.3424-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Linus Torvalds wrote:

> What do the per-CPU queue patches look like? I agree with Davide that
> it seems much more sensible from a scalability standpoint to allow
> O(n)  (or whatever) but with local queues. That should also very
> naturally give CPU affinity ;)

(if Davide's post gave you the impression that my patch doesnt do per-CPU
queues then i'd like to point out that it does so. Per-CPU runqueues are a
must for good performance on 8-way boxes and bigger. It's just the actual
implementation of the 'per CPU queue' that is O(1).)

> The problem with local queues is how to sanely break the CPU affinity
> when it needs breaking. Which is not necessarily all that often, but
> clearly does need to happen.

yes. The rule i did is this: 'if the runqueue of another CPU is longer by
more than 10% than our own runqueue then we pull over 5% of tasks'.

we also need to break affinity to get basic fairness - otherwise we might
end up running 10 CPU-bound tasks on CPU1 each using 10% of CPU time, and
a single CPU-bound task on CPU2, using up 100% of CPU time.

> It would be nice to have the notion of a cluster scheduler with a
> clear "transfer to another CPU" operation, and actively trying to
> minimize the number of transfers.

i'm doing this in essence in the set_cpus_allowed() function, it transfers
a task from one CPU's queue to another one.

there are two task migration types:

- a CPU 'pulls' tasks. My patch does this whenever a CPU goes idle, and
  does it periodically from the timer tick. This is the load_balance()
  code. It looks at runqueue lengths and tries to pick a task from another
  CPU that wont have a chance to run there in the near future (and would
  thus lose cache footprint anyway). The load balancer is what should be
  made aware of the caching hierarchy, NUMA, hyperthreading and the rest.

- a CPU might 'push' tasks. Right now my patch does this only when a
  process becomes 'illegal' on a CPU, ie. the cpus_allowed bitmask
  excludes the currently running CPU.

the migration itself needs a slightly more complex locking, but it's
relatively straightforward. Otherwise the per-CPU runqueue locks stay on
those CPUs nicely and scalability is very good.

	Ingo

