Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbQLVR5g>; Fri, 22 Dec 2000 12:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbQLVR51>; Fri, 22 Dec 2000 12:57:27 -0500
Received: from hermes.mixx.net ([212.84.196.2]:31495 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130320AbQLVR5S>;
	Fri, 22 Dec 2000 12:57:18 -0500
Message-ID: <3A438E6C.8A6984D8@innominate.de>
Date: Fri, 22 Dec 2000 18:25:00 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42B353.D0D249C1@innominate.de> <Pine.LNX.4.21.0012212221220.32526-100000@mindy.americas.sgi.com> <3A433F14.3F3871A5@innominate.de> <20001222073319.A2190@scutter.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> 
> On Fri, Dec 22, 2000 at 12:46:28PM +0100, Daniel Phillips wrote:
> [...]
> > Granted, it's just an example, but it doesn't make sense to wake up more
> > dmabuf_alloc waiters than you actually have buffers for.  You do one
> > up() per freed buffer, and the semaphore's wait queue better be fifo or
> > have some other way of ensuring a task doesn't languish there.  (I don't
> > know, does it?)
>
> ...You are correct - it doesn't
> make sense to wake up more waiters than you can satify if you know this at
> the time. As Paul mentioned, the idea here is that we may have freed
> multiple buffers, and so we wake all the consumers and let them fight it out.

With my model, if you were freeing several buffers you'd do several ups,
and especially in the common case where nobody is waiting that's
efficient enough that it would be hard to justify optimizing further
with say, an up_many(sem, n).

> At least in DYNIX/ptx, semaphores are exclusively FIFO. This gives wake-one
> semantics by default, and prevents starvation.

Then it's most probably that way in Linux too, but __wake_up_common will
take a little time to digest.

> One general rule to remember is that if you need to take multiple locks, then
> you need to always take them in the same order to avoid deadlocks.

Yes, I picked that one up while working on tailmerging and had to lock
multiple inodes.  Then I changed the design so it only takes one lock at
a time - what an improvement.  The moral of this story is that the best
lock is the one you never have to take.

> One simple, if crude way of doing this if they're not two fixed locks is to
> always take the lock with the lower address first. I don't know if this
> will help in this case, but it looks like you probably have to play with
> the rw locks for the wait queues to make this atomic.

I took a look at the code... the implementation details of these
primitives are a whole nuther world.  There's probably a simple
implementation of up_down but I'm far from being able to see it at this
point.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
