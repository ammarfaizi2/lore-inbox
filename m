Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWC2COr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWC2COr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWC2COr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:14:47 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:33784 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750772AbWC2COq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:14:46 -0500
Message-ID: <4429ED92.9040602@bigpond.net.au>
Date: Wed, 29 Mar 2006 13:14:42 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au>
In-Reply-To: <4429BC61.7020201@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 29 Mar 2006 02:14:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
>> On Tue, Mar 28, 2006 at 05:00:50PM +1100, Peter Williams wrote:
[bits deleted]
>>
>> Even with no HT and MC, this patch has still has issues in the presence
>> of different priority tasks... consider a simple DP system and run two
>> instances of high priority tasks(simple infinite loop) and two normal 
>> priority
>> tasks. With "top" I observed that these normal priority tasks keep on 
>> jumping
>> from one processor to another... Ideally with smpnice, we would assume 
>> that each processor should have two tasks (one high priority and 
>> another one with normal priority) ..
> 
> Yes, but you are failing to take into account the effect of the other 
> tasks on your system (e.g. top) that run from time to time.  If their 
> burst of CPU use happens to coincide with some load balancing activity 
> they will cause an imbalance to be detected (that is different to that 
> which only considers your test tasks) and this will result in some tasks 
> being moved.  Beware the Heisenberg Uncertainty Principle :-).

Notwithstanding the HUP, I've investigated this and have found that 
there is more instability than expected and that it is due to a silly 
bit of code (by me) at the end of find_busiest_queue() marked by the 
comment:

/* or if there's a reasonable chance that *imbalance is big
  * enough to cause a move
  */

that makes load balancing more aggressive.  The functionality it 
implemented should have been abandoned when the code was updated to use 
average run queue loads instead of SCHED_LOAD_SCALE in the code that 
handled small imbalances but wasn't.  I'll send Andrew a patch that 
removes the offending code shortly.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
