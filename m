Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWGGS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWGGS63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGGS63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:58:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1695 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932252AbWGGS62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:58:28 -0400
Date: Fri, 7 Jul 2006 11:59:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060707185903.GE1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060707163331.GD1296@us.ibm.com> <Pine.LNX.4.44L0.0607071345270.6793-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607071345270.6793-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 02:02:27PM -0400, Alan Stern wrote:
> On Fri, 7 Jul 2006, Paul E. McKenney wrote:
> 
> > > Note that this approach won't work when you need to do something like:
> > > 
> > > 	struct xyz {
> > > 		struct srcu_struct s;
> > > 	} the_xyz = {
> > > 		.s = /* What goes here? */
> > > 	};
> > 
> > Yep, this the same issue leading to my complaint below about not being
> > able to pass a pointer to the resulting srcu_struct.
> 
> No, not really.  The problem here is that you can't use DEFINE_PER_CPU 
> inside the initializer for the_xyz.  The problem about not being able to 
> pass a pointer is easily fixed; this problem is not so easy.

Both symptoms of the same problem in my view, but I agree that other
perspectives are possible and perhaps even useful.  ;-)

We agree on the important thing, which is that the approach I was
calling out in the earlier email has some severe shortcomings, and
that we therefore need to do something different.

> > Another approach I looked at was statically allocating a struct
> > percpu_data, but initializing it seems to be problematic.
> > 
> > So here are the three approaches that seem to have some chance
> > of working:
> > 
> > 1.	Your approach of dynamically selecting between the
> > 	per_cpu_ptr() and per_cpu() APIs based on a flag
> > 	within the structure.
> 
> Or a function pointer within the structure.

Agreed, either a function pointer or a flag.

> > 2.	Creating a pair of SRCU APIs, reflecting the two
> > 	underlying per-CPU APIs (one for staticly allocated
> > 	per-CPU variables, the other for dynamically allocated
> > 	per-CPU variables).
> 
> This seems ridiculous.  It would be much better IMO to come up with a 
> least-common-multiple API that would apply to both sorts of variables.
> For example, per-cpu data could be represented by _both_ a pointer and a 
> table instead of just a pointer (static) or just a table (dynamic).

No argument here.

> > 3.	A compile-time translation layer, making use of
> > 	two different structure types and a bit of gcc
> > 	type comparison.  The idea would be to create
> > 	a srcu_struct_static and a srcu_struct_dynamic
> > 	structure that contained a pointer to the corresponding
> > 	per-CPU variable and an srcu_struct, and to have
> > 	a set of macros that did a typeof comparison, selecting
> > 	the appropriate underlying primitive from the set
> > 	of two.
> > 
> > 	This is essentially #2, but with some cpp/typeof
> > 	magic to make it look to the user of SRCU that there
> > 	is but one API.
> 
> This would add tremendous complexity, in terms of how the API is
> implemented, for no very good reason.  Programming is hard enough 
> already...

Leaving out the "tremendous", yes, there would be some machinations.
It would certainly be OK by me if this can be avoided.  ;-)

> > The goal I believe we are trying to attain with SRCU include:
> > 
> > a.	Minimal read-side overhead.  This goal favors 2 and 3.
> > 	(Yes, blocking is so expensive that the extra check is
> > 	"in the noise" if we block on the read side -- but I
> > 	expect uses where blocking can happen but is extremely
> > 	rare.)
> > 
> > b.	Minimal API expansion.  This goal favors 1 and 3.
> > 
> > c.	Simple and straightforward use of well-understood and
> > 	timeworn features of gcc.  This goal favors 1 and 2.
> > 
> > Based on this breakdown, we have a three-way tie.  I tend to pay less
> > much attention to (c), which would lead me to choose #2.
> > 
> > Thoughts?  Other important goals?  Better yet, other approaches?
> 
> I think it's foolish for us to waste a tremendous amount of time on this 
> when the real problem is the poor design of the per-cpu API.  Fix that, 
> and most of the difficulties will be gone.

If the per-CPU API was reasonably unifiable, I expect that it would
already be unified.  The problem is that the easy ways to unify it hit
some extremely hot code paths with extra cache misses -- for example, one
could add a struct percpu_data to each and every static DEFINE_PERCPU(),
but at the cost of an extra cache line touched and extra indirection
-- which I believe was deemed unacceptable -- and would introduce
initialization difficulties for the static case.

So, a fourth possibility -- can a call from start_kernel() invoke some
function in yours and Matt's code invoke init_srcu_struct() to get a
statically allocated srcu_struct initialized?  Or, if this is part of
a module, can the module initialization function do this work?

(Hey, I had to ask!)

						Thanx, Paul
