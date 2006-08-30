Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWH3QBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWH3QBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWH3QBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:01:54 -0400
Received: from external.redrocketcomputing.com ([69.16.195.231]:17305 "EHLO
	external.redrocketcomputing.com") by vger.kernel.org with ESMTP
	id S1750999AbWH3QBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:01:53 -0400
Subject: Re: [spi-devel-general] [Patch] Add spi full duplex mode transfer
	support
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Manish Jaggi <manish.jaggi@gmail.com>
Cc: David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, Luke Yang <luke.adi@gmail.com>,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <2e2add590608300337h3e7e806bs69b63b24d73a104c@mail.gmail.com>
References: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com>
	 <200608292152.58616.david-b@pacbell.net>
	 <2e2add590608300337h3e7e806bs69b63b24d73a104c@mail.gmail.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 30 Aug 2006 08:56:58 -0700
Message-Id: <1156953418.6555.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - external.redrocketcomputing.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 16:07 +0530, Manish Jaggi wrote:
> On the same lines can we have a member in spi_transfer structure
> like bUseDMA.
> 
> In spi PIO mode for short writes of 2 to 8 words is better.
> And we use DMA for larger writes/reads
> 
This capability is built into the pxa2xx_spi driver.  

Excerpt from linux/Documentation/spi/pxa2xx:

The pxa2xx_spi driver support both DMA and interrupt driven PIO message
transfers.  The driver defaults to PIO mode and DMA transfers must
enabled by setting the "enable_dma" flag in the "pxa2xx_spi_master"
structure and and ensuring that the "pxa2xx_spi_chip.dma_burst_size"
field is non-zero.  The DMA mode support both coherent and stream based
DMA mappings.

The following logic is used to determine the type of I/O to be used on
a per "spi_transfer" basis:

if !enable_dma or dma_burst_size == 0 then
        always use PIO transfers

if spi_message.is_dma_mapped 
   and rx_dma_buf != 0 and tx_dma_buf != 0 then
        use coherent DMA mode

if rx_buf and tx_buf are aligned on 8 byte boundary then
        use streaming DMA mode

otherwise
        use PIO transfer

By enabling DMA tranfers, clearing the spi_message.is_dma_mapped and
providing transfer buffer NOT aligned on 8 byte boundary forced PIO mode
will transfer buffers aligned on 8 byte boundary forces a DMA mode.

My experiance has shown the most stack allocated transfer buffers are
not 8 byte aligned and thus use PIO mode.

Stephen

