Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTBYBP7>; Mon, 24 Feb 2003 20:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBYBPp>; Mon, 24 Feb 2003 20:15:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:64783 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264938AbTBYBOC>;
	Mon, 24 Feb 2003 20:14:02 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357782385@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135779999@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.11, 2003/02/24 16:31:00-08:00, greg@kroah.com

[PATCH] ACPI PCI hotplug: convert to use pci_remove_bus_device()

Also got rid of some unneeded bus walking on device init and shutdown.


diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Mon Feb 24 17:15:19 2003
+++ b/drivers/hotplug/acpiphp_pci.c	Mon Feb 24 17:15:19 2003
@@ -194,92 +194,6 @@
 	return 0;
 }
 
-
-/* enable pci_dev */
-static int configure_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	struct acpiphp_func *func;
-	struct acpiphp_bridge *bridge;
-	struct pci_dev *dev;
-
-	func = (struct acpiphp_func *)wrapped_dev->data;
-	bridge = (struct acpiphp_bridge *)wrapped_bus->data;
-	dev = wrapped_dev->dev;
-
-	/* TBD: support PCI-to-PCI bridge case */
-	if (!func || !bridge)
-		return 0;
-
-	//pci_proc_attach_device(dev);
-	//pci_announce_device_to_drivers(dev);
-	info("Device %s configured\n", dev->slot_name);
-
-	return 0;
-}
-
-/* remove device driver */
-static int unconfigure_pci_dev_driver (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-
-	dbg("attempting removal of driver for device %s\n", dev->slot_name);
-
-	/* Now, remove the Linux Driver Representation */
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
-/* remove pci_dev itself from system */
-static int unconfigure_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-
-	/* Now, remove the Linux Representation */
-	if (dev) {
-		if (pci_remove_device_safe(dev) == 0) {
-			info("Device %s removed\n", dev->slot_name);
-			kfree(dev); /* Now, remove */
-		} else {
-			return -1; /* problems while freeing, abort visitation */
-		}
-	}
-
-	return 0;
-}
-
-
-/* remove pci_bus itself from system */
-static int unconfigure_pci_bus (struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_dev)
-{
-	struct pci_bus *bus = wrapped_bus->bus;
-
-#ifdef CONFIG_PROC_FS
-	/* Now, remove the Linux Representation */
-	if (bus->procdir) {
-		pci_proc_detach_bus(bus);
-	}
-#endif
-	/* the cleanup code should live in the kernel ... */
-	bus->self->subordinate = NULL;
-	/* unlink from parent bus */
-	list_del(&bus->node);
-
-	/* Now, remove */
-	if (bus)
-		kfree(bus);
-
-	return 0;
-}
-
-
 /* detect_used_resource - subtract resource under dev from bridge */
 static int detect_used_resource (struct acpiphp_bridge *bridge, struct pci_dev *dev)
 {
@@ -551,22 +465,6 @@
 	return retval;
 }
 
-
-/* for pci_visit_dev() */
-static struct pci_visit configure_functions = {
-	.post_visit_pci_dev =	configure_pci_dev
-};
-
-static struct pci_visit unconfigure_functions_phase1 = {
-	.post_visit_pci_dev =	unconfigure_pci_dev_driver
-};
-
-static struct pci_visit unconfigure_functions_phase2 = {
-	.post_visit_pci_bus =	unconfigure_pci_bus,
-	.post_visit_pci_dev =	unconfigure_pci_dev
-};
-
-
 /**
  * acpiphp_configure_function - configure PCI function
  * @func: function to be configured
@@ -577,33 +475,10 @@
  */
 int acpiphp_configure_function (struct acpiphp_func *func)
 {
-	int retval = 0;
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
-	struct acpiphp_bridge *bridge;
-
-	/* if pci_dev is NULL, ignore it */
-	if (!func->pci_dev)
-		goto err_exit;
-
-	bridge = func->slot->bridge;
-
-	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-	wrapped_dev.dev = func->pci_dev;
-	wrapped_dev.data = func;
-	wrapped_bus.bus = bridge->pci_bus;
-	wrapped_bus.data = bridge;
-
-	retval = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
-	if (retval)
-		goto err_exit;
-
- err_exit:
-	return retval;
+	/* all handled by the pci core now */
+	return 0;
 }
 
-
 /**
  * acpiphp_unconfigure_function - unconfigure PCI function
  * @func: function to be unconfigured
@@ -612,28 +487,13 @@
 int acpiphp_unconfigure_function (struct acpiphp_func *func)
 {
 	struct acpiphp_bridge *bridge;
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
 	int retval = 0;
 
 	/* if pci_dev is NULL, ignore it */
 	if (!func->pci_dev)
 		goto err_exit;
 
-	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-	wrapped_dev.dev = func->pci_dev;
-	//wrapped_dev.data = func;
-	wrapped_bus.bus = func->slot->bridge->pci_bus;
-	//wrapped_bus.data = func->slot->bridge;
-
-	retval = pci_visit_dev(&unconfigure_functions_phase1, &wrapped_dev, &wrapped_bus);
-	if (retval)
-		goto err_exit;
-
-	retval = pci_visit_dev(&unconfigure_functions_phase2, &wrapped_dev, &wrapped_bus);
-	if (retval)
-		goto err_exit;
+	pci_remove_bus_device(func->pci_dev);
 
 	/* free all resources */
 	bridge = func->slot->bridge;

