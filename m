Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318685AbSHEQeg>; Mon, 5 Aug 2002 12:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318700AbSHEQeg>; Mon, 5 Aug 2002 12:34:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26373 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318685AbSHEQef>; Mon, 5 Aug 2002 12:34:35 -0400
Date: Mon, 5 Aug 2002 09:38:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user
 mode linux]
In-Reply-To: <20020805163910.C7130@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Aug 2002, Jamie Lokier wrote:

> Linus Torvalds wrote:
> > I agree that it is really sad that we have to save/restore FP on
> > signals, but I think it's unavoidable.
> 
> Couldn't you mark the FPU as unused for the duration of the
> handler, and let the lazy FPU mechanism save the state when it is used
> by the signal handler?

Nope. Believe me, I gave some thought to clever things to do. 

The kernel won't even _see_ a longjmp() out of a signal handler, so the
kernel has a really hard time trying to do any clever lazy stuff.

Also, people who play games with FP actually change the FP data on the
stack frame, and depend on signal return to reload it. Admittedly I've 
only ever seen this on SIGFPE, but anyway - this is all done with integer 
instructions that just touch bitpatterns on the stack.. The kernel can't 
catch it sanely.

> For sophisticated user space uses, like the above, I'd like to see
> a trap handling mechanism that saves only the _minimum_ state.

I would not mind an extra per-signal flag that says "don't bother with FP
saves" (the same way we already have "don't restart" etc), but I would be
very nervous if glibc used it by default (even if glibc doesn't use SSE2
in memcpy, gcc itself can do it, and obviously _users_ may just do it
themselves).

So it would have to be explicitly enabled with a SA_NOFPSIGHANDLER flag or 
something.

(And yes, it's the FP stuff that takes most of the time. I think the 
lmbench numbers for signal delivery tripled when that went in).

		Linus

