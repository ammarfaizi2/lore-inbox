Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTEFWxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTEFWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:52:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64173 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262029AbTEFWwm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624133520@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624132703@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1082, 2003/05/06 15:35:23-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix up the ibm driver to work properly again.


 drivers/hotplug/ibmphp_core.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Tue May  6 15:55:58 2003
+++ b/drivers/hotplug/ibmphp_core.c	Tue May  6 15:55:58 2003
@@ -846,22 +846,24 @@
 {
 	unsigned char bus;
 	struct pci_bus *child;
-	int rc = 0;
+	int num;
 	int flag = 0;	/* this is to make sure we don't double scan the bus, for bridged devices primarily */
 
 	if (!(bus_structure_fixup (func->busno)))
 		flag = 1;
 	if (func->dev == NULL)
-		func->dev = pci_find_slot (func->busno, (func->device << 3) | (func->function & 0x7));
+		func->dev = pci_find_slot (func->busno, PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
 		struct pci_bus *bus = ibmphp_find_bus (func->busno);
 		if (!bus)
 			return 0;
 
-		func->dev = pci_scan_slot(bus,
-				 (func->device << 3) + (func->function & 0x7));
+		num = pci_scan_slot(bus, PCI_DEVFN(func->device, func->function));
+		if (num)
+			pci_bus_add_devices(bus);
 
+		func->dev = pci_find_slot(func->busno, PCI_DEVFN(func->device, func->function));
 		if (func->dev == NULL) {
 			err ("ERROR... : pci_dev still NULL \n");
 			return 0;
@@ -873,7 +875,7 @@
 		pci_do_scan_bus (child);
 	}
 
-	return rc;
+	return 0;
 }
 
 /*******************************************************

