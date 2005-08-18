Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVHRFdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVHRFdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVHRFdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:33:23 -0400
Received: from fmr17.intel.com ([134.134.136.16]:13528 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750729AbVHRFdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:33:23 -0400
Subject: [RFC/PATCH]reconfigure MSI registers after resume
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tom.l.nguyen@intel.com, Greg KH <greg@kroah.com>, akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 13:35:46 +0800
Message-Id: <1124343346.6272.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It appears pci_enable_msi doesn't reconfigure msi registers if it
successfully look up a msi for a device. It assumes the data and address
registers unchanged after calling pci_disable_msi. But this isn't always
true, such as in a suspend/resume circle. In my test system, the
registers unsurprised become zero after a S3 resume. This patch fixes my
problem, please look at it. MSIX might have the same issue, but I
haven't taken a close look.

Thanks,
Shaohua
---

 linux-2.6.13-rc6-root/drivers/pci/msi.c |   72 +++++++++++++++++++-------------
 1 files changed, 43 insertions(+), 29 deletions(-)

diff -puN drivers/pci/msi.c~pci-msi drivers/pci/msi.c
--- linux-2.6.13-rc6/drivers/pci/msi.c~pci-msi	2005-08-18 12:58:45.032124008 +0800
+++ linux-2.6.13-rc6-root/drivers/pci/msi.c	2005-08-18 13:06:02.080682528 +0800
@@ -508,6 +508,45 @@ void pci_scan_msi_device(struct pci_dev 
 		nr_reserved_vectors++;
 }
 
+static void msi_register_init(struct pci_dev *dev, struct msi_desc *entry)
+{
+	struct msg_address address;
+	struct msg_data data;
+	int pos, vector = dev->irq;
+	u16 control;
+
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	/* Configure MSI capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
+				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
+	pci_write_config_dword(dev, msi_lower_address_reg(pos),
+			address.lo_address.value);
+	if (is_64bit_address(control)) {
+		pci_write_config_dword(dev,
+			msi_upper_address_reg(pos), address.hi_address);
+		pci_write_config_word(dev,
+			msi_data_reg(pos, 1), *((u32*)&data));
+	} else
+		pci_write_config_word(dev,
+			msi_data_reg(pos, 0), *((u32*)&data));
+	if (entry->msi_attrib.maskbit) {
+		unsigned int maskbits, temp;
+		/* All MSIs are unmasked by default, Mask them all */
+		pci_read_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			&maskbits);
+		temp = (1 << multi_msi_capable(control));
+		temp = ((temp - 1) & ~temp);
+		maskbits |= temp;
+		pci_write_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			maskbits);
+	}
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -520,8 +559,6 @@ void pci_scan_msi_device(struct pci_dev 
 static int msi_capability_init(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
-	struct msg_data data;
 	int pos, vector;
 	u16 control;
 
@@ -551,33 +588,8 @@ static int msi_capability_init(struct pc
 	/* Replace with MSI handler */
 	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
 	/* Configure MSI capability structure */
-	msi_address_init(&address);
-	msi_data_init(&data, vector);
-	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
-				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	pci_write_config_dword(dev, msi_lower_address_reg(pos),
-			address.lo_address.value);
-	if (is_64bit_address(control)) {
-		pci_write_config_dword(dev,
-			msi_upper_address_reg(pos), address.hi_address);
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 1), *((u32*)&data));
-	} else
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 0), *((u32*)&data));
-	if (entry->msi_attrib.maskbit) {
-		unsigned int maskbits, temp;
-		/* All MSIs are unmasked by default, Mask them all */
-		pci_read_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			&maskbits);
-		temp = (1 << multi_msi_capable(control));
-		temp = ((temp - 1) & ~temp);
-		maskbits |= temp;
-		pci_write_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			maskbits);
-	}
+	msi_register_init(dev, entry);
+
 	attach_msi_entry(entry, vector);
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
@@ -721,6 +733,8 @@ int pci_enable_msi(struct pci_dev* dev)
 			vector_irq[dev->irq] = -1;
 			nr_released_vectors--;
 			spin_unlock_irqrestore(&msi_lock, flags);
+
+			msi_register_init(dev, msi_desc[dev->irq]);
 			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 			return 0;
 		}
_


