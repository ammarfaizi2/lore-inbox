Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286143AbRLJCfA>; Sun, 9 Dec 2001 21:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286144AbRLJCev>; Sun, 9 Dec 2001 21:34:51 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:50446 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286143AbRLJCef>; Sun, 9 Dec 2001 21:34:35 -0500
Date: Sun, 9 Dec 2001 18:36:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <E16DF39-00008w-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091738540.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > Alan, you're mixing switch mm costs with cache image reload ones.
> > Note that equal mm does not mean matching cache image, at all.
>
> They are often close to the same thing. Take a look at the constraints
> on virtually cached processors like the ARM where they _are_ the same thing.
>
> Equal mm for cpu sucking tasks often means equal cache image. On the other
> hand unmatched mm pretty much definitively says "doesnt matter". The cost
> of getting the equal mm/shared cache case wrong is too horrific to handwave
> it out of existance using academic papers.

This is very difficult to prove and heavily depend on the application
architecture.
Anyway i was just thinking that, if we scan the cpu bound queue like
usual, by correctly sorting out mm related tasks, we're going to blend
this time ( about 2.9us with rqlen=32 on a dual PIII 733, std scheduler )
inside the cpu bound average run time ( 30-60ms ).
This means ~ 0.005%


> > By having only two queues maintain the implementation simple and solves
> > 99% of common/extraordinary cases.
> > The cost of a tlb flush become "meaningful" for I/O bound tasks where
> > their short average run time is not sufficent to compensate the tlb flush
> > cost, and this is handled correctly/like-usual inside the I/O bound queue.
>
> You don't seem to solve either problem directly.
>
> Without per cpu queues you spend all your time bouncing stuff between
> processors which hurts. Without multiple queues for interactive tasks you
> walk the interactive task list so you don't scale. Without some sensible
> handling of mm/cpu binding you spend all day wasting ram bandwidth with
> cache writeback.

It has two queues ( cpubound + iobound-rttasks ) per CPU, as i wrote in my
previous message.
By having split in a multi-queue model plus having a separate queue for
iobound tasks, i think it'll scale pretty well indeed.
Two queues against N means even a lower scheduler memory footprint.
The whole point is to understand where greater optimizations will not pay
for the greater complexity ( plus D/I cache footprint ).



> The single cpu sucker queue is easy, the cost of merging mm equivalent tasks
> in that queue is almost nil. Priority ordering interactive stuff using
> several queues is easy and very cheap if you need it (I think you do hence
> I have 7 priority bands and you have 1). In all these cases the hard bits
> end up being
>
> On a wake up which cpu do you give a task ?

The multi queue scheduler is not like the old one where the bunch of
running tasks virtually own to all cpu.
In a multi queue scheduler tasks are _local_by_default_.


> When does an idle cpu steal a task, who from and which task ?
> How do I define "imbalance" for cpu load balancing ?

As i wrote in previous messages the idle(s) is woken up at every timer
tick and check the balance status.
After N ( tunable ) consecutive ticks that the idle has found an
unbalanced status, it'll try to steal a tasks.
>From where, you could ask ?
This is a good question and the best answer to good questions is:

I don't know :)

Just kidding ( only in part ).
There're several concepts:

1) cpu load expressed in run queue length
2) cpu load expressed as the sum ( in jiffies ) of the average run time of
	the currently running task set
3) distance/metric of the move ( think about NUMA )
4) last mm used by the idle
5) last time in jiffies the task is ran

The trick is to find a function :

F = F( RQL, JLD, DIS, LMM, JLT )

so we can sort out and select the best task to run on the idle cpu.
And more, the cpu selection must be done without locking remote runqueue.
So it should be a two-phase task:

1) cpu selection ( no locks held )
2) task selection inside the selected cpu ( remote queue lock held )

The first phase will use 1, 2 and 3 from the above variable set, while the
second will use 4 and 5 for tasks selection inside the queue.




- Davide



