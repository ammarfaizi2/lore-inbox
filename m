Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbTF2Qtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbTF2Qtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 12:49:53 -0400
Received: from sith.mimuw.edu.pl ([193.0.96.4]:13319 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id S265697AbTF2Qtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 12:49:52 -0400
Date: Sun, 29 Jun 2003 19:04:09 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21(-ac) ide-disk and hpt366 modules problem
Message-ID: <20030629190409.A22124@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.21 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There is a chicken-egg problem between ide-disk and hpt366 modules.
ide-disk should be loaded after chipset driver to detect what disks are
connected, but hpt366 needs ide-disk loaded because of 372N tricks and
__ide_do_rw_disk symbol.

I used the following hack to avoid the problem, but I think maybe
something better is needed.


--- linux-2.4.21/drivers/ide/ide-disk.c~	Fri Jun 13 16:51:33 2003
+++ linux-2.4.21/drivers/ide/ide-disk.c	Sun Jun 29 18:48:33 2003
@@ -698,12 +698,9 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	if (hwif->rw_disk)
-		return hwif->rw_disk(drive, rq, block);
-	else 
-		return __ide_do_rw_disk(drive, rq, block);
+		hwif->rw_disk(drive, rq, block);
+	return __ide_do_rw_disk(drive, rq, block);
 }
-
-EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
 
 static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
 {
--- linux-2.4.21/drivers/ide/pci/hpt366.c~	Sun Jun 29 15:09:43 2003
+++ linux-2.4.21/drivers/ide/pci/hpt366.c	Sun Jun 29 18:50:33 2003
@@ -742,7 +742,7 @@
 		hpt372n_set_clock(drive, wantclock);
 		HWIF(drive)->config_data = wantclock;
 	}
-	return __ide_do_rw_disk(drive, rq, block);
+	return ide_started;
 }
 
 /*

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
