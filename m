Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319633AbSH3R5N>; Fri, 30 Aug 2002 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319634AbSH3R5N>; Fri, 30 Aug 2002 13:57:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:206 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319633AbSH3R5M>;
	Fri, 30 Aug 2002 13:57:12 -0400
Date: Fri, 30 Aug 2002 20:05:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301038240.1307-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208301947100.1519-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Linus Torvalds wrote:

> > i'm starting to wonder whether it's possible at all (theoretically) to
> > have a mutex design which has the current semaphore implementation's good
> > fastpath properties, but could also be used on stack.
> 
> That's is my point. I don't think there is - although I suspect that
> many architectures could easily do it. For all I know, there might well
> be some tricks we could play on x86 with cmpxchg8b, for example.

it might also make sense to let semaphores really be a function call.  
Right now our semaphore fastpath goes like:

 770:   b9 24 00 00 00          mov    $0x24,%ecx
 7d5:   f0 ff 0d 24 00 00 00    lock decl 0x24
 77b:   0f 88 57 01 00 00       js     8d8

if down() was a function call, it would be like:

 790:   b8 24 00 00 00          mov    $0x24,%eax
 795:   e8 fc ff ff ff          call   796 <dummy2+0x6>

ie. 10 bytes icache footprint, vs. 18 bytes icache footprint in the
inlined variant (17 bytes on UP).

In a typical vmlinux there are 300 down()s, so this would save more than
2K of instructions off the hotpath. [even if only half of those down()s
are truly performance critical, it's 1K off.]

[btw., gcc load %ecx in the fastpath, which looks wrong, perhaps an
optimization bug in the inline assembly?]

and in that case we could implement semaphores by letting them take the
waitqueue spinlock even in the fastpath - it's not a scalability problem
because that cacheline must be exclusive-locked anyway for the atomic op.

and by doing that we could implement more complex things like fairness, or
writers-preferred-over-readers type of semantics much more easily - and
*many* of the subtle races would simply go away, since we'd be able to
assume a frozen semaphore state.

i suspect such a semaphore implementation would take only about 2-3 cycles
more than the current one, in the fastpath.

> But I simply think that our current "completion vs semaphore" split is a
> pretty good one conceptually. [...]

agreed. I used semaphores for completion purposes for quite some time and
in quite many pieces of code, and completions are just so much more
logical in naming.

	Ingo

