Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTBYBRy>; Mon, 24 Feb 2003 20:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbTBYBQH>; Mon, 24 Feb 2003 20:16:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:272 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264940AbTBYBOD>;
	Mon, 24 Feb 2003 20:14:03 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135779999@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <10461357803594@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.12, 2003/02/24 16:32:16-08:00, greg@kroah.com

[PATCH] IBM PCI Hotplug: convert driver to use pci_bus_remove_device()

Also cleaned up a lot of unnecessary bus walking on device startup
and shutdown.


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:15 2003
+++ b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:15 2003
@@ -781,141 +781,23 @@
 	debug ("%s -- exit\n", __FUNCTION__);
 }
 
-static int ibm_unconfigure_visit_pci_dev_phase2 (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-	struct pci_func *temp_func;
-	int i = 0;
-
-	do {
-		temp_func = ibm_slot_find (dev->bus->number, dev->devfn >> 3, i++);
-	} while (temp_func && (temp_func->function != (dev->devfn & 0x07)));
-
-	if (dev) {
-		if (pci_remove_device_safe(dev) == 0)
-			kfree (dev);    /* Now, remove */
-		else
-			return -1;
-	}
-
-	if (temp_func)
-		temp_func->dev = NULL;
-	else
-		debug ("No pci_func representation for bus, devfn = %d, %x\n", dev->bus->number, dev->devfn);
-
-	return 0;
-}
-
-static int ibm_unconfigure_visit_pci_bus_phase2 (struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_dev)
-{
-	struct pci_bus *bus = wrapped_bus->bus;
-
-	pci_proc_detach_bus (bus);
-	/* The cleanup code should live in the kernel... */
-	bus->self->subordinate = NULL;
-	/* unlink from parent bus */
-	list_del (&bus->node);
-
-	/* Now, remove */
-	if (bus)
-		kfree (bus);
-
-	return 0;
-}
-
-static int ibm_unconfigure_visit_pci_dev_phase1 (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-
-	debug ("attempting removal of driver for device (%x, %x, %x)\n", dev->bus->number, PCI_SLOT (dev->devfn), PCI_FUNC (dev->devfn));
-
-	/* Now, remove the Linux Driver Representation */
-	if (dev->driver) {
-		debug ("is there a driver?\n");
-		if (dev->driver->remove) {
-			dev->driver->remove (dev);
-			debug ("driver was properly removed\n");
-		}
-		dev->driver = NULL;
-	}
-
-	return (pci_dev_driver(dev) != NULL);
-}
-
-static struct pci_visit ibm_unconfigure_functions_phase1 = {
-	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase1,
-};
-
-static struct pci_visit ibm_unconfigure_functions_phase2 = {
-	.post_visit_pci_bus =	ibm_unconfigure_visit_pci_bus_phase2,
-	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase2,
-};
-
 static int ibm_unconfigure_device (struct pci_func *func)
 {
-	int rc = 0;
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
 	struct pci_dev *temp;
 	u8 j;
 
-	memset (&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
-	memset (&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
-
-	debug ("inside ibm_unconfigure_device\n");
+	debug ("inside %s\n", __FUNCTION__);
 	debug ("func->device = %x, func->function = %x\n", func->device, func->function);
 	debug ("func->device << 3 | 0x0  = %x\n", func->device << 3 | 0x0);
 
 	for (j = 0; j < 0x08; j++) {
 		temp = pci_find_slot (func->busno, (func->device << 3) | j);
-		if (temp) {
-			wrapped_dev.dev = temp;
-			wrapped_bus.bus = temp->bus;
-			rc = pci_visit_dev (&ibm_unconfigure_functions_phase1, &wrapped_dev, &wrapped_bus);
-			if (rc)
-				break;
-
-			rc = pci_visit_dev (&ibm_unconfigure_functions_phase2, &wrapped_dev, &wrapped_bus);
-			if (rc)
-				break;
-		}
+		if (temp)
+			pci_remove_bus_device(temp);
 	}
-	debug ("rc in ibm_unconfigure_device b4 returning is %d \n", rc);
-	return rc;
-}
-
-static int configure_visit_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	//      struct pci_bus *bus = wrapped_bus->bus; /* We don't need this, since we don't create in the else statement */
-	struct pci_dev *dev = wrapped_dev->dev;
-	struct pci_func *temp_func;
-	int i = 0;
-
-	do {
-		temp_func = ibm_slot_find (dev->bus->number, dev->devfn >> 3, i++);
-	} while (temp_func && (temp_func->function != (dev->devfn & 0x07)));
-
-	if (temp_func)
-		temp_func->dev = dev;
-	else {
-		/* This should not really happen, since we create functions
-		   first and then call to configure */
-		debug (" We shouldn't come here \n");
-	}
-
-	if (temp_func->dev) {
-//		pci_proc_attach_device (temp_func->dev);
-//		pci_announce_device_to_drivers (temp_func->dev);
-	}
-
 	return 0;
 }
 
-static struct pci_visit configure_functions = {
-	.visit_pci_dev =configure_visit_pci_dev,
-};
-
-
 /*
  * The following function is to fix kernel bug regarding 
  * getting bus entries, here we manually add those primary 
@@ -965,15 +847,9 @@
 	unsigned char bus;
 	struct pci_dev dev0;
 	struct pci_bus *child;
-	struct pci_dev *temp;
 	int rc = 0;
 	int flag = 0;	/* this is to make sure we don't double scan the bus, for bridged devices primarily */
 
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
-
-	memset (&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
-	memset (&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
 	memset (&dev0, 0, sizeof (struct pci_dev));
 
 	if (!(bus_structure_fixup (func->busno)))
@@ -1001,12 +877,6 @@
 		pci_do_scan_bus (child);
 	}
 
-	temp = func->dev;
-	if (temp) {
-		wrapped_dev.dev = temp;
-		wrapped_bus.bus = temp->bus;
-		rc = pci_visit_dev (&configure_functions, &wrapped_dev, &wrapped_bus);
-	}
 	return rc;
 }
 

