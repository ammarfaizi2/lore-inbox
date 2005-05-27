Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVE0MUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVE0MUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVE0MUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:20:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56758 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262451AbVE0MUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:20:18 -0400
Subject: Resend: PATCH: Stop 2.6.12rc rmmod from being able to destroy CD
	hardware
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117196287.5743.186.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 27 May 2005 13:18:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an rmmod the cdrom layer when used with ide-cd issues a cache flush
atapi command to devices including those that do not support it.
According to Jens earlier discussion this isn't merely a minor glitch
but can destroy some CD hardware due to firmware bugs in the drive (as
per the Mandrake incident)

The IDE CD layer uses a mask of unsupported features, this means that
because ide-cd doesn't know about MRW writables it doesn't set the
relevant bit for non writables and harm can occur.

The simple fix is attached, making the driver start from ~0 and mask
bits the other direction would longer term be safer.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12rc3/drivers/ide/ide-cd.c linux-2.6.12rc3-minoride/drivers/ide/ide-cd.c
--- linux.vanilla-2.6.12rc3/drivers/ide/ide-cd.c	2005-04-27 16:01:29.000000000 +0100
+++ linux-2.6.12rc3-minoride/drivers/ide/ide-cd.c	2005-05-01 14:09:35.000000000 +0100
@@ -2860,6 +2922,9 @@
 		devinfo->mask |= CDC_CLOSE_TRAY;
 	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		devinfo->mask |= CDC_MO_DRIVE;
+		
+	/* We must have this masked unless a drive definitely handles it */
+	devinfo->mask |= CDC_MRW_W;
 
 	devinfo->disk = info->disk;
 	return register_cdrom(devinfo);

