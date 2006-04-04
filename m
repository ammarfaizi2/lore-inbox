Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWDDEeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWDDEeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWDDEeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:34:37 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:22338 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750851AbWDDEeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:34:37 -0400
Message-ID: <4431F75A.3070701@bigpond.net.au>
Date: Tue, 04 Apr 2006 14:34:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060403172408.A31895@unix-os.sc.intel.com> <4431CA4F.3020304@bigpond.net.au> <20060403191122.B31895@unix-os.sc.intel.com> <4431E6D7.2060604@bigpond.net.au>
In-Reply-To: <4431E6D7.2060604@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 04:34:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
>>>> c) DP system: if the cpu-0 has two high priority and cpu-1 has one 
>>>> normal
>>>> priority task, how can the current code detect this imbalance..
>>> How would it not?
>>
>> imbalance will be always < busiest_load_per_task and
>> max_load - this_load will be < 2 * busiest_load_per_task...
>> and pwr_move will be <= pwr_now...
> 
> I had thought about substituting (busiest_load_per_task + 
> this_load_per_task) for (busiest_load_per_task * 2) but couldn't 
> convince myself that it was the right thing to do.  (The final update to 
> this_load_per_task would need to be moved.)  The reason I couldn't 
> convince myself is that I thought it might be too aggressive and cause 
> excessive balancing.  Maybe something more sophisticated is needed to 
> prevent that possibility.  It should be noted that the relative sizes of 
> busiest_load_per_task and this_load_per_task my be useful in deciding 
> what to do in these cases.  I'll put some thought into that.

How does this bit of code look?

if (busiest_load_per_task > this_load_per_task) {
	if (max_load - this_load > busiest_load_per_task) {
		*imbalance = busiest_load_per_task;
		return busiest;
	}
} else if (max_load - this_load >= busiest_load_per_task*2) {
	*imbalance = busiest_load_per_task;
	return busiest;
}

My maths indicate this will work even in cases when the difference 
between the two load per task values is small.  By "work" I mean that it 
will one of the high priority tasks and it won't bounce back. Do you agree?

The actual patch would be a little neater than this, of course.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
