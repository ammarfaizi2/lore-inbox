Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSHLRQp>; Mon, 12 Aug 2002 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSHLRQp>; Mon, 12 Aug 2002 13:16:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45329 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318752AbSHLRQo>; Mon, 12 Aug 2002 13:16:44 -0400
Date: Mon, 12 Aug 2002 10:22:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
cc: Skip Ford <skip.ford@verizon.net>, "Adam J. Richter" <adam@yggdrasil.com>,
       <ryan.flanigan@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31: modules don't work at all
In-Reply-To: <3D574972.DD878928@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208121016001.2274-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> Yes, that's the problem.   qm_symbols() is performing copy_to_user()
> inside lock_kernel() and that's an "atomic copy_to_user()" in 2.5.31.
> But only if preempt is selected.  The copy_to_user() doesn't work.
> 
> There's nothing illegal about copy_to_user() inside lock_kernel().
> 
> Linus, we can back out the preempt_count() test in there and
> perform the atomic copy_*_user via a current->flags bit, or
> we can do something else?

Since I'm actually hoping that the kernel lock goes away some day, and I 
don't want to pollute the stuff that I hope will _not_ go away, I'd prefer 
a slightly different approach, namely make kernel_lock() special from a 
preempt_count() angle.

In particular, we already "sort" the preemtion count bits according to
just how atomic we are, and lock_kernel is certainly "less atomic" than a
spinlock. So the logical thing to do (I think) is to just make that more
explicit, and make lock_kernel use the low bit of preempt_count, and make
regular spinlocks do a "+= 2" instead of a "+= 1".

That way preempt_count() gives you a much better picture of what the state
of this process is (the name "preempt_count" really gives the wrong notion
these days, since it's really much more generic and is already used for
things that have little to do with preemption any more)

Robert, mind looking into this?

			Linus

