Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVIPVYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVIPVYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVIPVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:24:21 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:57762 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751297AbVIPVYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:24:21 -0400
Date: Fri, 16 Sep 2005 23:24:08 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap(2)ping of pci_alloc_consistent() allocated buffers on 2.4
 kernels question/help
In-Reply-To: <1126896652.3103.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0509162302310.14757@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0509162009510.14084@kepler.fjfi.cvut.cz>
 <1126896652.3103.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Sep 2005, Arjan van de Ven wrote:

> On Fri, 2005-09-16 at 20:33 +0200, Martin Drab wrote:
> > Hi,
> > 
> > can anyone explain me why it is not possible to mmap(2) a buffer 
> > allocated in kernel by pci_alloc_consistent() to userspace on a 2.4 
> > kernel?
> > 
> > In kernel PCI device initialization function I do something like:
> > 
> > ...
> > kladdr = pci_alloc_consistent (dev, BUFSIZE, &baddr);
> > ...
> > 
> > Then I send the physical address (i.e. the value of phaddr = __pa(kladdr)) 
> > to the userspace application, and then when in the userspace I do 
> > something like
> > 
> > ...
> > fd = fopen ("/dev/mem", O_RDWR);
> > buf = mmap (NULL, BUFSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, phaddr);
> > ...
> 
> 
> yuch.
> why don't you make your device have an mmap operation instead?
> (the device node that you use to get your physical address to userspace
> in the first place)

And would that help anyhow?

Just a background:

This is a RT driver for the RT Linux (that's why the 2.4 kernel). It is a 
data acquisition card. What I would like to do is:

Driver allocates a finite (predefined) number of DMA buffers with 
pci_alloc_consistent() during the initialization. (This fixed alloc is 
necessary, since when you switch the driver into RT you cannot do any 
memory allocations anymore). And then I would like to fill a buffer via 
DMA, send a notice to the app. via the RT FIFO device that a buffer is 
filled, app. then calls the ioctl of the RT FIFO with the buffer number 
(obtained via the RT FIFO) that he wants to mmap, the ioctl mmaps it to 
the app., app. uses the data, and then calls another ioctl to unmap the 
buffer and release it for next filling.

There's just a limited way to communicate between the RT and non-RT part 
of the kernel/app. The RT-FIFOs and their IOCTLs are safe. I'm not 
entirely sure a simple mmap would be safe here, but I may try that.

Martin
