Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936922AbWLDOqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936922AbWLDOqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936921AbWLDOqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:46:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:51648 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S936916AbWLDOqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:46:38 -0500
Date: Mon, 4 Dec 2006 15:46:34 +0100
From: Nick Piggin <npiggin@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem
Message-ID: <20061204144634.GA14383@wotan.suse.de>
References: <20061204100607.GA20529@wotan.suse.de> <29183.1165236916@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29183.1165236916@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 12:55:16PM +0000, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Move to an architecture independent rwsem implementation, using the
> > better of the two rwsem implementations (ie. the one which doesn't
> > take a spinlock to take an uncontested rwsem) as a basis. This gives
> > us a single rwsem design instead of two.
> 
> Sigh.
> 
> NAK again!
> 
> You are taking the wrong approach.  If you must collapse the multiple optimised
> implementations, then you must choose the spinlock approach.  cmpxchg() may

No I don't. Either approach works, and one is better than the current two
approaches. This doesn't have to be the final word on rwsem implementation.

> have be implemented by spinlock on some archs, and so your approach is really
> not optimal in such cases.  Not all archs have cmpxchg or any way of doing an

We do lots of things that aren't optimal for everyone. If it hurts, we can
special case it. This really doesn't, considering the rarity of rwsems.

> equivalent.  Please don't hold FRV up as an example, because as I've mentioned
> before, it does not have an SMP-safe implementation of cmpxchg for multiple
> CPUs.  FRV only has XCHG that you can really rely on.

FRV doesn't have an SMP port, and I frankly can't read the future and
know that you plan to do an SMP port in a year's time and what the code
looks like.

I honestly couldn't see why you went on this tangent last time and I
can't see your point now.  If FRV only has an SMP safe xchg, then it
will need to implement SMP atomics with spinlocks anyway, to get things
like add_return. 

> I have another CPU (MN10300/AM33) that we're working on too, and that only has
> BSET/BCLR - single bit XCHG basically.  That can't even do the UP emulation the
> FRV does.

And this is relevant how? Why do you imagine that atomic_cmpxchg
is so much harder than atomic_add_unless, atomic_add_return (or
even atomic_add) on an architecture like this?

> And if you've got LL/SC equivalents (alpha, mips, powerpc, arm6) then CMPXCHG
> is also suboptimal.
> 
> If you've got XADD, then CMPXCHG is also suboptimal.  CMPXCHG may have to spin.
> 
> Yes, you say "I know people will want to scream because it costs 3 more cycles
> on some obscure architecture", but that includes some i386 arch CPUs.  OTOH,
> XADD isn't much cheaper there.  On some i386 CPUs, the spinlock algorithm may
> be the best.

Nor did I understand this objection last time. You must have just read the
description, rather than the code. I *do* use xadd on x86 for down read (ie.
atomic_add_return). And the place where I use cmpxchg *already* uses cmpxchg
on i386. Ditto for alpha and powerpc (which are the ones implementing their
own rwsem.h of your above list).

Actually all these architectures will generate basically identical code
(ignoring ool vs inline). So will all the UP architectures that supress
interrupts for atomic ops.

> > If it is a real problem, we could look at extending the asm/mutex.h locking
> > helpers to make them usable for rwsem as well.
> 
> The asm-mutex stuff is not that nice either.

Which is why I'd prefer not to use it. The current rwsem stuff is much
worse though, which is why I'd consider it.

> > This patch needs review and testing from the architecture guys, but
> > I would like to consider it because of the obvious maintenance benefits.
> 
> Which are?  As far as I know there haven't needed to be any fixes in the rwsem
> stuff for some time.
> 
> So, what problems are you actually trying to fix?

2 designs, 8 or so implementations (some subtly different) implemented in
arch specific asm. That's the main problem, not actual code bugs.

> > Use high level atomic primitives for the implementation, rather than
> > open coded assembly. This gives us a single implementation, rather
> > than a handful.
> 
> But not all CPUs can be optimised the same way, even within the same arch...

And the day someone shows that it makes the slightest difference, we
could do something specific for a given CPU of a given arch. As I said,
this isn't the last change we make to rwsems.

> > Use atomic_long_t rather than atomic_t for the count, which solves
> > the parallelism limitation for those architectures (actually found
> > to be a problem with ia64, powerpc and x86-64 may not be far behind).
> 
> Then use the spinlock version generically.  You have to take the spinlock in
> the slowpath anyway.  This then gives you a maximum number of readers of of
> 2^30-1.  By trading another bit, you can remove the requirement to also
> contemplate the emptiness of the list of waiters.

I moved to the implementation on the most widely used and tested arch,
as well as the ones which have the most parallelism and weakly ordered
memory (i386, powerpc, ia64). I figure this is likely to be adequately
scalable and have less chance of being buggy.

> > Remove one level of indirection (kernel/rwsem.c -> lib/rwsem.c), and
> > give a bit of a cleanup (eg remove the fastcall junk) to make the
> > code a bit easier to read.
> 
> Actually, the code isn't anywhere near as difficult to read as the mutex code
> or the spinlock code.  The fastcall "junk" is quite important wrt the i386 code
> and permitted a small speedup (though if we compile with regparms=3 nowadays,
> then the advantage is actually bypassed).

No objections, then?

> > Out-of-line the fastpaths,
> 
> Why?  I think the fastpaths should be inlined if lockdep is disabled, but Ingo
> broke that.

I'm fairly sure that Ingo did not "break" anything. The decision was made to
out of line these things. Please do take it up in another thread if you like.
I will be happy to inline things if you get agreement.

> > to bring rw-semaphores into line with mutexes and spinlocks WRT our icache vs
> > function call policy.
> 
> Which is what?  And why do you assume mutexes and spinlocks are the correct way
> to do things?  They may result in slightly smaller code, but they end up with
> slower code.

Of course the code is slower when it is in L0 icache. I'm sure you know
that smaller code is the whole point...

Thanks,
Nick
