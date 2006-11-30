Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758497AbWK3HNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497AbWK3HNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758510AbWK3HNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:13:00 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:13968
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758497AbWK3HM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:12:59 -0500
Date: Wed, 29 Nov 2006 23:12:58 -0800 (PST)
Message-Id: <20061129.231258.65649383.davem@davemloft.net>
To: mingo@elte.hu
Cc: wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130064758.GD2003@elte.hu>
References: <20061130061758.GA2003@elte.hu>
	<20061129.223055.05159325.davem@davemloft.net>
	<20061130064758.GD2003@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 30 Nov 2006 07:47:58 +0100

> furthermore, the tweak allows the shifting of processing from a 
> prioritized process context into a highest-priority softirq context. 
> (it's not proven that there is any significant /net win/ of performance: 
> all that was proven is that if we shift TCP processing from process 
> context into softirq context then TCP throughput of that otherwise 
> penalized process context increases.)

If we preempt with any packets in the backlog, we send no ACKs and the
sender cannot send thus the pipe empties.  That's the problem, this
has nothing to do with scheduler priorities or stuff like that IMHO.
The argument goes that if the reschedule is delayed long enough, the
ACKs will exceed the round trip time and trigger retransmits which
will absolutely kill performance.

The only reason we block input packet processing while we hold this
lock is because we don't want the receive queue changing from
underneath us while we're copying data to userspace.

Furthermore once you preempt in this particular way, no input
packet processing occurs in that socket still, exacerbating the
situation.

Anyways, even if we somehow unlocked the socket and ran the backlog at
preemption points, by hand, since we've thus deferred the whole work
of processing whatever is in the backlog until the preemption point,
we've lost our quantum already, so it's perhaps not legal to do the
deferred processing as the preemption signalling point from a fairness
perspective.

It would be different if we really did the packet processing at the
original moment (where we had to queue to the socket backlog because
it was locked, in softirq) because then we'd return from the softirq
and hit the preemption point earlier or whatever.

Therefore, perhaps the best would be to see if there is a way we can
still allow input packet processing even while running the majority of
TCP's recvmsg().  It won't be easy :)
