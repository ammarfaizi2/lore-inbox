Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSFOSsV>; Sat, 15 Jun 2002 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFOSsU>; Sat, 15 Jun 2002 14:48:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315459AbSFOSsT>; Sat, 15 Jun 2002 14:48:19 -0400
Date: Sat, 15 Jun 2002 11:48:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3D0A45F2.1030202@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0206151140400.3479-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jun 2002, Jeff Garzik wrote:
>
> Can someone clarify for me the need of pci_request_irq??
>
> pci_enable_device() assigns the IRQ in routing, but it is not enabled
> until you call request_irq.  I don't see any simplification that can be
> done in the PCI API.

The irq _is_ enabled ona hardware level.

Which can be a total disaster if there are shared PCI irq's, and the
interrupt is "screaming" (ie an active level-sensitive thing).

We've had this on cardbus, for example, where we need to do an
"pci_emable_device()" in order to get access to the PCI IO mappings, which
are needed to shut the device up.

Right now the solution to a screaming device can be something as nasty as

	cli();
	pci_enable_device();
	disable_irq(dev->irq);
	sti();

	/* IRQ handling needs this ioremapped */
	membase = ioremap(dev->resource[]);
	request_irq(dev->irq);

	/* Now we can enable the irq, because we have a valid handler */
	enable_irq(dev->irq);

which is horribly stupid. We really want to do

	pci_enable_mem(dev);
	membase = ioremap(dev->resource[]);

	pci_request_irq(dev, irq_handler);

where "pci_request_irq()" enables the interrupt and adds an interrupt
handler atomically.

> The only thing I've wanted is a cross-platform way to detect if
> pdev->irq returned by pci_enable_device is valid.

It's required to be valid, because if it isn't, then the platform is
broken. There are no cross-platform issues: complain to the platform
vendor and/or the linux code for that architecture.

		Linus

