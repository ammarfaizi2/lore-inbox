Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUGVRiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUGVRiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266860AbUGVRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:38:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266855AbUGVRiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:38:13 -0400
Date: Thu, 22 Jul 2004 13:39:33 -0200
From: Jens Axboe <axboe@suse.de>
To: Tabris <tabris@tabriel.tabris.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Repost] IDE error 2.6.7-rc3-mm2 and 2.6.8-rc1-mm1
Message-ID: <20040722153933.GJ3987@suse.de>
References: <200407220659.22948.tabris@tabriel.tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407220659.22948.tabris@tabriel.tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22 2004, Tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jul 21 03:00:18 tabriel kernel: hda: drive_cmd: status=0x51 { DriveReady
> SeekComplete Error }
> Jul 21 03:00:18 tabriel kernel: hda: drive_cmd: error=0x04 {
> DriveStatusError }
> Jul 21 03:00:18 tabriel kernel: ide: failed opcode was: 0xe7
> Jul 21 03:00:23 tabriel kernel: hda: drive_cmd: status=0x51 { DriveReady
> SeekComplete Error }
> Jul 21 03:00:23 tabriel kernel: hda: drive_cmd: error=0x04 {
> DriveStatusError }
> Jul 21 03:00:23 tabriel kernel: ide: failed opcode was: 0xe7
> Jul 21 03:00:28 tabriel kernel: hda: drive_cmd: status=0x51 { DriveReady
> SeekComplete Error }
> Jul 21 03:00:28 tabriel kernel: hda: drive_cmd: error=0x04 {
> DriveStatusError }
> Jul 21 03:00:28 tabriel kernel: ide: failed opcode was: 0xe7
> 
> 	This error did not occur in 2.6.6-rc3-mm2. Turning off ACPI made no 
> difference, not that I expected one.
> 
> 	It appears to be harmless but it's polluting my syslog.
> 
> Appears related to 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108946389700930
> 
> 	None of my harddrives are over 60GiB (and hda is an 8GiB), so there's 
> no reason i should be getting LBA48 Flush Cache.
> 
> 	What should I do, what do you need from me to get to the bottom of 
> this?

Does this work?

--- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-22 13:37:09.751485758 -0200
+++ linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-22 13:37:52.812593031 -0200
@@ -1248,7 +1248,8 @@
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 
-	if ((drive->id->cfs_enable_2 & 0x2400) == 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
 		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
 	else
 		rq->cmd[0] = WIN_FLUSH_CACHE;
--- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22 13:37:09.756486583 -0200
+++ linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22 13:38:23.807708802 -0200
@@ -67,7 +67,8 @@
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
-	if (ide_id_has_flush_cache_ext(drive->id))
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
 		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
 }
 

-- 
Jens Axboe

