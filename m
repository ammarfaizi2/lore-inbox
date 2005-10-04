Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVJDUSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVJDUSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVJDUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:18:50 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:2520 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S964956AbVJDUSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:18:50 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=LGRFs2m9U1bLlSW6VmKzJqGFAfs2aPFkiH+zuw3B+89twXH9XODseG9oP/IdCDvlh
	/wiVKiRin9n2R8uo9Gd+A==
Date: Tue, 04 Oct 2005 13:18:35 -0700
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051004201835.8DC32EE96F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

> can you please describe the data flow in case of DMA transfer? Thanks!

In the current model, the controller driver handles it (assuming
that it uses DMA not PIO):

 - Use dma_map_single() at some point between the master->transfer()
   call and the time the DMA address is handed to DMA hardware.

 - Probably store those addresses in the spi_transfer struct, using
   rx_dma and/or tx_dma as appropriate.

 - After the DMA transfer completes, call dma_unmap_single() before
   calling spi_message.complete(spi_message.context).

There are two fancier approaches to consider for sometime later, both
of which have been used for several years now by host-side USB.

  * SPI controller drivers could require the mappings to already
    have been done, and stored in {rx,tx}_dma fields.  When those
    drivers are using DMA, they'd only use those DMA addresses.

    The way host-side USB does that is by having usbcore do work
    on all the submit and giveback paths.  Currently this SPI
    framework doesn't do "core" work on those paths; spi_async()
    just calls directly to the controller driver (no overhead!)
    and the completion reports likewise go right from controller
    driver back to the submitter (also, no overhead).

  * Drivers for SPI slave chips might sometimes want to provide their
    own rx_dma and/or tx_dma values ... either because they mapped the
    buffers themselves -- great for dma_map_sg()! -- or because the
    memory came from dma_alloc_coherent().

    This implies that the controller drivers are ready to accept
    those DMA addresses, and that there are per-buffer flags saying
    whether its DMA address is also valid (vs just its CPU address).
    
Note that the slave-side USB support only supports the latter, which
means the USB peripheral controller drivers with DMA support decide
on a per-request basis whether to do the DMA mappings.  I'd lean
towards doing that with SPI; it's a bunch simpler.

Right now DMA isn't on my priority list, but I'd be glad to see
someone else take further steps there.  Anyone doing bulk I/O to an
SPI flash chip at 50 MHz is surely going to want DMA for it!

- Dave

p.s. Please be sure to CC me on replies, so I'm sure to see them...

