Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWBQCaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWBQCaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWBQCaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:30:46 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:39321 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751131AbWBQCaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:30:46 -0500
Message-ID: <43F53553.50904@bigpond.net.au>
Date: Fri, 17 Feb 2006 13:30:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, npiggin@suse.de,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com>
In-Reply-To: <20060216171357.A27025@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 17 Feb 2006 02:30:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Andrew, Please don't apply this patch. This breaks the existing HT
> (and multi-core) scheduler optimizations.
> 
> Peter, on a DP system with HT, if we have only two runnable processes
> and they end up running on the two threads of the same package, 
> with your patch, migration thread will never move one of those processes 
> to the idle package..

On a normal system, would either of them be moved anyway?

> 
> To fix my reported problem, we need to make sure that find_busiest_group()
> doesn't find an imbalance..

I disagree.  If this causes a problem with your "optimizations" then I 
think that you need to fix the "optimizations".

There's a rational argument (IMHO) that this patch should be applied 
even in the absence of the smpnice patches as it prevents 
active_load_balance() doing unnecessary work.  If this isn't good for 
hypo threading then hypo threading is a special case and needs to handle 
it as such.

> 
> thanks,
> suresh
> 
> On Thu, Feb 16, 2006 at 11:39:34AM +1100, Peter Williams wrote:
> 
>>Suresh B. Siddha has reported:
>>
>>"on a lightly loaded system, this will result in higher priority job 
>>hopping around from one processor to another processor.. This is because 
>>of the code in find_busiest_group() which assumes that SCHED_LOAD_SCALE 
>>represents a unit process load and with nice_to_bias calculations this 
>>is no longer true (in the presence of non nice-0 tasks)"
>>
>>Analysis of this problem as revealed that the smpnice code results in 
>>the weighted load being larger than 1 and this triggers the active load 
>>balancing code.  However, in active_load_balance(), the migration thread 
>>fails to take into account itself when deciding if there are any tasks 
>>to be migrated from its run queue. I.e. even if there is only one other 
>>task on the run queue other than itself it will still migrate that other 
>>task.
>>
>>The attached patch fixes that anomaly.
>>
>>Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>>
>>Peter
>>-- 
>>Peter Williams                                   pwil3058@bigpond.net.au
>>
>>"Learning, n. The kind of ignorance distinguishing the studious."
>>  -- Ambrose Bierce
> 
> 
>>Index: MM-2.6.X/kernel/sched.c
>>===================================================================
>>--- MM-2.6.X.orig/kernel/sched.c	2006-02-16 10:51:52.000000000 +1100
>>+++ MM-2.6.X/kernel/sched.c	2006-02-16 11:02:45.000000000 +1100
>>@@ -2406,7 +2406,7 @@ static void active_load_balance(runqueue
>> 	runqueue_t *target_rq;
>> 	int target_cpu = busiest_rq->push_cpu;
>> 
>>-	if (busiest_rq->nr_running <= 1)
>>+	if (busiest_rq->nr_running <= 2)
>> 		/* no task to move */
>> 		return;
>> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
