Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUHSWER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUHSWER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHSWER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:04:17 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:18571 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267451AbUHSWEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:04:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Thu, 19 Aug 2004 16:03:55 -0600
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040819092654.27bb9adf.akpm@osdl.org> <1092938035.28370.13.camel@localhost.localdomain> <20040819215124.GA6114@hygelac>
In-Reply-To: <20040819215124.GA6114@hygelac>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191603.55327.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 3:51 pm, Terence Ripperda wrote:
> the original bug report was during module load time, when we're
> probing our devices via the pci_driver's probe callback. this is well
> before we hook up interrupts or do anything in our closed source code.
> 
> I'm attaching a trimmed down version of our driver that pretty much
> only does this probe (complete source is included). I don't know if
> this will reproduce the original bug or not.

Thanks, this is enough to show the problem:

	nv_kern_probe(struct pci_dev *dev, ...)
	{
		...
		nv->interrupt_line = dev->irq;
		...
		if (pci_enable_device(dev) != 0)

The driver is looking at dev->irq before calling pci_enable_device().
But dev->irq is not necessarily initialized before pci_enable_device().

I'm not a PCI expert, but I'm not sure you should be looking at
all the other dev->resource[] stuff before pci_enable_device()
either.  Most of the "modern" drivers in the tree seem to do
pci_enable_device() very early in the probe() function, i.e., 
see tg3.c.
