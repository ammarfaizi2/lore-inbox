Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263288AbVCDWB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbVCDWB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbVCDVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:55:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:39329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263112AbVCDUyS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:18 -0500
Cc: davej@redhat.com
Subject: [PATCH] convert pci_dev->slot_name usage to pci_name()
In-Reply-To: <20050304205316.GB32044@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:55 -0800
Message-Id: <11099696352086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.6, 2005/02/07 14:36:14-08:00, davej@redhat.com

[PATCH] convert pci_dev->slot_name usage to pci_name()

Prepare for removal of pci_dev->slot_name

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/frv/mb93090-mb00/pci-frv.c      |    4 +--
 arch/frv/mb93090-mb00/pci-vdk.c      |    6 ++---
 arch/mips/pmc-sierra/yosemite/ht.c   |    6 ++---
 arch/ppc/kernel/pci.c                |    2 -
 arch/sh/drivers/pci/fixups-sh03.c    |    4 +--
 arch/sh/drivers/pci/pci-sh7751.c     |    8 +++----
 arch/sh/drivers/pci/pci-st40.c       |    2 -
 arch/sh64/kernel/pci_sh5.c           |    2 -
 arch/sh64/kernel/pcibios.c           |    4 +--
 drivers/char/agp/generic.c           |    2 -
 drivers/char/agp/sis-agp.c           |    2 -
 drivers/ide/pci/sgiioc4.c            |    6 ++---
 drivers/isdn/hisax/hisax_fcpcipnp.c  |    2 -
 drivers/media/common/saa7146_video.c |    2 -
 drivers/media/video/meye.c           |    2 -
 drivers/media/video/zoran_driver.c   |    2 -
 drivers/net/defxx.c                  |    2 -
 drivers/net/r8169.c                  |    4 +--
 drivers/net/s2io.c                   |    2 -
 drivers/net/sk98lin/skethtool.c      |    2 -
 drivers/net/sk98lin/skge.c           |    2 -
 drivers/net/tulip/tulip.h            |    2 -
 drivers/net/typhoon.c                |    2 -
 drivers/net/via-velocity.c           |    2 -
 drivers/net/wan/wanxl.c              |   38 ++++++++++++++---------------------
 drivers/parisc/dino.c                |    5 +---
 drivers/pci/pci.c                    |    2 -
 drivers/pci/probe.c                  |    1 
 drivers/pci/setup-res.c              |    2 -
 drivers/pcmcia/yenta_socket.c        |    2 -
 drivers/scsi/qla2xxx/qla_os.c        |   14 ++++++------
 31 files changed, 65 insertions(+), 73 deletions(-)


diff -Nru a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
--- a/arch/frv/mb93090-mb00/pci-frv.c	2005-03-04 12:43:34 -08:00
+++ b/arch/frv/mb93090-mb00/pci-frv.c	2005-03-04 12:43:34 -08:00
@@ -43,7 +43,7 @@
 	pci_read_config_dword(dev, reg, &check);
 	if ((new ^ check) & ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK : PCI_BASE_ADDRESS_MEM_MASK)) {
 		printk(KERN_ERR "PCI: Error while updating region "
-		       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
+		       "%s/%d (%08x != %08x)\n", pci_name(dev), resource,
 		       new, check);
 	}
 }
@@ -128,7 +128,7 @@
 					continue;
 				pr = pci_find_parent_resource(dev, r);
 				if (!pr || request_resource(pr, r) < 0)
-					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, dev->slot_name);
+					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
diff -Nru a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
--- a/arch/frv/mb93090-mb00/pci-vdk.c	2005-03-04 12:43:34 -08:00
+++ b/arch/frv/mb93090-mb00/pci-vdk.c	2005-03-04 12:43:34 -08:00
@@ -294,7 +294,7 @@
 	 */
 	int i;
 
-	printk("PCI: Fixing base address flags for device %s\n", d->slot_name);
+	printk("PCI: Fixing base address flags for device %s\n", pci_name(d));
 	for(i=0; i<4; i++)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
@@ -308,7 +308,7 @@
 	 */
 	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
-	printk("PCI: IDE base address fixup for %s\n", d->slot_name);
+	printk("PCI: IDE base address fixup for %s\n", pci_name(d));
 	for(i=0; i<4; i++) {
 		struct resource *r = &d->resource[i];
 		if ((r->start & ~0x80) == 0x374) {
@@ -326,7 +326,7 @@
 	 * There exist PCI IDE controllers which have utter garbage
 	 * in first four base registers. Ignore that.
 	 */
-	printk("PCI: IDE base address trash cleared for %s\n", d->slot_name);
+	printk("PCI: IDE base address trash cleared for %s\n", pci_name(d));
 	for(i=0; i<4; i++)
 		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
 }
diff -Nru a/arch/mips/pmc-sierra/yosemite/ht.c b/arch/mips/pmc-sierra/yosemite/ht.c
--- a/arch/mips/pmc-sierra/yosemite/ht.c	2005-03-04 12:43:34 -08:00
+++ b/arch/mips/pmc-sierra/yosemite/ht.c	2005-03-04 12:43:34 -08:00
@@ -303,7 +303,7 @@
                 if (!r->start && r->end) {
                         printk(KERN_ERR
                                "PCI: Device %s not available because of "
-                               "resource collisions\n", dev->slot_name);
+                               "resource collisions\n", pci_name(dev));
                         return -EINVAL;
                 }
                 if (r->flags & IORESOURCE_IO)
@@ -377,7 +377,7 @@
             ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK :
              PCI_BASE_ADDRESS_MEM_MASK)) {
                 printk(KERN_ERR "PCI: Error while updating region "
-                       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
+                       "%s/%d (%08x != %08x)\n", pci_name(dev), resource,
                        new, check);
         }
 }
@@ -396,7 +396,7 @@
                    addresses kilobyte aligned.  */
                 if (size > 0x100) {
                         printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-                               " (%ld bytes)\n", dev->slot_name,
+                               " (%ld bytes)\n", pci_name(dev),
                                 dev->resource - res, size);
                 }
 
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2005-03-04 12:43:34 -08:00
+++ b/arch/ppc/kernel/pci.c	2005-03-04 12:43:34 -08:00
@@ -1058,7 +1058,7 @@
 		return;
  	res = *(bus->resource[0]);
 
-	DBG("Remapping Bus %d, bridge: %s\n", bus->number, bridge->slot_name);
+	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
diff -Nru a/arch/sh/drivers/pci/fixups-sh03.c b/arch/sh/drivers/pci/fixups-sh03.c
--- a/arch/sh/drivers/pci/fixups-sh03.c	2005-03-04 12:43:34 -08:00
+++ b/arch/sh/drivers/pci/fixups-sh03.c	2005-03-04 12:43:34 -08:00
@@ -46,11 +46,11 @@
 	/* now lookup the actual IRQ on a platform specific basis (pci-'platform'.c) */
 	irq = pcibios_map_platform_irq(slot, pin, dev);
 	if( irq < 0 ) {
-		pr_debug("PCI: Error mapping IRQ on device %s\n", dev->slot_name);
+		pr_debug("PCI: Error mapping IRQ on device %s\n", pci_name(dev));
 		return irq;
 	}
 
-	pr_debug("Setting IRQ for slot %s to %d\n", dev->slot_name, irq);
+	pr_debug("Setting IRQ for slot %s to %d\n", pci_name(dev), irq);
 
 	return irq;
 }
diff -Nru a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
--- a/arch/sh/drivers/pci/pci-sh7751.c	2005-03-04 12:43:34 -08:00
+++ b/arch/sh/drivers/pci/pci-sh7751.c	2005-03-04 12:43:34 -08:00
@@ -169,7 +169,7 @@
 	 */
 	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
-	pr_debug("PCI: IDE base address fixup for %s\n", d->slot_name);
+	pr_debug("PCI: IDE base address fixup for %s\n", pci_name(d));
 	for(i=0; i<4; i++) {
 		struct resource *r = &d->resource[i];
 		if ((r->start & ~0x80) == 0x374) {
@@ -401,11 +401,11 @@
 	/* now lookup the actual IRQ on a platform specific basis (pci-'platform'.c) */
 	irq = pcibios_map_platform_irq(slot,pin);
 	if( irq < 0 ) {
-		pr_debug("PCI: Error mapping IRQ on device %s\n", dev->slot_name);
+		pr_debug("PCI: Error mapping IRQ on device %s\n", pci_name(dev));
 		return irq;
 	}
-	
-	pr_debug("Setting IRQ for slot %s to %d\n", dev->slot_name, irq);
+
+	pr_debug("Setting IRQ for slot %s to %d\n", pci_name(dev), irq);
 
 	return irq;
 }
diff -Nru a/arch/sh/drivers/pci/pci-st40.c b/arch/sh/drivers/pci/pci-st40.c
--- a/arch/sh/drivers/pci/pci-st40.c	2005-03-04 12:43:34 -08:00
+++ b/arch/sh/drivers/pci/pci-st40.c	2005-03-04 12:43:34 -08:00
@@ -246,7 +246,7 @@
 	 */
 	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
-	printk("PCI: IDE base address fixup for %s\n", d->slot_name);
+	printk("PCI: IDE base address fixup for %s\n", pci_name(d));
 	for(i=0; i<4; i++) {
 		struct resource *r = &d->resource[i];
 		if ((r->start & ~0x80) == 0x374) {
diff -Nru a/arch/sh64/kernel/pci_sh5.c b/arch/sh64/kernel/pci_sh5.c
--- a/arch/sh64/kernel/pci_sh5.c	2005-03-04 12:43:34 -08:00
+++ b/arch/sh64/kernel/pci_sh5.c	2005-03-04 12:43:34 -08:00
@@ -39,7 +39,7 @@
 	 */
 	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
-	printk("PCI: IDE base address fixup for %s\n", d->slot_name);
+	printk("PCI: IDE base address fixup for %s\n", pci_name(d));
 	for(i=0; i<4; i++) {
 		struct resource *r = &d->resource[i];
 		if ((r->start & ~0x80) == 0x374) {
diff -Nru a/arch/sh64/kernel/pcibios.c b/arch/sh64/kernel/pcibios.c
--- a/arch/sh64/kernel/pcibios.c	2005-03-04 12:43:34 -08:00
+++ b/arch/sh64/kernel/pcibios.c	2005-03-04 12:43:34 -08:00
@@ -57,7 +57,7 @@
 	pci_read_config_dword(dev, reg, &check);
 	if ((new ^ check) & ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK : PCI_BASE_ADDRESS_MEM_MASK)) {
 		printk(KERN_ERR "PCI: Error while updating region "
-		       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
+		       "%s/%d (%08x != %08x)\n", pci_name(dev), resource,
 		       new, check);
 	}
 }
@@ -125,7 +125,7 @@
 			continue;
 		r = &dev->resource[idx];
 		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);
+			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/char/agp/generic.c	2005-03-04 12:43:34 -08:00
@@ -611,7 +611,7 @@
 	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device at %s.\n",
 				agp_bridge->major_version,
 				agp_bridge->minor_version,
-				agp_bridge->dev->slot_name);
+				pci_name(agp_bridge->dev));
 
 	pci_read_config_dword(agp_bridge->dev,
 		      agp_bridge->capndx + PCI_AGP_STATUS, &command);
diff -Nru a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
--- a/drivers/char/agp/sis-agp.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/char/agp/sis-agp.c	2005-03-04 12:43:34 -08:00
@@ -79,7 +79,7 @@
 	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device at %s.\n",
 		agp_bridge->major_version,
 		agp_bridge->minor_version,
-		agp_bridge->dev->slot_name);
+		pci_name(agp_bridge->dev));
 
 	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + PCI_AGP_STATUS, &command);
 	command = agp_collect_device_status(mode, command);
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/ide/pci/sgiioc4.c	2005-03-04 12:43:34 -08:00
@@ -688,7 +688,7 @@
 	if (ret < 0) {
 		printk(KERN_ERR
 		       "Failed to enable device %s at slot %s\n",
-		       d->name, dev->slot_name);
+		       d->name, pci_name(dev));
 		goto out;
 	}
 	pci_set_master(dev);
@@ -696,11 +696,11 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
-			d->name, dev->slot_name, class_rev);
+			d->name, pci_name(dev), class_rev);
 	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
 		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
 			"firmware is obsolete - please upgrade to revision"
-			"46 or higher\n", d->name, dev->slot_name);
+			"46 or higher\n", d->name, pci_name(dev));
 		ret = -EAGAIN;
 		goto out;
 	}
diff -Nru a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-03-04 12:43:34 -08:00
@@ -902,7 +902,7 @@
 	adapter->irq = pdev->irq;
 
 	printk(KERN_INFO "hisax_fcpcipnp: found adapter %s at %s\n",
-	       (char *) ent->driver_data, pdev->slot_name);
+	       (char *) ent->driver_data, pci_name(pdev));
 
 	retval = fcpcipnp_setup(adapter);
 	if (retval)
diff -Nru a/drivers/media/common/saa7146_video.c b/drivers/media/common/saa7146_video.c
--- a/drivers/media/common/saa7146_video.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/media/common/saa7146_video.c	2005-03-04 12:43:34 -08:00
@@ -889,7 +889,7 @@
 		
                 strcpy(cap->driver, "saa7146 v4l2");
 		strlcpy(cap->card, dev->ext->name, sizeof(cap->card));
-		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
+		sprintf(cap->bus_info,"PCI:%s", pci_name(dev->pci));
 		cap->version = SAA7146_VERSION_CODE;
 		cap->capabilities =
 			V4L2_CAP_VIDEO_CAPTURE |
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/media/video/meye.c	2005-03-04 12:43:34 -08:00
@@ -1154,7 +1154,7 @@
 		memset(cap, 0, sizeof(*cap));
 		strcpy(cap->driver, "meye");
 		strcpy(cap->card, "meye");
-		sprintf(cap->bus_info, "PCI:%s", meye.mchip_dev->slot_name);
+		sprintf(cap->bus_info, "PCI:%s", pci_name(meye.mchip_dev));
 		cap->version = (MEYE_DRIVER_MAJORVERSION << 8) +
 			       MEYE_DRIVER_MINORVERSION;
 		cap->capabilities = V4L2_CAP_VIDEO_CAPTURE |
diff -Nru a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
--- a/drivers/media/video/zoran_driver.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/media/video/zoran_driver.c	2005-03-04 12:43:34 -08:00
@@ -2694,7 +2694,7 @@
 		strncpy(cap->card, ZR_DEVNAME(zr), sizeof(cap->card));
 		strncpy(cap->driver, "zoran", sizeof(cap->driver));
 		snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
-			 zr->pci_dev->slot_name);
+			 pci_name(zr->pci_dev));
 		cap->version =
 		    KERNEL_VERSION(MAJOR_VERSION, MINOR_VERSION,
 				   RELEASE_VERSION);
diff -Nru a/drivers/net/defxx.c b/drivers/net/defxx.c
--- a/drivers/net/defxx.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/defxx.c	2005-03-04 12:43:34 -08:00
@@ -420,7 +420,7 @@
 	}
 
 	if (pdev != NULL)
-		print_name = pdev->slot_name;
+		print_name = pci_name(pdev);
 
 	dev = alloc_fddidev(sizeof(*bp));
 	if (!dev) {
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/r8169.c	2005-03-04 12:43:34 -08:00
@@ -1146,7 +1146,7 @@
 	// enable device (incl. PCI PM wakeup and hotplug setup)
 	rc = pci_enable_device(pdev);
 	if (rc) {
-		printk(KERN_ERR PFX "%s: enable failure\n", pdev->slot_name);
+		printk(KERN_ERR PFX "%s: enable failure\n", pci_name(pdev));
 		goto err_out_free_dev;
 	}
 
@@ -1184,7 +1184,7 @@
 	rc = pci_request_regions(pdev, MODULENAME);
 	if (rc) {
 		printk(KERN_ERR PFX "%s: could not request regions.\n",
-		       pdev->slot_name);
+		       pci_name(pdev));
 		goto err_out_mwi;
 	}
 
diff -Nru a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/s2io.c	2005-03-04 12:43:34 -08:00
@@ -3192,7 +3192,7 @@
 	strncpy(info->version, s2io_driver_version,
 		sizeof(s2io_driver_version));
 	strncpy(info->fw_version, "", 32);
-	strncpy(info->bus_info, sp->pdev->slot_name, 32);
+	strncpy(info->bus_info, pci_name(sp->pdev), 32);
 	info->regdump_len = XENA_REG_SPACE;
 	info->eedump_len = XENA_EEPROM_SPACE;
 	info->testinfo_len = S2IO_TEST_LEN;
diff -Nru a/drivers/net/sk98lin/skethtool.c b/drivers/net/sk98lin/skethtool.c
--- a/drivers/net/sk98lin/skethtool.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/sk98lin/skethtool.c	2005-03-04 12:43:34 -08:00
@@ -257,7 +257,7 @@
 	strlcpy(info->driver, DRIVER_FILE_NAME, sizeof(info->driver));
 	strcpy(info->version, vers);
 	strcpy(info->fw_version, "N/A");
-	strlcpy(info->bus_info, pAC->PciDev->slot_name, ETHTOOL_BUSINFO_LEN);
+	strlcpy(info->bus_info, pci_name(pAC->PciDev), ETHTOOL_BUSINFO_LEN);
 }
 
 /*
diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/sk98lin/skge.c	2005-03-04 12:43:34 -08:00
@@ -3058,7 +3058,7 @@
 		*/
 		* ((SK_U32 *)pMemBuf) = 0;
 		* ((SK_U32 *)pMemBuf + 1) = pdev->bus->number;
-		* ((SK_U32 *)pMemBuf + 2) = ParseDeviceNbrFromSlotName(pdev->slot_name);
+		* ((SK_U32 *)pMemBuf + 2) = ParseDeviceNbrFromSlotName(pci_name(pdev));
 		if(copy_to_user(Ioctl.pData, pMemBuf, Length) ) {
 			Err = -EFAULT;
 			goto fault_diag;
diff -Nru a/drivers/net/tulip/tulip.h b/drivers/net/tulip/tulip.h
--- a/drivers/net/tulip/tulip.h	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/tulip/tulip.h	2005-03-04 12:43:34 -08:00
@@ -476,7 +476,7 @@
 
 		if (!i)
 			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					tp->pdev->slot_name);
+					pci_name(tp->pdev));
 	}
 }
 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/typhoon.c	2005-03-04 12:43:34 -08:00
@@ -2438,7 +2438,7 @@
 	INIT_COMMAND_WITH_RESPONSE(&xp_cmd, TYPHOON_CMD_READ_VERSIONS);
 	if(typhoon_issue_command(tp, 1, &xp_cmd, 3, xp_resp) < 0) {
 		printk(ERR_PFX "%s: Could not get Sleep Image version\n",
-			pdev->slot_name);
+			pci_name(pdev));
 		goto error_out_reset;
 	}
 
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/via-velocity.c	2005-03-04 12:43:34 -08:00
@@ -2898,7 +2898,7 @@
 	struct velocity_info *vptr = dev->priv;
 	strcpy(info->driver, VELOCITY_NAME);
 	strcpy(info->version, VELOCITY_VERSION);
-	strcpy(info->bus_info, vptr->pdev->slot_name);
+	strcpy(info->bus_info, pci_name(vptr->pdev));
 }
 
 static void velocity_ethtool_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
diff -Nru a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
--- a/drivers/net/wan/wanxl.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/wan/wanxl.c	2005-03-04 12:43:34 -08:00
@@ -72,7 +72,7 @@
 	u8 irq;
 
 	u8 __iomem *plx;	/* PLX PCI9060 virtual base address */
-	struct pci_dev *pdev;	/* for pdev->slot_name */
+	struct pci_dev *pdev;	/* for pci_name(pdev) */
 	int rx_in;
 	struct sk_buff *rx_skbs[RX_QUEUE_LENGTH];
 	card_status_t *status;	/* shared between host and card */
@@ -88,12 +88,6 @@
 }
 
 
-static inline const char* card_name(struct pci_dev *pdev)
-{
-	return pdev->slot_name;
-}
-
-
 static inline port_status_t* get_status(port_t *port)
 {
 	return &port->card->status->port_status[port->node];
@@ -107,7 +101,7 @@
 	dma_addr_t addr = pci_map_single(pdev, ptr, size, direction);
 	if (addr + size > 0x100000000LL)
 		printk(KERN_CRIT "wanXL %s: pci_map_single() returned memory"
-		       " at 0x%LX!\n", card_name(pdev),
+		       " at 0x%LX!\n", pci_name(pdev),
 		       (unsigned long long)addr);
 	return addr;
 }
@@ -201,7 +195,7 @@
 	       desc->stat != PACKET_EMPTY) {
 		if ((desc->stat & PACKET_PORT_MASK) > card->n_ports)
 			printk(KERN_CRIT "wanXL %s: received packet for"
-			       " nonexistent port\n", card_name(card->pdev));
+			       " nonexistent port\n", pci_name(card->pdev));
 		else {
 			struct sk_buff *skb = card->rx_skbs[card->rx_in];
 			port_t *port = &card->ports[desc->stat &
@@ -604,7 +598,7 @@
 	card = kmalloc(alloc_size, GFP_KERNEL);
 	if (card == NULL) {
 		printk(KERN_ERR "wanXL %s: unable to allocate memory\n",
-		       card_name(pdev));
+		       pci_name(pdev));
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
 		return -ENOBUFS;
@@ -623,7 +617,7 @@
 
 #ifdef DEBUG_PCI
 	printk(KERN_DEBUG "wanXL %s: pci_alloc_consistent() returned memory"
-	       " at 0x%LX\n", card_name(pdev),
+	       " at 0x%LX\n", pci_name(pdev),
 	       (unsigned long long)card->status_address);
 #endif
 
@@ -649,7 +643,7 @@
 	while ((stat = readl(card->plx + PLX_MAILBOX_0)) != 0) {
 		if (time_before(timeout, jiffies)) {
 			printk(KERN_WARNING "wanXL %s: timeout waiting for"
-			       " PUTS to complete\n", card_name(pdev));
+			       " PUTS to complete\n", pci_name(pdev));
 			wanxl_pci_remove_one(pdev);
 			return -ENODEV;
 		}
@@ -661,7 +655,7 @@
 
 		default:
 			printk(KERN_WARNING "wanXL %s: PUTS test 0x%X"
-			       " failed\n", card_name(pdev), stat & 0x30);
+			       " failed\n", pci_name(pdev), stat & 0x30);
 			wanxl_pci_remove_one(pdev);
 			return -ENODEV;
 		}
@@ -681,7 +675,7 @@
 	    (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports) {
 		printk(KERN_WARNING "wanXL %s: no enough on-board RAM"
 		       " (%u bytes detected, %u bytes required)\n",
-		       card_name(pdev), ramsize, BUFFERS_ADDR +
+		       pci_name(pdev), ramsize, BUFFERS_ADDR +
 		       (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports);
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
@@ -689,7 +683,7 @@
 
 	if (wanxl_puts_command(card, MBX1_CMD_BSWAP)) {
 		printk(KERN_WARNING "wanXL %s: unable to Set Byte Swap"
-		       " Mode\n", card_name(pdev));
+		       " Mode\n", pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -720,7 +714,7 @@
 
 	if (wanxl_puts_command(card, MBX1_CMD_ABORTJ)) {
 		printk(KERN_WARNING "wanXL %s: unable to Abort and Jump\n",
-		       card_name(pdev));
+		       pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -735,7 +729,7 @@
 
 	if (!stat) {
 		printk(KERN_WARNING "wanXL %s: timeout while initializing card"
-		       "firmware\n", card_name(pdev));
+		       "firmware\n", pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -745,12 +739,12 @@
 #endif
 
 	printk(KERN_INFO "wanXL %s: at 0x%X, %u KB of RAM at 0x%X, irq %u\n",
-	       card_name(pdev), plx_phy, ramsize / 1024, mem_phy, pdev->irq);
+	       pci_name(pdev), plx_phy, ramsize / 1024, mem_phy, pdev->irq);
 
 	/* Allocate IRQ */
 	if (request_irq(pdev->irq, wanxl_intr, SA_SHIRQ, "wanXL", card)) {
 		printk(KERN_WARNING "wanXL %s: could not allocate IRQ%i.\n",
-		       card_name(pdev), pdev->irq);
+		       pci_name(pdev), pdev->irq);
 		wanxl_pci_remove_one(pdev);
 		return -EBUSY;
 	}
@@ -762,7 +756,7 @@
 		struct net_device *dev = alloc_hdlcdev(port);
 		if (!dev) {
 			printk(KERN_ERR "wanXL %s: unable to allocate"
-			       " memory\n", card_name(pdev));
+			       " memory\n", pci_name(pdev));
 			wanxl_pci_remove_one(pdev);
 			return -ENOMEM;
 		}
@@ -783,7 +777,7 @@
 		get_status(port)->clocking = CLOCK_EXT;
 		if (register_hdlc_device(dev)) {
 			printk(KERN_ERR "wanXL %s: unable to register hdlc"
-			       " device\n", card_name(pdev));
+			       " device\n", pci_name(pdev));
 			free_netdev(dev);
 			wanxl_pci_remove_one(pdev);
 			return -ENOBUFS;
@@ -791,7 +785,7 @@
 		card->n_ports++;
 	}
 
-	printk(KERN_INFO "wanXL %s: port", card_name(pdev));
+	printk(KERN_INFO "wanXL %s: port", pci_name(pdev));
 	for (i = 0; i < ports; i++)
 		printk("%s #%i: %s", i ? "," : "", i,
 		       card->ports[i].dev->name);
diff -Nru a/drivers/parisc/dino.c b/drivers/parisc/dino.c
--- a/drivers/parisc/dino.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/parisc/dino.c	2005-03-04 12:43:34 -08:00
@@ -653,14 +653,13 @@
 				      PCI_INTERRUPT_PIN, 1, &irq_pin);
 			irq_pin = (irq_pin + PCI_SLOT(dev->devfn) - 1) % 4 ;
 			printk(KERN_WARNING "Device %s has undefined IRQ, "
-					"setting to %d\n", dev->slot_name,
-					irq_pin);
+					"setting to %d\n", pci_name(dev), irq_pin);
 			dino_cfg_write(dev->bus, dev->devfn, 
 				       PCI_INTERRUPT_LINE, 1, irq_pin);
 			dino_assign_irq(dino_dev, irq_pin, &dev->irq);
 #else
 			dev->irq = 65535;
-			printk(KERN_WARNING "Device %s has unassigned IRQ\n", dev->slot_name);	
+			printk(KERN_WARNING "Device %s has unassigned IRQ\n", pci_name(dev));
 #endif
 		} else {
 
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/pci/pci.c	2005-03-04 12:43:34 -08:00
@@ -271,7 +271,7 @@
 	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
 		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
-		       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
+		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
 		return -EIO;
 	}
 
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/pci/probe.c	2005-03-04 12:43:34 -08:00
@@ -549,7 +549,6 @@
 {
 	u32 class;
 
-	dev->slot_name = dev->dev.bus_id;
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/pci/setup-res.c	2005-03-04 12:43:34 -08:00
@@ -86,7 +86,7 @@
 	}
 	res->flags &= ~IORESOURCE_UNSET;
 	DBGC((KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
-		dev->slot_name, resno, res->flags,
+		pci_name(dev), resno, res->flags,
 		new & ~PCI_REGION_FLAG_MASK));
 }
 
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/pcmcia/yenta_socket.c	2005-03-04 12:43:34 -08:00
@@ -963,7 +963,7 @@
 	 * the irq stuff...
 	 */
 	printk(KERN_INFO "Yenta: CardBus bridge found at %s [%04x:%04x]\n",
-		dev->slot_name, dev->subsystem_vendor, dev->subsystem_device);
+		pci_name(dev), dev->subsystem_vendor, dev->subsystem_device);
 
 	yenta_config_init(socket);
 
diff -Nru a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/scsi/qla2xxx/qla_os.c	2005-03-04 12:43:34 -08:00
@@ -1847,13 +1847,13 @@
 		if (pio_len < MIN_IOBASE_LEN) {
 			qla_printk(KERN_WARNING, ha,
 			    "Invalid PCI I/O region size (%s)...\n",
-			    ha->pdev->slot_name);
+				pci_name(ha->pdev));
 			pio = 0;
 		}
 	} else {
 		qla_printk(KERN_WARNING, ha,
 		    "region #0 not a PIO resource (%s)...\n",
-		    ha->pdev->slot_name);
+		    pci_name(ha->pdev));
 		pio = 0;
 	}
 
@@ -1865,20 +1865,20 @@
 	if (!(mmio_flags & IORESOURCE_MEM)) {
 		qla_printk(KERN_ERR, ha,
 		    "region #0 not an MMIO resource (%s), aborting\n",
-		    ha->pdev->slot_name);
+		    pci_name(ha->pdev));
 		goto iospace_error_exit;
 	}
 	if (mmio_len < MIN_IOBASE_LEN) {
 		qla_printk(KERN_ERR, ha,
 		    "Invalid PCI mem region size (%s), aborting\n",
-		    ha->pdev->slot_name);
+			pci_name(ha->pdev));
 		goto iospace_error_exit;
 	}
 
 	if (pci_request_regions(ha->pdev, ha->brd_info->drv_name)) {
 		qla_printk(KERN_WARNING, ha,
-		    "Failed to reserve PIO/MMIO regions (%s)\n", 
-		    ha->pdev->slot_name);
+		    "Failed to reserve PIO/MMIO regions (%s)\n",
+		    pci_name(ha->pdev));
 
 		goto iospace_error_exit;
 	}
@@ -1888,7 +1888,7 @@
 	ha->iobase = ioremap(mmio, MIN_IOBASE_LEN);
 	if (!ha->iobase) {
 		qla_printk(KERN_ERR, ha,
-		    "cannot remap MMIO (%s), aborting\n", ha->pdev->slot_name);
+		    "cannot remap MMIO (%s), aborting\n", pci_name(ha->pdev));
 
 		goto iospace_error_exit;
 	}

