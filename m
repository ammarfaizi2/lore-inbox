Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVHOXnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVHOXnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHOXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:43:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16883 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965034AbVHOXnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:43:31 -0400
Message-ID: <430127CC.5080102@mvista.com>
Date: Mon, 15 Aug 2005 16:39:56 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Ryan Brown <some.nzguy@gmail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
 Resolution Timers & RCU-tasklist features
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <1123893158.12680.70.camel@mindpipe> <42FD4593.9030702@mvista.com> <20050814021258.GA25877@elte.hu> <20050815062934.GA5915@elte.hu>
In-Reply-To: <20050815062934.GA5915@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* George Anzinger <george@mvista.com> wrote:
>>
>>
>>>Ingo, all
>>>
>>>I, silly person that I am, configured an RT, SMP, PREEMPT_DEBUG system. 
>>> Someone put code in the NMI path to modify the preempt count which, 
>>>often as not will generate a PREEMPT_DEBUG message as there is no tell 
>>>what state the preempt count is in on an NMI interrupt.  I have sent 
>>>the attached patch to Andrew on this, but meanwhile, if you want RT, 
>>>SMP, PREEMPT_DEBUG you will be much better off with this.
>>
>>ah - thanks, applied. Might explain some of the recent SMP weirdnesses 
>>i'm seeing. Attributed them to the HRT patch ;-)
> 
> 
> i'm still seeing weird crashes under SMP, which go away if i disable 
> CONFIG_HIGH_RES_TIMERS. (this after i fixed a couple of other SMP bugs 
> in the HRT code) It happens sometime during the bootup, after enabling 
> the network but before users can log in. There's no good debug info, 
> just a hang that comes from all CPUs trying to get some debug info out 
> but crashing deeply.
> 
I haven't looked at this new code all that closely as yet.  One thing I 
did notice is that there is an assumption that the "timer being 
delivered flag" can be shared between LR timers and HR timers.  I 
suspect this is wrong as the delivery code is in seperate threads (I 
assume).  This could lead to del_timer_async missing a timer.

In the prior patch we just ignored the del_timer_async issue for HR 
timers (code I plan to do soon).  This WAS taken care of in earlier 
kernels by a reuse of one of the list link fields, but Andrew convince 
me that this was _not_ good.

So, my guess, a nanosleep for an RT task (I think you said these are 
promoted to HR) is completing and over writing the deliver in progress 
flag for a LR timer which just happens to have a del_timer_sync going on 
at the same time.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
