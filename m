Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUHYPDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUHYPDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUHYPDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:03:41 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:30945 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267184AbUHYPDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:03:36 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ioc3-eth.c: add missing pci_enable_device()
Date: Wed, 25 Aug 2004 09:03:27 -0600
User-Agent: KMail/1.6.2
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408242225.i7OMPGLQ029847@hera.kernel.org> <412BE006.8040606@pobox.com>
In-Reply-To: <412BE006.8040606@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408250903.28133.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 August 2004 6:40 pm, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.1843.1.74, 2004/08/24 11:21:53-07:00, bjorn.helgaas@hp.com
> > 
> > 	[PATCH] ioc3-eth.c: add missing pci_enable_device()
> > 	
> > 	Add pci_enable_device()/pci_disable_device().  In the past, drivers often
> > 	worked without this, but it is now required in order to route PCI interrupts
> > 	correctly.
> > 	
> > 	Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> > 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

> I don't see a "signed-off-by" line from Ralf.  I noticed you never 
> bothered to send this patch to me.  Did you send it to Ralf either?

As a matter of fact, I did send it to Ralf, based on this:

	IOC3 DRIVER
	P:      Ralf Baechle
	M:      ralf@linux-mips.org
	L:      linux-mips@linux-mips.org
	S:      Maintained

Once I found the specific IOC3 entry, I neglected to search farther
and find the more generic "NETWORK DEVICE DRIVERS" entry, so I didn't
send it to you, Jeff; sorry about that.

> ioc3 is _very_ strange device and not fully compliant to the PCI spec.

OK, I don't know anything about ioc3, other than the fact that it
appeared to use pci_dev->irq without doing pci_enable_device().
All ACPI-based PCI interrupt routing is now done in pci_enable_device()
(in -mm, not yet in mainline), so if ioc3 were used in an ACPI-based
system, it would likely be broken.

I'm fine with reverting the change.  Here's a patch to do that:


Revert addition of pci_enable_device().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/ioc3-eth.c 1.27 vs edited =====
--- 1.27/drivers/net/ioc3-eth.c	2004-08-24 03:08:34 -06:00
+++ edited/drivers/net/ioc3-eth.c	2004-08-25 08:56:24 -06:00
@@ -1172,14 +1172,9 @@
 	u32 vendor, model, rev;
 	int err;
 
-	if (pci_enable_device(pdev))
-		return -ENODEV;
-
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
-	if (!dev) {
-		err = -ENOMEM;
-		goto out_disable;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	err = pci_request_regions(pdev, "ioc3");
 	if (err)
@@ -1274,8 +1269,6 @@
 	pci_release_regions(pdev);
 out_free:
 	free_netdev(dev);
-out_disable:
-	pci_disable_device(pdev);
 	return err;
 }
 
@@ -1289,7 +1282,6 @@
 	iounmap(ioc3);
 	pci_release_regions(pdev);
 	free_netdev(dev);
-	pci_disable_device(pdev);
 }
 
 static struct pci_device_id ioc3_pci_tbl[] = {
