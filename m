Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315195AbSEIWx3>; Thu, 9 May 2002 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSEIWx2>; Thu, 9 May 2002 18:53:28 -0400
Received: from web21506.mail.yahoo.com ([66.163.169.17]:44137 "HELO
	web21506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315195AbSEIWx0>; Thu, 9 May 2002 18:53:26 -0400
Message-ID: <20020509225325.10104.qmail@web21506.mail.yahoo.com>
Date: Thu, 9 May 2002 23:53:25 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: [PATCH] 2.4.18 IDE corruption (update)
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andre Hedrick <andre@linux-ide.org>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1805246264-1020984805=:8730"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1805246264-1020984805=:8730
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi...  This is a slightly "improved" version of the patch I first
floated last week (uses the spinlock now).

Summary: if a channel is shared by a DMA-using disk and a DMA-capable
CD, then loading the ide-cd or ide-scsi modules is liable to kill any
DMA transfers in flight on the disk while initialising the CDROM.  This
can cause serious disk corruption (has on my machine).

(Unless of course I've totally missed the point.)

Andre - can you check that this seems sane to you?

cheers
Neil
PS: bug also exists in 2.5.14, patch for that will go direct to Marcin.


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
--0-1805246264-1020984805=:8730
Content-Type: text/plain; name="ide_patch_2.4.18_090502.txt"
Content-Description: ide_patch_2.4.18_090502.txt
Content-Disposition: inline; filename="ide_patch_2.4.18_090502.txt"

--- ide-features.c.orig	Fri Feb  9 19:40:02 2001
+++ ide-features.c	Thu May  9 23:13:29 2002
@@ -281,12 +281,31 @@
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
+	 * The next test is a band-aid.  This is because it's possible to
+	 * enter this routine during DMA transfers, and as soon as we issued
+	 * the SELECT_DRIVE() command below, any such transfer would be hosed.
+	 * The RIGHT way to deal with this is probably either to queue the
+	 * call for execution when the hwgroup isn't busy, OR (dodgy?) to sleep
+	 * right here in this routine until it isn't busy.  We also now have
+	 * to use the io_request_lock spinlock to keep SMP systems honest.
+	 * This lot is temporary, pending a real fix.  NJC 9/5/02
+	 */
+	if (hwgroup->busy) {
+		spin_unlock_irqrestore(&io_request_lock, flags);
+		printk("Argh: hwgroup is busy in ide_config_drive_speed\n");
+		return error;
+	}
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	byte unit = (drive->select.b.unit & 0x01);
+	unit = (drive->select.b.unit & 0x01);
 	outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
@@ -347,6 +366,7 @@
 	enable_irq(hwif->irq);
 
 	if (error) {
+		spin_unlock_irqrestore(&io_request_lock, flags);
 		(void) ide_dump_status(drive, "set_drive_speed_status", stat);
 		return error;
 	}
@@ -380,6 +400,7 @@
 		case XFER_SW_DMA_0: drive->id->dma_1word |= 0x0101; break;
 		default: break;
 	}
+	spin_unlock_irqrestore(&io_request_lock, flags);
 	return error;
 }
 

--0-1805246264-1020984805=:8730--
