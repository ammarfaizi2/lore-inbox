Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVDGNI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVDGNI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVDGNI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:08:28 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:51089 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262453AbVDGNIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:08:05 -0400
Message-ID: <425530AB.90605@yahoo.com.au>
Date: Thu, 07 Apr 2005 23:07:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: george@mvista.com, mingo@elte.hu,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
References: <20050407124629.GA17268@in.ibm.com>
In-Reply-To: <20050407124629.GA17268@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

> I think a potential area which VST may need to address is 
> scheduler load balance. If idle CPUs stop taking local timer ticks for 
> some time, then during that period it could cause the various runqueues to 
> go out of balance, since the idle CPUs will no longer pull tasks from 
> non-idle CPUs. 
> 

Yep.

> Do we care about this imbalance? Especially considering that most 
> implementations will let the idle CPUs sleep only for some max duration
> (~900 ms in case of x86).
> 

I think we do care, yes. It could be pretty harmful to sleep for
even a few 10s of ms on a regular basis for some workloads. Although
I guess many of those will be covered by try_to_wake_up events...

Not sure in practice, I would imagine it will hurt some multiprocessor
workloads.

> If we do care about this imbalance, then we could hope that the balance logic
> present in try_to_wake_up and sched_exec may avoid this imbalance, but can we 
> bank upon these events to restore the runqueue balance?
> 
> If we cannot, then I had something in mind on these lines:
> 
> 1. A non-idle CPU (having nr_running > 1) can wakeup a idle sleeping CPU if it 
>    finds that the sleeping CPU has not balanced itself for it's 
>    "balance_interval" period.
> 
> 2. It would be nice to minimize the "cross-domain" wakeups. For ex: we may want 
>    to avoid a non-idle CPU in node B sending a wakeup to a idle sleeping CPU in 
>    another node A, when this wakeup could have been sent from another non-idle
>    CPU in node A itself. 
>  

3. This is exactly one of the situations that the balancing backoff code
    was designed for. Can you just schedule interrupts to fire when the
    next balance interval has passed? This may require some adjustments to
    the backoff code in order to get good powersaving, but it would be the
    cleanest approach from the scheduler's point of view.

Nick

-- 
SUSE Labs, Novell Inc.

