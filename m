Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263362AbVCDXH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbVCDXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbVCDWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:16:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:40865 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263113AbVCDUyS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:18 -0500
Cc: brking@us.ibm.com
Subject: [PATCH] PCI: Dynids - passing driver data
In-Reply-To: <11099696371419@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <11099696371910@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.15, 2005/02/08 12:23:18-08:00, brking@us.ibm.com

[PATCH] PCI: Dynids - passing driver data

Currently, code exists in the pci layer to allow userspace to specify
driver data when adding a pci dynamic id from sysfs. However, this data
is never used and there exists no way in the existing code to use it.
This patch allows device drivers to indicate that they want driver data
passed to them on dynamic id adds by initializing use_driver_data in their
pci_driver->pci_dynids struct. The documentation has also been updated
to reflect this.

Signed-off-by: Brian King <brking@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/pci.txt    |    8 ++++----
 drivers/pci/pci-driver.c |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2005-03-04 12:42:31 -08:00
+++ b/Documentation/pci.txt	2005-03-04 12:42:31 -08:00
@@ -99,10 +99,10 @@
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
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2005-03-04 12:42:31 -08:00
+++ b/drivers/pci/pci-driver.c	2005-03-04 12:42:31 -08:00
@@ -115,7 +115,6 @@
 static inline void
 pci_init_dynids(struct pci_dynids *dynids)
 {
-	memset(dynids, 0, sizeof(*dynids));
 	spin_lock_init(&dynids->lock);
 	INIT_LIST_HEAD(&dynids->list);
 }

