Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVHMPKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVHMPKY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVHMPKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 11:10:24 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:42414 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751332AbVHMPKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 11:10:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=xQLRHPYdIIpOrP3vtF1uRsc+600ytCfSJs39HcM0zSrdsGIsxOq/xv0lwDHeu2PUdaMRPKtTzwHZH+SfCyThrrjfONq0X1qrwoWNImrsBulKHT8cHpNYSvEZ6yKx5n5gpbrtYrCyu6qEBW4fKpV/SBlh4raqioEOXEPwr1LQqYc=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Sat, 13 Aug 2005 17:10:38 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508131710.38569.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this fixes the 'doubled ioapic level interrupt rate' issue I've been
seeing on a K8T800/AMD64 mainboard.
It also switches off quirk_via_irq() for the VT8237 southbridge.

As both changes are uncritical fixes, I'll post a real patch to -mm
in a week or so.

   Karsten


--- ../linux-2.6.13-rc6/drivers/pci/quirks.c    2005-08-08 11:46:05.000000000 +0200
+++ drivers/pci/quirks.c        2005-08-13 16:52:19.000000000 +0200
@@ -403,6 +403,25 @@ static void __devinit quirk_via_ioapic(s
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C686,       quirk_via_ioapic );

 /*
+ * VIA 8237: Some BIOSs don't set the 'Bypass APIC De-Assert Message' Bit.
+ * This leads to doubled level interrupt rates.
+ * Set this bit to get rid of cycle wastage.
+ * Otherwise uncritical.
+ */
+static void __devinit quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
+{
+       u8 misc_control2;
+#define BYPASS_APIC_DEASSERT 8
+
+       pci_read_config_byte(dev, 0x5B, &misc_control2);
+       if (!(misc_control2 & BYPASS_APIC_DEASSERT)) {
+               printk(KERN_INFO "PCI: Bypassing VIA 8237 APIC De-Assert Message\n");
+               pci_write_config_byte(dev, 0x5B, misc_control2|BYPASS_APIC_DEASSERT);
+       }
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_8237,         quirk_via_vt8237_bypass_apic_deassert);
+
+/*
  * The AMD io apic can hang the box when an apic irq is masked.
  * We check all revs >= B0 (yet not in the pre production!) as the bug
  * is currently marked NoFix
@@ -488,6 +507,47 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C686_4,     quirk_via_acpi );

 /*
+ * Devices part of the VIA VT8237 don't need quirk_via_irq().
+ * They also don't get confused by it, but dmesg gets quiter
+ * with this 'anti'-quirk.
+ * Here we are overly paranoic:
+ * we assume there might also exist via devices not part of the VT8237
+ * needing quirk_via_irq().
+ * This might never be the case in reality, when there is a VT8237.
+ */
+static unsigned int vt8237_devfn[] = {
+       PCI_DEVFN(15, 0),
+       PCI_DEVFN(15, 1),
+       PCI_DEVFN(16, 0),
+       PCI_DEVFN(16, 1),
+       PCI_DEVFN(16, 2),
+       PCI_DEVFN(16, 3),
+       PCI_DEVFN(16, 4),
+       PCI_DEVFN(16, 5),
+       PCI_DEVFN(17, 5),
+       PCI_DEVFN(17, 6),
+       PCI_DEVFN(18, 0)
+};
+static struct pci_dev *quirk_via_irq_not[ARRAY_SIZE(vt8237_devfn)];
+static void quirk_via_irq_not_for_8237(struct pci_dev *dev)
+{
+       // Make sure we do this only once
+       if (quirk_via_irq_not[0] != NULL)
+               return;
+
+       if (dev->devfn == PCI_DEVFN(0x11, 0)) {
+               int i, j;
+               for (i = 0, j = 0; i < ARRAY_SIZE(vt8237_devfn); i++) {
+                       struct pci_dev * d;
+                       d = pci_find_slot(dev->bus->number, vt8237_devfn[i]);
+                       if (d != NULL)
+                               quirk_via_irq_not[j++] = d;
+               }
+       }
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_irq_not_for_8237);
+
+/*
  * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
  * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
  * when written, it makes an internal connection to the PIC.
@@ -499,8 +559,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
+       int i;
        u8 irq, new_irq;

+       for (i = 0; i < ARRAY_SIZE(vt8237_devfn); i++)
+               if (quirk_via_irq_not[i] == dev)
+                       return;
+
+
        new_irq = dev->irq & 0xf;
        pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
        if (new_irq != irq) {
_

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
