Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWGYUFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWGYUFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWGYUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:05:05 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:53006 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964850AbWGYUFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:05:04 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Debugging APM - cat /proc/apm produces oops
Date: Tue, 25 Jul 2006 22:04:57 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
References: <200607231630.53968.linux@rainbow-software.org> <20060724010658.687e78be.sfr@canb.auug.org.au>
In-Reply-To: <20060724010658.687e78be.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607252204.57795.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my "fix" - patches BIOS in shadow RAM. Ugly but allows me to use APM battery status.
Probably not worth including in the kernel but it might help someone...

--- linux-2.6.17.5-orig/drivers/pci/quirks.c	2006-07-15 04:38:43.000000000 +0200
+++ linux-2.6.17.5/drivers/pci/quirks.c	2006-07-26 18:41:01.000000000 +0200
@@ -1404,6 +1404,36 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
+#ifdef CONFIG_X86
+/* 
+ * Fix DTK FortisPro TOP-5A APM BIOS bug which causes oops on /proc/apm access
+ * Most probably works only with the latest BIOS rev 2.31
+ */
+static void __devinit quirk_dtk_top5a(struct pci_dev *dev)
+{
+	u8 *patch_addr_1 = __va(0xf2f9d);
+	u8 orig_1[] = { 0x89, 0x5e, 0xfe }; /* mov [bp-2],bx -> this causes oops */
+	u8 patch_1[] = { 0x90, 0x90, 0x90 }; /* 3x nop */
+	u8 *patch_addr_2 = __va(0xf2fad);
+	u8 orig_2[] = { 0x83, 0x7e, 0xfe, 0x01, /* cmp w,[bp-2],1 -> second oops */
+			0x74 }; 		/* je somewhere -> this must be changed to jmps */
+	u8 patch_2[] = { 0x90, 0x90, 0x90, 0x90, 0xeb }; /* 4x nop + jmps */
+	u8 shadow_cfg;
+
+	/* Check if it's the buggy BIOS */
+	if (memcmp(patch_addr_1, &orig_1[0], ARRAY_SIZE(orig_1)) ||
+	    memcmp(patch_addr_2, &orig_2[0], ARRAY_SIZE(orig_2)))
+		return;
+
+	printk(KERN_INFO "Fixing DTK FortisPro TOP-5A APM BIOS bug\n");
+	pci_read_config_byte(dev, 0x59, &shadow_cfg);
+	pci_write_config_byte(dev, 0x59, 0x20);	/* enable shadow BIOS writes */
+	memcpy(patch_addr_1, patch_1, ARRAY_SIZE(patch_1));
+	memcpy(patch_addr_2, patch_2, ARRAY_SIZE(patch_2));
+	pci_write_config_byte(dev, 0x59, shadow_cfg);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439TX,	quirk_dtk_top5a);
+#endif /* CONFIG_X86 */
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {

-- 
Ondrej Zary
