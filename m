Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbTGDACL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTGDACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:02:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20383 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265538AbTGDACI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:02:08 -0400
Date: Fri, 4 Jul 2003 02:16:31 +0200 (MEST)
Message-Id: <200307040016.h640GV7o018321@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH][2.5.74] fix IDE init oops on PowerMac
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting kernel 2.5.74 on a PowerMac with CONFIG_BLK_DEV_IDE_PMAC=y
results in an oops during IDE init, and the box then reboots.

The call chain at the oops is ideprobe_init() => probe_hwif() =>
__ide_dma_off_quietly() => HWIF(drive)->ide_dma_queued_off().
The HWIF(drive)->ide_dma_queued_off function pointer is NULL for
PMAC, which triggers the oops. Previously this call was conditional
on drive->queue_setup, but 2.5.74 made it unconditional.

The patch below updates drivers/ide/ppc/pmac.c to also set up the
hwif->ide_dma_queued_off and hwif->ide_dma_queued_on function
pointers, which fixes the oops. Tested on my ancient PM4400.

(I apologize for not including a full oops text, but the box has
no serial console.)

/Mikael

diff -ruN linux-2.5.74/drivers/ide/ppc/pmac.c linux-2.5.74.ide-pmac-fixes/drivers/ide/ppc/pmac.c
--- linux-2.5.74/drivers/ide/ppc/pmac.c	2003-05-28 22:16:00.000000000 +0200
+++ linux-2.5.74.ide-pmac-fixes/drivers/ide/ppc/pmac.c	2003-07-04 00:45:05.000000000 +0200
@@ -1514,6 +1514,8 @@
 	ide_hwifs[ix].ide_dma_timeout = &__ide_dma_timeout;
 	ide_hwifs[ix].ide_dma_retune = &__ide_dma_retune;
 	ide_hwifs[ix].ide_dma_lostirq = &pmac_ide_dma_lostirq;
+	ide_hwifs[ix].ide_dma_queued_on = &__ide_dma_queued_on;
+	ide_hwifs[ix].ide_dma_queued_off = &__ide_dma_queued_off;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
