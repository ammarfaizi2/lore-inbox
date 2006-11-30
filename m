Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031341AbWK3UtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031341AbWK3UtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967906AbWK3UtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:49:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31905 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S967905AbWK3UtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:49:12 -0500
Date: Thu, 30 Nov 2006 21:49:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, nickpiggin@yahoo.com.au, wenji@fnal.gov,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130204908.GA19393@elte.hu>
References: <20061130103240.GA25733@elte.hu> <20061130.122258.68041055.davem@davemloft.net> <20061130203026.GD14696@elte.hu> <20061130.123853.10298783.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130.123853.10298783.davem@davemloft.net>
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

> > disk I/O is typically not CPU bound, and i believe these TCP tests 
> > /are/ CPU-bound. Otherwise there would be no expiry of the timeslice 
> > to begin with and the TCP receiver task would always be boosted to 
> > 'interactive' status by the scheduler and would happily chug along 
> > at 500 mbits ...
> 
> It's about the prioritization of the work.
> 
> If all disk I/O were shut off and frozen while we copy file data into 
> userspace, you'd see the same problem for disk I/O.

well, it's an issue of how much processing is done in non-prioritized 
contexts. TCP is a bit more sensitive to process context being throttled 
- but disk I/O is not immune either: if nothing submits new IO, or if 
the task does shorts reads+writes then any process level throttling 
immediately shows up in IO throughput.

but in the general sense it is /unfair/ that certain processing such as 
disk and network IO can get a disproportionate amount of CPU time from 
the system - just because they happen to have some of their processing 
in IRQ and softirq context (which is essentially prioritized to 
SCHED_FIFO 100). A system can easily spend 80% CPU time in softirq 
context. (and that is easily visible in something like an -rt kernel 
where various softirq contexts are separate threads and you can see 30% 
net-rx and 20% net-tx CPU utilization in 'top'). How is this kind of 
processing different from purely process-context based subsystems?

so i agree with you that by tweaking the TCP stack to be less sensitive 
to process throttling you /will/ improve the relative performance of the 
TCP receiver task - but in general system design and scheduler design 
terms it's not a win.

i'd also agree with the notion that the current 'throttling' of process 
contexts can be abrupt and uncooperative, and hence the TCP stack could 
get more out of the same amount of CPU time if it used it in a smarter 
way. As i pointed it out in the first mail i'd support the TCP stack 
getting the ability to query how much timeslices it has - or even the 
scheduler notifying the TCP stack via some downcall if 
current->timeslice reaches 1 (or something like that).

So i dont support the scheme proposed here, the blatant bending of the 
priority scale towards the TCP workload. Instead what i'd like to see is 
more TCP performance (and a nicer over-the-wire behavior - no 
retransmits for example) /with the same 10% CPU time used/. Are we in
rough agreement?

	Ingo
