Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbRDXOAS>; Tue, 24 Apr 2001 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRDXOAJ>; Tue, 24 Apr 2001 10:00:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20860 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135616AbRDXN7z>; Tue, 24 Apr 2001 09:59:55 -0400
Date: Tue, 24 Apr 2001 15:59:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424155923.A24646@athlon.random>
In-Reply-To: <20010424124450.C1682@athlon.random> <6419.988117667@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6419.988117667@warthog.cambridge.redhat.com>; from dhowells@warthog.cambridge.redhat.com on Tue, Apr 24, 2001 at 02:07:47PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 02:07:47PM +0100, David Howells wrote:
> It was my implementation that triggered it (I haven't tried it with yours),
> but the bug occurred because the SUBL happened to make the change outside of
> the spinlocked region in the slowpath at the same time as the wakeup routine
> was running on the other CPU.

That problem seems not to apply to my slowpath algorithm.

> I'll have a look at the sequence and make sure that it does actually apply to
> your implementation. It may not... but it doesn't hurt to check.

indeed, I'd be glad if you could verify of course, thanks!

> > yes of course, you use rwsem_cmpxchgw that is unnecessary.
> 
> Actually, I use this to try and avoid the following loop that you've got in
> your code:
> 
> > +static void __rwsem_wake(struct rw_semaphore *sem)
> ...
> > +	again:
> > +		count = rwsem_xchgadd(-wait->retire, &sem->count);
> > +		if (!wake_read && (count & RWSEM_READ_MASK)) {
> > +			count = rwsem_xchgadd(wait->retire, &sem->count);
> > +			if ((count & RWSEM_READ_MASK) == 1)
> > +				goto again;
> 
> I now only have that loop in the rwsem_up_write_wake() function.

I don't care about the slow path performance, mainly if I to make it faster I have
to slowdown up_write with an cmpxchg too.

> But! In mine, if __up_write()'s CMPXCHG failed, then it has also read the
> counter, which it then passes as an argument to rwsem_up_write_wake(). This
> means I can avoid the aforementioned loop in most cases, I suspect, by seeing
> if the active counter was 1 at the time of the failed CMPXCHG.
> 
> This also means that if a ex-writer wakes up a writer-to-be, the only atomic
> instruction performed on sem->count is the CMPXCHG in __up_write().
> 
> For the ex-writer waking up readers case, we have to perform an additional
> XADD, but this must be done before anyone is woken up, else __up_read() can
> get called to decrement the count before we've incremented it. I count the
> number of things I want to wake up, adjust the count (one LOCKED ADD only) and
> then wake the batch up.
> 
> You dive into a LOCKED XADD/XADD loop for each process you wake, which in the
> best case will give you one LOCKED XADD per process.

I don't dive into the loop for each process I wake, I only execute one locked
xadd for each prcess I wake (it's the de-retire logic). As I also execute
1 xadd for each process that goes to sleep in schedule() in the slow path
(that's the retire logic). That's really clean beahiour of my slow path I think.

> Looking again at rwsem_up_read_wake()... I can't actually eliminate the
> CMPXCHG there because the active count has already been decremented, and so
> will need to be incremented again prior to a wake-up being performed. However,
> if the increment was performed and someone else had incremented the count in
> the meantime, we have to decrement it again... but this can cause a transition
> back to zero, which we have to check for... and if that occurred...

I think what you describe is similar of what I'm doing in my algorithm (and this way
I don't need any chmxchg in both slow and fast path).

> You get the idea, anyway.
>
> Oh yes... this idea should be faster on SPARC/SPARC64 and IA64 which don't
> have useful XADD instructions (FETCHADD can only use small immediate values),
> only CMPXCHG/CAS are really useful there.
> 
> > I guess I'm faster because I avoid the pipeline stall using "+m" (sem->count)
> > that is written as a constant, that was definitely intentional idea.
> 
> "+m" doesn't avoid the stall. That's just shorthand for:
> 
> 	: "=m"(sem->count) : "m"(sem->count)
> 
> which is what mine has.

You have it yes, but you don't use it ;). While I use it so my compiler can
choose if to put dereference the constant in the incl/etc or to put the (%%eax)
that you hardcoded.

> "a+" luckily causes the avoidance by saying EAX gets clobbered, causing the
> compiler to save via an additional register. Note that the compiler saves
> anyway, even if the register will be discarded after being restored - yuk!
> 
> I think this one will depend on the surrounding code anyway. I suspect in some
> chunks of C mine will be faster, and in others yours will be, all depending on
> when EAX is loaded.

Ok but you save only in the slow path so the fast path should not be affected.
So doing "a" instead of "+a" shouldn't be able to hurt the fast path, it should
only help I think (that's why I changed it too).

> > My point is that when you set XADD you still force duplication of the header
> > stuff into the the asm/*
> 
> If you want to use my XADD algorithm, then I think that's going to be fair
> enough for now. You have to provide some extra routines anyway.

from the arch part you "only" have to provide some extra routine (not the
headers), that's why I included <asm/rwsem_xchgadd.h> from <linux/rwsem_xchgadd.h> ;)

Andrea
