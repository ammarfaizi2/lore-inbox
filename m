Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSJQRON>; Thu, 17 Oct 2002 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbSJQROM>; Thu, 17 Oct 2002 13:14:12 -0400
Received: from dsl-212-144-194-127.arcor-ip.net ([212.144.194.127]:51111 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261539AbSJQRNm>;
	Thu, 17 Oct 2002 13:13:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>, S@samba.org
Subject: Re: [RFC] change format of LSM hooks
Date: Thu, 17 Oct 2002 19:20:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021017075539.8DE762C0CA@lists.samba.org>
In-Reply-To: <20021017075539.8DE762C0CA@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E182EJl-0004Rd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 09:41, Rusty Russell wrote:
> In message <E181zuY-0004Fl-00@starship> you write:
> > On Thursday 17 October 2002 00:48, Rusty Russell wrote:
> > > > On Wednesday 16 October 2002 08:11, Rusty Russell wrote:
> > > > > It needs to be turned off when dealing with any interface which
> > > > > might be used by one of the hard modules.  Which is pretty bad.
> > > > 
> > > > As far as I can see, preemption only has to be disabled during the 
> > > > synchronize_kernel phase of unloading that one module, and this
> > > > requirement is inherited neither by dependant or depending modules.
> > > 
> > > No, someone could already have been preempted before you start
> > > synchronize_kernel().
> > 
> > I don't get that.  The sequence is:
> > 
> >   - turn off preemption
> >   - unhook call points
> >   - synchronize_kernel
> >   - ...
> > 
> > which doesn't leave any preemption hole that I can see, so I can't comment
> > on a couple of the other points until you clear that one up.
> 
> You mean that "turn off preemption" also wakes up anyone currently
> preempted?  Otherwise they're preempted just inside one of those call
> points.

Urk, yes, or just those preempted in kernel.  Which looks doable and not
intrusive, modulo my limited scheduler knowledge.  So synchronize_kernel 
isn't dead yet, though it just got a new flesh wound.

> > > Still a race between the zero check and the can't-increment state
> > > setting.
> > 
> > But that one is easy: the zero check just takes the same spinlock as 
> > TRY_INC_MOD_COUNT, then sets can't-increment only in the case the count
> > is zero, considerably simpler than:
> 
> The current spinlock is horrible.

Is it?  You must be thinking about much more intensive use of the spinlock as 
with per-op calls as opposed to per-attach (mount).  I'd planned to make the 
spinlocks per-module, but your per-cpu code looks just fine.

> > ...The still-initializing case is also easy, e.g., a filesystem module 
> > simply doesn't call register_filesystem until it's completely ready to 
> > service calls, so nobody is able to do TRY_INC_MOD_COUNT.
> 
> Consider some code which needs to know when cpus go up and down, so
> registers a notifier.  If the notifier fires before the init is
> finished, the notifier code will fail to "try_inc_mod_count()" and
> won't call it (it doesn't do try_inc_mod_count at the moment, but
> that's a bug).
> 
> I don't know of any code which does this now, but it is at least a
> theoretical problem.

To resolve this, start the module in can-increment state, do the module 
initialization, register the notifiers, and finally register the interface.
In other words, the module never needs to be in can't-increment state at 
initialization.  (The module writer must ensure they have the correct, 
raceless initial state of whatever the notifiers are notifying about, which 
strikes me as a little tricky in itself.)

> IMHO, the benifits of having it in-kernel outweigh the slight extra
> size.

I'll cast my vote for your in-kernel linker, in the mistaken belief that 
democracy has anything to do with the question.  Does this make progress 
towards eliminating one of create_module or init_module?

> > > ...The second is the "die-mother-fucker-die"
> > > version, which taints the kernel and just removes the damn thing.  For
> > > most people, this is better than a reboot, and will usually "work".
> > 
> > Is there a case where removing a module would actually help?  What is
> > the user going to do next, try to reinsert the same module?
> 
> Insert a fixed one, hopefully 8).

I'd use this feature in filesystem development, regardless of the risks, 
since I regularly do worse things to the kernel anyway.  But don't you think 
the rmmod parameter should be different for the ask-nicely vs the 
shoot-in-the-head flavor?  How about -f -f or -F for the latter?

-- 
Daniel
