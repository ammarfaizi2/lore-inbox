Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUHSXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUHSXBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHSXBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:01:42 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:43275 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S267491AbUHSW6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:58:54 -0400
Date: Thu, 19 Aug 2004 17:58:49 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Message-ID: <20040819225848.GE1263@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040819092654.27bb9adf.akpm@osdl.org> <1092938035.28370.13.camel@localhost.localdomain> <20040819215124.GA6114@hygelac> <200408191603.55327.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191603.55327.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 19 Aug 2004 22:58:51.0686 (UTC) FILETIME=[184BB460:01C48640]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn,

I'll move that call to pci_enable_device to earlier in the probe call.

but in Kevin's original email, he's hitting an oops within the
pci_enable_device call. is that likely due to pci_enable_device being
called late?

Thanks,
Terence

On Thu, Aug 19, 2004 at 04:03:55PM -0600, bjorn.helgaas@hp.com wrote:
> On Thursday 19 August 2004 3:51 pm, Terence Ripperda wrote:
> > the original bug report was during module load time, when we're
> > probing our devices via the pci_driver's probe callback. this is well
> > before we hook up interrupts or do anything in our closed source code.
> > 
> > I'm attaching a trimmed down version of our driver that pretty much
> > only does this probe (complete source is included). I don't know if
> > this will reproduce the original bug or not.
> 
> Thanks, this is enough to show the problem:
> 
> 	nv_kern_probe(struct pci_dev *dev, ...)
> 	{
> 		...
> 		nv->interrupt_line = dev->irq;
> 		...
> 		if (pci_enable_device(dev) != 0)
> 
> The driver is looking at dev->irq before calling pci_enable_device().
> But dev->irq is not necessarily initialized before pci_enable_device().
> 
> I'm not a PCI expert, but I'm not sure you should be looking at
> all the other dev->resource[] stuff before pci_enable_device()
> either.  Most of the "modern" drivers in the tree seem to do
> pci_enable_device() very early in the probe() function, i.e., 
> see tg3.c.
