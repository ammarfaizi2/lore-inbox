Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJAWi3>; Mon, 1 Oct 2001 18:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275669AbRJAWiK>; Mon, 1 Oct 2001 18:38:10 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:50683 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275670AbRJAWht>; Mon, 1 Oct 2001 18:37:49 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 1 Oct 2001 16:36:31 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Andrea Arcangeli <andrea@suse.de>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011001163631.C23808@turbolinux.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Andrea Arcangeli <andrea@suse.de>, Simon Kirby <sim@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  00:16 +0200, Ingo Molnar wrote:
> - the irq handling code has been extended to support 'soft mitigation',
>   ie. to mitigate the rate of hardware interrupts, without support from
>   the actual hardware. There is a reasonable default, but the value can
>   also be decreased/increased on a per-irq basis via /proc/irq/NR/max_rate.
> 
> the method is the following. We count the number of interrupts serviced,
> and if within a jiffy there are more than max_rate interrupts, the code
> disables the IRQ source and marks it as IRQ_MITIGATED. On the next timer
> interrupt the irq_rate_check() function is called, which makes sure that
> 'blocked' irqs are restarted & handled properly.

How far is it to go from a mitigated IRQ (because of too high an interrupt
rate) to a polled interface (e.g. for network cards)?  This was discussed
a number of times to improve overall performance on bust network systems.

Concievably, a network card could tune max_rate to a value where it is
more efficient (CPU wise) to poll the interface instead of using IRQs.
However, waiting for the next regular timer interrupt may be too long
(resulting in lost packets) as buffers overflowed.  Would it also be
possible for a driver to register a "maximum delay" between servicing
interrupts (within reason, on a non-RT system) so that it can say "I
have X kB of buffers, and the maximum line rate is Y kB/s, so I need
to be serviced within X/Y s when polling without losing data".

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

