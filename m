Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSJRCTj>; Thu, 17 Oct 2002 22:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262794AbSJRCTj>; Thu, 17 Oct 2002 22:19:39 -0400
Received: from dp.samba.org ([66.70.73.150]:6635 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262788AbSJRCTD>;
	Thu, 17 Oct 2002 22:19:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks 
In-reply-to: Your message of "Thu, 17 Oct 2002 19:20:10 +0200."
             <E182EJl-0004Rd-00@starship> 
Date: Fri, 18 Oct 2002 12:04:15 +1000
Message-Id: <20021018022503.1E5F52C24A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E182EJl-0004Rd-00@starship> you write:
> > The current spinlock is horrible.
> 
> Is it?  You must be thinking about much more intensive use of the spinlock as
> with per-op calls as opposed to per-attach (mount).  I'd planned to make the 
> spinlocks per-module, but your per-cpu code looks just fine.

Actually, after I thought about it harder, I was inspired by your
point that the race can be prevented with a spinlock (as currently
done).  I spent last night writing a new solution to this (I'm testing
it now), which works as follows:

/* We only need protection against local interrupts. */
#ifndef __HAVE_ARCH_LOCAL_INC
#define local_inc(x) atomic_inc(x)
#define local_dec(x) atomic_dec(x)
#endif

static inline int try_module_get(struct module *module)
{
	int ret = 1;

	if (module) {
		unsigned int cpu = get_cpu();
		if (likely(module->live))
			local_inc(&module->ref[cpu]);
		else
			ret = 0;
		put_cpu();
	}
	return ret;
}

static inline void module_put(struct module *module)
{
	if (module) {
		unsigned int cpu = get_cpu();
		local_dec(&module->ref[cpu]);
		/* Maybe they're waiting for us to drop reference? */
		if (unlikely(!module->live))
			wake_up_process(module->waiter);
		put_cpu();
	}
}

Now, these are both short, sweet, and cache-local.  The unload stage
becomes harder.  We stop all the reference counts by scheduling a
thread on every cpu, then having them all do a local_irq_disable.
This means we know that the refcounts won't change, and we can safely
sum them.  If they're zero (or the non-block flag isn't set), we set
"module->live" to false and release the CPUs.

Now, in the sleeping case, I sleep uninterruptible, but drop the
module mutex first, so other module stuff can happen at the same time.

This completely prevents the spurious unload race.

> > I don't know of any code which does this now, but it is at least a
> > theoretical problem.
> 
> To resolve this, start the module in can-increment state, do the module 
> initialization, register the notifiers, and finally register the interface.
> In other words, the module never needs to be in can't-increment state at 
> initialization.  (The module writer must ensure they have the correct, 
> raceless initial state of whatever the notifiers are notifying about, which 
> strikes me as a little tricky in itself.)

Yes, this basically means two-state init for modules, which I shy
clear of in general.  But if any modules care, they can do this
themselves, though, by setting "THIS_MODULE.live = 1;" to activate
the notifiers during their init routine.

Basically, with the other one solved, I'm happy to place this on the
shoulders of any module which really cares.

> > IMHO, the benifits of having it in-kernel outweigh the slight extra
> > size.
> 
> I'll cast my vote for your in-kernel linker, in the mistaken belief that 
> democracy has anything to do with the question.  Does this make progress 
> towards eliminating one of create_module or init_module?

Yes, query_module, create_module and /proc/ksyms all gone.

> > > > ...The second is the "die-mother-fucker-die"
> 
> I'd use this feature in filesystem development, regardless of the risks, 
> since I regularly do worse things to the kernel anyway.  But don't you think 
> the rmmod parameter should be different for the ask-nicely vs the 
> shoot-in-the-head flavor?  How about -f -f or -F for the latter?

Yes, currently:
	rusty@mingo:~$ /sbin/rmmod       
	Usage: /sbin/rmmod [--wait|-f] <modulename>
	  The --wait option begins a module removal even if it is used
	  and will stop new users from accessing the module (so it
	  should eventually fall to zero).
	  The -f option forces a module unload, and may crash your
	  machine.  This requires the Forced Module Removal option
	  when the kernel was compiled.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
