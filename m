Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265399AbRFVNMd>; Fri, 22 Jun 2001 09:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbRFVNMX>; Fri, 22 Jun 2001 09:12:23 -0400
Received: from [200.24.109.130] ([200.24.109.130]:22547 "EHLO
	earth.cj.osso.org.co") by vger.kernel.org with ESMTP
	id <S265399AbRFVNMF>; Fri, 22 Jun 2001 09:12:05 -0400
Message-ID: <3B3343E6.122965AC@osso.org.co>
Date: Fri, 22 Jun 2001 08:11:02 -0500
From: "Jhon H. Caicedo O." <jhcaiced@osso.org.co>
Organization: O.S.S.O
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: AMD756 PCI IRQ Routing Patch 0.2.0
Content-Type: multipart/mixed;
 boundary="------------4D7C0921CA0432C1ED14F2F2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4D7C0921CA0432C1ED14F2F2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi,

This is an updated version of the patch for AMD756 PCI IRQ Routing,
the changes are to use the read/write_config_nybble functions,
this makes the code shorter.

Thanks,

--
Jhon H. Caicedo O. <jhcaiced@osso.org.co>
Observatorio Sismológico del SurOccidente O.S.S.O
http://www.osso.org.co
Cali - Colombia
--------------4D7C0921CA0432C1ED14F2F2
Content-Type: text/plain; charset=us-ascii;
 name="linux-2.4.5_amd756-pci-irq-routing-0.2.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.5_amd756-pci-irq-routing-0.2.0.patch"

--- linux-2.4.5/arch/i386/kernel/pci-irq.c	Wed May 16 12:25:39 2001
+++ linux/arch/i386/kernel/pci-irq.c	Fri Jun 22 07:46:41 2001
@@ -391,6 +391,38 @@
 	return 1;
 }
 
+/* Support for AMD756 PCI IRQ Routing
+ * Jhon H. Caicedo <jhcaiced@osso.org.co>
+ * Jun/21/2001 0.2.0 Release, fixed to use "nybble" functions... (jhcaiced)
+ * Jun/19/2001 Alpha Release 0.1.0 (jhcaiced)
+ * The AMD756 pirq rules are nibble-based
+ * offset 0x56 0-3 PIRQA  4-7  PIRQB
+ * offset 0x57 0-3 PIRQC  4-7  PIRQD
+ */
+static int pirq_amd756_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	u8 irq;
+	irq = 0;
+	if (pirq <= 4)
+	{
+		irq = read_config_nybble(router, 0x56, pirq - 1);
+	}
+	printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d get irq : %2d\n",
+		dev->vendor, dev->device, pirq, irq);
+	return irq;
+}
+
+static int pirq_amd756_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d SET irq : %2d\n", 
+		dev->vendor, dev->device, pirq, irq);
+	if (pirq <= 4)
+	{
+		write_config_nybble(router, 0x56, pirq - 1, irq);
+	}
+	return 1;
+}
+
 #ifdef CONFIG_PCI_BIOS
 
 static int pirq_bios_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
@@ -426,6 +458,8 @@
 	{ "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set },
 	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4,
 	  pirq_serverworks_get, pirq_serverworks_set },
+	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
+		pirq_amd756_get, pirq_amd756_set },
 
 	{ "default", 0, 0, NULL, NULL }
 };

--------------4D7C0921CA0432C1ED14F2F2--

