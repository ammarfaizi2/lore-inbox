Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135597AbRDXNSH>; Tue, 24 Apr 2001 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135598AbRDXNR7>; Tue, 24 Apr 2001 09:17:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:31475 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135597AbRDXNRr>; Tue, 24 Apr 2001 09:17:47 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3] 
In-Reply-To: Your message of "Tue, 24 Apr 2001 12:44:50 +0200."
             <20010424124450.C1682@athlon.random> 
Date: Tue, 24 Apr 2001 14:07:47 +0100
Message-ID: <6419.988117667@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so you reproduced a deadlock with my patch applied, or you are saying
> you discovered that case with one of you testcases?

It was my implementation that triggered it (I haven't tried it with yours),
but the bug occurred because the SUBL happened to make the change outside of
the spinlocked region in the slowpath at the same time as the wakeup routine
was running on the other CPU.

I'll have a look at the sequence and make sure that it does actually apply to
your implementation. It may not... but it doesn't hurt to check.

The thing occurred with one of my simple testcases, but only happened once in
a number of runs, fortunately whilst I had the rwsemtrace()'s enabled.

> yes of course, you use rwsem_cmpxchgw that is unnecessary.

Actually, I use this to try and avoid the following loop that you've got in
your code:

> +static void __rwsem_wake(struct rw_semaphore *sem)
...
> +	again:
> +		count = rwsem_xchgadd(-wait->retire, &sem->count);
> +		if (!wake_read && (count & RWSEM_READ_MASK)) {
> +			count = rwsem_xchgadd(wait->retire, &sem->count);
> +			if ((count & RWSEM_READ_MASK) == 1)
> +				goto again;

I now only have that loop in the rwsem_up_write_wake() function.

But! In mine, if __up_write()'s CMPXCHG failed, then it has also read the
counter, which it then passes as an argument to rwsem_up_write_wake(). This
means I can avoid the aforementioned loop in most cases, I suspect, by seeing
if the active counter was 1 at the time of the failed CMPXCHG.

This also means that if a ex-writer wakes up a writer-to-be, the only atomic
instruction performed on sem->count is the CMPXCHG in __up_write().

For the ex-writer waking up readers case, we have to perform an additional
XADD, but this must be done before anyone is woken up, else __up_read() can
get called to decrement the count before we've incremented it. I count the
number of things I want to wake up, adjust the count (one LOCKED ADD only) and
then wake the batch up.

You dive into a LOCKED XADD/XADD loop for each process you wake, which in the
best case will give you one LOCKED XADD per process.

Looking again at rwsem_up_read_wake()... I can't actually eliminate the
CMPXCHG there because the active count has already been decremented, and so
will need to be incremented again prior to a wake-up being performed. However,
if the increment was performed and someone else had incremented the count in
the meantime, we have to decrement it again... but this can cause a transition
back to zero, which we have to check for... and if that occurred...

You get the idea, anyway.

Oh yes... this idea should be faster on SPARC/SPARC64 and IA64 which don't
have useful XADD instructions (FETCHADD can only use small immediate values),
only CMPXCHG/CAS are really useful there.

> I guess I'm faster because I avoid the pipeline stall using "+m" (sem->count)
> that is written as a constant, that was definitely intentional idea.

"+m" doesn't avoid the stall. That's just shorthand for:

	: "=m"(sem->count) : "m"(sem->count)

which is what mine has.

"a+" luckily causes the avoidance by saying EAX gets clobbered, causing the
compiler to save via an additional register. Note that the compiler saves
anyway, even if the register will be discarded after being restored - yuk!

I think this one will depend on the surrounding code anyway. I suspect in some
chunks of C mine will be faster, and in others yours will be, all depending on
when EAX is loaded.

> My point is that when you set XADD you still force duplication of the header
> stuff into the the asm/*

If you want to use my XADD algorithm, then I think that's going to be fair
enough for now. You have to provide some extra routines anyway.

David
