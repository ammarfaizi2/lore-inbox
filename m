Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBYBPg>; Mon, 24 Feb 2003 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbTBYBPI>; Mon, 24 Feb 2003 20:15:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58639 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264820AbTBYBNr>;
	Mon, 24 Feb 2003 20:13:47 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <10461357631881@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135763287@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.7, 2003/02/24 16:27:59-08:00, hch@lst.de

[PATCH] PCI: remove check_region abuse (and code duplication) from pci hp code

We have a function pci_dev_driver() to check whether a pci_dev has an
driver attached to it.  It's handling of legacy devices is a bit simpler
than what the hotplug code did (duplicated in various places), but if
that stuff is really needed the generic code should be updated.


diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Mon Feb 24 17:15:37 2003
+++ b/drivers/hotplug/acpiphp_pci.c	Mon Feb 24 17:15:37 2003
@@ -217,47 +217,6 @@
 	return 0;
 }
 
-
-static int is_pci_dev_in_use (struct pci_dev* dev)
-{
-	/*
-	 * dev->driver will be set if the device is in use by a new-style
-	 * driver -- otherwise, check the device's regions to see if any
-	 * driver has claimed them
-	 */
-
-	int i, inuse=0;
-
-	if (dev->driver) return 1; //assume driver feels responsible
-
-	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
-		if (!pci_resource_start(dev, i))
-			continue;
-
-		if (pci_resource_flags(dev, i) & IORESOURCE_IO)
-			inuse = check_region(pci_resource_start(dev, i),
-					     pci_resource_len(dev, i));
-		else if (pci_resource_flags(dev, i) & IORESOURCE_MEM)
-			inuse = check_mem_region(pci_resource_start(dev, i),
-						 pci_resource_len(dev, i));
-	}
-
-	return inuse;
-}
-
-
-static int pci_hp_remove_device (struct pci_dev *dev)
-{
-	if (is_pci_dev_in_use(dev)) {
-		err("***Cannot safely power down device -- "
-		       "it appears to be in use***\n");
-		return -EBUSY;
-	}
-	pci_remove_device(dev);
-	return 0;
-}
-
-
 /* remove device driver */
 static int unconfigure_pci_dev_driver (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
 {
@@ -274,7 +233,7 @@
 		dev->driver = NULL;
 	}
 
-	return is_pci_dev_in_use(dev);
+	return (pci_dev_driver(dev) != NULL);
 }
 
 
@@ -285,7 +244,7 @@
 
 	/* Now, remove the Linux Representation */
 	if (dev) {
-		if (pci_hp_remove_device(dev) == 0) {
+		if (pci_remove_device_safe(dev) == 0) {
 			info("Device %s removed\n", dev->slot_name);
 			kfree(dev); /* Now, remove */
 		} else {
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:37 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Mon Feb 24 17:15:37 2003
@@ -44,48 +44,6 @@
 
 static u16 unused_IRQ;
 
-
-static int is_pci_dev_in_use(struct pci_dev* dev) 
-{
-	/* 
-	 * dev->driver will be set if the device is in use by a new-style 
-	 * driver -- otherwise, check the device's regions to see if any
-	 * driver has claimed them
-	 */
-
-	int i, inuse=0;
-
-	if (dev->driver) return 1; //assume driver feels responsible
-
-	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
-		if (!pci_resource_start(dev, i))
-			continue;
-
-		if (pci_resource_flags(dev, i) & IORESOURCE_IO)
-			inuse = check_region(pci_resource_start(dev, i),
-					     pci_resource_len(dev, i));
-		else if (pci_resource_flags(dev, i) & IORESOURCE_MEM)
-			inuse = check_mem_region(pci_resource_start(dev, i),
-						 pci_resource_len(dev, i));
-	}
-
-	return inuse;
-
-}
-
-
-static int pci_hp_remove_device(struct pci_dev *dev)
-{
-	if (is_pci_dev_in_use(dev)) {
-		err("***Cannot safely power down device -- "
-		       "it appears to be in use***\n");
-		return -EBUSY;
-	}
-	pci_remove_device(dev);
-	return 0;
-}
-
-
 /*
  * detect_HRT_floating_pointer
  *
@@ -176,7 +134,7 @@
 
 	//Now, remove the Linux Representation
 	if (dev) {
-		if (pci_hp_remove_device(dev) == 0) {
+		if (pci_remove_device_safe(dev) == 0) {
 			kfree(dev); //Now, remove
 		} else {
 			return -1; // problems while freeing, abort visitation
@@ -228,7 +186,7 @@
 		dev->driver = NULL;
 	}
 
-	return is_pci_dev_in_use(dev);
+	return (pci_dev_driver(dev) != NULL);
 }
 
 
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:37 2003
+++ b/drivers/hotplug/ibmphp_core.c	Mon Feb 24 17:15:37 2003
@@ -781,39 +781,6 @@
 	debug ("%s -- exit\n", __FUNCTION__);
 }
 
-static int ibm_is_pci_dev_in_use (struct pci_dev *dev)
-{
-	int i = 0;
-	int inuse = 0;
-
-	if (dev->driver)
-		return 1;
-
-	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
-
-		if (!pci_resource_start (dev, i))
-			continue;
-
-		if (pci_resource_flags (dev, i) & IORESOURCE_IO)
-			inuse = check_region (pci_resource_start (dev, i), pci_resource_len (dev, i));
-
-		else if (pci_resource_flags (dev, i) & IORESOURCE_MEM)
-			inuse = check_mem_region (pci_resource_start (dev, i), pci_resource_len (dev, i));
-	}
-
-	return inuse;
-}
-
-static int ibm_pci_hp_remove_device (struct pci_dev *dev)
-{
-	if (ibm_is_pci_dev_in_use (dev)) {
-		err ("***Cannot safely power down device -- it appears to be in use***\n");
-		return -EBUSY;
-	}
-	pci_remove_device (dev);
-	return 0;
-}
-
 static int ibm_unconfigure_visit_pci_dev_phase2 (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
 {
 	struct pci_dev *dev = wrapped_dev->dev;
@@ -825,7 +792,7 @@
 	} while (temp_func && (temp_func->function != (dev->devfn & 0x07)));
 
 	if (dev) {
-		if (ibm_pci_hp_remove_device (dev) == 0)
+		if (pci_remove_device_safe(dev) == 0)
 			kfree (dev);    /* Now, remove */
 		else
 			return -1;
@@ -872,7 +839,7 @@
 		dev->driver = NULL;
 	}
 
-	return ibm_is_pci_dev_in_use (dev);
+	return (pci_dev_driver(dev) != NULL);
 }
 
 static struct pci_visit ibm_unconfigure_functions_phase1 = {
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Feb 24 17:15:37 2003
+++ b/include/linux/pci.h	Mon Feb 24 17:15:37 2003
@@ -692,7 +692,6 @@
 extern int pci_visit_dev(struct pci_visit *fn,
 			 struct pci_dev_wrapped *wrapped_dev,
 			 struct pci_bus_wrapped *wrapped_parent);
-extern int pci_is_dev_in_use(struct pci_dev *dev);
 extern int pci_remove_device_safe(struct pci_dev *dev);
 
 #endif /* CONFIG_PCI */

