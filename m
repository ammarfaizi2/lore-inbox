Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVBGWAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVBGWAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBGWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:00:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37027 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261340AbVBGWAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:00:32 -0500
Message-Id: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com>
Subject: [PATCH 1/1] PCI: Dynids - passing driver data
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       brking@us.ibm.com
From: brking@us.ibm.com
Date: Mon, 07 Feb 2005 16:00:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, code exists in the pci layer to allow userspace to specify
driver data when adding a pci dynamic id from sysfs. However, this data
is never used and there exists no way in the existing code to use it.
This patch allows device drivers to indicate that they want driver data
passed to them on dynamic id adds by initializing use_driver_data in their
pci_driver->pci_dynids struct. The documentation has also been updated
to reflect this.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.11-rc3-bk4-bjking1/Documentation/pci.txt    |    8 ++++----
 linux-2.6.11-rc3-bk4-bjking1/drivers/pci/pci-driver.c |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff -puN drivers/pci/pci-driver.c~pci_dynids_driver_data drivers/pci/pci-driver.c
--- linux-2.6.11-rc3-bk4/drivers/pci/pci-driver.c~pci_dynids_driver_data	2005-02-07 15:58:21.000000000 -0600
+++ linux-2.6.11-rc3-bk4-bjking1/drivers/pci/pci-driver.c	2005-02-07 15:58:21.000000000 -0600
@@ -115,7 +115,6 @@ static DRIVER_ATTR(new_id, S_IWUSR, NULL
 static inline void
 pci_init_dynids(struct pci_dynids *dynids)
 {
-	memset(dynids, 0, sizeof(*dynids));
 	spin_lock_init(&dynids->lock);
 	INIT_LIST_HEAD(&dynids->list);
 }
diff -puN Documentation/pci.txt~pci_dynids_driver_data Documentation/pci.txt
--- linux-2.6.11-rc3-bk4/Documentation/pci.txt~pci_dynids_driver_data	2005-02-07 15:58:21.000000000 -0600
+++ linux-2.6.11-rc3-bk4-bjking1/Documentation/pci.txt	2005-02-07 15:58:21.000000000 -0600
@@ -99,10 +99,10 @@ where all fields are passed in as hexade
 Users need pass only as many fields as necessary; vendor, device,
 subvendor, and subdevice fields default to PCI_ANY_ID (FFFFFFFF),
 class and classmask fields default to 0, and driver_data defaults to
-0UL.  Device drivers must call
-   pci_dynids_set_use_driver_data(pci_driver *, 1)
-in order for the driver_data field to get passed to the driver.
-Otherwise, only a 0 is passed in that field.
+0UL.  Device drivers must initialize use_driver_data in the dynids struct
+in their pci_driver struct prior to calling pci_register_driver in order
+for the driver_data field to get passed to the driver. Otherwise, only a
+0 is passed in that field.
 
 When the driver exits, it just calls pci_unregister_driver() and the PCI layer
 automatically calls the remove hook for all devices handled by the driver.
_
