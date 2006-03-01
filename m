Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWCAQix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWCAQix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCAQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:38:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62100 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751354AbWCAQiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:38:52 -0500
Subject: [PATCH] move eeh_add_device_tree_late()
From: John Rose <johnrose@austin.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20060301010249.GV20175@ca-server1.us.oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com>
	 <20060301010249.GV20175@ca-server1.us.oracle.com>
Content-Type: text/plain
Message-Id: <1141230954.19095.19.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Mar 2006 10:35:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch, Mark.

Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
function that calls eeh_add_device_late() implicitly.  This patch
reorders the two functions in question to fix the compile error.  This
might be preferable to exposing eeh_add_device_late() in eeh.h.

Apologies Paul/everyone, please don't kill me.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb arch/powerpc/platforms/pseries/eeh.c
--- 2_6_linus_3/arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb	2006-03-01 10:30:52.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/powerpc/platforms/pseries/eeh.c	2006-03-01 10:31:28.000000000 -0600
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
@@ -935,6 +921,20 @@ void eeh_add_device_late(struct pci_dev 
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_late);
 
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
+
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed

_

