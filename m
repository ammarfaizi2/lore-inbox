Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTEFWxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEFWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:52:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64429 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262030AbTEFWwm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624132703@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624131454@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1081, 2003/05/06 15:34:00-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix up the compaq driver to work properly again.


 drivers/hotplug/cpqphp_pci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Tue May  6 15:56:03 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Tue May  6 15:56:03 2003
@@ -85,19 +85,20 @@
 {
 	unsigned char bus;
 	struct pci_bus *child;
-	int rc = 0;
+	int num;
 
 	if (func->pci_dev == NULL)
-		func->pci_dev = pci_find_slot(func->bus, (func->device << 3) | (func->function & 0x7));
+		func->pci_dev = pci_find_slot(func->bus, PCI_DEVFN(func->device, func->function));
 
-	//Still NULL ? Well then scan for it !
+	/* No pci device, we need to create it then */
 	if (func->pci_dev == NULL) {
 		dbg("INFO: pci_dev still null\n");
 
-		//this will generate pci_dev structures for all functions, but we will only call this case when lookup fails
-		func->pci_dev = pci_scan_slot(ctrl->pci_dev->bus,
-				 (func->device << 3) + (func->function & 0x7));
+		num = pci_scan_slot(ctrl->pci_dev->bus, PCI_DEVFN(func->device, func->function));
+		if (num)
+			pci_bus_add_devices(ctrl->pci_dev->bus);
 
+		func->pci_dev = pci_find_slot(func->bus, PCI_DEVFN(func->device, func->function));
 		if (func->pci_dev == NULL) {
 			dbg("ERROR: pci_dev still null\n");
 			return 0;
@@ -108,10 +109,9 @@
 		pci_read_config_byte(func->pci_dev, PCI_SECONDARY_BUS, &bus);
 		child = (struct pci_bus*) pci_add_new_bus(func->pci_dev->bus, (func->pci_dev), bus);
 		pci_do_scan_bus(child);
-
 	}
 
-	return rc;
+	return 0;
 }
 
 

