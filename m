Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTHCJ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHCJ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:58:44 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:26663
	"EHLO gaston") by vger.kernel.org with ESMTP id S271104AbTHCJ6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:58:42 -0400
Subject: Re: IDE locking problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1059900149.3524.84.camel@gaston>
References: <1059900149.3524.84.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059904692.3514.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 11:58:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And there's more to it... ide_unregister() doesn't copy hwif->hold from
old to new hwif causing my hotswap bay to lose it's iops on next plug,
it doesn't call unregister_device() for neither hwif->gendev nor
drive[n]->gendev, causing the device model list to be corrupted after
an unregister, ...

Here's a patch that makes it work (media bay hotswap works and doesn't
break the device model device list), however, locking is probably broken
as hell (I just release the spinlock here or there).

I'm not sure what is the best way to fix that locking issue. Regarding
userland access, I beleive the settings semaphore is the way to go.
Regarding the blk queue, I don't know what's the "official" way to
atomically tear down a queue, making sure we properly complete (fail ?)
requests that may have slipped in, and make sure that queue won't be
called again, Jens ? In most cases, once that's done, the rest of
the locking in ide_unregister() is mostly to guard against userland
access (settings) and other ide_register() trying to take the slot
while we are still cleaning up, which can be dealt either with a 
"I'm busy housekeeping" flag in hwif, or a semaphore.

What do you think ?

In the meantime, here's the patch that at least makes it work, though
it's probably still racy: (Against 2.6-test2)

(Note to PPC users: there are other bugs in current
drivers/macintosh/mediabay.c in there that need fixes I have here, those
will be pushed separately).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1008  -> 1.1009 
#	   drivers/ide/ide.c	1.58    -> 1.59   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/03	benh@kernel.crashing.org	1.1009
# Fixes to ide_unregister() to avoid device list corruption and
# scheduling at interrupt time. Also make sure "hold" flag is
# properly transferred from old to new interface
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Sun Aug  3 11:57:56 2003
+++ b/drivers/ide/ide.c	Sun Aug  3 11:57:56 2003
@@ -689,8 +689,8 @@
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
 #endif
-	hwgroup = hwif->hwgroup;
 
+	hwgroup = hwif->hwgroup;
 	/*
 	 * free the irq if we were the only hwif using it
 	 */
@@ -745,7 +745,11 @@
 			drive->id = NULL;
 		}
 		drive->present = 0;
+		/* Fucked up locking ... */
+		spin_unlock_irq(&ide_lock);
 		blk_cleanup_queue(&drive->queue);
+		device_unregister(&drive->gendev);
+		spin_lock_irq(&ide_lock);
 	}
 	if (hwif->next == hwif) {
 		BUG_ON(hwgroup->hwif != hwif);
@@ -770,6 +774,11 @@
 		BUG_ON(hwgroup->hwif == hwif);
 	}
 
+	/* More fucked up locking ... */
+	spin_unlock_irq(&ide_lock);
+	device_unregister(&hwif->gendev);
+	spin_lock_irq(&ide_lock);
+
 #if !defined(CONFIG_DMA_NONPCI)
 	if (hwif->dma_base) {
 		(void) ide_release_dma(hwif);
@@ -794,6 +803,7 @@
 		put_disk(disk);
 	}
 	unregister_blkdev(hwif->major, hwif->name);
+
 	old_hwif			= *hwif;
 	init_hwif_data(index);	/* restore hwif data to pristine status */
 	hwif->hwgroup			= old_hwif.hwgroup;
@@ -812,6 +822,7 @@
 	hwif->swdma_mask		= old_hwif.swdma_mask;
 
 	hwif->chipset			= old_hwif.chipset;
+	hwif->hold			= old_hwif.hold;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	hwif->pci_dev			= old_hwif.pci_dev;
@@ -864,6 +875,13 @@
 	hwif->ide_dma_retune		= old_hwif.ide_dma_retune;
 	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
 	hwif->ide_dma_timeout		= old_hwif.ide_dma_timeout;
+	hwif->ide_dma_queued_on		= old_hwif.ide_dma_queued_on;
+	hwif->ide_dma_queued_off	= old_hwif.ide_dma_queued_off;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	hwif->ide_dma_queued_read	= old_hwif.ide_dma_queued_read;
+	hwif->ide_dma_queued_write	= old_hwif.ide_dma_queued_write;
+	hwif->ide_dma_queued_start	= old_hwif.ide_dma_queued_start;
+#endif
 #endif
 
 #if 0

