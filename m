Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWALAyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWALAyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWALAyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:54:33 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:5870 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964875AbWALAyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:54:32 -0500
Message-ID: <43C5A8C6.1040305@bigpond.net.au>
Date: Thu, 12 Jan 2006 11:54:30 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au>
In-Reply-To: <43C58117.9080706@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------080407000507030902060904"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 12 Jan 2006 00:54:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080407000507030902060904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> On Wednesday 11 January 2006 23:24, Peter Williams wrote:
>>
>>> Martin J. Bligh wrote:
>>>
>>>> That seems broken to me ?
>>>
>>>
>>> But, yes, given that the problem goes away when the patch is removed
>>> (which we're still waiting to see) it's broken.  I think the problem is
>>> probably due to the changed metric (i.e. biased load instead of simple
>>> load) causing idle_balance() to fail more often (i.e. it decides to not
>>> bother moving any tasks more often than it otherwise would) which would
>>> explain the increased idle time being seen.  This means that the fix
>>> would be to review the criteria for deciding whether to move tasks in
>>> idle_balance().
>>
>>
>>
>> Look back on my implementation. The problem as I saw it was that one 
>> task alone with a biased load would suddenly make a runqueue look much 
>> busier than it was supposed to so I special cased the runqueue that 
>> had precisely one task.
> 
> 
> OK.  I'll look at that.

Addressed in a separate e-mail.

> 
> But I was thinking more about the code that (in the original) handled 
> the case where the number of tasks to be moved was less than 1 but more 
> than 0 (i.e. the cases where "imbalance" would have been reduced to zero 
> when divided by SCHED_LOAD_SCALE).  I think that I got that part wrong 
> and you can end up with a bias load to be moved which is less than any 
> of the bias_prio values for any queued tasks (in circumstances where the 
> original code would have rounded up to 1 and caused a move).  I think 
> that the way to handle this problem is to replace 1 with "average bias 
> prio" within that logic.  This would guarantee at least one task with a 
> bias_prio small enough to be moved.
> 
> I think that this analysis is a strong argument for my original patch 
> being the cause of the problem so I'll go ahead and generate a fix. I'll 
> try to have a patch available later this morning.

Attached is a patch that addresses this problem.  Unlike the description 
above it does not use "average bias prio" as that solution would be very 
complicated.  Instead it makes the assumption that NICE_TO_BIAS_PRIO(0) 
is a "good enough" for this purpose as this is highly likely to be the 
median bias prio and the median is probably better for this purpose than 
the average.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------080407000507030902060904
Content-Type: text/plain;
 name="fix-excessive-idling-with-smp-move-load-not-tasks"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-excessive-idling-with-smp-move-load-not-tasks"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-01-12 09:23:38.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-01-12 10:44:50.000000000 +1100
@@ -2116,11 +2116,11 @@ find_busiest_group(struct sched_domain *
 				(avg_load - this_load) * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
-	if (*imbalance < SCHED_LOAD_SCALE) {
+	if (*imbalance < NICE_TO_BIAS_PRIO(0) * SCHED_LOAD_SCALE) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
 
-		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
+		if (max_load - this_load >= NICE_TO_BIAS_PRIO(0) * SCHED_LOAD_SCALE*2) {
 			*imbalance = NICE_TO_BIAS_PRIO(0);
 			return busiest;
 		}

--------------080407000507030902060904--
