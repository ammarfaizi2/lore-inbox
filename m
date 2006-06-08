Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWFHDTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWFHDTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 23:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWFHDTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 23:19:37 -0400
Received: from xenotime.net ([66.160.160.81]:13530 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750847AbWFHDTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 23:19:37 -0400
Date: Wed, 7 Jun 2006 20:22:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, mingo@elte.hu, laurent.riffard@free.fr, barryn@pobox.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, arjan@linux.intel.com
Subject: [PATCH] ide-cd: use blk_get_request()
Message-Id: <20060607202223.3478c8ad.rdunlap@xenotime.net>
In-Reply-To: <20060607062208.GZ6693@suse.de>
References: <44840838.7030802@free.fr>
	<4484584D.4070108@free.fr>
	<20060605110046.2a7db23f.akpm@osdl.org>
	<986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
	<20060606072628.GA28752@elte.hu>
	<4485E0D3.8080708@free.fr>
	<20060606205801.GC17787@elte.hu>
	<4485F5E2.5040708@free.fr>
	<20060606220507.GA19882@elte.hu>
	<20060606152930.adc58fe4.akpm@osdl.org>
	<20060607062208.GZ6693@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 08:22:08 +0200 Jens Axboe wrote:

> On Tue, Jun 06 2006, Andrew Morton wrote:
> > 
> > Note that Laurent is also passing through ide_cdrom_packet(), which has a
> > `struct request' on the stack.  The kernel does this in a lot of places,
> > and at 168 bytes on x86, it'd really be best if we were to dynamically
> > allocate these things.
> 
> That's an old peeve of mine, on-stack requests... It's nasty from
> several angles, stack usage just being one of them. Perhaps I'll give it
> a go for 2.6.18 and add checks for request being thrown at the block
> layer which didn't originate from get_request().

This is a start at converting ide-cd.c to use blk_get_request().
How does it look so far?
It builds, but I have not tested it yet.
And of course, there are other drivers to be modified as well.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Convert struct request req; on function stacks to
use allocation via blk_get_request() to
(a) reduce stack pressure and
(b) use centralized blk_ functions and
(c) allow for block IO tracing.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/ide/ide-cd.c |  258 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 170 insertions(+), 88 deletions(-)

--- linux-2617-rc6.orig/drivers/ide/ide-cd.c
+++ linux-2617-rc6/drivers/ide/ide-cd.c
@@ -2033,24 +2033,32 @@ int msf_to_lba (byte m, byte s, byte f)
 
 static int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
-	struct request req;
+	struct request *req;
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
 
-	cdrom_prepare_request(drive, &req);
-
-	req.sense = sense;
-	req.cmd[0] = GPCMD_TEST_UNIT_READY;
-	req.flags |= REQ_QUIET;
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	cdrom_prepare_request(drive, req);
+
+	req->sense = sense;
+	req->cmd[0] = GPCMD_TEST_UNIT_READY;
+	req->flags |= REQ_QUIET;
 
 #if ! STANDARD_ATAPI
         /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to 
            switch CDs instead of supporting the LOAD_UNLOAD opcode   */
 
-	req.cmd[7] = cdi->sanyo_slot % 3;
+	req->cmd[7] = cdi->sanyo_slot % 3;
 #endif /* not STANDARD_ATAPI */
 
-	return cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
+	return stat;
 }
 
 
@@ -2059,7 +2067,7 @@ static int
 cdrom_lockdoor(ide_drive_t *drive, int lockflag, struct request_sense *sense)
 {
 	struct request_sense my_sense;
-	struct request req;
+	struct request *req;
 	int stat;
 
 	if (sense == NULL)
@@ -2069,11 +2077,19 @@ cdrom_lockdoor(ide_drive_t *drive, int l
 	if (CDROM_CONFIG_FLAGS(drive)->no_doorlock) {
 		stat = 0;
 	} else {
-		cdrom_prepare_request(drive, &req);
-		req.sense = sense;
-		req.cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-		req.cmd[4] = lockflag ? 1 : 0;
-		stat = cdrom_queue_packet_command(drive, &req);
+		struct cdrom_info *info = drive->driver_data;
+		struct cdrom_device_info *cdi = &info->devinfo;
+		request_queue_t *q = cdi->disk->queue;
+
+		req = blk_get_request(q, WRITE, GFP_KERNEL);
+		if (!req)
+			return -ENOMEM;
+		cdrom_prepare_request(drive, req);
+		req->sense = sense;
+		req->cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+		req->cmd[4] = lockflag ? 1 : 0;
+		stat = cdrom_queue_packet_command(drive, req);
+		blk_put_request(req);
 	}
 
 	/* If we got an illegal field error, the drive
@@ -2086,7 +2102,7 @@ cdrom_lockdoor(ide_drive_t *drive, int l
 		CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
 		stat = 0;
 	}
-	
+
 	/* no medium, that's alright. */
 	if (stat != 0 && sense->sense_key == NOT_READY && sense->asc == 0x3a)
 		stat = 0;
@@ -2103,26 +2119,36 @@ cdrom_lockdoor(ide_drive_t *drive, int l
 static int cdrom_eject(ide_drive_t *drive, int ejectflag,
 		       struct request_sense *sense)
 {
-	struct request req;
+	struct request *req;
 	char loej = 0x02;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
 
 	if (CDROM_CONFIG_FLAGS(drive)->no_eject && !ejectflag)
 		return -EDRIVE_CANT_DO_THIS;
-	
+
 	/* reload fails on some drives, if the tray is locked */
 	if (CDROM_STATE_FLAGS(drive)->door_locked && ejectflag)
 		return 0;
 
-	cdrom_prepare_request(drive, &req);
+	req = blk_get_request(q, WRITE, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
 
 	/* only tell drive to close tray if open, if it can do that */
 	if (ejectflag && !CDROM_CONFIG_FLAGS(drive)->close_tray)
 		loej = 0;
 
-	req.sense = sense;
-	req.cmd[0] = GPCMD_START_STOP_UNIT;
-	req.cmd[4] = loej | (ejectflag != 0);
-	return cdrom_queue_packet_command(drive, &req);
+	req->sense = sense;
+	req->cmd[0] = GPCMD_START_STOP_UNIT;
+	req->cmd[4] = loej | (ejectflag != 0);
+	stat = cdrom_queue_packet_command(drive, req);
+
+	blk_put_request(req);
+	return stat;
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -2135,17 +2161,24 @@ static int cdrom_read_capacity(ide_drive
 	} capbuf;
 
 	int stat;
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
+	struct request *req;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
 
-	req.sense = sense;
-	req.cmd[0] = GPCMD_READ_CDVD_CAPACITY;
-	req.data = (char *)&capbuf;
-	req.data_len = sizeof(capbuf);
-	req.flags |= REQ_QUIET;
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+
+	req->sense = sense;
+	req->cmd[0] = GPCMD_READ_CDVD_CAPACITY;
+	req->data = (char *)&capbuf;
+	req->data_len = sizeof(capbuf);
+	req->flags |= REQ_QUIET;
 
-	stat = cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
 	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =
@@ -2159,24 +2192,33 @@ static int cdrom_read_tocentry(ide_drive
 				int format, char *buf, int buflen,
 				struct request_sense *sense)
 {
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
+	struct request *req;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
 
-	req.sense = sense;
-	req.data =  buf;
-	req.data_len = buflen;
-	req.flags |= REQ_QUIET;
-	req.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
-	req.cmd[6] = trackno;
-	req.cmd[7] = (buflen >> 8);
-	req.cmd[8] = (buflen & 0xff);
-	req.cmd[9] = (format << 6);
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+
+	req->sense = sense;
+	req->data =  buf;
+	req->data_len = buflen;
+	req->flags |= REQ_QUIET;
+	req->cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
+	req->cmd[6] = trackno;
+	req->cmd[7] = (buflen >> 8);
+	req->cmd[8] = (buflen & 0xff);
+	req->cmd[9] = (format << 6);
 
 	if (msf_flag)
-		req.cmd[1] = 2;
+		req->cmd[1] = 2;
 
-	return cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
+	return stat;
 }
 
 
@@ -2352,20 +2394,30 @@ static int cdrom_read_toc(ide_drive_t *d
 static int cdrom_read_subchannel(ide_drive_t *drive, int format, char *buf,
 				 int buflen, struct request_sense *sense)
 {
-	struct request req;
+	struct request *req;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
 
-	cdrom_prepare_request(drive, &req);
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+
+	req->sense = sense;
+	req->data = buf;
+	req->data_len = buflen;
+	req->cmd[0] = GPCMD_READ_SUBCHANNEL;
+	req->cmd[1] = 2;     /* MSF addressing */
+	req->cmd[2] = 0x40;  /* request subQ data */
+	req->cmd[3] = format;
+	req->cmd[7] = (buflen >> 8);
+	req->cmd[8] = (buflen & 0xff);
 
-	req.sense = sense;
-	req.data = buf;
-	req.data_len = buflen;
-	req.cmd[0] = GPCMD_READ_SUBCHANNEL;
-	req.cmd[1] = 2;     /* MSF addressing */
-	req.cmd[2] = 0x40;  /* request subQ data */
-	req.cmd[3] = format;
-	req.cmd[7] = (buflen >> 8);
-	req.cmd[8] = (buflen & 0xff);
-	return cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
+	return stat;
 }
 
 /* ATAPI cdrom drives are free to select the speed you request or any slower
@@ -2373,45 +2425,64 @@ static int cdrom_read_subchannel(ide_dri
 static int cdrom_select_speed(ide_drive_t *drive, int speed,
 			      struct request_sense *sense)
 {
-	struct request req;
-	cdrom_prepare_request(drive, &req);
+	struct request *req;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
+
+	req = blk_get_request(q, WRITE, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
 
-	req.sense = sense;
+	req->sense = sense;
 	if (speed == 0)
 		speed = 0xffff; /* set to max */
 	else
 		speed *= 177;   /* Nx to kbytes/s */
 
-	req.cmd[0] = GPCMD_SET_SPEED;
+	req->cmd[0] = GPCMD_SET_SPEED;
 	/* Read Drive speed in kbytes/second MSB */
-	req.cmd[2] = (speed >> 8) & 0xff;	
+	req->cmd[2] = (speed >> 8) & 0xff;
 	/* Read Drive speed in kbytes/second LSB */
-	req.cmd[3] = speed & 0xff;
+	req->cmd[3] = speed & 0xff;
 	if (CDROM_CONFIG_FLAGS(drive)->cd_r ||
 	    CDROM_CONFIG_FLAGS(drive)->cd_rw ||
 	    CDROM_CONFIG_FLAGS(drive)->dvd_r) {
 		/* Write Drive speed in kbytes/second MSB */
-		req.cmd[4] = (speed >> 8) & 0xff;
+		req->cmd[4] = (speed >> 8) & 0xff;
 		/* Write Drive speed in kbytes/second LSB */
-		req.cmd[5] = speed & 0xff;
+		req->cmd[5] = speed & 0xff;
        }
 
-	return cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
+	return stat;
 }
 
 static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba_end)
 {
 	struct request_sense sense;
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
+	struct request *req;
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	request_queue_t *q = cdi->disk->queue;
+	int stat;
 
-	req.sense = &sense;
-	req.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
-	lba_to_msf(lba_start, &req.cmd[3], &req.cmd[4], &req.cmd[5]);
-	lba_to_msf(lba_end-1, &req.cmd[6], &req.cmd[7], &req.cmd[8]);
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+
+	req->sense = &sense;
+	req->cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start, &req->cmd[3], &req->cmd[4], &req->cmd[5]);
+	lba_to_msf(lba_end-1, &req->cmd[6], &req->cmd[7], &req->cmd[8]);
 
-	return cdrom_queue_packet_command(drive, &req);
+	stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
+	return stat;
 }
 
 static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
@@ -2445,8 +2516,9 @@ static int cdrom_get_toc_entry(ide_drive
 static int ide_cdrom_packet(struct cdrom_device_info *cdi,
 			    struct packet_command *cgc)
 {
-	struct request req;
+	struct request *req;
 	ide_drive_t *drive = cdi->handle;
+	request_queue_t *q = cdi->disk->queue;
 
 	if (cgc->timeout <= 0)
 		cgc->timeout = ATAPI_WAIT_PC;
@@ -2454,21 +2526,26 @@ static int ide_cdrom_packet(struct cdrom
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
-	cdrom_prepare_request(drive, &req);
-	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+	memcpy(req->cmd, cgc->cmd, CDROM_PACKET_SIZE);
 	if (cgc->sense)
 		memset(cgc->sense, 0, sizeof(struct request_sense));
-	req.data = cgc->buffer;
-	req.data_len = cgc->buflen;
-	req.timeout = cgc->timeout;
+	req->data = cgc->buffer;
+	req->data_len = cgc->buflen;
+	req->timeout = cgc->timeout;
 
 	if (cgc->quiet)
-		req.flags |= REQ_QUIET;
+		req->flags |= REQ_QUIET;
+
+	req->sense = cgc->sense;
+	cgc->stat = cdrom_queue_packet_command(drive, req);
+	blk_put_request(req);
 
-	req.sense = cgc->sense;
-	cgc->stat = cdrom_queue_packet_command(drive, &req);
 	if (!cgc->stat)
-		cgc->buflen -= req.data_len;
+		cgc->buflen -= req->data_len;
 	return cgc->stat;
 }
 
@@ -2557,12 +2634,17 @@ int ide_cdrom_reset (struct cdrom_device
 {
 	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
-	struct request req;
+	struct request *req;
 	int ret;
+	request_queue_t *q = cdi->disk->queue;
 
-	cdrom_prepare_request(drive, &req);
-	req.flags = REQ_SPECIAL | REQ_QUIET;
-	ret = ide_do_drive_cmd(drive, &req, ide_wait);
+	req = blk_get_request(q, WRITE, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	cdrom_prepare_request(drive, req);
+	req->flags = REQ_SPECIAL | REQ_QUIET;
+	ret = ide_do_drive_cmd(drive, req, ide_wait);
+	blk_put_request(req);
 
 	/*
 	 * A reset will unlock the door. If it was previously locked,

