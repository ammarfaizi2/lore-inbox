Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160074-215>; Mon, 15 Mar 1999 06:00:49 -0500
Received: by vger.rutgers.edu id <157389-215>; Mon, 15 Mar 1999 06:00:34 -0500
Received: from chiara.csoma.elte.hu ([157.181.71.18]:31775 "EHLO chiara.csoma.elte.hu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160007-215>; Mon, 15 Mar 1999 05:58:20 -0500
Date: Mon, 15 Mar 1999 11:46:17 +0100 (CET)
From: Ingo Molnar <mingo@chiara.csoma.elte.hu>
Reply-To: Ingo Molnar <mingo@chiara.csoma.elte.hu>
To: Andrea Arcangeli <andrea@e-mind.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.rutgers.edu, Buddha Buck <bmbuck@acsu.buffalo.edu>, Colin McFadden <mcfadden@athenet.net>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] recover losed timer interrupt using the TSC [Re: [patch] kstat change to see how much Linux SMP really scale well]
In-Reply-To: <Pine.LNX.4.05.9903150016110.606-100000@laser.random>
Message-ID: <Pine.LNX.3.96.990315112902.21551A-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Mon, 15 Mar 1999, Andrea Arcangeli wrote:

> I was in the hope of some kind of pipeline since the code in the middle in
> my case was only moving a memory address to a register or to another
> memory address. But as you said the I/O latency is so high that probably
> would obfuscate any kind of clever optimization so I agree that it's
> better to make the code cleaner.

no, even if latency was smaller, the CPU simply does not overlap inb/outb
with preceding/succeeding instructions. even worse, it 'syncs' the
pipeline basically, so by moving instructions _between_ IO instructions
you increase latency. (because we lose the integration effect otherwise
that instruction could get)

> get back a KERN_NOTICE that will tell you how much ticks you lose. Since
> we can do that with a minimal overhead, why not be robust?

this is not necessarily robust. Timekeeping so far was pretty much
independent of the cycle counter. (micro-time is not, but generic
timekeeping yes). Now with your patch if the cycle counter produces
something funny, we'd not only get a message, but also broken time.

i think Andrea you are losing the generic picture. 10 msecs is _alot_ of
time, especially on systems that have a time stamp counter. We should
_not_ block interrupts for more than 10 msecs. If we do then yes we've
lost a few ticks (we've lost them in previous Linux versions too, so this
is certainly nothing new), but now we also get a message so people can fix
it. You've just increased complexity in an already complex and hard to
maintain piece of code to 'fix' the symptom of a fundamentally broken and
rare case, instead of just detecting and fixing the real reason. 

-- mingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
