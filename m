Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUHYPYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUHYPYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUHYPYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:24:14 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:56295 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267827AbUHYPYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:24:06 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] hp100.c: add missing pci_enable_device()
Date: Wed, 25 Aug 2004 09:23:58 -0600
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, perex@suse.cz
References: <200408242225.i7OMP5ak029691@hera.kernel.org> <412BE04F.3050306@pobox.com>
In-Reply-To: <412BE04F.3050306@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408250923.58024.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 August 2004 6:41 pm, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
> > --- a/drivers/net/hp100.c	2004-08-24 15:25:16 -07:00
> > +++ b/drivers/net/hp100.c	2004-08-24 15:25:16 -07:00
> > @@ -2910,10 +2910,15 @@
> >  	int ioaddr = pci_resource_start(pdev, 0);
> >  	u_short pci_command;
> >  	int err;
> > -	
> > +
> >  	if (!dev)
> >  		return -ENOMEM;
> >  
> > +	if (pci_enable_device(pdev)) {
> 
> 
> _Obviously_ incomplete change.  Look above, and see pci_resource_start()

Thanks.  Here's an additional patch to address this problem (again,
compiled but not tested because I don't have the hardware):


Don't look at pci_resource_start() before pci_enable_device().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/hp100.c 1.29 vs edited =====
--- 1.29/drivers/net/hp100.c	2004-08-24 03:08:34 -06:00
+++ edited/drivers/net/hp100.c	2004-08-25 09:12:59 -06:00
@@ -2906,16 +2906,17 @@
 static int __devinit hp100_pci_probe (struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
-	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
-	int ioaddr = pci_resource_start(pdev, 0);
+	struct net_device *dev;
+	int ioaddr;
 	u_short pci_command;
 	int err;
 
-	if (!dev)
-		return -ENOMEM;
+	if (pci_enable_device(pdev))
+		return -ENODEV;
 
-	if (pci_enable_device(pdev)) {
-		err = -ENODEV;
+	dev = alloc_etherdev(sizeof(struct hp100_private));
+	if (!dev) {
+		err = -ENOMEM;
 		goto out0;
 	}
 
@@ -2939,7 +2940,7 @@
 		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
 	}
 	
-
+	ioaddr = pci_resource_start(pdev, 0);
 	err = hp100_probe1(dev, ioaddr, HP100_BUS_PCI, pdev);
 	if (err) 
 		goto out1;
@@ -2956,8 +2957,8 @@
 	release_region(dev->base_addr, HP100_REGION_SIZE);
  out1:
 	free_netdev(dev);
-	pci_disable_device(pdev);
  out0:
+	pci_disable_device(pdev);
 	return err;
 }
 
