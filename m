Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTEVVxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTEVVv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:51:58 -0400
Received: from granite.he.net ([216.218.226.66]:43019 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263311AbTEVVvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411604177@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411592031@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:06:00 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1063.1.2, 2003/05/05 16:40:59-05:00, Matt_Domsch@dell.com

PCI dynids - documentation fixes, id_table NULL check


 Documentation/pci.txt    |   24 ++++++++++++++++++++++--
 drivers/pci/pci-driver.c |    4 +++-
 include/linux/pci.h      |    2 +-
 3 files changed, 26 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	Thu May 22 14:52:14 2003
+++ b/Documentation/pci.txt	Thu May 22 14:52:14 2003
@@ -45,8 +45,6 @@
 	id_table	Pointer to table of device ID's the driver is
 			interested in.  Most drivers should export this
 			table using MODULE_DEVICE_TABLE(pci,...).
-			Set to NULL to call probe() function for every
-			PCI device known to the system.
 	probe		Pointer to a probing function which gets called (during
 			execution of pci_register_driver for already existing
 			devices or later if a new device gets inserted) for all
@@ -82,6 +80,28 @@
 	class,		Device class to match. The class_mask tells which bits
 	class_mask	of the class are honored during the comparison.
 	driver_data	Data private to the driver.
+
+Most drivers don't need to use the driver_data field.  Best practice
+for use of driver_data is to use it as an index into a static list of
+equivalant device types, not to use it as a pointer.
+
+Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}
+to have probe() called for every PCI device known to the system.
+
+New PCI IDs may be added to a device driver at runtime by writing
+to the file /sys/bus/pci/drivers/{driver}/new_id.  When added, the
+driver will probe for all devices it can support.
+
+echo "vendor device subvendor subdevice class class_mask driver_data" > \
+ /sys/bus/pci/drivers/{driver}/new_id
+where all fields are passed in as hexadecimal values (no leading 0x).
+Users need pass only as many fields as necessary; vendor, device,
+subvendor, and subdevice fields default to PCI_ANY_ID (FFFFFFFF),
+class and classmask fields default to 0, and driver_data defaults to
+0UL.  Device drivers must call
+   pci_dynids_set_use_driver_data(pci_driver *, 1)
+in order for the driver_data field to get passed to the driver.
+Otherwise, only a 0 is passed in that field.
 
 When the driver exits, it just calls pci_unregister_driver() and the PCI layer
 automatically calls the remove hook for all devices handled by the driver.
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 22 14:52:14 2003
+++ b/drivers/pci/pci-driver.c	Thu May 22 14:52:14 2003
@@ -65,7 +65,9 @@
 {		   
 	int error = -ENODEV;
 	const struct pci_device_id *id;
-	
+
+	if (!drv->id_table)
+		return error;
 	id = pci_match_device(drv->id_table, pci_dev);
 	if (id)
 		error = drv->probe(pci_dev, id);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 22 14:52:14 2003
+++ b/include/linux/pci.h	Thu May 22 14:52:14 2003
@@ -499,7 +499,7 @@
 struct pci_driver {
 	struct list_head node;
 	char *name;
-	const struct pci_device_id *id_table;	/* NULL if wants all devices */
+	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */

