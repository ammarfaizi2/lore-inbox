Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWARAyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWARAyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWARAyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:54:32 -0500
Received: from fmr20.intel.com ([134.134.136.19]:61573 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964984AbWARAyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:21 -0500
Subject: [patch 4/4]  pci: quirk for IBM Dock II cardbus controllers
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
References: <20060116200218.275371000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:57:04 -0800
Message-Id: <1137545824.19858.49.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 00:54:12.0498 (UTC) FILETIME=[B292CF20:01C61BC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM Dock II cardbus bridges require some extra configuration
before Yenta is loaded in order to setup the Interrupts to be
routed properly. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

 drivers/pci/quirks.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

--- linux-2.6.15-mm.orig/drivers/pci/quirks.c
+++ linux-2.6.15-mm/drivers/pci/quirks.c
@@ -1242,6 +1242,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
 

+/*
+ * Fixup the cardbus bridges on the IBM Dock II docking station
+ */
+static void __devinit quirk_ibm_dock2_cardbus(struct pci_dev *dev)
+{
+	u32 val;
+
+	/*
+	 * tie the 2 interrupt pins to INTA, and configure the
+	 * multifunction routing register to handle this.
+	 */
+	if ((dev->subsystem_vendor == PCI_VENDOR_ID_IBM) &&
+		(dev->subsystem_device == 0x0148)) {
+		printk(KERN_INFO "PCI: Found IBM Dock II Cardbus Bridge "
+			"applying quirk\n");
+		pci_read_config_dword(dev, 0x8c, &val);
+		val = ((val & 0xffffff00) | 0x1002);
+		pci_write_config_dword(dev, 0x8c, val);
+		pci_read_config_dword(dev, 0x80, &val);
+		val = ((val & 0x00ffff00) | 0x2864c077);
+		pci_write_config_dword(dev, 0x80, val);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1420,
+				quirk_ibm_dock2_cardbus);
+
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;

