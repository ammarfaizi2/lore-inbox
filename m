Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUHDAid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUHDAid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHDAid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:38:33 -0400
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:49298 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S266825AbUHDAiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:38:06 -0400
Message-ID: <41102FE5.9010507@bigpond.net.au>
Date: Wed, 04 Aug 2004 10:37:57 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com>
In-Reply-To: <20040803104912.GW2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Aug 03, 2004 at 01:39:02PM +1000, Peter Williams wrote:
> 
>>OK.  Now I understand.
>>The main reason that I didn't do something like that is that 
>>(considering that real time tasks don't get promoted) it would complicate:
>>1. the selection (in schedule()) of the next task to be run as it would 
>>no longer be a case of just finding the first bit in the bitmap,
>>2. determining the appropriate list to put the task on in 
>>enqueue_task(), etc., and
>>3. determining the right bit to turn off in the bit map when dequeuing 
>>the last task in a slot.
>>As these are frequent operations compared to promotion I thought it 
>>would be better to leave the complexity in do_promotion().  Now that 
>>you've caused me to think about it again I realize that the changes in 
>>the above areas may not be as complicated as I thought would be 
>>necessary.  So I'll give it some more thought.
> 
> 
> In such schemes, realtime tasks are considered separately from
> timesharing tasks. Finding a task to run or migrate proceeds with a
> circular search of the portion of the bitmap used for timesharing tasks
> after a linear search of that for RT tasks. The list to enqueue a
> timesharing task in is just an offset from the fencepost determined by
> priority. Dequeueing is supported with a tag for actual array position.
> I did this for aperiodic queue rotations, which differs from your SPA.

While pondering this I have stumbled on a problem that rules out using a 
rotating list for implementing promotion.  The problem is that one of 
the requirements is that once a SCHED_NORMAL task is promoted to the 
MAX_RT_PRIO slot it stays there (as far as promotion is concerned). 
With the rotating list this isn't guaranteed and, in fact, any tasks 
that are in the MAX_RT_PRIO slot when promotion occurs will actually be 
demoted to IDLE_PRIO - 1.

Promotion should be a rare event as it is unnecessary if there's less 
than two tasks on the runqueue and when there are more than one task on 
the runqueue the interval between promotions increases linearly with the 
number of runnable tasks.  It is also an O(1) operation albeit with a 
constant factor determined by the number of occupied SCHED_NORMAL 
priority slots.

I will modify the code to take better advantage of the fact that 
promotion is not required when the number of runnable tasks is less than 
2 e.g. by resetting next_prom_due so that the first promotion after the 
number of runnable tasks exceeds 1 will only occur after a full 
promotion interval has expired.  At normal loads (and with sensible 
promotion interval settings i.e. greater than the time slice size) this 
should result in promotion never (or hardly ever) occurring and the 
overhead of do_promotions() will only have to be endured when it's 
absolutely necessary.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

