Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133104AbRDRMke>; Wed, 18 Apr 2001 08:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133107AbRDRMkP>; Wed, 18 Apr 2001 08:40:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26124 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133104AbRDRMkG>;
	Wed, 18 Apr 2001 08:40:06 -0400
Date: Wed, 18 Apr 2001 14:39:53 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Message-ID: <20010418143953.D490@suse.de>
In-Reply-To: <01041714250400.01376@antares> <20010418123941.H492@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20010418123941.H492@suse.de>; from axboe@suse.de on Wed, Apr 18, 2001 at 12:39:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18 2001, Jens Axboe wrote:
> On Tue, Apr 17 2001, Stefan Jaschke wrote:
> > Judging from the thread started Jan 1, 2001, by Andre Hedrick, 
> > I thought IDE DVD-RAM just works out of the box and got a
> > Toshiba SD-W2002. 
> > 
> > Problem: /dev/hdc cannot be read or written to when the drive contains
> >   DVD-RAM media. The behavior is the same for the stock 2.4.3 kernel
> >   and the SuSE-2.4.0 kernel.  Strangely enough, the disk can be read,
> >   but not written to, with the 2.2.18 kernel.
> 
> It should work, note that I recently spotted some quite severe bugs in
> the pio write handling for ATAPI which I've almost fixed here now. It
> seems you drive is in DMA mode though, so it shouldn't be affecting you.

Attached patch for 2.4.4-pre4 which fixes all known DVD-RAM ATAPI bugs.
Both pio and dma mode work fine here, using ext2, on a 9.4gb HITACHI
DVD-RAM GF-2000 drive.

-- 
Jens Axboe


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cd-244p4-1

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/drivers/cdrom/cdrom.c linux/drivers/cdrom/cdrom.c
--- /opt/kernel/linux-2.4.4-pre4/drivers/cdrom/cdrom.c	Thu Mar 29 21:56:07 2001
+++ linux/drivers/cdrom/cdrom.c	Wed Apr 18 13:27:36 2001
@@ -279,6 +279,9 @@
 static int lockdoor = 1;
 /* will we ever get to use this... sigh. */
 static int check_media_type;
+static unsigned long *cdrom_numbers;
+static DECLARE_MUTEX(cdrom_sem);
+
 MODULE_PARM(debug, "i");
 MODULE_PARM(autoclose, "i");
 MODULE_PARM(autoeject, "i");
@@ -340,6 +343,38 @@
 	check_media_change:	cdrom_media_changed,
 };
 
+/*
+ * get or clear a new cdrom number, run under cdrom_sem
+ */
+static int cdrom_get_entry(void)
+{
+	int i, nr, foo;
+
+	nr = 0;
+	foo = -1;
+	for (i = 0; i < CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8); i++) {
+		if (cdrom_numbers[i] == ~0UL) {
+			nr += sizeof(unsigned long) * 8;
+			continue;
+		}
+		foo = ffz(cdrom_numbers[i]);
+		set_bit(foo, &cdrom_numbers[i]);
+		nr += foo;
+		break;
+	}
+
+	return foo == -1 ? foo : nr;
+}
+
+static void cdrom_clear_entry(struct cdrom_device_info *cdi)
+{
+	int bit_nr = cdi->nr & ~(sizeof(unsigned long) * 8);
+	int cd_index = cdi->nr / (sizeof(unsigned long) * 8);
+
+	clear_bit(bit_nr, &cdrom_numbers[cd_index]);
+}
+
+
 /* This macro makes sure we don't have to check on cdrom_device_ops
  * existence in the run-time routines below. Change_capability is a
  * hack to have the capability flags defined const, while we can still
@@ -354,7 +389,6 @@
         struct cdrom_device_ops *cdo = cdi->ops;
         int *change_capability = (int *)&cdo->capability; /* hack */
 	char vname[16];
-	static unsigned int cdrom_counter;
 
 	cdinfo(CD_OPEN, "entering register_cdrom\n"); 
 
@@ -395,7 +429,17 @@
 
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir (NULL, "cdroms", NULL);
-	sprintf (vname, "cdrom%u", cdrom_counter++);
+
+	/*
+	 * get new cdrom number
+	 */
+	down(&cdrom_sem);
+	cdi->nr = cdrom_get_entry();
+	up(&cdrom_sem);
+	if (cdi->nr == -1)
+		return -ENOMEM;
+
+	sprintf(vname, "cdrom%u", cdi->nr);
 	if (cdi->de) {
 		int pos;
 		devfs_handle_t slave;
@@ -418,9 +462,13 @@
 				    S_IFBLK | S_IRUGO | S_IWUGO,
 				    &cdrom_fops, NULL);
 	}
-	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+
+	down(&cdrom_sem);
 	cdi->next = topCdromPtr; 	
 	topCdromPtr = cdi;
+	up(&cdrom_sem);
+
+	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	return 0;
 }
 #undef ENSURE
@@ -429,12 +477,14 @@
 {
 	struct cdrom_device_info *cdi, *prev;
 	int major = MAJOR(unreg->dev);
+	int bit_nr, cd_index;
 
 	cdinfo(CD_OPEN, "entering unregister_cdrom\n"); 
 
 	if (major < 0 || major >= MAX_BLKDEV)
 		return -1;
 
+	down(&cdrom_sem);
 	prev = NULL;
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != unreg->dev) {
@@ -442,14 +492,20 @@
 		cdi = cdi->next;
 	}
 
-	if (cdi == NULL)
+	if (cdi == NULL) {
+		up(&cdrom_sem);
 		return -2;
+	}
+
+	cdrom_clear_entry(cdi);
+
 	if (prev)
 		prev->next = cdi->next;
 	else
 		topCdromPtr = cdi->next;
+	up(&cdrom_sem);
 	cdi->ops->n_minors--;
-	devfs_unregister (cdi->de);
+	devfs_unregister(cdi->de);
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 	return 0;
 }
@@ -458,10 +514,14 @@
 {
 	struct cdrom_device_info *cdi;
 
+	down(&cdrom_sem);
+
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != dev)
 		cdi = cdi->next;
 
+	up(&cdrom_sem);
+
 	return cdi;
 }
 
@@ -2418,6 +2478,8 @@
 	}
 
 	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
+
+	down(&cdrom_sem);
 	
 	pos += sprintf(info+pos, "\ndrive name:\t");
 	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
@@ -2487,6 +2549,8 @@
 	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
 	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_RAM) != 0);
 
+	up(&cdrom_sem);
+
 	strcpy(info+pos,"\n\n");
 		
         return proc_dostring(ctl, write, filp, buffer, lenp);
@@ -2633,6 +2697,10 @@
 
 static int __init cdrom_init(void)
 {
+	int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
+
+	cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
+
 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_register();
 #endif
@@ -2643,6 +2711,7 @@
 static void __exit cdrom_exit(void)
 {
 	printk(KERN_INFO "Uniform CD-ROM driver unloaded\n");
+	kfree(cdrom_numbers);
 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_unregister();
 #endif
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.4.4-pre4/drivers/ide/ide-cd.c	Fri Feb  9 20:30:23 2001
+++ linux/drivers/ide/ide-cd.c	Wed Apr 18 14:28:30 2001
@@ -977,8 +977,7 @@
 
 		/* If we've filled the present buffer but there's another
 		   chained buffer after it, move on. */
-		if (rq->current_nr_sectors == 0 &&
-		    rq->nr_sectors > 0)
+		if (rq->current_nr_sectors == 0 && rq->nr_sectors)
 			cdrom_end_request (1, drive);
 
 		/* If the buffers are full, cache the rest of the data in our
@@ -1192,6 +1191,55 @@
 	return cdrom_start_packet_command (drive, 0, cdrom_start_seek_continuation);
 }
 
+static inline int cdrom_merge_requests(struct request *rq, struct request *nxt)
+{
+	int ret = 1;
+
+	/*
+	 * partitions not really working, but better check anyway...
+	 */
+	if (rq->cmd == nxt->cmd && rq->rq_dev == nxt->rq_dev) {
+		rq->nr_sectors += nxt->nr_sectors;
+		rq->hard_nr_sectors += nxt->nr_sectors;
+		rq->bhtail->b_reqnext = nxt->bh;
+		rq->bhtail = nxt->bhtail;
+		list_del(&nxt->queue);
+		blkdev_release_request(nxt);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * the current request will always be the first one on the list
+ */
+static void cdrom_attempt_remerge(ide_drive_t *drive, struct request *rq)
+{
+	struct list_head *entry;
+	struct request *nxt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	while (1) {
+		entry = rq->queue.next;
+		if (entry == &drive->queue.queue_head)
+			break;
+
+		nxt = blkdev_entry_to_request(entry);
+		if (rq->sector + rq->nr_sectors != nxt->sector)
+			break;
+		else if (rq->nr_sectors + nxt->nr_sectors > SECTORS_MAX)
+			break;
+
+		if (cdrom_merge_requests(rq, nxt))
+			break;
+	}
+
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
 /* Fix up a possibly partially-processed request so that we can
    start it over entirely, or even put it back on the request queue. */
 static void restore_request (struct request *rq)
@@ -1203,6 +1251,8 @@
 		rq->sector -= n;
 	}
 	rq->current_nr_sectors = rq->bh->b_size >> SECTOR_BITS;
+	rq->hard_nr_sectors = rq->nr_sectors;
+	rq->hard_sector = rq->sector;
 }
 
 /*
@@ -1216,20 +1266,22 @@
 
 	/* If the request is relative to a partition, fix it up to refer to the
 	   absolute address.  */
-	if ((minor & PARTN_MASK) != 0) {
+	if (minor & PARTN_MASK) {
 		rq->sector = block;
 		minor &= ~PARTN_MASK;
-		rq->rq_dev = MKDEV (MAJOR(rq->rq_dev), minor);
+		rq->rq_dev = MKDEV(MAJOR(rq->rq_dev), minor);
 	}
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
-	restore_request (rq);
+	restore_request(rq);
 
 	/* Satisfy whatever we can of this request from our cached sector. */
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
 
+	cdrom_attempt_remerge(drive, rq);
+
 	/* Clear the local sector buffer. */
 	info->nsectors_buffered = 0;
 
@@ -1477,7 +1529,7 @@
 
 static ide_startstop_t cdrom_write_intr(ide_drive_t *drive)
 {
-	int stat, ireason, len, sectors_to_transfer;
+	int stat, ireason, len, sectors_to_transfer, uptodate;
 	struct cdrom_info *info = drive->driver_data;
 	int i, dma_error = 0, dma = info->dma;
 	ide_startstop_t startstop;
@@ -1498,6 +1550,9 @@
 		return startstop;
 	}
  
+	/*
+	 * using dma, transfer is complete now
+	 */
 	if (dma) {
 		if (dma_error)
 			return ide_error(drive, "dma error", stat);
@@ -1519,12 +1574,13 @@
 		/* If we're not done writing, complain.
 		 * Otherwise, complete the command normally.
 		 */
+		uptodate = 1;
 		if (rq->current_nr_sectors > 0) {
 			printk("%s: write_intr: data underrun (%ld blocks)\n",
-				drive->name, rq->current_nr_sectors);
-			cdrom_end_request(0, drive);
-		} else
-			cdrom_end_request(1, drive);
+			drive->name, rq->current_nr_sectors);
+			uptodate = 0;
+		}
+		cdrom_end_request(uptodate, drive);
 		return ide_stopped;
 	}
 
@@ -1533,26 +1589,42 @@
 		if (cdrom_write_check_ireason(drive, len, ireason))
 			return ide_stopped;
 
-	/* The number of sectors we need to read from the drive. */
 	sectors_to_transfer = len / SECTOR_SIZE;
 
-	/* Now loop while we still have data to read from the drive. DMA
-	 * transfers will already have been complete
+	/*
+	 * now loop and write out the data
 	 */
 	while (sectors_to_transfer > 0) {
-		/* If we've filled the present buffer but there's another
-		   chained buffer after it, move on. */
-		if (rq->current_nr_sectors == 0 && rq->nr_sectors > 0)
-			cdrom_end_request(1, drive);
+		int this_transfer;
+
+		if (!rq->current_nr_sectors) {
+			printk("ide-cd: write_intr: oops\n");
+			break;
+		}
+
+		/*
+		 * Figure out how many sectors we can transfer
+		 */
+		this_transfer = MIN(sectors_to_transfer,rq->current_nr_sectors);
+
+		while (this_transfer > 0) {
+			atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
+			rq->buffer += SECTOR_SIZE;
+			--rq->nr_sectors;
+			--rq->current_nr_sectors;
+			++rq->sector;
+			--this_transfer;
+			--sectors_to_transfer;
+		}
 
-		atapi_output_bytes(drive, rq->buffer, rq->current_nr_sectors);
-		rq->nr_sectors -= rq->current_nr_sectors;
-		rq->current_nr_sectors = 0;
-		rq->sector += rq->current_nr_sectors;
-		sectors_to_transfer -= rq->current_nr_sectors;
+		/*
+		 * current buffer complete, move on
+		 */
+		if (rq->current_nr_sectors == 0 && rq->nr_sectors)
+			cdrom_end_request (1, drive);
 	}
 
-	/* arm handler */
+	/* re-arm handler */
 	ide_set_handler(drive, &cdrom_write_intr, 5 * WAIT_CMD, NULL);
 	return ide_started;
 }
@@ -1583,10 +1655,26 @@
 	return cdrom_transfer_packet_command(drive, &pc, cdrom_write_intr);
 }
 
-static ide_startstop_t cdrom_start_write(ide_drive_t *drive)
+static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
 
+	/*
+	 * writes *must* be 2kB frame aligned
+	 */
+	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
+		cdrom_end_request(0, drive);
+		return ide_stopped;
+	}
+
+	/*
+	 * for dvd-ram and such media, it's a really big deal to get
+	 * big writes all the time. so scour the queue and attempt to
+	 * remerge requests, often the plugging will not have had time
+	 * to do this properly
+	 */
+	cdrom_attempt_remerge(drive, rq);
+
 	info->nsectors_buffered = 0;
 
         /* use dma, if possible. we don't need to check more, since we
@@ -1629,7 +1717,7 @@
 				if (rq->cmd == READ)
 					action = cdrom_start_read(drive, block);
 				else
-					action = cdrom_start_write(drive);
+					action = cdrom_start_write(drive, rq);
 			}
 			info->last_block = block;
 			return action;
@@ -1832,6 +1920,7 @@
 
 	pc.buffer =  buf;
 	pc.buflen = buflen;
+	pc.quiet = 1;
 	pc.c[0] = GPCMD_READ_TOC_PMA_ATIP;
 	pc.c[6] = trackno;
 	pc.c[7] = (buflen >> 8);
@@ -2826,7 +2915,12 @@
 	drive->part[0].nr_sects = toc->capacity * SECTORS_PER_FRAME;
 	HWIF(drive)->gd->sizes[minor] = toc->capacity * BLOCKS_PER_FRAME;
 
+	/*
+	 * reset block size, ide_revalidate_disk incorrectly sets it to
+	 * 1024 even for CDROM's
+	 */
 	blk_size[HWIF(drive)->major] = HWIF(drive)->gd->sizes;
+	set_blocksize(MKDEV(HWIF(drive)->major, minor), CD_FRAMESIZE);
 }
 
 static
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- /opt/kernel/linux-2.4.4-pre4/drivers/ide/ide-cd.h	Tue Mar 27 01:49:15 2001
+++ linux/drivers/ide/ide-cd.h	Wed Apr 18 13:09:13 2001
@@ -37,11 +37,12 @@
 
 /************************************************************************/
 
-#define SECTOR_SIZE		512
 #define SECTOR_BITS 		9
-#define SECTORS_PER_FRAME	(CD_FRAMESIZE / SECTOR_SIZE)
+#define SECTOR_SIZE		(1 << SECTOR_BITS)
+#define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
-#define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE / SECTOR_SIZE)
+#define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)
+#define SECTORS_MAX		(131072 >> SECTOR_BITS)
 
 #define BLOCKS_PER_FRAME	(CD_FRAMESIZE / BLOCK_SIZE)
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- /opt/kernel/linux-2.4.4-pre4/drivers/scsi/sr.c	Mon Feb 19 19:25:17 2001
+++ linux/drivers/scsi/sr.c	Wed Apr 18 13:00:32 2001
@@ -262,7 +262,7 @@
 static int sr_scatter_pad(Scsi_Cmnd *SCpnt, int s_size)
 {
 	struct scatterlist *sg, *old_sg = NULL;
-	int i, fsize, bsize, sg_ent;
+	int i, fsize, bsize, sg_ent, sg_count;
 	char *front, *back;
 
 	back = front = NULL;
@@ -290,17 +290,24 @@
 	/*
 	 * extend or allocate new scatter-gather table
 	 */
-	if (SCpnt->use_sg)
+	sg_count = SCpnt->use_sg;
+	if (sg_count)
 		old_sg = (struct scatterlist *) SCpnt->request_buffer;
 	else {
-		SCpnt->use_sg = 1;
+		sg_count = 1;
 		sg_ent++;
 	}
 
-	SCpnt->sglist_len = ((sg_ent * sizeof(struct scatterlist)) + 511) & ~511;
-	if ((sg = scsi_malloc(SCpnt->sglist_len)) == NULL)
+	i = ((sg_ent * sizeof(struct scatterlist)) + 511) & ~511;
+	if ((sg = scsi_malloc(i)) == NULL)
 		goto no_mem;
 
+	/*
+	 * no more failing memory allocs possible, we can safely assign
+	 * SCpnt values now
+	 */
+	SCpnt->sglist_len = i;
+	SCpnt->use_sg = sg_count;
 	memset(sg, 0, SCpnt->sglist_len);
 
 	i = 0;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- /opt/kernel/linux-2.4.4-pre4/drivers/scsi/sr_ioctl.c	Fri Dec 29 23:07:22 2000
+++ linux/drivers/scsi/sr_ioctl.c	Wed Apr 18 13:00:32 2001
@@ -530,6 +530,8 @@
 	target = MINOR(cdi->dev);
 
 	switch (cmd) {
+	case BLKGETSIZE:
+		return put_user(scsi_CDs[target].capacity >> 1, (long *) arg);
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.4-pre4/include/linux/cdrom.h linux/include/linux/cdrom.h
--- /opt/kernel/linux-2.4.4-pre4/include/linux/cdrom.h	Wed Apr 18 14:37:43 2001
+++ linux/include/linux/cdrom.h	Wed Apr 18 13:02:10 2001
@@ -577,6 +577,8 @@
 	struct dvd_manufact	manufact;
 } dvd_struct;
 
+#define CDROM_MAX_CDROMS	256
+
 /*
  * DVD authentication ioctl
  */
@@ -732,6 +734,7 @@
 	devfs_handle_t de;		/* real driver creates this  */
 /* specifications */
         kdev_t dev;	                /* device number */
+	int nr;				/* cdrom entry */
 	int mask;                       /* mask of capability: disables them */
 	int speed;			/* maximum speed for reading data */
 	int capacity;			/* number of discs in jukebox */

--liOOAslEiF7prFVr--
