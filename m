Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTI1SOc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTI1SOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:14:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47774 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262649AbTI1SOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:14:21 -0400
Date: Sun, 28 Sep 2003 20:14:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Derek Foreman <manmower@signalmarketing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
Message-ID: <20030928181421.GK15415@suse.de>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com> <20030927114712.GJ3416@suse.de> <20030927122703.GK3416@suse.de> <20030927175445.GI15415@suse.de> <Pine.LNX.4.58.0309272200200.1850@uberdeity.signalmarketing.com> <20030928085119.GJ15415@suse.de> <Pine.LNX.4.58.0309281149590.3337@uberdeity.signalmarketing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309281149590.3337@uberdeity.signalmarketing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28 2003, Derek Foreman wrote:
> On Sun, 28 Sep 2003, Jens Axboe wrote:
> 
> > On Sat, Sep 27 2003, Derek Foreman wrote:
> > > On Sat, 27 Sep 2003, Jens Axboe wrote:
> > > 
> > > -			memcpy(hdr.cmdp, cgc.cmd, sizeof(cgc.cmd));
> > > +			hdr.cmdp = (unsigned char *)arg
> > > +			         + offsetof(struct cdrom_generic_command, cmd);
> > 
> > No that's buggy, arg is a user pointer. It needs to read:
> > 
> > 			hdr.cmdp = cgc.cmd;
> 
> Actually, hdr.cmdp is expected to be a user pointer.  in sg_io we do
> 
>         rq->cmd_len = hdr->cmd_len;
>         if (copy_from_user(rq->cmd, hdr->cmdp, hdr->cmd_len))
>                 goto out_request;
>         if (sizeof(rq->cmd) != hdr->cmd_len)

Ah you are right, I'd rather kill that too then like I removed user
sg_io_hdr pointer as well. It makes for less error handling in sg_io().

===== drivers/block/scsi_ioctl.c 1.34 vs edited =====
--- 1.34/drivers/block/scsi_ioctl.c	Fri Sep  5 12:22:31 2003
+++ edited/drivers/block/scsi_ioctl.c	Sun Sep 28 20:12:44 2003
@@ -25,6 +25,7 @@
 #include <linux/cdrom.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
+#include <linux/times.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
@@ -140,40 +141,36 @@
 }
 
 static int sg_io(request_queue_t *q, struct block_device *bdev,
-		 struct sg_io_hdr *uptr)
+		 struct sg_io_hdr *hdr)
 {
 	unsigned long start_time;
 	int reading, writing;
-	struct sg_io_hdr hdr;
 	struct request *rq;
 	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	void *buffer;
 
-	if (copy_from_user(&hdr, uptr, sizeof(*uptr)))
-		return -EFAULT;
-
-	if (hdr.interface_id != 'S')
+	if (hdr->interface_id != 'S')
 		return -EINVAL;
-	if (hdr.cmd_len > sizeof(rq->cmd))
+	if (hdr->cmd_len > sizeof(rq->cmd))
 		return -EINVAL;
 
 	/*
 	 * we'll do that later
 	 */
-	if (hdr.iovec_count)
+	if (hdr->iovec_count)
 		return -EOPNOTSUPP;
 
-	if (hdr.dxfer_len > (q->max_sectors << 9))
+	if (hdr->dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
 	reading = writing = 0;
 	buffer = NULL;
 	bio = NULL;
-	if (hdr.dxfer_len) {
-		unsigned int bytes = (hdr.dxfer_len + 511) & ~511;
+	if (hdr->dxfer_len) {
+		unsigned int bytes = (hdr->dxfer_len + 511) & ~511;
 
-		switch (hdr.dxfer_direction) {
+		switch (hdr->dxfer_direction) {
 		default:
 			return -EINVAL;
 		case SG_DXFER_TO_FROM_DEV:
@@ -191,8 +188,8 @@
 		 * first try to map it into a bio. reading from device will
 		 * be a write to vm.
 		 */
-		bio = bio_map_user(bdev, (unsigned long) hdr.dxferp,
-				   hdr.dxfer_len, reading);
+		bio = bio_map_user(bdev, (unsigned long) hdr->dxferp,
+				   hdr->dxfer_len, reading);
 
 		/*
 		 * if bio setup failed, fall back to slow approach
@@ -203,11 +200,11 @@
 				return -ENOMEM;
 
 			if (writing) {
-				if (copy_from_user(buffer, hdr.dxferp,
-						   hdr.dxfer_len))
+				if (copy_from_user(buffer, hdr->dxferp,
+						   hdr->dxfer_len))
 					goto out_buffer;
 			} else
-				memset(buffer, 0, hdr.dxfer_len);
+				memset(buffer, 0, hdr->dxfer_len);
 		}
 	}
 
@@ -216,11 +213,10 @@
 	/*
 	 * fill in request structure
 	 */
-	rq->cmd_len = hdr.cmd_len;
-	if (copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len))
-		goto out_request;
-	if (sizeof(rq->cmd) != hdr.cmd_len)
-		memset(rq->cmd + hdr.cmd_len, 0, sizeof(rq->cmd) - hdr.cmd_len);
+	rq->cmd_len = hdr->cmd_len;
+	memcpy(rq->cmd, hdr->cmdp, hdr->cmd_len);
+	if (sizeof(rq->cmd) != hdr->cmd_len)
+		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
 
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
@@ -234,9 +230,9 @@
 		blk_rq_bio_prep(q, rq, bio);
 
 	rq->data = buffer;
-	rq->data_len = hdr.dxfer_len;
+	rq->data_len = hdr->dxfer_len;
 
-	rq->timeout = (hdr.timeout * HZ) / 1000;
+	rq->timeout = (hdr->timeout * HZ) / 1000;
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)
@@ -254,33 +250,30 @@
 		bio_unmap_user(bio, reading);
 
 	/* write to all output members */
-	hdr.status = rq->errors;	
-	hdr.masked_status = (hdr.status >> 1) & 0x1f;
-	hdr.msg_status = 0;
-	hdr.host_status = 0;
-	hdr.driver_status = 0;
-	hdr.info = 0;
-	if (hdr.masked_status || hdr.host_status || hdr.driver_status)
-		hdr.info |= SG_INFO_CHECK;
-	hdr.resid = rq->data_len;
-	hdr.duration = ((jiffies - start_time) * 1000) / HZ;
-	hdr.sb_len_wr = 0;
+	hdr->status = rq->errors;	
+	hdr->masked_status = (hdr->status >> 1) & 0x1f;
+	hdr->msg_status = 0;
+	hdr->host_status = 0;
+	hdr->driver_status = 0;
+	hdr->info = 0;
+	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
+		hdr->info |= SG_INFO_CHECK;
+	hdr->resid = rq->data_len;
+	hdr->duration = ((jiffies - start_time) * 1000) / HZ;
+	hdr->sb_len_wr = 0;
 
-	if (rq->sense_len && hdr.sbp) {
-		int len = min((unsigned int) hdr.mx_sb_len, rq->sense_len);
+	if (rq->sense_len && hdr->sbp) {
+		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
 
-		if (!copy_to_user(hdr.sbp, rq->sense, len))
-			hdr.sb_len_wr = len;
+		if (!copy_to_user(hdr->sbp, rq->sense, len))
+			hdr->sb_len_wr = len;
 	}
 
 	blk_put_request(rq);
 
-	if (copy_to_user(uptr, &hdr, sizeof(*uptr)))
-		goto out_buffer;
-
 	if (buffer) {
 		if (reading)
-			if (copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len))
+			if (copy_to_user(hdr->dxferp, buffer, hdr->dxfer_len))
 				goto out_buffer;
 
 		kfree(buffer);
@@ -289,8 +282,6 @@
 	/* may not have succeeded, but output values written to control
 	 * structure (struct sg_io_hdr).  */
 	return 0;
-out_request:
-	blk_put_request(rq);
 out_buffer:
 	kfree(buffer);
 	return -EFAULT;
@@ -437,9 +428,71 @@
 		case SG_EMULATED_HOST:
 			err = sg_emulated_host(q, (int *) arg);
 			break;
-		case SG_IO:
-			err = sg_io(q, bdev, (struct sg_io_hdr *) arg);
+		case SG_IO: {
+			struct sg_io_hdr hdr;
+
+			if (copy_from_user(&hdr, (struct sg_io_hdr *) arg, sizeof(hdr))) {
+				err = -EFAULT;
+				break;
+			}
+			err = sg_io(q, bdev, &hdr);
+			if (copy_to_user((struct sg_io_hdr *) arg, &hdr, sizeof(hdr)))
+				err = -EFAULT;
 			break;
+		}
+		case CDROM_SEND_PACKET: {
+			struct cdrom_generic_command cgc;
+			struct sg_io_hdr hdr;
+
+			if (copy_from_user(&cgc, (struct cdrom_generic_command *) arg, sizeof(cgc))) {
+				err = -EFAULT;
+				break;
+			}
+			cgc.timeout = clock_t_to_jiffies(cgc.timeout);
+			memset(&hdr, 0, sizeof(hdr));
+			hdr.interface_id = 'S';
+			hdr.cmd_len = sizeof(cgc.cmd);
+			hdr.dxfer_len = cgc.buflen;
+			err = 0;
+			switch (cgc.data_direction) {
+				case CGC_DATA_UNKNOWN:
+					hdr.dxfer_direction = SG_DXFER_UNKNOWN;
+					break;
+				case CGC_DATA_WRITE:
+					hdr.dxfer_direction = SG_DXFER_TO_DEV;
+					break;
+				case CGC_DATA_READ:
+					hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+					break;
+				case CGC_DATA_NONE:
+					hdr.dxfer_direction = SG_DXFER_NONE;
+					break;
+				default:
+					err = -EINVAL;
+			}
+			if (err)
+				break;
+
+			hdr.dxferp = cgc.buffer;
+			hdr.sbp = (char *) cgc.sense;
+			if (hdr.sbp)
+				hdr.mx_sb_len = sizeof(struct request_sense);
+			hdr.timeout = cgc.timeout;
+			hdr.cmdp = cgc.cmd;
+			hdr.cmd_len = sizeof(cgc.cmd);
+			err = sg_io(q, bdev, &hdr);
+
+			if (hdr.status)
+				err = -EIO;
+
+			cgc.stat = err;
+			cgc.buflen = hdr.resid;
+			if (copy_to_user((struct cdrom_generic_command *) arg, &cgc, sizeof(cgc)))
+				err = -EFAULT;
+
+			break;
+		}
+
 		/*
 		 * old junk scsi send command ioctl
 		 */
===== drivers/cdrom/cdrom.c 1.40 vs edited =====
--- 1.40/drivers/cdrom/cdrom.c	Tue Sep 23 21:18:06 2003
+++ edited/drivers/cdrom/cdrom.c	Sat Sep 27 14:24:59 2003
@@ -1856,57 +1856,6 @@
 	return cdo->generic_packet(cdi, &cgc);
 }
 
-static int cdrom_do_cmd(struct cdrom_device_info *cdi,
-			struct cdrom_generic_command *cgc)
-{
-	struct request_sense *usense, sense;
-	unsigned char *ubuf;
-	int ret;
-
-	if (cgc->data_direction == CGC_DATA_UNKNOWN)
-		return -EINVAL;
-
-	if (cgc->buflen < 0 || cgc->buflen >= 131072)
-		return -EINVAL;
-
-	usense = cgc->sense;
-	cgc->sense = &sense;
-	if (usense && !access_ok(VERIFY_WRITE, usense, sizeof(*usense))) {
-		return -EFAULT;
-	}
-
-	ubuf = cgc->buffer;
-	if (cgc->data_direction == CGC_DATA_READ ||
-	    cgc->data_direction == CGC_DATA_WRITE) {
-		cgc->buffer = kmalloc(cgc->buflen, GFP_KERNEL);
-		if (cgc->buffer == NULL)
-			return -ENOMEM;
-	}
-
-
-	if (cgc->data_direction == CGC_DATA_READ) {
-		if (!access_ok(VERIFY_READ, ubuf, cgc->buflen)) {
-			kfree(cgc->buffer);
-			return -EFAULT;
-		}
-	} else if (cgc->data_direction == CGC_DATA_WRITE) {
-		if (copy_from_user(cgc->buffer, ubuf, cgc->buflen)) {
-			kfree(cgc->buffer);
-			return -EFAULT;
-		}
-	}
-
-	ret = cdi->ops->generic_packet(cdi, cgc);
-	__copy_to_user(usense, cgc->sense, sizeof(*usense));
-	if (!ret && cgc->data_direction == CGC_DATA_READ)
-		__copy_to_user(ubuf, cgc->buffer, cgc->buflen);
-	if (cgc->data_direction == CGC_DATA_READ ||
-	    cgc->data_direction == CGC_DATA_WRITE) {
-		kfree(cgc->buffer);
-	}
-	return ret;
-}
-
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		     unsigned long arg)
 {		
@@ -2176,14 +2125,6 @@
 		return 0;
 		}
 
-	case CDROM_SEND_PACKET: {
-		if (!CDROM_CAN(CDC_GENERIC_PACKET))
-			return -ENOSYS;
-		cdinfo(CD_DO_IOCTL, "entering CDROM_SEND_PACKET\n"); 
-		IOCTL_IN(arg, struct cdrom_generic_command, cgc);
-		cgc.timeout = clock_t_to_jiffies(cgc.timeout);
-		return cdrom_do_cmd(cdi, &cgc);
-		}
 	case CDROM_NEXT_WRITABLE: {
 		long next = 0;
 		cdinfo(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n"); 

-- 
Jens Axboe

