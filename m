Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbRDLSVg>; Thu, 12 Apr 2001 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRDLSV0>; Thu, 12 Apr 2001 14:21:26 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:34270 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135248AbRDLSVF>; Thu, 12 Apr 2001 14:21:05 -0400
Message-ID: <3AD5F112.E78436F@uow.edu.au>
Date: Thu, 12 Apr 2001 11:16:50 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@cambridge.redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 4th try: i386 rw_semaphores fix
In-Reply-To: Your message of "Wed, 11 Apr 2001 17:37:10 BST."
				             <17213.987007030@warthog.cambridge.redhat.com> <17794.987025299@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> Here's the RW semaphore patch attempt #4. This fixes the bugs that Andrew
> Morton's test cases showed up.
> 


It still doesn't compile with gcc-2.91.66 because of the
"#define rwsemdebug(FMT, ...)" thing.  What can we do
about this?

I cooked up a few more tests, generally beat the thing
up.  This code works.  Good stuff.  I'll do some more testing
later this week - put some delays inside the semaphore code
itself to stretch the timing windows, but I don't see how
it can break it.

Manfred says the rep;nop should come *before* the memory
operation, but I don't know if he's been heard...

parisc looks OK.  ppc tried hard, but didn't get it
right.  The spin_lock_irqsave() in up_read/up_write shouldn't be
necessary plus it puts the readers onto the
waitqueue with add_wait_queue_exclusive, so an up_write
will only release one reader.  Looks like they'll end
up with stuck readers.  Other architectures need work.
If they can live with a spinlock in the fastpath, then
the code at http://www.uow.edu.au/~andrewm/linux/rw_semaphore.tar.gz
is bog-simple and works.



Now I think we should specify the API a bit:

* A task is not allowed to down_read() the same rwsem
more than once time.  Otherwise another task can
do a down_write() in the middle and cause deadlock.
(I don't think this has been specified for read_lock()
and write_lock().  There's no such deadlock on the
x86 implementation of these.  Other architectures?
Heaven knows.  They're probably OK).

* up_read() and up_write() may *not* be called from
interrupt context.

The latter is just a suggestion.  It looks like your
code is safe for interrupt-context upping - but it
isn't tested for this.  The guys who are going to
support rwsems for architectures which have less
rich atomic ops are going to *need* to know the rules
here.   Let's tell 'em.

If we get agreement on these points, then please
drop a comment in there and I believe we're done.

In another email you said:

> schedule() disabled:
>  reads taken: 585629
>  writes taken: 292997

That's interesting.  With two writer threads and
four reader threads hammering the rwsem, the write/read
grant ratio is 0.5003.  Neat, but I'd have expected
readers to do better.  Perhaps the writer-wakes-multiple
readers stuff isn't happening.  I'll test for this.


There was some discussion regarding contention rates a few
days back.  I did dome instrumentation on the normal semaphores.
The highest contention rate I could observe was during a `make
-j3 bzImage' on dual CPU.  With this workload, down() enters
__down() 2% of the time.  That's a heck of a lot.  It means that
the semaphore slow path is by a very large margin the most
expensive part.

The most contention was on i_sem in real_lookup(), then pipe_sem
and vfork_sem.  ext2_lookup is slow; no news there.

But tweaking the semaphore slowpath won't help here
because when a process slept in __down(), it was always
the only sleeper.

With `dbench 12' the contention rate was much lower
(0.01%).  But when someone slept, there was almost
always another sleeper, so the extra wake_up() at
the end of __down() is worth attention.

I don't have any decent multithread workloads which would
allow me to form an opinion on whether we need to optimise
the slowpath, or to more finely thread the contention areas.
Could be with some workloads the contention is significant and
threading is painful. I'll have another look at it sometime...
