Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280351AbRJaRvc>; Wed, 31 Oct 2001 12:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280363AbRJaRvW>; Wed, 31 Oct 2001 12:51:22 -0500
Received: from [208.129.208.52] ([208.129.208.52]:39940 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S280351AbRJaRvO>;
	Wed, 31 Oct 2001 12:51:14 -0500
Date: Wed, 31 Oct 2001 09:59:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler
 ...
In-Reply-To: <20011031090703.A1105@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0110310949270.1484-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Mike Kravetz wrote:

> On Tue, Oct 30, 2001 at 09:29:41PM -0800, Mike Kravetz wrote:
> >
> > I'll kick off the all important 'kernel build benchmark' and have
> > some results tomorrow.
>
> --------------------------------------------------------------------
> mkbench - Time how long it takes to compile the kernel.  On this
> 	8 CPU system we use 'make -j 8' and increase the number
> 	of makes run in parallel.  Result is average build time in
> 	seconds.
> --------------------------------------------------------------------
> # parallel makes       Vanilla Sched   MQ Sched         Xsched
> --------------------------------------------------------------------
> 1			 56		 55		 61
> 2			105		105		105
> 3			156		156		154
> 4			206		206		205
> 5			257		257		256
> 6			308		308		307

Thanks Mike,

I'm pretty happy with this coz it shows that the current process migration
scheme does not suck so much, only a bit.
Kernel builds are not a stress test for the scheduler, when I run a -j 2
on my 2SMP I got a vmstat cs~= 500
I'm currently working on different schemes of process balancing among CPUs
with a concept of tunable hysteresis to try to give the ability for users
to setup the scheduler behavior for their needs.
What is happening with the volanomark with the proposed scheduler is that
one task start creating the requested number of threads and the new
created thread is very likely going to sleep after its creation.
So suppose that the main test task run on CPU0 ( rqlen[0] == 1 ),
get_best_cpu() is going to return 1 coz it's probably the first free.
But the new task is going to sleep/"wait for some event" before the test
task on CPU0 will call fork()/clone() again.
This will create a heavy process distribution over CPU1 that, when the
real test begin, will not find any idle reschedule to have the opportunity
to balance.




- Davide


