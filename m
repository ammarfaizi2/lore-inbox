Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTLDJ2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLDJ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:28:15 -0500
Received: from fmr06.intel.com ([134.134.136.7]:21697 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263258AbTLDJ2D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:28:03 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Date: Thu, 4 Dec 2003 01:27:42 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DD67@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Thread-Index: AcO6KrVu+uNLshYETm2zUY2/Ep48KQAFyM5A
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 04 Dec 2003 09:27:42.0934 (UTC) FILETIME=[DE783F60:01C3BA48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Jamie Lokier [mailto:jamie@shareable.org]

> Iñaky Pérez-González wrote:


> If you are only doing priority inheritance for RT priorities, then
> it's not such a big deal to have task B boosted.

Heh ... doing it for SCHED_OTHER becomes a nightmare, and I still
am not that sure is feasible without major surgery on the way
the priority information is stored in the task_struct now; as well,
POSIX says nothing about it, or at least is kind of gray in a sense
where it seems only SCHED_{FIFO,RR} should be involved, so I am 
really tempted not to do it (well, that's what is nicing it towards
20 :)

> > That was the first thing I thought of; however, it is not an easy
> > task--for example, now you have to allocate a central node that has
> > to live during the life of the waitqueue (unlike in futexes), and
> > that didn't play too well -- with the current code, unlike my previous
> > attempt with rtfutexes, it is not that much of a deal and could be
> > done, but I don't know how much of the interface I could emulate.
> 
> What do you need the central node for?

In futexes we have that each hash chain has all the waiters, in FIFO
arrival order, and we just wake as many as needed. In the fuqueues, 
this wake up has to be by priority. We could walk that chain pedaling
back and forth to wake them up in the correct order, but that would be
anything but O(1), and being "real-time" like, or predictable, is one
of the requirements.

So the wait list has a head, the fuqueue->wlist, and the waiters are
appended there in their correct position (so addition is O(N) now, will
change to O(1) IANF, and removal of the highest priority guy is O(1)--
take the guy in the head).

Now, on ufuqueues (the ones that are associated to user space addresses,
the true futex equivalent) that means you can't do the trick of the 
futex chain lists, so you have on each chain a head per ufuqueue/user
space address. That ufuqueue cannot be declared on the stack of one
of the waiters, as it would disappear when it is woken up and might leave
others dangling.

So we have to allocate it, add the waiters to it and deallocate it when 
the wait list is empty. This is what complicates the whole thing and 
adds the blob of code that is vl_locate() [the allocation and addition 
to the list, checking for collisions when locks are dropped]. As the 
whole thing is kind of expensive, we better cache it for a few seconds, 
as chances are we will have some temporal locality (in fact, it happens, 
it improves the performance a lot), so that leads to more code for the 
"garbage collector" that cleans the hash chains of unused queue heads
every now and then. All this is what the vlocator code does.

> > >   - Is there a method for passing the locked state to another task?
> > >     Compare-and-swap old-pid -> new-pid works when there isn't any
> > >     contention, but a kernel call is needed in any of the
> > >     kernel-controlled states.
> >
> > That can be done, because if you are in non-KCO mode (ie: pid), the
> > kernel by definition knows nil about the mutex, so just do the compare
> > and swap in user space and you are ready. No need to add any special
> > code.
> 
> The question asks what to do in the KCO state.  I.e. when you want to
> transfer a locked state and there are waiters.

Ah, ah, ah ... makes sense. Ok, so this is like an unlock operation 
but "unlock to this guy". Well, same thing, but extended. You need to
try it first in user space, if that fails because it is KCO (locked
and there are waiters), then go to the kernel and ask it to transfer
ownership in there.

Piece of cake, more or less, and can be done O(1) by checking 
dest_task->fuqueue_wait. Why the interest for this? I am curious
to see what could it be used for.

I will give it a shot as soon as I have a minute (unless your question
was purely academic and plan no uses for it).

> If it is as simple as just keeping the mutex in KCO mode all the time
> on archs which don't have compare-and-swap, or those that do if an
> application doesn't have explicit asm code for that arch, that would
> be very convenient.
> 
> I haven't thought through whether keeping a mutex in KCO mode has this
> capability.  Perhaps you have and can state the answer?

First I should make a distinction that is causing way too much confusion,
one thing is KCO for the vfulock (telling the user that it has to go to
the kernel) and the other is using it always in KCO mode by passing a
yet-to-be-implemented-flag FULOCK_FL_KCO to the sys_ufulock_*() system
calls (so it skips all the ugly synchronization code).

This FULOCK_FL_KCO is needed for priority protection anyway, so it will
be there no matter what; thus, in arches without atomic compare-and-swap,
it becomes a matter of ops-I-don't-have-the-fast-path so I just call the
syscall with that bit set.

> > Another thing I discarded; then there is no way for the kernel to
> > identify the owner and most of fusyn's benefits disappear. However,
> > I want to give it a second try, in such a way that it would disable
> > owner identification (as well as priority inheritance).
> 
> You don't lose the owner id, because pid is always positive so there's
> a spare bit.

But still you need to set the full PID--or whatever you use for 
identifying yourself as the owner--atomically. If you are thinking of
using bit 32 as a spinlock and then once you have it, set the rest of
the PID in a non-atomic fashion, I'd forget it. Consider the following
scenario:

Task A: FIFO, prio 5, 

time  A
0     sets bit 32, succeeds
1     sets pid(A)
..    does his thing as lock owner
 
Now the same, but Task B, FIFO prio 6 is trying to do the same

time  A                        B
0     sets bit 32, succeeds
1                              spins trying to set bit
puf!

Now you could say: okay, let's yield B, but it'd not work because
B is prio six and A is five; as you know, you are toast, as B will
run again and A won't.

Another option is as B sees that bit 32 is 1, it goes down to the 
kernel; but A still might not have had a chance to set the PID, so
B (in the kernel) has no means to identify who is A; it can create
the ufulock and leave it in some 'owner unknown state' and queue 
for it--however, how do we find who A is? The synch code in the 
kernel still needs to do an atomic operation, protecting against
user space, to put the v/ufulock in KCO mode, and for robustness to
work correctly, A might have to check that something like that happened
to call the kernel and let it know that it is the owner...

Maybe I am missing a simpler solution, but I just thought, after 
spinning it many times that it wasn't worth the effort, as most
modern arches have an atomic compare and swap, even embedded targets;
and that the easiest thing to do is either to run all the time in
KCO mode or massage the code a wee bit so that owner identification
(and associated goodies) are disabled.

> It would be great if the KCO state could be used to provide complete
> portability, and then adding arch-specific asm code to the
> applications becomes an optimisation, not a requirement.

Yep, as I said, my next requirement is to add that code tidbit, so
that will not be a problem. Being the optimization a simple 
atomic-compare-and-swap, I don't foresee too much uglyness on it.

> More complex locks can be implemented with one or two bits in an
> object and auxiliary user-space data structures hashing the object
> address in the contended case (which is usually a very small subset of
> all the objects).
> 
> In these ways, futex is very versatile.

Agreed - but as I explained above, that leads to many ugly conditions in
real-time scheduling environments (and they can lead to deadline misses
or who knows). I'd love to be proven wrong, or that I missed one or more
ways to do it...I just got drained :]

Now, fuqueues still can do all that, because except for the wake up
order and because you can get -ENOMEM on wait(), they behave exactly
the same.

> Thinking this over, it occurs to me that you can also implement lock
> stealing.  You know who the owner is, so you can send a signal to the
> owner saying "please release the lock", but actually stealing a lock
> requires kernel support doesn't it?  Just a thought, not sure how
> useful that would be.

Yep, it is similar, if not the same, as the "unlock to this guy" we were 
discussing above [and not necessarily the owner is the one that has to
unlock, anybody with access to the lock can unlock it].

However, I am kind of reluctant to add code to do that unless it is really
needed. I am going to have already a hard sell with this as to bloat it
a wee bit more :) [I can already hear Ulrich sharpening his Jagdmesser
over the proposed modifications to NPTL to support this].

> > Asides from the comments, it adds the most complex/bloating part,
> > the priority-sorted thingie and chprio support vs not having the FUTEX_FD
> > or requeue support...it comes to be, more or less equivalent, considering
> > all the crap that has to be changed for the prioritization to work
> > respecting the incredibly stupid POSIX semantincs for mutex lifetimes.
> 
> Are there specified POSIX semantics for prioritisation and mutex interaction?

Yep, they state different things on all that, and how you don't need to 
necessarily destroy non-shared mutexes (vs shared) and a few more things
that made my life a little bit more exciting...I think I still need to tweak
a few bits more on the priority inheritance stuff to get it completely up
to the spec, but it should be pretty good already.

Oh, did I mention anywhere you can also use the fulocks in the kernel to
replace the DECLARE_MUTEXes and gain robustness, pi and pp? Wonder if anybody
will find this interesting.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
