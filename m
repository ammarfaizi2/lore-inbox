Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268783AbTCCU2l>; Mon, 3 Mar 2003 15:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268784AbTCCU2k>; Mon, 3 Mar 2003 15:28:40 -0500
Received: from [207.12.156.200] ([207.12.156.200]:5162 "EHLO
	mugwump.hstn.tensor.pgs.com") by vger.kernel.org with ESMTP
	id <S268783AbTCCU2i>; Mon, 3 Mar 2003 15:28:38 -0500
Message-Id: <200303032038.h23KcjY24553@mugwump.hstn.tensor.pgs.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Stephen Hemminger <shemminger@osdl.org>
cc: David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible FIFO race in lock_sock() 
In-Reply-To: Message from Stephen Hemminger <shemminger@osdl.org> 
   of "28 Feb 2003 13:25:50 PST." <1046467548.30194.258.camel@dell_ss3.pdx.osdl.net> 
Reply-To: shocking@pgs.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Mar 2003 14:38:45 -0600
From: Steve Hocking <shocking@pgs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doing a review to understand socket locking, found a race by inspection
> but don't have a test to reproduce the problem.
> 
> It appears lock_sock() basically reinvents a semaphore in order to have
> FIFO wakeup and allow test semantics for the bottom half.  The problem
> is that when socket is locked, the wakeup is guaranteed FIFO.  It is
> possible for another requester to sneak in the window between when owner
> is cleared and the next queued requester is woken up.
> 
> Don't know what this impacts, perhaps out of order data on a pipe?
> 
> Scenario:
> 	Multiple requesters (A, B, C, D) and new requester N
> 	
> 	Assume A gets socket lock and is owner. 
> 	B, C, D are on the wait queue.
> 	A release_lock which ends up waking up B
> 	Before B runs and acquires socket lock:
> 	   N requests socket lock and sees owner is NULL so it grabs it.
> 
> The patch just checks the waitq before proceeding with the fast path.
> 
> Other alternatives:
> 1. Ignore it we aren't guaranteeing FIFO anyway.
> 	- then why bother with waitq when spin lock will do.
> 2. Replace socket_lock with a semaphore
> 	- with changes to BH to get same semantics
> 3. Implement a better FIFO spin lock

We may've seen a problem relating to this in the 2.4.xx series of kernels. It 
presents itself within various comms libs (MPI, PVM) as an invalid message and 
occasionally with data being sent to the wrong process on a node. It's very 
intermittent, and seems to occur less as the speed of the machine in question 
increases. We have some 1400 dual CPU nodes, a mixture of P3 and P4 boxes, 
with jobs spanning up to a hundred nodes, so it tends to pop out rather more 
frequently than most people would see it.


	Stephen
-- 
  The views expressed above are not those of PGS Tensor.

    "We've heard that a million monkeys at a million keyboards could produce
     the Complete Works of Shakespeare; now, thanks to the Internet, we know
     this is not true."            Robert Wilensky, University of California


