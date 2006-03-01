Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWCATA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCATA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCATAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:00:25 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:56475 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932165AbWCATAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:00:24 -0500
Subject: [PATCH] move eeh_add_device_tree_late()
From: John Rose <johnrose@austin.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20060301175922.GX20175@ca-server1.us.oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com>
	 <20060301010249.GV20175@ca-server1.us.oracle.com>
	 <1141230954.19095.19.camel@sinatra.austin.ibm.com>
	 <20060301175922.GX20175@ca-server1.us.oracle.com>
Content-Type: text/plain
Message-Id: <1141239448.19095.28.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Mar 2006 12:57:28 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, you still left the EXPORT_SYMBOL(eeh_add_device_late) and you didn't
> make eeh_add_device_late() static. Shouldn't you do that if you don't want
> to make it accessible outside of eeh.c?
> 	--Mark

Again, good points.  Ever have one of those days?  Take 2.

Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
function that calls eeh_add_device_late() implicitly.  This patch
reorders the two functions in question to fix the compile error.  This
might be preferable to exposing eeh_add_device_late() in eeh.h.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb arch/powerpc/platforms/pseries/eeh.c
--- 2_6_linus_3/arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb	2006-03-01 10:30:52.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/powerpc/platforms/pseries/eeh.c	2006-03-01 12:54:03.000000000 -0600
@@ -893,20 +893,6 @@ void eeh_add_device_tree_early(struct de
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 
-void eeh_add_device_tree_late(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
- 		eeh_add_device_late(dev);
- 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
- 			struct pci_bus *subbus = dev->subordinate;
- 			if (subbus)
- 				eeh_add_device_tree_late(subbus);
- 		}
-	}
-}
-
 /**
  * eeh_add_device_late - perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
@@ -914,7 +900,7 @@ void eeh_add_device_tree_late(struct pci
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-void eeh_add_device_late(struct pci_dev *dev)
+static void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
@@ -933,7 +919,20 @@ void eeh_add_device_late(struct pci_dev 
 
 	pci_addr_cache_insert_device (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_late);
+
+void eeh_add_device_tree_late(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+ 		eeh_add_device_late(dev);
+ 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+ 			struct pci_bus *subbus = dev->subordinate;
+ 			if (subbus)
+ 				eeh_add_device_tree_late(subbus);
+ 		}
+	}
+}
 
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device

_

