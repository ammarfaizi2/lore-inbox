Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUEWI1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUEWI1p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUEWI1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:27:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262356AbUEWI1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:27:37 -0400
Date: Sun, 23 May 2004 10:27:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-ID: <20040523082728.GH1952@suse.de>
References: <200405222107.55505.l_allegrucci@despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405222107.55505.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22 2004, Lorenzo Allegrucci wrote:
> 
> I get a 100% reproducible oops mounting an ext3 or reiserfs
> partition with -o barrier enabled.
> Hand written oops (for ext3):
> 
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { DriveStatusError }
> end_request: I/O error, dev hda, sector 84666781
> ------------[ cut here ]------------
> kernel BUG at include/linux/blkdev.h:576!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: lp emu10k1 sound soundcore ac97_codec unix
> CPU:    0
> EIP:    0060:[<c02125ae>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.6-mm5)
> EIP is at __ide_end_request+0xbe/0x110
> eax: 00000e7a   ebx: da88636c   ecx: 00000000   edx: da88636c
> esi: 00000000   edi: c038180c   ebp: 00000008   esp: c0368ec4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0368000 task=c02d1a40)
> Stack: 00000001 00000008 da88636c 050be99d 00000000 c02128fc 00000008 c0116718
>        00000000 c036bb01 00000246 00000001 00000000 c038180c 00000286 c0368000
>        dffdfa78 c038180c c0212a79 c02abc65 c0381760 042aa50a 00000051 dffdf951
> Call Trace:
>  [<c02128fc>] ide_complete_barrier+0xec/0x160

So here's a complete patch, that both fixes the code bug and adds some
support for (hopefully) fool proof checking proper flush support in the
drive. Can you give this a test, please? Post the dmesg ide boot
messages and whether it works, thanks.

diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-disk.c linux-2.6.6-mm5/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-disk.c	2004-05-23 09:56:20.098457257 +0200
+++ linux-2.6.6-mm5/drivers/ide/ide-disk.c	2004-05-23 10:23:36.211541946 +0200
@@ -1392,13 +1392,6 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
-/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
-#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
-
-/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
-#define ide_id_has_flush_cache_ext(id)	\
-	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
-
 static int write_cache (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
@@ -1597,6 +1590,7 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
+	int barrier = 0;
 
 	idedisk_add_settings(drive);
 
@@ -1729,8 +1723,29 @@ static void idedisk_setup (ide_drive_t *
 
 	write_cache(drive, 1);
 
-	blk_queue_ordered(drive->queue, 1);
-	blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	/*
+	 * decide if we can sanely support flushes and barriers on
+	 * this drive
+	 */
+	if (drive->addressing == 1) {
+		/*
+		 * if capacity is over 2^28 sectors, drive must support
+		 * FLUSH_CACHE_EXT
+		 */
+		if (ide_id_has_flush_cache_ext(id))
+			barrier = 1;
+		else if (capacity <= (1ULL << 28))
+			barrier = 1;
+		else
+			printk("%s: drive is buggy, no support for FLUSH_CACHE_EXT with lba48\n", drive->name);
+	} else if (ide_id_has_flush_cache(id))
+		barrier = 1;
+
+	printk("%s: cache flushes %ssupported\n", drive->name, barrier ? "" : "not ");
+	if (barrier) {
+		blk_queue_ordered(drive->queue, 1);
+		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	}
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-io.c linux-2.6.6-mm5/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-io.c	2004-05-23 09:56:20.100457041 +0200
+++ linux-2.6.6-mm5/drivers/ide/ide-io.c	2004-05-23 10:22:59.204542947 +0200
@@ -67,7 +67,7 @@ static void ide_fill_flush_cmd(ide_drive
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
-	if (drive->id->cfs_enable_2 & 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id))
 		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
 }
 
@@ -229,7 +229,7 @@ u64 ide_get_error_location(ide_drive_t *
 	lcyl = args[4];
 	sect = args[3];
 
-	if (drive->id->cfs_enable_2 & 0x2400) {
+	if (ide_id_has_flush_cache_ext(drive->id)) {
 		low = (hcyl << 16) | (lcyl << 8) | sect;
 		HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 		high = ide_read_24(drive);
@@ -277,32 +277,48 @@ static void ide_complete_barrier(ide_dri
 	}
 
 	/*
-	 * bummer, flush failed. if it was the pre-flush, fail the barrier.
-	 * if it was the post-flush, complete the succesful part of the request
-	 * and fail the rest
+	 * we need to end real_rq, but it's not on the queue currently.
+	 * put it back on the queue, so we don't have to special case
+	 * anything else for completing it
 	 */
-	good_sectors = 0;
-	if (blk_barrier_postflush(rq)) {
-		sector = ide_get_error_location(drive, rq->buffer);
-
-		if ((sector >= real_rq->hard_sector) &&
-		    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
-			good_sectors = sector - real_rq->hard_sector;
-	} else
-		sector = real_rq->hard_sector;
+	elv_requeue_request(drive->queue, real_rq);
+	
+	/*
+	 * drive aborted flush command, assume FLUSH_CACHE_* doesn't
+	 * work and disable barrier support
+	 */
+	if (error & ABRT_ERR) {
+		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
+		__ide_end_request(drive, real_rq, 0, real_rq->hard_nr_sectors);
+		blk_queue_ordered(drive->queue, 0);
+		blk_queue_issue_flush_fn(drive->queue, NULL);
+	} else {
+		/*
+		 * find out what part of the request failed
+		 */
+		good_sectors = 0;
+		if (blk_barrier_postflush(rq)) {
+			sector = ide_get_error_location(drive, rq->buffer);
 
-	bad_sectors = real_rq->hard_nr_sectors - good_sectors;
-	if (good_sectors)
-		__ide_end_request(drive, real_rq, 1, good_sectors);
-	if (bad_sectors)
-		__ide_end_request(drive, real_rq, 0, bad_sectors);
+			if ((sector >= real_rq->hard_sector) &&
+			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
+				good_sectors = sector - real_rq->hard_sector;
+		} else
+			sector = real_rq->hard_sector;
+
+		bad_sectors = real_rq->hard_nr_sectors - good_sectors;
+		if (good_sectors)
+			__ide_end_request(drive, real_rq, 1, good_sectors);
+		if (bad_sectors)
+			__ide_end_request(drive, real_rq, 0, bad_sectors);
+
+		printk(KERN_ERR "%s: failed barrier write: "
+				"sector=%Lx(good=%d/bad=%d)\n",
+				drive->name, (unsigned long long)sector,
+				good_sectors, bad_sectors);
+	}
 
 	drive->doing_barrier = 0;
-
-	printk(KERN_ERR "%s: failed barrier write: "
-			"sector=%Lx(good=%d/bad=%d)\n",
-			drive->name, (unsigned long long)sector,
-			good_sectors, bad_sectors);
 }
 
 /**
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/include/linux/ide.h linux-2.6.6-mm5/include/linux/ide.h
--- /opt/kernel/linux-2.6.6-mm5/include/linux/ide.h	2004-05-23 09:56:21.401316264 +0200
+++ linux-2.6.6-mm5/include/linux/ide.h	2004-05-23 10:09:21.313967868 +0200
@@ -1716,4 +1716,11 @@ static inline int ata_can_queue(ide_driv
 
 extern struct bus_type ide_bus_type;
 
+/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
+#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
+
+/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
+#define ide_id_has_flush_cache_ext(id)	\
+	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
+
 #endif /* _IDE_H */

-- 
Jens Axboe

