Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSLSOBa>; Thu, 19 Dec 2002 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSLSOBa>; Thu, 19 Dec 2002 09:01:30 -0500
Received: from users.ccur.com ([208.248.32.211]:60996 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S264004AbSLSOB2>;
	Thu, 19 Dec 2002 09:01:28 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200212191408.OAA07548@rudolph.ccur.com>
Subject: Re: [PATCH] An O1, nonrecursive ID allocator for Posix timers
To: george@mvista.com (george anzinger)
Date: Thu, 19 Dec 2002 09:08:18 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), akpm@digeo.com, torvalds@transmeta.com,
       jim.houston@ccur.com, linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <3E00ED8A.B63B8A9D@mvista.com> from "george anzinger" at Dec 18, 2002 01:50:02 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is a drop-in replacement for the ID allocator that Jim Houston
>> wrote to support posix timers.  [...]
> 
> A few comments:
> 
> I have found that the locking needs on lookup require that
> the object be locked before the id-look-up is unlocked. 
> With out this it is possible to find an object and have it
> "removed" by another prior to getting it locked.  This is
> why, in my version, the lock is exported.



Hi George,
Ouch.  I completely missed this API flaw.  Good catch.

Some ideas: rather than exporting the lock, we could replace

    int id2ptr_lookup(...)

with a

    int id2ptr_get(...)
    void id2ptr_put(...)

pair.  id2ptr_get() would do the old id2ptr_lookup semantics plus
bump a use-count on the ID.  id2ptr_put() would decrement the
use-count and delete the ID if the use-count became zero.
id2ptr_new() and id2ptr_remove() would need similar use-count
adjustments.

Or, a callback capability could be added to the API.  The callback
function would be registered by a new argument to id2ptr_init() and
called by id2ptr_lookup() before it dropped the lock.  In this case,
we would change id2ptr_init to look like:

    void id2ptr_init(struct id *id, int min_wrap, void (*func)(void *data));

where the callback function is defined to take one argument, the
(void *) value attached to the ID.  You (&Jim) would use this
callback mechanism to provide a function that would lock down the
data structure represented by the (void *) passed-in argument.



> Another issue with locking is the irq required or not thing.  Irq
> locking is VERY expensive and getting more so as cpu speeds go up and
> I/O speeds stay the same.  If it is not needed, it is best not to use
> it.  Again, exporting the locking to the caller seems the best answer.

IIRC, it is the spin_lock_* part that is expensive, not the *_irq part.
Interrupt locking is merely setting/clearing a bit in the EFLAGS
register, which (if the i386 follows the PowerPC pattern, the CPU I
am most familiar with), is slower than setting/clearing a bit in a
general purpose register but not that much slower.

On the other hand, the bus locking of spin_lock_* stops all other cpus
and dma traffic from accessing the bus for the interval of the lock,
this can be devastating on systems with large numbers of cpus and/or
high IO traffic.  However, this is not a problem on all architectures.
The PowerPC, for one, provides a pair of instructions which one can
implement spin_lock without utilizing a bus lock.  I look forward to
the day Intel adds a similiar pair of instructions to their ISA.

In any case, all of the ID user interfaces have exactly one lock and
one unlock along their most commonly executed patch.  One can't get
any better than that without resorting to architecture tricks like
assuming reads and writes go out to memory in a certain order.



> I would much prefer to return memory on release.  In my code
> I currently only return the leaf nodes, but I consider this
> something to be fixed rather than a feature.

I have an adjustment in mind which would allow the O(1) ID allocator
to return excess memory.  Each ID block would do its own little free
list and those lists in turn would be chained together.  That way it
would be easy to kfree() an ID block once it became completely full
of freed IDs.



> While the code is order 1 it does do a divide which, as I
> understand it, is rather expensive (risc machines do them
> with subroutines).  It is rather easy to eliminate the
> recursion in an radix-tree AND avoid the div at the same
> time.

I will make this change.  Thanks.



> I would consider moving the "ctr" member to the root of the
> tree and using the same one for all allocations.  I may be
> wrong here, but I think it gives a better cycle time for the
> bits used.

A random value works just as well (actually a little better) than a
counter that is not unique to each ID data structure.  I may go the
(pseudo) random route & eliminate the ctr altogether.  Or I may be
able to find some unused bits in the ID data structure where I can
pack it in.

Thanks for your feedback,
Joe
