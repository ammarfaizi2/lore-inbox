Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWGGATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWGGATw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGGATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:19:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34493 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751100AbWGGATv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:19:51 -0400
Date: Thu, 6 Jul 2006 16:39:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060706233909.GN1316@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0607061603320.5768-100000@iolanthe.rowland.org> <1152226204.21787.2093.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152226204.21787.2093.camel@stark>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 03:50:03PM -0700, Matt Helsley wrote:
> On Thu, 2006-07-06 at 16:28 -0400, Alan Stern wrote:
> > I've been trying to come up with a way to allow SRCU structures to be
> > initialized statically rather than dynamically.  The per-cpu data makes it
> > quite hard.  Not only do you have to use different routines to access
> > static vs. dynamic per-cpu data, there's just no good way to write a
> > static initializer.  This is because the per-cpu data requires its own
> > separate definition, and there's no way to call DEFINE_PER_CPU from within 
> > an initializer.
> > 
> > Here, in outline, is the best I've been able to come up with.  It uses a
> > function pointer member to select the appropriate sort of per-cpu data
> > access.  You would use it like this:
> > 
> > PREDEFINE_SRCU(s);
> > static DEFINE_SRCU(s);
> > ...
> > idx = srcu_read_lock(&s);
> > ... etc ...
> > 
> > Alternative possibilities involve an entire parallel implementation for
> > statically-initialized structures (which seems excessive) or using a
> > runtime test instead of a function pointer to select the dereferencing
> > mechanism.
> > 
> > Can anybody suggest anything better?
> > 
> > Alan Stern
> 
> I started to come up with something similar but did not get as far. I
> suspect the runtime test you're suggesting would look like:
> 
> #include <asm/sections.h>
> 
> ...
> if ((per_cpu_ptr >= __per_cpu_start) && (per_cpu_ptr < __per_cpu_end)) {
>     /* staticly-allocated per-cpu data */
>     ...
> } else {
>     /* dynamically-allocated per-cpu data */
>     ...
> }
> ...
> 
> I think that's easier to read and understand than following a function
> pointer.

Is this what the two of you are getting at?

#define DEFINE_SRCU_STRUCT(name) \
	DEFINE_PER_CPU(struct srcu_struct_array, name) = { 0, 0 }; \
	struct srcu_struct name = { \
		.completed = 0, \
		.per_cpu_ref = NULL, \
		.mutex = __MUTEX_INITIALIZER(name.mutex) \
	}

#define srcu_read_lock(ss) \
	({ \
		if ((ss)->per_cpu_ref != NULL) \
			srcu_read_lock_dynamic(&ss); \
		else { \
			int ret; \
			\
			preempt_disable(); \
			ret = srcu_read_lock_static(&ss, &__get_cpu_var(ss)); \
			preempt_enable(); \
			ret; \
		} \
	})

int srcu_read_lock_dynamic(struct srcu_struct *sp)
{
	int idx;

	preempt_disable();
	idx = sp->completed & 0x1;
	barrier();  /* ensure compiler looks -once- at sp->completed. */
	per_cpu_ptr(sp->per_cpu_ref, smp_processor_id())->c[idx]++;
	srcu_barrier();  /* ensure compiler won't misorder critical section. */
	preempt_enable();
	return idx;
}

int srcu_read_lock_static(struct srcu_struct *sp, srcu_struct_array *cp)
{
	int idx;

	idx = sp->completed & 0x1;
	barrier();  /* ensure compiler looks -once- at sp->completed. */
	cp->c[idx]++;
	srcu_barrier();  /* ensure compiler won't misorder critical section. */
	return idx;
}

And similarly for srcu_read_unlock()?

I sure hope that there is a better way!!!  For one thing, you cannot pass
a pointer in to srcu_read_lock(), since __get_cpu_var's name mangling would
fail in that case...

							Thanx, Paul
