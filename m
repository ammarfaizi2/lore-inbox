Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTHWVrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTHWVrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:47:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:26085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263887AbTHWVqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:46:55 -0400
Date: Sat, 23 Aug 2003 14:49:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: piggin@cyberone.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]O18.1int
Message-Id: <20030823144907.6bcce289.akpm@osdl.org>
In-Reply-To: <200308240258.33924.kernel@kolivas.org>
References: <200308231555.24530.kernel@kolivas.org>
	<20030823023231.6d0c8af3.akpm@osdl.org>
	<3F4738BE.6060007@cyberone.com.au>
	<200308240258.33924.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > >It might help if you or a buddy could get set up with volanomark on an
>  > > OSDL 4-or-8-way so that you can more closely track the effect of your
>  > > changes on such benchmarks.
> 
>  Ok here goes. 
>  This is on 8way:
> 
>  Test4:
>  Average throughput = 11145 messages per second
> 
>  Test4-O18.1:
>  Average throughput = 9860 messages per second
> 
>  Test3-mm3:
>  Average throughput = 9788 messages per second
> 
> 
>  So I grabbed test3-mm3 and started peeling back the patches
>  and found no change in throughput without _any_ of my Oxint patches applied, 
>  and just Ingo's A3 patch:
> 
>  Test3-mm3-A3
>  Average throughput = 9889 messages per second
> 
> 
>  Then finally I removed that patch so there were no interactivity patches:
>  Test3-mm3-ni
>  Average throughput = 11052 messages per second

Well that was quick, thanks.

Surely the only reason we see more idle time in this sort of workload is
because of runqueue imbalance: some CPUs are idle while other CPUs have
more than one runnable process.  That sounds like a bug more than a
tuning/balancing thing: having no runnable tasks is a sort of binary
do-something-right-now case.

We should be going across and pullng a task off another CPU synchronously
as soon as a runqueue is seen to be empty.  The code tries to do that so
hrm.  

Ingo just sent the below patch which is related, but doesn't look like it
will fix it.  I'll include this in test4-mm1, RSN.



From: Ingo Molnar <mingo@elte.hu>

the attached patch fixes the SMP balancing problem reported by David 
Mosberger. (the 'yield-ing threads do not get spread out properly' bug).

it turns out that we never really spread out tasks in the busy-rebalance
case - contrary to my intention. The most likely incarnation of this
balancing bug is via yield() - but in theory pipe users can be affected
too.

the patch balances more agressively with a slow frequency, on SMP (or
within the same node on NUMA - not between nodes on NUMA).



 kernel/sched.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN kernel/sched.c~sched-balance-fix-2.6.0-test3-mm3-A0 kernel/sched.c
--- 25/kernel/sched.c~sched-balance-fix-2.6.0-test3-mm3-A0	2003-08-23 13:57:06.000000000 -0700
+++ 25-akpm/kernel/sched.c	2003-08-23 13:57:06.000000000 -0700
@@ -1144,7 +1144,6 @@ static void rebalance_tick(runqueue_t *t
 			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 			spin_unlock(&this_rq->lock);
 		}
-		return;
 	}
 #ifdef CONFIG_NUMA
 	if (!(j % BUSY_NODE_REBALANCE_TICK))
@@ -1152,7 +1151,7 @@ static void rebalance_tick(runqueue_t *t
 #endif
 	if (!(j % BUSY_REBALANCE_TICK)) {
 		spin_lock(&this_rq->lock);
-		load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
+		load_balance(this_rq, 0, cpu_to_node_mask(this_cpu));
 		spin_unlock(&this_rq->lock);
 	}
 }

_

