Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUCRX4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUCRXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:55:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263334AbUCRXwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:52:21 -0500
Date: Thu, 18 Mar 2004 23:52:17 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [2/3] Use insert_resource in pci_claim_resource
Message-ID: <20040318235217.GJ25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On ia64, the parent resources are not necessarily PCI resources and
so won't get found by pci_find_parent_resource.  Use the shiny new
insert_resource() function instead, which I think we would have used
here had it been available at the time.

Index: drivers/pci/setup-res.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/setup-res.c,v
retrieving revision 1.7
diff -u -p -r1.7 setup-res.c
--- a/drivers/pci/setup-res.c	10 Mar 2004 02:27:48 -0000	1.7
+++ b/drivers/pci/setup-res.c	18 Mar 2004 23:40:56 -0000
@@ -94,13 +94,18 @@ int __init
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

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
