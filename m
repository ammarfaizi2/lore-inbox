Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCaIYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUCaIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:24:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261794AbUCaIYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:24:36 -0500
Message-ID: <406A8035.2080108@pobox.com>
Date: Wed, 31 Mar 2004 03:24:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Petr Sebor <petr@scssoft.com>, jpaana@s2.org
Subject: [PATCH] Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
In-Reply-To: <4069FBC3.2080104@scssoft.com>
Content-Type: multipart/mixed;
 boundary="------------080505080901010606080404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505080901010606080404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Petr Sebor wrote:
> Hi Jeff,
> 
> I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
> sata drive anymore...
> 
> I am seeing this:
> -------------------------------------------------------------------
> libata version 1.02 loaded.
> sata_via version 0.20
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
> ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
> ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
> 88:203f
> ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)

Here's a potentially better patch, if you guys (or anyone else) would be 
willing to give it a quick test...?

	Jeff



--------------080505080901010606080404
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_via.c 1.10 vs edited =====
--- 1.10/drivers/scsi/sata_via.c	Thu Mar 25 07:30:08 2004
+++ edited/drivers/scsi/sata_via.c	Wed Mar 31 03:20:50 2004
@@ -39,9 +39,10 @@
 enum {
 	via_sata		= 0,
 
-	SATA_CHAN_ENAB		= 0x40,
-	SATA_INT_GATE		= 0x41,
-	SATA_NATIVE_MODE	= 0x42,
+	SATA_CHAN_ENAB		= 0x40, /* SATA channel enable */
+	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
+	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
+	SATA_PATA_SHARING	= 0x49, /* PATA/SATA sharing func ctrl */
 
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
@@ -51,6 +52,9 @@
 	INT_GATE_ALL		= PORT0 | PORT1,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
+
+	SATA_EXT_PHY		= (1 << 6), /* 0==use PATA, 1==ext phy */
+	SATA_2DEV		= (1 << 5), /* SATA is master/slave */
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -136,13 +140,7 @@
 
 static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
 {
-	if (port >= 4)
-		return 0;	/* invalid port */
-
-	addr &= ~((1 << 7) | (1 << 6));
-	addr |= ((unsigned long)port << 6);
-
-	return addr;
+	return addr + (port * 128);
 }
 
 /**
@@ -175,6 +173,13 @@
 	if (rc)
 		goto err_out;
 
+	pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
+	if ((tmp8 & (SATA_EXT_PHY | SATA_2DEV)) != SATA_EXT_PHY) {
+		printk(KERN_ERR DRV_NAME "(%s): PATA sharing not supported (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		rc = -EIO;
+		goto err_out_regions;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||

--------------080505080901010606080404--

