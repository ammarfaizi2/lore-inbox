Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUHDA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUHDA4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUHDAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:54:04 -0400
Received: from holomorphy.com ([207.189.100.168]:9144 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267170AbUHDAul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:50:41 -0400
Date: Tue, 3 Aug 2004 17:50:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040804005034.GE2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41102FE5.9010507@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> In such schemes, realtime tasks are considered separately from
>> timesharing tasks. Finding a task to run or migrate proceeds with a
>> circular search of the portion of the bitmap used for timesharing tasks
>> after a linear search of that for RT tasks. The list to enqueue a
>> timesharing task in is just an offset from the fencepost determined by
>> priority. Dequeueing is supported with a tag for actual array position.
>> I did this for aperiodic queue rotations, which differs from your SPA.

On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> While pondering this I have stumbled on a problem that rules out using a 
> rotating list for implementing promotion.  The problem is that one of 
> the requirements is that once a SCHED_NORMAL task is promoted to the 
> MAX_RT_PRIO slot it stays there (as far as promotion is concerned). 
> With the rotating list this isn't guaranteed and, in fact, any tasks 
> that are in the MAX_RT_PRIO slot when promotion occurs will actually be 
> demoted to IDLE_PRIO - 1.

Aperiodic rotations defer movement until MAX_RT_PRIO's slot is evacuated.


On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> Promotion should be a rare event as it is unnecessary if there's less 
> than two tasks on the runqueue and when there are more than one task on 
> the runqueue the interval between promotions increases linearly with the 
> number of runnable tasks.  It is also an O(1) operation albeit with a 
> constant factor determined by the number of occupied SCHED_NORMAL 
> priority slots.

The asymptotics were in terms of SCHED_NORMAL priorities.


On Wed, Aug 04, 2004 at 10:37:57AM +1000, Peter Williams wrote:
> I will modify the code to take better advantage of the fact that 
> promotion is not required when the number of runnable tasks is less than 
> 2 e.g. by resetting next_prom_due so that the first promotion after the 
> number of runnable tasks exceeds 1 will only occur after a full 
> promotion interval has expired.  At normal loads (and with sensible 
> promotion interval settings i.e. greater than the time slice size) this 
> should result in promotion never (or hardly ever) occurring and the 
> overhead of do_promotions() will only have to be endured when it's 
> absolutely necessary.

The primary concern was that ticklessness etc. may require it to occur
during context switches.


-- wli
