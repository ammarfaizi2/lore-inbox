Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292481AbSCDQwF>; Mon, 4 Mar 2002 11:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292482AbSCDQvz>; Mon, 4 Mar 2002 11:51:55 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5096 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292481AbSCDQvq>;
	Mon, 4 Mar 2002 11:51:46 -0500
Date: Mon, 4 Mar 2002 11:51:43 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020304115143.B1116@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au> <20020302095031.A1381@elinux01.watson.ibm.com> <20020304003040.21ac02b7.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304003040.21ac02b7.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Mon, Mar 04, 2002 at 12:30:40AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 12:30:40AM +1100, Rusty Russell wrote:
> On Sat, 2 Mar 2002 09:50:31 -0500
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> 

I am pretty much ready to support Rusty's latest patch. I think
much of the stuff I mentioned as been addressed.
The hash collision elimination the biggest one.
The page pinning is a great idea and I see that to be a great 
advantage over what I tried to push.

> > On Wed, Feb 27, 2002 at 11:24:17AM +1100, Rusty Russell wrote:
> > > - We can no longer do generic semaphores: mutexes only.
> > > - Requires arch __update_count atomic op.
> > 
> >     I don't see that, you can use atomic_inc on 386s ..
> 
> __update_count needed to be able to do the decrement from 0 or
> the count, whichever was greater.  I have eliminated this in the
> new patch (patch III).
> 
> > (a) the hashing is to simple. As a consequence there are two limitations
> >      -  the total number of locks that can be waited for is 
> >         (1<< USEM_HASHBITS).
> >         that is way not enough (as you pointed out).
> >      - this has to be bumped up to roughly the number of tasks in the
> >        system.
> 
> OK.  We dealt with hash collisions by sharing waitqueues.  This works, but
> means we have to do wake-all.  My new patch uses its own queues: we still
> share queues, but we only wake the first one waiting on our counter.
> 
> > (c) your implementation could be easily expanded to include Ben's
> >     suggestion of multiple queues (which I already implement in my 
> >     submission), by including the queue index into the hashing mechanism.
> 
> Hmmm.... it should be pretty easy to extend: the queues can be shared.
> 

Correct, should we bring that into the interface already. 
Expand the syscall with an additional parameter identifying the queue.

> > (f) Why get away from semaphores and only stick to mutexes. Isn't there
> >     some value to provide counting semaphores ? Effectively, mutexes are
> >     a subclass of semaphores with a max-count of 1.
> 
> Yes, but counting semaphores need two variables, or cmpxchg.  Mutexes do not
> need either (proof by implementation 8).  While general counting semaphores
> may be useful, the fact that they are not implemented in the kernel suggests
> they are not worth paying extra for.

Not exactly, they need one atomic in user space and a semaphore in the kernel
which as you stated uses (atomic and sleepers).

> 
> > (g) I don't understand the business of rechecking in the kernel. In your
> >     case it comes cheap as you pinned the page already. In general that's 
> >     true, since the page was just touched the pinning itself is reasonable
> >     cheap. Nevertheless, I am concerned that now you need intrinsic knowledge
> >     how the lock word is used in user space. For instance, I use it in 
> >     different fashions, dependent whether its a semaphore or rwlock.
> 
> This is a definite advantage: my old fd-based code never looked at the
> userspace counter: it had a kernel sempahore to sleep on for each
> userspace lock. OTOH, this involves kernel allocation, with the complexity
> that brings.
> 

???, kernel allocation is only required in under contention. If you take a look 
at how I used the atomic word for semaphores and for rwlock_t, its different. 
If you recheck in the kernel you need to know how this is used.
In my approach I simply allocated two queues on demand.

I am OK with only supplying semaphores and rwlocks, if there is a general consent
about it. Nevertheless, I think the multiqueue approach is somewhat more elegant
and expandable.

> > (h) how do you deal with signals ? E.g. SIGIO or something like it.
> 
> They're interruptible, so you'll get -ERESTARTSYS.  Should be fine.
>  

That's what I did too, but some folks pointed out they might want to 
interrupt a waking task, so that it can get back into user space and
fail with EAGAIN or so and do not automatically restart the syscall.

> > Overall, pinning down the page (assuming that not a lot of tasks are
> > waiting on a large number of queues at the same time) is acceptable, 
> > and it cuts out one additional level of indirection that is present 
> > in my submission.
> 
> I agree.  While originally reluctant, when it's one page per sleeping
> process it's rather neat.
> 

Yipp, most applications that will take advantage of this will allocate
the locks anyway in a shared region, i.e. there will be more than
one lock per page.

> Cheers!
> Rusty.
> -- 

As I said above, I am favor for the general infrastructure that you have in 
place now. Can we hash out the rwlock issues again.
They can still be folded into a single queue (logical) and you wakeup
eiher the next writer or set of readers, or all readers ....
We need a mean to bring that through the API. I think about it.

Great job Rusty, pulling all these issues together with a comprehensive patch.
The few remaining issues are cravy :-)

>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

-- Hubertus  
