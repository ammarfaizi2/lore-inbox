Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291269AbSCDERV>; Sun, 3 Mar 2002 23:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSCDERM>; Sun, 3 Mar 2002 23:17:12 -0500
Received: from slip-202-135-78-125.ad.au.prserv.net ([202.135.78.125]:18048
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S291269AbSCDEQ6>; Sun, 3 Mar 2002 23:16:58 -0500
Date: Mon, 4 Mar 2002 00:30:40 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020304003040.21ac02b7.rusty@rustcorp.com.au>
In-Reply-To: <20020302095031.A1381@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
	<20020225100025.A1163@elinux01.watson.ibm.com>
	<20020227112417.3a302d31.rusty@rustcorp.com.au>
	<20020302095031.A1381@elinux01.watson.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002 09:50:31 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:

> On Wed, Feb 27, 2002 at 11:24:17AM +1100, Rusty Russell wrote:
> > - We can no longer do generic semaphores: mutexes only.
> > - Requires arch __update_count atomic op.
> 
>     I don't see that, you can use atomic_inc on 386s ..

__update_count needed to be able to do the decrement from 0 or
the count, whichever was greater.  I have eliminated this in the
new patch (patch III).

> (a) the hashing is to simple. As a consequence there are two limitations
>      -  the total number of locks that can be waited for is 
>         (1<< USEM_HASHBITS).
>         that is way not enough (as you pointed out).
>      - this has to be bumped up to roughly the number of tasks in the
>        system.

OK.  We dealt with hash collisions by sharing waitqueues.  This works, but
means we have to do wake-all.  My new patch uses its own queues: we still
share queues, but we only wake the first one waiting on our counter.

> (c) your implementation could be easily expanded to include Ben's
>     suggestion of multiple queues (which I already implement in my 
>     submission), by including the queue index into the hashing mechanism.

Hmmm.... it should be pretty easy to extend: the queues can be shared.

> (f) Why get away from semaphores and only stick to mutexes. Isn't there
>     some value to provide counting semaphores ? Effectively, mutexes are
>     a subclass of semaphores with a max-count of 1.

Yes, but counting semaphores need two variables, or cmpxchg.  Mutexes do not
need either (proof by implementation 8).  While general counting semaphores
may be useful, the fact that they are not implemented in the kernel suggests
they are not worth paying extra for.

> (g) I don't understand the business of rechecking in the kernel. In your
>     case it comes cheap as you pinned the page already. In general that's 
>     true, since the page was just touched the pinning itself is reasonable
>     cheap. Nevertheless, I am concerned that now you need intrinsic knowledge
>     how the lock word is used in user space. For instance, I use it in 
>     different fashions, dependent whether its a semaphore or rwlock.

This is a definite advantage: my old fd-based code never looked at the
userspace counter: it had a kernel sempahore to sleep on for each
userspace lock. OTOH, this involves kernel allocation, with the complexity
that brings.

> (h) how do you deal with signals ? E.g. SIGIO or something like it.

They're interruptible, so you'll get -ERESTARTSYS.  Should be fine.
 
> Overall, pinning down the page (assuming that not a lot of tasks are
> waiting on a large number of queues at the same time) is acceptable, 
> and it cuts out one additional level of indirection that is present 
> in my submission.

I agree.  While originally reluctant, when it's one page per sleeping
process it's rather neat.

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
