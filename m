Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbTIKW7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTIKW7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:59:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:50834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261584AbTIKW6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:58:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10633211532756@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test5
In-Reply-To: <10633211522486@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 11 Sep 2003 15:59:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1286, 2003/09/11 14:36:33-07:00, greg@kroah.com

[PATCH] PCI: remove compiler warning from previous new_id patch

Also change the #define functions into inline functions to help
catch any future paramater mis-matches.

And clean up a few minor style issue...


 drivers/pci/pci-driver.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Sep 11 15:54:46 2003
+++ b/drivers/pci/pci-driver.c	Thu Sep 11 15:54:46 2003
@@ -69,6 +69,7 @@
 	spin_unlock(&drv->dynids.lock);
 	return error;
 }
+
 static inline void
 dynid_init(struct dynid *dynid)
 {
@@ -78,15 +79,12 @@
 
 /**
  * store_new_id
- * @ pdrv
- * @ buf
- * @ count
  *
  * Adds a new dynamic pci device ID to this driver,
  * and causes the driver to probe for all devices again.
  */
 static inline ssize_t
-store_new_id(struct device_driver * driver, const char * buf, size_t count)
+store_new_id(struct device_driver *driver, const char *buf, size_t count)
 {
 	struct dynid *dynid;
 	struct bus_type * bus;
@@ -159,7 +157,7 @@
 }
 
 static int
-pci_create_newid_file(struct pci_driver * drv)
+pci_create_newid_file(struct pci_driver *drv)
 {
 	int error = 0;
 	if (drv->probe != NULL)
@@ -169,7 +167,7 @@
 }
 
 static int
-pci_bus_match_dynids(const struct pci_dev * pci_dev, const struct pci_driver * pci_drv)
+pci_bus_match_dynids(const struct pci_dev *pci_dev, struct pci_driver *pci_drv)
 {
 	struct list_head *pos;
 	struct dynid *dynid;
@@ -187,12 +185,21 @@
 }
 
 #else /* !CONFIG_HOTPLUG */
-#define pci_device_probe_dynamic(drv,pci_dev) (-ENODEV)
-#define dynid_init(dynid) do {} while (0)
-#define pci_init_dynids(dynids) do {} while (0)
-#define pci_free_dynids(drv) do {} while (0)
-#define pci_create_newid_file(drv) (0)
-#define pci_bus_match_dynids(pci_dev, pci_drv) (0)
+static inline int pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
+{
+	return -ENODEV;
+}
+static inline void dynid_init(struct dynid *dynid) {}
+static inline void pci_init_dynids(struct pci_dynids *dynids) {}
+static inline void pci_free_dynids(struct pci_driver *drv) {}
+static inline int pci_create_newid_file(struct pci_driver *drv)
+{
+	return 0;
+}
+static inline int pci_bus_match_dynids(const struct pci_dev *pci_dev, struct pci_driver *pci_drv)
+{
+	return 0;
+}
 #endif
 
 /**
@@ -352,7 +359,7 @@
 };
 
 static int
-pci_populate_driver_dir(struct pci_driver * drv)
+pci_populate_driver_dir(struct pci_driver *drv)
 {
 	return pci_create_newid_file(drv);
 }

