Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWAKEdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWAKEdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAKEdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:33:47 -0500
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:14161 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932423AbWAKEdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:33:46 -0500
Message-ID: <43C48AA7.6070603@bigpond.net.au>
Date: Wed, 11 Jan 2006 15:33:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601111407.05738.kernel@kolivas.org> <43C47E32.4020001@bigpond.net.au> <200601111449.29269.kernel@kolivas.org>
In-Reply-To: <200601111449.29269.kernel@kolivas.org>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 11 Jan 2006 04:33:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 11 Jan 2006 02:40 pm, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>I disagree. I think the current implementation changes the balancing
>>>according to nice much more effectively than previously where by their
>>>very nature, low priority tasks were balanced more frequently and ended
>>>up getting their own cpu.
>>
>>I can't follow the logic here 
> 
> 
> cpu bound non interactive tasks have long timeslices. Tasks that have short 
> timeslices like interactive ones or cpu bound ones at nice 19 have short 
> timeslices.

Time slice size is dependent on nice (via static_prio) only, gets bigger 
as static_prio gets smaller and only really effects the switching of 
tasks from the active array to the expired array.  This means that 
programs with high nice values will tend to spend more time on the 
expired array than the active array.  Since the expired queue is always 
examined first this makes them the most likely to be moved regardless of 
the smp nice patch.  This is independent of the amount of CPU a task 
uses each time it gets onto the CPU which is what I think you were 
alluding to.

> If a nice 0 and nice 19 task are running on the same cpu, the 
> nice 19 one is going to be spending most of its time waiting in the runqueue. 
> As soon as an idle cpu appears it will only pull a task that is waiting in a 
> runqueue... and that is going to be the low priority tasks. 

Because they're more likely to be on the expired array.

So the patch works by reducing the chance of any tasks being moved 
during an idle rebalance.  Surely this is likely to increase the amount 
of idle time.

Maybe the idle balance should check the active arrays before it checks 
the expired arrays?  This will increase the chances of getting a high 
priority task.  The down side is that tasks on the active array are more 
likely to be "cache warm" which is why the expired array is checked 
first (hence the suggestion that this only apply to idle balancing).

But, as you say, let's wait and see what happens with the patch backed 
out before we get too carried away.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
