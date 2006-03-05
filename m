Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWCET1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWCET1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWCET1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:27:13 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:56849 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751622AbWCET1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:27:13 -0500
Date: Sun, 5 Mar 2006 20:27:09 +0100
From: bjd <bjdouma@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Message-ID: <20060305192709.GA3789@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bauke Jan Douma <bjdouma@xs4all.nl>

On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
and MC97 modem controller are deactivated when a second PCI soundcard
is present.  This patch enables them.

Signed-off-by: Bauke Jan Douma <bjdouma@xs4all.nl>

---

When a PCI soundcard is present in an Asus A8V or A8V Deluxe system, the
BIOS will disable the onboard AC97 and MC97 devices.  This patch enables
them.  The soundcard now works on my A8V Deluxe, shows up in lspci output,
in /proc/asound/cards, has mixer controls, plays audio, on both 32 bits
and 64 bits systems.
Patch is against 2.6.16-rc3.


--- ./linux-2.6.16-rc3/drivers/pci/quirks.c.orig	2006-02-28 00:54:47.000000000
+0100
+++ ./linux-2.6.16-rc3/drivers/pci/quirks.c	2006-02-28 21:34:46.000000000 +0100
@@ -1074,6 +1074,37 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,
 quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,
 quirk_sis_96x_smbus );

+/*
+ * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
+ * and MC97 modem controller are disabled when a second PCI soundcard is
+ * present. This patch, tweaking the VT8237 ISA bridge, enables them.
+ * -- bjd
+ */
+static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
+{
+	u8 val;
+	int asus_hides_ac97 = 0;
+
+	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
+		if (dev->device == PCI_DEVICE_ID_VIA_8237)
+			asus_hides_ac97 = 1;
+	}
+
+	if (!asus_hides_ac97)
+		return;
+
+	pci_read_config_byte(dev, 0x50, &val);
+	if (val & 0xc0) {
+		pci_write_config_byte(dev, 0x50, val & (~0xc0));
+		pci_read_config_byte(dev, 0x50, &val);
+		if (val & 0xc0)
+			printk(KERN_INFO "PCI: onboard AC97/MC97 devices continue to
play 'hide and seek'! 0x%x\n", val);
+		else
+			printk(KERN_INFO "PCI: enabled onboard AC97/MC97 devices\n");
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,
asus_hides_ac97_lpc );
+
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
 {
