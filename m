Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVCDDgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVCDDgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVCDDcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:32:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:42462 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262852AbVCDCqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:46:48 -0500
Date: Fri, 4 Mar 2005 03:47:43 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2/10] verify_area cleanup : drivers part 2
Message-ID: <Pine.LNX.4.62.0503040325040.2801@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts the second half of drivers from verify_area to
access_ok.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-orig/drivers/mtd/mtdchar.c linux-2.6.11/drivers/mtd/mtdchar.c
--- linux-2.6.11-orig/drivers/mtd/mtdchar.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/mtd/mtdchar.c	2005-03-03 22:51:20.000000000 +0100
@@ -285,12 +285,12 @@ static int mtd_ioctl(struct inode *inode
 
 	size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
 	if (cmd & IOC_IN) {
-		ret = verify_area(VERIFY_READ, argp, size);
-		if (ret) return ret;
+		if (!access_ok(VERIFY_READ, argp, size))
+			return -EFAULT;
 	}
 	if (cmd & IOC_OUT) {
-		ret = verify_area(VERIFY_WRITE, argp, size);
-		if (ret) return ret;
+		if (!access_ok(VERIFY_WRITE, argp, size))
+			return -EFAULT;
 	}
 	
 	switch (cmd) {
@@ -389,7 +389,8 @@ static int mtd_ioctl(struct inode *inode
 		if (!mtd->write_oob)
 			ret = -EOPNOTSUPP;
 		else
-			ret = verify_area(VERIFY_READ, buf.ptr, buf.length);
+			ret = access_ok(VERIFY_READ, buf.ptr, 
+					buf.length) ? 0 : EFAULT;
 
 		if (ret)
 			return ret;
@@ -428,7 +429,8 @@ static int mtd_ioctl(struct inode *inode
 		if (!mtd->read_oob)
 			ret = -EOPNOTSUPP;
 		else
-			ret = verify_area(VERIFY_WRITE, buf.ptr, buf.length);
+			ret = access_ok(VERIFY_WRITE, buf.ptr, 
+					buf.length) ? 0 : -EFAULT;
 
 		if (ret)
 			return ret;
diff -urp linux-2.6.11-orig/drivers/net/wireless/orinoco.c linux-2.6.11/drivers/net/wireless/orinoco.c
--- linux-2.6.11-orig/drivers/net/wireless/orinoco.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/drivers/net/wireless/orinoco.c	2005-03-03 22:51:20.000000000 +0100
@@ -2553,9 +2553,8 @@ static int orinoco_ioctl_getiwrange(stru
 
 	TRACE_ENTER(dev->name);
 
-	err = verify_area(VERIFY_WRITE, rrq->pointer, sizeof(range));
-	if (err)
-		return err;
+	if (!access_ok(VERIFY_WRITE, rrq->pointer, sizeof(range)))
+		return -EFAULT;
 
 	rrq->length = sizeof(range);
 
diff -urp linux-2.6.11-orig/drivers/pcmcia/ds.c linux-2.6.11/drivers/pcmcia/ds.c
--- linux-2.6.11-orig/drivers/pcmcia/ds.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.11/drivers/pcmcia/ds.c	2005-03-03 22:51:28.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/s390/net/ctctty.c linux-2.6.11/drivers/s390/net/ctctty.c
--- linux-2.6.11-orig/drivers/s390/net/ctctty.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11/drivers/s390/net/ctctty.c	2005-03-03 22:51:22.000000000 +0100
@@ -778,11 +778,10 @@ ctc_tty_ioctl(struct tty_struct *tty, st
 			printk(KERN_DEBUG "%s%d ioctl TIOCSERGETLSR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
-			error = verify_area(VERIFY_WRITE, (void __user *) arg, sizeof(uint));
-			if (error)
-				return error;
-			else
+			if (access_ok(VERIFY_WRITE, (void __user *) arg, sizeof(uint)))
 				return ctc_tty_get_lsr_info(info, (uint __user *) arg);
+			else
+				return -EFAULT;
 		default:
 #ifdef CTC_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "UNKNOWN ioctl 0x%08x on %s%d\n", cmd,
diff -urp linux-2.6.11-orig/drivers/sbus/char/aurora.c linux-2.6.11/drivers/sbus/char/aurora.c
--- linux-2.6.11-orig/drivers/sbus/char/aurora.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11/drivers/sbus/char/aurora.c	2005-03-03 22:51:22.000000000 +0100
@@ -1887,14 +1887,12 @@ extern int aurora_get_serial_info(struct
 {
 	struct serial_struct tmp;
 	struct Aurora_board *bp = port_Board(port);
-	int error;
 	
 #ifdef AURORA_DEBUG
 	printk("aurora_get_serial_info: start\n");
 #endif
-	error = verify_area(VERIFY_WRITE, (void *) retinfo, sizeof(tmp));
-	if (error)
-		return error;
+	if (!access_ok(VERIFY_WRITE, (void *) retinfo, sizeof(tmp)))
+		return -EFAULT;
 	
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = PORT_CIRRUS;
diff -urp linux-2.6.11-orig/drivers/sbus/char/openprom.c linux-2.6.11/drivers/sbus/char/openprom.c
--- linux-2.6.11-orig/drivers/sbus/char/openprom.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/sbus/char/openprom.c	2005-03-03 22:51:22.000000000 +0100
@@ -427,16 +427,14 @@ static int openprom_bsd_ioctl(struct ino
 			len = op.op_buflen = 0;
 		}
 
-		error = verify_area(VERIFY_WRITE, argp, sizeof(op));
-		if (error) {
+		if (!access_ok(VERIFY_WRITE, argp, sizeof(op))) {
 			kfree(str);
-			return error;
+			return -EFAULT;
 		}
 
-		error = verify_area(VERIFY_WRITE, op.op_buf, len);
-		if (error) {
+		if (!access_ok(VERIFY_WRITE, op.op_buf, len)) {
 			kfree(str);
-			return error;
+			return -EFAULT;
 		}
 
 		error = __copy_to_user(argp, &op, sizeof(op));
diff -urp linux-2.6.11-orig/drivers/scsi/cpqfcTSinit.c linux-2.6.11/drivers/scsi/cpqfcTSinit.c
--- linux-2.6.11-orig/drivers/scsi/cpqfcTSinit.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.11/drivers/scsi/cpqfcTSinit.c	2005-03-03 22:51:28.000000000 +0100
@@ -752,7 +752,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
 		result = -ENXIO;
 		break;
 	}
-	result = verify_area(VERIFY_WRITE, arg, sizeof(Scsi_FCTargAddress));
+	result = access_ok(VERIFY_WRITE, arg, sizeof(Scsi_FCTargAddress)) ? 0 : -EFAULT;
 	if (result) break;
  
       put_user(pLoggedInPort->port_id,
diff -urp linux-2.6.11-orig/drivers/scsi/scsi_ioctl.c linux-2.6.11/drivers/scsi/scsi_ioctl.c
--- linux-2.6.11-orig/drivers/scsi/scsi_ioctl.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.11/drivers/scsi/scsi_ioctl.c	2005-03-03 22:51:28.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/scsi/sg.c linux-2.6.11/drivers/scsi/sg.c
--- linux-2.6.11-orig/drivers/scsi/sg.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/drivers/scsi/sg.c	2005-03-03 22:51:28.000000000 +0100
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
@@ -1959,9 +1953,8 @@ sg_write_xfer(Sg_request * srp)
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
 
@@ -2031,7 +2024,7 @@ sg_u_iovec(sg_io_hdr_t * hp, int sg_num,
 {
 	int num_xfer = (int) hp->dxfer_len;
 	unsigned char __user *p = hp->dxferp;
-	int count, k;
+	int count;
 
 	if (0 == sg_num) {
 		if (wr_xf && ('\0' == hp->interface_id))
@@ -2045,8 +2038,8 @@ sg_u_iovec(sg_io_hdr_t * hp, int sg_num,
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
@@ -2113,9 +2106,8 @@ sg_read_xfer(Sg_request * srp)
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
 
Only in linux-2.6.11/drivers/scsi: sg.c~
diff -urp linux-2.6.11-orig/drivers/serial/68328serial.c linux-2.6.11/drivers/serial/68328serial.c
--- linux-2.6.11-orig/drivers/serial/68328serial.c	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.11/drivers/serial/68328serial.c	2005-03-03 22:51:28.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/serial/mcfserial.c linux-2.6.11/drivers/serial/mcfserial.c
--- linux-2.6.11-orig/drivers/serial/mcfserial.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11/drivers/serial/mcfserial.c	2005-03-03 22:51:28.000000000 +0100
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
Only in linux-2.6.11/drivers/tc: zs.c.rej
Only in linux-2.6.11/drivers/tc: zs.c~
diff -urp linux-2.6.11-orig/drivers/usb/serial/kl5kusb105.c linux-2.6.11/drivers/usb/serial/kl5kusb105.c
--- linux-2.6.11-orig/drivers/usb/serial/kl5kusb105.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11/drivers/usb/serial/kl5kusb105.c	2005-03-03 22:51:20.000000000 +0100
@@ -925,45 +925,34 @@ static int klsi_105_ioctl (struct usb_se
 		/* TODO */
 		dbg("%s - TIOCMIWAIT not handled", __FUNCTION__);
 		return -ENOIOCTLCMD;
-
 	case TIOCGICOUNT:
 		/* return count of modemline transitions */
 		/* TODO */
 		dbg("%s - TIOCGICOUNT not handled", __FUNCTION__);
 		return -ENOIOCTLCMD;
-	case TCGETS: {
-	     /* return current info to caller */
-	     int retval;
-
-	     dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
-
-	     retval = verify_area(VERIFY_WRITE, user_arg,
-				  sizeof(struct termios));
-	     if (retval)
-			 return retval;
-
-	     if (kernel_termios_to_user_termios((struct termios __user *)arg,
-						&priv->termios))
-		     return -EFAULT;
-	     return(0);
-	     }
-	case TCSETS: {
-		/* set port termios to the one given by the user */
-		int retval;
+	case TCGETS:
+		/* return current info to caller */
+		dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
+
+		if (!access_ok(VERIFY_WRITE, user_arg, sizeof(struct termios)))
+			return -EFAULT;
 
+		if (kernel_termios_to_user_termios((struct termios __user *)arg,
+						   &priv->termios))
+			return -EFAULT;
+		return 0;
+	case TCSETS:
+		/* set port termios to the one given by the user */
 		dbg("%s - TCSETS not handled", __FUNCTION__);
 
-		retval = verify_area(VERIFY_READ, user_arg,
-				     sizeof(struct termios));
-		if (retval)
-			    return retval;
+		if (!access_ok(VERIFY_READ, user_arg, sizeof(struct termios)))
+			return -EFAULT;
 
 		if (user_termios_to_kernel_termios(&priv->termios,
-						  (struct termios __user *)arg))
+						   (struct termios __user *)arg))
 			return -EFAULT;
 		klsi_105_set_termios(port, &priv->termios);
-		return(0);
-	     }
+		return 0;
 	case TCSETSW: {
 		/* set port termios and try to wait for completion of last
 		 * write operation */
diff -urp linux-2.6.11-orig/drivers/usb/serial/kobil_sct.c linux-2.6.11/drivers/usb/serial/kobil_sct.c
--- linux-2.6.11-orig/drivers/usb/serial/kobil_sct.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11/drivers/usb/serial/kobil_sct.c	2005-03-03 22:51:20.000000000 +0100
@@ -637,10 +637,9 @@ static int  kobil_ioctl(struct usb_seria
 
 	switch (cmd) {
 	case TCGETS:   // 0x5401
-		result = verify_area(VERIFY_WRITE, user_arg, sizeof(struct termios));
-		if (result) {
-			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
-			return(result);
+		if (!access_ok(VERIFY_WRITE, user_arg, sizeof(struct termios))) {
+			dbg("%s - port %d Error in access_ok", __FUNCTION__, port->number);
+			return -EFAULT;
 		}
 		if (kernel_termios_to_user_termios((struct termios __user *)arg,
 						   &priv->internal_termios))
@@ -652,10 +651,9 @@ static int  kobil_ioctl(struct usb_seria
 			dbg("%s - port %d Error: port->tty->termios is NULL", __FUNCTION__, port->number);
 			return -ENOTTY;
 		}
-		result = verify_area(VERIFY_READ, user_arg, sizeof(struct termios));
-		if (result) {
-			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
-			return result;
+		if (!access_ok(VERIFY_READ, user_arg, sizeof(struct termios))) {
+			dbg("%s - port %d Error in access_ok", __FUNCTION__, port->number);
+			return -EFAULT;
 		}
 		if (user_termios_to_kernel_termios(&priv->internal_termios,
 						   (struct termios __user *)arg))
diff -urp linux-2.6.11-orig/drivers/video/amifb.c linux-2.6.11/drivers/video/amifb.c
--- linux-2.6.11-orig/drivers/video/amifb.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11/drivers/video/amifb.c	2005-03-03 22:51:28.000000000 +0100
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
diff -up linux-2.6.11-orig/drivers/tc/zs.c linux-2.6.11/drivers/tc/zs.c
--- linux-2.6.11-orig/drivers/tc/zs.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11/drivers/tc/zs.c	2005-03-04 00:47:40.000000000 +0100
@@ -1240,28 +1240,24 @@ static int rs_ioctl(struct tty_struct *t
 
 	switch (cmd) {
 	case TIOCGSERIAL:
-		error = verify_area(VERIFY_WRITE, (void *)arg,
-				    sizeof(struct serial_struct));
-		if (error)
-			return error;
+		if (!access_ok(VERIFY_WRITE, (void *)arg,
+			       sizeof(struct serial_struct)))
+			return -EFAULT;
 		return get_serial_info(info, (struct serial_struct *)arg);
 
 	case TIOCSSERIAL:
 		return set_serial_info(info, (struct serial_struct *)arg);
 
 	case TIOCSERGETLSR:			/* Get line status register */
-		error = verify_area(VERIFY_WRITE, (void *)arg,
-				    sizeof(unsigned int));
-		if (error)
-			return error;
-		else
-			return get_lsr_info(info, (unsigned int *)arg);
+		if (!access_ok(VERIFY_WRITE, (void *)arg,
+			       sizeof(unsigned int)))
+			return -EFAULT;
+		return get_lsr_info(info, (unsigned int *)arg);
 
 	case TIOCSERGSTRUCT:
-		error = verify_area(VERIFY_WRITE, (void *)arg,
-				    sizeof(struct dec_serial));
-		if (error)
-			return error;
+		if (!access_ok(VERIFY_WRITE, (void *)arg,
+			       sizeof(struct dec_serial)))
+			return -EFAULT;
 		copy_from_user((struct dec_serial *)arg, info,
 			       sizeof(struct dec_serial));
 		return 0;


