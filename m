Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVARBf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVARBf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVARBet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:34:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:54455 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262907AbVARBTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:19:30 -0500
Date: Tue, 18 Jan 2005 02:22:17 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 05/11] Get rid of verify_area() - drivers part 2, approximately
 second half of drivers/.
Message-ID: <Pine.LNX.4.61.0501180149330.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
Drivers part 2, approximately second half of drivers/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/drivers/scsi/sg.c	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/scsi/sg.c	2005-01-17 22:51:56.000000000 +0100
@@ -330,7 +330,7 @@ sg_release(struct inode *inode, struct f
 static ssize_t
 sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 {
-	int k, res;
+	int res;
 	Sg_device *sdp;
 	Sg_fd *sfp;
 	Sg_request *srp;
@@ -343,8 +343,8 @@ sg_read(struct file *filp, char __user *
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, printk("sg_read: %s, count=%d\n",
 				   sdp->disk->disk_name, (int) count));
-	if ((k = verify_area(VERIFY_WRITE, buf, count)))
-		return k;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
 	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
 		if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
 			return -EFAULT;
@@ -501,8 +501,8 @@ sg_write(struct file *filp, const char _
 	      scsi_block_when_processing_errors(sdp->device)))
 		return -ENXIO;
 
-	if ((k = verify_area(VERIFY_READ, buf, count)))
-		return k;	/* protects following copy_from_user()s + get_user()s */
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
 	if (count < SZ_SG_HEADER)
 		return -EIO;
 	if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
@@ -594,8 +594,8 @@ sg_new_write(Sg_fd * sfp, const char __u
 
 	if (count < SZ_SG_IO_HDR)
 		return -EINVAL;
-	if ((k = verify_area(VERIFY_READ, buf, count)))
-		return k; /* protects following copy_from_user()s + get_user()s */
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT; /* protects following copy_from_user()s + get_user()s */
 
 	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
 	if (!(srp = sg_add_request(sfp))) {
@@ -631,9 +631,9 @@ sg_new_write(Sg_fd * sfp, const char __u
 		sg_remove_request(sfp, srp);
 		return -EMSGSIZE;
 	}
-	if ((k = verify_area(VERIFY_READ, hp->cmdp, hp->cmd_len))) {
+	if (!access_ok(VERIFY_READ, hp->cmdp, hp->cmd_len)) {
 		sg_remove_request(sfp, srp);
-		return k;	/* protects following copy_from_user()s + get_user()s */
+		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
 	}
 	if (__copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
 		sg_remove_request(sfp, srp);
@@ -773,9 +773,8 @@ sg_ioctl(struct inode *inode, struct fil
 				return -ENODEV;
 			if (!scsi_block_when_processing_errors(sdp->device))
 				return -ENXIO;
-			result = verify_area(VERIFY_WRITE, p, SZ_SG_IO_HDR);
-			if (result)
-				return result;
+			if (!access_ok(VERIFY_WRITE, p, SZ_SG_IO_HDR))
+				return -EFAULT;
 			result =
 			    sg_new_write(sfp, p, SZ_SG_IO_HDR,
 					 blocking, read_only, &srp);
@@ -837,10 +836,8 @@ sg_ioctl(struct inode *inode, struct fil
 	case SG_GET_LOW_DMA:
 		return put_user((int) sfp->low_dma, ip);
 	case SG_GET_SCSI_ID:
-		result =
-		    verify_area(VERIFY_WRITE, p, sizeof (sg_scsi_id_t));
-		if (result)
-			return result;
+		if (!access_ok(VERIFY_WRITE, p, sizeof (sg_scsi_id_t)))
+			return -EFAULT;
 		else {
 			sg_scsi_id_t __user *sg_idp = p;
 
@@ -868,9 +865,8 @@ sg_ioctl(struct inode *inode, struct fil
 		sfp->force_packid = val ? 1 : 0;
 		return 0;
 	case SG_GET_PACK_ID:
-		result = verify_area(VERIFY_WRITE, ip, sizeof (int));
-		if (result)
-			return result;
+		if (!access_ok(VERIFY_WRITE, ip, sizeof (int)))
+			return -EFAULT;
 		read_lock_irqsave(&sfp->rq_list_lock, iflags);
 		for (srp = sfp->headrp; srp; srp = srp->nextrp) {
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
@@ -938,10 +934,8 @@ sg_ioctl(struct inode *inode, struct fil
 		val = (sdp->device ? 1 : 0);
 		return put_user(val, ip);
 	case SG_GET_REQUEST_TABLE:
-		result = verify_area(VERIFY_WRITE, p,
-				     SZ_SG_REQ_INFO * SG_MAX_QUEUE);
-		if (result)
-			return result;
+		if (!access_ok(VERIFY_WRITE, p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
+			return -EFAULT;
 		else {
 			sg_req_info_t rinfo[SG_MAX_QUEUE];
 			Sg_request *srp;
@@ -1956,9 +1950,8 @@ sg_write_xfer(Sg_request * srp)
 			  num_xfer, iovec_count, schp->k_use_sg));
 	if (iovec_count) {
 		onum = iovec_count;
-		if ((k = verify_area(VERIFY_READ, hp->dxferp,
-				     SZ_SG_IOVEC * onum)))
-			return k;
+		if (!access_ok(VERIFY_READ, hp->dxferp, SZ_SG_IOVEC * onum))
+			return -EFAULT;
 	} else
 		onum = 1;
 
@@ -2028,7 +2021,7 @@ sg_u_iovec(sg_io_hdr_t * hp, int sg_num,
 {
 	int num_xfer = (int) hp->dxfer_len;
 	unsigned char __user *p = hp->dxferp;
-	int count, k;
+	int count;
 
 	if (0 == sg_num) {
 		if (wr_xf && ('\0' == hp->interface_id))
@@ -2042,8 +2035,8 @@ sg_u_iovec(sg_io_hdr_t * hp, int sg_num,
 		p = iovec.iov_base;
 		count = (int) iovec.iov_len;
 	}
-	if ((k = verify_area(wr_xf ? VERIFY_READ : VERIFY_WRITE, p, count)))
-		return k;
+	if (!access_ok(wr_xf ? VERIFY_READ : VERIFY_WRITE, p, count))
+		return -EFAULT;
 	if (up)
 		*up = p;
 	if (countp)
@@ -2110,9 +2103,8 @@ sg_read_xfer(Sg_request * srp)
 			  num_xfer, iovec_count, schp->k_use_sg));
 	if (iovec_count) {
 		onum = iovec_count;
-		if ((k = verify_area(VERIFY_READ, hp->dxferp,
-				     SZ_SG_IOVEC * onum)))
-			return k;
+		if (!access_ok(VERIFY_READ, hp->dxferp, SZ_SG_IOVEC * onum))
+			return -EFAULT;
 	} else
 		onum = 1;
 
--- linux-2.6.11-rc1-bk4-orig/drivers/scsi/cpqfcTSinit.c	2004-12-24 22:33:51.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/scsi/cpqfcTSinit.c	2005-01-17 22:52:58.000000000 +0100
@@ -752,7 +752,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
 		result = -ENXIO;
 		break;
 	}
-	result = verify_area(VERIFY_WRITE, arg, sizeof(Scsi_FCTargAddress));
+	result = access_ok(VERIFY_WRITE, arg, sizeof(Scsi_FCTargAddress)) ? 0 : -EFAULT;
 	if (result) break;
  
       put_user(pLoggedInPort->port_id,
--- linux-2.6.11-rc1-bk4-orig/drivers/scsi/scsi_ioctl.c	2005-01-12 23:26:15.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/scsi/scsi_ioctl.c	2005-01-17 22:53:57.000000000 +0100
@@ -230,7 +230,7 @@ int scsi_ioctl_send_command(struct scsi_
 	/*
 	 * Verify that we can read at least this much.
 	 */
-	if (verify_area(VERIFY_READ, sic, sizeof(Scsi_Ioctl_Command)))
+	if (!access_ok(VERIFY_READ, sic, sizeof(Scsi_Ioctl_Command)))
 		return -EFAULT;
 
 	if(__get_user(inlen, &sic->inlen))
@@ -285,7 +285,7 @@ int scsi_ioctl_send_command(struct scsi_
 	
 	result = -EFAULT;
 
-	if (verify_area(VERIFY_READ, cmd_in, cmdlen + inlen))
+	if (!access_ok(VERIFY_READ, cmd_in, cmdlen + inlen))
 		goto error;
 
 	if(__copy_from_user(cmd, cmd_in, cmdlen))
@@ -417,7 +417,7 @@ int scsi_ioctl(struct scsi_device *sdev,
 
 	switch (cmd) {
 	case SCSI_IOCTL_GET_IDLUN:
-		if (verify_area(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
+		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
 			return -EFAULT;
 
 		__put_user((sdev->id & 0xff)
--- linux-2.6.11-rc1-bk4-orig/drivers/block/nbd.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/block/nbd.c	2005-01-17 23:00:11.000000000 +0100
@@ -38,7 +38,7 @@
  * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
  * 04-02-19 Remove PARANOIA, plus various cleanups (Paul Clements)
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
- * why not: would need verify_area and friends, would share yet another 
+ * why not: would need access_ok and friends, would share yet another 
  *          structure with userland
  */
 
--- linux-2.6.11-rc1-bk4-orig/drivers/block/viodasd.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/block/viodasd.c	2005-01-17 23:01:24.000000000 +0100
@@ -250,7 +250,6 @@ static int viodasd_release(struct inode 
 static int viodasd_ioctl(struct inode *ino, struct file *fil,
 			 unsigned int cmd, unsigned long arg)
 {
-	int err;
 	unsigned char sectors;
 	unsigned char heads;
 	unsigned short cylinders;
@@ -263,9 +262,8 @@ static int viodasd_ioctl(struct inode *i
 		geo = (struct hd_geometry *)arg;
 		if (geo == NULL)
 			return -EINVAL;
-		err = verify_area(VERIFY_WRITE, geo, sizeof(*geo));
-		if (err)
-			return err;
+		if (!access_ok(VERIFY_WRITE, geo, sizeof(*geo)))
+			return -EFAULT;
 		gendisk = ino->i_bdev->bd_disk;
 		d = gendisk->private_data;
 		sectors = d->sectors;
--- linux-2.6.11-rc1-bk4-orig/drivers/cdrom/sbpcd.c	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/cdrom/sbpcd.c	2005-01-17 23:03:08.000000000 +0100
@@ -4266,9 +4266,9 @@ static int sbpcd_dev_ioctl(struct cdrom_
 				   sizeof(struct cdrom_read_audio)))
 			RETURN_UP(-EFAULT);
 		if (read_audio.nframes < 0 || read_audio.nframes>current_drive->sbp_audsiz) RETURN_UP(-EINVAL);
-		i=verify_area(VERIFY_WRITE, read_audio.buf,
-			      read_audio.nframes*CD_FRAMESIZE_RAW);
-		if (i) RETURN_UP(i);
+		if (!access_ok(VERIFY_WRITE, read_audio.buf,
+			      read_audio.nframes*CD_FRAMESIZE_RAW))
+                	RETURN_UP(-EFAULT);
 		
 		if (read_audio.addr_format==CDROM_MSF) /* MSF-bin specification of where to start */
 			block=msf2lba(&read_audio.addr.msf.minute);
--- linux-2.6.11-rc1-bk4-orig/drivers/cdrom/sjcd.c	2005-01-12 23:26:05.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/cdrom/sjcd.c	2005-01-17 23:12:01.000000000 +0100
@@ -831,8 +831,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: playmsf\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_READ, argp,
-					 sizeof(sjcd_msf))) == 0) {
+			     access_ok(VERIFY_READ, argp, sizeof(sjcd_msf)) 
+			     		? 0 : -EFAULT) == 0) {
 				if (sjcd_audio_status == CDROM_AUDIO_PLAY) {
 					sjcd_send_cmd(SCMD_PAUSE);
 					(void) sjcd_receive_status();
@@ -888,8 +888,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: readtocentry\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_WRITE, argp,
-					 sizeof(toc_entry))) == 0) {
+			     access_ok(VERIFY_WRITE, argp, sizeof(toc_entry))
+			     		? 0 : -EFAULT) == 0) {
 				struct sjcd_hw_disk_info *tp;
 
 				if (copy_from_user(&toc_entry, argp,
@@ -943,8 +943,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: subchnl\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_WRITE, argp,
-					 sizeof(subchnl))) == 0) {
+			     access_ok(VERIFY_WRITE, argp, sizeof(subchnl))
+			     		? 0 : -EFAULT) == 0) {
 				struct sjcd_hw_qinfo q_info;
 
 				if (copy_from_user(&subchnl, argp,
@@ -1002,8 +1002,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: volctrl\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_READ, argp,
-					 sizeof(vol_ctrl))) == 0) {
+			     access_ok(VERIFY_READ, argp, sizeof(vol_ctrl))
+			     		? 0 : -EFAULT) == 0) {
 				unsigned char dummy[4];
 
 				if (copy_from_user(&vol_ctrl, argp,
--- linux-2.6.11-rc1-bk4-orig/drivers/cdrom/cdu31a.c	2004-12-24 22:35:21.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/cdrom/cdu31a.c	2005-01-17 23:13:22.000000000 +0100
@@ -2769,7 +2769,6 @@ static int scd_dev_ioctl(struct cdrom_de
 			 unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	int i;
 
 	switch (cmd) {
 	case CDROMREADAUDIO:	/* Read 2352 byte audio tracks and 2340 byte
@@ -2790,10 +2789,9 @@ static int scd_dev_ioctl(struct cdrom_de
 				return 0;
 			}
 
-			i = verify_area(VERIFY_WRITE, ra.buf,
-					CD_FRAMESIZE_RAW * ra.nframes);
-			if (i < 0)
-				return i;
+			if (!access_ok(VERIFY_WRITE, ra.buf,
+					CD_FRAMESIZE_RAW * ra.nframes))
+				return -EFAULT;
 
 			if (ra.addr_format == CDROM_LBA) {
 				if ((ra.addr.lba >=
--- linux-2.6.11-rc1-bk4-orig/drivers/media/video/c-qcam.c	2005-01-12 23:26:12.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/media/video/c-qcam.c	2005-01-17 23:13:40.000000000 +0100
@@ -363,7 +363,7 @@ static long qc_capture(struct qcam_devic
 	size_t wantlen, outptr = 0;
 	char tmpbuf[BUFSZ];
 
-	if (verify_area(VERIFY_WRITE, buf, len))
+	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
 	/* Wait for camera to become ready */
--- linux-2.6.11-rc1-bk4-orig/drivers/video/amifb.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/video/amifb.c	2005-01-17 23:16:00.000000000 +0100
@@ -3338,7 +3338,7 @@ static int ami_get_var_cursorinfo(struct
 	register short delta;
 	register u_char color;
 	short height, width, bits, words;
-	int i, size, alloc;
+	int size, alloc;
 
 	size = par->crsr.height*par->crsr.width;
 	alloc = var->height*var->width;
@@ -3348,8 +3348,8 @@ static int ami_get_var_cursorinfo(struct
 	var->yspot = par->crsr.spot_y;
 	if (size > var->height*var->width)
 		return -ENAMETOOLONG;
-	if ((i = verify_area(VERIFY_WRITE, (void *)data, size)))
-		return i;
+	if (!access_ok(VERIFY_WRITE, (void *)data, size))
+		return -EFAULT;
 	delta = 1<<par->crsr.fmode;
 	lspr = lofsprite + (delta<<1);
 	if (par->bplcon0 & BPC0_LACE)
@@ -3413,7 +3413,6 @@ static int ami_set_var_cursorinfo(struct
 	register short delta;
 	u_short fmode;
 	short height, width, bits, words;
-	int i;
 
 	if (!var->width)
 		return -EINVAL;
@@ -3429,8 +3428,8 @@ static int ami_set_var_cursorinfo(struct
 		return -EINVAL;
 	if (!var->height)
 		return -EINVAL;
-	if ((i = verify_area(VERIFY_READ, (void *)data, var->width*var->height)))
-		return i;
+	if (!access_ok(VERIFY_READ, (void *)data, var->width*var->height))
+		return -EFAULT;
 	delta = 1<<fmode;
 	lofsprite = shfsprite = (u_short *)spritememory;
 	lspr = lofsprite + (delta<<1);
--- linux-2.6.11-rc1-bk4-orig/drivers/ieee1394/raw1394.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/ieee1394/raw1394.c	2005-01-17 23:16:32.000000000 +0100
@@ -2338,7 +2338,7 @@ static int raw1394_iso_recv_packets(stru
 		return -EINVAL;
 
 	/* ensure user-supplied buffer is accessible and big enough */
-	if (verify_area(VERIFY_WRITE, upackets.infos,
+	if (!access_ok(VERIFY_WRITE, upackets.infos,
 		       upackets.n_packets * sizeof(struct raw1394_iso_packet_info)))
 		return -EFAULT;
 
@@ -2368,7 +2368,7 @@ static int raw1394_iso_send_packets(stru
 		return -EINVAL;
 
 	/* ensure user-supplied buffer is accessible and big enough */
-	if (verify_area(VERIFY_READ, upackets.infos,
+	if (!access_ok(VERIFY_READ, upackets.infos,
 		       upackets.n_packets * sizeof(struct raw1394_iso_packet_info)))
 		return -EFAULT;
 
--- linux-2.6.11-rc1-bk4-orig/drivers/serial/68328serial.c	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/serial/68328serial.c	2005-01-17 23:22:33.000000000 +0100
@@ -1055,28 +1055,23 @@ static int rs_ioctl(struct tty_struct *t
 				 (arg ? CLOCAL : 0));
 			return 0;
 		case TIOCGSERIAL:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct serial_struct));
-			if (error)
-				return error;
-			return get_serial_info(info,
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(struct serial_struct)))
+				return get_serial_info(info,
 					       (struct serial_struct *) arg);
+			return -EFAULT;
 		case TIOCSSERIAL:
 			return set_serial_info(info,
 					       (struct serial_struct *) arg);
 		case TIOCSERGETLSR: /* Get line status register */
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-				sizeof(unsigned int));
-			if (error)
-				return error;
-			else
-			    return get_lsr_info(info, (unsigned int *) arg);
-
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(unsigned int));
+				return get_lsr_info(info, (unsigned int *) arg);
+			return -EFAULT;
 		case TIOCSERGSTRUCT:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct m68k_serial));
-			if (error)
-				return error;
+			if (!access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(struct m68k_serial)))
+				return -EFAULT;
 			copy_to_user((struct m68k_serial *) arg,
 				    info, sizeof(struct m68k_serial));
 			return 0;
--- linux-2.6.11-rc1-bk4-orig/drivers/serial/mcfserial.c	2005-01-12 23:26:15.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/serial/mcfserial.c	2005-01-17 23:24:15.000000000 +0100
@@ -1092,23 +1092,19 @@ static int mcfrs_ioctl(struct tty_struct
 				 (arg ? CLOCAL : 0));
 			return 0;
 		case TIOCGSERIAL:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct serial_struct));
-			if (error)
-				return error;
-			return get_serial_info(info,
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(struct serial_struct)))
+				return get_serial_info(info,
 					       (struct serial_struct *) arg);
+			return -EFAULT;
 		case TIOCSSERIAL:
 			return set_serial_info(info,
 					       (struct serial_struct *) arg);
 		case TIOCSERGETLSR: /* Get line status register */
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-				sizeof(unsigned int));
-			if (error)
-				return error;
-			else
-			    return get_lsr_info(info, (unsigned int *) arg);
-
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(unsigned int)))
+				return get_lsr_info(info, (unsigned int *) arg);
+			return -EFAULT;
 		case TIOCSERGSTRUCT:
 			error = copy_to_user((struct mcf_serial *) arg,
 				    info, sizeof(struct mcf_serial));
--- linux-2.6.11-rc1-bk4-orig/drivers/bluetooth/hci_vhci.c	2004-12-24 22:35:29.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/bluetooth/hci_vhci.c	2005-01-17 23:25:12.000000000 +0100
@@ -157,7 +157,7 @@ static ssize_t hci_vhci_chr_write(struct
 {
 	struct hci_vhci_struct *hci_vhci = (struct hci_vhci_struct *) file->private_data;
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
 	return hci_vhci_get_user(hci_vhci, buf, count);
@@ -222,7 +222,7 @@ static ssize_t hci_vhci_chr_read(struct 
 			continue;
 		}
 
-		if (!verify_area(VERIFY_WRITE, buf, count))
+		if (access_ok(VERIFY_WRITE, buf, count))
 			ret = hci_vhci_put_user(hci_vhci, skb, buf, count);
 		else
 			ret = -EFAULT;
--- linux-2.6.11-rc1-bk4-orig/drivers/macintosh/adb.c	2004-12-24 22:35:49.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/macintosh/adb.c	2005-01-17 23:27:00.000000000 +0100
@@ -755,7 +755,7 @@ static int adb_release(struct inode *ino
 static ssize_t adb_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	int ret;
+	int ret = 0;
 	struct adbdev_state *state = file->private_data;
 	struct adb_request *req;
 	wait_queue_t wait = __WAITQUEUE_INITIALIZER(wait,current);
@@ -765,9 +765,8 @@ static ssize_t adb_read(struct file *fil
 		return -EINVAL;
 	if (count > sizeof(req->reply))
 		count = sizeof(req->reply);
-	ret = verify_area(VERIFY_WRITE, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
 
 	req = NULL;
 	spin_lock_irqsave(&state->lock, flags);
@@ -824,9 +823,8 @@ static ssize_t adb_write(struct file *fi
 		return -EINVAL;
 	if (adb_controller == NULL)
 		return -ENXIO;
-	ret = verify_area(VERIFY_READ, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
 
 	req = (struct adb_request *) kmalloc(sizeof(struct adb_request),
 					     GFP_KERNEL);
--- linux-2.6.11-rc1-bk4-orig/drivers/macintosh/ans-lcd.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/macintosh/ans-lcd.c	2005-01-17 23:27:30.000000000 +0100
@@ -61,7 +61,7 @@ anslcd_write( struct file * file, const 
 	printk(KERN_DEBUG "LCD: write\n");
 #endif
 
-	if ( verify_area(VERIFY_READ, buf, count) )
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	for ( i = *ppos; count > 0; ++i, ++p, --count ) 
 	{
--- linux-2.6.11-rc1-bk4-orig/drivers/macintosh/nvram.c	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/macintosh/nvram.c	2005-01-17 23:27:51.000000000 +0100
@@ -45,7 +45,7 @@ static ssize_t read_nvram(struct file *f
 	unsigned int i;
 	char __user *p = buf;
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
@@ -63,7 +63,7 @@ static ssize_t write_nvram(struct file *
 	const char __user *p = buf;
 	char c;
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
--- linux-2.6.11-rc1-bk4-orig/drivers/macintosh/via-pmu.c	2005-01-12 23:26:12.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/macintosh/via-pmu.c	2005-01-17 23:28:29.000000000 +0100
@@ -2781,13 +2781,12 @@ pmu_read(struct file *file, char __user 
 	struct pmu_private *pp = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	if (count < 1 || pp == 0)
 		return -EINVAL;
-	ret = verify_area(VERIFY_WRITE, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_WRITE, buf, count);
+		return -EFAULT;
 
 	spin_lock_irqsave(&pp->lock, flags);
 	add_wait_queue(&pp->wait, &wait);
--- linux-2.6.11-rc1-bk4-orig/drivers/pcmcia/ds.c	2005-01-12 23:26:14.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/pcmcia/ds.c	2005-01-18 01:10:47.000000000 +0100
@@ -1099,17 +1099,15 @@ static int ds_ioctl(struct inode * inode
 	return -EPERM;
 	
     if (cmd & IOC_IN) {
-	err = verify_area(VERIFY_READ, uarg, size);
-	if (err) {
-	    ds_dbg(3, "ds_ioctl(): verify_read = %d\n", err);
-	    return err;
+	if (!access_ok(VERIFY_READ, uarg, size)) {
+	    ds_dbg(3, "ds_ioctl(): verify_read = %d\n", -EFAULT);
+	    return -EFAULT;
 	}
     }
     if (cmd & IOC_OUT) {
-	err = verify_area(VERIFY_WRITE, uarg, size);
-	if (err) {
-	    ds_dbg(3, "ds_ioctl(): verify_write = %d\n", err);
-	    return err;
+	if (!access_ok(VERIFY_WRITE, uarg, size)) {
+	    ds_dbg(3, "ds_ioctl(): verify_write = %d\n", -EFAULT);
+	    return -EFAULT;
 	}
     }
     buf = kmalloc(sizeof(ds_ioctl_arg_t), GFP_KERNEL);



