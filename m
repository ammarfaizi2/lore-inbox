Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWIKXYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWIKXYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWIKXYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:24:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50884 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965105AbWIKXYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:24:38 -0400
Message-ID: <4505F030.3020207@pobox.com>
Date: Mon, 11 Sep 2006 19:24:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
References: <1157947414.31071.386.camel@localhost.localdomain>	 <200609111139.35344.jbarnes@virtuousgeek.org>	 <1158011129.3879.69.camel@localhost.localdomain>	 <4505DB10.7080807@pobox.com> <1158015394.3879.82.camel@localhost.localdomain>
In-Reply-To: <1158015394.3879.82.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Well, the argument currently is to make writel and readl imply the above
> barriers by making them fully ordered (and slow on some platforms) and
> so also provide more weakly ordered routines along with barriers for
> people who know what they do. The above 2 barriers are what I've called
> io_to_memory_rb() and memory_to_io_wb() (actually,
> prepare_to_read_dma_memory() by itself doesn't really make much sense.
> It does in conjunction with an MMIO read to flush DMA buffers, in which
> case the barrier provides an ordering guarantee that the memory reads
> will only be performed after the MMIO read has fully completed).

<jgarzik throws a monkey wrench into the works>

I think focusing on MMIO just confuses the issue.

wmb() is often used to make sure a memory store is visible to a 
busmastering PCI device... before the code proceeds with some more 
transactions in the memory space shared by the host and PCI device.

prepare_to_read_dma_memory() is the operation that an ethernet driver's 
RX code wants.  And this is _completely_ unrelated to MMIO.  It just 
wants to make sure that the device and host are looking at the same 
data.  Often this involves polling a DMA descriptor (or index, stored 
inside DMA-able memory) looking for changes.

flush_my_writes_to_dma_memory() is the operation that an ethernet 
driver's TX code wants, to precede either an MMIO "poke" or any other 
non-MMIO operation where the driver needs to be certain that the write 
is visible to the PCI device, should the PCI device desire to read that 
area of memory.

	Jeff




