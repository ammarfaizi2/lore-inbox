Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWGGQsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGGQsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGGQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:48:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59872 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932142AbWGGQsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:48:20 -0400
Date: Fri, 7 Jul 2006 09:33:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matt Helsley <matthltc@us.ibm.com>, linux-kernel@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060707163331.GD1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060706233909.GN1316@us.ibm.com> <Pine.LNX.4.44L0.0607071051430.17135-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607071051430.17135-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 10:58:28AM -0400, Alan Stern wrote:
> On Thu, 6 Jul 2006, Paul E. McKenney wrote:
> 
> > Is this what the two of you are getting at?
> > 
> > #define DEFINE_SRCU_STRUCT(name) \
> > 	DEFINE_PER_CPU(struct srcu_struct_array, name) = { 0, 0 }; \
> > 	struct srcu_struct name = { \
> > 		.completed = 0, \
> > 		.per_cpu_ref = NULL, \
> > 		.mutex = __MUTEX_INITIALIZER(name.mutex) \
> > 	}
> 
> Note that this approach won't work when you need to do something like:
> 
> 	struct xyz {
> 		struct srcu_struct s;
> 	} the_xyz = {
> 		.s = /* What goes here? */
> 	};

Yep, this the same issue leading to my complaint below about not being
able to pass a pointer to the resulting srcu_struct.

> > #define srcu_read_lock(ss) \
> > 	({ \
> > 		if ((ss)->per_cpu_ref != NULL) \
> > 			srcu_read_lock_dynamic(&ss); \
> > 		else { \
> > 			int ret; \
> > 			\
> > 			preempt_disable(); \
> > 			ret = srcu_read_lock_static(&ss, &__get_cpu_var(ss)); \
> > 			preempt_enable(); \
> > 			ret; \
> > 		} \
> > 	})
> > 
> > int srcu_read_lock_dynamic(struct srcu_struct *sp)
> > {
> > 	int idx;
> > 
> > 	preempt_disable();
> > 	idx = sp->completed & 0x1;
> > 	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > 	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
> > 	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > 	preempt_enable();
> > 	return idx;
> > }
> > 
> > int srcu_read_lock_static(struct srcu_struct *sp, srcu_struct_array *cp)
> > {
> > 	int idx;
> > 
> > 	idx = sp->completed & 0x1;
> > 	barrier();  /* ensure compiler looks -once- at sp->completed. */
> > 	cp->c[idx]++;
> > 	srcu_barrier();  /* ensure compiler won't misorder critical section. */
> > 	return idx;
> > }
> > 
> > And similarly for srcu_read_unlock()?
> > 
> > I sure hope that there is a better way!!!  For one thing, you cannot pass
> > a pointer in to srcu_read_lock(), since __get_cpu_var's name mangling would
> > fail in that case...
> 
> No, that's not what we had in mind.

Another approach I looked at was statically allocating a struct
percpu_data, but initializing it seems to be problematic.

So here are the three approaches that seem to have some chance
of working:

1.	Your approach of dynamically selecting between the
	per_cpu_ptr() and per_cpu() APIs based on a flag
	within the structure.

2.	Creating a pair of SRCU APIs, reflecting the two
	underlying per-CPU APIs (one for staticly allocated
	per-CPU variables, the other for dynamically allocated
	per-CPU variables).

3.	A compile-time translation layer, making use of
	two different structure types and a bit of gcc
	type comparison.  The idea would be to create
	a srcu_struct_static and a srcu_struct_dynamic
	structure that contained a pointer to the corresponding
	per-CPU variable and an srcu_struct, and to have
	a set of macros that did a typeof comparison, selecting
	the appropriate underlying primitive from the set
	of two.

	This is essentially #2, but with some cpp/typeof
	magic to make it look to the user of SRCU that there
	is but one API.

The goal I believe we are trying to attain with SRCU include:

a.	Minimal read-side overhead.  This goal favors 2 and 3.
	(Yes, blocking is so expensive that the extra check is
	"in the noise" if we block on the read side -- but I
	expect uses where blocking can happen but is extremely
	rare.)

b.	Minimal API expansion.  This goal favors 1 and 3.

c.	Simple and straightforward use of well-understood and
	timeworn features of gcc.  This goal favors 1 and 2.

Based on this breakdown, we have a three-way tie.  I tend to pay less
much attention to (c), which would lead me to choose #2.

Thoughts?  Other important goals?  Better yet, other approaches?

						Thanx, Paul
