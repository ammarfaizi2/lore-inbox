Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTAPCeP>; Wed, 15 Jan 2003 21:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAPCeP>; Wed, 15 Jan 2003 21:34:15 -0500
Received: from almesberger.net ([63.105.73.239]:274 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id <S265114AbTAPCeM>;
	Wed, 15 Jan 2003 21:34:12 -0500
Date: Wed, 15 Jan 2003 23:42:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030115234258.E1521@almesberger.net>
References: <20030115063349.A1521@almesberger.net> <20030116013125.ACE0F2C0A3@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116013125.ACE0F2C0A3@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Jan 16, 2003 at 12:12:25PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Deprecating every module, and rewriting their initialization routines
> is ambitious beyond the scale of anything you have mentioned.

Well, it has happened before, e.g. sleep_on is now deprecated,
cli() doesn't give the comprehensive protection it used to,
holding spinlocks while sleeping used to be frowned upon, but
it's only recently that it moved to being forbidden, etc.

And the people making the new rules didn't go and fix every
module in existence. You may get this kind of responsibility
only if you actually break the old interface, but that's not
what I'm suggesting to do.

> And remember why we're doing it: for a fairly obscure race condition.

No, I want to do this to fix the reason for the fix for the
obscure race condition :-)

Also, all this smells of a fundamental design problem: modules
aren't the only things that can become unavailable. So why
construct a special mechanism that only applies to modules ?

> So we go from:

Yes. Note that the problem case only occurs if you have more than
one registration that could block you for a long time. Otherwise,
you just take that one first, and sleep on all the others.

Otherwise, things get messy, I admit. But that's not a new problem
either, e.g.

> int init(void)
> {
> 	if (!register_foo(&foo))
> 		return -err;
> 	if (!register_bar(&bar)) {
> 		unregister_foo(&foo);
> 		return -err;
> 	}
> 	return 0;
> }

What if unregister_foo fails, because somebody already started
to use the foo interface ? If "block until it works" is a valid
answer, you could probably use this also for the unload case.

This would actually work even with the current interface: just
make the module exit function sleep until all references are
gone. This means than rmmod might take a looong time, but is
this really a problem ? If a module wishes to accelerate its
demise, it can always add errors exits. If the interface doesn't
provide error exits, this is again a general problem, and
actually one of the interface.

If there's a really nasty case, where you absolutely can't
afford to sleep, you need to change the service to split
"deregister" into:

 - prepare_deregister (like "deregister", but reversible)
 - commit_deregister
 - undo_deregister

But there probably aren't many cases where you'd really need
this.

> Something like this?

Yes, for instance. Or use atomic operations.

> Now, if someone tries to remove a module, but it's busy, you get a
> window of spurious failure, even though the module isn't actually
> removed.

Correct. But does this matter ? After all, we were prepared to
get failures if the removal succeeds anyway. So this is not a
new race condition.

> Secondly, there is often no way of returning a value which
> says "I'm going away, act as if I'm not here": only the level above
> can sanely know what it would do if this were not found.

Okay, my approach usually puts the responsibility of finally giving
up in user space. If user space just ignores the error, and keeps
the thing open anyway, you're in for a long wait. But that's not
different from opening some device and never releasing it. In
either case, your module becomes un-unloadable, unless you kill
the user-space hog. Again, not a new problem.

> On a busy system, they're never not being used.  Your unload routine
> would always fail.  Same with netfilter modules.

But they're only active for a short time, so the deregistration
could just sleep.

> It also puts the (minimal) burden in the right place: in the interface
> coder's lap, not the interface user's lap.

Well, both need to cooperate. And I don't see why the interface
coder should have to know whether its users are modules or not,
while the interface user, who is implicitly very aware if he's
a module or not, shouldn't.

Also note that this isn't just a module problem. Instead of
tripping over code that all of a sudden isn't there, one may
well trip over a data structure that has just been removed. In
either case, you need to get the synchronization right. What
I'm proposing is simply to make those two cases more similar,
such that handling one case correctly also handles the other
one.

Example:

struct foo *my_data;

int foo_callback()
{
	do_something(my_data->blah);
	...
}

void foo_exit()
{
	deregister(...);
	kfree(my_data);
	...
}

So if "deregister" allows callbacks after it returns, you'll
still end up getting your oops every once in a while.

Now make this a non-module, and if foo_exit or some equivalent
can be called for some other reason (e.g. power-down,
hotplugging, etc.), you a) still have the same problem, and b)
all the miracle protection of try_module_get has vanished. So
you have to do the synchronization twice, i.e. on both sides
of the interface.

> Unfortunately, I don't have the patience to explain this once for
> every kernel developer.

Sorry for being so persistent. But I really think the module
situation is rapidly approaching the point where just fixing
the next bug isn't good enough, but where we need to get back
to the drawing board, look at the larger picture, and then
work towards a cleaner solution.

Also, although the task may seem daunting, don't forget that
even the BLK wasn't removed in a day :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
