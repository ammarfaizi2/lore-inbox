Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSL1SGX>; Sat, 28 Dec 2002 13:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSL1SGX>; Sat, 28 Dec 2002 13:06:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25607 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266274AbSL1SGW>; Sat, 28 Dec 2002 13:06:22 -0500
Date: Sat, 28 Dec 2002 18:14:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
Message-ID: <20021228181438.B5217@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212180301.gBI31wE06794@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212180301.gBI31wE06794@localhost.localdomain>; from James.Bottomley@steeleye.com on Tue, Dec 17, 2002 at 09:01:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just been working through the ARM dma stuff, converting it to the
new API, and I foudn this:

> +static inline int
> +pci_dma_supported(struct pci_dev *hwdev, u64 mask)
> +{
> +	return dma_supported(&hwdev->dev, mask);
> +}
> (etc)

I'll now pull out a bit from DMA-mapping.txt:

| 		 Using Consistent DMA mappings.
| 
| To allocate and map large (PAGE_SIZE or so) consistent DMA regions,
| you should do:
| 
| 	dma_addr_t dma_handle;
| 
| 	cpu_addr = pci_alloc_consistent(dev, size, &dma_handle);
| 
| where dev is a struct pci_dev *. You should pass NULL for PCI like buses
| where devices don't have struct pci_dev (like ISA, EISA).  This may be
| called in interrupt context. 

What happens to &hwdev->dev when you do as detailed there and pass NULL
into these "compatibility" functions?  Probably an oops.

I think these "compatibility" functions need to do:

static inline xxx
pci_xxx(struct pci_dev *hwdev, ...)
{
	dma_xxxx(hwdev ? &hwdev->dev : NULL, ...)
}

so they remain correct to existing API users expectations.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html








