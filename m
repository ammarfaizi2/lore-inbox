Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLHSsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTLHSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:48:47 -0500
Received: from columba1.eur.3com.com ([161.71.171.235]:43926 "EHLO
	columba1.eur.3com.com") by vger.kernel.org with ESMTP
	id S261563AbTLHSsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:48:43 -0500
Message-ID: <3FD4C785.4080306@jburgess.uklinux.net>
Date: Mon, 08 Dec 2003 18:48:37 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: raphael.rigo@inp-net.eu.org
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS?] 2.6-test11 : problem about irq18.
Content-Type: multipart/mixed;
 boundary="------------060204040806090701050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204040806090701050609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Raphaël Rigo wrote:

 > Dec 7 18:27:45 pici kernel: Disabling IRQ #18
 >
 > I am using a P4 2.6 Ghz without HT activated
 > 512 MB DDR PC3200 on an ASUS P4P800 Deluxe MB.
 > HardDrive is on SATA (native mode) : Maxtor 6Y120MO.

Sounds like the known problem with an interrupt storm with the ICH5
See "Issue #2" at 
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0597.html

 > 2.4.23 doesn't have this problem but keeps using 30-50% CPU even if I 
do nothing.

Try vmstat, I expect you'll see ~100k IRQ/s

You could try using the ata_piix driver (located amongst the SCSI drivers).

If that still doesn't help, you could try adding the patch attached to 
drivers/scsi/libata-core.c
this should make the ata_piix driver catch the spurious interrupts

    Jon


--------------060204040806090701050609
Content-Type: text/plain;
 name="libata-spurious2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-spurious2.diff"

--- libata-core.c-orig	2003-12-07 01:54:19.000000000 +0000
+++ libata-core.c	2003-12-07 16:25:11.961806872 +0000
@@ -2386,6 +2386,37 @@
 }
 
 /**
+ *	ata_chk_spurious_int - Check for spurious interrupts
+ *	@ap: port to which command is being issued
+ *
+ *	Examines the DMA status registers and clears
+ *      unexpected interrupts
+ *
+ *	LOCKING:
+ */
+static inline void ata_chk_spurious_int(struct ata_port *ap) {
+	int host_stat;
+	
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	
+	if ((host_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == ATA_DMA_INTR) {
+		if (ap->flags & ATA_FLAG_MMIO) {
+			void *mmio = (void *) ap->ioaddr.bmdma_addr;
+			writeb(host_stat & ~ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
+		} else
+			outb(host_stat & ~ATA_DMA_ERR, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		
+		DPRINTK("ata%u: Caught spurious interrupt, status 0x%X\n", ap->id, host_stat);
+		udelay(1);
+	}
+}
+
+
+/**
  *	ata_interrupt -
  *	@irq:
  *	@dev_instance:
@@ -2417,6 +2448,7 @@
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
 				handled += ata_host_intr(ap, qc);
+			ata_chk_spurious_int(ap);
 		}
 	}
 

--------------060204040806090701050609--

