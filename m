Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293256AbSCFHAX>; Wed, 6 Mar 2002 02:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293260AbSCFHAN>; Wed, 6 Mar 2002 02:00:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:36868 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S293256AbSCFHAF>; Wed, 6 Mar 2002 02:00:05 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Does kmalloc always return address below 4GB?
Date: 5 Mar 2002 17:00:55 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna89ue7.4at.kraxel@bytesex.org>
In-Reply-To: <200203051639.IAA05629@adam.yggdrasil.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1015347655 4446 127.0.0.1 (5 Mar 2002 17:00:55 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Look at other drivers using the DMA interfaces like the two aic7xxx
> >and all of the sym53c8xx drivers, they get it right.
>  
>  	Grepping for vmalloc and kmap in them turns up no hits.

Why do you want to vmalloc() memory in the scsi driver?

>  computer with >4GB of RAM (CONFIG_HIGHEM) talking to a PCI card
>  that only does 32-bit addressing:
>  
>  		pci_set_dma_mask(pcidev, 0xffffffff);
>  		addr = vmalloc(nbytes);
>  		/* On an x86 with >4GB of RAM, addr will be <4GB, but
>  	           __pa(addr) might be >4GB, and the system lacks
>  	           PCI address mapping harware. */

use vmalloc_32(), this one returns lowmem.

>  		dma_addr = pci_map_single(pcidev, addr, nbytes, direction);

This is illegal because addr is a kernel _virtual_ address.  You have to
get the page using vmalloc_to_page() and feed this to pci_map_page()
then.  With nbytes > PAGE_SIZE you probably want to build a scatterlist
and use pci_map_sg().

  Gerd

-- 
#include </dev/tty>
