Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUIXRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUIXRnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUIXRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:43:49 -0400
Received: from [69.25.196.29] ([69.25.196.29]:13231 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268944AbUIXRnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:43:43 -0400
Date: Fri, 24 Sep 2004 13:43:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924174301.GB20320@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	linux-kernel@vger.kernel.org
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org> <20040924125457.GO28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924125457.GO28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:54:57AM -0400, Jean-Luc Cooke wrote:
> On Fri, Sep 24, 2004 at 12:38:51AM -0400, Theodore Ts'o wrote:
> > 2.  The kernel will break if CONFIG_CRYPTO is false
> > matter what.  This was a design decision that was made long ago, to
> > simplify user space applications that could count on /dev/random ...
> 
> My naive point of view tells me either this design decision from days of
> yore was not thought out properly (blasphemy!), or the cryptoapi needs to
> be in kernel.

There is some historical issues here --- namely, back in the early
1990's crypto still had significant export control issues, so we
didn't want to put any crypto code into the core kernel.  So we didn't
have *any* encryption algorithms in the kernel at all.  As to whether
or not cryptoapi needs to be mandatory in the kernel, the question is
aside from /dev/random, do most people need to have crypto in the
kernel?  If they're not using ipsec, or crypto loop devices, etc.,
they might not want to have the crypto api in their kernel
unconditionally.

That aside, it's been demonstrated through a lot of experience, to the
point of it being a principle of software engineering, that optional
interfaces significantly complicate the users of that interface.  In
order to encourage applications to use /dev/random, we wanted to make
it something that people could guarantee would be there.  Random
numbers are important!

> A compromise would be to have a primitive PRNG in random.c is no
> CONFIG_CRYRPTO is present to keep things working.

Now *that*'s an extremely ill-considered idea.  It means that an
application can without any warning, can have its strong source of
random numbers replaced with a weak random number generator.  It
should be blatently obvious why this is a specatularily bad, horrific
idea.

>  - why do linux users want information secure random numbers?  Wouldn't
>    crypto-secure random numbers be what they really want?

If they only want crypto-secure random numbers, they can do it in
userspace.  Information secure random numbers is something the kernel
can provide, because it has low-level access to entrpoy sources.  So
why not try to do the best possible job? 

This by the way your complaint that /dev/random is "too slow" is a
complete red herring.  When do you need more than 6 megs of random
numbers per second?  And if the application just needs crypto-secure
random numbers, then the application can just extract 32 bytes or so
of randomness from /dev/random, and then do the CRNG in userspace, at
which point it will be even faster, since the data won't have to
copied from kernel to userspace.

> The design used by PGP and
> > /dev/random both limit the amount of reliance placed in the crypto
> > algorithms, where as Fortuna and Yarrow both assume that crypto
> > primitives are 100% strong.  This is again a philosophical divide;
> > given that we have access to unpredicitability based on hardware
> > timings, we should limit the dependence on crypto algorithsm and to
> > design a system that is closer to "true randomness" as possible.  
> 
> What if I told the SHA-1 implementation in random.c right now is weaker
> than those hashs in terms of collisions?  The lack of padding in the
> implementation is the cause.  HASH("a\0\0\0\0...") == HASH("a") There
> are billions of other examples.

This is another red herring.  First of all, we're not using the hash
as a MAC, or in any way where we would care about collisions.
Secondly, all of the places where we take a hash, we are always doing
it 16 bytes at a time, which is SHA's block size, so that there's no
need for any padding.  And although you didn't complain about it,
that's also why we don't need to mix in the length in the padding;
extension attacks just simply aren't an issue, since the way we are
using the hash, that just simply an issue as far as the strength of
/dev/random.


> Vanilla random.c depends on SHA-1 be to be resistant to 1-st pre-image
> attacks.  Fortuna depends on this as well with SHA-256 (or whatever
> other hash you put in there).  

Incorrect, vanilla random.c does *not* depend on SHA-1's resistance to
1st pre-image attacks.  In other words, even if you did have an oracle
which given a SHA-1 hash will give you a string which hashes to that
value, /dev/random's security properties would not be affected.  Just
because you have *a* string which hashes to that value, that won't
help you find the contents of the pool.

That's my whole point.  We have not changed SHA-1 to make it stronger;
we simply have carefully designed /dev/random to minimize its reliance
on crypto primitives, since we have so much entropy available to us
from the hardware.  Fortuna, in contrast, has the property that if its
cryptoprimitives are broken, you might as well go home.

						- Ted
