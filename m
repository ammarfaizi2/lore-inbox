Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUKPXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUKPXlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKPXjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:39:14 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:36961 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261899AbUKPXh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:37:26 -0500
Message-ID: <419A8F32.2020401@yahoo.com.au>
Date: Wed, 17 Nov 2004 10:37:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu> <419A83FB.2080308@yahoo.com.au> <419A8E0B.4000601@bigpond.net.au>
In-Reply-To: <419A8E0B.4000601@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:
> 
>> Ingo Molnar wrote:
>>
>>> PREEMPT_RT on SMP systems triggered weird (very high) load average
>>> values rather easily, which turned out to be a mainline kernel
>>> ->nr_uninterruptible handling bug in try_to_wake_up().
>>>
>>> the following code:
>>>
>>>         if (old_state == TASK_UNINTERRUPTIBLE) {
>>>                 old_rq->nr_uninterruptible--;
>>>
>>> potentially executes with old_rq potentially being != rq, and hence
>>> updating ->nr_uninterruptible without the lock held. Given a
>>> sufficiently concurrent preemption workload the count can get out of
>>> whack and updates might get lost, permanently skewing the global 
>>> count. Nothing except the load-average uses nr_uninterruptible() so this
>>> condition can go unnoticed quite easily.
>>>
>>
>> Hi Ingo,
>> Yes you're right.
>>
>> I have another idea. Revert back to the old code, then just transfer
>> the nr_uninterruptible count when migrating a task. That way, the
> 
> 
> I presume that you mean adjust rather than transfer.
> 
>> rq's nr_uninterruptible field always is a measure of the number of
>> uninterruptible tasks on it. What do you think?
> 
> 
> To make this work you need to do the adjustment every where that a task 
> changes CPU while in the UNINTERRUPTIBLE state.  Are both run queue 
> locks always held in these circumstances?  I don't think that they are 
> in try_to_wake_up() but it may be possible to work around that.
> 

Yeah this won't actually work of course, because a task can set itself
UNINTERRUPTIBLE and subsequently get preempted then moved CPUs before
calling schedule() itself.

And yeah I missed the original point of your fix which was due to the
task moving runqueues in try_to_wake_up. Sorry, forget about the patch :P
