Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283860AbRLITrS>; Sun, 9 Dec 2001 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283871AbRLITrI>; Sun, 9 Dec 2001 14:47:08 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:37900 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283860AbRLITrC>; Sun, 9 Dec 2001 14:47:02 -0500
Date: Sun, 9 Dec 2001 11:48:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <anton@samba.org>, <davej@suse.de>,
        <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <E16D6l9-00073R-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091122330.7268-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Alan Cox wrote:

> > Using the scheduler i'm working on and setting a trigger load level of 2,
> > as soon as the idle is scheduled it'll go to grab the task waiting on the
> > other cpu and it'll make it running.
>
> That rapidly gets you thrashing around as I suspect you've found.

Not really because i can make the same choices inside the idle code, out
of he fast path, without slowing the currently running cpu ( the waker ).


> I'm currently using the following rule in wake up
>
> 	if(current->mm->runnable > 0)	/* One already running ? */
> 		cpu = current->mm->last_cpu;
> 	else
> 		cpu = idle_cpu();
> 	else
> 		cpu = cpu_num[fast_fl1(runnable_set)]
>
> that is
> 	If we are running threads with this mm on a cpu throw them at the
> 		same core
> 	If there is an idle CPU use it
> 	Take the mask of currently executing priority levels, find the last
> 	set bit (lowest pri) being executed, and look up a cpu running at
> 	that priority
>
> Then the idle stealing code will do the rest of the balancing, but at least
> it converges towards each mm living on one cpu core.

I've done a lot of experiments balancing the cost of moving tasks with
related tlb flushes and cache image trashing, with the cost of actually
leaving a cpu idle for a given period of time.
For example in a dual cpu the cost of leaving an idle cpu for more than
40-50 ms is higher than immediately fill the idle with a stolen task (
trigger rq length == 2 ).
This picture should vary a lot with big SMP systems, that's why i'm
seeking at a biased solution where it's easy to adjust the scheduler
behavior based on the underlying architecture.
For example, by leaving balancing decisions inside the idle code we'll
have a bit more time to consider different moving costs/metrics than will
be present for example in NUMA machines.
By measuring the cost of moving with the cpu idle time we'll have a pretty
good granularity and we could say, for example, that the tolerable cost of
moving a task on a given architecture is 40 ms idle time.
This means that if during 4 consecutive timer ticks ( on 100 HZ archs )
the idle cpu has found an "unbalanced" system, it's allowed to steal a
task to run on it.
Or better, it's allowed to steal a task from a cpu set that has a
"distance" <= 40 ms from its own set.





- Davide


