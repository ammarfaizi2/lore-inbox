Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSGNJbh>; Sun, 14 Jul 2002 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSGNJbg>; Sun, 14 Jul 2002 05:31:36 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:30436 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314885AbSGNJbc>; Sun, 14 Jul 2002 05:31:32 -0400
Date: Sun, 14 Jul 2002 11:33:41 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC][Patch] DMA for CD-ROM audio
Message-Id: <20020714113341.786b3600.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've taken the CD-audio-DMA patch from Andrew Morton and made it available as a config option. You're now able to choose whether you still want the old code which uses PIO or the new code which decreases CPU load (on some systems up to 70%) and improves total time of read.

It should be safe with old systems. My broken AMD 386 falls back to PIO.

Maybe some of the maintainers could comment.

The patch is against 2.4.19-rc1.

*Kristian

diff -rauN linux-2.4.19-rc1/Documentation/Configure.help linux-2.4.19-rc1-idecd/Documentation/Configure.help
--- linux-2.4.19-rc1/Documentation/Configure.help	Fri Jul 12 17:58:03 2002
+++ linux-2.4.19-rc1-idecd/Documentation/Configure.help	Sat Jul 13 11:57:27 2002
@@ -694,6 +694,19 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called ide-cd.o.
 
+Use DMA for IDE/ATAPI CD-ROM audio
+CONFIG_DMA_IDECD
+  Reading audio from IDE CDROMs always uses PIO.  This option
+  teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.
+
+  Total time to read a CD using cdparanoia improves by up to 20%.
+  But sometimes there is no change.
+
+  Total CPU load decreases greatly.  On a 700 MHz VIA C3 with 82C6xx
+  Southbridge the CPU load during the rip falls from 85% to 9%.
+
+  On an 850MHz P3 with piix chipset CPU load falls from 76% to 8%.
+
 Include IDE/ATAPI TAPE support
 CONFIG_BLK_DEV_IDETAPE
   If you have an IDE tape drive using the ATAPI protocol, say Y.
diff -rauN linux-2.4.19-rc1/drivers/cdrom/cdrom.c linux-2.4.19-rc1-idecd/drivers/cdrom/cdrom.c
--- linux-2.4.19-rc1/drivers/cdrom/cdrom.c	Fri Jul 12 17:58:13 2002
+++ linux-2.4.19-rc1-idecd/drivers/cdrom/cdrom.c	Sat Jul 13 12:00:34 2002
@@ -1911,6 +1911,109 @@
 	return ret;
 }
 
+#ifdef CONFIG_DMA_IDECD
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
+	 * unisgned short.
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
+#endif
+
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		     unsigned long arg)
 {		
@@ -1974,10 +2077,13 @@
 		}
 	case CDROMREADAUDIO: {
 		struct cdrom_read_audio ra;
+#ifndef CONFIG_DMA_IDECD
 		int lba, nr;
-
+#endif
 		IOCTL_IN(arg, struct cdrom_read_audio, ra);
-
+#ifdef CONFIG_DMA_IDECD
+		return cdda_read_audio(cmd, cdi, &cgc, &ra);
+#else
 		if (ra.addr_format == CDROM_MSF)
 			lba = msf_to_lba(ra.addr.msf.minute,
 					 ra.addr.msf.second,
@@ -2025,6 +2131,7 @@
 		}
 		kfree(cgc.buffer);
 		return ret;
+#endif
 		}
 	case CDROMSUBCHNL: {
 		struct cdrom_subchnl q;
diff -rauN linux-2.4.19-rc1/drivers/ide/Config.in linux-2.4.19-rc1-idecd/drivers/ide/Config.in
--- linux-2.4.19-rc1/drivers/ide/Config.in	Fri Jul 12 17:58:14 2002
+++ linux-2.4.19-rc1-idecd/drivers/ide/Config.in	Sat Jul 13 12:01:13 2002
@@ -29,6 +29,9 @@
 
    dep_tristate '  PCMCIA IDE support' CONFIG_BLK_DEV_IDECS $CONFIG_BLK_DEV_IDE $CONFIG_PCMCIA
    dep_tristate '  Include IDE/ATAPI CDROM support' CONFIG_BLK_DEV_IDECD $CONFIG_BLK_DEV_IDE
+   if [ "$CONFIG_BLK_DEV_IDECD" != "n" ]; then
+      dep_mbool '    Use DMA for IDE/ATAPI CD-ROM audio' CONFIG_DMA_IDECD $CONFIG_BLK_DEV_IDECD
+   fi
    dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
    dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
diff -rauN linux-2.4.19-rc1/drivers/ide/ide-cd.c linux-2.4.19-rc1-idecd/drivers/ide/ide-cd.c
--- linux-2.4.19-rc1/drivers/ide/ide-cd.c	Fri Jul 12 17:58:14 2002
+++ linux-2.4.19-rc1-idecd/drivers/ide/ide-cd.c	Sat Jul 13 12:07:05 2002
@@ -1312,8 +1312,29 @@
 	int ireason, len, stat, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
+#ifdef CONFIG_DMA_IDECD
+	struct cdrom_info *info = drive->driver_data;
+	int dma = info->dma;
+	int dma_error;
+#endif
 	ide_startstop_t startstop;
 
+#ifdef CONFIG_DMA_IDECD
+	/* Check for errors. */
+	if (dma) {
+		info->dma = 0;
+		if ((dma_error = HWIF(drive)->dmaproc(ide_dma_end, drive))) {
+			/*
+			 * We don't disable drive DMA for packet DMA errors.
+			 * It's handled in cdda_read_audio()
+			 */
+			/* HWIF(drive)->dmaproc(ide_dma_off, drive); */
+			pc->stat = 2;	/* 2 -> DMA error */
+			printk(KERN_ERR "CDROM packet DMA error\n");
+		}
+	}
+#endif
+
 	/* Check for errors. */
 	if (cdrom_decode_status (&startstop, drive, 0, &stat))
 		return startstop;
@@ -1322,6 +1343,16 @@
 	ireason = IN_BYTE (IDE_NSECTOR_REG);
 	len = IN_BYTE (IDE_LCYL_REG) + 256 * IN_BYTE (IDE_HCYL_REG);
 
+#ifdef CONFIG_DMA_IDECD
+	if (dma) {
+		/*
+		 * If DMA succeeded, we have all the data
+		 */
+		pc->buffer += pc->buflen;
+		pc->buflen = 0;
+	}
+#endif
+
 	/* If DRQ is clear, the command has completed.
 	   Complain if we still have data left to transfer. */
 	if ((stat & DRQ_STAT) == 0) {
@@ -1424,7 +1455,15 @@
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
 	struct cdrom_info *info = drive->driver_data;
 
+#ifdef CONFIG_DMA_IDECD
+	if (rq->bh) {
+		info->dma = 1;
+	} else {
+		info->dma = 0;
+	}
+#else
 	info->dma = 0;
+#endif
 	info->cmd = 0;
 	pc->stat = 0;
 	len = pc->buflen;
@@ -1447,6 +1486,15 @@
 	} while (sleep);
 }
 
+#ifdef CONFIG_DMA_IDECD
+/*
+ * end_buffer_io_sync() is not exported
+ */
+static void cdrom_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+{
+}
+#endif
+
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command *pc)
 {
@@ -1459,7 +1507,28 @@
 
 	/* Start of retry loop. */
 	do {
+#ifdef CONFIG_DMA_IDECD
+		struct buffer_head bh;
+#endif
 		ide_init_drive_cmd (&req);
+
+#ifdef CONFIG_DMA_IDECD
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
+#endif
+
 		req.cmd = PACKET_COMMAND;
 		req.buffer = (char *)pc;
 		ide_do_drive_cmd (drive, &req, ide_wait);
@@ -2200,7 +2269,16 @@
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
+#ifdef CONFIG_DMA_IDECD
+	if (cgc->do_dma && drive->using_dma)
+		pc.do_dma = 1;
+	cgc->stat = cdrom_queue_packet_command(drive, &pc);
+	if (pc.stat == 2)	/* DMA error: fall back to lower mode */
+		cgc->dma_error = 1;
+	return cgc->stat;
+#else
 	return cgc->stat = cdrom_queue_packet_command(drive, &pc);
+#endif
 }
 
 static
diff -rauN linux-2.4.19-rc1/drivers/ide/ide-cd.h linux-2.4.19-rc1-idecd/drivers/ide/ide-cd.h
--- linux-2.4.19-rc1/drivers/ide/ide-cd.h	Fri Jul 12 17:58:14 2002
+++ linux-2.4.19-rc1-idecd/drivers/ide/ide-cd.h	Sat Jul 13 12:07:45 2002
@@ -111,6 +111,9 @@
 	int quiet;
 	int timeout;
 	struct request_sense *sense;
+#ifdef CONFIG_DMA_IDECD
+	int do_dma;
+#endif
 	unsigned char c[12];
 };
 
diff -rauN linux-2.4.19-rc1/include/linux/cdrom.h linux-2.4.19-rc1-idecd/include/linux/cdrom.h
--- linux-2.4.19-rc1/include/linux/cdrom.h	Thu Nov 22 20:47:04 2001
+++ linux-2.4.19-rc1-idecd/include/linux/cdrom.h	Sat Jul 13 12:09:08 2002
@@ -287,6 +287,10 @@
 	unsigned char		data_direction;
 	int			quiet;
 	int			timeout;
+#ifdef CONFIG_DMA_IDECD
+	int			do_dma;		/* Try to use DMA */
+	int			dma_error;	/* A DMA_specific error occurred */
+#endif
 	void			*reserved[1];
 };
 
@@ -743,10 +747,21 @@
     	char name[20];                  /* name of the device type */
 /* per-device flags */
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
-        __u8 reserved		: 6;	/* not used yet */
+#ifdef CONFIG_DMA_IDECD
+        __u8 dma_mode		: 2;	/* See below */
+        __u8 reserved		: 4;	/* not used yet */
+#else
+	 __u8 reserved		: 6;	/* not used yet */
+#endif
 	struct cdrom_write_settings write;
 };
 
+#ifdef CONFIG_DMA_IDECD
+#define CDROM_DMA_MULTI		0	/* Multiframe DMA (default) */
+#define CDROM_DMA_SINGLE	1	/* Single frame DMA */
+#define CDROM_DMA_NONE		2	/* Multiframe PIO */
+#endif
+
 struct cdrom_device_ops {
 /* routines */
 	int (*open) (struct cdrom_device_info *, int);



  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
