Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSHPRX6>; Fri, 16 Aug 2002 13:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318631AbSHPRX6>; Fri, 16 Aug 2002 13:23:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44930 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318630AbSHPRX5>;
	Fri, 16 Aug 2002 13:23:57 -0400
Date: Fri, 16 Aug 2002 19:28:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <Pine.LNX.4.44.0208161013420.2243-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161921060.17613-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:

> So I'd like to know what the likelyhood of it being used as a futex is.
> If 90% of all users would like a futex, that's _wonderful_. No question
> that we should do it. But if it's dynamically fairly rare to have this
> "synchronize with thread exit", then we may be losing more than we win.

having looked at threading libraries i can tell you that any library
writer who cares about performance would use a futex for exit
notification. We've got a performance test that compares
signal-notification and futex-notification:

  earth3:~/libc> ./p3 -s 100000 -t 1 -r 0 -T --sync-join
  Runtime: 1.208586749 seconds

  earth3:~/libc> ./p3 -s 100000 -t 1 -r 0 -T --sync-signal
  Runtime: 1.336826839 seconds

the sync-join variant uses a futex, the sync-signal variant uses a signal
to notify completion. Note that the test does not even use SIGCHLD because
that is slower, it uses SIGUSR1 [in the application code] and sigwait(),
to remove the signal handler overhead. The futex variant is still faster,
and with futexes being used for CLONE_CLEARTID it would be faster by about
~0.1 seconds.

(The kernel used is an uptodate 2.4-threading kernel with yesterday's APIs
backported, and glibc fitted to those new interfaces.)

sure, this solution is even less generic and thus a bit more dangerous of
being a libpthread-specific optimization [ ;) ], but i cannot think of any
more complex threading library - things like JVMs tend to have less
semantical needs.  And if someone wants signal-based notification then
it's still possible.

	Ingo

