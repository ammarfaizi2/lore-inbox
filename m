Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbUKBW4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUKBW4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUKBWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:52:44 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:12492
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262343AbUKBWvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:51:43 -0500
Message-ID: <41880F63.9030606@ppp0.net>
Date: Tue, 02 Nov 2004 23:51:15 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [patch 1/2] fakephp: introduce pci_bus_add_device
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net> <20041030041615.GH1584@kroah.com> <41857C7A.2030007@ppp0.net> <20041101093514.GA25921@infradead.org>
In-Reply-To: <20041101093514.GA25921@infradead.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Nov 01, 2004 at 12:59:54AM +0100, Jan Dittmer wrote:
> 
>>fakephp needs to add newly discovered devices to the global pci list.
>>Therefore seperate out the appropriate chunk from pci_bus_add_devices
>>to pci_bus_add_device to add a single device to sysfs, procfs
>>and the global device list.
>>
>>Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

> the brace should go to a line of it's own

Sorry about that, updated patch follows:

--- 1.9/drivers/pci/bus.c       2004-04-11 00:27:59 +02:00
+++ edited/drivers/pci/bus.c    2004-11-01 10:41:27 +01:00
@@ -69,6 +69,25 @@
 }

 /**
+ * add a single device
+ * @dev: device to add
+ *
+ * This adds a single pci device to the global
+ * device list and adds sysfs and procfs entries
+ */
+void __devinit pci_bus_add_device(struct pci_dev *dev)
+{
+       device_add(&dev->dev);
+
+       spin_lock(&pci_bus_lock);
+       list_add_tail(&dev->global_list, &pci_devices);
+       spin_unlock(&pci_bus_lock);
+
+       pci_proc_attach_device(dev);
+       pci_create_sysfs_dev_files(dev);
+}
+
+/**
  * pci_bus_add_devices - insert newly discovered PCI devices
  * @bus: bus to check for new devices
  *
@@ -91,16 +110,7 @@
                 */
                if (!list_empty(&dev->global_list))
                        continue;
-
-               device_add(&dev->dev);
-
-               spin_lock(&pci_bus_lock);
-               list_add_tail(&dev->global_list, &pci_devices);
-               spin_unlock(&pci_bus_lock);
-
-               pci_proc_attach_device(dev);
-               pci_create_sysfs_dev_files(dev);
-
+               pci_bus_add_device(dev);
        }

        list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -136,5 +146,6 @@
 }

 EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);
--- 1.139/include/linux/pci.h   2004-10-06 00:56:26 +02:00
+++ edited/include/linux/pci.h  2004-10-31 23:10:04 +01:00
@@ -713,6 +713,7 @@
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
+void pci_bus_add_device(struct pci_dev *dev);
 void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);


