Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULHQIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULHQIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbULHQIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:08:14 -0500
Received: from mail3.utc.com ([192.249.46.192]:18340 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261247AbULHQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:08:10 -0500
Message-ID: <41B726D1.6030009@cybsft.com>
Date: Wed, 08 Dec 2004 10:07:45 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu>
In-Reply-To: <20041208083447.GB7720@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Could you explain what the attached trace means. It looks to me like
>>the trace starts in try_to_wake_up when we are trying to wake amlat,
>>but then before we finish we get a hit on IRQ 8 and run the IRQ
>>handler???  Or do I somehow have it backwards? :)
> 

Thank you. I really did have it backwards. The thing that confused me 
was that trace_start... gets called with the task that we are trying to 
wake up. I didn't follow the trace code far enough to realize that it 
later starts getting task info from current instead of p. :) This all 
makes more sense now.

I am still confused about one thing, unrelated to this. If RT tasks 
never expire and thus are never moved to the expired array??? Does that 
imply that we never switch the active and expired arrays? If so how do 
tasks that do expire get moved back into the active array?

> 
>>   amlat-4973  0-h.3    0?s : __trace_start_sched_wakeup (try_to_wake_up)
>>   amlat-4973  0-h.3    1?s : _raw_spin_unlock (try_to_wake_up)
>>   amlat-4973  0-h.2    1?s : preempt_schedule (try_to_wake_up)
>>   amlat-4973  0        2?s : wake_up_process <IRQ 8-677> (0 1): 
> 
> 
> this portion shows that amlat-4973 woke up IRQ_8-677. Subsequently the 
> scheduler picked it from a list of 5 tasks:
> 
> 
>>   amlat-4973  0-..2   13?s : trace_array (__schedule)
>>   amlat-4973  0       14?s : __schedule <IRQ 8-677> (0 1): 
>>   amlat-4973  0       14?s+: __schedule <amlat-4973> (1 2): 
>>   amlat-4973  0       18?s+: __schedule <<unknown-792> (39 3a): 
>>   amlat-4973  0       21?s : __schedule <<unknown-4> (69 6e): 
>>   amlat-4973  0       21?s : __schedule <<unknown-4854> (73 78): 
>>   amlat-4973  0-..2   22?s+: trace_array (__schedule)
>>   IRQ 8-677   0-..2   31?s : __switch_to (__schedule)
> 
> 
> IRQ_8's RT priority was 1, amlat's priority was 2, so IRQ-8 got
> selected. (there were also other, SCHED_NORMAL tasks with pid 792, 4 and
> 4854 in the queue but they did not get selected) [ Note that in reality
> the O(1) scheduler only considered IRQ_8 when picking the next task,
> it's the tracer that listed all runnable tasks, to make it easier to
> validate scheduler logic. This 'list all runnable tasks at schedule()
> time' tracing is only done if both tracing and rw-deadlock detection is
> enabled.]
> 
> in this trace you can see the new RT global balancing in the works as
> well:
> 
> 
>>   IRQ 8-677   0       32?s : schedule <amlat-4973> (1 0): 
>>   IRQ 8-677   0-..2   32?s : finish_task_switch (__schedule)
>>   IRQ 8-677   0-..2   33?s : smp_send_reschedule_allbutself (finish_task_switch)
>>   IRQ 8-677   0-..2   33?s : __bitmap_weight (smp_send_reschedule_allbutself)
>>   IRQ 8-677   0-..2   34?s : __send_IPI_shortcut (smp_send_reschedule_allbutself)
> 
> 
> here the scheduler noticed that a higher-prio RT task (IRQ_8) preempted
> a lower-prio but still RT task (amlat), and sent an IPI (inter-processor
> interrupt) to another CPU in the system so that amlat can run on the
> other CPU.
> 
> 	Ingo
> 

