Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWIKFV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWIKFV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWIKFV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:21:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:9637 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964810AbWIKFV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:21:28 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FB2A@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC093FB2A@NT-IRVA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 15:21:21 +1000
Message-Id: <1157952081.31071.409.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It definitely is caused by lack of memory barriers before the writel().
> IBM, Anton, and all of us know about this.  TSO probably makes it more
> susceptible because you write to many buffer descriptors before you
> issue one writel() to DMA all the descriptors.  The large number of
> TSO descriptors makes re-ordering more likely.

The barrier problem exist for sure. However, I've added a barrier before
all write to the mailboxes and I still see the problem. Any idea what I
may have missed ?

I'm now investigating a theory of possible missing barriers in the
producer/consumer variable manipulation if the ring ends up being full
and emptied entirely all at once. It's a bit of a headach to put my head
around this driver as it managed to totally avoid locks and use very few
barriers in general for ordering both between CPUs and with shared data
structures with the chip like the hw status structure. I don't say it's
bad, I say it's complex to make sure it's completely right :)

For example the driver never flushes the PCI buffers with an MMIO read
before reading shared data structures. That means that it can, I suppose
(I hope) rely on the producer/comsumer fields in there always being
updated last (that is after all relevant descriptors have been updated),
but also, that it can afford to lose interrupts (since it doesn't flush
the PCI buffers when getting an interrupt, it reads potentially stale
status and then acts upon that). It might all be on purpose though :)

Cheers,
Ben.


