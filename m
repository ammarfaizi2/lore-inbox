Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSFSMG6>; Wed, 19 Jun 2002 08:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSFSMG5>; Wed, 19 Jun 2002 08:06:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41141 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317862AbSFSMGx>;
	Wed, 19 Jun 2002 08:06:53 -0400
Date: Wed, 19 Jun 2002 14:04:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
In-Reply-To: <Pine.LNX.3.96.1020619065011.1119B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0206191356350.11797-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Bill Davidsen wrote:

> Consider the case where a threaded application and a CPU hog are
> running. In sum the threaded process is also a hog, although any one
> thread is not.

it is a mistake to assume that sched_yield() == 'threaded applications'.

sched_yield() is a horrible interface to base userspace spinlocks on, it's
not in any way cheaper than real blocking, even in the best-case situation
when there is no 'useless' yielding back and forth. In the worst-case
situation it can be a few orders more expensive (!) than blocking-based
solutions. LinuxThread's use of sched_yield() was and remains a hack. I'm 
actually surprised that it works for real applications.

We are trying to improve things as much as possible on the kernel
scheduler side, but since there is absolutely no object/contention
information available for kernel space (why it wants to schedule away,
which other processes are using the blocked object, etc.), it's impossible
to do a perfect job - in fact it's not even possible to do a 'good' job.

IMO people interested in high-performance threading should concentrate on
the lightweight, kernel-backed userspace semaphores patch(es) that have
been presented a few weeks ago, and merge those concepts into LinuxThreads
(or into their own threading/spinlock solutions). Those patches do it
properly, and the scheduler will be able to give all the help it can.

	Ingo

