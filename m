Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWDYCaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWDYCaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWDYCaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:30:04 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:28599 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751534AbWDYCaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:30:03 -0400
Message-ID: <444D89A8.7070109@bigpond.net.au>
Date: Tue, 25 Apr 2006 12:30:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task
 move_tasks()
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com> <44498771.1030409@bigpond.net.au> <20060424120014.A16716@unix-os.sc.intel.com> <444D5989.3060002@bigpond.net.au> <20060424164800.B16716@unix-os.sc.intel.com>
In-Reply-To: <20060424164800.B16716@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Apr 2006 02:30:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Apr 25, 2006 at 09:04:41AM +1000, Peter Williams wrote:
>> Looks like there's a NOT missing doesn't it.  So there is an error but I 
>> don't think that your patch is the right way to fix it.  We just need to 
>> negate the above assignment.  E.g.
>>
>> skip_for_load = !(busiest_best_prio_seen || idx != busiest_best_prio);
>>
>> or
>>
>> skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
>>
>> whichever is more efficient.
> 
> That just will not be enough. busiest_best_prio needs to be set to '1'
> whenever we skip the first best priority task(not whenever we move it)

Yes, I just realized that.  It needs to be done after skip_for_load has 
been finalized.

> 
> And we also need to initialize busiest_best_prio_seen inside this check.
> (like in my patch)
> 	if (busiest->expired->nr_active) {

Why?  It's already initialized.  If the current running task has 
prio==busiest_best_prio then we know that can_migrate_task() will 
prevent it from being moved so it's safe to move any other tasks we meet 
with that priority.

> 
> And we need to reset busiest_best_prio_seen to '0' whenever we finished
> the checking of expired list (and move onto active list) and there are
> no best prio tasks on expired list..

No we don't.  Once we've skipped one it's OK to move any others that we 
find.  We'll never move more than one as a result of overriding the skip 
anyhow .

> 
>>> @@ -2072,6 +2067,13 @@ static int move_tasks(runqueue_t *this_r
>>>  	if (busiest->expired->nr_active) {
>>>  		array = busiest->expired;
>>>  		dst_array = this_rq->expired;
>>> +		/*
>>> +		 * We already have one or more busiest best prio tasks on
>>> +		 * active list.
>> This is a pretty bold assertion.  How do we know that this is true.
> 
> That comment refers to when 'busiest_best_prio_seen' is initialized to '1'.
> Comment needs to be fixed.

But you initialized it to zero.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
