Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968677AbWLEUgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968677AbWLEUgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968676AbWLEUgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:36:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39485 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968674AbWLEUgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:36:36 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061204144634.GA14383@wotan.suse.de> 
References: <20061204144634.GA14383@wotan.suse.de>  <20061204100607.GA20529@wotan.suse.de> <29183.1165236916@redhat.com> 
To: Nick Piggin <npiggin@suse.de>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Dec 2006 20:36:22 +0000
Message-ID: <25001.1165350982@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:

> Either approach works, and one is better than the current two approaches.

>From one point of view that's true.  But from other points of view, it isn't.

> > have be implemented by spinlock on some archs, and so your approach is
> > really not optimal in such cases.  Not all archs have cmpxchg or any way
> > of doing an
> 
> We do lots of things that aren't optimal for everyone.

In this case it can be particularly suboptimal.  The approach you've chosen to
generalise on is specifically for XADD-based rwsems.  XADD is only available
on i386, x86_64 and ia64 (FETCHADD), and of those only i386 and ia64 actually
use the XADD-optimised rwsems.  Andi wants x86_64 to use the spinlock version.

Everywhere else, XADD is emulated.

If you have to emulate XADD by using CMPXCHG or LL/SC equivalents, then
there're actually better ways of doing things than either of these approaches
that the kernel currently has.  I just need to find the time to explore them.

Look at how the counter works in the XADD-based version.  That's the way it is
*because* I'm using XADD.  That's quite limiting.

> If it hurts, we can special case it. This really doesn't, considering the
> rarity of rwsems.

If you're willing to special case it, then what's the point in generalising?

And in case you're wondering, FS-Cache uses a _lot_ of rwsem operations, so I
do have an interest in making it quick, and that includes undoing what Ingo
did when it's not necessary.

> I honestly couldn't see why you went on this tangent last time and I
> can't see your point now.  If FRV only has an SMP safe xchg, then it
> will need to implement SMP atomics with spinlocks anyway, to get things
> like add_return. 

That's _exactly_ my point.

Think!  If you _require_ the use of atomic ops in implementing rwsems, then
you introduce _extra_, _general_ spinlocks into the XADD-based algorithm
everywhere you call an atomic_xxx() op that has a side effect.

And if you're going to have to be getting general spinlocks then the
XADD-based rwsem really is worse by quite a bit than the current
spinlock-based rwsem as the latter _doesn't_ need general spinlocks as it
doesn't use atomic ops.

> And this is relevant how? Why do you imagine that atomic_cmpxchg
> is so much harder than atomic_add_unless, atomic_add_return (or
> even atomic_add) on an architecture like this?

It isn't, but atomic_xxx() will _have_ to be implemented with spinlocks.

My point here was that last time I believe you said that FRV managed to
implement atomic ops without spinlocks, and so the case wasn't worth
considering.  My points are that (a) FRV would have to to do SMP, and (b) we
have another arch lurking in the wings that does have to use spinlocks because
I can't do the clever tricks there that I can on FRV.

> Nor did I understand this objection last time. You must have just read the
> description, rather than the code. I *do* use xadd on x86 for down read (ie.
> atomic_add_return)

I missed the atomic_add_return(), so I'll forgive you that bit.

> And the place where I use cmpxchg *already* uses cmpxchg on i386. Ditto for
> alpha and powerpc (which are the ones implementing their own rwsem.h of your
> above list).
> 
> Actually all these architectures will generate basically identical code
> (ignoring ool vs inline). So will all the UP architectures that supress
> interrupts for atomic ops.

Alpha and powerpc emulate XADD, so see above.

> Which is why I'd prefer not to use it. The current rwsem stuff is much
> worse though, which is why I'd consider it.

No, it isn't.  It's much more straightforward; or at least it was until Ingo
decided to rearrange things.

> > So, what problems are you actually trying to fix?
> 
> 2 designs, 8 or so implementations (some subtly different) implemented in
> arch specific asm.

Yes, and?

> That's the main problem, not actual code bugs.

That's not actually a problem.  It's done that way specifically so that the
arches _can_ override it if they have a more optimal way to implement things.

That's the whol point of having separate arch code.

Don't generalise just for the sake of generalising things.

> > But not all CPUs can be optimised the same way, even within the same arch...
> 
> And the day someone shows that it makes the slightest difference, we
> could do something specific for a given CPU of a given arch. As I said,
> this isn't the last change we make to rwsems.

You still haven't given a good reason for making your change.

Rwsems can be overridden now for different CPUs if you wish.

> > Then use the spinlock version generically.  You have to take the spinlock in
> > the slowpath anyway.  This then gives you a maximum number of readers of of
> > 2^30-1.  By trading another bit, you can remove the requirement to also
> > contemplate the emptiness of the list of waiters.
> 
> I moved to the implementation on the most widely used and tested arch,
> as well as the ones which have the most parallelism and weakly ordered
> memory (i386, powerpc, ia64). I figure this is likely to be adequately
> scalable and have less chance of being buggy.

The spinlock-based approach is easier to verify and has been tested on more
archs than the other.  I don't think either of them is more buggy than the
other.  The spinlock-based rwsems are also used on i386 under some
circumstances.

> > > Remove one level of indirection (kernel/rwsem.c -> lib/rwsem.c), and
> > > give a bit of a cleanup (eg remove the fastcall junk) to make the
> > > code a bit easier to read.
> > 
> > Actually, the code isn't anywhere near as difficult to read as the mutex
> > code or the spinlock code.  The fastcall "junk" is quite important wrt the
> > i386 code and permitted a small speedup (though if we compile with
> > regparms=3 nowadays, then the advantage is actually bypassed).
> 
> No objections, then?

WRONG!

Remove the fastcall and the i386 rwsems will cease to function if
CONFIG_REGPARM=n.

> > Why?  I think the fastpaths should be inlined if lockdep is disabled, but
> > Ingo broke that.
> 
> I'm fairly sure that Ingo did not "break" anything.

Okay, "broke" is a bit strong.  It still works, but it injects an unnecessary
extra function call for each operation done if lockdep is disabled.

> Of course the code is slower when it is in L0 icache. I'm sure you know
> that smaller code is the whole point...

Not necessarily.  Faster code may also be the whole point; it depends on what
you want.  Enforcing a function call has various effects on what the compiler
does at the point of consideration.  By tailoring the i386 machine code, I was
able to avoid forcing the compiler to realise it was making a function call at
all, and only that it had to have the address of the semaphore in EAX when
doing an rwsem op.  This meant that down_read() was _very_ efficient.  It only
had two instructions interpolated into the main run of code, and normally the
conditional jump would not be taken.

However, someone's changed that also, so it may well not be worth doing the
XADD-based rwsems in i386 any more, and that arch should probably revert to
the spinlock-based rwsems now.

I don't remember seeing anyone benchmarking the change made, but since it has
to do with DWARF unwinding, it's probably necessary.

David
