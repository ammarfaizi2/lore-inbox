Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUCSXcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUCSXcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:32:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:32463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263143AbUCSXcU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:20 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <10797391322645@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:12 -0800
Message-Id: <10797391322846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.6, 2004/03/19 14:08:16-08:00, willy@debian.org

[PATCH] PCI: Use insert_resource in pci_claim_resource

On ia64, the parent resources are not necessarily PCI resources and
so won't get found by pci_find_parent_resource.  Use the shiny new
insert_resource() function instead, which I think we would have used
here had it been available at the time.


 drivers/pci/setup-res.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Fri Mar 19 15:21:11 2004
+++ b/drivers/pci/setup-res.c	Fri Mar 19 15:21:11 2004
@@ -94,13 +94,18 @@
 pci_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];
-	struct resource *root = pci_find_parent_resource(dev, res);
+	struct resource *root = NULL;
 	char *dtype = resource < PCI_BRIDGE_RESOURCES ? "device" : "bridge";
 	int err;
 
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
 	err = -EINVAL;
 	if (root != NULL)
-		err = request_resource(root, res);
+		err = insert_resource(root, res);
 
 	if (err) {
 		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",

