Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUKPXgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUKPXgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUKPXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:34:16 -0500
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:19146 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S261902AbUKPXcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:32:31 -0500
Message-ID: <419A8E0B.4000601@bigpond.net.au>
Date: Wed, 17 Nov 2004 10:32:27 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu> <419A83FB.2080308@yahoo.com.au>
In-Reply-To: <419A83FB.2080308@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> PREEMPT_RT on SMP systems triggered weird (very high) load average
>> values rather easily, which turned out to be a mainline kernel
>> ->nr_uninterruptible handling bug in try_to_wake_up().
>>
>> the following code:
>>
>>         if (old_state == TASK_UNINTERRUPTIBLE) {
>>                 old_rq->nr_uninterruptible--;
>>
>> potentially executes with old_rq potentially being != rq, and hence
>> updating ->nr_uninterruptible without the lock held. Given a
>> sufficiently concurrent preemption workload the count can get out of
>> whack and updates might get lost, permanently skewing the global 
>> count. Nothing except the load-average uses nr_uninterruptible() so this
>> condition can go unnoticed quite easily.
>>
> 
> Hi Ingo,
> Yes you're right.
> 
> I have another idea. Revert back to the old code, then just transfer
> the nr_uninterruptible count when migrating a task. That way, the

I presume that you mean adjust rather than transfer.

> rq's nr_uninterruptible field always is a measure of the number of
> uninterruptible tasks on it. What do you think?

To make this work you need to do the adjustment every where that a task 
changes CPU while in the UNINTERRUPTIBLE state.  Are both run queue 
locks always held in these circumstances?  I don't think that they are 
in try_to_wake_up() but it may be possible to work around that.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
