Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290606AbSAYIqn>; Fri, 25 Jan 2002 03:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290609AbSAYIqe>; Fri, 25 Jan 2002 03:46:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47116 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290606AbSAYIqZ>; Fri, 25 Jan 2002 03:46:25 -0500
Message-ID: <3C5119E0.6E5C45B6@zip.com.au>
Date: Fri, 25 Jan 2002 00:40:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [CFT] Bus mastering support for IDE CDROM audio
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading audio from IDE CDROMs always uses PIO.  This patch
teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.

Total time to read a CD using cdparanoia improves by up to 20%.
But sometimes there is no change.

Total CPU load decreases greatly.  On a 700 MHz VIA C3 with 82C6xx
Southbridge the CPU load during the rip falls from 85% to 9%.

On an 850MHz P3 with piix chipset CPU load falls from 76% to 8%.

These loads cannot be observed with `top' or `ps' - it all happens
at interrupt time.  I measure with `cyclesoak'.  It's googlable.

Recovery from media errors has been tested, works OK.

Recovery from DMA errors has been simulated.  It falls back to
PIO mode OK.

This code has not been tested for its effects upon SCSI-based
CDROM readers.  It needs to be.

I'd be interested in feedback from testers, please.

(Thanks, Jens)


--- linux-2.4.18-pre7/drivers/cdrom/cdrom.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/cdrom/cdrom.c	Thu Jan 24 23:52:17 2002
@@ -1910,6 +1910,76 @@ static int cdrom_do_cmd(struct cdrom_dev
 	return ret;
 }
 
+/*
+ * CDROM audio read, with DMA support.  Added in 2.4.18-pre4, akpm.
+ */
+static int cdda_read_audio(int cmd,
+			struct cdrom_device_info *cdi,
+			struct cdrom_generic_command *cgc,
+			struct cdrom_read_audio *ra)
+{
+	int lba;
+	int frames_todo;
+	int ret;
+	void *xferbuf = 0;
+	char *useraddr;
+
+	ret = -EINVAL;
+	if (ra->addr_format == CDROM_MSF) {
+		lba = msf_to_lba(ra->addr.msf.minute,
+				 ra->addr.msf.second,
+				 ra->addr.msf.frame);
+	} else if (ra->addr_format == CDROM_LBA) {
+		lba = ra->addr.lba;
+	} else {
+		goto out;
+	}
+
+	if (lba < 0 || ra->nframes <= 0)
+		goto out;
+
+	/*
+	 * We just allocate a single frame for the transfer buffer.  It
+	 * would be nice to allocate a page vector, but that would require
+	 * s/g support for PIO mode in cdrom_pc_intr().  Later.
+	 *
+	 * Also, I cannot persuade my CDROM to DMA transfer more than a single
+	 * frame before it drops DRQ and stops.
+	 *
+	 * This code used to kmalloc a large transfer buffer.  Be aware that
+	 * in DMA mode we later wrap a single buffer_head around this memory,
+	 * and b_size is unsigned short.  64k limit.
+	 *
+	 * Andre says the disk can transfer too much data sometimes, hence
+	 * the extra 100 bytes.
+	 */
+	xferbuf = kmalloc(CD_FRAMESIZE_RAW + 100, GFP_KERNEL);
+	ret = -ENOMEM;
+	if (!xferbuf)
+		goto out;
+
+	cgc->buffer = xferbuf;
+	cgc->data_direction = CGC_DATA_READ;
+	cgc->do_dma = 1;
+	frames_todo = ra->nframes;
+	useraddr = ra->buf;
+	while (frames_todo) {
+		ret = cdrom_read_block(cdi, cgc, lba, 1, 1, CD_FRAMESIZE_RAW);
+		if (ret)
+			goto out;
+		ret = -EFAULT;
+		if (copy_to_user(useraddr, cgc->buffer, CD_FRAMESIZE_RAW))
+			goto out;
+		useraddr += CD_FRAMESIZE_RAW;
+		frames_todo--;
+		lba++;
+	}
+	ret = 0;
+out:
+	kfree(xferbuf);
+	return ret;
+}
+
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		     unsigned long arg)
 {		
@@ -1973,57 +2043,9 @@ static int mmc_ioctl(struct cdrom_device
 		}
 	case CDROMREADAUDIO: {
 		struct cdrom_read_audio ra;
-		int lba, nr;
 
 		IOCTL_IN(arg, struct cdrom_read_audio, ra);
-
-		if (ra.addr_format == CDROM_MSF)
-			lba = msf_to_lba(ra.addr.msf.minute,
-					 ra.addr.msf.second,
-					 ra.addr.msf.frame);
-		else if (ra.addr_format == CDROM_LBA)
-			lba = ra.addr.lba;
-		else
-			return -EINVAL;
-
-		/* FIXME: we need upper bound checking, too!! */
-		if (lba < 0 || ra.nframes <= 0)
-			return -EINVAL;
-
-		/*
-		 * start with will ra.nframes size, back down if alloc fails
-		 */
-		nr = ra.nframes;
-		do {
-			cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
-			if (cgc.buffer)
-				break;
-
-			nr >>= 1;
-		} while (nr);
-
-		if (!nr)
-			return -ENOMEM;
-
-		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
-			kfree(cgc.buffer);
-			return -EFAULT;
-		}
-		cgc.data_direction = CGC_DATA_READ;
-		while (ra.nframes > 0) {
-			if (nr > ra.nframes)
-				nr = ra.nframes;
-
-			ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
-			if (ret)
-				break;
-			__copy_to_user(ra.buf, cgc.buffer, CD_FRAMESIZE_RAW*nr);
-			ra.buf += CD_FRAMESIZE_RAW * nr;
-			ra.nframes -= nr;
-			lba += nr;
-		}
-		kfree(cgc.buffer);
-		return ret;
+		return cdda_read_audio(cmd, cdi, &cgc, &ra);
 		}
 	case CDROMSUBCHNL: {
 		struct cdrom_subchnl q;
--- linux-2.4.18-pre7/drivers/ide/ide-cd.c	Wed Jan 23 15:11:33 2002
+++ linux-akpm/drivers/ide/ide-cd.c	Fri Jan 25 00:09:15 2002
@@ -1312,9 +1312,22 @@ static ide_startstop_t cdrom_pc_intr (id
 	int ireason, len, stat, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
+	struct cdrom_info *info = drive->driver_data;
+	int dma = info->dma;
+	int dma_error;
 	ide_startstop_t startstop;
 
 	/* Check for errors. */
+	if (dma) {
+		info->dma = 0;
+		if ((dma_error = HWIF(drive)->dmaproc(ide_dma_end, drive))) {
+			HWIF(drive)->dmaproc(ide_dma_off, drive);
+			pc->stat = 1;
+			printk(KERN_ERR "CDROM packet DMA error\n");
+		}
+	}
+
+	/* Check for errors. */
 	if (cdrom_decode_status (&startstop, drive, 0, &stat))
 		return startstop;
 
@@ -1322,6 +1335,20 @@ static ide_startstop_t cdrom_pc_intr (id
 	ireason = IN_BYTE (IDE_NSECTOR_REG);
 	len = IN_BYTE (IDE_LCYL_REG) + 256 * IN_BYTE (IDE_HCYL_REG);
 
+	if (dma) {
+		if (len > pc->buflen) {
+			printk(__FUNCTION__ ": read too much data! %d > %d\n",
+					len, pc->buflen);
+			len = pc->buflen;
+		}
+		if ((stat & DRQ_STAT) == 0 && len < pc->buflen) {
+			printk(__FUNCTION__ ": read too little data! %d < %d\n",
+					len, pc->buflen);
+		}
+		pc->buflen -= len;
+		pc->buffer += len;
+	}
+
 	/* If DRQ is clear, the command has completed.
 	   Complain if we still have data left to transfer. */
 	if ((stat & DRQ_STAT) == 0) {
@@ -1424,7 +1451,11 @@ static ide_startstop_t cdrom_do_packet_c
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
 	struct cdrom_info *info = drive->driver_data;
 
-	info->dma = 0;
+	if (rq->bh) {
+		info->dma = 1;
+	} else {
+		info->dma = 0;
+	}
 	info->cmd = 0;
 	pc->stat = 0;
 	len = pc->buflen;
@@ -1447,6 +1478,13 @@ void cdrom_sleep (int time)
 	} while (sleep);
 }
 
+/*
+ * end_buffer_io_sync() is not exported
+ */
+static void cdrom_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+{
+}
+
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command *pc)
 {
@@ -1459,7 +1497,25 @@ int cdrom_queue_packet_command(ide_drive
 
 	/* Start of retry loop. */
 	do {
+		struct buffer_head bh;
+
 		ide_init_drive_cmd (&req);
+
+		if (pc->do_dma) {
+			/* Hack up a buffer_head for IDE DMA's use */
+			memset(&bh, 0, sizeof(bh));
+			bh.b_size = pc->buflen;
+			bh.b_data = pc->buffer;
+			bh.b_state = (1 << BH_Lock) | (1 << BH_Mapped) |
+					(1 << BH_Req);
+			bh.b_end_io = cdrom_end_buffer_io_sync;
+#if 0		/* Needed by end_buffer_io_sync, but not cdrom_end_buffer_io_sync */
+			atomic_set(&bh.b_count, 1);
+			init_waitqueue_head(&bh.b_wait);
+#endif
+			req.bh = &bh;
+		}
+
 		req.cmd = PACKET_COMMAND;
 		req.buffer = (char *)pc;
 		ide_do_drive_cmd (drive, &req, ide_wait);
@@ -2200,6 +2256,8 @@ static int ide_cdrom_packet(struct cdrom
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
+	if (cgc->do_dma && drive->using_dma)
+		pc.do_dma = 1;
 	return cgc->stat = cdrom_queue_packet_command(drive, &pc);
 }
 
--- linux-2.4.18-pre7/drivers/ide/ide-cd.h	Tue Oct 23 21:59:54 2001
+++ linux-akpm/drivers/ide/ide-cd.h	Thu Jan 24 23:52:17 2002
@@ -109,6 +109,7 @@ struct packet_command {
 	int quiet;
 	int timeout;
 	struct request_sense *sense;
+	int do_dma;
 	unsigned char c[12];
 };
 
--- linux-2.4.18-pre7/include/linux/cdrom.h	Mon Nov  5 21:01:12 2001
+++ linux-akpm/include/linux/cdrom.h	Thu Jan 24 23:52:17 2002
@@ -287,6 +287,7 @@ struct cdrom_generic_command
 	unsigned char		data_direction;
 	int			quiet;
 	int			timeout;
+	int			do_dma;
 	void			*reserved[1];
 };
