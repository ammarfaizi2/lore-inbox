Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVGNS4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVGNS4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGNSxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:53:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5548 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263081AbVGNSuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:50:21 -0400
Date: Thu, 14 Jul 2005 11:50:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       "David A. Wheeler" <dwheeler@ida.org>, Tony Jones <tonyj@immunix.com>
Subject: Re: rcu-refcount stacker performance
Message-ID: <20050714185053.GF1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050714142107.GA20984@serge.austin.ibm.com> <20050714152321.GB1299@us.ibm.com> <20050714134450.GB7296@sergelap.austin.ibm.com> <20050714165936.GE1299@us.ibm.com> <20050714171357.GA23309@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714171357.GA23309@serge.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 12:13:57PM -0500, serue@us.ibm.com wrote:
> Quoting Paul E. McKenney (paulmck@us.ibm.com):
> > On Thu, Jul 14, 2005 at 08:44:50AM -0500, serue@us.ibm.com wrote:
> > > Quoting Paul E. McKenney (paulmck@us.ibm.com):
> > > > My guess is that the reference count is indeed costing you quite a
> > > > bit.  I glance quickly at the patch, and most of the uses seem to
> > > > be of the form:
> > > > 
> > > > 	increment ref count
> > > > 	rcu_read_lock()
> > > > 	do something
> > > > 	rcu_read_unlock()
> > > > 	decrement ref count
> > > > 
> > > > Can't these cases rely solely on rcu_read_lock()?  Why do you also
> > > > need to increment the reference count in these cases?
> > > 
> > > The problem is on module unload: is it possible for CPU1 to be
> > > on "do something", and sleep, and, while it sleeps, CPU2 does
> > > rmmod(lsm), so that by the time CPU1 stops sleeping, the code it
> > > is executing has been freed?
> > 
> > OK, but in the above case, "do something" cannot be sleeping, since
> > it is under rcu_read_lock().
> 
> Oh, but that's not quite what the code is doing, rather it is doing:
> 
> 	rcu_read_lock
> 	while get next element from list
> 		inc element.refcount
> 		rcu_read_unlock
> 		do something
> 		rcu_read_lock
> 		dec refcount
> 	rcu_read_unlock

Color me blind this morning...  :-/  Yes, "do something" can legitimately
sleep.  Sorry for my confusion!

> What I plan to try next is:
> 
> 	rcu_read_lock
> 	while get next element from list
> 		if (element->owning_module->state != LIVE)
> 			continue
> 		rcu_read_unlock
> 		do something
> 		rcu_read_lock
> 	rcu_read_unlock
> 
> > > Because stacker won't remove the lsm from the list of modules
> > > until mod->exit() is executed, and module_free(mod) happens
> > > immediately after that, the above scenario seems possible.
> > 
> > Right, if you have some other code path that sleeps (outside of
> > rcu_read_lock(), right?), then you need the reference count for that
> > code path.  But the code paths that do not sleep should be able to
> > dispense with the reference count, reducing the cache-line traffic.
> 
> Most if not all of the codepaths can sleep, however.  So unfortunately
> that doesn't seem a feasible solution.  That's why I'm hoping there is
> something inherent in the module unload code that I can take advantage
> of to forego my own refcounting.

OK, so the only way that elements are removed is when a module is
unloaded, right?

If your module trick does not pan out, how about the following:

o	Add a "need per-element reference count" global variable

o	Have a per-CPU reference-count variable.

o	Make your code snippet do something like the following:

	rcu_read_lock()
	while get next element from list
		if (need per-element reference count)
			ref = &element.refcount
		else
			ref = &__get_cpu_var(stacker_refcounts)
		atomic_inc(ref)
		rcu_read_unlock()
		do something
		rcu_read_lock()
		atomic_dec(ref)
	rcu_read_unlock()

o	The point is to (hopefully) reduce the cache thrashing associated
	with the reference counts.

At module unload time, do something like the following:

	need per-element reference count = 1
	synchronize_rcu()
	for_each_cpu(cpu)
		while (per_cpu(stacker_refcounts,cpu) != 0)
			sleep for a bit

	/* At this point, all CPUs are using per-element reference counts */

If this approach does not reduce cache thrashing enough, one could use
a per-task reference count instead of a per-CPU reference count.  The
downside of doing this per-task approach is that you have to traverse
the entire task list at unload time.  But module unloading should be
quite rare.  If doing the per-task approach, you don't need atomic
increments and decrements for the reference count, and you have excellent
cache locality.

							Thanx, Paul
