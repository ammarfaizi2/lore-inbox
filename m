Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJPXC5>; Wed, 16 Oct 2002 19:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJPXCP>; Wed, 16 Oct 2002 19:02:15 -0400
Received: from dp.samba.org ([66.70.73.150]:36012 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261456AbSJPXBP>;
	Wed, 16 Oct 2002 19:01:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 16 Oct 2002 19:33:47 +0200."
             <E181s3M-0004C7-00@starship> 
Date: Thu, 17 Oct 2002 08:48:56 +1000
Message-Id: <20021016230712.713B12C076@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E181s3M-0004C7-00@starship> you write:
> (Warning, this is one of those reply-to-every-point posts, read on if you
> have masochistic tendencies.)

Yes, whip me harder.

> On Wednesday 16 October 2002 08:11, Rusty Russell wrote:
> > It needs to be turned off when dealing with any interface which might
> > be used by one of the hard modules.  Which is pretty bad.
> 
> As far as I can see, preemption only has to be disabled during the 
> synchronize_kernel phase of unloading that one module, and this requirement 
> is inherited neither by dependant or depending modules.

No, someone could already have been preempted before you start
synchronize_kernel().

> > > Conceptually, are there any outstanding issues with "hard"
> > > way of unloading modules, assuming we can use the TRY_INC way[1] for
> > > "easy" modules?  One I don't recall being discussed, is the inherent
> > > difficulty of unhooking an interface like LSM, one function at a time.
> > 
> > Without preempt, it was relatively easy (my initial code preceeded
> > preempt).  With preempt, unless you touch the scheduler (I have code
> > for that too, Ingo doesn't like it anyway), a module can't control its
> > own reference counts.
> 
> The current proposal touches the scheduler only in the slow path of 
> preempt_schedule, does it not?  It's hard to see what the objection to that 
> would be.  By the way, do you when I say "schedule on every cpu", is that 
> exactly equivalent to your synchronize_kernel?

Yes, my original version does just that.  The version in the kernel at
the moment (2.5.43) is functionally equivalent.

> > Either way, how do you return "Pretend I wasn't here" in general, if
> > the module is being unloaded?  Only the infrastructure knows what to
> > do.
> > 
> > If a module cannot control its own reference counts, every exported
> > interface which can sleep needs to do the try_inc_modcount thing, or a
> > module which uses it cannot be unloaded.
> 
> But this question goes away if we get our preempt-off switch, no?

Not really.  If the hook disables preemption before calling in, it
might as well simply do try_inc_mod_count() and be done with it.
ie. either way, we have to modify the hook: the module cannot control
its own reference counts.

> > Now, there remains a subtle problem with the try_inc_mod_count
> > approach in general.  It is the "spurious failure" problem, where
> > eg. a notifier cannot inc the module count, and so does not call the
> > registered notifier, but the module is still being initialized *OR* is
> > in the middle of an attempt to remove the module (which fails, and the
> > module is restored to "life").
> 
> For pure counting-style modules, it's easy to avoid this problem: the module
> is placed in the can't-increment state if and only if the current count is 
> zero, and from that point on we know the unload will either succeed or fail 
> with an error.

Still a race between the zero check and the can't-increment state
setting.  This is what my current code does: rmmod itself checks (if
/proc/modules available), then the kernel sets the module to
can't-increment, then checks again.  If the non-blocking flag is set,
it then re-animates the module and fails, otherwise it waits.

BTW, current patchset (2.5.43):

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kbuild_object.patch.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/implicit-init-removal.patch.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/everyone-needs-init.patch.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/module.patch.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/module-i386.patch.gz

> > Will this be a problem in general?  I don't think so, since I couldn't
> > find an example, but it's possible.
> 
> Since it's easy to avoid, why leave the fuzz there?
> 
> Things get more interesting with (the proposed) rmmod -f.  In this case
> some as-yet-undefined mechanism would try to, say, unmount all the 
> filesystems using a given module.  It's just too hard and too much work to
> try do the shy suitor thing here, and determine beforehand if all the 
> unmounts will be successful.  The easy way out is just to say "yes,
> rmmod -f may be unsuccessful but still change the system state, deal with
> it".  An even easier way is just to put rmmod -f on the back burner for
> the time being.

I have two variants of this.  First is the "wait" mentioned above, so
the module will eventually be removed (my latest patch, above, allows
^C to interrupt this).  The second is the "die-mother-fucker-die"
version, which taints the kernel and just removes the damn thing.  For
most people, this is better than a reboot, and will usually "work".

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/force-unload.patch.gz
[ Doesn't apply currently, needs updating ]

> > The major advantage of this scheme is the simplicity for module
> > authors (for the vast majority, no change).  Given the complete dogs
> > breakfast most module authors made of the current module count scheme,
> > that's a HUGE bonus.
> 
> Yes, well, for "easy" modules, all the interfaces that are on the table
> or in use are simple.  Hard modules require some care on the part of the 
> author, but we knew that.  IMHO, the important thing is to be able to state 
> the rules clearly.

Agreed.  I wrote a document to enumerate the conditions.  I will
revise it today as I update the rest of my patches to 2.5.43...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
