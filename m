Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132772AbRDKS2U>; Wed, 11 Apr 2001 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132761AbRDKS2L>; Wed, 11 Apr 2001 14:28:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132742AbRDKS17>; Wed, 11 Apr 2001 14:27:59 -0400
Date: Wed, 11 Apr 2001 11:27:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bernd Schmidt <bernds@redhat.com>
cc: Andreas Franck <afranck@gmx.de>,
        David Howells <dhowells@cambridge.redhat.com>, <andrewm@uow.edu.au>,
        <bcrl@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix
In-Reply-To: <Pine.LNX.4.30.0104111606010.1106-100000@host140.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.31.0104111118000.17733-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2001, Bernd Schmidt wrote:
> >
> > The example in there compiles out-of-the box and is much easier to
> > experiment on than the whole kernel :-)
>
> That example seems to fail because a "memory" clobber only tells the compiler
> that memory is written, not that it is read.

The above makes no sense. The notion of "memory is written" is a true
superset of the "memory is read", and must be a complete memory barrier
(ie telling the compiler that "we read memory" is non-sensical: it can't
give the compiler any more information).

Because the memory clobber doesn't tell _what_ memory is clobbered, you
cannot consider memory dead after the instruction. As such, the compiler
HAS to treat a clobber as a "read-modify-write" - because on a very
fundamental level it _is_. Clobbering memory is logically 100% equivalent
to reading all of memory, modifying some of it, and writing the modified
information back.

(This is different from a "clobber specific register" thing, btw, where
the compiler can honestly assuem that the register is dead after the
instruction and contains no useful data. That is a write-only dependency,
and means that gcc can validly use optimization techniques like removing
previous dead writes to the register.)

See? Do you see why a "memory" clobber is _not_ comparable to a "ax"
clobber? And why that non-comparability makes a memory clobber equivalent
to a read-modify-write cycle?

In short: I disagree 100%. A "memory" clobber -does- effectively tell the
compiler that memory is read. If the compiler doesn't realize that, then
it's a compiler bug waiting to happen. No ifs, buts of maybes.

			Linus

