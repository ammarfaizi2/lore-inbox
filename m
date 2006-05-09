Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWEIAGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWEIAGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWEIAGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:06:11 -0400
Received: from web50101.mail.yahoo.com ([206.190.38.29]:59518 "HELO
	web50101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750895AbWEIAGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:06:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BzoqoFfpjL0P0bit8sYmKlkS2b9rzdak+beEvVpTonFer5PdpeKfQGWcFpTkjZmTIDpdVNm/7BE32OMczx/kpxvs+Y4atop6MOUCWC85ugybNMDuq57LLeeyFarfw/0oerAKytlBTEZNmOdvy931tDyn+FBIxDq26UU629vKfDI=  ;
Message-ID: <20060509000609.62160.qmail@web50101.mail.yahoo.com>
Date: Mon, 8 May 2006 17:06:09 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH] PCI Bus Parity Status-broken hardware attribute, EDAC foundation
To: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>,
       arjan@infradead.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH against the 2.6.17-rc3 release.

Currently, the EDAC (error detection and correction) modules that are in the kernel
contain some features that need to be moved. After some good feedback on the PCI
Parity detection code and interface
(http://www.ussg.iu.edu/hypermail/linux/kernel/0603.1/0897.html) this patch ADDs an
new attribute to the pci_dev structure: Namely the 'broken_parity_status' bit. 

When set this indicates that the respective hardware generates false positives of
Parity errors.

The EDAC "blacklist" solution was inferior and will be removed in a future patch.

Also in this patch is a PCI quirk.c entry for an Infiniband PCI-X card which
generates false positive parity errors.

I am requesting comments on this AND on the possibility of a exposing this
'broken_parity_status' bit to userland via the PCI device sysfs directory for
devices. This access would allow for enabling of this feature on new devices and for
old devices that have their drivers updated. (SLES 9 SP3 did this on an ATI
motherboard video device). There is a need to update such a PCI attribute between
kernel releases. 

This patch just adds a storage place for the attribute and a quirk entry for a known
bad PCI device. PCI Parity reaper/harvestor operations are in EDAC itself and will
be refactored to use this PCI attribute instead of its own mechanisms (which are
currently disabled) in the future.

Signed-off-by:  Doug Thompson <norsk5@xmission.com>
---

 drivers/pci/quirks.c    |   11 +++++++++++
 include/linux/pci.h     |    1 +
 include/linux/pci_ids.h |    1 +
 3 files changed, 13 insertions(+)

diff -uprN -X orig/Documentation/dontdiff orig/drivers/pci/quirks.c
new/drivers/pci/quirks.c
--- orig/drivers/pci/quirks.c	2006-03-21 10:19:58.000000000 -0700
+++ new/drivers/pci/quirks.c	2006-05-08 15:54:17.000000000 -0600
@@ -24,6 +24,17 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
+/* The Mellanox Tavor device gives false positive parity errors
+ * Mark this device with a broken_parity_status, to allow
+ * PCI scanning code to "skip" this now blacklisted device.
+ */
+static void __devinit quirk_mellanox_tavor(struct pci_dev *dev)
+{
+	dev->broken_parity_status = 1;	/* This device gives false positives */
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX,PCI_DEVICE_ID_MELLANOX_TAVOR,quirk_mellanox_tavor
);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX,PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE,quirk_mellanox_tavor
);
+
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
 static void __devinit quirk_passive_release(struct pci_dev *dev)
diff -uprN -X orig/Documentation/dontdiff orig/include/linux/pci.h
new/include/linux/pci.h
--- orig/include/linux/pci.h	2006-03-21 10:20:00.000000000 -0700
+++ new/include/linux/pci.h	2006-05-08 15:20:46.000000000 -0600
@@ -152,6 +152,7 @@ struct pci_dev {
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
diff -uprN -X orig/Documentation/dontdiff orig/include/linux/pci_ids.h
new/include/linux/pci_ids.h
--- orig/include/linux/pci_ids.h	2006-03-21 10:20:12.000000000 -0700
+++ new/include/linux/pci_ids.h	2006-05-08 15:54:05.000000000 -0600
@@ -1914,6 +1914,7 @@
 
 #define PCI_VENDOR_ID_MELLANOX		0x15b3
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
+#define PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE	0x5a46
 #define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
 #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c


