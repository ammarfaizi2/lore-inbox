Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWGGT7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWGGT7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGGT7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:59:18 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:4368 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932254AbWGGT7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:59:17 -0400
Date: Fri, 7 Jul 2006 15:59:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>, <tytso@us.ibm.com>,
       Darren Hart <dvhltc@us.ibm.com>, <oleg@tv-sign.ru>,
       Jes Sorensen <jes@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
In-Reply-To: <20060707185903.GE1296@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0607071523330.6793-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Paul E. McKenney wrote:

> > I think it's foolish for us to waste a tremendous amount of time on this 
> > when the real problem is the poor design of the per-cpu API.  Fix that, 
> > and most of the difficulties will be gone.
> 
> If the per-CPU API was reasonably unifiable, I expect that it would
> already be unified.  The problem is that the easy ways to unify it hit
> some extremely hot code paths with extra cache misses -- for example, one
> could add a struct percpu_data to each and every static DEFINE_PERCPU(),
> but at the cost of an extra cache line touched and extra indirection
> -- which I believe was deemed unacceptable -- and would introduce
> initialization difficulties for the static case.

Here's a sketch of a possible approach.  Generalizing it and making it 
look pretty are left as exercises for the reader.  :-)

In srcu_struct, along with

	struct srcu_struct_array *per_cpu_ref;

add
	struct percpu_data *per_cpu_table;

Dynamic initialization does:

	sp->per_cpu_ref = NULL;
	sp->per_cpu_table = alloc_percpu(...);

Static initialization does:

	sp->per_cpu_ref = PER_CPU_ADDRESS(...);		/* My macro
		from before; gives the address of the static variable */

	sp->per_cpu_table = (struct percpu_data *)
		~(unsigned long) __per_cpu_offset;

Then the unified_per_cpu_ptr(ref, table, cpu) macro would expand to
something like this:

({
	struct percpu_data *t = (struct percpu_data *)~(unsigned long)(table);
	RELOC_HIDE(ref, t->ptrs[cpu]);
})

Making this work right would of course require knowledge of the intimate
details of both include/linux/percpu.h and include/asmXXX/percpu.h.  
There's some ambiguity about what t above points to: a structure
containing an array of pointers to void, or an array of unsigned longs.  
Fortunately I think it doesn't matter.

Doing it this way would not incur any extra cache misses, except for the 
need to store an extra member in srcu_struct.

> So, a fourth possibility -- can a call from start_kernel() invoke some
> function in yours and Matt's code invoke init_srcu_struct() to get a
> statically allocated srcu_struct initialized?  Or, if this is part of
> a module, can the module initialization function do this work?
> 
> (Hey, I had to ask!)

That is certainly a viable approach: just force everyone to use dynamic 
initialization.  Changes to existing code would be relatively few.

I'm not sure where the right place would be to add these initialization 
calls.  After kmalloc is working but before the relevant notifier chains 
get used at all.  Is there such a place?  I guess it depends on which 
notifier chains we convert.

We might want to leave some chains using the existing rw-semaphore API.  
It's more appropriate when there's a high frequency of write-locking
(i.e., things registering or unregistering on the notifier chain).  The 
SRCU approach is more appropriate when the chain is called a lot and 
needs to have low overhead, but (un)registration is uncommon.  Matt's task 
notifiers are a good example.

Alan Stern

