Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSGYRMj>; Thu, 25 Jul 2002 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGYRMj>; Thu, 25 Jul 2002 13:12:39 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:62635 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S315416AbSGYRMi>; Thu, 25 Jul 2002 13:12:38 -0400
Date: Thu, 25 Jul 2002 18:15:37 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Message-ID: <20020725181537.A11324@kushida.apsleyroad.org>
References: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com> <m1eldrix4f.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1eldrix4f.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Jul 25, 2002 at 10:35:28AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> When we have a cpu load average < 1, it is trivial to increase the
> timer granularity to something resembling the gettimeofday resolution 
> simply by internally doing gettimeofday when schedule is called, and
> adding those processes that have just become runnable to the run
> queue.  To get the most out of this the idle task would need to busy
> wait looking for timer events, when we have an event scheduled before
> the next timer tick.

Unfortunately, this does not help "soft real-time" tasks like the
hypothetical video game with a compile running in the background.  That
needs to preempt lower priority tasks somehow.

Ideally, because they don't use much CPU but do want to run on time, it
should be possible to run those programs using non-real-time priority,
and they would run on time simply because they always have a high
dynamic priority.

To be fair, although 100Hz timer resolution wasn't good enough even for
a simple "snake" video game with no other load (the eye detects the time
variance as an apparent velocity variance), 1000Hz is probably fine.

> The goal is twofold, to remove the need for user space applications to
> busy wait, so sometimes the system can get something done another
> process is waiting, and to increase the internal kernel timer
> granularity to the point where user space doesn't care anymore.  With
> the only timer we sleep past the desired time is when the kernel
> decides there is some higher priority task to run.

What will happen if the timer granularity remains at 1000Hz when
loadavg > 1 is that time-sensitive interactive apps will still busy wait
for the remainder of a tick.  _But_, if we can define select() or similar
semantics to mean, as Linus suggested, "wait until at most TIME", then
it becomes possible to avoid the busy wait at low loads (paradoxically).

> The most interesting use I have seen is a high performance local area
> data transfer utility, that would do short sleeps in between sending
> packets to avoid pushing the switch to the point where it would drop
> packets.  But it was perfectly fine if a new packet came in before it
> was done waiting for the old packet to go out the wire.

That's the sort of thing I work on :)  The resolution required of a
packet shaper is measured in 10s of microseconds, though, so I just
accept that user space must busy wait _all_ the time the link isn't idle.

-- Jamie
