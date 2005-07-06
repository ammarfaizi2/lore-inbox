Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVGFTxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVGFTxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVGFTud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:50:33 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36280 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262201AbVGFPC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:02:56 -0400
Date: Wed, 6 Jul 2005 17:02:41 +0200 (MEST)
Message-Id: <200507061502.j66F2f5b010528@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: gregkh@suse.de
Subject: [PATCH 2.6.13-rc2] pci: fix PCI && !HOTPLUG compile error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc2 triggers compile errors in pci-driver.c
when hotplug is disabled:

drivers/pci/pci-driver.c: In function 'pci_match_device':
drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to 'int' in declaration of 'type name'
drivers/pci/pci-driver.c:156: error: request for member 'node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to 'int' in declaration of '__mptr'
drivers/pci/pci-driver.c:156: warning: initialization from incompatible pointer type
etc

This is because 2.6.13-rc2 added a code block to this function which references
hotplug-only stuff. Fixed crudely by #ifdef CONFIG_HOTPLUG around it.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.13-rc2/drivers/pci/pci-driver.c.~1~	2005-07-06 15:20:41.000000000 +0200
+++ linux-2.6.13-rc2/drivers/pci/pci-driver.c	2005-07-06 15:49:18.000000000 +0200
@@ -145,12 +145,15 @@ const struct pci_device_id *pci_match_de
 					     struct pci_dev *dev)
 {
 	const struct pci_device_id *id;
+#ifdef CONFIG_HOTPLUG
 	struct pci_dynid *dynid;
+#endif
 
 	id = pci_match_id(drv->id_table, dev);
 	if (id)
 		return id;
 
+#ifdef CONFIG_HOTPLUG
 	/* static ids didn't match, lets look at the dynamic ones */
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
@@ -160,6 +163,7 @@ const struct pci_device_id *pci_match_de
 		}
 	}
 	spin_unlock(&drv->dynids.lock);
+#endif
 	return NULL;
 }
 
