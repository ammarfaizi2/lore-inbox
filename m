Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUFKQ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUFKQ0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUFKQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:19:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14233 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264153AbUFKQQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:19 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [4/12]
Date: Fri, 11 Jun 2004 17:55:02 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111755.02325.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell, is icside part okay?

[PATCH] ide: kill hw_regs_t->dma

hw_regs_t->dma is needed only by icside.c so make it local to this driver
(add unsigned int dma to struct icside_state) and kill it from hw_regs_t.
This allows us also to remove arm specific NO_DMA define from <linux/ide.h>.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/arm/icside.c      |   22 +++++++++--------
 linux-2.6.7-rc3-bzolnier/drivers/ide/h8300/ide-h8300.c |    1 
 linux-2.6.7-rc3-bzolnier/drivers/ide/ide.c             |    1 
 linux-2.6.7-rc3-bzolnier/drivers/ide/legacy/q40ide.c   |    1 
 linux-2.6.7-rc3-bzolnier/include/linux/ide.h           |    5 ---
 5 files changed, 12 insertions(+), 18 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide_hw_dma drivers/ide/arm/icside.c
--- linux-2.6.7-rc3/drivers/ide/arm/icside.c~ide_hw_dma	2004-06-11 16:51:18.517860632 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/arm/icside.c	2004-06-11 16:51:18.538857440 +0200
@@ -69,6 +69,7 @@ struct icside_state {
 	unsigned long irq_port;
 	unsigned long slot_port;
 	unsigned int type;
+	unsigned int dma;
 	/* parent device... until the IDE core gets one of its own */
 	struct device *dev;
 	ide_hwif_t *hwif[2];
@@ -395,7 +396,7 @@ static int icside_dma_end(ide_drive_t *d
 
 	drive->waiting_for_dma = 0;
 
-	disable_dma(hwif->hw.dma);
+	disable_dma(state->dma);
 
 	/* Teardown mappings after DMA has completed. */
 	dma_unmap_sg(state->dev, hwif->sg_table, hwif->sg_nents,
@@ -403,16 +404,17 @@ static int icside_dma_end(ide_drive_t *d
 
 	hwif->sg_dma_active = 0;
 
-	return get_dma_residue(hwif->hw.dma) != 0;
+	return get_dma_residue(state->dma) != 0;
 }
 
 static int icside_dma_begin(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct icside_state *state = hwif->hwif_data;
 
 	/* We can not enable DMA on both channels simultaneously. */
-	BUG_ON(dma_channel_active(hwif->hw.dma));
-	enable_dma(hwif->hw.dma);
+	BUG_ON(dma_channel_active(state->dma));
+	enable_dma(state->dma);
 	return 0;
 }
 
@@ -450,12 +452,13 @@ icside_dma_common(ide_drive_t *drive, st
 		  unsigned int dma_mode)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct icside_state *state = hwif->hwif_data;
 
 	/*
 	 * We can not enable DMA on both channels.
 	 */
 	BUG_ON(hwif->sg_dma_active);
-	BUG_ON(dma_channel_active(hwif->hw.dma));
+	BUG_ON(dma_channel_active(state->dma));
 
 	icside_build_sglist(drive, rq);
 
@@ -472,14 +475,14 @@ icside_dma_common(ide_drive_t *drive, st
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(hwif->hw.dma, drive->drive_data);
+	set_dma_speed(state->dma, drive->drive_data);
 
 	/*
 	 * Tell the DMA engine about the SG table and
 	 * data direction.
 	 */
-	set_dma_sg(hwif->hw.dma, hwif->sg_table, hwif->sg_nents);
-	set_dma_mode(hwif->hw.dma, dma_mode);
+	set_dma_sg(state->dma, hwif->sg_table, hwif->sg_nents);
+	set_dma_mode(state->dma, dma_mode);
 
 	drive->waiting_for_dma = 1;
 
@@ -773,6 +776,7 @@ icside_register_v6(struct icside_state *
 
 	state->irq_port   = port;
 	state->slot_port  = slot_port;
+	state->dma	  = ec->dma;
 	state->hwif[0]    = hwif;
 	state->hwif[1]    = mate;
 
@@ -786,7 +790,6 @@ icside_register_v6(struct icside_state *
 	hwif->serialized  = 1;
 	hwif->config_data = slot_port;
 	hwif->select_data = sel;
-	hwif->hw.dma      = ec->dma;
 
 	mate->maskproc    = icside_maskproc;
 	mate->channel     = 1;
@@ -795,7 +798,6 @@ icside_register_v6(struct icside_state *
 	mate->serialized  = 1;
 	mate->config_data = slot_port;
 	mate->select_data = sel | 1;
-	mate->hw.dma      = ec->dma;
 
 	if (ec->dma != NO_DMA && !request_dma(ec->dma, hwif->name)) {
 		icside_dma_init(hwif);
diff -puN drivers/ide/h8300/ide-h8300.c~ide_hw_dma drivers/ide/h8300/ide-h8300.c
--- linux-2.6.7-rc3/drivers/ide/h8300/ide-h8300.c~ide_hw_dma	2004-06-11 16:51:18.522859872 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/h8300/ide-h8300.c	2004-06-11 16:51:18.539857288 +0200
@@ -69,7 +69,6 @@ static inline void hw_setup(hw_regs_t *h
 		hw->io_ports[i] = CONFIG_H8300_IDE_BASE + H8300_IDE_GAP*i;
 	hw->io_ports[IDE_CONTROL_OFFSET] = CONFIG_H8300_IDE_ALT;
 	hw->irq = EXT_IRQ0 + CONFIG_H8300_IDE_IRQ;
-	hw->dma = NO_DMA;
 	hw->chipset = ide_generic;
 }
 
diff -puN drivers/ide/ide.c~ide_hw_dma drivers/ide/ide.c
--- linux-2.6.7-rc3/drivers/ide/ide.c~ide_hw_dma	2004-06-11 16:51:18.526859264 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide.c	2004-06-11 16:51:18.540857136 +0200
@@ -924,7 +924,6 @@ void ide_setup_ports (	hw_regs_t *hw,
 		}
 	}
 	hw->irq = irq;
-	hw->dma = NO_DMA;
 	hw->ack_intr = ack_intr;
 /*
  *	hw->iops = iops;
diff -puN drivers/ide/legacy/q40ide.c~ide_hw_dma drivers/ide/legacy/q40ide.c
--- linux-2.6.7-rc3/drivers/ide/legacy/q40ide.c~ide_hw_dma	2004-06-11 16:51:18.530858656 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/legacy/q40ide.c	2004-06-11 16:51:18.542856832 +0200
@@ -90,7 +90,6 @@ void q40_ide_setup_ports ( hw_regs_t *hw
 	}
 	
 	hw->irq = irq;
-	hw->dma = NO_DMA;
 	hw->ack_intr = ack_intr;
 /*
  *	hw->iops = iops;
diff -puN include/linux/ide.h~ide_hw_dma include/linux/ide.h
--- linux-2.6.7-rc3/include/linux/ide.h~ide_hw_dma	2004-06-11 16:51:18.534858048 +0200
+++ linux-2.6.7-rc3-bzolnier/include/linux/ide.h	2004-06-11 16:51:18.544856528 +0200
@@ -241,10 +241,6 @@ typedef unsigned char	byte;	/* used ever
 struct hwif_s;
 typedef int (ide_ack_intr_t)(struct hwif_s *);
 
-#ifndef NO_DMA
-#define NO_DMA  255
-#endif
-
 /*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
@@ -264,7 +260,6 @@ typedef enum {	ide_unknown,	ide_generic,
 typedef struct hw_regs_s {
 	unsigned long	io_ports[IDE_NR_PORTS];	/* task file registers */
 	int		irq;			/* our irq number */
-	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	void		*priv;			/* interface specific data */
 	hwif_chipset_t  chipset;

_

