Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270180AbUJSXgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270180AbUJSXgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270157AbUJSXgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:36:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:9354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270128AbUJSWqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:33 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257332170@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257332039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.9, 2004/10/06 11:21:54-07:00, greg@kroah.com

[PATCH] PCI: remove pci_find_class() usage from all drivers/ files

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/applicom.c          |    2 +-
 drivers/char/drm/drm_fops.h      |    7 +++++--
 drivers/char/ipmi/ipmi_si_intf.c |   14 ++++++++++----
 drivers/media/video/bttv-cards.c |    6 +++---
 drivers/net/wan/sbni.c           |    6 +++++-
 drivers/scsi/eata.c              |   12 +++++++++---
 6 files changed, 33 insertions(+), 14 deletions(-)


diff -Nru a/drivers/char/applicom.c b/drivers/char/applicom.c
--- a/drivers/char/applicom.c	2004-10-19 15:27:11 -07:00
+++ b/drivers/char/applicom.c	2004-10-19 15:27:11 -07:00
@@ -200,7 +200,7 @@
 
 	/* No mem and irq given - check for a PCI card */
 
-	while ( (dev = pci_find_class(PCI_CLASS_OTHERS << 16, dev))) {
+	while ( (dev = pci_get_class(PCI_CLASS_OTHERS << 16, dev))) {
 
 		if (dev->vendor != PCI_VENDOR_ID_APPLICOM)
 			continue;
diff -Nru a/drivers/char/drm/drm_fops.h b/drivers/char/drm/drm_fops.h
--- a/drivers/char/drm/drm_fops.h	2004-10-19 15:27:11 -07:00
+++ b/drivers/char/drm/drm_fops.h	2004-10-19 15:27:11 -07:00
@@ -99,8 +99,11 @@
 	 */
 	if (!dev->hose) {
 		struct pci_dev *pci_dev;
-		pci_dev = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
-		if (pci_dev) dev->hose = pci_dev->sysdata;
+		pci_dev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
+		if (pci_dev) {
+			dev->hose = pci_dev->sysdata;
+			pci_dev_put(pci_dev);
+		}
 		if (!dev->hose) {
 			struct pci_bus *b = pci_bus_b(pci_root_buses.next);
 			if (b) dev->hose = b->sysdata;
diff -Nru a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
--- a/drivers/char/ipmi/ipmi_si_intf.c	2004-10-19 15:27:11 -07:00
+++ b/drivers/char/ipmi/ipmi_si_intf.c	2004-10-19 15:27:11 -07:00
@@ -1777,10 +1777,10 @@
 
 	pci_smic_checked = 1;
 
-	if ((pci_dev = pci_find_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID,
+	if ((pci_dev = pci_get_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID,
 				       NULL)))
 		;
-	else if ((pci_dev = pci_find_class(PCI_ERMC_CLASSCODE, NULL)) &&
+	else if ((pci_dev = pci_get_class(PCI_ERMC_CLASSCODE, NULL)) &&
 		 pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID)
 		fe_rmc = 1;
 	else
@@ -1789,6 +1789,7 @@
 	error = pci_read_config_word(pci_dev, PCI_MMC_ADDR_CW, &base_addr);
 	if (error)
 	{
+		pci_dev_put(pci_dev);
 		printk(KERN_ERR
 		       "ipmi_si: pci_read_config_word() failed (%d).\n",
 		       error);
@@ -1798,6 +1799,7 @@
 	/* Bit 0: 1 specifies programmed I/O, 0 specifies memory mapped I/O */
 	if (!(base_addr & 0x0001))
 	{
+		pci_dev_put(pci_dev);
 		printk(KERN_ERR
 		       "ipmi_si: memory mapped I/O not supported for PCI"
 		       " smic.\n");
@@ -1809,11 +1811,14 @@
 		/* Data register starts at base address + 1 in eRMC */
 		++base_addr;
 
-	if (!is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr))
-	    return -ENODEV;
+	if (!is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {
+		pci_dev_put(pci_dev);
+		return -ENODEV;
+	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
+		pci_dev_put(pci_dev);
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (5)\n");
 		return -ENOMEM;
 	}
@@ -1836,6 +1841,7 @@
 	printk("ipmi_si: Found PCI SMIC at I/O address 0x%lx\n",
 		(long unsigned int) base_addr);
 
+	pci_dev_put(pci_dev);
 	return 0;
 }
 #endif /* CONFIG_PCI */
diff -Nru a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
--- a/drivers/media/video/bttv-cards.c	2004-10-19 15:27:11 -07:00
+++ b/drivers/media/video/bttv-cards.c	2004-10-19 15:27:11 -07:00
@@ -4045,7 +4045,7 @@
 
 #if 0
 	/* print which chipset we have */
-	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
+	while ((dev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
 		printk(KERN_INFO "bttv: Host bridge is %s\n",pci_name(dev));
 #endif
 
@@ -4064,8 +4064,8 @@
 	if (UNSET != latency)
 		printk(KERN_INFO "bttv: pci latency fixup [%d]\n",latency);
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-				      PCI_DEVICE_ID_INTEL_82441, dev))) {
+	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				     PCI_DEVICE_ID_INTEL_82441, dev))) {
                 unsigned char b;
 		pci_read_config_byte(dev, 0x53, &b);
 		if (bttv_debug)
diff -Nru a/drivers/net/wan/sbni.c b/drivers/net/wan/sbni.c
--- a/drivers/net/wan/sbni.c	2004-10-19 15:27:11 -07:00
+++ b/drivers/net/wan/sbni.c	2004-10-19 15:27:11 -07:00
@@ -294,7 +294,7 @@
 {
 	struct pci_dev  *pdev = NULL;
 
-	while( (pdev = pci_find_class( PCI_CLASS_NETWORK_OTHER << 8, pdev ))
+	while( (pdev = pci_get_class( PCI_CLASS_NETWORK_OTHER << 8, pdev ))
 	       != NULL ) {
 		int  pci_irq_line;
 		unsigned long  pci_ioaddr;
@@ -331,10 +331,14 @@
 		/* avoiding re-enable dual adapters */
 		if( (pci_ioaddr & 7) == 0  &&  pci_enable_device( pdev ) ) {
 			release_region( pci_ioaddr, SBNI_IO_EXTENT );
+			pci_dev_put( pdev );
 			return  -EIO;
 		}
 		if( sbni_probe1( dev, pci_ioaddr, pci_irq_line ) ) {
 			SET_NETDEV_DEV(dev, &pdev->dev);
+			/* not the best thing to do, but this is all messed up 
+			   for hotplug systems anyway... */
+			pci_dev_put( pdev );
 			return  0;
 		}
 	}
diff -Nru a/drivers/scsi/eata.c b/drivers/scsi/eata.c
--- a/drivers/scsi/eata.c	2004-10-19 15:27:11 -07:00
+++ b/drivers/scsi/eata.c	2004-10-19 15:27:11 -07:00
@@ -1005,7 +1005,7 @@
    unsigned int addr;
    struct pci_dev *dev = NULL;
 
-   while((dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
+   while((dev = pci_get_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
       addr = pci_resource_start (dev, 0);
 
 #if defined(DEBUG_PCI_DETECT)
@@ -1013,6 +1013,11 @@
              driver_name, dev->bus->number, dev->devfn, addr);
 #endif
 
+      /* we are in so much trouble for a pci hotplug system with this driver
+       * anyway, so doing this at least lets people unload the driver and not
+       * cause memory problems, but in general this is a bad thing to do (this
+       * driver needs to be converted to the proper PCI api someday... */
+      pci_dev_put(dev);
       if (addr + PCI_BASE_ADDRESS_0 == port_base) return dev;
       }
 
@@ -1027,7 +1032,7 @@
 
    struct pci_dev *dev = NULL;
 
-   while((dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
+   while((dev = pci_get_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
 
 #if defined(DEBUG_PCI_DETECT)
       printk("%s: enable_pci_ports, bus %d, devfn 0x%x.\n",
@@ -1454,7 +1459,7 @@
 
    for (k = 0; k < MAX_PCI; k++) {
 
-      if (!(dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) break;
+      if (!(dev = pci_get_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) break;
 
       if (pci_enable_device (dev)) {
 
@@ -1478,6 +1483,7 @@
              addr + PCI_BASE_ADDRESS_0;
       }
 
+   pci_dev_put(dev);
 #endif /* end CONFIG_PCI */
 
    return;

