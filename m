Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVHRIqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVHRIqn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVHRIqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:46:43 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:44111 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932121AbVHRIqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:46:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gfKRGXNKzx25KB9suI6f2e95zM1nBRGS7j5tl0xNwBgfjpCRkXi6sDVfgh+oF/pu2Ys+o7IQL2zgKz8Q1LAYm57xDfRQ+Z+twvIbn3LSCXXMZEcgCTfHiU6lXSFYVAUSdC3Uu1tKwF++Vb8kaYbPpPlLmCYnwUuMWiIWg45efJc=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] quirk_via_vt8237_bypass_apic_deassert
Date: Thu, 18 Aug 2005 10:47:34 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508181047.34228.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This helps at least on Ingo's and my AMD64@K8T800
and shouldn't bite anybody else.
Please add to -mm for later inclusion into mainline.

   Thanks,
   Karsten

------
From: Karsten Wiese <annabellesgarden@yahoo.de>

The VIA VT8237's IOAPIC sends 'APIC De-Assert Messages' by default,
causing another CPU interrupt when the IRQ pin is de-asserted.
This feature is switched off by the patch to get rid of
doubled ioapic level interrupt rates.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- linux-2.6.13-rc6/drivers/pci/quirks.c	2005-08-08 11:46:05.000000000 +0200
+++ linux-2.6.13/drivers/pci/quirks.c	2005-08-18 10:15:06.000000000 +0200
@@ -403,6 +403,25 @@ static void __devinit quirk_via_ioapic(s
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic );
 
 /*
+ * VIA 8237: Some BIOSs don't set the 'Bypass APIC De-Assert Message' Bit.
+ * This leads to doubled level interrupt rates.
+ * Set this bit to get rid of cycle wastage.
+ * Otherwise uncritical.
+ */
+static void __devinit quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
+{
+	u8 misc_control2;
+#define BYPASS_APIC_DEASSERT 8
+
+	pci_read_config_byte(dev, 0x5B, &misc_control2);
+	if (!(misc_control2 & BYPASS_APIC_DEASSERT)) {
+		printk(KERN_INFO "PCI: Bypassing VIA 8237 APIC De-Assert Message\n");
+		pci_write_config_byte(dev, 0x5B, misc_control2|BYPASS_APIC_DEASSERT);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
+
+/*
  * The AMD io apic can hang the box when an apic irq is masked.
  * We check all revs >= B0 (yet not in the pre production!) as the bug
  * is currently marked NoFix

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
