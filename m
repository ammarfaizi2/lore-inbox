Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135313AbRDRUfR>; Wed, 18 Apr 2001 16:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135317AbRDRUfL>; Wed, 18 Apr 2001 16:35:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32535 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135313AbRDRUey>; Wed, 18 Apr 2001 16:34:54 -0400
Date: Wed, 18 Apr 2001 22:49:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010418224946.A7583@athlon.random>
In-Reply-To: <01041800544100.06481@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041800544100.06481@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Wed, Apr 18, 2001 at 12:54:41AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 12:54:41AM +0100, D . W . Howells wrote:
> > It is 36bytes. and on 64bit archs the difference is going to be less. 
> 
> You're right - I can't add up (must be too late at night), and I was looking 
> at wait_queue not wait_queue_head. I suppose that means my implementations 
> are then 20 and 16 bytes respectively.
> 
> On 64-bit archs the difference will be less, depending on what a "long" is.

yes. I actually modified my implementation and now I gone below the size of a
waitqueue because I don't need its lock. The rw_semaphore now is only 16
bytes in size even in SMP (while your generic rw_semaphore is larger than 16 in
smp).  I also changed the wakeup mechanism to do the same fair logic as yours
but I'm not changing any common code (so it's complete FIFO with a wake up all
contigous readers behaviour). It's also now completly fair as the fast path
will go to sleep if anybody is registered in a waitqueue so it has the property
that we are still missing in the non rw semaphores. And it still seems quite
obvious while reading it.

> Perhaps you should steal my wake_up_ctx() idea. That means you only need one 

I now stolen the wakeup logic but I reimplemented it internally to the rwsem.c
without involving the external visible waitqueue mechanism (short version: no
changes to sched.c and wait.h).

> You can then say "wake up the first thing at the front of the queue if it is 
> a writer"; and you can say "wake up the first consequtive bunch of things at 
> the front of the queue, provided they're all readers" or "wake up all the 
> readers in the queue".

I preferred not to generalize that in the wake_up_ctx way but yes I hardcoded
that in a function that knows what to do with a simple list_head that is
even ligther and faster.

> My point exactly... It can't be as fast because it's _all_ out of line. 

Ok, I also inlined the fast path. Of course if you're not running out of icache
(like in a benchmark dedicated to the rwsem) inlining the fast path is
faster... (previously I was talking about real world misc load where we can more
easily run out of icache)

> However! mine runs for as little time as possible with spinlocks held in the 
> generic case, and, perhaps more importantly, as little time as possible with 
> interrupts disabled.

But it reacquires other locks for the waitqueue and it clears irqs again too
and it will ping pong cachelines in the wait event interface. So it's _slower_
and not faster. Making the locks more granular makes sense when the contention
on the lock goes away after you make it granular, but you are using two
spinlocks instead of one and you still have contention in the same slow path
on the second spinlock and wait_even runtime, while I only have contention in
the first one and that's why I'm more efficient (see numbers below).

> One other thing: should you be using spin_lock_irqsave() instead of 
> spin_lock_irq() in your down functions? I'm not sure it's necessary, however, 

It's not necessary to save flags because they can sleep.

BTW, your rwsem-spinlock.h forgets the clear irqs in down_* and to clear irqs
and save flags in the up_*! So my spinlock are penalized as the cli/sti pairs
are not that light and you are providing weaker wakeup semantics than me.

My new implementation only handle up to 2^31 concurrent readers, as usual
unlimited sleepers in the slow paths and down_read is not anymore recursive
because of the guaranteed total fifo behaviour.  This scenario will deadlock
while it was working fine with the previous patches on my ftp area:

	task0		task1
	down_read(sem)
			down_write(sem)
	down_read(sem)

new patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre3/rwsem-generic-5

And now I compared 2.4.4pre3aa3 - 00_rwsem-generic-1 with 2.4.4pre3aa3 - 00_rwsem-generic-1 + rwsem-generic-5,
that is the same as comparing vanilla 2.4.4pre3 with vanilla 2.4.4pre3 + rwsem-generic-5.

I wrote this rwsem stresser (if you have any bug in the rwsem this stresser will trigger it
almost immediatly).

/*
 *  rw_semaphore benchmark (use with 2.4.3 or more recent kernels
 *  that uses down_read() in the page fault and down_write() in mmap).
 *
 *  Copyright (C) 2001  Andrea Arcangeli <andrea@suse.de> SuSE
 */

#include <pthread.h>
#include <stdio.h>
#include <asm/page.h>
#include <sys/mman.h>
#include <asm/system.h>

#define NR_THREADS 50
#define RWSEM_LOOPS 500
#define READ_DOWN_PER_WRITE_DOWN 4

static int start;

void * rwsemflood(void * foo)
{
	int i;
	pthread_mutex_t * mutex = (pthread_mutex_t *) foo;

	if (pthread_mutex_lock(mutex))
		perror("pthread_mutex_lock"), exit(1);

	for (i = 0; i < RWSEM_LOOPS; i++) {
		volatile char * mem;
		int i;

		mem = mmap(NULL, PAGE_SIZE * READ_DOWN_PER_WRITE_DOWN,
			   PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
		if (mem == MAP_FAILED)
			perror("mmap"), exit(1);
		for (i = 0; i < PAGE_SIZE * READ_DOWN_PER_WRITE_DOWN; i += PAGE_SIZE)
			*(mem+i);
		if (munmap((char *)mem, PAGE_SIZE) < 0)
			perror("munmap"), exit(1);
	}
	pthread_exit(NULL);
}

main()
{
	pthread_t thread[NR_THREADS];
	pthread_mutex_t mutex[NR_THREADS];
	int i;

	for (i = 0; i < NR_THREADS; i++) {
		pthread_mutex_init(&mutex[i], NULL);
		if (pthread_mutex_lock(&mutex[i]))
			perror("pthread_mutex_lock"), exit(1);
	}

	for (i = 0; i < NR_THREADS; i++)
		if (pthread_create(&thread[i], NULL , rwsemflood, &mutex[i]) < 0)
			perror("pthread_create"), exit(1);

	for (i = 0; i < NR_THREADS; i++)
		if (pthread_mutex_unlock(&mutex[i]))
			perror("pthread_mutex_unlock"), exit(1);

	for (i = 0; i < NR_THREADS; i++)
		if (pthread_join(thread[i], NULL))
			perror("pthread_join"), exit(1);
}

And here are the numbers with the plain 2.4.4pre3 rwsemaphores that are
implemented in asm with the kernel configured for PII and the wakeup that
cannot happen in an irq/softirq. The hardware is a 2-way SMP PII.

andrea@laser:~ > for i in 1 2 3 4; do time ./rwsem ;done

real    0m51.587s
user    0m0.100s
sys     0m52.770s

real    0m50.476s
user    0m0.100s
sys     0m50.730s

real    0m51.502s
user    0m0.110s
sys     0m53.110s

real    0m50.437s
user    0m0.080s
sys     0m51.070s

and now here it is the same benchmark run with rwsem-generic-5:

ndrea@laser:~ > for i in 1 2 3 4; do time ./rwsem ;done

real    0m50.035s
user    0m0.080s
sys     0m51.430s

real    0m50.636s
user    0m0.090s
sys     0m51.100s

real    0m50.038s
user    0m0.050s
sys     0m50.640s

real    0m50.655s
user    0m0.060s
sys     0m50.800s

as you can see despite it was an unfair comparison my implementation was still
a bit faster or at least running at the same speed.  And yes, this only
benchmark the slow path, the fast path is not easy to measure from userspace
and since I now inlined the fast path it must not run slower than yours. If you
have more interesting bench go ahead of course.

I think you should now agree on my generic rwsemaphore implementation.

About your last patch where you try to change all archs to use your generic
implementation in pre3, it still breaks during compilation and I dislike
that long cryptic names:

	CONFIG_RWSEM_GENERIC_SPINLOCK
	CONFIG_RWSEM_XCHGADD_ALGORITHM

I don't see why you didn't call them CONFIG_RWSEM_GENERIC and
CONFIG_RWSEM_ATOMIC_RETURN respectively (as I suggested originally).

I now recommend anyone with an alpha to use 2.4.4pre3 with those
two patches applied:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre3aa3/00_alpha-numa-3
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre3/rwsem-generic-5

(they can be applied also on ia32 kernels of course)

About your comment on the atomic_*_return vs spinlock in the fast path, the
atomic_*_return way is obviously much faster and shorter than the spinlock
version on the alpha and it also saves 8 bytes in the size of the rw_semaphore
compared to the generic implementation (and I'm sure the same is valid for the
other RISC chips that provides read locked store conditional mechanism to
implement atomic updates in memory).  That's why I suggested to move it in the
common code (if it would be slower not even the alpha would be trying to use it
:). It's just that by sharing it we increase the userbase of the brainer part.

Also on any 64bit arch we can provide 2^32 readers and 2^32 writers at the same
time without the need of a spinlock. We could do the same also on >=586 using
chmxchg8b but I'm not sure if that would be a great idea.

Andrea
