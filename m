Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTIPVmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTIPVmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:42:13 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45972 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262474AbTIPVmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:42:07 -0400
Date: Tue, 16 Sep 2003 22:41:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Robert White <rwhite@casabyte.com>
Cc: "'Iker'" <iker@computer.org>, linux-kernel@vger.kernel.org
Subject: RE: self piping and context switching
Message-ID: <20030916214157.GA30188@mail.jlokier.co.uk>
References: <20030916194101.GA29266@mail.jlokier.co.uk> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAXdCgZz9uCkifnVjI6hutcwEAAAAA@casabyte.com> <20030916213826.GA29814@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAXdCgZz9uCkifnVjI6hutcwEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> The guy is writing on a pipe in an attempt to have a thread signal itself,
> and wanted to know if he could do this in a way that wouldn't cause that
> thread to lose its timeslice.

Indeed he was.  I responded to Alan, though, who was talking of
signals and a classic method of handling them:

Alan Cox wrote:
> Sending a message to yourself down a pipe is pretty standard in
> event based programs as a way of turning a signal from asynchronous
> event and thus nuisance to handle into a message.

Robert:
> Thing the first: NEVER write to ANYTHING that can block (like a pipe) in a
> signal handler.  Period.
>
> Thing the second:  Mixing signals and threads is bad, especially if you
> handle it as naively as you outline below.

I, and I believe Alan, were talking about systems _without_ threads...

I.e. a time-honoured technique for turning signals into events in a
portable program.  Of course modern platforms with good threading
don't need to use the technique.

> There are several good techniques for dealing with SIGALRM and SIGCHLD etc
> that will not deadlock the poll, that doesn't need to use any of the
> longjump() variants, and which doesn't do exterior IO.

All the ones you gave require threads, hence I would not consider any
of them portable.  I'll be impressed if you come up with something
that doesn't use threads, pipes or more signals.

> 2) Pick a signal (I like SIGUSR2) and install a handler for it without the
> SA_RESTART bit set.

That's all very well if you're on a system which _has_ SA_RESTART.
Here are some portability notes:

	- Traditional BSD-like systems don't have SA_RESTART.
	  They always restart some system calls on signals.

	- POSIX specifies that signals always interrupt system
	  calls (according to the GNU libc documentation).
	  You cannot make signals restartable.

	- On some threading systems, establishing a signal handler
	  with SA_RESTART not set will cause it to interrupt systems
	  calls in all thread, not just the one it is destined for.

	  If you used this technique, you'd need to take it into
	  account in the code of all threads.

	- Of course, truly portable code has to assume EINTR may be
	  returned by all interruptible system calls anyway.

	- The select() system call is interrupted by signals
	  even when they have SA_RESTART set anyway.  If that's all
	  you want to interrupt, you don't need to mess with the flag.

> When you get a SIGALRM etc, in the handler you check the state of an
> atomic boolean-equivalent (normally an int, but on some embedded
> platforms you should use a char)

It's called sigatomic_t.

> and, if that boolean is set you promote the signal to the
> non-restarting signal by pthread_kill(ing) the specific thread you
> want to wake.  The poll/select being run in that thread will then
> return -1 instead of restarting.

What was that about not mixing signals and threads?

Even when you have a thread library, and it claims to be pthreads, I'd
consider pthread_kill() the most unlikely construct to work portably,
without crashing poll/select, or failing to terminate it, that we've
come up with so far.

Having seen siglongjmp() crash when it's done during select(), I have
not a lot of faith in things working the unix way on all the platforms
I target, let alone pthreads and signals working as specified.

> The above systems will outperform a write-on-pipe wakeup model "on the
> average" anyway, because you almost never drop your timeslice prematurely
> and you spend way less time in kernel-entry/exit space.

Certainly, optimising for the common case is good and so is saving
system calls.  (Believe me, I am very familiar with saving system calls).

I hope this exchange has been entertaining.  As you can see, we have
very different target platforms in mind when we talk of portability.

-- Jamie
