Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLHCYv>; Thu, 7 Dec 2000 21:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQLHCYl>; Thu, 7 Dec 2000 21:24:41 -0500
Received: from gateway.sequent.com ([192.148.1.10]:10362 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129627AbQLHCYY>; Thu, 7 Dec 2000 21:24:24 -0500
Date: Thu, 7 Dec 2000 17:53:36 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Lock ordering, inquiring minds want to know.
Message-ID: <20001207175336.A15623@w-mikek.des.sequent.com>
In-Reply-To: <3A301826.B483D19D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A301826.B483D19D@mvista.com>; from george@mvista.com on Thu, Dec 07, 2000 at 03:07:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,

I can't answer your question.  However, have  you noticed that this
lock ordering has changed in the test11 kernel.  The new sequence is:

        read_lock_irq(&tasklist_lock);
        spin_lock(&runqueue_lock);

Perhaps the person who made this change could provide their reasoning.

An additional question I have is:  Is it really necessary to hold
the runqueue lock (with interrupts disabled) for as long as we do
in this routine (setscheduler())?  I suspect we only need the
tasklist_lock while calling find_process_by_pid().  Isn't it
possible to do the error checking (parameter validation) with just
the tasklist_lock held?  Seems that we would only need to acquire
the runqueue_lock (and disable interrupts) if we are in fact
changing the task's scheduling policy.
-
Mike

On Thu, Dec 07, 2000 at 03:07:18PM -0800, george anzinger wrote:
> In looking over sched.c I find:
> 
> 	spin_lock_irq(&runqueue_lock);
> 	read_lock(&tasklist_lock);
> 
> 
> This seems to me to be the wrong order of things.  The read lock
> unavailable (some one holds a write lock) for relatively long periods of
> time, for example, wait holds it in a while loop.  On the other hand the
> runqueue_lock, being a "irq" lock will always be held for short periods
> of time.  It would seem better to wait for the runqueue lock while
> holding the read_lock with the interrupts on than to wait for the
> read_lock with interrupts off.  As near as I can tell this is the only
> place in the system that both of these locks are held (of course, all
> cases of two locks being held at the same time, both locker must use the
> same order).  So...
> 
> 
> What am I missing here? 
> 
> George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
