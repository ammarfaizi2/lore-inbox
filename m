Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVCAIJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVCAIJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVCAIJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:09:36 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:5731 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261293AbVCAIJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:09:25 -0500
Message-ID: <4224232F.3000600@yahoo.com.au>
Date: Tue, 01 Mar 2005 19:09:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] timestamp fixes
References: <42235517.5070504@us.ibm.com> <42235EC6.9030900@us.ibm.com>
In-Reply-To: <42235EC6.9030900@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote:
> Nick, can you describe the system you run the DB tests on?  Do you have 
> any cpu idle time stats and hopefully some context switch rate stats?

Yeah, it is dbt3-pgsql on OSDL's 8-way STP machines. I think they're
PIII Xeons with 2MB L2 cache.

I had been having some difficulty running them recently, but I might
have just worked out what the problem was, so hopefully I can benchmark
the patchset I just sent to Andrew (plus fixes from Ingo, etc).

Basically what would happen is that with seemingly small changes, the
"throughput" figure would go from about 260 tps to under 100. I don't
know exactly why this benchmark is particularly sensitive to the
problem, but it has been a good canary for too-much-idle-time
regressions in the past.

> I think I understand the concern [patch 6] of stealing a task from one 
> node to an idle cpu in another node, but I wonder if we can have some 
> sort of check for idle balance: if the domain/node to steal from has 
> some idle cpu somewhere, we do not steal, period.  To do this we have a 
> cpu_idle bitmask, we update as cpus go idle/busy, and we reference this 
> cpu_idle & sd->cpu_mask to see if there's at least one cpu that's idle.
> 

I think this could become a scalability problem... and I'd prefer to
initially try to address problems of too much idle time by tuning them
out rather than use things like wake-to-idle-cpu.

One of my main problems with wake to idle is that it is explicitly
introducing a bias so that wakers repel their wakees. With all else
being equal, we want exactly the opposite effect (hence all the affine
wakeups and wake balancing stuff).

The regular periodic balancing may be dumb, but at least it doesn't
have that kind of bias.

The other thing of course is that we want to reduce internode task
movement at almost all costs, and the periodic balancer can be very
careful about this - something more difficult for wake_idle unless
we introduce more complexity there (a very time critical path).

Anyway, I'm not saying no to anything at this stage... let's just see
how we go.

>> Ingo wrote:
>>
>> But i expect fork/clone balancing to be almost certainly a problem. (We
>> didnt get it right for all workloads in 2.6.7, and i think it cannot be
>> gotten right currently either, without userspace API help - but i'd be
>> happy to be proven wrong.)
> 
> 
> Perhaps initially one could balance on fork up to the domain level which 
> has task_hot_time=0, up to a shared cache by default.  Anything above 
> that could require a numactl like preference from userspace.
> 

That may end up being what we have to do. Probably doesn't make
much sense to do it at all if we aren't doing it for NUMA.

Nick

