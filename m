Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRIHQcU>; Sat, 8 Sep 2001 12:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271276AbRIHQcK>; Sat, 8 Sep 2001 12:32:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270229AbRIHQcB>; Sat, 8 Sep 2001 12:32:01 -0400
Date: Sat, 8 Sep 2001 09:28:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <jdike@karaya.com>
Subject: Re: expand_stack fix [was Re: 2.4.9aa3]
In-Reply-To: <20010908180416.Z11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109080917180.3489-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Sep 2001, Andrea Arcangeli wrote:
>
> In short you agree that the current locking is broken but you propose to
> limit the usability of GROWSDOWN and GROWSUP solely to the anonymous
> vmas instead of fixing the pgoff race with proper locking as I did.

Yes. Note that GROWSUP has never been implemented, and doesn't work. And
the only normal usage for GROWSDOWN is the stack(s), which through being
anonymous never cares about pgoff anyway.

Note that in theory, GROWSUP would be supported on platforms that have a
stack growing upwards (HP-PA, I think), but as far as I know those
architectures just use a fixed mapping instead.

> My fix for the race doesn't drop the usability of GROWSDOWN that could
> otherwise break userspace programs. I guess at least uml uses growsdown
> vma file backed. Jeff?

It does?

GROWSDOWN doesn't actually tend to be all that useful - even for the stack
we could easily just use a fixed size segment these days. I don't think
other OS's do anything like it, and the only real reason for having
GROWSDOWN is actually a historical mistake - Linux didn't really use to
honour or care about things like stack size limits, which meant that there
was no good default "size" - so GROWSDOWN was a clever way to try to avoid
the problem.

"Clever", of course, is all a matter of context - it made a lot more sense
back when the VM layer didn't have to worry about concurrecy etc at all.

In short, I would not be entirely against just getting rid of GROWSDOWN/UP
altogether, with a fixed (well, dynamic based on rlimit) mapping for the
stack. That would also make it a lot more trivial to do things like the
guard page etc - without impacting any regular code.

> it would still require the fail path in case of the faliure (multiple
> readers potentially all trying to upgrade the lock) so I ignored the
> optimization (expand_stack isn't a very fast path anyways).

Note that we can't even just fall back on the "drop read-lock and
re-aquire s real write-lock", because the page fault might be happening
while the faulter already holds a read lock (core dumping does things like
this, other places might too). That means that your error case doesn't
really have any way to fix things up, so you'd have to actually fail the
page-in - which in turn implies that you'd bet pretty much random failures
depending on subtle past history.. Not good.

> if you are 100% sure it's acceptable to break the kernel API for the
> GROWSDOWN file backed vmas (which I don't think it's the case) I can
> switch to your suggested fix

I'd be _very_ surprised if any real application uses growsdown with
backing store. Anybody?

		Linus

