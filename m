Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbUKWIR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUKWIR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUKWIR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:17:26 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:12525 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262329AbUKWIRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:17:14 -0500
Date: Tue, 23 Nov 2004 09:13:51 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: john cooper <john.cooper@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <41A2902A.5050308@timesys.com>
Message-Id: <Pine.OSF.4.05.10411230849010.23417-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, john cooper wrote:

> Ingo Molnar wrote:
> > [...]
> 
> Yes I see where you are walking the dependency chain
> in pi_setprio().  But this is under the global spinlock
> 'pi_lock'.
> 
> My earlier comment was of the difficulty to establish fine
> grained locking, ie: per-mutex to synchronize mutex
> ownership/waiter lists and per task to synchronize
> the list maintaining mutexes owned by task.  While this
> arguably scales better in an SMP environment, there are
> issues of mutex traversal sequence during PI which lead
> to deadlock scenarios.  Though I believe there are
> reasonable constraints placed on application mutex
> acquisition order which side step this problem.
>

In the implementation I sent out earlier (I called it -U9.2-priom) I
solved this by releasing all locks before going to the next task in the
dependency chain. This leaves me open to rescheduling in the middle and
some of the tasks could exit before I got to them. To solve this I used
task_get/put() to make sure the task struct doesn't disappeare before the
next lock is taken. All this locking/unlocking, task_get/task_put is
ofcourse an overhead, but besides avoiding one big lock it gives one more
advantage: It decreases the amount of time a spin lock is held, thus
descreasing the penalty to the overall latency.

 
> In the current design pi_lock has scope protecting all
> mutex waiter lists (rooted either in mutex or owning task),
> as well as per-mutex owner(s).  The result of this is
> pi_lock must be speculatively acquired before altering
> any of the above lists/data regardless whether a PI
> scenario is encountered.  The behavior looks correct to
> my reading.  However I'd offer there is more concurrency
> possible in this design.
> 
I think that is a good approach on UP: Disable preemption, do the sorting
etc., enable preempion. On SMP, however, a global lock is not so nice...

However, I am thinking: Fix the bugs in the current implementation, then
try to optimize it.


> -john
> 
Esben

