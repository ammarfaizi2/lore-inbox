Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTATQni>; Mon, 20 Jan 2003 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTATQni>; Mon, 20 Jan 2003 11:43:38 -0500
Received: from havoc.daloft.com ([64.213.145.173]:63642 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266233AbTATQnh>;
	Mon, 20 Jan 2003 11:43:37 -0500
Date: Mon, 20 Jan 2003 11:52:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: propagating failures down to pci_module_init()
Message-ID: <20030120165236.GA27972@gtf.org>
References: <20030120155435.GA29238@codemonkey.org.uk> <20030120163321.A32585@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120163321.A32585@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 04:33:21PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 20, 2003 at 03:54:35PM +0000, Dave Jones wrote:
> > I've got a wierd situation with a certain chipset for agpgart.
> > There are a few cases where I want to be able to use the existing
> > pci_driver api to detect the right PCI device, and call
> > the relevant .probe routine. No problem there.
> > 
> > The problem is that in these cases, I want to be able to read
> > a certain register in that device, and if a bit is 0, bail out
> > of the .probe function with -ENODEV, and make the loading of
> > the module fail.
> > 
> > The problem is that the ENODEV in my .probe routine doesn't
> > propagate back down as far as pci_module_init().
> > 
> > Ideas ?
> 
> Just use pci_register_driver.

Nope.  Look at pci_module_init code.  It propagates pci_register_driver
return value.

The _real_ problem is that ->probe return value is not propagated back
to pci_register_driver return value.  The reason for this is that you
may call ->probe many times, and nobody has written the code to collate
the error returns.

Since one can only sanely return an error code when there was _one_
device and it failed, you are rather limited in error propagation.

	Jeff



