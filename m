Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWAYGCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWAYGCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWAYGCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:02:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751023AbWAYGCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:02:31 -0500
Date: Tue, 24 Jan 2006 22:05:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David Luyer" <david@luyer.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Reuben Farrelly <reuben-lkml@reub.net>, Daniel Drake <dsd@gentoo.org>
Subject: [RFT] sky2: pci express error fix
Message-ID: <20060124220533.5fade501@localhost.localdomain>
In-Reply-To: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For all those people suffering with pci express errors
on the sky2 driver.  The problem is the PCI subsystem sometimes
won't let the sky2 driver write to PCI express registers. It depends
on the phase of the moon (actually ACPI) and number of devices.

Anyway, this should fix it. Please tell me if it solves it for you.


--- sky2-2.6.orig/drivers/net/sky2.c
+++ sky2-2.6/drivers/net/sky2.c
@@ -2003,19 +2003,16 @@ static void sky2_hw_intr(struct sky2_hw 
 
 	if (status & Y2_IS_PCI_EXP) {
 		/* PCI-Express uncorrectable Error occurred */
-		u32 pex_err;
-
-		pci_read_config_dword(hw->pdev, PEX_UNC_ERR_STAT, &pex_err);
+		u32 pex_err = sky2_read32(hw, PCI_C(PEX_UNC_ERR_STAT));
 
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
 			       pci_name(hw->pdev), pex_err);
 
 		/* clear the interrupt */
-		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
-				       0xffffffffUL);
-		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
+		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
+		sky2_write32(hw, PCI_CI(PEX_UNC_ERR_STAT), 0xffffffffUL);
+		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 
 		if (pex_err & PEX_FATAL_ERRORS) {
 			u32 hwmsk = sky2_read32(hw, B0_HWE_IMSK);
@@ -2181,12 +2178,8 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
 	/* clear any PEX errors */
-	if (is_pciex(hw)) {
-		u16 lstat;
-		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
-				       0xffffffffUL);
-		pci_read_config_word(hw->pdev, PEX_LNK_STAT, &lstat);
-	}
+	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP))
+		sky2_write32(hw, PCI_C(PEX_UNC_ERR_STAT), 0xffffffffUL);
 
 	pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
--- sky2-2.6.orig/drivers/net/sky2.h
+++ sky2-2.6/drivers/net/sky2.h
@@ -183,6 +183,12 @@ enum csr_regs {
 	Y2_CFG_SPC	= 0x1c00,
 };
 
+/* Workaround for ACPI limitations in pci support.
+ * Sometimes it is impossible to access registers > 256 with
+ * pci_{read/write}_config_dword
+ */
+#define PCI_C(reg)	(Y2_CFG_SPC + reg)
+
 /*	B0_CTST			16 bit	Control/Status register */
 enum {
 	Y2_VMAIN_AVAIL	= 1<<17,/* VMAIN available (YUKON-2 only) */
