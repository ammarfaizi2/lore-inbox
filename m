Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDIDIr>; Sun, 8 Apr 2001 23:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRDIDIh>; Sun, 8 Apr 2001 23:08:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132607AbRDIDI1>; Sun, 8 Apr 2001 23:08:27 -0400
Date: Sun, 8 Apr 2001 20:08:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Ben LaHaise <bcrl@redhat.com>, David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <3AD0FD0F.9B0C47FD@uow.edu.au>
Message-ID: <Pine.LNX.4.31.0104081841440.7671-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Apr 2001, Andrew Morton wrote:
>
> One issue with the current implementation is the (necessary)
> design where one reader (or writer) is sleeping in
> down_x_failed_biased(), with its bias in place, whereas
> all other sleepers are sleeping in down_x_failed(), with
> their bias not in place.

Why not do this the same way the _real_ semaphores do it?

You have a fast-path that has a single integer, and a slow path which has
more state but and protected by a spinlock. The _only_ worry I see is to
make sure that we properly have a "contention" state, because both readers
and writers need to be able to know when they should wake things up. But
there's a _trivial_ contention state. Read on:

Forget about the BIAS stuff, and go back to the old simple "negative is
writer, positive is reader" implementation:

	0		- unlocked
	1..n		- 1-n readers
	0xc0000000	- writer
	other <0	- contention

Do you see anything wrong with this?

Implementation:

 - fast path:

	down_read:
		lock incl (%sem)
		js __down_read_failed

	down_write:
		xorl %eax,%eax
		movl $0xc0000000,%r
		lock cmpxchgl %r,(%sem)
		jne __down_write_failed

	up_read:
		lock decl (%sem)
		js __up_read_wakeup

	up_write:
		lock andl $0x3fffffff,(%sem)
		jne __up_write_wakeup

The above are all fairly obvious for the non-failure case, agreed?
Including the guarantee that _if_ there is contention, the "up()"
routines will always go to the slow path to handle the contention.

Now, the _slow_ case could be your generic "protected by a spinlock" code,
although I have a suggestion. As follows:

The only half-way "subtle" case is that __down_write_failed needs to make
sure that it marks itself as a contender (the down_read() fast-case code
will have done so already by virtue of incrementing the counter, which is
guaranteed to have resulted in a "contention" value.

While down_read() automatically gets a "contention value" on failure,
"down_write()" needs to do extra work. The extra work is not all that
expensive: the simplest thing is to just do

	subl $0x8000,(%sem)

at the beginning - which will cause a "contention" value regardless of
whether it was pure-reader before (it goes negative by the simple
assumption that there will never be more than 32k concurrent readers), or
whether it was locked by a writer (it stays negative due to the 0x40000000
bit in the write lock logic). In both cases, both a up_write() and a
up_read() will notice that they need to handle the contention of a waiting
writer-to-be.

Would you agree that the above fast-path implementation guarantees that we
always get to the spinlock-protected slow path?

Now, the above _heavily_ favours readers. There's no question that the
above is unfair. I think that's ok. I think fairness and efficiency tend
to be at odds. But queuing theory shows that the faster you can get out of
the critical region, the smaller your queue will be - exponentially. So
speed is worth it.

Let's take an example at this point:

 - lock is zero

 - writer(1) gets lock: lock is 0xc0000000

 - reader(2) tries to get in: lock becomes 0xc0000001, synchronizes on
   spinlock.

 - another writer(3) tries to get in: lock becomes 0xbfff8001, synchronizes
   on spinlock.

 - writer(1) does up_write: lock becomes 0x3fff8001, != 0, so writer  decides
   it needs to wake up, and synchronizes on spinlock.

 - another reader(4) comes on on another CPU, increments, and notices that
   it can do so without it being negative: lock becomes 0x3fff8002 and
   this one does NOT synchronize on the spinlock.

End result: reader(4) "stole base" and actually got the lock without ever
seeing any contention, and we now have (1), (2) and (3) who are serialized
inside the spinlock.

So we get to what the serializers have to do, ie the slow path:

First, let's do the __up_read/write_wakeup() case, because that one is the
easy one. In fact, I think it ends up being the same function:

	spin_lock(&sem->lock);
	wake_up(&sem->waiters);
	spin_unlock(&sem->lock);

and we're all done. The only optimization here (which we should do for
regular semaphores too) is to use the same spinlock for the semaphore lock
and the wait-queue lock.

The above is fairly obviously correct, and sufficient: we have shown that
we'll get here if there is contention, and the only other thing that the
wakup could sanely do would possibly be to select which process to wake.
Let's not do that yet.

The harder case is __down_read/write_failed(). Here is my suggested
pseudo-code:

	__down_write_failed(sem)
	{
		DECLARE_WAIT_QUEUE(wait, current);

		lock subl $0x8000,(%sem)	/* Contention marker */
		spin_lock(&sem->lock);
		add_wait_queue_exclusive(&sem->wait, &wait);
		for (;;) {
			unsigned int value, newvalue;

			set_task_state(TASK_SLEEPING);
			value = sem->value;

			/*
			 * Ignore other pending writers: but if there is
			 * are pending readers or a write holder we should
			 * sleep
			 */
			if (value & 0xc0007fff) {
				spin_unlock(&sem->lock);
				schedule();
				spin_lock(&sem->lock);
				continue;
			}

			/*
			 * This also undoes our contention marker thing,  while
			 * leaving other waiters contention markers in  place
			 */
			newvalue = (value + 0x8000) | 0xc0000000;
			if (lock_cmpxchg(sem->value, value, newvalue))
				break;	/* GOT IT! */

			/* Damn, somebody else changed it from under us */
			continue;
		}
		remove_wait_queue(&sem->wait, &wait);
		spin_unlock(&sem->lock);
	}

The down_read() slow case is equivalent, but ends up being much simpler
(because we don't need to play with contention markers or ignore other
peoples contention markers):

	__down_read_failed(sem)
	{
		DECLARE_WAIT_QUEUE(wait, current);

		spin_lock(&sem->lock);
		add_wait_queue(&sem->wait, &wait);
		for (;;) {
			set_task_state(TASK_SLEEPING);
			/*
			 * Yah! We already did our "inc", so if we ever see
			 * a positive value we're all done.
			 */
			if (sem->value > 0)
				break;
			spin_unlock(&sem->lock);
			schedule();
			spin_lock(&sem->lock);
		}
		remove_wait_queue(&sem->wait, &wait);
		spin_unlock(&sem->lock);
	}

Can anybody shoot any holes in this? I haven't actually tested it, but
race conditions in locking primitives are slippery things, and I'd much
rather have an algorithm we can _think_ about and prove to be working. And
I think the above one is provably correct.

Not that I want to go to that kind of extremes.

Anybody? Andrew? Mind giving the above a whirl on your testbed? Or can you
see some thinko in it without even testing?

Note in particular how the above keeps the non-contention "down_read()" /
"up_read()" cases as two single instructions, no slower than a spinlock.

(There are the following assumptions in the code: there are at most 32k
active readers, and also at most 32k pending writers. The limits come from
the writer contention marker logic. You have the 32 bits split up as:

 - 2 bits "write lock owner" (it's really only one bit, but the other bit
   is set so that the writer contention marker won't turn the most
   negative number into a positive one, so we have one "extra" bit set to
   keep the thing negative for the whole duration of a write lock)
 - 15 "reader count" bits
 - 15 "pending writer count" bits

and the 15 bits is why you have the 32k user limitation. I think it's an
acceptable one - and if not you can expand on it by adding extra fields
thata re only accessed within the spinlock).

		Linus

