Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268241AbRGWO3C>; Mon, 23 Jul 2001 10:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268239AbRGWO2x>; Mon, 23 Jul 2001 10:28:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21564 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268241AbRGWO2n>; Mon, 23 Jul 2001 10:28:43 -0400
Date: Mon, 23 Jul 2001 16:29:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010723162909.D822@athlon.random>
In-Reply-To: <20010723013416.B23517@athlon.random> <m15Obfk-000CD5C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15Obfk-000CD5C@localhost>; from rusty@rustcorp.com.au on Mon, Jul 23, 2001 at 07:06:40PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 07:06:40PM +1000, Rusty Russell wrote:
> Aside: why does it do a local_irq_save() if it's always run from an
> interrupt handler?

to avoid corrupting the backlog with nested irqs.

However if you want a microoptimization is to sti before
__cpu_raise_softirq, __cpu_raise_softirq from 2.4.7 is required to be
atomic with respect of irqs (but it doesn't need to be atomic with
respect of SMP). in the x86 port is handled as a single not locked bts
instruction. So it can be run with irq enabled.

Here the optimization:

--- 2.4.7aa1/net/core/dev.c.~1~	Sat Jul 21 00:04:34 2001
+++ 2.4.7aa1/net/core/dev.c	Mon Jul 23 16:21:35 2001
@@ -1217,10 +1217,10 @@
 enqueue:
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue,skb);
+			local_irq_restore(flags);
 
 			/* Runs from irqs or BH's, no need to wake BH */
 			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-			local_irq_restore(flags);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
@@ -1529,10 +1529,10 @@
 
 	local_irq_disable();
 	netdev_rx_stat[this_cpu].time_squeeze++;
+	local_irq_enable();
 
 	/* This already runs in BH context, no need to wake up BH's */
 	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-	local_irq_enable();
 
 	NET_PROFILE_LEAVE(softnet_process);
 	return;

> > I cannot see any problem.
> 
> Why not fix all the cases?  Why have this wierd secret rule that
> cpu_raise_softirq() should not be called with irqs disabled?

cpu_raise_softirq _can_ be called with irq disabled too just now, irq
enabled or disabled has no influence at all on cpu_raise_softirq.

The fact you are running on a irq handler or not has influence instead,
if you are running in a irq handler do_IRQ will take care of the
latency, if you are running in normal kernel code ksoftirqd will take
care of the latency, and both cases are handled perfectly right.

> Call me old-fashioned, but why not *fix* the problem, if you're going
> to rewrite this code... again...

There's no problem at all to fix, everything is just fine from 2.4.7,
period.

Andrea
