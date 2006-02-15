Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWBOX32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWBOX32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBOX32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:29:28 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:24310 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750747AbWBOX31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:29:27 -0500
Message-ID: <43F3B952.90606@bigpond.net.au>
Date: Thu, 16 Feb 2006 10:29:22 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <43ED3D6A.8010300@bigpond.net.au> <20060214010712.B20191@unix-os.sc.intel.com> <43F25C60.4080603@bigpond.net.au> <20060214230745.A1677@unix-os.sc.intel.com> <43F3ACDD.4060901@bigpond.net.au>
In-Reply-To: <43F3ACDD.4060901@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 15 Feb 2006 23:29:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
> 
>> On Wed, Feb 15, 2006 at 09:40:32AM +1100, Peter Williams wrote:
>>
>>> Siddha, Suresh B wrote:
>>>
>>>> On a 4P(8-way with HT), if you run a -20 task(a simple infinite loop)
>>>> it hops from one processor to another processor... you can observe it
>>>> using top.
>>>
>>>
>>> How do you get top to display which CPU tasks are running on?
>>
>>
>>
>> In the interactive mode, you can select the "last used cpu" field to 
>> display.

Thanks this works and I'm now convinced that there's hopping occurring 
but I disagree on the cause (see below).

>> or you can use /proc/pid/stat
>>
>>
>>>> find_busiest_group() thinks there is an imbalance and ultimately the
>>>> idle cpu kicks active load balance on busy cpu, resulting in the 
>>>> hopping.
>>>
>>>
>>> I'm still having trouble getting my head around this.  A task 
>>> shouldn't be moved unless there's at least one other task on its 
>>> current CPU, it 
>>
>>
>>
>> Because of the highest priority task, weighted load of that cpu
>> will be > SCHED_LOAD_SCALE. Because of this, an idle cpu in 
>> find_busiest_group() thinks that there is an imbalance.. This is due to
>> the code near the comment "however we may be ablet to increase total 
>> CPU power used by ...". That piece of code assumes that a unit load
>> is represented by SCHED_LOAD_SCALE (which is no longer true with smpnice)
>> and finally results in "pwr_move > pwr_now".. This will make the idle cpu
>> try to pull that process from busiest cpu and the process will 
>> ultimately move
>> with the help of active load balance...
> 
> 
> But as I pointed out, with the code as it is in the recent -mm kernels, 
> the amount of biased load (i.e. NICE_TO_BIAS_PRIO(0)) that 
> find_busiest_group() sets *imbalance to in these circumstances is too 
> small for a task with nice less than zero to be moved i.e. move_tasks() 
> will skip it.  Or are you just referring to the vanilla kernels?

The upshot of this is that the code near "however we may" etc. never 
gets executed.  So what must be happening is that *imbalance is greater 
than SCHED_LOAD_SCALE so it goes out unchanged (as the fact that the 
problem occurs with hard spinners lets try_to_wake_up() off the hook). 
But, as I also said in another e-mail, there must be another task with 
equal or higher priority than the task (that's doing the hopping) on its 
CPU for it to be booted off.  I would surmise that the prime candidate 
here would be the migration thread for the CPU in question as it's a 
real time task and seems to run fairly frequently.

The obvious way to handle this is too NOT move tasks from a run queue 
where the migration thread is running unless the number of running tasks 
on that CPU is greater than 2.  I'll try to come up with a patch that 
does this without causing too much complexity.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
