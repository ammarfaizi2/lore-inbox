Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTAEMdH>; Sun, 5 Jan 2003 07:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTAEMdH>; Sun, 5 Jan 2003 07:33:07 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:21253 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264697AbTAEMdF>; Sun, 5 Jan 2003 07:33:05 -0500
Date: Sun, 5 Jan 2003 15:37:35 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       grundler@cup.hp.com, linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030105153735.A8532@jurassic.park.msu.ru>
References: <m17ke3m3gl.fsf@frodo.biederman.org> <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> <15877.26255.524564.576439@argo.ozlabs.ibm.com> <1040569382.1966.11.camel@zion> <20021222222106.B30070@localhost.park.msu.ru> <15878.22747.913279.67149@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15878.22747.913279.67149@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Dec 23, 2002 at 11:29:15AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this patch should solve most problems with probing the BARs.
The changes are quite minimal as everything still is done in one pass.
- Added another level of fixups (PCI_FIXUP_EARLY), called with only
  device/vendor IDs and class code filled in, before sizing the BARs.
- pci_read_bases won't probe the BAR if the respective resource has
  non-zero flags.

This allows to implement numerous alternative probing methods for
particular architecture/device/BAR. Some of possible variants:
get information from firmware and don't touch the BAR at all;
write the BAR value into respective resource->start and set
resource->end according to the chip manual without probing;
disable the device, call generic pci_read_bases(), re-enable the device;
probe with value other than 0xffffffff and so on.

Besides, this would easily solve one interesting (though unrelated) problem.
There are quite a few devices (IDE controllers, AGP aperture stuff,
some bridges) that significantly change their PCI header including BARs,
class code etc. depending on some configuration bits, so it might be useful
to program the device into desired state before probing.

Ivan.

--- 2.5.54/drivers/pci/probe.c	Thu Jan  2 06:22:34 2003
+++ linux/drivers/pci/probe.c	Sat Jan  4 19:02:19 2003
@@ -53,6 +53,9 @@ static void pci_read_bases(struct pci_de
 		next = pos+1;
 		res = &dev->resource[pos];
 		res->name = dev->dev.name;
+		/* Skip already probed resources */
+		if (res->flags)
+			continue;
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_read_config_dword(dev, reg, &l);
 		pci_write_config_dword(dev, reg, ~0);
@@ -355,10 +358,7 @@ int pci_setup_device(struct pci_dev * de
 	sprintf(dev->dev.name, "PCI device %04x:%04x", dev->vendor, dev->device);
 	INIT_LIST_HEAD(&dev->pools);
 	
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-	class >>= 8;				    /* upper 3 bytes */
-	dev->class = class;
-	class >>= 8;
+	class = dev->class >> 8;
 
 	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number, dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
 
@@ -433,9 +433,16 @@ struct pci_dev * __devinit pci_scan_devi
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &l);
+	dev->class = l >> 8;			    /* upper 3 bytes */
+
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
+
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(PCI_FIXUP_EARLY, dev);
+
 	if (pci_setup_device(dev) < 0) {
 		kfree(dev);
 		return NULL;
--- 2.5.54/include/linux/pci.h	Thu Jan  2 06:21:56 2003
+++ linux/include/linux/pci.h	Sun Jan  5 15:27:51 2003
@@ -809,8 +809,12 @@ struct pci_fixup {
 
 extern struct pci_fixup pcibios_fixups[];
 
-#define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
-#define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+#define PCI_FIXUP_EARLY		1	/* Called immediately after reading
+					   header type, device/vendor IDs
+					   and class code */
+#define PCI_FIXUP_HEADER	2	/* Called after reading configuration
+					   header (including BARs) */
+#define PCI_FIXUP_FINAL		3	/* Final phase of device fixups */
 
 void pci_fixup_device(int pass, struct pci_dev *dev);
 
