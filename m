Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbRGXPhK>; Tue, 24 Jul 2001 11:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267567AbRGXPhB>; Tue, 24 Jul 2001 11:37:01 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64774 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267569AbRGXPgr>; Tue, 24 Jul 2001 11:36:47 -0400
Date: Tue, 24 Jul 2001 08:35:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Hubicka <jh@suse.cz>
cc: Andrea Arcangeli <andrea@suse.de>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010724110216.C3955@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0107240815040.29354-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Jan Hubicka wrote:
>
> What I was concerned about is for example scenario:
> 1) cse realizes that given variable is constnat in some region of program
>    (by seeing an conjump).

Note that just about _every_ single global in the whole kernel is
"volatile" in this sense.

In fact, I can't think of a single (interesting) global that cannot be
changed by another thread at any time.

What makes this even more interesting, of course, is that with SMP you
also have various memory ordering models, so many classic algorithms
simply will not work: one classic algorithm is to know about update order
and avoid locking by using optimistic algorithms:

	do {
		x = (volatile) value1;
		y = (volatile) value2;
	} while (x != (volatile) value1);

the above is a completely valid algorithm in a strictly ordered system,
but it simply WILL NOT WORK on SMP.

How do we handle globals in the kernel? We use locking.

It's really that simple. We _always_ use locking to a first approximation.
And the locking code takes care to tell gcc that gcc cannot optimize
memory movements of assume that memory is constant.

This is just a basic fact of life.

There are other valid algorithms, but they have to be secondary if only
because they are a lot harder to think about and validate.

One is to use memory ordering constraints. Note that in this one
"volatile" simply doesn't help. Even with "volatile" maybe (and this is
debatable - gcc does not actually have a very good definition of what
volatile means even for a purely gcc implementation standpoint) forcing
ordering with the compiler, it doesn't force any ordering in the hardware.

In fact, there have been CPU's at least designed that simply will not be
guaranteed to pick up changes by another CPU without some kind of memory
barrier. On such a CPU it is simply not _possible_ to use

	while ((volatile) jiffies < x)
		/* do nothing */;

because if "jiffies" is updated on another CPU, the first CPU will not
necessarily see it AT ALL. Even though the compiler causes the code to
re-load the value constantly.

An example of this kind of machine? Imagine a P4 that didn't have some
backwards compatibility cruft.. And wonder about some of the reasons that
Intel _really_ wants people to start using "rep ; nop" in these kinds of
loops.

Do we potentially have these bugs? Yes. In the case of "jiffies", we'd be
ok on these kinds of machines simply because all places that do this do so
with interrupts enabled (it wouldn't work on UP otherwise), and interrupts
would end up working as memory barriers in any case.

Ok, so memory ordering is one valid algorithm. And clearly "volatile" is
useless for memory ordering.

Another valid algorithm: "we don't care what the value is, old or new".
This is the one most often used for "jiffies". We simply don't care
enough. We know that jiffies can change at any time, and the code had
better not do anything strange about it anyway. And the code had better be
such that even the compiler cannot do anything really strange with it
either.

"xtime" simply isn't this kind of value. Why? Because it's not even
atomic. It's two 32-bit words, and the operations gcc would use on it
aren't things that we could improve with "volatile".

For "xtime", we're ok with (for example) only looking at one of the fields
(usually xtime.sec), and just not caring _what_ the value is, because we
just copy it into "inode->i_mtime" or something.

But if we have an algorithm that really _does_ care, then "volatile"
really doesn't help. See above on memory ordering etc constraints anyway.

> For instance gcc 3.1 now does load store motion that makes gcc to keep
> global variables in registers much longer than it did originally making
> such risk greater.

I bet that we'll find kernel bugs thanks to it. And I look forward to it,
as that is just a sign of gcc doing a better job. And we'll have to make
sure that we add the locks or the memory ordering things that we missed.

Looking back a few years, we used to have lots of code of the type

	while (!SCpnt->ready) {
		.. do some waiting ..
	}

and gcc was simply too stupid to notice that it could hoist the load of
"SCpnt->ready" outside the loop because the loop did nothing.

Then gcc improved, and for a while we had a _lot_ of "barrier()" calls
added. And we've been fine with this ever since.

Maybe we'll need to add some more. Maybe for xtime. Maybe for something we
haven't even thought about. Bugs are nothing new, and nothing to be really
afraid of.

		Linus

