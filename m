Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbSKPRxI>; Sat, 16 Nov 2002 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbSKPRxH>; Sat, 16 Nov 2002 12:53:07 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:31998 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267321AbSKPRxA>; Sat, 16 Nov 2002 12:53:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: Arnd Bergmann <ibm.com@arndb.de>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: [RFC][PATCH] move dma_mask into struct device
Date: Sat, 16 Nov 2002 20:56:54 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>,
       Mike Anderson <andmike@us.ibm.com>
References: <200211161701.gAGH1xF03711@localhost.localdomain>
In-Reply-To: <200211161701.gAGH1xF03711@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211162056.54008.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 18:01, J.E.J. Bottomley wrote:

> However, in order to divorce DMA from the
> PCI bus, it has to be obtainable from the generic device, without requiring
> knowledge of the bus.  In OO terms, it would be in a dmaable_device which
> inherits from device, but for expediency in layering all this into the
> kernel means I'd have to break almost every driver and introduce them to
> the concept of
> dmaable_device, so it's just easier to expand device by a pointer.

The Scsi_Host is already derived from struct device and since you need the 
dma_mask only for Scsi_Host, there is no need to expand the base class.

You can easily keep out the pci stuff if you do something like
this:

static inline void scsi_set_device(struct Scsi_Host *shost,
                                   struct device *dev)
{
        shost->dev = dev;
        shost->host_driverfs_dev.parent = dev;
}

static inline void scsi_set_pci_device(struct Scsi_Host *shost,
                                       struct pci_dev *pdev)
{
	scsi_set_device(shost, &pdev->dev);
	shost->dma_mask = pdev->dma_mask;
}

static inline void scsi_set_foobus_device(struct Scsi_Host *shost,
					  struct foo_dev *fdev)
{
	scsi_set_device(shost, fdev->dev);
	shost->dma_mask = fdev->foo_dma_mask;
}

You can even avoid Scsi_Host::dev completely if you make its only
remaining user (scsi_ioctl_get_pci) use host_sysfs_dev->parent.bus_id
instead.

	Arnd <><
