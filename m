Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbRFTVBy>; Wed, 20 Jun 2001 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbRFTVBo>; Wed, 20 Jun 2001 17:01:44 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:19660 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263003AbRFTVBe>; Wed, 20 Jun 2001 17:01:34 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Larry McVoy" <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: RE:Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 14:01:16 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKAENCPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
In-Reply-To: <20010619095239.T3089@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nobody is arguing that having more than one thread of execution in an
> application is a bad idea.  On an SMP machine, having the same number of
> processes/threads as there are CPUs is a requirement to get the scaling
> if that app is all you are running.  That's fine.  But on a uniprocessor,
> threads are basically stupid.  The only place that I know of where it is
> necessary is for I/O which blocks.  And even there you only need enough
> to overlap the I/O such that it streams.  And processes will, and do,
> work fine for that.

	It's very hard to use processes for this purpose. Consider, for example, a
web server. You don't want to use one process for each client because that
would limit your scalability (16,000 clients would become difficult, and
with threads it's trivial). You don't want to use one thread for each client
for obvious reasons.

	The risk with a poll loop type single-process design is that one client
might perform an expensive operation and you can't afford to have your whole
server stall. A worst-case kind of example would be reading a file from a
slow NFS server. But more common are page faults from slow disks when a
piece of code in the web server that handles some obscure feature needs to
fault in.

	This can theoretically be handled by a process pool architecture with
suitable shared memory, but that's much more difficult to get right than
threads. And there's no advantage gained from the extra effort.

	Another case where threads can be extremely useful is for special tasks
with timing requirements. Consider, for example, time and timer management.

	Many programs have requirements for a monotonic timer that can provide
reasonable guarantee that intervals will be accurately measured so that
future events will trigger at the right time. For example, if you need to
idle out a connection if it's not used for, say, 30 seconds it may be
unacceptable to have all your connections stay around for an hour if the
clock jumps backwards.

	This is very easy to do if you have a thread monitor the clock and wake up
every second. If the clock jumps forward, it can let virtual time run a bit
faster until it catches up. If it jumps backwards, it can slow virtual time
down keeping it always monotonic.

	This can provide a reasonable guarantee that no matter what the system time
does (short of jumping every second!) your 30 second timer will be between,
say, 25 and 35 seconds. This can also provide a good way to measure elapsed
time that is well-protected from system clock issues.

	Without a separate thread, it's very hard to assure that the the clock
monitoring code runs often enough to keep its timebase. If it doesn't run
for 6 seconds, it would think the time had jumped. As a separate thread, you
can write this time monitoring timer management code one time and it will
work with any other code regardless of how it blocks.

	The two things I have found threads most useful for (in fact, indispensable
for) are ambush avoidance and dedicated threads for 'special' tasks that
can't easily be done another way. Both of these things can, at least
theoertically, by done using processes and shared memory or other IPC
mechanisms, but threads is easier and cleaner. This is especially true for
ambush avoidance.

	DS

