Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268362AbRGXRFM>; Tue, 24 Jul 2001 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbRGXRFC>; Tue, 24 Jul 2001 13:05:02 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:44045 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268362AbRGXRE4>;
	Tue, 24 Jul 2001 13:04:56 -0400
Message-Id: <200107232224.CAA06983@mops.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: andrea@suse.DE (Andrea Arcangeli)
Date: Tue, 24 Jul 2001 02:24:47 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010723013416.B23517@athlon.random> from "Andrea Arcangeli" at Jul 23, 1 03:45:00 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> The first netif_rx is required to run from interrupt handler 

No! netif_rx() is called from _any_ context. Check with grep.
So, this must be repaired in some way.

Actually, assumption that local_bh_enable() etc does not happen
with disabled irq was the biggest hole in Ingo's patch: all the functions
ever doing local_irq_save() assume that they _can_ be called with
disabled irqs (otherwise they would make local_irq_disable() instead)
and, hence, some spinlocks held.



> for the next interrupt (in old 2.4 kernels you had to wait for the next
> irq instead).

Well, not "had to", a small delay was purpose of this call yet.
Actually, now it can be replaced with a direct schedule ksoftirqd,
because we surely have softirq flood, when this place is reached.

Alexey

