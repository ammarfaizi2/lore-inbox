Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935001AbWK3Kcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935001AbWK3Kcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935007AbWK3Kcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:32:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59098 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935001AbWK3Kcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:32:45 -0500
Date: Thu, 30 Nov 2006 11:32:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Miller <davem@davemloft.net>,
       wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130103240.GA25733@elte.hu>
References: <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net> <20061130064758.GD2003@elte.hu> <20061129.231258.65649383.davem@davemloft.net> <20061130073504.GA19437@elte.hu> <20061130095232.GA8990@2ka.mipt.ru> <456EAD6E.6040709@yahoo.com.au> <20061130102205.GA20654@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130102205.GA20654@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> > David's line of thinking for a solution sounds better to me. This 
> > patch does not prevent the process from being preempted (for 
> > potentially a long time), by any means.
> 
> It steals timeslices from other processes to complete tcp_recvmsg() 
> task, and only when it does it for too long, it will be preempted. 
> Processing backlog queue on behalf of need_resched() will break 
> fairness too - processing itself can take a lot of time, so process 
> can be scheduled away in that part too.

correct - it's just the wrong thing to do. The '10% performance win' 
that was measured was against _9 other tasks who contended for the same 
CPU resource_. I.e. it's /not/ an absolute 'performance win' AFAICS, 
it's a simple shift in CPU cycles away from the other 9 tasks and 
towards the task that does TCP receive.

Note that even without the change the TCP receiving task is already 
getting a disproportionate share of cycles due to softirq processing! 
Under a load of 10.0 it went from 500 mbits to 74 mbits, while the 
'fair' share would be 50 mbits. So the TCP receiver /already/ has an 
unfair advantage. The patch only deepends that unfairness.

The solution is really simple and needs no kernel change at all: if you 
want the TCP receiver to get a larger share of timeslices then either 
renice it to -20 or renice the other tasks to +19.

The other disadvantage, even ignoring that it's the wrong thing to do, 
is the crudeness of preempt_disable() that i mentioned in the other 
post:

---------->

independently of the issue at hand, in general the explicit use of 
preempt_disable() in non-infrastructure code is quite a heavy tool. Its 
effects are heavy and global: it disables /all/ preemption (even on 
PREEMPT_RT). Furthermore, when preempt_disable() is used for per-CPU 
data structures then [unlike for example to a spin-lock] the connection 
between the 'data' and the 'lock' is not explicit - causing all kinds of 
grief when trying to convert such code to a different preemption model. 
(such as PREEMPT_RT :-)

So my plan is to remove all "open-coded" use of preempt_disable() [and 
raw use of local_irq_save/restore] from the kernel and replace it with 
some facility that connects data and lock. (Note that this will not 
result in any actual changes on the instruction level because internally 
every such facility still maps to preempt_disable() on non-PREEMPT_RT 
kernels, so on non-PREEMPT_RT kernels such code will still be the same 
as before.)

	Ingo
