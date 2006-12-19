Return-Path: <linux-kernel-owner+w=401wt.eu-S932872AbWLSSVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbWLSSVN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWLSSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:21:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52479 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbWLSSVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:21:12 -0500
Date: Tue, 19 Dec 2006 10:37:56 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, wenji@fnal.gov, netdev@vger.kernel.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
Message-ID: <20061219103756.38f7426c@freekitty>
In-Reply-To: <20061130063252.GC2003@elte.hu>
References: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
	<20061129154200.c4db558c.akpm@osdl.org>
	<20061130063252.GC2003@elte.hu>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this bit of discussion in tcp_recvmsg. It implies that a better
queuing policy would be good. But it is confusing English (Alexey?) so
not sure where to start.


> 		if (!sysctl_tcp_low_latency && tp->ucopy.task == user_recv) {
> 			/* Install new reader */
> 			if (!user_recv && !(flags & (MSG_TRUNC | MSG_PEEK))) {
> 				user_recv = current;
> 				tp->ucopy.task = user_recv;
> 				tp->ucopy.iov = msg->msg_iov;
> 			}
> 
> 			tp->ucopy.len = len;
> 
> 			BUG_TRAP(tp->copied_seq == tp->rcv_nxt ||
> 				 (flags & (MSG_PEEK | MSG_TRUNC)));
> 
> 			/* Ugly... If prequeue is not empty, we have to
> 			 * process it before releasing socket, otherwise
> 			 * order will be broken at second iteration.
> 			 * More elegant solution is required!!!
> 			 *
> 			 * Look: we have the following (pseudo)queues:
> 			 *
> 			 * 1. packets in flight
> 			 * 2. backlog
> 			 * 3. prequeue
> 			 * 4. receive_queue
> 			 *
> 			 * Each queue can be processed only if the next ones
> 			 * are empty. At this point we have empty receive_queue.
> 			 * But prequeue _can_ be not empty after 2nd iteration,
> 			 * when we jumped to start of loop because backlog
> 			 * processing added something to receive_queue.
> 			 * We cannot release_sock(), because backlog contains
> 			 * packets arrived _after_ prequeued ones.
> 			 *
> 			 * Shortly, algorithm is clear --- to process all
> 			 * the queues in order. We could make it more directly,
> 			 * requeueing packets from backlog to prequeue, if
> 			 * is not empty. It is more elegant, but eats cycles,
> 			 * unfortunately.
> 			 */
> 			if (!skb_queue_empty(&tp->ucopy.prequeue))
> 				goto do_prequeue;
> 
> 			/* __ Set realtime policy in scheduler __ */
> 		}
> 
> 		if (copied >= target) {
> 			/* Do not sleep, just process backlog. */
> 			release_sock(sk);
> 			lock_sock(sk);
> 		} else
> 		

-- 
Stephen Hemminger <shemminger@osdl.org>
