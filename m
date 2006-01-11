Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWAKDxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWAKDxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWAKDxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:53:53 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:26347 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750907AbWAKDxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:53:53 -0500
Subject: Re: 2.6.15-rt3 + Open Posix Test Suite
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1136934210.5756.13.camel@localhost.localdomain>
References: <1136934210.5756.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 22:53:12 -0500
Message-Id: <1136951593.6197.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 15:03 -0800, Daniel Walker wrote:
> 	It's worth noting that a few tests in the current Open Posix Test Suite
> hang RT systems. 
> 
> Specifically this test (hope this url comes through),
> 
> http://cvs.sourceforge.net/viewcvs.py/*checkout*/posixtest/posixtestsuite/conformance/interfaces/sched_setparam/10-1.c?rev=1.2
> 
> sched_setparam test 10-1.c and I think 9-1.c .
> 
> The 10-1 test spawns some children at SCHED_FIFO priority 99 , then runs
> the following,
> 
> void child_process(){
> 	alarm(2);
> 
> 	while(1) {
> 		(*shmptr)++;
> 		sched_yield();
> 	}
> }
> 
> I'm sure this is what's hanging the system, the yield() is one issue.
> Another is why the alarm() is never delivered .

This runs a while loop at SCHED_FIFO prio 99?  And alarm never happens.
Doesn't the alarm get activated by the softirqd that is running at a
lower priority?  Seems that this is starving out the softirq from
getting the alarm.

I believe that Thomas once had priorities attached to the timers.  I'd
like to see that again, and may even start adding them myself, such that
when a process activates a timer, when that timer goes off, the softirq
will get the priority of the timer.  But this has some complications to
be sorted out.

-- Steve


