Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTBYBPi>; Mon, 24 Feb 2003 20:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTBYBP2>; Mon, 24 Feb 2003 20:15:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:63247 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264931AbTBYBOC>;
	Mon, 24 Feb 2003 20:14:02 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135774520@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <10461357782385@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.10, 2003/02/24 16:30:40-08:00, greg@kroah.com

[PATCH] Compaq PCI Hotplug: remove unused walk of the device on insertion.


diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:24 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:24 2003
@@ -80,61 +80,14 @@
 	return fp;
 }
 
-static int configure_visit_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus) 
-{
-	struct pci_bus* bus = wrapped_bus->bus;
-	struct pci_dev* dev = wrapped_dev->dev;
-	struct pci_func *temp_func;
-	int i=0;
-
-	//We need to fix up the hotplug function representation with the linux representation
-	do {
-		temp_func = cpqhp_slot_find(dev->bus->number, dev->devfn >> 3, i++);
-	} while (temp_func && (temp_func->function != (dev->devfn & 0x07)));
-
-	if (temp_func) {
-		temp_func->pci_dev = dev;
-	} else {
-		//We did not even find a hotplug rep of the function, create it
-		//This code might be taken out if we can guarantee the creation of functions
-		//in parallel (hotplug and Linux at the same time).
-		dbg("@@@@@@@@@@@ cpqhp_slot_create in %s\n", __FUNCTION__);
-		temp_func = cpqhp_slot_create(bus->number);
-		if (temp_func == NULL)
-			return -ENOMEM;
-		temp_func->pci_dev = dev;
-	}
-
-	//Create /proc/bus/pci proc entry for this device and bus device is on
-	//Notify the drivers of the change
-	if (temp_func->pci_dev) {
-//		pci_insert_device (temp_func->pci_dev, bus);
-//		pci_proc_attach_device(temp_func->pci_dev);
-//		pci_announce_device_to_drivers(temp_func->pci_dev);
-	}
-
-	return 0;
-}
-
-
-static struct pci_visit configure_functions = {
-	.visit_pci_dev =	configure_visit_pci_dev,
-};
-
 
 int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)  
 {
 	unsigned char bus;
 	struct pci_dev dev0;
 	struct pci_bus *child;
-	struct pci_dev* temp;
 	int rc = 0;
 
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
-	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-
 	memset(&dev0, 0, sizeof(struct pci_dev));
 
 	if (func->pci_dev == NULL)
@@ -162,13 +115,6 @@
 
 	}
 
-	temp = func->pci_dev;
-
-	if (temp) {
-		wrapped_dev.dev = temp;
-		wrapped_bus.bus = temp->bus;
-		rc = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
-	}
 	return rc;
 }
 

