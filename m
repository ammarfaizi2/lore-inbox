Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319496AbSIMBvK>; Thu, 12 Sep 2002 21:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319487AbSIMBuR>; Thu, 12 Sep 2002 21:50:17 -0400
Received: from dp.samba.org ([66.70.73.150]:9936 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319484AbSIMBuK>;
	Thu, 12 Sep 2002 21:50:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Thu, 12 Sep 2002 15:44:01 +0200."
             <Pine.LNX.4.44.0209121520300.28515-100000@serv> 
Date: Fri, 13 Sep 2002 11:30:47 +1000
Message-Id: <20020913015502.1D43F2C070@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209121520300.28515-100000@serv> you write:
> Hi,
> 
> On Thu, 12 Sep 2002, Rusty Russell wrote:
> 
> > Nope, that's one of the two problems.  Read my previous post: the
> > other is partial initialization.
> >
> > Your patch is two-stage delete, with the additional of a usecount
> > function.  So you have to move the usecount from the module to each
> > object it registers: great for filesystems, but I don't think it buys
> > you anything (since they were easy anyway).
> 
> I'm aware of the init problem, what I described was the core problem,
> which prevents any further cleanup.

I don't think of either of them as core, they are two problems.

> The usecount is optional, the only important question a module must be

Yes, for sure.  So why check the use count at all?

> able to answer is: Are there any objects/references belonging to the
> module? It's a simple yes/no question. If a module can't answer that, it
> likely has more problem than just module unloading.

Ah, we're assuming you insert synchronize_kernel() between the call
to stop and the call to exit?

In which case *why* do you check the use count *inside* exit_affs_fs?
Why not get exit_module() to do "if (mod->usecount() != 0) return
-EBUSY; else mod->exit();"?

There's the other issue of symmetry.  If you allocate memory, in
start, do you clean it up in stop or exit?  Similarly for other
resources: you call mod->exit() every time start fails, so that is
supposed to check that mod->start() succeeded?

Of course, separating start into "init" and "start" allows you to
solve the half-initialized problem as well as clarify the rules.

================

I disagree with pushing the count into the filesystem structure: it
changes nothing except hide the fact that you're only keeping
reference counts for the sake of the module.  Filesystems are low
performance impact, but other subsystems really don't want that atomic
inc and dec for every access.  See my implementation (for those in the
audience: http://www.kernel.org/pub/linux/kernel/people/rusty/
	
	if (down_interruptible(&module_mutex))
		return -EINTR;

	mod = find_module(name);
	if (!mod) {
		ret = -ENOENT;
		goto out;
	}
	if (!mod->stop && !mod->exit) {
		/* This module can't be removed */
		ret = -EBUSY;
		goto out;
	}

	if (mod->stop) {
		ret = mod->stop();
		if (ret != 0) goto out;
	}

	/* Remove symbols so module count can't increase */
	spin_lock_irq(&modlist_lock);
	list_del_init(&mod->symbols.list);
	spin_unlock_irq(&modlist_lock);

	/* This may or may not decrement to zero.  We may be waiting
	   for someone else who is holding a reference. */
	set_current_state(TASK_UNINTERRUPTIBLE);
	mod->waiting = current;
	module_put(mod);
	schedule();

	/* Wait to ensure that noone is executing inside a module right now */
	synchronize_kernel();

	/* Final destruction now noone is using it. */
	if (mod->exit) mod->exit();
	free_module(mod);
	ret = 0;

Now, I chose to leave the usage count checks as a userspace problem,
and *not* to do call ->start again in this implementation, but sleep
until the refcount hits 0.

This works better for my in ip_conntrack, since ideally the usage
count is a count of the number of packets we're tracking, which is
under control of the outside world, so I wanted an "rmmod -f".

I think either way is valid: effectively, where I do the wait, you do
the check and reinitialize the module ("oh oh!").

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
