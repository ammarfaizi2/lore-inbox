Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161401AbWBUGcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWBUGcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161406AbWBUGcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:32:52 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40934 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161401AbWBUGcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:32:51 -0500
Message-ID: <43FAB375.2020007@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:30:13 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags
 into pci_device_id
References: <43FAB283.8090206@jp.fujitsu.com>
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device_flags field into struct pci_device_id to
enables pci device drivers to pass per device ID flags to the
kernel. This patch also defines the PCI_DEVICE_ID_FLAG_NOIOPOT flag of
the device_flags field which is used to tell the kernel whether the
driver need to use I/O port regions to handle the device.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-driver.c        |   14 +++++++++++---
 include/linux/mod_devicetable.h |    3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc4/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/pci/pci-driver.c	2006-02-21 14:40:55.000000000 +0900
+++ linux-2.6.16-rc4/drivers/pci/pci-driver.c	2006-02-21 14:40:55.000000000 +0900
@@ -43,13 +43,13 @@
 	struct pci_dynid *dynid;
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
-		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+		subdevice=PCI_ANY_ID, class=0, class_mask=0, device_flags=0;
 	unsigned long driver_data=0;
 	int fields=0;
 
-	fields = sscanf(buf, "%x %x %x %x %x %x %lx",
+	fields = sscanf(buf, "%x %x %x %x %x %x %lx %x",
 			&vendor, &device, &subvendor, &subdevice,
-			&class, &class_mask, &driver_data);
+			&class, &class_mask, &driver_data, &device_flags);
 	if (fields < 0)
 		return -EINVAL;
 
@@ -67,6 +67,7 @@
 	dynid->id.class_mask = class_mask;
 	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
 		driver_data : 0UL;
+	dynid->id.device_flags = device_flags;
 
 	spin_lock(&pdrv->dynids.lock);
 	list_add_tail(&pdrv->dynids.list, &dynid->node);
@@ -170,6 +171,12 @@
 	return NULL;
 }
 
+static inline void pci_extract_per_id_flags(struct pci_dev *dev,
+					    const struct pci_device_id *id)
+{
+	dev->no_ioport = !!(id->device_flags & PCI_DEVICE_ID_FLAG_NOIOPORT);
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
@@ -189,6 +196,7 @@
 	current->mempolicy = &default_policy;
 	mpol_get(current->mempolicy);
 #endif
+	pci_extract_per_id_flags(dev, id);
 	error = drv->probe(dev, id);
 #ifdef CONFIG_NUMA
 	set_cpus_allowed(current, oldmask);
Index: linux-2.6.16-rc4/include/linux/mod_devicetable.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/mod_devicetable.h	2006-02-21 14:40:46.000000000 +0900
+++ linux-2.6.16-rc4/include/linux/mod_devicetable.h	2006-02-21 14:40:55.000000000 +0900
@@ -19,8 +19,11 @@
 	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
 	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
 	kernel_ulong_t driver_data;	/* Data private to the driver */
+	__u32 device_flags;		/* Per device ID flags (See below) */
 };
 
+/* Per PCI device ID flags */
+#define PCI_DEVICE_ID_FLAG_NOIOPORT	(1<<0)	/* Don't need I/O port */
 
 #define IEEE1394_MATCH_VENDOR_ID	0x0001
 #define IEEE1394_MATCH_MODEL_ID		0x0002


