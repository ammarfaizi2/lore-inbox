Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUJNTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUJNTxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUJNTuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:50:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62181 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267416AbUJNTr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:47:29 -0400
Date: Thu, 14 Oct 2004 21:48:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, Bill Huey <bhuey@lnxw.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Adam Heath <doogie@debian.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014194854.GA14763@elte.hu>
References: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >the overhead we can try to optimize later on. What problems do you see
> >with setting priorities on those IRQs?
> 
> Perhaps I am old fashioned, but in building a real time system, I
> consider hardware interrupt processing as something that is always at
> a higher priority than real time tasks. [...]

this is what i believe you'll ultimately get under PREEMPT_REALTIME:
instant execution of the hardware interrupt thread! Just give it a
higher RT priority than any of the existing tasks in the system:

	chrt -f -p 99 `pidof "IRQ 9"`

it is only a couple of microseconds to switch over from the current task
to the IRQ handling thread.

the only difference to a 'direct' interrupt is that it is you who
determines the policy and the priority of interrupt handling.

with direct interrupts there's no choice - a hardware interrupt has the
highest priority. In fact there's not even any way to prioritize 
hardware interrupts relative to each other.

> [...] In general that is not a problem because hardware interrupt
> processing should do just enough to keep the hardware happy and
> nothing more. I have enough spare CPU cycles within each frame to
> account for [could be a large number of] interrupts that follow that
> approach. Unthreaded IRQ's preserves that relationship.
> 
> However, with the threaded IRQ's, a real time program (e.g.,
> latencytest) can request a priority higher than IRQ processing -
> causing problems interfacing with devices. At a minimum, the default
> priority of IRQ's should be some real time value so that nice -20 jobs
> won't bother them either. A possibility that comes to mind is to
> schedule IRQ's at a range higher than available to all real time
> application tasks. I'll mention another possibility below as well.

we could increase the RT priority range perhaps, and only allow IRQ
threads to venture into that range. But, this is really pushing a piece
of policy into the kernel. RT tasks interfering with interrupt threads
is an application level problem: priorities have to be properly set up
between RT applications anyway.

> In the systems I have to deal with, I do not have a clear criteria
> to set priorities of interrupts relative to each other. For example, I
> have a real time simulation system using the following devices:
>  - occasional disk access to simulate disk I/O
>  - real time network traffic
>  - real time delivery of interrupts from a PCI timer card and APIC timers
>  - real time interrupts from a shared memory interface
> The priorities of real time tasks are basically assigned based on the
> rate of execution. 80 Hz tasks run at a higher priority than 60 Hz, 60 Hz >
> 40 Hz, and so on. A number of tasks can access each device.

if you dont know the relative priority and dont want to allow (non-RT)
userspace starving of IRQ processing then you can make all of them
SCHED_FIFO priority 99.

> As noted above, I can live with a system where I can guarantee that
> all the IRQ processing has higher priority than all the real time
> tasks.

what might make sense is to extend SELinux to allow partitioning of the
priority space. Allow 'normal' applications only SCHED_FIFO range 1-90,
and have 91-99 for IRQ threads, or something like that. I dont think
this priority scheme should be part of the kernel proper - it would be
an inflexible feature. But ... i have no strong feelings in either
direction.

> It would be "better" if the priority of the hardware interrupts
> somehow inherited the priority (absolute or relative to other IRQ's)
> of the task making the request. So in that way, a 40 Hz task making a
> network transfer would somehow boost the priority of the network
> interface until that transfer was complete. It would also be good if
> the queue of pending transfers was reordered by RT priority, but I
> don't see that as an easy thing to implement currently in Linux (but I
> can ask... :-) ).

unfortunately there's no 1:1 relationship between 'work' and
'completion' activies so no good mapping from tasks to interrupts. Think
about a SCHED_OTHER and a SCHED_FIFO task dirtying the same page and it
getting flushed out to disk by pdflush. Whose priority should the disk
interrupt inherit, if anything?

> Needless to say, if you implemented priority inheritance, when the 40
> Hz task is not doing network transfers, I would just as soon prefer
> that other network operations (say from a 2 Hz tasks) does not get a
> priority boost above a 20 Hz task accessing another device.

in reality it seems that most of the contention wrt. networks is on the
queueing level, not on the CPU use level. So the solution should rather
be on the 'jump the queue and get xmit-ed right now' level - i.e. the
use of priority-aware TCP/IP QoS features. They do not really need
priority inheritance for the hardware interrupt. (especially considering
that most network processing happens in softirq context, which is even
more anonymous than a hardirq handler.)

	Ingo
