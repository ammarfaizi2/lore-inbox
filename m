Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268099AbRGVXeb>; Sun, 22 Jul 2001 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbRGVXeU>; Sun, 22 Jul 2001 19:34:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31556 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268099AbRGVXeJ>; Sun, 22 Jul 2001 19:34:09 -0400
Date: Mon, 23 Jul 2001 01:34:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010723013416.B23517@athlon.random>
In-Reply-To: <m15OQ5D-000CDBC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15OQ5D-000CDBC@localhost>; from rusty@rustcorp.com.au on Mon, Jul 23, 2001 at 06:44:10AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 06:44:10AM +1000, Rusty Russell wrote:
> This current code is bogus.  Consider:
> 	spin_lock_irqsave(flags);	
> 	cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
> 	spin_unlock_irqrestore(flags);

What kernel are you looking at? There's no such code in 2.4.7, the only
two raise of the NET_RX_SOFTIRQ softirq are in dev.c in net_rx_action
and netif_rx:

here the one in netif_rx:

			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
			local_irq_restore(flags);

here the one in net_rx_action:

	/* This already runs in BH context, no need to wake up BH's */
	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
	local_irq_enable();

> Oops... softirq not run until the next interrupt.  So, EITHER:

The first netif_rx is required to run from interrupt handler (otherwise
we should have executed cpu_raise_softirq and not __cpu_raise_softirq)
so we cannot miss the do_softirq in the return path from do_IRQ() and so
we cannot wait for the next incoming interrupt (if we have a overflow of
the do_softirq loop ksoftirqd will take care of it without waiting for
the next interrupt as it could instead happen in old 2.4 kernels).

The second net_rx_action is running into the softirq code itself that
will marks itself runnable again and this will generate a do_softirq
overflow that is handled gracefully by ksoftirqd again without waiting
for the next interrupt (in old 2.4 kernels you had to wait for the next
irq instead).

I cannot see any problem.

Andrea
