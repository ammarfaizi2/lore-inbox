Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWASLHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWASLHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWASLHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:07:12 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:39413 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161151AbWASLHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:07:11 -0500
Message-ID: <43CF72FC.9060207@gentoo.org>
Date: Thu, 19 Jan 2006 11:07:40 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: David Luyer <david@luyer.net>
CC: Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: SKY2 driver - version 0.13 - buggy but working
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
In-Reply-To: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
Content-Type: multipart/mixed;
 boundary="------------010208000405030101050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208000405030101050104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Luyer wrote:
> Your new SKY2 driver in the latest 2.6.16-rc1 snapshots does millions
> of printk()s (approximately 230,000 per second) ... but works!
> 
> Motherboard: A7V-E SE (onboard Marvel GE)
> OS: Linux current snapshot (2.6.16-rc1-g0f36b018), 32-bit on AMD64
> PCI options: ACPI, PCI, PCI Express, MSI enabled
> 
> dmesg|egrep 'sky2|messages suppressed':
> 
> sky2 v0.13 addr 0xdc000000 irq 66 Yukon-EC (0xb6) rev 2
> sky2 eth0: addr 00:13:d4:f6:be:52
> sky2 0000:05:00.0: pci express error (0x0)

Can you see if this patch makes any difference?

Thanks.


--------------010208000405030101050104
Content-Type: text/x-patch;
 name="sky2-error-reporting.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sky2-error-reporting.patch"

Date: Wed, 11 Jan 2006 15:37:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Dmitrij D. Czarkoff" <czarkoff@yandex.ru>, Daniel Drake
 <dsd@gentoo.org>
Cc: netdev@vger.kernel.org
Subject: sky2: error reporting
Message-ID: <20060111153701.26d66526@dxpl.pdx.osdl.net>
In-Reply-To: <200601112116.46099.czarkoff@yandex.ru>
References: <200601112116.46099.czarkoff@yandex.ru>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
X-Virus-Scan: scanned

Try this, it limits the console output and attempts to handle more
errors. Of course, I see no errors on my systems (that would make
this problem too easy)...

Index: sky2-work/drivers/net/sky2.c
===================================================================
--- sky2-work.orig/drivers/net/sky2.c	2006-01-11 13:54:23.000000000 -0800
+++ sky2-work/drivers/net/sky2.c	2006-01-11 15:19:56.000000000 -0800
@@ -1900,8 +1900,9 @@
 {
 	struct net_device *dev = hw->dev[port];
 
-	printk(KERN_INFO PFX "%s: hw error interrupt status 0x%x\n",
-	       dev->name, status);
+	if (printk_ratelimit())
+		printk(KERN_INFO PFX "%s: hw error interrupt status 0x%x\n",
+		       dev->name, status);
 
 	if (status & Y2_IS_PAR_RD1) {
 		printk(KERN_ERR PFX "%s: ram data read parity error\n",
@@ -1918,12 +1919,14 @@
 	}
 
 	if (status & Y2_IS_PAR_MAC1) {
-		printk(KERN_ERR PFX "%s: MAC parity error\n", dev->name);
+		if (printk_ratelimit())
+			printk(KERN_ERR PFX "%s: MAC parity error\n", dev->name);
 		sky2_write8(hw, SK_REG(port, TX_GMF_CTRL_T), GMF_CLI_TX_PE);
 	}
 
 	if (status & Y2_IS_PAR_RX1) {
-		printk(KERN_ERR PFX "%s: RX parity error\n", dev->name);
+		if (printk_ratelimit())
+			printk(KERN_ERR PFX "%s: RX parity error\n", dev->name);
 		sky2_write32(hw, Q_ADDR(rxqaddr[port], Q_CSR), BMU_CLR_IRQ_PAR);
 	}
 
@@ -1935,43 +1938,64 @@
 
 static void sky2_hw_intr(struct sky2_hw *hw)
 {
+	struct pci_dev *pdev = hw->pdev;
 	u32 status = sky2_read32(hw, B0_HWE_ISRC);
 
+	sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
+	/* This driver doesn't use receive timestamps */
 	if (status & Y2_IS_TIST_OV)
 		sky2_write8(hw, GMAC_TI_ST_CTRL, GMT_ST_CLR_IRQ);
 
+	if (status & Y2_IS_PCI_NEXP) {
+		if (printk_ratelimit())
+			printk(KERN_INFO PFX "%s: pci express abort\n",
+			       pci_name(pdev));
+	}
+
 	if (status & (Y2_IS_MST_ERR | Y2_IS_IRQ_STAT)) {
 		u16 pci_err;
 
-		pci_read_config_word(hw->pdev, PCI_STATUS, &pci_err);
-		printk(KERN_ERR PFX "%s: pci hw error (0x%x)\n",
-		       pci_name(hw->pdev), pci_err);
+		pci_read_config_word(pdev, PCI_STATUS, &pci_err);
+		if (printk_ratelimit())
+			printk(KERN_ERR PFX "%s: pci hw error (0x%x)\n",
+			       pci_name(pdev), pci_err);
 
-		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		pci_write_config_word(hw->pdev, PCI_STATUS,
+		pci_write_config_word(pdev, PCI_STATUS,
 				      pci_err | PCI_STATUS_ERROR_BITS);
-		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	}
 
-	if (status & Y2_IS_PCI_EXP) {
-		/* PCI-Express uncorrectable Error occurred */
-		u32 pex_err;
+	if (status & Y2_IS_PCI_EXP) {		/* PCI-Express error */
+		u32 err;
 
-		pci_read_config_dword(hw->pdev, PEX_UNC_ERR_STAT, &pex_err);
+		pci_read_config_dword(pdev, PEX_UNC_ERR_STAT, &err);
+		if (err) {
+			if (net_ratelimit())
+				printk(KERN_INFO PFX
+				       "%s: pci express uncorrectable error (0x%x)\n",
+				       pci_name(pdev), err);
 
-		printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
-		       pci_name(hw->pdev), pex_err);
+			if (err & PEX_FATAL_ERRORS) {
+				u32 hwmsk = sky2_read32(hw, B0_HWE_IMSK);
 
-		/* clear the interrupt */
-		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
-				       0xffffffffUL);
-		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
+				printk(KERN_ERR PFX "%s: adapter failed\n", pci_name(pdev));
 
-		if (pex_err & PEX_FATAL_ERRORS) {
-			u32 hwmsk = sky2_read32(hw, B0_HWE_IMSK);
-			hwmsk &= ~Y2_IS_PCI_EXP;
-			sky2_write32(hw, B0_HWE_IMSK, hwmsk);
+				hwmsk &= ~Y2_IS_PCI_EXP;
+				sky2_write32(hw, B0_HWE_IMSK, hwmsk);
+
+				/* Should we turn off all interrupts?? */
+			}
+
+			/* clear the interrupt */
+			pci_write_config_dword(pdev, PEX_UNC_ERR_STAT, 0xffffffffUL);
+		}
+
+		pci_read_config_dword(pdev, PEX_COR_ERR_STAT, &err);
+		if (err) {
+			if (printk_ratelimit())
+				printk(KERN_INFO PFX
+				       "%s: pci express correctable error (0x%x)\n",
+				       pci_name(pdev), err);
+			pci_write_config_dword(pdev, PEX_COR_ERR_STAT, 0xffffffffUL);
 		}
 	}
 
@@ -1980,6 +2004,8 @@
 	status >>= 8;
 	if (status & Y2_HWE_L1_MASK)
 		sky2_hw_error(hw, 1, status);
+
+	sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 }
 
 static void sky2_mac_intr(struct sky2_hw *hw, unsigned port)
Index: sky2-work/drivers/net/sky2.h
===================================================================
--- sky2-work.orig/drivers/net/sky2.h	2006-01-11 13:54:23.000000000 -0800
+++ sky2-work/drivers/net/sky2.h	2006-01-11 15:18:12.000000000 -0800
@@ -10,9 +10,25 @@
 #define PCI_DEV_STATUS  0x7c
 #define PCI_OS_PCI_X    (1<<26)
 
-#define PEX_LNK_STAT	0xf2
-#define PEX_UNC_ERR_STAT 0x104
-#define PEX_DEV_CTRL	0xe8
+#define PEX_CAP_ID	0xe0	/*  8 bit	PEX Capability ID */
+#define PEX_NITEM	0xe1	/*  8 bit	PEX Next Item Pointer */
+#define PEX_CAP_REG	0xe2	/* 16 bit	PEX Capability Register */
+#define PEX_DEV_CAP	0xe4	/* 32 bit	PEX Device Capabilities */
+#define PEX_DEV_CTRL	0xe8	/* 16 bit	PEX Device Control */
+#define PEX_DEV_STAT	0xea	/* 16 bit	PEX Device Status */
+#define PEX_LNK_CAP	0xec	/* 32 bit	PEX Link Capabilities */
+#define PEX_LNK_CTRL	0xf0	/* 16 bit	PEX Link Control */
+#define PEX_LNK_STAT	0xf2	/* 16 bit	PEX Link Status */
+
+/* PCI Express Extended Capabilities */
+#define PEX_ADV_ERR_REP	 0x100	/* 32 bit	PEX Advanced Error Reporting */
+#define PEX_UNC_ERR_STAT 0x104	/* 32 bit	PEX Uncorr. Errors Status */
+#define PEX_UNC_ERR_MASK 0x108	/* 32 bit	PEX Uncorr. Errors Mask */
+#define PEX_UNC_ERR_SEV	 0x10c	/* 32 bit	PEX Uncorr. Errors Severity */
+#define PEX_COR_ERR_STAT 0x110	/* 32 bit	PEX Correc. Errors Status */
+#define PEX_COR_ERR_MASK 0x114	/* 32 bit	PEX Correc. Errors Mask */
+#define PEX_ADV_ERR_CAP_C 0x118	/* 32 bit	PEX Advanced Error Cap./Ctrl */
+#define PEX_HEADER_LOG	0x11c	/* 4x32 bit	PEX Header Log Register */
 
 /* Yukon-2 */
 enum pci_dev_reg_1 {


--------------010208000405030101050104--
