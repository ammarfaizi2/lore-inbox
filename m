Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUG3Vxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUG3Vxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267855AbUG3Vxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:53:35 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:18521 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267701AbUG3Vx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:53:26 -0400
Message-ID: <20040730215325.98365.qmail@web14922.mail.yahoo.com>
Date: Fri, 30 Jul 2004 14:53:25 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <20040730212930.GA30979@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another grungy thing I needed to do to PCI. Multi-headed video
cards don't really implement independent PCI devices even though they
look like independent devices. I've heard that this behavior is needed
for MS Windows compatibility.

I'm missing a PCI call to claim ownership for the secondary device
without also causing a second instance of my driver to be loaded.
Here's the code I'm using, what's the right way to do this?

struct pci_dev *secondary;
/* check the next function on the same card */
secondary = pci_find_slot(dev->pdev->bus->number, dev->pdev->devfn +
1);
if (secondary) {
	/* check if class is secondary video */
	if (secondary->class == 0x038000) {
		DRM_DEBUG("registering secondary video head\n");
		/* This code is need to bind the driver to the secondary device */
		/* There is no direct pci call to do this, there should be one */
		secondary->dev.driver = dev->pdev->dev.driver;
		device_bind_driver(&secondary->dev);
		/* dev->pdev->driver is not filled until after probe completes */
		secondary->driver = to_pci_driver(dev->pdev->dev.driver);
		pci_dev_get(secondary);
	}
}

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
