Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSKRBj0>; Sun, 17 Nov 2002 20:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSKRBj0>; Sun, 17 Nov 2002 20:39:26 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:3819 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261321AbSKRBjY>;
	Sun, 17 Nov 2002 20:39:24 -0500
Date: Mon, 18 Nov 2002 01:46:12 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
Message-ID: <20021118014612.GA2483@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain> <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  - the async nature of CLONE_CHILD_SETTID is just bound to cause 
>    interesting-to-debug behaviour

Fun for debuggers and tracers, certainly.  It could be made
synchronous by selecting the new tid value and storing it in the
SETTID address before the mm is cloned.

> Hmm.. I really ahve to say that I just prefer the current two flags,

Agreed, but for different reasons than you gave.

>  - the the for is _not_ a CLONE_VM, the child is really an independent 
>    VM thing, and we should not even _allow_ the parent to change the VM of 
>    the child: the SETTID behaviour (where it changes the parent VM) makes 
>    sense and is good, but we should probably disallow CLEARTID altogether 
>    for that case (and if the independent child wants to clear its own 
>    memory space on exit, it should just do a set_tid_address() itself)
> 
> In fact, from what I can tell, your new CLONE_CHILD_SETTID really is 100% 
> semantically equivalent to the child just doing a "set_tid_address()" on 
> its own.

Don't get this in a muddle.  As far as I can tell, the only purpose of
set_tid_address() is to set the address for _CLEARTID_.  (As a bonus,
it returns the tid so that the caller can save the value, but that's
just an optimisation).

So, CLONE_CHILD_SETTID is not at all similar to calling
set_tid_address() in the child.

That said, you're still right.  There should be two flags, and these
are the simple, obvious semantics:

   1. CLONE_SETTID sets the child's tid in the parent's memory.
      In the child's memory, if CLONE_VM is not set, the tid word will
      have whatever value was stored in it before the parent called
      clone().  Unless I've misread the code, this is the behaviour we
      have now.

   2. CLONE_CLEARTID sets tid_address in the child (only the child).
      It is equivalent to calling set_tid_address() first thing in the
      child.

Note that these semantics make sense, and the implementation is very
simple.  There is no problem with allowing CLEARTID always.

The race condition which Ulrich brought up, which requires
CLONE_CHILD_SETTID to be used without CLONE_PARENT_SETTID, only occurs
when using the same address to store the tid of the forked child as
the parent's tid address.  In other words, it's a user space error.
(Please correct me if I'm mistaken, Ulrich).

Finally, it would be kinder to everyone if CLONE_SETTID stored the
child's tid in _both_ the parent and child address spaces, atomically
w.r.t. debuggers.  The simplest way to do that is to store the child's
tid value in the parent's memory before cloning the mm.  If thread
creation fails, that's fine because the parent knows.

-- Jamie
