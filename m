Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWFRTO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWFRTO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWFRTOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:14:25 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:55704 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932288AbWFRTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:14:25 -0400
Date: Sun, 18 Jun 2006 20:14:22 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix resume
Message-ID: <20060618191421.GA15358@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some VIA southbridges contain a flag in the ACPI register space that 
indicates whether an abnormal poweroff has occured, presumably with the 
intention that it can be cleared on clean shutdown. Some BIOSes check 
this flag at resume time, and will re-POST the system rather than jump 
back to the OS if it's set. Clearing it at boot time appears to be 
sufficient. I'm not sure if drivers/pci/quirks.c is the right place to 
do it, but I'm not sure where would be cleaner.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7537260..2f9f996 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -660,6 +660,33 @@ static void __devinit quirk_vt82c598_id(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
 
+#ifdef CONFIG_ACPI
+
+/* Some VIA systems boot with the abnormal status flag set. This can cause
+ * the BIOS to re-POST the system on resume rather than passing control 
+ * back to the OS. Clear the flag on boot
+ */
+
+static void __devinit quirk_via_abnormal_poweroff(struct pci_dev *dev)
+{
+	u32 register;
+
+	acpi_hw_register_read (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_STATUS,
+			       &register);
+
+	if (register & 0x800) {
+		printk ("Clearing abnormal poweroff flag\n");
+		acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK,
+					ACPI_REGISTER_PM1_STATUS,
+					(u16)0x800);
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_VIA, PCI_DEVICE_ID_VIA_8235, quirk_via_abnormal_poweroff);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_abnormal_poweroff);
+
+#endif
+
 /*
  * CardBus controllers have a legacy base address that enables them
  * to respond as i82365 pcmcia controllers.  We don't want them to

-- 
Matthew Garrett | mjg59@srcf.ucam.org
