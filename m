Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbTLaAUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbTLaAUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:20:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14012 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265875AbTLaAUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:20:45 -0500
Message-ID: <3FF21648.8030604@pobox.com>
Date: Tue, 30 Dec 2003 19:20:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>
CC: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Hugo Mills <hugo-lkml@carfax.org.uk>
Subject: Re: [PATCH] adaptec 1210sa
References: <200312220305.29955.marchand@kde.org>
In-Reply-To: <200312220305.29955.marchand@kde.org>
Content-Type: multipart/mixed;
 boundary="------------030700020005090506000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700020005090506000107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mickael Marchand wrote:
> reading linux-scsi I found a suggestion by Justin to make adaptec's 1210 sa 
> working. I made the corresponding patch for libata, and it actually works :)
> 
> it needs  some redesign to only apply to aar1210 (as standard sil3112 does not 
> need it) and I guess some testing before inclusion.


Here is the patch I'm applying.  Please test and let me know how it goes.

Also, someone please send me a patch for the PCI ids :)

	Jeff



--------------030700020005090506000107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.3 vs edited =====
--- 1.3/drivers/scsi/sata_sil.c	Tue Dec 16 19:16:55 2003
+++ edited/drivers/scsi/sata_sil.c	Tue Dec 30 19:11:02 2003
@@ -40,6 +40,10 @@
 enum {
 	sil_3112		= 0,
 
+	SIL_SYSCFG		= 0x48,
+	SIL_MASK_IDE0_INT	= (1 << 22),
+	SIL_MASK_IDE1_INT	= (1 << 23),
+
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
 	SIL_IDE0_BMDMA		= 0x00,
@@ -236,6 +240,7 @@
 	unsigned long base;
 	void *mmio_base;
 	int rc;
+	u32 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -295,6 +300,14 @@
 	probe_ent->port[1].bmdma_addr = base + SIL_IDE1_BMDMA;
 	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
 	ata_std_ports(&probe_ent->port[1]);
+
+	/* make sure IDE0/1 interrupts are not masked */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	if (tmp & (SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT)) {
+		tmp &= ~(SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT);
+		writel(tmp, mmio_base + SIL_SYSCFG);
+		readl(mmio_base + SIL_SYSCFG);	/* flush */
+	}
 
 	pci_set_master(pdev);
 

--------------030700020005090506000107--

