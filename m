Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUHDBhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUHDBhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUHDBhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:37:10 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:37547 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S267176AbUHDBhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:37:03 -0400
Message-ID: <41103DBB.6090100@bigpond.net.au>
Date: Wed, 04 Aug 2004 11:36:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com>
In-Reply-To: <20040804005034.GE2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>In such schemes, realtime tasks are considered separately from
>>>timesharing tasks. Finding a task to run or migrate proceeds with a
>>>circular search of the portion of the bitmap used for timesharing tasks
>>>after a linear search of that for RT tasks. The list to enqueue a
>>>timesharing task in is just an offset from the fencepost determined by
>>>priority. Dequeueing is supported with a tag for actual array position.
>>>I did this for aperiodic queue rotations, which differs from your SPA.
> 
> 
> On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> 
>>While pondering this I have stumbled on a problem that rules out using a 
>>rotating list for implementing promotion.  The problem is that one of 
>>the requirements is that once a SCHED_NORMAL task is promoted to the 
>>MAX_RT_PRIO slot it stays there (as far as promotion is concerned). 
>>With the rotating list this isn't guaranteed and, in fact, any tasks 
>>that are in the MAX_RT_PRIO slot when promotion occurs will actually be 
>>demoted to IDLE_PRIO - 1.
> 
> 
> Aperiodic rotations defer movement until MAX_RT_PRIO's slot is evacuated.

Unfortunately, to ensure no starvation, promotion has to continue even 
when there are tasks in MAX_RT_PRIO's slot.

> 
> 
> On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> 
>>Promotion should be a rare event as it is unnecessary if there's less 
>>than two tasks on the runqueue and when there are more than one task on 
>>the runqueue the interval between promotions increases linearly with the 
>>number of runnable tasks.  It is also an O(1) operation albeit with a 
>>constant factor determined by the number of occupied SCHED_NORMAL 
>>priority slots.
> 
> 
> The asymptotics were in terms of SCHED_NORMAL priorities.
> 
> 
> On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> 
>>I will modify the code to take better advantage of the fact that 
>>promotion is not required when the number of runnable tasks is less than 
>>2 e.g. by resetting next_prom_due so that the first promotion after the 
>>number of runnable tasks exceeds 1 will only occur after a full 
>>promotion interval has expired.  At normal loads (and with sensible 
>>promotion interval settings i.e. greater than the time slice size) this 
>>should result in promotion never (or hardly ever) occurring and the 
>>overhead of do_promotions() will only have to be endured when it's 
>>absolutely necessary.
> 
> 
> The primary concern was that ticklessness etc. may require it to occur
> during context switches.

On a tickless system, I'd consider using a timer to control when 
do_promotions() gets called.  I imagine something similar will be 
necessary to manage time slices?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

