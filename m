Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCCK01>; Sat, 3 Mar 2001 05:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRCCK0Q>; Sat, 3 Mar 2001 05:26:16 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:43534 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S130438AbRCCK0I>; Sat, 3 Mar 2001 05:26:08 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context
In-Reply-To: <200103030931.f239Vvo124697@saturn.cs.uml.edu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: "Albert D. Cahalan"'s message of "Sat, 3 Mar 2001 04:31:57 -0500 (EST)"
Date: 03 Mar 2001 04:26:06 -0600
Message-ID: <vbar90ftagx.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> 
> So you change it to 2... but what about the "float" type? It gets
> a mixture of 64-bit and 32-bit IEEE arithmetic depending rather
> unpredictably on compiler register allocations and optimizations???

Well, yes, but I'll try not to cry myself to sleep over it.  I'm
tempted to say that someone who chooses to use "float"s has given up
all pretense of caring about the answers they get.  And, if they
really want to do predictable math with floats they can change the FPU
control word from whatever its default is to PC==0.

I guess if I had to choose between two default control word settings
so that either (A) "float" arithmetic is unpredictable but "double"
arithmetic is predictable, corresponds to 64-bit IEEE arithmetic, is
invariant under different compiler optimization settings, matches the
compiler's handling of constant folding, and mimics the behavior on
i386 FreeBSD and NetBSD and most modern, non-i386 architectures; or
(B) "float" and "double" arithmetic are both unpredictable and
non-IEEE; I'd choose (A).

> If a "float" will have excess precision, then a "double" might
> as well have it too. Usually it helps, but sometimes it hurts.
> This is life with C on x86.

That's the way I initially felt, and it looks silly when it's written
down, so I'm glad I changed my mind.

I don't think extra precision that is unpredictable is ever helpful.
Extra precision that might be gained or lost depending on, say, which
branch of an if-statement is taken, is of no use to anyone.  It just
causes confusion.  The excess precision on "float" is a nuisance.  The
excess precision on "double" is another nuisance.  It would be nice to
eliminate one of those nuisances, at least by default.

> Ugh, more start-up crud.

The startup crud is already there.  It's used to allow linking with
"-lieee" to set a new control word value, for example, and it's
inelegant and ugly.  Because we don't want to set the control word on
a non-FPU program and defeat the lazy FPU context initialization, we
compare the value of the control word we want with a value hard-coded
into the library that's supposed to match the value hard-coded into
the kernel.  If the two values differ, we set the control word to the
new value (whether the program actually ends up ever executing an FPU
instruction or not).

To me, a system call (not necessarily a *new* system call, but some
way to get the desired FPU control word to the kernel) seems like a
more elegant solution.

On the other hand, I'm not married to the idea.  I'd rather just get
the default control word changed in the kernel.

Kevin <buhr@stat.wisc.edu>
