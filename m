Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUJNTxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUJNTxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUJNTvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:51:12 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:22276 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267397AbUJNTrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:47:24 -0400
Date: Thu, 14 Oct 2004 12:46:47 -0700
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Adam Heath <doogie@debian.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014194647.GA17579@nietzsche.lynx.com>
References: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 02:13:15PM -0500, Mark_H_Johnson@raytheon.com wrote:
...
> be some real time value so that nice -20 jobs won't bother them either.
> A possibility that comes to mind is to schedule IRQ's at a range higher
> than
> available to all real time application tasks. I'll mention another
> possibility below as well.

The interrupt priority range probably needs to be increased to accommodate the
increased design demand of RT applications.

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

Crank it higher 120hz and see what kind of jitter your getting. Hit
something with high memory load, large, mmap images, swap and friends.

> It would be "better" if the priority of the hardware interrupts somehow
> inherited the priority (absolute or relative to other IRQ's) of the task
> making the request. So in that way, a 40 Hz task making a network transfer
> would somehow boost the priority of the network interface until that
> transfer was complete. It would also be good if the queue of pending
> transfers was reordered by RT priority, but I don't see that as an easy
> thing to implement currently in Linux (but I can ask... :-) ).

That's an RT app slippery slope and it should be handled by some kind of
in-kernel or kernel locking aware facilties. The reason why Linux is
ideal for RTOS usage is directly related to all of the SMP work that's
been done over the years. Contention, therefore the need for priority
inheritance, is evil. If you need that kind of functionality, then you
might be good to consider the scheduling indeterminancy of the lock chain
being aquired and it should have little or no overlap with things like
irq-threads. The system should be decoupled (queues, etc...) if possible
and you shouldn't abuse priority inheritance. The use of priority
inheritance should be considered a kind lock contention overload and
the algorithms it bounds should be optimized. In your case, the network
stack might need to be broken up to provide  the kind of granularity
and control need to attach on a socket per process/thread basis, just
like Jeffery Hsu's lockless network stack effort in DragonFly BSD.

Long priority inheritance chains is an app-level indeterminacy nightmare
and either indicates an improperly written application or nasty SMP
contention issue. That's how I see it.

> Needless to say, if you implemented priority inheritance, when the 40 Hz
> task is not doing network transfers, I would just as soon prefer that
> other network operations (say from a 2 Hz tasks) does not get a priority
> boost above a 20 Hz task accessing another device.

bill
