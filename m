Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268167AbRGWJZr>; Mon, 23 Jul 2001 05:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268162AbRGWJZh>; Mon, 23 Jul 2001 05:25:37 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:13062 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S268166AbRGWJZY>; Mon, 23 Jul 2001 05:25:24 -0400
Date: Mon, 23 Jul 2001 11:25:23 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7 softirq incorrectness.
In-Reply-To: <20010723013416.B23517@athlon.random>
Message-ID: <Pine.LNX.4.33.0107231113150.27373-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Andrea Arcangeli wrote:

> here the one in netif_rx:
> 
> 			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
> 			local_irq_restore(flags);
> [...] 

> The first netif_rx is required to run from interrupt handler (otherwise
> we should have executed cpu_raise_softirq and not __cpu_raise_softirq)
> so we cannot miss the do_softirq in the return path from do_IRQ() and so
> we cannot wait for the next incoming interrupt (if we have a overflow of
> the do_softirq loop ksoftirqd will take care of it without waiting for
> the next interrupt as it could instead happen in old 2.4 kernels).

Hmmh, wait a second. I take it that means calling netif_rx not from 
hard-irq context, but e.g. from bh is a bug? (Even if the only consequence 
is delaying the processing by up to one timer tick?)

If so, I believe this bug exists in a couple of a places. One example is -
of course - the ISDN code, where netif_rx() is called from bh context. But
I would think that e.g. ppp_generic is affected as well.

Could you clarify this? Maybe adding something like the following to 
netif_rx() is a good idea?

	if (!in_irq)
		printk(KERN_WARNING "netif_rx called not in_irq() from %p\n",
		       __builtin_return_address(0));

--Kai

