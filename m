Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbTDIKu0 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTDIKu0 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 06:50:26 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:2246 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262988AbTDIKuX (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 06:50:23 -0400
Subject: Re: Linux 2.4.21-pre7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: Kaj-Michael Lang <milang@tal.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linuxppc-dev@lists.linuxppc.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16019.62440.828553.117381@gargle.gargle.HOWL>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
	 <00b101c2fdeb$e1aa6e20$56dc10c3@amos>
	 <16019.60959.273586.121431@gargle.gargle.HOWL>
	 <1049882960.559.35.camel@zion.wanadoo.fr>
	 <16019.62440.828553.117381@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049886100.559.38.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Apr 2003 13:01:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 12:20, mikpe@csd.uu.se wrote:

> Ok, I can understand what happened, but shouldn't these fixes be
> cc:d to or at last announced on LKML as well? It could be a month
> before Marcelo does a -pre8 or -rc1.

Well.. Most PPC users use the PPC trees and most pmac users use
mine, so I didn't bother, but here it is:

diff -urN linux-2.4/drivers/ide/ppc/pmac.c linuxppc_benh_devel/drivers/ide/ppc/pmac.c
--- linux-2.4/drivers/ide/ppc/pmac.c	2003-04-05 21:45:19.000000000 +0200
+++ linuxppc_benh_devel/drivers/ide/ppc/pmac.c	2003-04-05 16:56:00.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ppc/ide-pmac.c
+ * linux/drivers/ide/ppc/pmac.c
  *
  * Support for IDE interfaces on PowerMacs.
  * These IDE interfaces are memory-mapped and have a DBDMA channel
@@ -408,7 +408,7 @@
 	else
 		writel(pmif->timings[0],
 			(unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG));
-	io_flush(readl((unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG)));
+	(void)readl((unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG));
 }
 
 static void __pmac
@@ -430,7 +430,7 @@
 		writel(pmif->timings[2],
 		       (unsigned *)(IDE_DATA_REG + IDE_KAUAI_ULTRA_CONFIG));
 	}
-	io_flush(readl((unsigned *)(IDE_DATA_REG + IDE_KAUAI_PIO_CONFIG)));
+	(void)readl((unsigned *)(IDE_DATA_REG + IDE_KAUAI_PIO_CONFIG));
 }
 
 static void __pmac
@@ -454,7 +454,6 @@
 	
 	writeb(value, port);	
 	tmp = readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG));
-	io_flush(value);
 }
 
 static int __pmac
@@ -469,7 +468,7 @@
 	SELECT_MASK(drive, 0);
 	udelay(1);
 	/* Get rid of pending error state */
-	io_flush(hwif->INB(IDE_STATUS_REG));
+	(void)hwif->INB(IDE_STATUS_REG);
 	/* Timeout bumped for some powerbooks */
 	if (wait_for_ready(drive, 2000)) {
 		/* Timeout bumped for some powerbooks */
@@ -1139,7 +1138,7 @@
 		/* Tell common code _not_ to mess with resources */
 		hwif->mmio = 2;
 		hwif->hwif_data = pmif;
-		pmac_ide_init_hwif_ports(&hwif->hw, base, 0, &hwif->irq);
+		pmac_ide_init_hwif_ports(&hwif->hw, regbase, 0, &hwif->irq);
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->chipset = ide_pmac;
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || in_bay;
@@ -1568,7 +1567,7 @@
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
 		writel(pmif->timings[unit]+0x00800000UL,
 			(unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG));
-		io_flush(readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG)));
+		(void)readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG));
 	}
 
 	drive->waiting_for_dma = 1;	
@@ -1624,7 +1623,7 @@
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
 		writel(pmif->timings[unit],
 			(unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG));
-		io_flush(readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG)));
+		(void)readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG));
 	}
 
 	drive->waiting_for_dma = 1;
@@ -1674,7 +1673,7 @@
 
 	writel((RUN << 16) | RUN, &dma->control);
 	/* Make sure it gets to the controller right now */
-	io_flush(readl(&dma->control));
+	(void)readl(&dma->control);
 	return 0;
 }
 
@@ -1791,11 +1790,10 @@
 			printk(KERN_ERR "ide-pmac(%s): can't request DMA resource !\n", np->name);
 			return;
 		}
+		pmif->dma_regs =
+			(volatile struct dbdma_regs*)ioremap(np->addrs[1].address, 0x200);
 	}
 
-	pmif->dma_regs =
-		(volatile struct dbdma_regs*)ioremap(np->addrs[1].address, 0x200);
-
 	/*
 	 * Allocate space for the DBDMA commands.
 	 * The +2 is +1 for the stop command and +1 to allow for
@@ -1863,7 +1861,7 @@
 		SELECT_DRIVE(drive);
 		SELECT_MASK(drive, 0);
 		hwif->OUTB(drive->select.all, IDE_SELECT_REG);
-		io_flush(hwif->INB(IDE_SELECT_REG));
+		(void) hwif->INB(IDE_SELECT_REG);
 		udelay(100);
 		hwif->OUTB(0x00, IDE_SECTOR_REG);
 		hwif->OUTB(0x00, IDE_NSECTOR_REG);

