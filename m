Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSLSSbi>; Thu, 19 Dec 2002 13:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLSSbi>; Thu, 19 Dec 2002 13:31:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44028 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265865AbSLSSbf>;
	Thu, 19 Dec 2002 13:31:35 -0500
Message-ID: <3E021237.763035FB@mvista.com>
Date: Thu, 19 Dec 2002 10:38:47 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>
CC: akpm@digeo.com, torvalds@transmeta.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An O1, nonrecursive ID allocator for Posix timers
References: <200212191408.OAA07548@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> >> This is a drop-in replacement for the ID allocator that Jim Houston
> >> wrote to support posix timers.  [...]
> >
> > A few comments:
> >
> > I have found that the locking needs on lookup require that
> > the object be locked before the id-look-up is unlocked.
> > With out this it is possible to find an object and have it
> > "removed" by another prior to getting it locked.  This is
> > why, in my version, the lock is exported.
> 
> Hi George,
> Ouch.  I completely missed this API flaw.  Good catch.
> 
> Some ideas: rather than exporting the lock, we could replace
> 
>     int id2ptr_lookup(...)
> 
> with a
> 
>     int id2ptr_get(...)
>     void id2ptr_put(...)
> 
> pair.  id2ptr_get() would do the old id2ptr_lookup semantics plus
> bump a use-count on the ID.  id2ptr_put() would decrement the
> use-count and delete the ID if the use-count became zero.
> id2ptr_new() and id2ptr_remove() would need similar use-count
> adjustments.
> 
> Or, a callback capability could be added to the API.  The callback
> function would be registered by a new argument to id2ptr_init() and
> called by id2ptr_lookup() before it dropped the lock.  In this case,
> we would change id2ptr_init to look like:
> 
>     void id2ptr_init(struct id *id, int min_wrap, void (*func)(void *data));
> 
> where the callback function is defined to take one argument, the
> (void *) value attached to the ID.  You (&Jim) would use this
> callback mechanism to provide a function that would lock down the
> data structure represented by the (void *) passed-in argument.

This might work, but consider this:  How might one remove an
ID and what it points at.  It needs to disappear atomically
or some cpu will end up with a valid ID that points at a
structure that has been returned.  One way of doing this
would be to do the id look up to get the structure and then,
under the same lock, do the id_remove.

The way I do it in the posix_timers is to look up, under the
look up, lock the structure, unlock the look up, flag the
structure as "gone" and then go about removing it.  This
way, another cpu will still find it but will also find a
"gone" flag, which must be checked on each lookup.  As I
write this, I realize that I would prefer the first way of
doing things.

Why not remove all locking from the id2ptr code and let the
user take care of it?  You might have to export one
additional function which "prepares to allocate an id" so
you can call the slab code without being locked.
> 
> > Another issue with locking is the irq required or not thing.  Irq
> > locking is VERY expensive and getting more so as cpu speeds go up and
> > I/O speeds stay the same.  If it is not needed, it is best not to use
> > it.  Again, exporting the locking to the caller seems the best answer.
> 
> IIRC, it is the spin_lock_* part that is expensive, not the *_irq part.
> Interrupt locking is merely setting/clearing a bit in the EFLAGS
> register, which (if the i386 follows the PowerPC pattern, the CPU I
> am most familiar with), is slower than setting/clearing a bit in a
> general purpose register but not that much slower.

I don't believe this is so.  The interrupt on/off change
needs to sync with the I/O system, to avoid in-flight stuff,
and so introduces stalls.  I suspect that sometimes it also
needs to flush the pipeline, but I am not that up on those
sorts of details.  I have, however, seen the results of some
timing studies done on the run_timer_list code which showed
that the whole of the run_timer_list function was shorter
that the interrupt off instruction.  I think this was on a
1.3GHZ PIII.  I know this was an issue on the PARISC (the
last machine I worked on) also, so I think it is common to
all modern machines that run the cpu faster and async to the
I/O bus.
> 
> On the other hand, the bus locking of spin_lock_* stops all other cpus
> and dma traffic from accessing the bus for the interval of the lock,

No, this is not true.  The lock is only for the access time
of the spinlock byte.  If spinning, the lock will be taken
quite often, but even then there are other unlocked
instructions in the loop.

> this can be devastating on systems with large numbers of cpus and/or
> high IO traffic.  However, this is not a problem on all architectures.
> The PowerPC, for one, provides a pair of instructions which one can
> implement spin_lock without utilizing a bus lock.  I look forward to
> the day Intel adds a similiar pair of instructions to their ISA.
> 
> In any case, all of the ID user interfaces have exactly one lock and
> one unlock along their most commonly executed patch.  One can't get
> any better than that without resorting to architecture tricks like
> assuming reads and writes go out to memory in a certain order.
> 
> > I would much prefer to return memory on release.  In my code
> > I currently only return the leaf nodes, but I consider this
> > something to be fixed rather than a feature.
> 
> I have an adjustment in mind which would allow the O(1) ID allocator
> to return excess memory.  Each ID block would do its own little free
> list and those lists in turn would be chained together.  That way it
> would be easy to kfree() an ID block once it became completely full
> of freed IDs.
> 
> > While the code is order 1 it does do a divide which, as I
> > understand it, is rather expensive (risc machines do them
> > with subroutines).  It is rather easy to eliminate the
> > recursion in an radix-tree AND avoid the div at the same
> > time.
> 
> I will make this change.  Thanks.
> 
> > I would consider moving the "ctr" member to the root of the
> > tree and using the same one for all allocations.  I may be
> > wrong here, but I think it gives a better cycle time for the
> > bits used.
> 
> A random value works just as well (actually a little better) than a
> counter that is not unique to each ID data structure.  I may go the
> (pseudo) random route & eliminate the ctr altogether.  Or I may be
> able to find some unused bits in the ID data structure where I can
> pack it in.

I have not looked at random number generators, but I assumed
a counter would be faster.  I could be wrong here...
> 
> Thanks for your feedback,
> Joe

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
