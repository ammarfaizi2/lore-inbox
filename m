Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVAJRYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVAJRYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAJRYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:24:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29588 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262362AbVAJRVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:07 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776573462@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <11053776573816@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.6, 2004/12/16 16:14:27-08:00, matthew@wil.cx

[PATCH] PCI: cope with duplicate bus numbers better

Make pci_scan_bridge() a little more robust in the presence of broken
firmware.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-10 09:04:01 -08:00
+++ b/drivers/pci/probe.c	2005-01-10 09:04:01 -08:00
@@ -375,6 +375,17 @@
 		if (pass)
 			return max;
 		busnr = (buses >> 8) & 0xFF;
+
+		/*
+		 * If we already got to this bus through a different bridge,
+		 * ignore it.  This can happen with the i450NX chipset.
+		 */
+		if (pci_find_bus(pci_domain_nr(bus), busnr)) {
+			printk(KERN_INFO "PCI: Bus %04x:%02x already known\n",
+					pci_domain_nr(bus), busnr);
+			return max;
+		}
+
 		child = pci_alloc_child_bus(bus, dev, busnr);
 		if (!child)
 			return max;
@@ -785,7 +796,7 @@
 
 	if (pci_find_bus(pci_domain_nr(b), bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
-		DBG("PCI: Bus %02x already known\n", bus);
+		DBG("PCI: Bus %04:%02x already known\n", pci_domain_nr(b), bus);
 		goto err_out;
 	}
 	list_add_tail(&b->node, &pci_root_buses);

