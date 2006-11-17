Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933700AbWKQQXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700AbWKQQXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933698AbWKQQXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:23:18 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:21187 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S933699AbWKQQXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:23:17 -0500
Date: Fri, 17 Nov 2006 17:22:58 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Wojtek Kaniewski <wojtekka@toxygen.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH take 2] Atmel MACB ethernet driver
Message-ID: <20061117172258.51bec4a3@cad-250-152.norway.atmel.com>
In-Reply-To: <455C8FB4.8000200@toxygen.net>
References: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
	<455C8FB4.8000200@toxygen.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 17:20:04 +0100
Wojtek Kaniewski <wojtekka@toxygen.net> wrote:

> Haavard Skinnemoen wrote:
> > Driver for the Atmel MACB on-chip ethernet module.
> > 
> > Tested on AVR32/AT32AP7000/ATSTK1000. I've heard rumours that it
> > works with AT91SAM9260 as well, and it may be possible to share
> > some code with the at91_ether driver for AT91RM9200.
> 
> It seems to work with AT91SAM9260, but unfortunately not without
> problems. I occasionally get TX underrun errors, mostly while
> transferring some large files. The same thing happens with driver
> provided by TimeSys in their AT91SAM9260-enabled Linux distribution
> recommended by Atmel (both drivers share the codebase). Is there
> anything I can check by myself (without an ICE) to see what's wrong?
> Some printk() in macb_tx() maybe?

Hmm...underruns as in "eth0: TX underrun, resetting buffers"?

If so, this happens when the UND bit is set in the Transmit Status
Register. This bit has the following meaning (from the at32ap7000
data sheet):

"Set when transmit DMA was not able to read data from memory, either
because the bus was not granted in time, because a not OK hresp(bus
error) was returned or because a used bit was read midway through frame
transmission. If this occurs, the transmitter forces bad CRC. Cleared
by writing a one to this bit."

So it's caused either by a corrupted descriptor or by excessive bus
latency.

If it's a problem with the descriptor, it would probably help to dump
out some information about the ring state, i.e. the value of
bp->tx_head and bp->tx_tail, and maybe dump all outstanding descriptors
in the ring to see if any of them look suspicious.

Of course, if it's a cache flushing issue, we might not see
anything wrong in the descriptors. The descriptor rings are allocated
with dma_alloc_coherent(), so I don't think this is very likely.

If it's a bus latency issue, things start to get a bit
platform-specific, so we should probably involve some more experienced
ARM people. Might be possible to improve things by configuring the
main system bus differently, or put the DMA buffers in internal SRAM if
possible.

Thanks for the report,

Haavard
