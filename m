Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVBBDup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVBBDup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVBBDEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:04:36 -0500
Received: from [211.58.254.17] ([211.58.254.17]:29834 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262213AbVBBCzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:55:46 -0500
Date: Wed, 2 Feb 2005 11:55:38 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 12/29] ide: add ide_hwgroup_t.polling
Message-ID: <20050202025538.GM621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 12_ide_hwgroup_t_polling.patch
> 
> 	ide_hwgroup_t.polling field added.  0 in poll_timeout field
> 	used to indicate inactive polling but because 0 is a valid
> 	jiffy value, though slim, there's a chance that something
> 	weird can happen.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:04.260354336 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:04.465321080 +0900
@@ -1314,7 +1314,7 @@ void ide_timer_expiry (unsigned long dat
 			/* local CPU only,
 			 * as if we were handling an interrupt */
 			local_irq_disable();
-			if (hwgroup->poll_timeout != 0) {
+			if (hwgroup->polling) {
 				startstop = handler(drive);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
@@ -1442,8 +1442,7 @@ irqreturn_t ide_intr (int irq, void *dev
 		return IRQ_NONE;
 	}
 
-	if ((handler = hwgroup->handler) == NULL ||
-	    hwgroup->poll_timeout != 0) {
+	if ((handler = hwgroup->handler) == NULL || hwgroup->polling) {
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
Index: linux-ide-export/drivers/ide/ide-iops.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-iops.c	2005-02-02 10:27:15.612247109 +0900
+++ linux-ide-export/drivers/ide/ide-iops.c	2005-02-02 10:28:04.466320918 +0900
@@ -1028,14 +1028,14 @@ static ide_startstop_t atapi_reset_pollf
 			return ide_started;
 		}
 		/* end of polling */
-		hwgroup->poll_timeout = 0;
+		hwgroup->polling = 0;
 		printk("%s: ATAPI reset timed-out, status=0x%02x\n",
 				drive->name, stat);
 		/* do it the old fashioned way */
 		return do_reset1(drive, 1);
 	}
 	/* done polling */
-	hwgroup->poll_timeout = 0;
+	hwgroup->polling = 0;
 	return ide_stopped;
 }
 
@@ -1095,7 +1095,7 @@ static ide_startstop_t reset_pollfunc (i
 			printk("\n");
 		}
 	}
-	hwgroup->poll_timeout = 0;	/* done polling */
+	hwgroup->polling = 0;	/* done polling */
 	return ide_stopped;
 }
 
@@ -1170,6 +1170,7 @@ static ide_startstop_t do_reset1 (ide_dr
 		udelay (20);
 		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		hwgroup->polling = 1;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_started;
@@ -1210,6 +1211,7 @@ static ide_startstop_t do_reset1 (ide_dr
 	/* more than enough time */
 	udelay(10);
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+	hwgroup->polling = 1;
 	__ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
 
 	/*
Index: linux-ide-export/drivers/ide/pci/siimage.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/siimage.c	2005-02-02 10:27:15.612247109 +0900
+++ linux-ide-export/drivers/ide/pci/siimage.c	2005-02-02 10:28:04.466320918 +0900
@@ -590,7 +590,7 @@ static int siimage_reset_poll (ide_drive
 		if ((hwif->INL(SATA_STATUS_REG) & 0x03) != 0x03) {
 			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
 				hwif->name, hwif->INL(SATA_STATUS_REG));
-			HWGROUP(drive)->poll_timeout = 0;
+			HWGROUP(drive)->polling = 0;
 			return ide_started;
 		}
 		return 0;
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:28:04.261354174 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:04.467320756 +0900
@@ -938,7 +938,9 @@ typedef struct hwgroup_s {
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
-	int sleeping;
+	int sleeping	: 1;
+		/* BOOL: polling active & poll_timeout field valid */
+	int polling	: 1;
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */
