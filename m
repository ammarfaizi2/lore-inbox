Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967671AbWLARVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967671AbWLARVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936535AbWLARVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:21:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42642 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S936534AbWLARVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:21:51 -0500
Date: Fri, 1 Dec 2006 17:21:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: [RFC] timers, pointers to functions and type safety
Message-ID: <20061201172149.GC3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There's a bunch of related issues, some kernel, some gcc,
thus the Cc from hell on that one.

First of all, in theory the timers in kernel are done that way:
	* they have callback of type void (*)(unsigned long)
	* they have data to be passed to it - of type unsigned long
	* callback is called by the code that even in theory has no
chance whatsoever of inlining the call.
	* one of the constraints on the targets we can port the kernel
on is that unsigned long must be uintptr_t.

The last one means that we can pass any pointers to these suckers; just
cast to unsigned long and cast back in the callback.

While that is safe (modulo the portability constraint that affects much
more code than just timers), it ends up very inconvenient and leads to
lousy type safety.

The thing is, absolute majority of callbacks really want a pointer to
some object.  There is a handful of cases where we really want a genuine
number - not a pointer cast to unsigned long, not an index in array, etc.
They certainly can be dealt with.  Nearly a thousand of other instances
definitely want pointers.

Another observation is that quite a few places are playing fast and
loose with function pointers.  Some are just too lazy and cast
void (*)(void) to void (*)(unsigned long).  These, IMO, should stop
wanking and grow an unused argument.  Not worth the ugliness...
However, there are other cases, including very interesting
	timer->function = (void (*)(unsigned long))func;
	timer->data = (unsigned long)p;
with func actually being void (void *) and p being void *.

Now, _that_ is definitely not a valid C.  Worse, it doesn't take much
to come up with realistic architecture that would have different calling
conventions for those.  Just assume that
	* there are two groups of registers (A and D)
	* base address for memory access must be in some A register 
	* both A and D registers can be used for arithmetics
	* ABI is such that functions with few arguments have them passed
via A and D registers, with pointers going via A and numbers via D.
Realistic enough?  I wouldn't be surprised if such beasts actually existed -
embedded processors influenced by m68k are not particulary rare and picking
such ABI would make sense for them.

Note that this kind of casts is not just in some obscure code; e.g.
rpc_init_task() does just that.


And that's where it gets interesting.  It would be very nice to get to
the following situation:
	* callbacks are void (*)(void *)
	* data is void *
	* instances can take void * or pointer to object type
	* a macro SETUP_TIMER(timer, func, data) sets callback and data
and checks if func(data) would be valid.

It would be remove a lot of cruft and definitely improve the type safety
of the entire thing.  It's not hard to do; all it takes [warning: non
portable C ahead] is
	typeof(*data) *p = data;
	timer->function = (void (*)(void *))func;
	timer->data = (void *)p;
	(void)(0 && (func(p),0));

Again, that's not a portable C, even leaving aside the use of typeof.
Casts between the incompatible function types are undefined behaviour;
rationale is that we might have different calling conventions for those.
However, here we are at much safer ground; calling conventions are not
likely to change if you replace a pointer to object with void *.  It's
still possible in theory, but let's face it, we would have far worse
problems if it ever came to porting to such targets.

Note that here we have absolutely no possibility of eventual call
ever being inlined, no matter what kind of analysis compiler might
be doing.  Call happens when kernel/timer.c gets to structure while
trawling the lists and it simply has no way to tell which callback
might be there (as the matter of fact, callback can and often does
come from a module).

IOW, "gcc would ICE if it ever inlined it" kind of arguments (i.e. what
had triggered gcc refusing to do direct call via such cast) doesn't apply
here.  Question to gcc folks: can we expect no problems with the approach
above, provided that calling conventions are the same for passing void *
and pointers to objects?  No versions (including current 4.3 snapshots)
create any problems here...

BTW, similar trick would be very useful for workqueues - there we already
have void * as argument, but extra type safety would be nice to have.


Now, there's another question: how do we get there?  Or, at least, from
current void (*)(unsigned long) to void (*)(void *)...

"A fscking huge patch flipping everything at once" is obviously not an
answer; too much PITA merging and impossible to review.  There is a tempting
possibility to do that gradually, with all intermediates still in working
state, provided that on all platforms currently supported by the kernel
unsigned long and void * are indeed passed the same way (again, only for
current kernel targets and existing gcc versions).  Namely, we could
	* introduce SETUP_TIMER variant with cast to void (*)(unsigned long)
	* switch to its use, converting callback instances to take pointers
at the same time.  That would be done in reasonably sized groups.
	* once it's over, flip ->function to void (*)(void *), ->data to
void * and update SETUP_TIMER accordingly; deal with remaining few instances
of ->function.
That way we at least get that sucker chopped into reasonable pieces and
do not introduce broken intermediate trees.  Evil casts to void (*)(unsigned
long) will be gone by the end of the series, so they are not there to
stay - just a way to avoid too bad breakage in the middle of series.
Of course, that strategy only works if all currently supported targets
*do* allow that kind of casts; if there are any counterexamples, it's
back to the drawing board and we'd better fix sunrpc ASAP - it does pull
that sort of trick.
