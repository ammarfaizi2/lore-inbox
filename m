Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267055AbRGYWXf>; Wed, 25 Jul 2001 18:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbRGYWXZ>; Wed, 25 Jul 2001 18:23:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31600 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267053AbRGYWXQ>; Wed, 25 Jul 2001 18:23:16 -0400
Date: Thu, 26 Jul 2001 00:23:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010726002357.D32148@athlon.random>
In-Reply-To: <20010723013416.B23517@athlon.random> <200107232224.CAA06983@mops.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107232224.CAA06983@mops.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, Jul 24, 2001 at 02:24:47AM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 02:24:47AM +0400, Alexey Kuznetsov wrote:
> Hello!
> 
> > The first netif_rx is required to run from interrupt handler 
> 
> No! netif_rx() is called from _any_ context. Check with grep.

Originally it was a cpu_raise_softirq, but David asked to put the __ so
Linus added the comment as well:

		/* Runs from irqs or BH's, no need to wake BH */

At that time I checked loopback that runs under the bh so it's ok too.

> So, this must be repaired in some way.

Yes.  If ethertap or others runs outside bh and irq they could use if
(pending) do_softirq by hand (or as worse wakeup ksoftirqd by hand)
after netif_rx.

> Actually, assumption that local_bh_enable() etc does not happen
> with disabled irq was the biggest hole in Ingo's patch: all the functions

I hoped it was never the case because when you serialize against bh it's
because you are using the bh logic instead of irqs and the whole point
of the bh logic is to left irq enabled. but I'm not surprised some
problem actually triggered because of this change.

Andrea
