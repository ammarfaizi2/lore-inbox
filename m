Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTL3GgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbTL3GgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:36:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3735 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264488AbTL3GgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:36:05 -0500
Message-ID: <3FF11CC2.7040209@pobox.com>
Date: Tue, 30 Dec 2003 01:35:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad House <brad_mssw@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>        <20031230052041.GA7007@gtf.org> <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>
In-Reply-To: <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad House wrote:
> Hmm, I don't think this driver is as complex as others may
> be to port.  But then again, I'm probably wrong b/c I'm mainly
> a userland guy, not a kernel guy :/
> But, nonetheless, I've made some changes:

The only thing that matters is the hardware s/g list capabilities. 
Driver complexity is irrelevant.


>>> 			/* Calculate Scatter-Gather info */
>>> 			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
>>>-					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
>>>+					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);
>>
>>Casting just hides a bug.
> 
> 
> Well, the  xferaddr is actually a dma_addr_t now, so that cast really
> does nothing, the only reason it's there is because they previously
> casted it as (u32 *).  I removed the cast just so it couldn't obscure
> warnings, and it didn't.
> 
> Also, I use  dma_addr_t even though it may have nothing to do with dma
> where it's used. I'm more familiar with userland stuff, so I wasn't sure
> what to use. In userland I'd use  uintptr_t.
> 
> 
>>The real fix is to pass a full 64-bit address
> 
> 
> I did find a few instances where they recast the addresses,
> which was improper, but it does appear that the original address
> in the original driver was coming in as 64bit (dma_addr_t as originally
> written), but were passing it around and casting it as a u32, so I
> think the interfaces allowed for it to work, they just wrote it
> unware of 64bit systems.
> 
> Also, they tried to stuff the address returned here :
> ext_inq = pci_alloc_consistent(adapter->dev,
>                                 sizeof(mraid_ext_inquiry), &dma_handle);
> (the dma_handle) into a u32 which I just fixed.
> 
> 
>>into the s/g list, if it supports 64-bit addresses.  if it doesn't, you
>>need to make sure the driver doesn't set highmem_io, make sure the
>>driver doesn't set a 64-bit DMA mask, and make sure the driver does set
>>a 32-bit DMA mask.
> 
> 
> The driver already does this it appears, without me needing to do it,
> Part of which is covered by this:
>  /* Set the Mode of addressing to 64 bit if we can */
>                 if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) ==
> 8)) {
>                         pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
>                         adapter->has_64bit_addr = 1;
>                 }
>                 else  {
>                         pci_set_dma_mask(pdev, 0xffffffff);
>                         adapter->has_64bit_addr = 0;
>                 }

This code is completely bogus and wrong (not your fault, but still). 
Take a look at tg3.c for the right way to do it.

The driver continues to have obvious 64-bit issues that your patch 
doesn't address.  Your main test platform should really be a 32-bit 
system with PAE, and >4GB of RAM.

	Jeff



