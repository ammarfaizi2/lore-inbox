Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUKSWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUKSWAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUKSV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:58:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:30615 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261623AbUKSV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:57:34 -0500
Date: Fri, 19 Nov 2004 13:57:00 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc2
Message-ID: <20041119215659.GC15863@kroah.com>
References: <20041119215618.GA15863@kroah.com> <20041119215640.GB15863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119215640.GB15863@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2165, 2004/11/19 10:02:07-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: clean up rpaphp_pci.c::rpaphp_find_pci_dev

this patch improves rpaphp_find_pci_dev. First it uses the for_each_pci_dev
macro instead of the while loop, making this hotplug safe (which is a good
idea in a hotplug driver, isn't it?). Then it removes retval_dev. retval_dev
is set to the found device when something is found, NULL otherwise. If
nothing is found dev will be NULL at the end of the loop anyway and the
found device if we found something, no need for retval_dev then. And a very
small coding style fix.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp_pci.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-11-19 13:20:10 -08:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-11-19 13:20:10 -08:00
@@ -31,18 +31,17 @@
 
 struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn)
 {
-	struct pci_dev *retval_dev = NULL, *dev = NULL;
+	struct pci_dev *dev = NULL;
 	char bus_id[BUS_ID_SIZE];
 
-	sprintf(bus_id, "%04x:%02x:%02x.%d",dn->phb->global_number,
+	sprintf(bus_id, "%04x:%02x:%02x.%d", dn->phb->global_number,
 		dn->busno, PCI_SLOT(dn->devfn), PCI_FUNC(dn->devfn));
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		if (!strcmp(pci_name(dev), bus_id)) {
-			retval_dev = dev;
 			break;
 		}
 	}
-	return retval_dev;
+	return dev;
 }
 
 EXPORT_SYMBOL_GPL(rpaphp_find_pci_dev);
