Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936795AbWLDMz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936795AbWLDMz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936793AbWLDMz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:55:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936792AbWLDMzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:55:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061204100607.GA20529@wotan.suse.de> 
References: <20061204100607.GA20529@wotan.suse.de> 
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 12:55:16 +0000
Message-ID: <29183.1165236916@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:

> Move to an architecture independent rwsem implementation, using the
> better of the two rwsem implementations (ie. the one which doesn't
> take a spinlock to take an uncontested rwsem) as a basis. This gives
> us a single rwsem design instead of two.

Sigh.

NAK again!

You are taking the wrong approach.  If you must collapse the multiple optimised
implementations, then you must choose the spinlock approach.  cmpxchg() may
have be implemented by spinlock on some archs, and so your approach is really
not optimal in such cases.  Not all archs have cmpxchg or any way of doing an
equivalent.  Please don't hold FRV up as an example, because as I've mentioned
before, it does not have an SMP-safe implementation of cmpxchg for multiple
CPUs.  FRV only has XCHG that you can really rely on.

I have another CPU (MN10300/AM33) that we're working on too, and that only has
BSET/BCLR - single bit XCHG basically.  That can't even do the UP emulation the
FRV does.

And if you've got LL/SC equivalents (alpha, mips, powerpc, arm6) then CMPXCHG
is also suboptimal.

If you've got XADD, then CMPXCHG is also suboptimal.  CMPXCHG may have to spin.

Yes, you say "I know people will want to scream because it costs 3 more cycles
on some obscure architecture", but that includes some i386 arch CPUs.  OTOH,
XADD isn't much cheaper there.  On some i386 CPUs, the spinlock algorithm may
be the best.

> If it is a real problem, we could look at extending the asm/mutex.h locking
> helpers to make them usable for rwsem as well.

The asm-mutex stuff is not that nice either.

> This patch needs review and testing from the architecture guys, but
> I would like to consider it because of the obvious maintenance benefits.

Which are?  As far as I know there haven't needed to be any fixes in the rwsem
stuff for some time.

So, what problems are you actually trying to fix?

> Use high level atomic primitives for the implementation, rather than
> open coded assembly. This gives us a single implementation, rather
> than a handful.

But not all CPUs can be optimised the same way, even within the same arch...

> Use atomic_long_t rather than atomic_t for the count, which solves
> the parallelism limitation for those architectures (actually found
> to be a problem with ia64, powerpc and x86-64 may not be far behind).

Then use the spinlock version generically.  You have to take the spinlock in
the slowpath anyway.  This then gives you a maximum number of readers of of
2^30-1.  By trading another bit, you can remove the requirement to also
contemplate the emptiness of the list of waiters.

> Remove one level of indirection (kernel/rwsem.c -> lib/rwsem.c), and
> give a bit of a cleanup (eg remove the fastcall junk) to make the
> code a bit easier to read.

Actually, the code isn't anywhere near as difficult to read as the mutex code
or the spinlock code.  The fastcall "junk" is quite important wrt the i386 code
and permitted a small speedup (though if we compile with regparms=3 nowadays,
then the advantage is actually bypassed).

> Out-of-line the fastpaths,

Why?  I think the fastpaths should be inlined if lockdep is disabled, but Ingo
broke that.

> to bring rw-semaphores into line with mutexes and spinlocks WRT our icache vs
> function call policy.

Which is what?  And why do you assume mutexes and spinlocks are the correct way
to do things?  They may result in slightly smaller code, but they end up with
slower code.

David
