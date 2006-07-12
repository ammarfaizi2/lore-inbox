Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWGLNrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWGLNrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWGLNrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:47:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45243 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751368AbWGLNrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:47:45 -0400
Subject: PATCH: Fix Jmicron support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 15:05:41 +0100
Message-Id: <1152713141.22943.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to 2.6.18rc1 you could install with devices on a JMicron chipset
using the "all-generic-ide" option. As of this kernel the AHCI driver
grabs the controller and rams it into AHCI mode losing the PATA ports
and making CD drives and the like vanish. The all-generic-ide option
fails because the AHCI driver grabbed the PCI device and reconfigured
it.

To fix this three things are needed.

#1 We must put the chip into dual function mode
#2 The AHCI driver must grab only function 0 (already in your rc1 tree)
#3 Something must grab the PATA ports

The attached patch is the minimal risk edition of this. It puts the chip
into dual function mode so that AHCI will grab the SATA ports without
losing the PATA ports. To keep the risk as low as possible the third
patch adds the PCI identifiers for the PATA port and the FN check to the
ide-generic driver. There is a more featured jmicron driver on its way
but that adds risk and the ide-generic support is sufficient to install
and run a system.

The actual chip setup done by the quirk is the precise setup recommended
by the vendor.

(The JMB368 appears only in the ide-generic entry as it has no AHCI so
does not need the quirk)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc1/drivers/ide/pci/generic.c linux-2.6.18-rc1/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.18-rc1/drivers/ide/pci/generic.c	2006-07-12 11:48:11.000000000 +0100
+++ linux-2.6.18-rc1/drivers/ide/pci/generic.c	2006-07-12 13:38:35.000000000 +0100
@@ -211,6 +211,9 @@
 	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		goto out;
+		
+	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
+		goto out;
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	if (!(command & PCI_COMMAND_IO)) {
@@ -239,6 +242,11 @@
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
 	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
 	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
 	{ 0, },
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc1/drivers/pci/quirks.c linux-2.6.18-rc1/drivers/pci/quirks.c
--- linux.vanilla-2.6.18-rc1/drivers/pci/quirks.c	2006-07-12 12:16:46.000000000 +0100
+++ linux-2.6.18-rc1/drivers/pci/quirks.c	2006-07-12 13:36:08.000000000 +0100
@@ -1174,6 +1174,55 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
+#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
+
+/*
+ *	If we are using libata we can drive this chip proeprly but must
+ *	do this early on to make the additional device appear during
+ *	the PCI scanning.
+ */
+ 
+static void __devinit quirk_jmicron_dualfn(struct pci_dev *pdev)
+{
+	u32 conf;
+	u8 hdr;
+
+	/* Only poke fn 0 */	
+	if (PCI_FUNC(pdev->devfn))
+		return;
+		
+	switch(pdev->device) {
+		case PCI_DEVICE_ID_JMICRON_JMB365:
+		case PCI_DEVICE_ID_JMICRON_JMB366:
+			/* Redirect IDE second PATA port to the right spot */
+			pci_read_config_dword(pdev, 0x80, &conf);
+			conf |= (1 << 24);
+			/* Fall through */
+			pci_write_config_dword(pdev, 0x80, conf);
+		case PCI_DEVICE_ID_JMICRON_JMB361:
+		case PCI_DEVICE_ID_JMICRON_JMB363:
+			pci_read_config_dword(pdev, 0x40, &conf);
+			/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
+			/* Set the class codes correctly and then direct IDE 0 */
+			conf &= ~0x000F0200;	/* Clear bit 9 and 16-19 */
+			conf |=  0x00C20002;	/* Set bit 1, 17, 22, 23 */
+			pci_write_config_dword(pdev, 0x40, conf);
+			
+			/* Reconfigure so that the PCI scanner discovers the
+			   device is now multifunction */
+			   
+			pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
+			pdev->hdr_type = hdr & 0x7f;
+			pdev->multifunction = !!(hdr & 0x80);
+			
+			break;
+	}
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
+
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
 {

