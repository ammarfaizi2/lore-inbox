Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSBISFn>; Sat, 9 Feb 2002 13:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSBISFY>; Sat, 9 Feb 2002 13:05:24 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:5645 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S289055AbSBISFM>;
	Sat, 9 Feb 2002 13:05:12 -0500
Date: Sat, 9 Feb 2002 00:13:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: axboe@suse.de, kernel list <linux-kernel@vger.kernel.org>
Subject: IDE cleanup for 2.5.4-pre3
Message-ID: <20020208231346.GA1209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are first small ide cleanups. Jens, please apply,
									Pavel

--- clean/drivers/ide/ide-disk.c	Thu Jan 31 23:42:14 2002
+++ linux-dm/drivers/ide/ide-disk.c	Wed Feb  6 21:43:51 2002
@@ -123,29 +123,24 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	if (rq->flags & REQ_CMD)
-		goto good_command;
-
-	blk_dump_rq_flags(rq, "do_rw_disk, bad command");
-	ide_end_request(0, HWGROUP(drive));
-	return ide_stopped;
-
-good_command:
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
+		ide_end_request(0, HWGROUP(drive));
+		return ide_stopped;
+	}
 
-#ifdef CONFIG_BLK_DEV_PDC4030
 	if (IS_PDC4030_DRIVE) {
 		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
 		return promise_rw_disk(drive, rq, block);
 	}
-#endif /* CONFIG_BLK_DEV_PDC4030 */
 
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))	/* 48-bit LBA */
-		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
+		return lba_48_rw_disk(drive, rq, block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
-		return lba_28_rw_disk(drive, rq, (unsigned long) block);
+		return lba_28_rw_disk(drive, rq, block);
 
 	/* 28-bit CHS : DIE DIE DIE piece of legacy crap!!! */
-	return chs_rw_disk(drive, rq, (unsigned long) block);
+	return chs_rw_disk(drive, rq, block);
 }
 
 static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
--- clean/drivers/ide/ide-proc.c	Thu Jan 31 23:42:14 2002
+++ linux-dm/drivers/ide/ide-proc.c	Mon Feb  4 23:05:09 2002
@@ -629,7 +629,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)
@@ -746,7 +746,6 @@
 	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
-//	ide_driver_t *driver = drive->driver;
 
 	if (drive->present && !drive->proc) {
 		drive->proc = proc_mkdir(drive->name, parent);
--- clean/include/linux/ide.h	Thu Jan 31 23:42:29 2002
+++ linux-dm/include/linux/ide.h	Wed Feb  6 21:32:41 2002
@@ -424,12 +425,12 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	void		  *hwif;	/* actually (ide_hwif_t *) */
+	struct hwif_s   *hwif;		/* actually (ide_hwif_t *) */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	void 		*driver;	/* (ide_driver_t *) */
+	struct ide_driver_s *driver;	/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
