Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTAPBWc>; Wed, 15 Jan 2003 20:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTAPBWc>; Wed, 15 Jan 2003 20:22:32 -0500
Received: from dp.samba.org ([66.70.73.150]:4998 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266955AbTAPBW3>;
	Wed, 15 Jan 2003 20:22:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Wed, 15 Jan 2003 06:33:49 -0300."
             <20030115063349.A1521@almesberger.net> 
Date: Thu, 16 Jan 2003 12:12:25 +1100
Message-Id: <20030116013125.ACE0F2C0A3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030115063349.A1521@almesberger.net> you write:
> Rusty Russell wrote:
> > 1) It's simply not a good idea to force 1600 modules to change, no
> >    matter what timescale.
> 
> That's the part that I don't believe. The kernel interfaces
> aren't static. Locking rules have changed several times, the
> wait/sleep interface has changed, the concept of a module
> owner has been added, various other interfaces have changed.

Deprecating every module, and rewriting their initialization routines
is ambitious beyond the scale of anything you have mentioned.  Not
that 90% of the kernel code couldn't use a damn good spring cleaning,
but I'm not prepared to make such a change personally.

And remember why we're doing it: for a fairly obscure race condition.

> > And changing it in a way that is *more*,
> >    not *less* complex is even worse.
> 
> The implementation may be more complex, but the change I'm
> suggesting would greatly simplify the rules: no endless set
> of voodoo rites, but one simple rule: "the shutdowncall
> function either does nothing, and returns failure, or it
> returns success, and completely de-registers everything it
> has previously registered".

So we go from:

int init(void)
{
	if (!register_foo(&foo))
		return -err;
	if (!register_bar(&bar)) {
		unregister_foo(&foo);
		return -err;
	}
	return 0;
}

void fini(void)
{
	unregister_foo(&foo);
	unregister_bar(&bar);
}

to:

int fini(void)
{
	if (!unregister_foo(&foo))
		return -err;
	if (!unregister_bar(&bar)) {
		if (!register_foo(&foo))
			????
		return -err;
	}
	return 0;
}

> > PS.  The *implementation* flaw in your scheme: someone starts using a
> >      module as you try to deregister it.
> 
> If a callback comes in at the wrong moment, the module can
> choose to de-register and wait until the subsystem has
> finished any callbacks, or detect that it's about to
> shut itself down, and fail the callback. The point is that
> all the locking is now under control of the module, and
> not scattered all over kernel+module(s).

Something like this?

static int i_am_live;
static spinlock_t my_lock = SPIN_LOCK_UNLOCKED;

/* This is our registered function. */
static int foo_function(void *somedata)
{
	int live;

	spin_lock(&my_lock);
	live = i_am_live;
	spin_unlock(&my_lock);
	if (!live)
		return -EIGNOREME???;
	...
}

int fini(void)
{
	spin_lock(&my_lock);
	i_am_live = 0;
	spin_unlock(&my_lock);

	if (!unregister_foo(&foo)) {
		spin_lock(&my_lock);
		i_am_live = 1;
		spin_unlock(&my_lock);
		return -err;
	}
	if (!unregister_bar(&bar)) {
		if (!register_foo(&foo))
			????
		spin_lock(&my_lock);
		i_am_live = 1;
		spin_unlock(&my_lock);
		return -err;
	}
	return 0;
}

Now, if someone tries to remove a module, but it's busy, you get a
window of spurious failure, even though the module isn't actually
removed.  Secondly, there is often no way of returning a value which
says "I'm going away, act as if I'm not here": only the level above
can sanely know what it would do if this were not found.

> > (ie. you can never unload security modules),
> 
> Hmm, what makes security modules (what exactly do you mean
> by that ?) special ? In any case, a module that's truly
> unloadable would simply return failure from its
> shutdowncall.

On a busy system, they're never not being used.  Your unload routine
would always fail.  Same with netfilter modules.

> > or you leave it half unloaded (even worse).
> 
> There's always the choice of just sleeping through any
> inconvenient callbacks. In some cases, this is perfectly
> acceptable, because the callback won't keep the module
> busy for a long time anyway (interrupts, timers, tasklets,
> etc.). In other cases (e.g. "open" functions), a callback
> could keep it busy forever.

Exactly.  It's kept there forever, while the module is useless.

> The problem I see with the current module interface is that it
> just tries to hack the current mess into a less buggy state,
> but doesn't provide much of an incentive for actually cleaning
> up the interfaces.
> 
> Avoiding the bugs is good, but we should also work towards a
> clean long-term solution.

The current scheme is clean: it's two-stage delete with a nice helper
function "try_module_get()" which tells you when it's going away, and
no requirement that modules actually implement two-stage delete
themselves.  The patch to mirror this in two-stage init was posted
yesterday, as well.

It also puts the (minimal) burden in the right place: in the interface
coder's lap, not the interface user's lap.

Unfortunately, I don't have the patience to explain this once for
every kernel developer.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
