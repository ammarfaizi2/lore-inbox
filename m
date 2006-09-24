Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWIXPCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWIXPCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 11:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIXPCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 11:02:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:446 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751143AbWIXPCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 11:02:15 -0400
Date: Sun, 24 Sep 2006 16:59:25 +0200 (MEST)
Message-Id: <200609241459.k8OExPba016954@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, jgarzik@pobox.com
Subject: [BUG 2.6.18] sata_promise unaligned PCI accesses on sparc64
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.18 kernel's sata_promise driver causes alignment
traps in my Ultra5 sparc64 machine. dmesg shows:

SCSI subsystem initialized
libata version 2.00 loaded.
sata_promise 0000:02:03.0: version 1.04
Kernel unaligned access at TPC[100a8cbc] pdc_ata_init_one+0x284/0x308 [sata_promise]
Kernel unaligned access at TPC[100a8cd0] pdc_ata_init_one+0x298/0x308 [sata_promise]
Kernel unaligned access at TPC[100a8cd4] pdc_ata_init_one+0x29c/0x308 [sata_promise]
ata1: SATA max UDMA/133 cmd 0x1FF00008200 ctl 0x1FF00008238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0x1FF00008280 ctl 0x1FF000082B8 bmdma 0x0 irq 18
scsi0 : sata_promise
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05

Using debug printk:s I've traced this to the three PDC_TBG_MODE
accesses in sata_promise.c:pdc_host_init():

	/* reduce TBG clock to 133 Mhz. */
	tmp = readl(mmio + PDC_TBG_MODE);
	tmp &= ~0x30000; /* clear bit 17, 16*/
	tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
	writel(tmp, mmio + PDC_TBG_MODE);

	readl(mmio + PDC_TBG_MODE);	/* flush */

The debugging printk:s also showed that mmio points to
0x000001ff00008000 and that PDC_TBG_MODE is 65, so mmio+PDC_TBG_MODE
cannot possibly be 32-bit aligned.

>From reading sata_promise.c it appears that PDC_TBG_MODE also
intersects both PDC_INT_SEQMASK and PDC_FLASH_CTL, which I find weird.

/Mikael
