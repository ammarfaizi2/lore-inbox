Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTADX3j>; Sat, 4 Jan 2003 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTADX3j>; Sat, 4 Jan 2003 18:29:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:6092 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261724AbTADX3e>;
	Sat, 4 Jan 2003 18:29:34 -0500
Message-ID: <3E177058.FF41AA10@digeo.com>
Date: Sat, 04 Jan 2003 15:38:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: updated CDROMREADAUDIO DMA patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 23:38:02.0033 (UTC) FILETIME=[52407210:01C2B44A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A refresh and retest of this patch, against 2.4.21-pre2.  It would
be helpful if a few (or a lot of) people could test this, and report
on the result.   Otherwise it'll never get anywhere...






Reading audio from IDE CDROMs always uses PIO.  This patch teaches the kernel
to use DMA for the CDROMREADAUDIO ioctl.

Total time to read a CD using cdparanoia improves by up to 20%.  But
sometimes there is no change.

Total CPU load decreases greatly.  On a 700 MHz VIA C3 with 82C6xx
Southbridge the CPU load during the rip falls from 85% to 9%.

On an 850MHz P3 with piix chipset CPU load falls from 76% to 8%.

These loads cannot be observed with `top' or `ps' - it all happens at
interrupt time.  I measure with `cyclesoak'.

Recovery from media errors has been tested, works OK.

Recovery from DMA errors has been simulated.  It falls back to PIO mode OK.

The cdrom needs to be set into DMA mode (hdparm -d1 /dev/cdrom) for this code
to have an effect.  I find that

	hdparm -c1 -u1 -d1 /dev/cdrom

works nicely.


 drivers/cdrom/cdrom.c |  151 +++++++++++++++++++++++++++++++++-----------------
 drivers/ide/ide-cd.c  |   62 +++++++++++++++++++-
 drivers/ide/ide-cd.h  |    1 
 include/linux/cdrom.h |    9 ++
 4 files changed, 171 insertions(+), 52 deletions(-)

--- 24/drivers/cdrom/cdrom.c~ide-akpm	Sat Jan  4 14:57:36 2003
+++ 24-akpm/drivers/cdrom/cdrom.c	Sat Jan  4 14:57:36 2003
@@ -1911,6 +1911,107 @@ static int cdrom_do_cmd(struct cdrom_dev
 	return ret;
 }
 
+/*
+ * CDROM audio read, with DMA support.  Added in 2.4.18-pre4, akpm.
+ *
+ * Initially, we try to perform multiframe bus-mastering.  If the IDE
+ * layer experiences a DMA error, we fall back to single-frame DMA.
+ * If the IDE layer again detects a DMA error, we fall back to multiframe
+ * PIO.
+ *
+ * We do not want to disable drive-level DMA at any stage, because
+ * some devices can perform non-packet DMA quite happily, but appear
+ * to not be able to perform packet DMA correctly.
+ *
+ * If the drive is not using_dma, we never attempt packet DMA.
+ */
+static int cdda_read_audio(int cmd,
+			struct cdrom_device_info *cdi,
+			struct cdrom_generic_command *cgc,
+			struct cdrom_read_audio *ra)
+{
+	int lba;
+	unsigned frames_todo;
+	int ret;
+	void *xferbuf = 0;
+	unsigned nr_local_frames;
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
+	 * We can't sensibly support more that 64k because we later
+	 * use a buffer_head to map the temp buffer.  And b_count is
+	 * unsigned short.
+	 */
+	nr_local_frames = ra->nframes;
+	if (nr_local_frames * CD_FRAMESIZE_RAW > 32768)
+		nr_local_frames = 32768 / CD_FRAMESIZE_RAW;
+
+	if (cdi->dma_mode == CDROM_DMA_SINGLE)
+		nr_local_frames = 1;
+
+	do {
+		xferbuf = kmalloc(CD_FRAMESIZE_RAW * nr_local_frames, GFP_KERNEL);
+	} while (!xferbuf && nr_local_frames--);
+	ret = -ENOMEM;
+	if (!xferbuf)
+		goto out;
+
+	cgc->buffer = xferbuf;
+	cgc->data_direction = CGC_DATA_READ;
+	if (cdi->dma_mode != CDROM_DMA_NONE)
+		cgc->do_dma = 1;
+	frames_todo = ra->nframes;
+	useraddr = ra->buf;
+retry:
+	while (frames_todo) {
+		unsigned frames_now = min(frames_todo, nr_local_frames);
+
+		cgc->dma_error = 0;
+		ret = cdrom_read_block(cdi, cgc, lba, frames_now, 1, CD_FRAMESIZE_RAW);
+		if (ret) {
+			/*
+			 * Here we implement DMA size fallback
+			 */
+			if (cgc->dma_error && cdi->dma_mode == CDROM_DMA_MULTI) {
+				printk(KERN_WARNING "CDROM: falling back to "
+					"single frame DMA\n");
+				cdi->dma_mode = CDROM_DMA_SINGLE;
+				nr_local_frames = 1;
+				goto retry;
+			} else if (cgc->dma_error && cdi->dma_mode == CDROM_DMA_SINGLE) {
+				printk(KERN_WARNING "CDROM: disabled DMA\n");
+				cdi->dma_mode = CDROM_DMA_NONE;
+				goto retry;
+			}
+			goto out;
+		}
+		ret = -EFAULT;
+		if (copy_to_user(useraddr, cgc->buffer, CD_FRAMESIZE_RAW * frames_now))
+			goto out;
+		useraddr += CD_FRAMESIZE_RAW * frames_now;
+		frames_todo -= frames_now;
+		lba += frames_now;
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
@@ -1977,57 +2078,9 @@ static int mmc_ioctl(struct cdrom_device
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
--- 24/drivers/ide/ide-cd.c~ide-akpm	Sat Jan  4 14:57:36 2003
+++ 24-akpm/drivers/ide/ide-cd.c	Sat Jan  4 14:57:36 2003
@@ -1449,9 +1449,25 @@ static ide_startstop_t cdrom_pc_intr (id
 	int ireason, len, stat, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
+	struct cdrom_info *info = drive->driver_data;
+	int dma = info->dma;
+	int dma_error;
 	ide_startstop_t startstop;
 	u8 lowcyl = 0, highcyl = 0;
 
+	if (dma) {
+		info->dma = 0;
+		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
+			/*
+			 * We don't disable drive DMA for packet DMA errors.
+			 * It's handled in cdda_read_audio()
+			 */
+			/* HWIF(drive)->dmaproc(ide_dma_off, drive); */
+			pc->stat = 2;	/* 2 -> DMA error */
+			printk(KERN_ERR "CDROM packet DMA error\n");
+		}
+	}
+
 	/* Check for errors. */
 	if (cdrom_decode_status(&startstop, drive, 0, &stat))
 		return startstop;
@@ -1463,6 +1479,14 @@ static ide_startstop_t cdrom_pc_intr (id
 
 	len = lowcyl + (256 * highcyl);
 
+	if (dma) {
+		/*
+		 * If DMA succeeded, we have all the data
+		 */
+		pc->buffer += pc->buflen;
+		pc->buflen = 0;
+	}
+
 	/* If DRQ is clear, the command has completed.
 	   Complain if we still have data left to transfer. */
 	if ((stat & DRQ_STAT) == 0) {
@@ -1568,7 +1592,11 @@ static ide_startstop_t cdrom_do_packet_c
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
@@ -1591,6 +1619,13 @@ void cdrom_sleep (int time)
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
@@ -1603,7 +1638,25 @@ int cdrom_queue_packet_command(ide_drive
 
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
 		ide_do_drive_cmd(drive, &req, ide_wait);
@@ -2352,7 +2405,12 @@ static int ide_cdrom_packet(struct cdrom
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
-	return cgc->stat = cdrom_queue_packet_command(drive, &pc);
+	if (cgc->do_dma && drive->using_dma)
+		pc.do_dma = 1;
+	cgc->stat = cdrom_queue_packet_command(drive, &pc);
+	if (pc.stat == 2)	/* DMA error: fall back to lower mode */
+		cgc->dma_error = 1;
+	return cgc->stat;
 }
 
 static
--- 24/drivers/ide/ide-cd.h~ide-akpm	Sat Jan  4 14:57:36 2003
+++ 24-akpm/drivers/ide/ide-cd.h	Sat Jan  4 14:59:29 2003
@@ -111,6 +111,7 @@ struct packet_command {
 	int quiet;
 	int timeout;
 	struct request_sense *sense;
+	int do_dma;
 	unsigned char c[12];
 };
 
--- 24/include/linux/cdrom.h~ide-akpm	Sat Jan  4 14:57:36 2003
+++ 24-akpm/include/linux/cdrom.h	Sat Jan  4 15:01:11 2003
@@ -287,6 +287,8 @@ struct cdrom_generic_command
 	unsigned char		data_direction;
 	int			quiet;
 	int			timeout;
+	int			do_dma;		/* Try to use DMA */
+	int			dma_error;	/* A DMA_specific error occurred */
 	void			*reserved[1];
 };
 
@@ -743,10 +745,15 @@ struct cdrom_device_info {
     	char name[20];                  /* name of the device type */
 /* per-device flags */
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
-        __u8 reserved		: 6;	/* not used yet */
+        __u8 dma_mode		: 2;	/* See below */
+        __u8 reserved		: 4;	/* not used yet */
 	struct cdrom_write_settings write;
 };
 
+#define CDROM_DMA_MULTI		0	/* Multiframe DMA (default) */
+#define CDROM_DMA_SINGLE	1	/* Single frame DMA */
+#define CDROM_DMA_NONE		2	/* Multiframe PIO */
+
 struct cdrom_device_ops {
 /* routines */
 	int (*open) (struct cdrom_device_info *, int);

_
