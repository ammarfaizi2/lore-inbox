Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUBOPYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUBOPYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:24:09 -0500
Received: from topaz.cx ([66.220.6.227]:46269 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S264981AbUBOPWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:22:55 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3 - missing IDE hunk from bk4; good or bad?
X-Newsgroups: linux.kernel
In-Reply-To: <1pliv-6ya-5@gated-at.bofh.it>
From: chip@pobox.com (Chip Salzenberg)
Organization: NASA Calendar Research
Message-Id: <E1AsO6X-0003hW-1u@tytlal>
Date: Sun, 15 Feb 2004 10:22:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
>More merges, although most of them are architecture updates. IA64,
>ppc32/64, SuperH and ARM.

One non-arch difference between rc3 and bk4 seems to involve IDE DMA.
When I ran briefly ran bk4 I got a few IDE DMA errors (ThinkPad A30,
TOSHIBA MK8025GAS).  Makes one wonder.  Thus:

Is the IDE patch in bk4 (that's missing from rc3) going to be in
2.6.3?  Does it only come into play with SCSI, as it seems to, or
does it affect a non-SCSI setup?

Here's the diff between bk4 and rc3:

diff -ru2 linux-2.6.3rc2bk4/drivers/scsi/libata-core.c linux-2.6.3rc3/drivers/scsi/libata-core.c
--- linux-2.6.3rc2bk4/drivers/scsi/libata-core.c	2004-02-14 23:40:19.000000000 -0500
+++ linux-2.6.3rc3/drivers/scsi/libata-core.c	2004-02-15 01:51:34.000000000 -0500
@@ -2387,39 +2387,4 @@
 
 /**
- *	ata_chk_spurious_int - Check for spurious interrupts
- *	@ap: port to which command is being issued
- *
- *	Examines the DMA status registers and clears
- *      unexpected interrupts.  Created to work around
- *	hardware bug on Intel ICH5, but is applied to all
- *	chipsets using the standard irq handler, just for safety.
- *	If the bug is not present, this is simply a single
- *	PIO or MMIO read addition to the irq handler.
- *
- *	LOCKING:
- */
-static inline void ata_chk_spurious_int(struct ata_port *ap) {
-	int host_stat;
-	
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	
-	if ((host_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == ATA_DMA_INTR) {
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			writeb(host_stat & ~ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
-		} else
-			outb(host_stat & ~ATA_DMA_ERR, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-		
-		DPRINTK("ata%u: Caught spurious interrupt, status 0x%X\n", ap->id, host_stat);
-		udelay(1);
-	}
-}
-
-
-/**
  *	ata_interrupt -
  *	@irq:
@@ -2453,5 +2418,4 @@
 			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
 				handled += ata_host_intr(ap, qc);
-			ata_chk_spurious_int(ap);
 		}
 	}



-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
