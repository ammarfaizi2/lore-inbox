Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTEMLJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTEMLJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:09:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:23308 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263506AbTEMLJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:09:10 -0400
Date: Tue, 13 May 2003 15:21:26 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Message Signalled Interrupt support?
Message-ID: <20030513152126.A16419@jurassic.park.msu.ru>
References: <20030512163249.GF27111@gtf.org> <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk> <20030512104300.A23510@home.com> <20030512182023.GA29534@parcelfarce.linux.theplanet.co.uk> <20030512114851.B23510@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030512114851.B23510@home.com>; from mporter@kernel.crashing.org on Mon, May 12, 2003 at 11:48:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:48:51AM -0700, Matt Porter wrote:
> request_msi() needs an additional parameter to specify which MSI
> it is hooking.  A device can implement many messages in order to
> clarify which one of many events on a device has occurred.  It
> may be desired to hook a separate handler for each of those to
> avoid another read of a status register.

Assuming that platform specific PCI setup does reasonable real to virtual
IRQ mapping, request_msi() is not needed. We can use pdev->irq
as "base" vector and MSI message number as offset. Alpha works this
way, BTW.

I think of something like this:
/**
 * pci_using_msi - is this PCI device configured to use MSI?
 * @dev: PCI device structure of device being queried
 *
 * Tells whether or not a PCI device is configured to use Message Signaled
 * Interrupts. Returns number of allocated MSI messages, else 0.
 */
int
pci_using_msi(struct pci_dev *dev)
{
	int msi = pci_find_capability(dev, PCI_CAP_ID_MSI);
	u8 msgctl;

	if (!msi || !dev->irq)
		return 0;

	pci_read_config_byte(dev, msi + PCI_MSI_FLAGS, &msgctl);

	if (!(msgctl & PCI_MSI_FLAGS_ENABLE))
		return 0;
	
	return 1 << ((msgctl >> 4) & 7); /* # of messages allocated */
}

So that MSI-aware driver can do

	nummsgs = pci_using_msi(dev);
	if (!nummsgs)
		goto no_msi;
	for (msg = 0; msg < nummsgs; msg++) {
		...
		request_irq(dev->irq + msg, ...);
	}

Ivan.
