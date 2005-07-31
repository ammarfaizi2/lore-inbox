Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVGaBPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVGaBPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVGaBPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:15:37 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:12895 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263014AbVGaBPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:15:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lS+fEemyR7hzBbYUY7+foKEtg5hdPo29GO06cnZEL4gEhRv/TeJvwH4UImYSDcxfdLScMt8LqckxdGxebKs+NV4O1w/Mv9cmsy7D0rUq+LKUeWGgYcgARiHsvf5vJINi3uw/gGuP31j89fiV0Gc+5IpIds46bKBx3u3nOiH43pU=  ;
Message-ID: <42EC2624.7030509@yahoo.com.au>
Date: Sun, 31 Jul 2005 11:15:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John Hawkes <hawkes@sgi.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [sched, patch] better wake-balancing, #3
References: <42E98DEA.9090606@yahoo.com.au> <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <20050729114822.GA25249@elte.hu> <20050729141311.GA4154@elte.hu> <20050729150207.GA6332@elte.hu> <20050729162108.GA10243@elte.hu> <42EAC504.3000300@yahoo.com.au> <20050730071917.GA31822@elte.hu>
In-Reply-To: <20050730071917.GA31822@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>I don't really like having a hard cutoff like that -wake balancing can 
>>be important for IO workloads, though I haven't measured for a long 
>>time. [...]
> 
> 
> well, i have measured it, and it was a win for just about everything 

I meant: measured for IO workloads.

I had one group tell me their IO efficiency went up by several
*times* on a 16-way NUMA system after generalising the wake
balancing to interrupts as well.

> that is not idle, and even for an IPC (SysV semaphores) half-idle 
> workload i've measured a 3% gain. No performance loss in tbench either, 
> which is clearly the most sensitive to affine/passive balancing. But i'd 
> like to see what Ken's (and others') numbers are.
> 
> the hard cutoff also has the benefit that it allows us to potentially 
> make wakeup migration _more_ agressive in the future. So instead of 
> having to think about weakening it due to the tradeoffs present in e.g.  
> Ken's workload, we can actually make it stronger.
> 

That would make the behaviour change even more violent, which is
what I dislike. I would much prefer to have code that handles both
workloads without introducing sudden cutoff points in behaviour.

> 
> especially on NUMA, if the migration-target CPU (this_cpu) is not at 
> least partially idle, i'd be quite uneasy to passive balance from 
> another node. I suspect this needs numbers from Martin and John?
> 

Passive balancing cuts in only when an imbalance is becoming apparent.
If the queue gets more imbalanced, periodic balancing will cut in,
and that is much worse than wake balancing.

> 
>>fork/clone/exec/etc balancing really doesn't do anything to capture 
>>this kind of relationship between tasks and between tasks and IRQ 
>>sources. Without wake balancing we basically have a completely random 
>>scattering of tasks.
> 
> 
> Ken's workload is a heavy IO one with lots of IRQ sources. And precisely 
> for such type of workloads usually the best tactic is to leave the task 
> alone and queue it wherever it last ran.
> 

Yep, I agree the wake balancing code in 2.6.12 wasn't ideal. That's
why I changed it in 2.6.13 - precisely because it moved things around
too much. It probably still isn't ideal though.

> whenever there's a strong (and exclusive) relationship between tasks and 
> individual interrupt sources, explicit binding to CPUs/groups of CPUs is 
> the best method. In any case, more measurements are needed.
> 

Well, I wouldn't say it is always the best method. Especially not when
there is a big variation in the CPU consumption of the groups of tasks.
But anyway, even in the cases where it definitely is the best method,
we really should try to handle them properly without binding too.

I do agree that more measurements are needed :)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
