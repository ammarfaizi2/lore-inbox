Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319218AbSIDRLl>; Wed, 4 Sep 2002 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319220AbSIDRLl>; Wed, 4 Sep 2002 13:11:41 -0400
Received: from mailb.telia.com ([194.22.194.6]:22732 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S319218AbSIDRLc>;
	Wed, 4 Sep 2002 13:11:32 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.33: Modifiable timeout in sr_packet
From: Peter Osterlund <petero2@telia.com>
Date: 04 Sep 2002 19:16:02 +0200
Message-ID: <m27ki1r7zh.fsf@p4.localdomain>
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

This is implemented by changing the sr_do_ioctl() function to take a
cdrom_generic_command pointer instead of a whole bunch of parameters.

Please apply.


diff -u -r orig/linux-2.5.33/drivers/scsi/sr.c linux-2.5.33/drivers/scsi/sr.c
--- orig/linux-2.5.33/drivers/scsi/sr.c	Wed Sep  4 18:28:55 2002
+++ linux-2.5.33/drivers/scsi/sr.c	Wed Sep  4 18:31:03 2002
@@ -581,7 +581,7 @@
 void get_capabilities(int i)
 {
 	Scsi_CD *SCp;
-	unsigned char cmd[6];
+	struct cdrom_generic_command cgc;
 	unsigned char *buffer;
 	int rc, n;
 
@@ -604,13 +604,18 @@
 		printk(KERN_ERR "sr: out of memory.\n");
 		return;
 	}
-	cmd[0] = MODE_SENSE;
-	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-		 ((SCp->device->lun << 5) & 0xe0) : 0;
-	cmd[2] = 0x2a;
-	cmd[4] = 128;
-	cmd[3] = cmd[5] = 0;
-	rc = sr_do_ioctl(i, cmd, buffer, 128, 1, SCSI_DATA_READ, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = MODE_SENSE;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     ((SCp->device->lun << 5) & 0xe0) : 0;
+	cgc.cmd[2] = 0x2a;
+	cgc.cmd[4] = 128;
+	cgc.buffer = buffer;
+	cgc.buflen = 128;
+	cgc.quiet = 1;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = SR_TIMEOUT;
+	rc = sr_do_ioctl(i, &cgc);
 
 	if (rc) {
 		/* failed, drive doesn't have capabilities mode page */
@@ -687,7 +692,10 @@
 	if (device->scsi_level <= SCSI_2)
 		cgc->cmd[1] |= device->lun << 5;
 
-	cgc->stat = sr_do_ioctl(minor(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
+	if (cgc->timeout <= 0)
+		cgc->timeout = IOCTL_TIMEOUT;
+
+	sr_do_ioctl(minor(cdi->dev), cgc);
 
 	return cgc->stat;
 }
diff -u -r orig/linux-2.5.33/drivers/scsi/sr.h linux-2.5.33/drivers/scsi/sr.h
--- orig/linux-2.5.33/drivers/scsi/sr.h	Sun Aug 11 03:41:26 2002
+++ linux-2.5.33/drivers/scsi/sr.h	Wed Sep  4 18:31:03 2002
@@ -19,6 +19,10 @@
 
 #include "scsi.h"
 
+/* The CDROM is fairly slow, so we need a little extra time */
+/* In fact, it is very slow if it has to spin up first */
+#define IOCTL_TIMEOUT 30*HZ
+
 typedef struct {
 	unsigned capacity;	/* size in blocks                       */
 	Scsi_Device *device;
@@ -34,7 +38,7 @@
 
 extern Scsi_CD *scsi_CDs;
 
-int sr_do_ioctl(int, unsigned char *, void *, unsigned, int, int, struct request_sense *);
+int sr_do_ioctl(int, struct cdrom_generic_command *);
 
 int sr_lock_door(struct cdrom_device_info *, int);
 int sr_tray_move(struct cdrom_device_info *, int);
diff -u -r orig/linux-2.5.33/drivers/scsi/sr_ioctl.c linux-2.5.33/drivers/scsi/sr_ioctl.c
--- orig/linux-2.5.33/drivers/scsi/sr_ioctl.c	Sun Aug 11 03:41:42 2002
+++ linux-2.5.33/drivers/scsi/sr_ioctl.c	Wed Sep  4 18:31:03 2002
@@ -27,9 +27,6 @@
 extern void get_sectorsize(int);
 
 #define IOCTL_RETRIES 3
-/* The CDROM is fairly slow, so we need a little extra time */
-/* In fact, it is very slow if it has to spin up first */
-#define IOCTL_TIMEOUT 30*HZ
 
 /* ATAPI drives don't have a SCMD_PLAYAUDIO_TI command.  When these drives
    are emulating a SCSI device via the idescsi module, they need to have
@@ -39,7 +36,7 @@
 {
 	struct cdrom_tocentry trk0_te, trk1_te;
 	struct cdrom_tochdr tochdr;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	int ntracks, ret;
 
 	if ((ret = sr_audio_ioctl(cdi, CDROMREADTOCHDR, &tochdr)))
@@ -61,22 +58,25 @@
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
-	return sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
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
+	return sr_do_ioctl(minor(cdi->dev), &cgc);
 }
 
 /* We do our own retries because we want to know what the specific
    error code is.  Normally the UNIT_ATTENTION code will automatically
    clear after one error */
 
-int sr_do_ioctl(int target, unsigned char *sr_cmd, void *buffer, unsigned buflength, int quiet, int readwrite, struct request_sense *sense)
+int sr_do_ioctl(int target, struct cdrom_generic_command *cgc)
 {
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDev;
@@ -88,29 +88,32 @@
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
@@ -126,7 +129,7 @@
 		switch (SRpnt->sr_sense_buffer[2] & 0xf) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_INFO "sr%d: disc change detected.\n", target);
 			if (retries++ < 10)
 				goto retry;
@@ -136,7 +139,7 @@
 			if (SRpnt->sr_sense_buffer[12] == 0x04 &&
 			    SRpnt->sr_sense_buffer[13] == 0x01) {
 				/* sense: Logical unit is in process of becoming ready */
-				if (!quiet)
+				if (!cgc->quiet)
 					printk(KERN_INFO "sr%d: CDROM not ready yet.\n", target);
 				if (retries++ < 10) {
 					/* sleep 2 sec and try again */
@@ -148,7 +151,7 @@
 					break;
 				}
 			}
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_INFO "sr%d: CDROM not ready.  Make sure there is a disc in the drive.\n", target);
 #ifdef DEBUG
 			print_req_sense("sr", SRpnt);
@@ -156,7 +159,7 @@
 			err = -ENOMEDIUM;
 			break;
 		case ILLEGAL_REQUEST:
-			if (!quiet)
+			if (!cgc->quiet)
 				printk(KERN_ERR "sr%d: CDROM (ioctl) reports ILLEGAL "
 				       "REQUEST.\n", target);
 			if (SRpnt->sr_sense_buffer[12] == 0x20 &&
@@ -167,24 +170,26 @@
 				err = -EINVAL;
 			}
 #ifdef DEBUG
-			print_command(sr_cmd);
+			print_command(cgc->cmd);
 			print_req_sense("sr", SRpnt);
 #endif
 			break;
 		default:
 			printk(KERN_ERR "sr%d: CDROM (ioctl) error, command: ", target);
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
 
@@ -194,28 +199,32 @@
 static int test_unit_ready(int minor)
 {
 	Scsi_CD *SCp;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 
 	SCp = &scsi_CDs[minor];
-	sr_cmd[0] = GPCMD_TEST_UNIT_READY;
-	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	            ((SCp->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-	return sr_do_ioctl(minor, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     ((SCp->device->lun) << 5) : 0;
+	cgc.quiet = 1;
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(minor, &cgc);
 }
 
 int sr_tray_move(struct cdrom_device_info *cdi, int pos)
 {
 	Scsi_CD *SCp = cdi->handle;
-	u_char sr_cmd[10];
-
-	sr_cmd[0] = GPCMD_START_STOP_UNIT;
-	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	            ((SCp->device->lun) << 5) : 0;
-	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
-	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
+	struct cdrom_generic_command cgc;
 
-	return sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_START_STOP_UNIT;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     ((SCp->device->lun) << 5) : 0;
+	cgc.cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(minor(cdi->dev), &cgc);
 }
 
 int sr_lock_door(struct cdrom_device_info *cdi, int lock)
@@ -282,22 +291,22 @@
 int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
 	Scsi_CD *SCp = cdi->handle;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	char buffer[32];
 	int result;
 
-	sr_cmd[0] = GPCMD_READ_SUBCHANNEL;
-	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	            ((SCp->device->lun) << 5) : 0;
-	sr_cmd[2] = 0x40;	/* I do want the subchannel info */
-	sr_cmd[3] = 0x02;	/* Give me medium catalog number info */
-	sr_cmd[4] = sr_cmd[5] = 0;
-	sr_cmd[6] = 0;
-	sr_cmd[7] = 0;
-	sr_cmd[8] = 24;
-	sr_cmd[9] = 0;
-
-	result = sr_do_ioctl(minor(cdi->dev), sr_cmd, buffer, 24, 0, SCSI_DATA_READ, NULL);
+        memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_SUBCHANNEL;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     ((SCp->device->lun) << 5) : 0;
+	cgc.cmd[2] = 0x40;	/* I do want the subchannel info */
+	cgc.cmd[3] = 0x02;	/* Give me medium catalog number info */
+	cgc.cmd[8] = 24;
+	cgc.buffer = buffer;
+	cgc.buflen = 24;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	result = sr_do_ioctl(minor(cdi->dev), &cgc);
 
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
@@ -314,21 +323,23 @@
 int sr_select_speed(struct cdrom_device_info *cdi, int speed)
 {
 	Scsi_CD *SCp = cdi->handle;
-	u_char sr_cmd[MAX_COMMAND_SIZE];
+	struct cdrom_generic_command cgc;
 
 	if (speed == 0)
 		speed = 0xffff;	/* set to max */
 	else
 		speed *= 177;	/* Nx to kbyte/s */
 
-	memset(sr_cmd, 0, MAX_COMMAND_SIZE);
-	sr_cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
-	sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	            ((SCp->device->lun) << 5) : 0;
-	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
-	sr_cmd[3] = speed & 0xff;	/* LSB */
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_SET_SPEED;	/* SET CD SPEED */
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     ((SCp->device->lun) << 5) : 0;
+	cgc.cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
+	cgc.cmd[3] = speed & 0xff;	/* LSB */
+	cgc.data_direction = SCSI_DATA_NONE;
+	cgc.timeout = IOCTL_TIMEOUT;
 
-	if (sr_do_ioctl(minor(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL))
+	if (sr_do_ioctl(minor(cdi->dev), &cgc))
 		return -EIO;
 	return 0;
 }
@@ -342,24 +353,28 @@
 int sr_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
 {
 	Scsi_CD *SCp = cdi->handle;
-	u_char sr_cmd[10];
+	struct cdrom_generic_command cgc;
 	int result, target = minor(cdi->dev);
 	unsigned char buffer[32];
 
-	memset(sr_cmd, 0, sizeof(sr_cmd));
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.timeout = IOCTL_TIMEOUT;
 
 	switch (cmd) {
 	case CDROMREADTOCHDR:
 		{
 			struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
 
-			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-			            ((SCp->device->lun) << 5) : 0;
-			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-			sr_cmd[8] = 12;		/* LSB of length */
+			cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+			cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+				     ((SCp->device->lun) << 5) : 0;
+			cgc.cmd[8] = 12;		/* LSB of length */
+			cgc.buffer = buffer;
+			cgc.buflen = 12;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
 
-			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+			result = sr_do_ioctl(target, &cgc);
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
@@ -371,15 +386,17 @@
 		{
 			struct cdrom_tocentry *tocentry = (struct cdrom_tocentry *) arg;
 
-			sr_cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-			sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-			            ((SCp->device->lun) << 5) : 0;
-			sr_cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
-			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-			sr_cmd[6] = tocentry->cdte_track;
-			sr_cmd[8] = 12;		/* LSB of length */
+			cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+			cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+				     ((SCp->device->lun) << 5) : 0;
+			cgc.cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;
+			cgc.cmd[6] = tocentry->cdte_track;
+			cgc.cmd[8] = 12;		/* LSB of length */
+			cgc.buffer = buffer;
+			cgc.buflen = 12;
+			cgc.data_direction = SCSI_DATA_READ;
 
-			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 0, SCSI_DATA_READ, NULL);
+			result = sr_do_ioctl(target, &cgc);
 
 			tocentry->cdte_ctrl = buffer[5] & 0xf;
 			tocentry->cdte_adr = buffer[5] >> 4;
@@ -398,15 +415,16 @@
 	case CDROMPLAYTRKIND: {
 		struct cdrom_ti* ti = (struct cdrom_ti*)arg;
 
-		sr_cmd[0] = GPCMD_PLAYAUDIO_TI;
-		sr_cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-		            (SCp->device->lun << 5) : 0;
-		sr_cmd[4] = ti->cdti_trk0;
-		sr_cmd[5] = ti->cdti_ind0;
-		sr_cmd[7] = ti->cdti_trk1;
-		sr_cmd[8] = ti->cdti_ind1;
+		cgc.cmd[0] = GPCMD_PLAYAUDIO_TI;
+		cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			     (SCp->device->lun << 5) : 0;
+		cgc.cmd[4] = ti->cdti_trk0;
+		cgc.cmd[5] = ti->cdti_ind0;
+		cgc.cmd[7] = ti->cdti_trk1;
+		cgc.cmd[8] = ti->cdti_ind1;
+		cgc.data_direction = SCSI_DATA_NONE;
 
-		result = sr_do_ioctl(target, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+		result = sr_do_ioctl(target, &cgc);
 		if (result == -EDRIVE_CANT_DO_THIS)
 			result = sr_fake_playtrkind(cdi, ti);
 
@@ -441,7 +459,7 @@
 
 int sr_read_cd(int minor, unsigned char *dest, int lba, int format, int blksize)
 {
-	unsigned char cmd[MAX_COMMAND_SIZE];
+	struct cdrom_generic_command cgc;
 	Scsi_CD *SCp = &scsi_CDs[minor];
 
 #ifdef DEBUG
@@ -449,31 +467,35 @@
 	       minor, lba, format, blksize);
 #endif
 
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = GPCMD_READ_CD;	/* READ_CD */
-	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	         (SCp->device->lun << 5) : 0;
-	cmd[1] |= ((format & 7) << 2);
-	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
-	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
-	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
-	cmd[5] = (unsigned char) lba & 0xff;
-	cmd[8] = 1;
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_CD;	/* READ_CD */
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     (SCp->device->lun << 5) : 0;
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
-	return sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
+	cgc.buffer = dest;
+	cgc.buflen = blksize;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	return sr_do_ioctl(minor, &cgc);
 }
 
 /*
@@ -482,7 +504,7 @@
 
 int sr_read_sector(int minor, int lba, int blksize, unsigned char *dest)
 {
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	Scsi_CD *SCp = &scsi_CDs[minor];
 	int rc;
 
@@ -504,16 +526,20 @@
 	printk("sr%d: sr_read_sector lba=%d blksize=%d\n", minor, lba, blksize);
 #endif
 
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = GPCMD_READ_10;
-	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	         (SCp->device->lun << 5) : 0;
-	cmd[2] = (unsigned char) (lba >> 24) & 0xff;
-	cmd[3] = (unsigned char) (lba >> 16) & 0xff;
-	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
-	cmd[5] = (unsigned char) lba & 0xff;
-	cmd[8] = 1;
-	rc = sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = GPCMD_READ_10;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     (SCp->device->lun << 5) : 0;
+	cgc.cmd[2] = (unsigned char) (lba >> 24) & 0xff;
+	cgc.cmd[3] = (unsigned char) (lba >> 16) & 0xff;
+	cgc.cmd[4] = (unsigned char) (lba >> 8) & 0xff;
+	cgc.cmd[5] = (unsigned char) lba & 0xff;
+	cgc.cmd[8] = 1;
+	cgc.buffer = dest;
+	cgc.buflen = blksize;
+	cgc.data_direction = SCSI_DATA_READ;
+	cgc.timeout = IOCTL_TIMEOUT;
+	rc = sr_do_ioctl(minor, &cgc);
 
 	return rc;
 }
diff -u -r orig/linux-2.5.33/drivers/scsi/sr_vendor.c linux-2.5.33/drivers/scsi/sr_vendor.c
--- orig/linux-2.5.33/drivers/scsi/sr_vendor.c	Sun Aug 11 03:41:28 2002
+++ linux-2.5.33/drivers/scsi/sr_vendor.c	Wed Sep  4 18:31:03 2002
@@ -58,6 +58,8 @@
 #define VENDOR_TOSHIBA         3
 #define VENDOR_WRITER          4	/* pre-scsi3 writers */
 
+#define VENDOR_TIMEOUT	30*HZ
+
 void sr_vendor_init(Scsi_CD *SCp)
 {
 #ifndef CONFIG_BLK_DEV_SR_VENDOR
@@ -104,7 +106,7 @@
 int sr_set_blocklength(int minor, int blocklength)
 {
 	unsigned char *buffer;	/* the buffer for the ioctl */
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	struct ccs_modesel_head *modesel;
 	Scsi_CD *SCp = &scsi_CDs[minor];
 	int rc, density = 0;
@@ -121,19 +123,23 @@
 #ifdef DEBUG
 	printk("sr%d: MODE SELECT 0x%x/%d\n", minor, density, blocklength);
 #endif
-	memset(cmd, 0, MAX_COMMAND_SIZE);
-	cmd[0] = MODE_SELECT;
-	cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-	         (SCp->device->lun << 5) : 0;
-	cmd[1] |= (1 << 4);
-	cmd[4] = 12;
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+	cgc.cmd[0] = MODE_SELECT;
+	cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+		     (SCp->device->lun << 5) : 0;
+	cgc.cmd[1] |= (1 << 4);
+	cgc.cmd[4] = 12;
 	modesel = (struct ccs_modesel_head *) buffer;
 	memset(modesel, 0, sizeof(*modesel));
 	modesel->block_desc_length = 0x08;
 	modesel->density = density;
 	modesel->block_length_med = (blocklength >> 8) & 0xff;
 	modesel->block_length_lo = blocklength & 0xff;
-	if (0 == (rc = sr_do_ioctl(minor, cmd, buffer, sizeof(*modesel), 0, SCSI_DATA_WRITE, NULL))) {
+	cgc.buffer = buffer;
+	cgc.buflen = sizeof(*modesel);
+	cgc.data_direction = SCSI_DATA_WRITE;
+	cgc.timeout = VENDOR_TIMEOUT;
+	if (0 == (rc = sr_do_ioctl(minor, &cgc))) {
 		SCp->device->sector_size = blocklength;
 	}
 #ifdef DEBUG
@@ -155,7 +161,7 @@
 	Scsi_CD *SCp = cdi->handle;
 	unsigned long sector;
 	unsigned char *buffer;	/* the buffer for the ioctl */
-	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
+	struct cdrom_generic_command cgc;
 	int rc, no_multi, minor;
 
 	minor = minor(cdi->dev);
@@ -170,16 +176,22 @@
 	no_multi = 0;		/* flag: the drive can't handle multisession */
 	rc = 0;
 
+	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+
 	switch (SCp->vendor) {
 
 	case VENDOR_SCSI3:
-		memset(cmd, 0, MAX_COMMAND_SIZE);
-		cmd[0] = READ_TOC;
-		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-		         (SCp->device->lun << 5) : 0;
-		cmd[8] = 12;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;
+		cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			     (SCp->device->lun << 5) : 0;
+		cgc.cmd[8] = 12;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 12;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(minor, &cgc);
 		if (rc != 0)
 			break;
 		if ((buffer[0] << 8) + buffer[1] < 0x0a) {
@@ -199,13 +211,17 @@
 #ifdef CONFIG_BLK_DEV_SR_VENDOR
 	case VENDOR_NEC:{
 			unsigned long min, sec, frame;
-			memset(cmd, 0, MAX_COMMAND_SIZE);
-			cmd[0] = 0xde;
-			cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-			         (SCp->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
-			cmd[2] = 0xb0;
-			rc = sr_do_ioctl(minor, cmd, buffer, 0x16, 1, SCSI_DATA_READ, NULL);
+			cgc.cmd[0] = 0xde;
+			cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+				     (SCp->device->lun << 5) : 0;
+			cgc.cmd[1] |= 0x03;
+			cgc.cmd[2] = 0xb0;
+			cgc.buffer = buffer;
+			cgc.buflen = 0x16;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
+			cgc.timeout = VENDOR_TIMEOUT;
+			rc = sr_do_ioctl(minor, &cgc);
 			if (rc != 0)
 				break;
 			if (buffer[14] != 0 && buffer[14] != 0xb0) {
@@ -226,12 +242,16 @@
 
 			/* we request some disc information (is it a XA-CD ?,
 			 * where starts the last session ?) */
-			memset(cmd, 0, MAX_COMMAND_SIZE);
-			cmd[0] = 0xc7;
-			cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-			         (SCp->device->lun << 5) : 0;
-			cmd[1] |= 0x03;
-			rc = sr_do_ioctl(minor, cmd, buffer, 4, 1, SCSI_DATA_READ, NULL);
+			cgc.cmd[0] = 0xc7;
+			cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+				     (SCp->device->lun << 5) : 0;
+			cgc.cmd[1] |= 0x03;
+			cgc.buffer = buffer;
+			cgc.buflen = 4;
+			cgc.quiet = 1;
+			cgc.data_direction = SCSI_DATA_READ;
+			cgc.timeout = VENDOR_TIMEOUT;
+			rc = sr_do_ioctl(minor, &cgc);
 			if (rc == -EINVAL) {
 				printk(KERN_INFO "sr%d: Hmm, seems the drive "
 				       "doesn't support multisession CD's\n", minor);
@@ -251,13 +271,17 @@
 		}
 
 	case VENDOR_WRITER:
-		memset(cmd, 0, MAX_COMMAND_SIZE);
-		cmd[0] = READ_TOC;
-		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-		         (SCp->device->lun << 5) : 0;
-		cmd[8] = 0x04;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 0x04, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;
+		cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			     (SCp->device->lun << 5) : 0;
+		cgc.cmd[8] = 0x04;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 0x04;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(minor, &cgc);
 		if (rc != 0) {
 			break;
 		}
@@ -266,13 +290,18 @@
 			       "sr%d: No finished session\n", minor);
 			break;
 		}
-		cmd[0] = READ_TOC;	/* Read TOC */
-		cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
-		         (SCp->device->lun << 5) : 0;
-		cmd[6] = rc & 0x7f;	/* number of last session */
-		cmd[8] = 0x0c;
-		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
+		cgc.cmd[0] = READ_TOC;	/* Read TOC */
+		cgc.cmd[1] = (SCp->device->scsi_level <= SCSI_2) ?
+			     (SCp->device->lun << 5) : 0;
+		cgc.cmd[6] = rc & 0x7f;	/* number of last session */
+		cgc.cmd[8] = 0x0c;
+		cgc.cmd[9] = 0x40;
+		cgc.buffer = buffer;
+		cgc.buflen = 12;
+		cgc.quiet = 1;
+		cgc.data_direction = SCSI_DATA_READ;
+		cgc.timeout = VENDOR_TIMEOUT;
+		rc = sr_do_ioctl(minor, &cgc);
 		if (rc != 0) {
 			break;
 		}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
