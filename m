Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUK2Qur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUK2Qur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUK2Qur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:50:47 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:4290 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261761AbUK2Quj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:50:39 -0500
Date: Mon, 29 Nov 2004 17:50:33 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041129155752.GA17828@elte.hu>
Message-Id: <Pine.OSF.4.05.10411291717120.14592-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > iteration over a list which can be O(number of waiters * locking
> > > depth) long. As long as we are in the kernel both is "controlled",
> > > i.e. one can see the worst-case number in stress test and know it
> > > can't get worse. *
> > 
> > which list do you mean? Note that the pi_list depends on the number of
> > _RT-tasks_, not on the number of SCHED_NORMAL tasks. So you can create
> > an arbitrary number of SCHED_NORMAL tasks, they wont impact the
> > overhead of mutexes!
> > 
> > i very intentionally made it independent of nr-of-non-RT-tasks.
>
Sorry I overlooked that detail. Also the wait_list on each mutex is
"sorted" (the rt-threads in the beginning and normal threads at the end).
Then there should be no problems. 

However, a full sorting among the rt-tasks along with only holding the
first waiter for each mutex on the pi_waiters list would give it better
performance since the list traversals could be avoided. The worst case
still has a full list traversel at insertion of a waiter, but that would
only happen if the rt-thread sleeps on something not a mutex while holding
one - which is really bad coding style! Otherwise, only increasingly high
priority task can possible get the CPU(s) and get access to locking the
mutex. Thus all insertion will be within the first <number of CPUs>
elements on the list.
 
> and i'm regularly testing this property with 'hackbench 50', which
> creates over a 1000 wildly scheduling non-RT tasks. Latency is not
> affected by such workloads.
>
 
Probably not. Even while doing that you most likely wont build up wait
lists of more than 10, maybe 100 tasks? Doing full traversals with irq
disabled probably wont be meassureable!(?) compared to much other stuff
increasing responsible for the meassured latency.

> 	Ingo

Esben

