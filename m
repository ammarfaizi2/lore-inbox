Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWHBFqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWHBFqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWHBFqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:46:04 -0400
Received: from camden.avalon.com.au ([150.101.131.13]:20175 "EHLO
	camden.avalon.com.au") by vger.kernel.org with ESMTP
	id S1751262AbWHBFqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:46:03 -0400
Subject: DMA buffer synchronisation - inconsistent processor
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Reply-To: Phil.Nitschke@avalon.com.au
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Avalon Systems Pty Ltd
Date: Wed, 02 Aug 2006 15:15:23 +0930
Message-Id: <1154497523.11033.12.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.5 (camden.avalon.com.au [192.168.0.1]); Wed, 02 Aug 2006 15:15:24 +0930 (CST)
X-Avalon-MailScanner: Found to be clean
X-Avalon-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.538,
	required 4, autolearn=, AWL 0.06, BAYES_00 -2.60)
X-MailScanner-From: phil.nitschke@avalon.com.au
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm transferring data using DMA from a custom PCI device memory into
RAM.  Can someone advise me on the correct buffer synchronisation
strategy for the following 3 scenarios:

Assuming I have three buffers, buf_A, and buf_B, both created using
dma_alloc_noncoherent(NULL, 32 * PAGE_SIZE, ...), and buf_C (much
larger), remapped into the processor's virtual address space using
ioremap(), and 'n' is the number of bytes to copy using DMA channel
'dmanr', ...

1/. DMA copy from PCI device memory into buf_B:

   /* ...prepare DMA engine, then: */
   WARN_ON(buf_B != L1_CACHE_ALIGN(buf_B));
   dma_sync_single_range_for_device(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   dma_sync_single_range_for_cpu(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

2/. DMA copy from buf_A to buf_B 
    (same as above, except now sync the src buffer prior to DMA):

   /* ...prepare DMA engine, check buffer alignment (x2), then: */
   dma_sync_single_range_for_device(NULL, buf_A,  0, n, DMA_TO_DEVICE);
   dma_sync_single_range_for_device(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   dma_sync_single_range_for_cpu(NULL, buf_B, 0, n, DMA_FROM_DEVICE);

3/. DMA from PCI device memory into ioremap()'ed buffer, buf_C:

   /* ...prepare DMA engine, check buffer alignment, then: */
   /* No buffer sync-ing is required? */

   mv64x6x_enable_dma(dmanr);
   wait_for_completion_interruptible_timeout(...)

   /* No buffer sync'ing is required? */

Will this approach work (particularly case 3/.)?  I tried dma_sync-ing
the region, but got an 'oops' (kernel access of bad area(?)).

I'm using the 2.6.16 kernel (compiled with CONFIG_NOT_COHERENT_CACHE
defined) on an Artesyn PmPPC7448 processor.  The processor utilises its
Marvell MV64460 as the DMA controller for the transaction.  

Thanks,

-- 
Phil


