Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311221AbSCLO4F>; Tue, 12 Mar 2002 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311223AbSCLOzy>; Tue, 12 Mar 2002 09:55:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21674 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311221AbSCLOzp>; Tue, 12 Mar 2002 09:55:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Tue, 12 Mar 2002 09:56:42 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16kgaz-0007ry-00@wagner.rustcorp.com.au>
In-Reply-To: <E16kgaz-0007ry-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020312145542.2C8613FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 March 2002 02:20 am, Rusty Russell wrote:
> In message <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com>
> you
>
>  write:
> > On Sat, 9 Mar 2002, Rusty Russell wrote:
> > > > So I would suggest making the size (and thus alignment check) of
> > > > locks at least 8 bytes (and preferably 16). That makes it slightly
> > > > harder to put locks on the stack, but gcc does support stack
> > > > alignment, even if the cod
>
> e
>
> > > > sucks right now.
> > >
> > > Actually, I disagree.
> > >
> > > 1) We've left wiggle room in the second arg to sys_futex() to add
> > > rwsems later if required.
> > > 2) Someone needs to implement them and prove they are superior to the
> > >    pure userspace solution.
> >
> > You've convinced me.
>
> Damn.  Because now I've been playing with a different approach.
>
> If we basically export "add_to_waitqueue", "del_from_waitqueue",
> "wait_for_waitqueue" and "wakeup_waitqueue" syscalls, we have a more
> powerful interface: the kernel need not touch userspace addresses at
> all (no kmap/kunmap, no worried about spinlocks vs. rwlocks).
>
> The problem is that this fundamentally requires at least two syscalls
> in the slow path (add_to_waitqueue, try for lock, wait_for_waitqueue).
> My tests here show it's about 6% slower than the solution you accepted
> for tdbtorture (which means the slow path is significantly slower).  I
> can't imagine shaving that much more off it.
>
> There are variations on this: cookie could be replaces the page struct
> and the offset, ala futexes.
>
> Thoughts?
> Rusty.
>
> PS.  Kudos: it was Ben LaHaise's idea to export waitqueues, but I
>      didn't see how to do it until Paul M made a bad joke about two
>      syscalls....

Rusty, aren't you now going back to the design that I implemented after Ben's 
comments. 
>From the get-go, I never touched the user address in the kernel, as I thought 
it would require detailed knowledge of the user level locking strategy.

Could you explain, why you need add_to_waitqueue and wait_for_waitqueue as 
separate calls ? Is it for resolving a race conditions ?

One comment with respect to multiple wait queues and rwsems:
Again it will allow you to do reader-pref and/or writer-pref, but not 
something like FIFO, i.e. wake up a writer if first waiter or wake up all 
readers if first ..... and so on.
I don't know whether the latter is terrible important ...

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
