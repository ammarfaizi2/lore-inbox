Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbTBYBPg>; Mon, 24 Feb 2003 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTBYBPX>; Mon, 24 Feb 2003 20:15:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61199 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264877AbTBYBOA>;
	Mon, 24 Feb 2003 20:14:00 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357663921@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135774520@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.9, 2003/02/24 16:29:53-08:00, greg@kroah.com

[PATCH] Compaq PCI Hotplug: convert to use pci_remove_bus_device instead of custom code.


diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:28 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:28 2003
@@ -117,94 +117,11 @@
 }
 
 
-static int unconfigure_visit_pci_dev_phase2 (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus) 
-{
-	struct pci_dev* dev = wrapped_dev->dev;
-
-	struct pci_func *temp_func;
-	int i=0;
-
-	//We need to remove the hotplug function representation with the linux representation
-	do {
-		temp_func = cpqhp_slot_find(dev->bus->number, dev->devfn >> 3, i++);
-		if (temp_func) {
-			dbg("temp_func->function = %d\n", temp_func->function);
-		}
-	} while (temp_func && (temp_func->function != (dev->devfn & 0x07)));
-
-	//Now, remove the Linux Representation
-	if (dev) {
-		if (pci_remove_device_safe(dev) == 0) {
-			kfree(dev); //Now, remove
-		} else {
-			return -1; // problems while freeing, abort visitation
-		}
-	}
-
-	if (temp_func) {
-		temp_func->pci_dev = NULL;
-	} else {
-		dbg("No pci_func representation for bus, devfn = %d, %x\n", dev->bus->number, dev->devfn);
-	}
-
-	return 0;
-}
-
-
-static int unconfigure_visit_pci_bus_phase2 (struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_dev) 
-{
-	struct pci_bus* bus = wrapped_bus->bus;
-
-	//The cleanup code for proc entries regarding buses should be in the kernel...
-	if (bus->procdir)
-		dbg("detach_pci_bus %s\n", bus->procdir->name);
-	pci_proc_detach_bus(bus);
-	// The cleanup code should live in the kernel...
-	bus->self->subordinate = NULL;
-	// unlink from parent bus
-	list_del(&bus->node);
-
-	// Now, remove
-	if (bus)
-		kfree(bus);
-
-	return 0;
-}
-
-
-static int unconfigure_visit_pci_dev_phase1 (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus) 
-{
-	struct pci_dev* dev = wrapped_dev->dev;
-
-	dbg("attempting removal of driver for device (%x, %x, %x)\n", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	//Now, remove the Linux Driver Representation 
-	if (dev->driver) {
-		if (dev->driver->remove) {
-			dev->driver->remove(dev);
-			dbg("driver was properly removed\n");
-		}
-		dev->driver = NULL;
-	}
-
-	return (pci_dev_driver(dev) != NULL);
-}
-
-
 static struct pci_visit configure_functions = {
 	.visit_pci_dev =	configure_visit_pci_dev,
 };
 
 
-static struct pci_visit unconfigure_functions_phase1 = {
-	.post_visit_pci_dev =	unconfigure_visit_pci_dev_phase1
-};
-
-static struct pci_visit unconfigure_functions_phase2 = {
-	.post_visit_pci_bus =	unconfigure_visit_pci_bus_phase2,               
-	.post_visit_pci_dev =	unconfigure_visit_pci_dev_phase2
-};
-
-
 int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)  
 {
 	unsigned char bus;
@@ -258,31 +175,16 @@
 
 int cpqhp_unconfigure_device(struct pci_func* func) 
 {
-	int rc = 0;
 	int j;
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
 	
-	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-
 	dbg("%s: bus/dev/func = %x/%x/%x\n", __FUNCTION__, func->bus, func->device, func->function);
 
 	for (j=0; j<8 ; j++) {
 		struct pci_dev* temp = pci_find_slot(func->bus, (func->device << 3) | j);
-		if (temp) {
-			wrapped_dev.dev = temp;
-			wrapped_bus.bus = temp->bus;
-			rc = pci_visit_dev(&unconfigure_functions_phase1, &wrapped_dev, &wrapped_bus);
-			if (rc)
-				break;
-
-			rc = pci_visit_dev(&unconfigure_functions_phase2, &wrapped_dev, &wrapped_bus);
-			if (rc)
-				break;
-		}
+		if (temp)
+			pci_remove_bus_device(temp);
 	}
-	return rc;
+	return 0;
 }
 
 static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)

