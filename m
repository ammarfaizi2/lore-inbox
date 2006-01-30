Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWA3KBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWA3KBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWA3KBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:01:10 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38023 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932195AbWA3KBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:01:08 -0500
Date: Mon, 30 Jan 2006 02:00:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: dada1@cosmosbay.com, dipankar@in.ibm.com, rlrevell@joe-job.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060130100009.GC17848@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060130043604.GF16585@us.ibm.com> <43DD9C49.4000000@cosmosbay.com> <20060130051156.GK16585@us.ibm.com> <20060129.215244.05901896.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129.215244.05901896.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 09:52:44PM -0800, David S. Miller wrote:
> From: "Paul E. McKenney" <paulmck@us.ibm.com>
> Date: Sun, 29 Jan 2006 21:11:56 -0800
> 
> > > If the size is expanded by a 2 factor (or a power of too), can your 
> > > proposal works ?
> > 
> > Yep!!!
> > 
> > Add the following:
> 
> This all sounds very exciting and promising.  I'll try to find some
> spare cycles tomorrow to cook something up.

Cool!  My earlier description did not get rid of all the explicit
memory barriers.  The following updated pseudocode does so.

I will of course be happy to review what you come up with!!!
(And I will be interested to see if this still makes sense after
sleeping on it...)

Improvements welcome as always!!!

						Thanx, Paul

------------------------------------------------------------------------

Data Structures

o	Yes, the names suck, but that is why I usually am happy to
	have other people come up with names...

o	Having separate fvbupd and fvbrdr removes the need for
	(hopefully all) explicit memory barriers.

	struct hashtbl {
		int nbuckets;
		int fvbupd;	/* updater's first valid bucket. */
		int fvbrdr;	/* readers' first valid bucket. */
		struct hash_param params;
		struct list_head buckets[0];
	};

	/* Both fvbupd and fvbrdr need to be initialized to -1. */

	struct hashtbl *current;
	struct hashtbl *not_current;

Switch Pseudocode: assumes that the switcher can block, if not,
then need to make a state machine driven by call_rcu().

o	Wait until at least one grace period has elapsed since the
	previous switch.  Easiest to just put "synchronize_rcu()"
	up front, but can take advantage of naturally occurring
	grace periods that elapsed since the last switch if desired.

o	Initialize the not-current array, including the hash params.
	If the new array is to be different in size, allocate the
	new one and free the not-current array.

o	Use rcu_assign_pointer() to point not_current to (you guessed
	it!) the not-current array.

o	Set current->fvbupd = current->fvbrdr = 0;

o	Wait for a grace period (synchronize_rcu() if blocking OK,
	otherwise call_rcu()...).  The delay guarantees that readers
	are aware that things might be disappearing before we actually
	start making them disappear.

o	Loop until all buckets of current are emptied:

	o	current->fvbrdr = current->fvbupd

		No memory barriers needed because all buckets
		preceding current->fvbupd were emptied at least
		one grace period ago, so any readers that were
		active when any of those buckets were non-empty
		have now completed.

	o	Remove elements from current->bucket[current->fvbupd]
		until the bucket is empty or until we use up our
		alloted quota of time and/or elements.

		o	If we empty the bucket, we of course increment
			current->fvbupd, and if there is time/elements
			left, could continue on the next bucket.

	o	Wait for a grace period.

	-Really- big arrays on really big SMP machines might want
	to have multiple CPUs processing buckets in parallel.  In theory,
	this is not hard, but the fvbrdr update gets messier.

	And yes, there needs to be some sort of update-side locking.
	Per-bucket locking seems like it should work -- one would
	hold the bucket lock for the current array throughout,
	and acquire and release the bucket lock for the non-current
	array on a per-element basis.  One perhaps better way is to
	simply remove the elements from current, and let the readers
	insert them into not_current only upon cache miss.  Getting
	this right requires more insight into the networking code
	than I currently have.

o	Use rcu_assign_pointer() to set current to not_current.

o	Note: leave not_current pointing to the now-current array
	to allow slow readers to complete successfully.  Alternatively,
	one could wait for a grace period, then set non_current to
	NULL (but does not seem worth it).

Table lookup (am assuming that this does rcu_read_unlock() before
returning, but that only makes sense if you have some sort of lock
on the element being returned -- if no such lock, the rcu_read_unlock()
primitives must be removed -- the caller must rcu_read_unlock() instead):

o	rcu_read_lock();

o	c = rcu_dereference(current);

o	Compute hash based on c->params

o	If hash >= c->fvbrdr, do lookup in c->bucket[hash]
	If found, rcu_read_unlock() and return it.

o	If c->fvbrdr is not -1, look the item up in the non-current
	table:

	o	c = rcu_dereference(not_current);

	o	Compute hash based on c->params

	o	Do lookup in c->bucket[hash]

	Note that c->fvbrdr -could- transition to zero here, but
	if it does, we are guaranteed that nothing will actually
	be removed from the current table until we complete.

	And note that we need the non-current lookup even if the
	switch is not populating the non-current array, since the
	readers would be doing so upon cache miss, right?

o	rcu_read_unlock()

o	return what is found or complain appropriately if nothing found.
