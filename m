Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164381AbWLHCXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164381AbWLHCXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 21:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164379AbWLHCXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 21:23:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:50562 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164378AbWLHCXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 21:23:01 -0500
Date: Fri, 8 Dec 2006 03:22:59 +0100
From: Nick Piggin <npiggin@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem
Message-ID: <20061208022259.GB11551@wotan.suse.de>
References: <20061204144634.GA14383@wotan.suse.de> <20061204100607.GA20529@wotan.suse.de> <29183.1165236916@redhat.com> <25001.1165350982@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25001.1165350982@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 08:36:22PM +0000, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Either approach works, and one is better than the current two approaches.
> 
> >From one point of view that's true.  But from other points of view, it isn't.
> 
> > > have be implemented by spinlock on some archs, and so your approach is
> > > really not optimal in such cases.  Not all archs have cmpxchg or any way
> > > of doing an
> > 
> > We do lots of things that aren't optimal for everyone.
> 
> In this case it can be particularly suboptimal.  The approach you've chosen to
> generalise on is specifically for XADD-based rwsems.  XADD is only available
> on i386, x86_64 and ia64 (FETCHADD), and of those only i386 and ia64 actually
> use the XADD-optimised rwsems.  Andi wants x86_64 to use the spinlock version.
> 
> Everywhere else, XADD is emulated.
> 
> If you have to emulate XADD by using CMPXCHG or LL/SC equivalents, then
> there're actually better ways of doing things than either of these approaches
> that the kernel currently has.  I just need to find the time to explore them.
> 
> Look at how the counter works in the XADD-based version.  That's the way it is
> *because* I'm using XADD.  That's quite limiting.

Not really. ll/sc architectures "emulate" xadd the same as they would
emulate a spinlock. There is nothing suboptimal about it.

Look at alpha or powerpc, for example.

> > If it hurts, we can special case it. This really doesn't, considering the
> > rarity of rwsems.
> 
> If you're willing to special case it, then what's the point in generalising?

Because I don't like the way it is currently done.

> And in case you're wondering, FS-Cache uses a _lot_ of rwsem operations, so I
> do have an interest in making it quick, and that includes undoing what Ingo
> did when it's not necessary.

And I bet you couldn't measure a difference, even on FRV.

> > I honestly couldn't see why you went on this tangent last time and I
> > can't see your point now.  If FRV only has an SMP safe xchg, then it
> > will need to implement SMP atomics with spinlocks anyway, to get things
> > like add_return. 
> 
> That's _exactly_ my point.
> 
> Think!  If you _require_ the use of atomic ops in implementing rwsems, then
> you introduce _extra_, _general_ spinlocks into the XADD-based algorithm
> everywhere you call an atomic_xxx() op that has a side effect.

No, only where you also call down into the contended path. I never
claimed this is optimal for atomics-with-spinlocks architectures, and
I know how they are going to be impacted.

However, it is not 100% clear that they will be slower. For starters,
you are using 2 spinlocks, so if there is a lot of contention, you
can have concurrent down_read()s go through while the rwsem spinlock
is held for a long time while readers are being worken off the wait
list.

> And if you're going to have to be getting general spinlocks then the
> XADD-based rwsem really is worse by quite a bit than the current
> spinlock-based rwsem as the latter _doesn't_ need general spinlocks as it
> doesn't use atomic ops.

It is mostly worse in the contended case, in that it needs to take 2
spinlocks where 1 would do. But for *all* other SMP architectures (ie.
all - sparc32 - parisc) spinlock design is slower when there is
contention. I don't know how you could be advocating the spinlock
version on this basis.

FYI, x86-64 uses spinlocks because of the complexity and task limit
of the xadd algorithm, not because it was measured to be any faster.

> > And this is relevant how? Why do you imagine that atomic_cmpxchg
> > is so much harder than atomic_add_unless, atomic_add_return (or
> > even atomic_add) on an architecture like this?
> 
> It isn't, but atomic_xxx() will _have_ to be implemented with spinlocks.
> 
> My point here was that last time I believe you said that FRV managed to
> implement atomic ops without spinlocks, and so the case wasn't worth
> considering.  My points are that (a) FRV would have to to do SMP, and (b) we
> have another arch lurking in the wings that does have to use spinlocks because
> I can't do the clever tricks there that I can on FRV.

So let's take another look when these are in the kernel.

> > Nor did I understand this objection last time. You must have just read the
> > description, rather than the code. I *do* use xadd on x86 for down read (ie.
> > atomic_add_return)
> 
> I missed the atomic_add_return(), so I'll forgive you that bit.

You mean I'll forgive you ;) I've been trying to tell you this.

> > And the place where I use cmpxchg *already* uses cmpxchg on i386. Ditto for
> > alpha and powerpc (which are the ones implementing their own rwsem.h of your
> > above list).
> > 
> > Actually all these architectures will generate basically identical code
> > (ignoring ool vs inline). So will all the UP architectures that supress
> > interrupts for atomic ops.
> 
> Alpha and powerpc emulate XADD, so see above.

They *implement* atomic_add_return.

> > Which is why I'd prefer not to use it. The current rwsem stuff is much
> > worse though, which is why I'd consider it.
> 
> No, it isn't.  It's much more straightforward; or at least it was until Ingo
> decided to rearrange things.

Well I'm working with the mainline kernel.

Anyway, IMO it is cleaner to have down_read be a generic function which calls
into an arch helper to perform some simple procedure, rather than have
any architecture able implement a completely different algorithm.

> > 2 designs, 8 or so implementations (some subtly different) implemented in
> > arch specific asm.
> 
> Yes, and?

Ah, that explains why you think this is pointless: you don't think that is
a problem. OK... if you think it is not then I won't be able to convince
you otherwise.

> > I moved to the implementation on the most widely used and tested arch,
> > as well as the ones which have the most parallelism and weakly ordered
> > memory (i386, powerpc, ia64). I figure this is likely to be adequately
> > scalable and have less chance of being buggy.
> 
> The spinlock-based approach is easier to verify and has been tested on more
> archs than the other.  I don't think either of them is more buggy than the
> other.  The spinlock-based rwsems are also used on i386 under some
> circumstances.

On UP architectures, maybe. That's not too interesting.

> > > Actually, the code isn't anywhere near as difficult to read as the mutex
> > > code or the spinlock code.  The fastcall "junk" is quite important wrt the
> > > i386 code and permitted a small speedup (though if we compile with
> > > regparms=3 nowadays, then the advantage is actually bypassed).
> > 
> > No objections, then?
> 
> WRONG!
> 
> Remove the fastcall and the i386 rwsems will cease to function if
> CONFIG_REGPARM=n.

WRONG! Because they aren't called by assembly anymore. But if it means
that much to you, the fastcalls can stay.

> > Of course the code is slower when it is in L0 icache. I'm sure you know
> > that smaller code is the whole point...
> 
> Not necessarily.  Faster code may also be the whole point; it depends on what

Do you have to argue everything? I mean the whole point of OOLing spinlocks
and mutexes is to generate smaller code (with associated benefits like
reuse of branch predictor).

Anyway, this is not a big deal. If you want to continue arguing the point,
we can if we get past the other points.

