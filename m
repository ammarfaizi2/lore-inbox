Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263391AbSJFMTK>; Sun, 6 Oct 2002 08:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbSJFMTK>; Sun, 6 Oct 2002 08:19:10 -0400
Received: from mailb.telia.com ([194.22.194.6]:20221 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S263397AbSJFMSs>;
	Sun, 6 Oct 2002 08:18:48 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH] 2.5.40: Make sr_packet honor provided timeout value
From: Peter Osterlund <petero2@telia.com>
Date: 06 Oct 2002 14:24:19 +0200
Message-ID: <m2ptun3gcs.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that makes the sr_packet function in sr.c use the
timeout value provided by the cdrom_generic_command argument, instead
of using the previously hardcoded value in sr_do_ioctl.

The patch is needed by some user space tools related to CDRW packet
writing and DVD writing. The IDE equivalent (ide_cdrom_packet) has
been honoring the provided timeout value for a long time.

This is implemented by changing sr_do_ioctl() to take a
cdrom_generic_command pointer instead of adding yet another parameter
to the already too long parameter list. It now takes two parameters
instead of seven.

Please apply.

 drivers/scsi/sr.c        |   26 ++--
 drivers/scsi/sr.h        |    6 -
 drivers/scsi/sr_ioctl.c  |  271 +++++++++++++++++++++++++----------------------
 drivers/scsi/sr_vendor.c |  115 ++++++++++++-------
 4 files changed, 242 insertions(+), 176 deletions(-)

diff -u -r -N linux.old/drivers/scsi/sr.c linux.new/drivers/scsi/sr.c
--- linux.old/drivers/scsi/sr.c	Wed Oct  2 22:19:45 2002
+++ linux.new/drivers/scsi/sr.c	Sun Oct  6 13:25:24 2002
@@ -575,7 +575,7 @@
 
 void get_capabilities(Scsi_CD *cd)
 {
-	unsigned char cmd[6];
+	struct cdrom_generic_command cgc;
 	unsigned char *buffer;
 	int rc, n;
 
@@ -597,13 +597,18 @@
 		printk(KERN_ERR "sr: out of memory.\n");
 		return;
 	}
-	cmd[0] = MODE_SENSE;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		 ((cd->device->lun << 5) & 0xe0) : 0;
-	cmd[2] = 0x2a;
-	cmd[4] = 128;
-	cmd[3] = cmd[5] = 0;
-	rc = sr_do_ioctl(cd, cmd, buffer, 128, 1, SCSI_DATA_READ, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = MODE_SENSE;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     ((cd->device->lun << 5) & 0xe0) : 0;
+	cgc.cmd[2] = 0x2a;
+	cgc.cmd[4] = 128;
+	cgc.buffer = buffer;
+	cgc.buflen = 128;
+	cgc.quiet = 1;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = SR_TIMEOUT;
+	rc = sr_do_ioctl(cd, &cgc);
 
 	if (rc) {
 		/* failed, drive doesn't have capabilities mode page */
@@ -680,7 +685,10 @@
 	if (device->scsi_level <= SCSI_2)
 		cgc->cmd[1] |= device->lun << 5;
 
-	cgc->stat = sr_do_ioctl(cdi->handle, cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
+	if (cgc->timeout <= 0)
+		cgc->timeout = IOCTL_TIMEOUT;
+
+	sr_do_ioctl(cdi->handle, cgc);
 
 	return cgc->stat;
 }
diff -u -r -N linux.old/drivers/scsi/sr.h linux.new/drivers/scsi/sr.h
--- linux.old/drivers/scsi/sr.h	Mon Sep  9 20:54:11 2002
+++ linux.new/drivers/scsi/sr.h	Sun Oct  6 13:25:25 2002
@@ -20,6 +20,10 @@
 #include "scsi.h"
 #include <linux/genhd.h>
 
+/* The CDROM is fairly slow, so we need a little extra time */
+/* In fact, it is very slow if it has to spin up first */
+#define IOCTL_TIMEOUT 30*HZ
+
 typedef struct {
 	unsigned capacity;	/* size in blocks                       */
 	Scsi_Device *device;
@@ -34,7 +38,7 @@
 	struct gendisk *disk;
 } Scsi_CD;
 
-int sr_do_ioctl(Scsi_CD *, unsigned char *, void *, unsigned, int, int, struct request_sense *);
+int sr_do_ioctl(Scsi_CD *, struct cdrom_generic_command *);
 
 int sr_lock_door(struct cdrom_device_info *, int);
 int sr_tray_move(struct cdrom_device_info *, int);
diff -u -r -N linux.old/drivers/scsi/sr_ioctl.c linux.new/drivers/scsi/sr_ioctl.c
--- linux.old/drivers/scsi/sr_ioctl.c	Sun Sep 22 11:44:31 2002
+++ linux.new/drivers/scsi/sr_ioctl.c	Sun Oct  6 13:25:30 2002
@@ -25,9 +25,6 @@
 static int xa_test = 0;
 
 #define IOCTL_RETRIES 3
-/* The CDROM is fairly slow, so we need a little extra time */
-/* In fact, it is very slow if it has to spin up first */
-#define IOCTL_TIMEOUT 30*HZ
 
 /* ATAPI drives don't have a SCMD_PLAYAUDIO_TI command.  When these drives
    are emulating a SCSI device via the idescsi module, they need to have
@@ -37,7 +34,7 @@
 {
 	struct cdrom_tocentry trk0_te, trk1_te;
 	struct cdrom_tochdr tochdr;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	int ntracks, ret;
 
 	if ((ret = sr_audio_ioctl(cdi, CDROMREADTOCHDR, &tochdr)))
@@ -59,22 +56,25 @@
 		return ret;
 	if ((ret = sr_audio_ioctl(cdi, CDROMREADTOCENTRY, &trk1_te)))
 		return ret;
-	
-	sr_cmd[0] = GPCMD_PLAY_AUDIO_MSF;
-	sr_cmd[3] = trk0_te.cdte_addr.msf.minute;
-	sr_cmd[4] = trk0_te.cdte_addr.msf.second;
-	sr_cmd[5] = trk0_te.cdte_addr.msf.frame;
-	sr_cmd[6] = trk1_te.cdte_addr.msf.minute;
-	sr_cmd[7] = trk1_te.cdte_addr.msf.second;
-	sr_cmd[8] = trk1_te.cdte_addr.msf.frame;
-	return sr_do_ioctl(cdi->handle, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+	cgc.cmd[3] = trk0_te.cdte_addr.msf.minute;
+	cgc.cmd[4] = trk0_te.cdte_addr.msf.second;
+	cgc.cmd[5] = trk0_te.cdte_addr.msf.frame;
+	cgc.cmd[6] = trk1_te.cdte_addr.msf.minute;
+	cgc.cmd[7] = trk1_te.cdte_addr.msf.second;
+	cgc.cmd[8] = trk1_te.cdte_addr.msf.frame;
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(cdi->handle, &cgc);
 }
 
 /* We do our own retries because we want to know what the specific
    error code is.  Normally the UNIT_ATTENTION code will automatically
    clear after one error */
 
-int sr_do_ioctl(Scsi_CD *cd, unsigned char *sr_cmd, void *buffer, unsigned buflength, int quiet, int readwrite, struct request_sense *sense)
+int sr_do_ioctl(Scsi_CD *cd, struct cdrom_generic_command *cgc)
 {
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDev;
@@ -86,29 +86,32 @@
 	SRpnt = scsi_allocate_request(SDev);
         if (!SRpnt) {
                 printk("Unable to allocate SCSI request in sr_do_ioctl");
-                return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
         }
-	SRpnt->sr_data_direction = readwrite;
+	SRpnt->sr_data_direction = cgc->data_direction;
 
 	/* use ISA DMA buffer if necessary */
-	SRpnt->sr_request->buffer = buffer;
-	if (buffer && SRpnt->sr_host->unchecked_isa_dma &&
-	    (virt_to_phys(buffer) + buflength - 1 > ISA_DMA_THRESHOLD)) {
-		bounce_buffer = (char *) kmalloc(buflength, GFP_DMA);
+	SRpnt->sr_request->buffer = cgc->buffer;
+	if (cgc->buffer && SRpnt->sr_host->unchecked_isa_dma &&
+	    (virt_to_phys(cgc->buffer) + cgc->buflen - 1 > ISA_DMA_THRESHOLD)) {
+		bounce_buffer = (char *) kmalloc(cgc->buflen, GFP_DMA);
 		if (bounce_buffer == NULL) {
 			printk("SCSI DMA pool exhausted.");
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
-		memcpy(bounce_buffer, (char *) buffer, buflength);
-		buffer = bounce_buffer;
+		memcpy(bounce_buffer, cgc->buffer, cgc->buflen);
+		cgc->buffer = bounce_buffer;
 	}
       retry:
-	if (!scsi_block_when_processing_errors(SDev))
-		return -ENODEV;
-
+	if (!scsi_block_when_processing_errors(SDev)) {
+		err = -ENODEV;
+		goto out;
+	}
 
-	scsi_wait_req(SRpnt, (void *) sr_cmd, (void *) buffer, buflength,
-		      IOCTL_TIMEOUT, IOCTL_RETRIES);
+	scsi_wait_req(SRpnt, cgc->cmd, cgc->buffer, cgc->buflen,
+		      cgc->timeout, IOCTL_RETRIES);
 
 	req = SRpnt->sr_request;
 	if (SRpnt->sr_buffer && req->buffer && SRpnt->sr_buffer != req->buffer) {
@@ -124,7 +127,7 @@
 		switch (SRpnt->sr_sense_buffer[2] & 0xf) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_INFO "%s: disc change detected.\n", cd->cdi.name);
 			if (retries++ < 10)
 				goto retry;
@@ -134,7 +137,7 @@
 			if (SRpnt->sr_sense_buffer[12] == 0x04 &&
 			    SRpnt->sr_sense_buffer[13] == 0x01) {
 				/* sense: Logical unit is in process of becoming ready */
-				if (!quiet)
+				if (!cgc->quiet)
 					printk(KERN_INFO "%s: CDROM not ready yet.\n", cd->cdi.name);
 				if (retries++ < 10) {
 					/* sleep 2 sec and try again */
@@ -146,7 +149,7 @@
 					break;
 				}
 			}
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_INFO "%s: CDROM not ready.  Make sure there is a disc in the drive.\n", cd->cdi.name);
 #ifdef DEBUG
 			print_req_sense("sr", SRpnt);
@@ -154,7 +157,7 @@
 			err = -ENOMEDIUM;
 			break;
 		case ILLEGAL_REQUEST:
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_ERR "%s: CDROM (ioctl) reports ILLEGAL "
 				       "REQUEST.\n", cd->cdi.name);
 			if (SRpnt->sr_sense_buffer[12] == 0x20 &&
@@ -165,24 +168,26 @@
 				err = -EINVAL;
 			}
 #ifdef DEBUG
-			print_command(sr_cmd);
+			print_command(cgc->cmd);
 			print_req_sense("sr", SRpnt);
 #endif
 			break;
 		default:
 			printk(KERN_ERR "%s: CDROM (ioctl) error, command: ", cd->cdi.name);
-			print_command(sr_cmd);
+			print_command(cgc->cmd);
 			print_req_sense("sr", SRpnt);
 			err = -EIO;
 		}
 	}
 
-	if (sense)
-		memcpy(sense, SRpnt->sr_sense_buffer, sizeof(*sense));
+	if (cgc->sense)
+		memcpy(cgc->sense, SRpnt->sr_sense_buffer, sizeof(*cgc->sense));
 
 	/* Wake up a process waiting for device */
 	scsi_release_request(SRpnt);
 	SRpnt = NULL;
+      out:
+	cgc->stat = err;
 	return err;
 }
 
@@ -191,27 +196,31 @@
 
 static int test_unit_ready(Scsi_CD *cd)
 {
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 
-	sr_cmd[0] = GPCMD_TEST_UNIT_READY;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-	return sr_do_ioctl(cd, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     ((cd->device->lun) << 5) : 0;
+	cgc.quiet = 1;
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(cd, &cgc);
 }
 
 int sr_tray_move(struct cdrom_device_info *cdi, int pos)
 {
 	Scsi_CD *cd = cdi->handle;
-	u_char sr_cmd[10];
-
-	sr_cmd[0] = GPCMD_START_STOP_UNIT;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
-	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
+	struct cdrom_generic_command cgc;
 
-	return sr_do_ioctl(cd, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_START_STOP_UNIT;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     ((cd->device->lun) << 5) : 0;
+	cgc.cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(cd, &cgc);
 }
 
 int sr_lock_door(struct cdrom_device_info *cdi, int lock)
@@ -278,22 +287,22 @@
 int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
 	Scsi_CD *cd = cdi->handle;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	char buffer[32];
 	int result;
 
-	sr_cmd[0] = GPCMD_READ_SUBCHANNEL;
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = 0x40;	/* I do want the subchannel info */
-	sr_cmd[3] = 0x02;	/* Give me medium catalog number info */
-	sr_cmd[4] = sr_cmd[5] = 0;
-	sr_cmd[6] = 0;
-	sr_cmd[7] = 0;
-	sr_cmd[8] = 24;
-	sr_cmd[9] = 0;
-
-	result = sr_do_ioctl(cd, sr_cmd, buffer, 24, 0, SCSI_DATA_READ, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_SUBCHANNEL;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     ((cd->device->lun) << 5) : 0;
+	cgc.cmd[2] = 0x40;	/* I do want the subchannel info */
+	cgc.cmd[3] = 0x02;	/* Give me medium catalog number info */
+	cgc.cmd[8] = 24;
+	cgc.buffer = buffer;
+	cgc.buflen = 24;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	result = sr_do_ioctl(cd, &cgc);
 
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
@@ -309,21 +318,23 @@
 int sr_select_speed(struct cdrom_device_info *cdi, int speed)
 {
 	Scsi_CD *cd = cdi->handle;
-	u_char sr_cmd[MAX_COMMAND_SIZE];
+	struct cdrom_generic_command cgc;
 
 	if (speed == 0)
 		speed = 0xffff;	/* set to max */
 	else
 		speed *= 177;	/* Nx to kbyte/s */
 
-	memset(sr_cmd, 0, MAX_COMMAND_SIZE);
-	sr_cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
-	sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	            ((cd->device->lun) << 5) : 0;
-	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
-	sr_cmd[3] = speed & 0xff;	/* LSB */
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     ((cd->device->lun) << 5) : 0;
+	cgc.cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
+	cgc.cmd[3] = speed & 0xff;	/* LSB */
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
 
-	if (sr_do_ioctl(cd, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL))
+	if (sr_do_ioctl(cd, &cgc))
 		return -EIO;
 	return 0;
 }
@@ -337,24 +348,28 @@
 int sr_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
 {
 	Scsi_CD *cd = cdi->handle;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	int result;
 	unsigned char buffer[32];
 
-	memset(sr_cmd, 0, sizeof(sr_cmd));
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.timeout = IOCTL_TIMEOUT;
 
 	switch (cmd) {
 	case CDROMREADTOCHDR:
 		{
 			struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
 
-			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			            ((cd->device->lun) << 5) : 0;
-			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-			sr_cmd[8] = 12;		/* LSB of length */
+			cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+			cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+				     ((cd->device->lun) << 5) : 0;
+			cgc.cmd[8] = 12;		/* LSB of length */
+			cgc.buffer = buffer;
+			cgc.buflen = 12;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
 
-			result = sr_do_ioctl(cd, sr_cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+			result = sr_do_ioctl(cd, &cgc);
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
@@ -366,15 +381,17 @@
 		{
 			struct cdrom_tocentry *tocentry = (struct cdrom_tocentry *) arg;
 
-			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			            ((cd->device->lun) << 5) : 0;
-			sr_cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
-			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-			sr_cmd[6] = tocentry->cdte_track;
-			sr_cmd[8] = 12;		/* LSB of length */
+			cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+			cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+				     ((cd->device->lun) << 5) : 0;
+			cgc.cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
+			cgc.cmd[6] = tocentry->cdte_track;
+			cgc.cmd[8] = 12;		/* LSB of length */
+			cgc.buffer = buffer;
+			cgc.buflen = 12;
+			cgc.data_direction = SCSI_DATA_READ;
 
-			result = sr_do_ioctl(cd, sr_cmd, buffer, 12, 0, SCSI_DATA_READ, NULL);
+			result = sr_do_ioctl(cd, &cgc);
 
 			tocentry->cdte_ctrl = buffer[5] & 0xf;
 			tocentry->cdte_adr = buffer[5] >> 4;
@@ -393,15 +410,16 @@
 	case CDROMPLAYTRKIND: {
 		struct cdrom_ti* ti = (struct cdrom_ti*)arg;
 
-		sr_cmd[0] = GPCMD_PLAYAUDIO_TI;
-		sr_cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		            (cd->device->lun << 5) : 0;
-		sr_cmd[4] = ti->cdti_trk0;
-		sr_cmd[5] = ti->cdti_ind0;
-		sr_cmd[7] = ti->cdti_trk1;
-		sr_cmd[8] = ti->cdti_ind1;
+		cgc.cmd[0] = GPCMD_PLAYAUDIO_TI;
+		cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+			     (cd->device->lun << 5) : 0;
+		cgc.cmd[4] = ti->cdti_trk0;
+		cgc.cmd[5] = ti->cdti_ind0;
+		cgc.cmd[7] = ti->cdti_trk1;
+		cgc.cmd[8] = ti->cdti_ind1;
+		cgc.data_direction = SCSI_DATA_NONE;
 
-		result = sr_do_ioctl(cd, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+		result = sr_do_ioctl(cd, &cgc);
 		if (result == -EDRIVE_CANT_DO_THIS)
 			result = sr_fake_playtrkind(cdi, ti);
 
@@ -436,38 +454,42 @@
 
 static int sr_read_cd(Scsi_CD *cd, unsigned char *dest, int lba, int format, int blksize)
 {
-	unsigned char cmd[MAX_COMMAND_SIZE];
+	struct cdrom_generic_command cgc;
 
 #ifdef DEBUG
 	printk("%s: sr_read_cd lba=%d format=%d blksize=%d\n",
 	       cd->cdi.name, lba, format, blksize);
 #endif
 
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = GPCMD_READ_CD;	/* READ_CD */
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
-	cmd[1] |= ((format & 7) << 2);
-	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
-	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
-	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
-	cmd[5] = (unsigned char) lba & 0xff;
-	cmd[8] = 1;
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_CD;	/* READ_CD */
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     (cd->device->lun << 5) : 0;
+	cgc.cmd[1] |= ((format & 7) << 2);
+	cgc.cmd[2] = (unsigned char) (lba >> 24) & 0xff;
+	cgc.cmd[3] = (unsigned char) (lba >> 16) & 0xff;
+	cgc.cmd[4] = (unsigned char) (lba >> 8) & 0xff;
+	cgc.cmd[5] = (unsigned char) lba & 0xff;
+	cgc.cmd[8] = 1;
 	switch (blksize) {
 	case 2336:
-		cmd[9] = 0x58;
+		cgc.cmd[9] = 0x58;
 		break;
 	case 2340:
-		cmd[9] = 0x78;
+		cgc.cmd[9] = 0x78;
 		break;
 	case 2352:
-		cmd[9] = 0xf8;
+		cgc.cmd[9] = 0xf8;
 		break;
 	default:
-		cmd[9] = 0x10;
+		cgc.cmd[9] = 0x10;
 		break;
 	}
-	return sr_do_ioctl(cd, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
+	cgc.buffer = dest;
+	cgc.buflen = blksize;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(cd, &cgc);
 }
 
 /*
@@ -476,7 +498,7 @@
 
 static int sr_read_sector(Scsi_CD *cd, int lba, int blksize, unsigned char *dest)
 {
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	int rc;
 
 	/* we try the READ CD command first... */
@@ -497,16 +519,20 @@
 	printk("%s: sr_read_sector lba=%d blksize=%d\n", cd->cdi.name, lba, blksize);
 #endif
 
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = GPCMD_READ_10;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
-	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
-	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
-	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
-	cmd[5] = (unsigned char) lba & 0xff;
-	cmd[8] = 1;
-	rc = sr_do_ioctl(cd, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_10;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     (cd->device->lun << 5) : 0;
+	cgc.cmd[2] = (unsigned char) (lba >> 24) & 0xff;
+	cgc.cmd[3] = (unsigned char) (lba >> 16) & 0xff;
+	cgc.cmd[4] = (unsigned char) (lba >> 8) & 0xff;
+	cgc.cmd[5] = (unsigned char) lba & 0xff;
+	cgc.cmd[8] = 1;
+	cgc.buffer = dest;
+	cgc.buflen = blksize;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	rc = sr_do_ioctl(cd, &cgc);
 
 	return rc;
 }
@@ -562,7 +588,6 @@
  * c-label-offset: -4
  * c-continued-statement-offset: 4
  * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
  * tab-width: 8
  * End:
  */
diff -u -r -N linux.old/drivers/scsi/sr_vendor.c linux.new/drivers/scsi/sr_vendor.c
--- linux.old/drivers/scsi/sr_vendor.c	Mon Sep  9 20:54:11 2002
+++ linux.new/drivers/scsi/sr_vendor.c	Sun Oct  6 13:25:38 2002
@@ -58,6 +58,8 @@
 #define VENDOR_TOSHIBA         3
 #define VENDOR_WRITER          4	/* pre-scsi3 writers */
 
+#define VENDOR_TIMEOUT	30*HZ
+
 void sr_vendor_init(Scsi_CD *cd)
 {
 #ifndef CONFIG_BLK_DEV_SR_VENDOR
@@ -104,7 +106,7 @@
 int sr_set_blocklength(Scsi_CD *cd, int blocklength)
 {
 	unsigned char *buffer;	/* the buffer for the ioctl */
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	struct ccs_modesel_head *modesel;
 	int rc, density = 0;
 
@@ -120,19 +122,23 @@
 #ifdef DEBUG
 	printk("%s: MODE SELECT 0x%x/%d\n", cd->cdi.name, density, blocklength);
 #endif
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = MODE_SELECT;
-	cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-	         (cd->device->lun << 5) : 0;
-	cmd[1] |= (1 << 4);
-	cmd[4] = 12;
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = MODE_SELECT;
+	cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+		     (cd->device->lun << 5) : 0;
+	cgc.cmd[1] |= (1 << 4);
+	cgc.cmd[4] = 12;
 	modesel = (struct ccs_modesel_head *) buffer;
 	memset(modesel, 0, sizeof(*modesel));
 	modesel->block_desc_length = 0x08;
 	modesel->density = density;
 	modesel->block_length_med = (blocklength >> 8) & 0xff;
 	modesel->block_length_lo = blocklength & 0xff;
-	if (0 == (rc = sr_do_ioctl(cd, cmd, buffer, sizeof(*modesel), 0, SCSI_DATA_WRITE, NULL))) {
+	cgc.buffer = buffer;
+	cgc.buflen = sizeof(*modesel);
+	cgc.data_direction = SCSI_DATA_WRITE;
+	cgc.timeout = VENDOR_TIMEOUT;
+	if (0 == (rc = sr_do_ioctl(cd, &cgc))) {
 		cd->device->sector_size = blocklength;
 	}
 #ifdef DEBUG
@@ -154,7 +160,7 @@
 	Scsi_CD *cd = cdi->handle;
 	unsigned long sector;
 	unsigned char *buffer;	/* the buffer for the ioctl */
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	int rc, no_multi;
 
 	if (cd->cdi.mask & CDC_MULTI_SESSION)
@@ -168,16 +174,22 @@
 	no_multi = 0;		/* flag: the drive can't handle multisession */
 	rc = 0;
 
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+
 	switch (cd->vendor) {
 
 	case VENDOR_SCSI3:
-		memset(cmd, 0, MAX_COMMAND_SIZE);
-		cmd[0] = READ_TOC;
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
-		cmd[8] = 12;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(cd, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;
+		cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+			     (cd->device->lun << 5) : 0;
+		cgc.cmd[8] = 12;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 12;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(cd, &cgc);
 		if (rc != 0)
 			break;
 		if ((buffer[0] << 8) + buffer[1] < 0x0a) {
@@ -197,13 +209,17 @@
 #ifdef CONFIG_BLK_DEV_SR_VENDOR
 	case VENDOR_NEC:{
 			unsigned long min, sec, frame;
-			memset(cmd, 0, MAX_COMMAND_SIZE);
-			cmd[0] = 0xde;
-			cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			         (cd->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
-			cmd[2] = 0xb0;
-			rc = sr_do_ioctl(cd, cmd, buffer, 0x16, 1, SCSI_DATA_READ, NULL);
+			cgc.cmd[0] = 0xde;
+			cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+				     (cd->device->lun << 5) : 0;
+			cgc.cmd[1] |= 0x03;
+			cgc.cmd[2] = 0xb0;
+			cgc.buffer = buffer;
+			cgc.buflen = 0x16;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
+			cgc.timeout = VENDOR_TIMEOUT;
+			rc = sr_do_ioctl(cd, &cgc);
 			if (rc != 0)
 				break;
 			if (buffer[14] != 0 && buffer[14] != 0xb0) {
@@ -225,12 +241,16 @@
 
 			/* we request some disc information (is it a XA-CD ?,
 			 * where starts the last session ?) */
-			memset(cmd, 0, MAX_COMMAND_SIZE);
-			cmd[0] = 0xc7;
-			cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-			         (cd->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
-			rc = sr_do_ioctl(cd, cmd, buffer, 4, 1, SCSI_DATA_READ, NULL);
+			cgc.cmd[0] = 0xc7;
+			cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+				     (cd->device->lun << 5) : 0;
+			cgc.cmd[1] |= 0x03;
+			cgc.buffer = buffer;
+			cgc.buflen = 4;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
+			cgc.timeout = VENDOR_TIMEOUT;
+			rc = sr_do_ioctl(cd, &cgc);
 			if (rc == -EINVAL) {
 				printk(KERN_INFO "%s: Hmm, seems the drive "
 				       "doesn't support multisession CD's\n",
@@ -251,13 +271,17 @@
 		}
 
 	case VENDOR_WRITER:
-		memset(cmd, 0, MAX_COMMAND_SIZE);
-		cmd[0] = READ_TOC;
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
-		cmd[8] = 0x04;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(cd, cmd, buffer, 0x04, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;
+		cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+			     (cd->device->lun << 5) : 0;
+		cgc.cmd[8] = 0x04;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 0x04;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(cd, &cgc);
 		if (rc != 0) {
 			break;
 		}
@@ -266,13 +290,18 @@
 			       "%s: No finished session\n", cd->cdi.name);
 			break;
 		}
-		cmd[0] = READ_TOC;	/* Read TOC */
-		cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
-		         (cd->device->lun << 5) : 0;
-		cmd[6] = rc & 0x7f;	/* number of last session */
-		cmd[8] = 0x0c;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(cd, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;	/* Read TOC */
+		cgc.cmd[1] = (cd->device->scsi_level <= SCSI_2) ?
+			     (cd->device->lun << 5) : 0;
+		cgc.cmd[6] = rc & 0x7f;	/* number of last session */
+		cgc.cmd[8] = 0x0c;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 12;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(cd, &cgc);
 		if (rc != 0) {
 			break;
 		}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
