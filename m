Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273254AbRIRJcB>; Tue, 18 Sep 2001 05:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273257AbRIRJbw>; Tue, 18 Sep 2001 05:31:52 -0400
Received: from t2.redhat.com ([199.183.24.243]:56824 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S273254AbRIRJbk>; Tue, 18 Sep 2001 05:31:40 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Tue, 18 Sep 2001 09:55:49 +0200." <20010918095549.T698@athlon.random> 
Date: Tue, 18 Sep 2001 10:32:03 +0100
Message-ID: <4294.1000805523@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <linux-kernel@vger.kernel.org> wrote:
> The mmap semaphore is a read-write semaphore, and it _is_ permissible to
> call "copy_to_user()" and friends while holding the read lock.
>
> The bug appears to be in the implementation of the write semaphore -
> down_write() doesn't undestand that blocked writes must not block new
> readers, exactly because of this situation. 
>
> The situation wrt read-write spinlocks is exactly the same, btw, except
> there we have "readers can have interrupts enabled even if interrupts
> also take read locks" instead of having user-level faults.
>
> Why do we want to explicitly allow this behaviour wrt mmap_sem? Because
> some things are inherently racy without it (ie threaded processes that
> read or write the address space - coredumping, ptrace etc).


Hmmm... I don't think this is possible with XADD based semaphores as they
stand (my version or Andrea's).

With the current XADD based stuff, you can't distinguish between one
writer running and a queue of sleeping locks and one reader running and a
queue of sleeping locks without counting the sleepers

	Sem(sleepers)	Proc 1	Proc 2	Proc 3	Proc 4	Proc 5
	========	======	======	======	======	======
	00000000(0)
			-->down_read()
			<--down_read()
	00000001(0)
				-->down_write()
				-->down_write_failed()
				[schedule]
	FFFF0001(1)
					-->down_write()
					-->down_write_failed()
					[schedule]
	FFFE0001(2)
						-->down_write()
						-->down_write_failed()
						[schedule]
	FFFD0001(3)
							-->down_read_unfair()
	FFFC0002(3)
							is the active proc
							R or W?

	Sem		Proc 1	Proc 2	Proc 3	Proc 4
	========	======	======	======	======
	00000000(0)
			-->down_write()
			<--down_write()
	FFFF0001(0)
				-->down_write()
				-->down_write_failed()
				[schedule]
	FFFE0001(1)
					-->down_write()
					-->down_write_failed()
					[schedule]
	FFFD0001(2)
						-->down_read_unfair()
	FFFC0002(2)
						is the active proc R or W?

In fact, it's worse than that: you can't tell the difference between two
active readers and a queue of sleepers and one active writer, one failed
read or write attempt as yet unprocessed, and a queue of sleepers

	Sem(sleepers)	Proc 1	Proc 2	Proc 3	Proc 4	Proc 5
	==============	======	======	======	======	======
	00000000(0)
			-->down_read()
			<--down_read()
	00000001(0)
				-->down_read()
				<--down_read()
	00000002(0)
					-->down_write()
	FFFF0003(0)
					-->down_write_failed()
					[schedule]
	FFFF0002(1)
						-->down_write()
	FFFE0003(1)
							-->down_read_unfair()
	FFFE0004(1)
							since the LSW>2 does
							this mean there are 2+
							readers active?

	Sem(sleepers)	Proc 1	Proc 2	Proc 3	Proc 4	Proc 5
	==============	======	======	======	======	======
	00000000(0)
			-->down_write()
			<--down_write()
	FFFF0001(0)
				-->down_write()
	FFFE0002(0)
				-->down_write_failed()
				[schedule]
	FFFE0001(1)
					-->down_read()
	FFFE0002(1)
						-->down_read()
	FFFE0003(1)
							-->down_read_unfair()
	FFFE0004(1)
							since the LSW>2 does
							this mean there are 2+
							readers active?

I think it might well be too hard to do unfair reads with the XADD based
stuff. The problem is that you can't compensate for the effect on the counter
of failed attempts to get read or write locks, even when you've got the
semaphore spinlock (the queue length is of no help).

I think that this problem can only be solved by going to the spinlock version,
and maintaining a flag to say what sort of lock is currently active.

David
