Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRGZUHr>; Thu, 26 Jul 2001 16:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268677AbRGZUH2>; Thu, 26 Jul 2001 16:07:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268675AbRGZUHX>; Thu, 26 Jul 2001 16:07:23 -0400
Date: Thu, 26 Jul 2001 20:29:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010726202939.D22784@athlon.random>
In-Reply-To: <20010726002357.D32148@athlon.random> <200107261746.VAA31697@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107261746.VAA31697@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Jul 26, 2001 at 09:46:52PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 09:46:52PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > At that time I checked loopback that runs under the bh so it's ok too.
> 
> Well, it was not alone. I just looked at couple of places, when
> netif_rx was used. One is right, another (looping multicasts) is wrong. :-)
> 
> So, is plain raising softirq and leaving it raised before return
> to normal context not a bug? If so, then no problems.
> The worst, which can happen is that it will work as earlier, right?

Depends what you mean with 'normal context'. If you mean 'userspace
context' then it is a bug, and in 2.4.5 we would been catching that case
in entry.S.

If there are lots of users of netif_rx outside bh or irq context I guess
this is the simpler way is:

--- 2.4.7/net/core/dev.c	Sat Jul 21 00:04:34 2001
+++ 2.4.7aa1/net/core/dev.c	Thu Jul 26 20:05:26 2001
@@ -1217,10 +1217,10 @@
 enqueue:
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue,skb);
+			local_irq_restore(flags);
 
 			/* Runs from irqs or BH's, no need to wake BH */
-			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-			local_irq_restore(flags);
+			cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
@@ -1529,10 +1529,10 @@
 
 	local_irq_disable();
 	netdev_rx_stat[this_cpu].time_squeeze++;
+	local_irq_enable();
 
 	/* This already runs in BH context, no need to wake up BH's */
-	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-	local_irq_enable();
+	cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
 
 	NET_PROFILE_LEAVE(softnet_process);
 	return;

> And we are allowed to yuild bhs at any point, when we desire. Nice.
> 
> Actually, also I was afraid opposite thing: netif_rx was used to allow
> to restart processing of skb, when we were in wrong context or were afraid
> recursion. And the situation, when it is called with disabled irqs and/or
> raised spinlock_irq (it was valid very recently!), is undetectable.

It should be detectable with this debugging code (untested but trivially
fixable if it doesn't compile):

--- 2.4.7aa1/include/asm-i386/softirq.h.~1~	Wed Jul 25 22:38:08 2001
+++ 2.4.7aa1/include/asm-i386/softirq.h	Thu Jul 26 20:22:28 2001
@@ -25,7 +25,11 @@
 #define local_bh_enable()						\
 do {									\
 	unsigned int *ptr = &local_bh_count(smp_processor_id());	\
+	unsigned long flags;						\
 									\
+	__save_flags(flags);						\
+	if (!(flags & (1 << 9)))					\
+		BUG();							\
 	barrier();							\
 	if (!--*ptr)							\
 		__asm__ __volatile__ (					\

> Actually, I hope such places are absent, networking core does not use
> irq protection at all, except for netif_rx() yet. :-)

I hope too :).

> > after netif_rx.
> 
> But why not to do just local_bh_disable(); netif_rx(); local_bh_enable()?
> Is this not right?

That is certainly right. However it is slower than just doing if
(pending) do_softirq()  after netif_rx().

Andrea
