Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292594AbSB0PyF>; Wed, 27 Feb 2002 10:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSB0Px4>; Wed, 27 Feb 2002 10:53:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46241 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292595AbSB0Pxk>;
	Wed, 27 Feb 2002 10:53:40 -0500
Date: Wed, 27 Feb 2002 10:53:11 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020227105311.C838@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227112417.3a302d31.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Feb 27, 2002 at 11:24:17AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 11:24:17AM +1100, Rusty Russell wrote:
> On Mon, 25 Feb 2002 10:00:25 -0500
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> 
> > Rusty, since I supplied one of those packages available under lse.sourceforge.net
> > let me make some comments.
> > 
> > (a) why do you need to pin. I simply use the user level address (vaddr)  
> >     and hash with the <mm,vaddr> to obtain the internal object.
> >     This also gives me full protection through the general vmm mechanisms.
> 
> I pin while sleeping for convenience, so I can get a kernel address.  It's
> only one page (maybe 2).  I could look up the address every time, but then I
> need to swap the page back in anyway to look at it.

As stated above, I allocate a kernel object <kulock_t> on demand and
hash it. This way I don't have to pin any user address. What does everybody
think about the merit of this approach versus the pinning approach?
Most importantly I think the merit of both approaches stems from the fact
that the access is purely through the userlevel address rather than
through a handle. In your case, can the lock be allocated at different
virtual addresses in the various address spaces.
How do you cleanup ? Do you search through the hashtable ? In other words
what happens if you SIGTERM a process ?
> 
> > (b) I like the idea of mmap or shmat with special flags better than going 
> >     through a device driver.
> 
> Me too, but I'd rather have people saying "make it a syscall" than "eww...
> not another special purpose syscall!" 8)

One more syscall its all that needed like semop(). I multiplex all operations
through this interface. Agree, its more scalable then a device driver as
somebody pointed out that the device has locks associated with it.
> 
> > (c) creation can be done on demand, that's what I do. If you never have 
> >     to synchronize through the kernel than you don't create the objects. 
> >     There should be an option to force explicite creation if desired.
> 
> Absolutely, except there is no real "creation" event.  Adding a "here be
> semaphores" syscall is sufficient and useful (and also makes it easy to
> detect that there is no FUS support in the kernel).

That's what I have done. All internal objects are created on the fly.
Somebody pointed out to me that RT programs might want to allocate the 
internal object apriori, in that case the forcing the creation would be
required.

> 
> > (d) The kernel should simply provide waiting and wakeup functionality and 
> >     the bean counting should be done in user space. There is no need to 
> >     pin or crossmap.
> 
> See above.

Yip, no state sharing required between kernel and user. I analyzed this 
vary carefully, particularly for spinning locks, I can show you sequences
of events that get you in real trouble because the atomic update in user
space and the waiting are non atomic. As far as I am concerned separation
is imperative.

> 
> > (e) I really like to see multiple reader/single writer locks as well. I 
> >     implemented these 
> 
> Hmmm... my current implementatino only allows down one and up one
> operations, but off the top of my head I don't see a no reason this couldn't
> be generalized.   Then:
> 1) Initialize at INT_MAX
> 2) down_read = down 1
> 3) down_write = down INT_MAX
> 
> Sufficient?
> 

No, you effectively need two queues or you have to basically replicate
the low level semaphore routines to walk the list and identify the
sequence (R*W)* and only wake those up that are the same. There are many
issues in the wakeup. Do I want to wakeup all readers waiting regardless
of intermittent writers....

> > (f) I also implemented convoy avoidance locks, spinning versions of 
> >     user semaphores.  All over the same simple interface.
> >     ulocks_wait(read_or_write) and ulocks_signal(read_or_write, num_to_wake_up).
> >     Ofcourse to cut down on the interface a single system call is enough.
> 
> Interesting.  Something like this might be needed for backwards
> compatibility anyway (spin & yield, at least).

This is a must. I talked to database folks, they can see huge utilization
out of these locks. I hence echo again Ben LaHaises opinion, the kernel
mechanism must be flexible enough to support more complex locking stuff.
I have added in my next update on lse download support for queues.

> 
> > (g) I have an extensive test program and regression test <ulockflex>
> >     that exercises the hell out of the userlevel approach. 
> 
> Excellent.   I shall grab it and take a look!

Indeed this is/was a lifesaver, it points out so many interesting things
with respect to bugs and performance when the rubber hits the road.

> 
> Thanks for the feedback,
> Rusty.

Let's keep the sync going. At this point we need to figure out what
is the right approach for the kernel. Is the explicite kernel object 
approach I have chosen better/worse/equal to the pinning approach ?
Inputs from everyone please. We need to score against
	codepath length, 
	cleanup, 
	memory requirements

> -- 
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Cheers.
-- Hubertus
