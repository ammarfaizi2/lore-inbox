Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTBYBRw>; Mon, 24 Feb 2003 20:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBYBQU>; Mon, 24 Feb 2003 20:16:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2064 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264984AbTBYBOE>;
	Mon, 24 Feb 2003 20:14:04 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135780408@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <10461357813436@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.14, 2003/02/24 16:35:48-08:00, greg@kroah.com

[PATCH] CPCI core: remove unneeded visit device on unconfigure.

The driver now links properly, but this is untested due to my
lack of cPCI hardware.


diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotplug_pci.c
--- a/drivers/hotplug/cpci_hotplug_pci.c	Mon Feb 24 17:15:06 2003
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Mon Feb 24 17:15:06 2003
@@ -483,29 +483,6 @@
 	return 0;
 }
 
-static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrapped_dev,
-				 struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-
-	dbg("%s - enter", __FUNCTION__);
-
-	dbg("attempting removal of driver for device %02x:%02x.%x",
-	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-
-	/* Now, remove the Linux Driver representation */
-	if(dev->driver) {
-		dbg("device is attached to a driver");
-		if(dev->driver->remove) {
-			dev->driver->remove(dev);
-			dbg("driver was removed");
-		}
-		dev->driver = NULL;
-	}
-	dbg("%s - exit", __FUNCTION__);
-	return pci_is_dev_in_use(dev);
-}
-
 static int unconfigure_visit_pci_dev_phase2(struct pci_dev_wrapped *wrapped_dev,
 					    struct pci_bus_wrapped *wrapped_bus)
 {
@@ -577,10 +554,6 @@
 	.visit_pci_dev = configure_visit_pci_dev,
 };
 
-static struct pci_visit unconfigure_functions_phase1 = {
-	.post_visit_pci_dev = unconfigure_visit_pci_dev_phase1
-};
-
 static struct pci_visit unconfigure_functions_phase2 = {
 	.post_visit_pci_bus = unconfigure_visit_pci_bus_phase2,
 	.post_visit_pci_dev = unconfigure_visit_pci_dev_phase2
@@ -668,13 +641,6 @@
 		if(dev) {
 			wrapped_dev.dev = dev;
 			wrapped_bus.bus = dev->bus;
-			dbg("%s - unconfigure phase 1", __FUNCTION__);
-			rc = pci_visit_dev(&unconfigure_functions_phase1,
-					   &wrapped_dev, &wrapped_bus);
-			if(rc) {
-				break;
-			}
-
 			dbg("%s - unconfigure phase 2", __FUNCTION__);
 			rc = pci_visit_dev(&unconfigure_functions_phase2,
 					   &wrapped_dev, &wrapped_bus);

