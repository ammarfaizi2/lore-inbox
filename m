Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbRAaML7>; Wed, 31 Jan 2001 07:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRAaMLu>; Wed, 31 Jan 2001 07:11:50 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:7905 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S130030AbRAaMLg>; Wed, 31 Jan 2001 07:11:36 -0500
Date: Wed, 31 Jan 2001 12:11:25 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <becker@scyld.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.4.21.0101310346240.2065-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.31.0101311207150.20199-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Martin Diehl wrote:

> Reason: we fetched the irq too early, before calling pci_enable_device(),
> so it was bogus after initial routing.
> Patch below (prepared for 2.4.0 - should be fine for 2.4.1 too).

I think it would be better to move the pci_enable_device(pdev);
above all this, as we should enable the device before reading the
pdev->resource[] too iirc.

Something like this maybe ?

  	i = pci_enable_device (pdev);
  	if (i)
  		return i;

  	ioaddr = pci_resource_start (pdev, 0);

  	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_IO) == 0)) {
  		printk (KERN_ERR "ne2k-pci: no I/O resource at PCI BAR #0\n");

 	irq = pdev->irq;

Comments?

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
