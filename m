Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLaBkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLaBkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLaBkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:40:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932076AbVLaBkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:40:24 -0500
Date: Fri, 30 Dec 2005 17:39:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
In-Reply-To: <1135991732.31111.57.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
References: <1135726300.22744.25.camel@mindpipe> 
 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> 
 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> 
 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> 
 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> 
 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe> 
 <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe> 
 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org> <1135991732.31111.57.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Lee Revell wrote:
> 
> No there are no large jumps, it really seems that this was the network
> code causing an RCU callback to drop ~2K routes at once.  Specifically
> RCU invokes dst_rcu_free 2085 times in a single batch
> (call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free) is only called from
> rt_free() and rt_drop()).

Ok. This is likely something that was hidden by the RCU batch size thing, 
but that in turn was effectively turned off because it caused 
out-of-memory situations where a small batch size would cause the RCU 
queues to grow without bounds (noticed when we started freeing the 
dentries from RCU)..

We fixed that for "regular" RCU callbacks by noticing when the RCU queue 
got long, and encouraging a RCU event when that happened. However, that 
doesn't happen for the "call_rcu_bh()" case, so I'm not surprised that the 
network queues can grow fairly long.

I've added Eric Dumazet, Dipankar and Paul to the Cc: list, and appended a 
totally untested (and probably horribly buggy) possible patch as a 
starting point for discussion. It just sets "need_resched()" in the hope 
that we'll go through an RCU idle point and go the RCU callbacks. Whether 
it helps your case or not, I have no clue.

		Linus
---
diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 48d3bce..b107562 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -149,11 +149,10 @@ void fastcall call_rcu_bh(struct rcu_hea
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
 	rdp->count++;
-/*
- *  Should we directly call rcu_do_batch() here ?
- *  if (unlikely(rdp->count > 10000))
- *      rcu_do_batch(rdp);
- */
+
+	if (unlikely(++rdp->count > 100))
+		set_need_resched();
+
 	local_irq_restore(flags);
 }
 
