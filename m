Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSAZAkm>; Fri, 25 Jan 2002 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSAZAkd>; Fri, 25 Jan 2002 19:40:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17683 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288919AbSAZAkX>; Fri, 25 Jan 2002 19:40:23 -0500
Date: Fri, 25 Jan 2002 16:39:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, David Howells wrote:
>
>  * improves base syscall latency by approximately 5.4% (dual PIII) or 3.6%
>    (dual Athlon) as measured by lmbench's "lat_syscall null" command against
>    the vanilla kernel.

Looking at the code, I suspect that 99.9% of this "improvement" comes from
one thing, and one thing only: you removed the "cli" in the system call
return path.

Yes, you probably removed two other instructions too, but those other
instructions should have paired beautifully and should not be noticeable
in benchmarks.

The thing is, that "cli" was there for a reason, and we should think hard
about removing it. Removing the cli introduces a race condition where we
can otherwise return to user mode with "need_resched" or "signal_pending"
set.

Now, I don't disagree at all with putting those flags into a common word
and optimizing some of the code to test them at the same time, but I _do_
mind bad benchmarking.

Do we care about the race? Possibly not. It doesn't cause data corruption
or anything like that, but it can cause (for example), real-time processes
not getting scheduled when they should have been, or signals being
delayed.

In short:

 - Try removing the "cli" from the standard tree, and I bet you'll get
   basically the same speedups.

 - this "atomically return to user mode and test flags" thing needs to be
   discussed. I'm personally inclined to think that that "cli" is really
   needed, but 5% on simple system calls is a strong argument.

NOTE! There are potentially other ways to do all of this, _without_ losing
atomicity. For example, you can move the "flags" value into the slot saved
for the CS segment (which, modulo vm86, will always be at a constant
offset on the stack), and make CS=0 be the work flag. That will cause the
CPU to trap atomically at the "iret".

(I doubt that is a good approach, as the trap itself is going to be
_quite_ expensive, on the order of several hundreds of cycles, and we'd
basically slow down signal handling and rescheduling by that amount. I'm
pointing it out more as a clever - as opposed to intelligent - alternate
approach that doesn't lose atomicity).

		Linus

