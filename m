Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUCaQtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUCaQtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:49:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262100AbUCaQtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:49:01 -0500
Message-ID: <406AF66B.1030205@pobox.com>
Date: Wed, 31 Mar 2004 11:48:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Sebor <petr@scssoft.com>
CC: linux-kernel@vger.kernel.org, jpaana@s2.org
Subject: Re: [PATCH] Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com> <406A8035.2080108@pobox.com> <406AB08C.1040907@scssoft.com>
In-Reply-To: <406AB08C.1040907@scssoft.com>
Content-Type: multipart/mixed;
 boundary="------------040707090801030309010302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040707090801030309010302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Petr Sebor wrote:
> 2.6.5-rc3 + this patch:
> 
> sata_via (0000:00:0f.0): PATA sharing not supported (0x2)
> via_sata: probe of (0000:00:0f.0) failed with error -5


Thanks for testing.  OK, one bug fix and here's a new patch...

Thanks for all your help in narrowing this down,

	Jeff



--------------040707090801030309010302
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_via.c 1.10 vs edited =====
--- 1.10/drivers/scsi/sata_via.c	Thu Mar 25 07:30:08 2004
+++ edited/drivers/scsi/sata_via.c	Wed Mar 31 11:47:24 2004
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
+	if (tmp8 & SATA_2DEV) {
+		printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		rc = -EIO;
+		goto err_out_regions;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||

--------------040707090801030309010302--

