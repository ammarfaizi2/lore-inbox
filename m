Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758609AbWK3HhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609AbWK3HhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758626AbWK3HhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:37:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27839 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1758596AbWK3HhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:37:19 -0500
Date: Thu, 30 Nov 2006 08:35:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130073504.GA19437@elte.hu>
References: <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net> <20061130064758.GD2003@elte.hu> <20061129.231258.65649383.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129.231258.65649383.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> > furthermore, the tweak allows the shifting of processing from a 
> > prioritized process context into a highest-priority softirq context. 
> > (it's not proven that there is any significant /net win/ of 
> > performance: all that was proven is that if we shift TCP processing 
> > from process context into softirq context then TCP throughput of 
> > that otherwise penalized process context increases.)
> 
> If we preempt with any packets in the backlog, we send no ACKs and the 
> sender cannot send thus the pipe empties.  That's the problem, this 
> has nothing to do with scheduler priorities or stuff like that IMHO. 
> The argument goes that if the reschedule is delayed long enough, the 
> ACKs will exceed the round trip time and trigger retransmits which 
> will absolutely kill performance.

yes, but i disagree a bit about the characterisation of the problem. The 
question in my opinion is: how is TCP processing prioritized for this 
particular socket, which is attached to the process context which was 
preempted.

normally, normally quite a bit of TCP processing happens in a softirq 
context (in fact most of it happens there), and softirq contexts have no 
fairness whatsoever - they preempt whatever processing is going on, 
regardless of any priority preferences of the user!

what was observed here were the effects of completely throttling TCP 
processing for a given socket. I think such throttling can in fact be 
desirable: there is a /reason/ why the process context was preempted: in 
that load scenario there was 10 times more processing requested from the 
CPU than it can possibly service. It's a serious overload situation and 
it's the scheduler's task to prioritize between workloads!

normally such kind of "throttling" of the TCP stack for this particular 
socket does not happen. Note that there's no performance lost: we dont 
do TCP processing because there are /9 other tasks for this CPU to run/, 
and the scheduler has a tough choice.

Now i agree that there are more intelligent ways to throttle and less 
intelligent ways to throttle, but the notion to allow a given workload 
'steal' CPU time from other workloads by allowing it to push its 
processing into a softirq is i think unfair. (and this issue is 
partially addressed by my softirq threading patches in -rt :-)

	Ingo
