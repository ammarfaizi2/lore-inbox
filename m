Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWDUI4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDUI4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDUI4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:56:52 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18598 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932280AbWDUI4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:56:51 -0400
Message-ID: <44489E27.2090108@jp.fujitsu.com>
Date: Fri, 21 Apr 2006 17:56:07 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [RFC][PATCH 3/9] CPU controller - Adds timeslice scaling
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>	 <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <1145607449.10016.47.camel@homer>
In-Reply-To: <1145607449.10016.47.camel@homer>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
>> Index: linux-2.6.17-rc2/kernel/sched.c
>> ===================================================================
>> --- linux-2.6.17-rc2.orig/kernel/sched.c
>> +++ linux-2.6.17-rc2/kernel/sched.c
>> @@ -173,10 +173,17 @@
>>  
>>  static unsigned int task_timeslice(task_t *p)
>>  {
>> +	unsigned int timeslice;
>> +
>>  	if (p->static_prio < NICE_TO_PRIO(0))
>> -		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
>> +		timeslice = SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
>>  	else
>> -		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
>> +		timeslice = SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
>> +
>> +	if (!TASK_INTERACTIVE(p))
>> +		timeslice = cpu_rc_scale_timeslice(p, timeslice);
>> +
>> +	return timeslice;
>>  }
> 
> Why does timeslice scaling become undesirable if TASK_INTERACTIVE(p)?
> With this barrier, you will completely disable scaling for many loads.

Because interactive tasks tend to spend very small timeslice at one
time, scaling timeslice for these tasks is not effective to control
CPU spent.

Or, do you say that lots of non-interactive tasks are misjudged as
TASK_INTERACTIVE(p)?

> Is it possible you meant !rt_task(p)?
> 
> (The only place I can see scaling as having a large effect is on gobs of
> non-sleeping tasks.  Slice width doesn't mean much otherwise.)

Yes. But these non-sleeping CPU-hog tasks tend to dominant CPU, so
it is worth controlling them.

Thanks,
MAEDA Naoaki

