Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbRGQGlA>; Tue, 17 Jul 2001 02:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267779AbRGQGkl>; Tue, 17 Jul 2001 02:40:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10257 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267778AbRGQGkd>; Tue, 17 Jul 2001 02:40:33 -0400
Date: Mon, 16 Jul 2001 23:40:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.4.6] PPID of a process is set to itself
In-Reply-To: <wv5813yb.wl@nisaaru.open.nm.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.33.0107162325120.933-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Tachino Nobuhiro wrote:
> At Mon, 16 Jul 2001 21:41:56 -0700,
> Linus Torvalds wrote:
> >
> > HOWEVER, the bug you hit is because CLONE_THREAD also implies
> > CLONE_PARENT, and the fork() code didn't actually enforce this. So
> > instead of your patch, we just should not allow the parent and the child
> > to be in the same thread group. Suggested real patch appended. Does this
> > fix it for you too?
>
> Thank you for the patch.
> I tried it and found the the process cloned by my test program became
> the zombie child of my shell and is not reaped because the shell is
> not expecting the process.

Right.

That, however, is because you're using CLONE_THREAD in a manner it wasn't
really meant to be used (but now it is purely _your_ problem, and will no
longer cause processes that cannot be reaped by anybody).

The real design for CLONE_THREAD is basically to allow pthreads-like
thread handling by having pthread_create() do roughly something like this:

	static int has_created_master_process = 0;

	if (!has_created_master_process) {
		new_me = clone(CLONE_VM | SIGCHLD);
		if (new_me > 0) {
			/* Original thread turns into master process */
			printf("I am the new master process, bow down before me!\n");
			has_created_master_process = 1;
			for (;;) {
				if (!waitpid(-1, NULL, 0))
					continue;
				if (errno == ENOCHLD)
					exit(0);
				.. we could do signal propagation here ..
			}
		}
		/* This child now takes over the role of the original thread */
	}

	clone(CLONE_VM | CLONE_THREAD | SIGCHLD);
	/* The child of this clone is the new thread */

ie we'd always have "n+1" kernel threads for the "n" pthreads threads,
where the extra additional thread is there to make the real parent of the
threaded application see just one "process". More importantly, it means
that the real parent sees the death of the "clone group" only after all
threads have exited.

Alternatively, you can always use a zero signal specifier to clone(), but
you have to realize that if you do that, the original parent will only see
one exit code, and it will be the one from the first thread. The other
threads may still be running - and the original parent simply won't know
anything at all about them. This is quite acceptable thread behaviour for
some thread usage, but it is not the behaviour that pthreads is supposed
to have (this is how you can make "IO slaves" or similar - threads that
are not full-fledged parts of the process that the parent is supposed to
see).

Also, please do notice that one fundamental part of the CLONE_THREAD logic
never made it into a stable kernel: the shared signal handling. So while
CLONE_THREAD allows for many pthread-like things (one common process ID
shared by all threads, for example), the most fundamental part of it was
not actually merged into the standard kernel because of stability concerns
in late pre-2.4 test cycle.

			Linus

