Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288999AbSANUEw>; Mon, 14 Jan 2002 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSANUDH>; Mon, 14 Jan 2002 15:03:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:54532 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288992AbSANUCa>;
	Mon, 14 Jan 2002 15:02:30 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201141216520.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201141216520.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 15:05:23 -0500
Message-Id: <1011038724.4603.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 09:35, Rik van Riel wrote:
> OK, suppose you have three tasks.
> 
> A is a SCHED_FIFO task
> B is a nice 0 SCHED_OTHER task
> C is a nice +19 SCHED_OTHER task
> 
> Task B is your standard CPU hog, running all the time, task C has
> grabbed  an inode semaphore (no spinlock), task A wakes up, preempts
> task C, tries to grab the inode semaphore and goes back to sleep.
> 
> Now task A has to wait for task B to give up the CPU before task C
> can run again and release the semaphore.
> 
> Without preemption task C would not have been preempted and it would
> have released the lock much sooner, meaning task A could have gotten
> the resource earlier.
> 
> Using the low latency patch we'd insert some smart code into the
> algorithm so task A also releases the lock before rescheduling.
> 
> Before you say this thing never happens in practice, I ran into
> this thing in real life with the SCHED_IDLE patch. In fact, this
> problem was so severe it convinced me to abandon SCHED_IDLE ;))

This isn't related.  The problem you described can happen nearly as
easily on a non-preemptible system.  We have plenty of semaphores held
across schedules and there is no reason to single out ones that acquire
and release the semaphore in short, non-preemptible, sequences.  We
always have this "problem."

SCHED_IDLE is much different, as you know, because the SCHED_IDLE task
holding the lock can _never_ get scheduled if there is a CPU hog on the
system!  With the preemptive case, we only worry about an increase in
this period, which is at the expense of fairness in running higher
priority tasks.  But I think you know this ...

	Robert Love

