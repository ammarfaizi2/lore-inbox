Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbTIKVUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTIKVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:20:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:49129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261535AbTIKVUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:20:09 -0400
Date: Thu, 11 Sep 2003 14:20:18 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030911212018.GA14238@kroah.com>
References: <Pine.LNX.4.44.0309100427490.17820-100000@localhost.localdomain> <Pine.LNX.4.44.0309101212510.2440-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309101212510.2440-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:17:34PM -0500, Matt Domsch wrote:
> > > These either need to be marked __devinit and make "new_id" dependant on
> > > CONFIG_HOTPLUG
> 
> Patch below moves all the new_id code under CONFIG_HOTPLUG.  Tested
> with both CONFIG_HOTPLUG enabled and disabled.  No significant code
> changes, merely code moving, and in 2 cases, stub functions added.
> 
> Please review and apply.

Looks good.  I've added this patch, and then applied this one on top of
yours to fix up some compiler warnings that I got when building yours.
I've also moved the #defines into static inline functions, which is a
bit nicer to do.

I'll send it on in a bit to Linus.

I'll also go through the tree and fix up any pci probe functions that
are marked __init as they should now be marked __devinit.

thanks for doing this patch,

greg k-h


# PCI: remove compiler warning from previous new_id patch
#
# Also change the #define functions into inline functions to help
# catch any future paramater mis-matches.
#
# And clean up a few minor style issue...

diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Sep 11 14:23:32 2003
+++ b/drivers/pci/pci-driver.c	Thu Sep 11 14:23:32 2003
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
