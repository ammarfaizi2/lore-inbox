Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264952AbRFUNFb>; Thu, 21 Jun 2001 09:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbRFUNFW>; Thu, 21 Jun 2001 09:05:22 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:64780 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S264952AbRFUNFG>;
	Thu, 21 Jun 2001 09:05:06 -0400
Date: Thu, 21 Jun 2001 17:05:01 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i810 watchdog driver: support for i815/i8[2456]0 chipsets
Message-ID: <20010621170501.A28568@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
User-Agent: Mutt/1.0.1i
X-Uptime: 2:31pm  up 21 days, 22:14,  2 users,  load average: 0.64, 0.19, 0.05
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii

Hi all,

this small patch (2.4.5-ac16) adds Intel i815/i820/i840/i850/i860 chipsets support
into i810 TCO watchdog driver, also MODULE_DEVICE_TABLE added.

Should work but untested (can't stop server just to test it :)

Best regards.

-- 
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin.asc
--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i810tco

diff -ur linux.vanilla/drivers/char/i810-tco.c linux/drivers/char/i810-tco.c
--- linux.vanilla/drivers/char/i810-tco.c	Thu Jun 21 10:52:57 2001
+++ linux/drivers/char/i810-tco.c	Thu Jun 21 10:55:48 2001
@@ -232,18 +232,40 @@
 	}
 }
 
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id i810tco_pci_tbl[] __initdata = {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
+
 static struct pci_dev *i810tco_pci;
 
 static unsigned char i810tco_getdevice (void)
 {
+	struct pci_dev *dev;
 	u8 val1, val2;
 	u16 badr;
 	/*
-	 *      Find the PCI device which has vendor id 0x8086
-	 *      and device ID 0x2410
+	 *      Find the PCI device
 	 */
-	i810tco_pci = pci_find_device (PCI_VENDOR_ID_INTEL,
-				       PCI_DEVICE_ID_INTEL_82801AA_0, NULL);
+
+	pci_for_each_dev(dev) {
+		i810tco_pci = pci_match_device(i810tco_pci_tbl, dev);
+		if (i810tco_pci != NULL)
+			break;
+	}
+
 	if (i810tco_pci) {
 		/*
 		 *      Find the ACPI base I/O address which is the base

--k+w/mQv8wyuph6w0--
