Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268740AbUHLU3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268740AbUHLU3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268750AbUHLU3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:29:41 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:64112 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268740AbUHLU2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:28:09 -0400
Message-ID: <20040812202808.19586.qmail@web14928.mail.yahoo.com>
Date: Thu, 12 Aug 2004 13:28:08 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <1092311491.21995.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2004-08-12 at 00:31, Jon Smirl wrote:
> > How are we supposed to implement this without a copy? Once the
> device
> > driver is loaded there is never a safe way access the ROM again
> because
> > an interrupt or another CPU might use the PCI decoders to access
> the
> > other hardware and disrupt the ROM read. You have to copy the ROM
> when
> > the driver says it is safe.
> 
> It's never safe essentially. The only way you can make it safe for
> this
> case is to put the knowledge in the device driver for that specific
> card
> rather than sysfs.

I added these two calls to the pci API just for the case of partially
decoded hardware. The device driver for the hardware needs to make
these calls.

unsigned char *pci_map_rom_copy(struct pci_dev *dev, size_t *size);

Call this one from the driver when it is safe to read the ROM. It will
copy it and then provide a virtual address so that you can read it. The
copy is stored in the kernel so that the sysfs attribute will work
right.

void pci_remove_rom(struct pci_dev *dev);

Call this one from the driver to simply remove the ROM attribute.

Before the driver is loaded we have to assume that it safe to read the
ROM normally and the sysfs attribute will directly access the ROM.


unsigned char *pci_map_rom(struct pci_dev *dev, size_t *size);

For normal hardware that implements full decoding use this call. It
will automatically sort out the need to use the real ROM or a shadow
copy.

void pci_unmap_rom(struct pci_dev *dev, unsigned char *rom);

When you are done with a mapping use this

Normal ROMs do not make copies. The only time a copy happens is when a
device driver for a partially decoded device calls pci_map_rom_copy().

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
