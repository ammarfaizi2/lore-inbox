Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSAFBoH>; Sat, 5 Jan 2002 20:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286750AbSAFBn4>; Sat, 5 Jan 2002 20:43:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61587 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286758AbSAFBnj>;
	Sat, 5 Jan 2002 20:43:39 -0500
Date: Sun, 6 Jan 2002 04:41:05 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201051722540.24370-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201060427590.4730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Linus Torvalds wrote:

> At that point I don't think O(1) matters all that much, but it
> certainly won't hurt. UNLESS it causes bad choices to be made. Which
> we can only guess at right now.

i have an escape path for the MM-goodness issue: we can make it
O(nr_running_threads) if need to be, by registering MM users into a per-MM
'MM runqueue', and scanning this runqueue for potentially better
candidates if it's non-empty. In the process case this falls back to O(1),
in the threaded case it would be scanning the whole (local) runqueue in
essence.

And George Anzinger has a nice idea to help those platforms which have
slow bitsearch functions, we can keep a floating pointer of the highest
priority queue which can be made NULL if the last task from a priority
level was used up or can be increased if a higher priority task is added,
this pointer will be correct in most of the time, and we can fall back to
the bitsearch if it's NULL.

so while i think that the O(1) design indeed stretches things a bit and
reduces our moving space, it's i think worth a try. Switching an existing
per-CPU queue design for a full-search design shouldnt be too hard. The
load-balancing parts wont be lost whichever path we chose later on, and
that is the most important bit i think.

> Just out of interest, where have the bugs crept up? I think we could
> just try out the thing and see what's up, but I know that at least
> some versions of bash are buggy and _will_ show problems due to the
> "run child first" behaviour. Remember:  we actually tried that for a
> while in 2.4.x.

i've disabled the 'run child first' behavior in the latest patch at:

        http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B1.patch

the crash bug i've been hunting all day, but i cannot reproduce it which
appears to show it's either something really subtle or something really
stupid. But the patch certainly does not have any of the scarier
strace/ptrace related bug scenarios or 'two CPUs run the same task' bugs,
i've put lots of testing into that part. The only crash remaining in -B1
is a clear NULL pointer dereference in wakeup(), which is a direct bug not
some side-effect, i hope to be able to find it soon.

right now there are a number of very helpful people who are experiencing
those crashes and are ready to run bzImages i compile for them (so that
compiler and build environment is out of the picture) - Pawel Kot for
example. (thanks Pawel!)

> [ In 2.5.x it's fine to break broken programs, though, so this isn't that
>   much of an issue any more. From the reports I've seen the thing has
>   shown more bugs than that, though. I'd happily test a buggy scheduler,
>   but I don't want to mix bio problems _and_ scheduler problems, so I'm
>   not ready to switch over until either the scheduler patch looks stable,
>   or the bio stuff has finalized more. ]

i've disabled it to reduce the number of variables - we can still try and
enable it later on once things have proven to be stable.

	Ingo


