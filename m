Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSAFQ0z>; Sun, 6 Jan 2002 11:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAFQ0q>; Sun, 6 Jan 2002 11:26:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14231 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288987AbSAFQ0b>;
	Sun, 6 Jan 2002 11:26:31 -0500
Date: Sun, 6 Jan 2002 19:23:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] mqo1 changes ...
In-Reply-To: <Pine.LNX.4.40.0201052237340.945-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201061613330.3556-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Davide Libenzi wrote:

> Ingo, there a fix in ksyms.c ( missing ; ).

thanks, applied, it's in -C1.

> There's a checkpointing code for rt tasks.

thanks, we can certainly do something like this, i've added a variation of
this to -C1. One thing your patch misses: we need to update the event
counter when we remove RT tasks as well.

> Ingo, are you sure we need to lock the whole lock set to do rt queue
> pickups ?
> RT lock ( first ) + prev-task lock ( next ) should be sufficent.
> The lock rule will become 1) RT  2) cpu

i had something like this in previous scheduler versions and it was
deadlock land. But i agree that we can do better and i've already started
relaxing the draconian RT locking rules again in my tree. (that's not in
-C1 yet.) But it's much more complex than what you describe, because the
->policy value and ->cpu can change as well, so locking in this manner has
to be done very carefully.

> The estimator has been removed and the prio/timeslice logic has been used.
> Each time there's a swap on arrays the rq counter is increased.

not applied. I had this in the very first version of the O(1) scheduler,
it was called expire_count:

+               unsigned long nr_running, nr_switches, expire_count;

i replaced it with the current estimator, which works much better in a
number of trickier workloads.

> Each time a task is injected inside the run queue its priority is fastly
> updated == bonus for sleeping tasks.
> Each time a task exaust its time slice its priority is decreased, penalty
> for cpu hungry tasks.

i found this to be a too simple approach that doesnt work for some
workloads. The history-based load estimator i wrote is sound from a
theoretical point of view, it calculates an integral of the load value and
thus represents the load history of the task accurately.

this estimator is well-tested under a number of workloads which do break
under simpler schemes like the switch-counter based estimator. (the
4-entry history estimator clearly beats even some estimators that are more
accurate than the switch-count based estimator - like the run/sleep
timestamping estimator or the single-entry history estimator.)

the way i developed/tested the estimator was to put the system under
various extreme loads and i traced interactive processes. If they were not
working smoothly (ie. they were starved of the runqueue despite their
interactive nature) then i changed the estimator.

so if you'd like to replace it then please do not do it casually, trace
the difference under a number of important workloads - i have done so.

	Ingo

