Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSFOULF>; Sat, 15 Jun 2002 16:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSFOULE>; Sat, 15 Jun 2002 16:11:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315517AbSFOULD>;
	Sat, 15 Jun 2002 16:11:03 -0400
Message-ID: <3D0B9E79.7010909@mandrakesoft.com>
Date: Sat, 15 Jun 2002 16:07:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206151140400.3479-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> which is horribly stupid. We really want to do
> 
> 	pci_enable_mem(dev);
> 	membase = ioremap(dev->resource[]);
> 
> 	pci_request_irq(dev, irq_handler);
> 
> where "pci_request_irq()" enables the interrupt and adds an interrupt
> handler atomically.

That seems ok to me.  Note that we still want 
pci_{enable,disable}_device to exist (as mentioned in the mail to 
Kai)...  I'm fine with moving a lot of pci_enable_device's duties to 
pci_{assign,request,release}_{irq,io,mem} as long as we don't kill it 
completely.


>>The only thing I've wanted is a cross-platform way to detect if
>>pdev->irq returned by pci_enable_device is valid.
> 
> 
> It's required to be valid, because if it isn't, then the platform is
> broken. There are no cross-platform issues: complain to the platform
> vendor and/or the linux code for that architecture.

Well, then I should either complain to myself, or to you ;-)  Part of 
this comes back to PCI irq routing.  The actual situation encountered is,

When ia32 PCI irq routing messes up, or some other random reason why an 
irq is not available for a PCI device, pdev->irq==0.  So I test for that 
in my code.  Then DaveM bitches at me for my test (pdev->irq < 2) not 
being cross-platform.

My suggested solution, if you like Kai's proposal, is to have 
pci_assign_irq() or pci_request_irq() return an error if PCI IRQ routing 
fails.

	Jeff


P.S. Random tangent:  the PCI layer could do a lot better job at 
spreading devices across the available IRQs.  I've seen devices 
clustered on a single interrupt by the Linux PCI code, where their pci 
irq routing masks indicating other, not-assigned-at-all irqs were available.


