Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSK0KQb>; Wed, 27 Nov 2002 05:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSK0KQb>; Wed, 27 Nov 2002 05:16:31 -0500
Received: from web21503.mail.yahoo.com ([66.163.169.14]:18326 "HELO
	web21503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262040AbSK0KQZ>; Wed, 27 Nov 2002 05:16:25 -0500
Message-ID: <20021127102344.21982.qmail@web21503.mail.yahoo.com>
Date: Wed, 27 Nov 2002 10:23:44 +0000 (GMT)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: FS-corrupting IDE bug still in 2.4.20-rc3
To: Andre Hedrick <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1190404082-1038392624=:21963"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1190404082-1038392624=:21963
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Guys - you may remember this one from May this year.

I've been off-list and not paying much attention since Andre
acknowledged it was a bug (and didn't like my patch).

I recently needed to compile 2.4.19 and was surprised to find the bug
still present.  On examining 2.4.20-rc3 it still seems to be there too
-- no time to compile yet, sorry, but since 2.4.20 is imminent I
thought I should err on the side of caution and remind people about the
bug.

Let me be very clear: this bug has corrupted filesystems on three
machines of mine.  All of these had PIIX chipsets.  I have also
reproduced it on a VIA chipset, but since that machine was production I
didn't try very hard to corrupt the fs.

The patch is not a real fix, merely a workaround.  But since 6 months
have already elapsed, can I request that the patch be applied now, and
when Andre creates a proper fix we can use that.

I've updated the comments in the patch to reflect the fact that I now
realise it's not only DMA transfers that can be trashed by the bug.

Neil


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
--0-1190404082-1038392624=:21963
Content-Type: text/plain; name="ide_patch_2.4.20-rc3_261102.txt"
Content-Description: ide_patch_2.4.20-rc3_261102.txt
Content-Disposition: inline; filename="ide_patch_2.4.20-rc3_261102.txt"

--- ide-features.c.orig	Wed Nov 27 09:34:18 2002
+++ ide-features.c	Wed Nov 27 10:06:49 2002
@@ -272,12 +272,39 @@
  */
 int ide_config_drive_speed (ide_drive_t *drive, byte speed)
 {
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	ide_hwif_t *hwif = HWIF(drive);
 	int	i, error = 1;
-	byte stat;
+	byte stat,unit;
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	/*
+	 * XXXXX FIXME:
+	 * The next test is a band-aid.  This is because this routine can be
+	 * called while the hwgroup is busy - e.g., after a DMA or PIO
+	 * transfer has been initiated.  Known culprits: so far, the only
+	 * known way to trigger the bug is to load an IDE CD module (both
+	 * ide-scsi and ide-cd count) - on most chipsets, this ultimately
+	 * causes a call to this routine with no regard for the busy-ness of
+	 * the hwgroup.  If a transfer is in progress, then as soon as we issue
+	 * the SELECT_DRIVE() command below, we trash it.  This has caused
+	 * fs corruption (it probably shouldn't!).
+	 *
+	 * The RIGHT way to deal with this is probably either to queue the
+	 * call for execution when the hwgroup isn't busy, OR (dodgy?) to sleep
+	 * right here in this routine until it isn't busy.  We also now have
+	 * to use the io_request_lock spinlock to keep SMP systems honest.
+	 * This lot is temporary, pending a real fix.  NJC 9/5/02, 26/11/02
+	 */
+	if (hwgroup) if (hwgroup->busy) {
+		spin_unlock_irqrestore(&io_request_lock, flags);
+		printk("Argh: hwgroup is busy in ide_config_drive_speed\n");
+		return error;
+	}
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	byte unit = (drive->select.b.unit & 0x01);
+	unit = (drive->select.b.unit & 0x01);
 	outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
@@ -338,6 +365,7 @@
 	enable_irq(hwif->irq);
 
 	if (error) {
+		spin_unlock_irqrestore(&io_request_lock, flags);
 		(void) ide_dump_status(drive, "set_drive_speed_status", stat);
 		return error;
 	}
@@ -371,6 +399,7 @@
 		case XFER_SW_DMA_0: drive->id->dma_1word |= 0x0101; break;
 		default: break;
 	}
+	spin_unlock_irqrestore(&io_request_lock, flags);
 	return error;
 }
 

--0-1190404082-1038392624=:21963--
