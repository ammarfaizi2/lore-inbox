Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHNQwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHNQwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUHNQwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:52:24 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:8453 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S264113AbUHNQwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:52:21 -0400
Message-ID: <411E4343.1050302@superbug.demon.co.uk>
Date: Sat, 14 Aug 2004 17:52:19 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk> <20040814115139.GB9705@elte.hu> <411E0361.9020407@superbug.demon.co.uk> <20040814123240.GA11034@elte.hu>
In-Reply-To: <20040814123240.GA11034@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
> 
>>This is just for info, now that we have a nice latency testing tool,
>>we might as well collect some useful traces that we can later work on.
>>
>>Here is a trace showing a latency of 39034us. 
>>http://www.superbug.demon.co.uk/kernel/
> 
> 
>>This looks to me to be a bug somewhere. Either in the O7 patch, or in
>>the kernel. Surely, do_IRQ should happen quickly, and not take 39ms.
> 
> 
> something's wrong indeed. Is this an x86 SMP system? If it's SMP then
> please apply the patch below (ontop of -O7), it fixes an SMP false
> positive bug in the latency timing code.
> 
> the process is looping somewhere. Here are the non-IRQ trace entries:
> 
>  0.001ms (+0.000ms): __switch_to (schedule)
>  0.002ms (+0.000ms): finish_task_switch (schedule)
>  0.002ms (+0.000ms): __preempt_spin_lock (schedule)
> ... [lots of IRQs] ...
>  38.126ms (+0.362ms): preempt_schedule (schedule)
>  38.126ms (+0.000ms): sched_clock (schedule)
>  38.127ms (+0.000ms): find_next_bit (schedule)
>  38.127ms (+0.000ms): task_timeslice (schedule)
> 
> this shows that we are looping in __preempt_spin_lock() - most likely
> via schedule()'s reqacquire_kernel_lock() code.
> 
> i.e. another CPU is holding the big kernel lock and this CPU is looping. 
> _but_ this CPU is fully preemptible so the trace produces this false
> positive.
> 
> 	Ingo
> 

I have not seen that particular problem any more, so I think the patch 
helped.

I have found a new problem though:

# cat latency_trace
preemption latency trace v1.0
-----------------------------
  latency: 1883455195 us, entries: 1 (1)
  process: ksoftirqd/1/5, uid: 0
  nice: -10, policy: 0, rt_priority: 0
=======>
  0.000ms (+0.000ms): cond_resched_softirq (___do_softirq)


That looks bad to me. The user did not notice any latency, but 1883 
seconds seems like a high latency to me!

James
