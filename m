Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129649AbQKKKaw>; Sat, 11 Nov 2000 05:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbQKKKam>; Sat, 11 Nov 2000 05:30:42 -0500
Received: from slc229.modem.xmission.com ([166.70.9.229]:8711 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129649AbQKKKa0>; Sat, 11 Nov 2000 05:30:26 -0500
To: Andrew Morton <andrewm@uow.edu.au>
Cc: George Anzinger <george@mvista.com>, Keith Owens <kaos@ocs.com.au>,
        John Kacur <jkacur@home.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks'  WHAT?!
In-Reply-To: <23569.973832900@kao2.melbourne.sgi.com> <3A0C2D4A.83C75D4B@mvista.com> <3A0C90FD.CB645430@uow.edu.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 01:50:23 -0700
In-Reply-To: Andrew Morton's message of "Sat, 11 Nov 2000 11:21:17 +1100"
Message-ID: <m1y9yqdh9s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <andrewm@uow.edu.au> writes:

> George Anzinger wrote:
> > 
> > The notion of releasing a spin lock by initializing it seems IMHO, on
> > the face of it, way off.  Firstly the protected area is no longer
> > protected which could lead to undefined errors/ crashes and secondly,
> > any future use of spinlocks to control preemption could have a lot of
> > trouble with this, principally because the locker is unknown.
> > 
> > In the case at hand, it would seem that an unlocked path to the console
> > is a more correct answer that gives the system a far better chance of
> > actually remaining viable.
> > 
> 
> Does bust_spinlocks() muck up the preemptive kernel's spinlock
> counting?  Would you prefer spin_trylock()/spin_unlock()?
> It doesn't matter - if we call bust_spinlocks() the kernel is
> known to be dead meat and there is a fsck in your near future.
> 
> We are still trying to find out why kumon@fujitsu's 8-way is
> crashing on the test10-pre5 sched.c.  Looks like it's fixed
> in test11-pre2 but we want to know _why_ it's fixed.  And at
> present each time he hits the bug, his printk() deadlocks.
> 
> So bust_spinlocks() is a RAS feature :)  A very important one -
> it's terrible when your one-in-a-trillion bug happens and there
> are no diagnostics.
> 
> It's a work-in-progress.  There are a lot of things which
> can cause printk to deadlock:
> 
> - console_lock
> - timerlist_lock
> - global_irq_lock (console code does global_cli)
> - log_wait.lock
> - tasklist_lock (printk does wake_up) (*)
> - runqueue_lock (printk does wake_up)
> 
> I'll be proposing a better patch for this in a few days.

Hmm.  I would like to suggest we look at non locking variants of
things. i.e. Data structure version changing with swap.  


Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
