Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbULJPid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbULJPid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbULJPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:38:33 -0500
Received: from mail.convergence.de ([212.227.36.84]:31134 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261735AbULJPhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:37:21 -0500
Message-ID: <41B9C281.5060100@linuxtv.org>
Date: Fri, 10 Dec 2004 16:36:33 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][1/6] saa7146 driver + misc updates
Content-Type: multipart/mixed;
 boundary="------------040406040404090207080306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406040404090207080306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040406040404090207080306
Content-Type: text/plain;
 name="01-dvb-saa7146+misc-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-dvb-saa7146+misc-update.diff"

- [DVB] saa7146: prefix IER_DISABLE and IER_ENABLE with SAA7146_, add SAA7146_ISR_CLEAR
- [DVB] dvb-bt8xx/dst: fix typo
- [DVB] cinergyT2: locking in SET_PARAMETERS and some VDR compatibility code for GET_EVENT (thanks to Stefan Lucke)

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/cinergyT2/cinergyT2.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/cinergyT2/cinergyT2.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/cinergyT2/cinergyT2.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/cinergyT2/cinergyT2.c	2004-12-08 14:45:05.000000000 +0100
@@ -139,6 +139,7 @@
 	struct work_struct query_work;
 
 	wait_queue_head_t poll_wq;
+	int pending_fe_events;
 
 	void *streambuf;
 	dma_addr_t streambuf_dmahandle;
@@ -204,7 +205,7 @@
 
 static int cinergyt2_command (struct cinergyt2 *cinergyt2,
 		    char *send_buf, int send_buf_len,
-		    char *rec_buf, int rec_buf_len)
+			      char *recv_buf, int recv_buf_len)
 {
 	int actual_len;
 	char dummy;
@@ -216,11 +217,11 @@
 	if (ret)
 		dprintk(1, "usb_bulk_msg (send) failed, err %i\n", ret);
 
-	if (!rec_buf)
-		rec_buf = &dummy;
+	if (!recv_buf)
+		recv_buf = &dummy;
 
 	ret = usb_bulk_msg(cinergyt2->udev, usb_rcvbulkpipe(cinergyt2->udev, 1),
-			   rec_buf, rec_buf_len, &actual_len, HZ);
+			   recv_buf, recv_buf_len, &actual_len, HZ);
 
 	if (ret)
 		dprintk(1, "usb_bulk_msg (read) failed, err %i\n", ret);
@@ -325,7 +326,7 @@
 
 	for (i=0; i<STREAM_URB_COUNT; i++)
 		if (cinergyt2->stream_urb[i])
-			usb_unlink_urb(cinergyt2->stream_urb[i]);
+			usb_kill_urb(cinergyt2->stream_urb[i]);
 }
 
 static int cinergyt2_start_stream_xfer (struct cinergyt2 *cinergyt2)
@@ -586,15 +587,24 @@
 		if (copy_from_user(&p, (void *) arg, sizeof(p)))
 			return -EFAULT;
 
+		if (down_interruptible(&cinergyt2->sem))
+			return -ERESTARTSYS;
+
 		param->cmd = CINERGYT2_EP1_SET_TUNER_PARAMETERS;
 		param->tps = cpu_to_le16(compute_tps(&p));
 		param->freq = cpu_to_le32(p.frequency / 1000);
 		param->bandwidth = 8 - p.u.ofdm.bandwidth - BANDWIDTH_8_MHZ;
 
+		stat->lock_bits = 0;
+		cinergyt2->pending_fe_events++;
+		wake_up_interruptible(&cinergyt2->poll_wq);
+
 		err = cinergyt2_command(cinergyt2,
 					(char *) param, sizeof(*param),
 					NULL, 0);
 
+		up(&cinergyt2->sem);
+
 		return (err < 0) ? err : 0;
 	}
 
@@ -608,6 +618,24 @@
 		 */
 		break;
 
+	case FE_GET_EVENT:
+	{
+		/**
+		 *  for now we only fill the status field. the parameters
+		 *  are trivial to fill as soon FE_GET_FRONTEND is done.
+		 */
+		struct dvb_frontend_event *e = (void *) arg;
+		if (cinergyt2->pending_fe_events == 0) {
+			if (file->f_flags & O_NONBLOCK)
+				return -EWOULDBLOCK;
+			wait_event_interruptible(cinergyt2->poll_wq,
+						 cinergyt2->pending_fe_events > 0);
+		}
+		cinergyt2->pending_fe_events = 0;
+		return cinergyt2_ioctl(inode, file, FE_READ_STATUS,
+					(unsigned long) &e->status);
+	}
+
 	default:
 		;
 	}
@@ -734,8 +762,10 @@
 	unc += le32_to_cpu(s->uncorrected_block_count);
 	s->uncorrected_block_count = unc;
 
-	if (lock_bits != s->lock_bits)
+	if (lock_bits != s->lock_bits) {
 		wake_up_interruptible(&cinergyt2->poll_wq);
+		cinergyt2->pending_fe_events++;
+	}
 
 	schedule_delayed_work(&cinergyt2->query_work,
 			      msecs_to_jiffies(QUERY_INTERVAL));
@@ -762,6 +792,7 @@
 	INIT_WORK(&cinergyt2->query_work, cinergyt2_query, cinergyt2);
 
 	cinergyt2->udev = interface_to_usbdev(intf);
+	cinergyt2->param.cmd = CINERGYT2_EP1_SET_TUNER_PARAMETERS;
 	
 	if (cinergyt2_alloc_stream_urbs (cinergyt2) < 0) {
 		dprintk(1, "unable to allocate stream urbs\n");
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/bt8xx/dst.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/bt8xx/dst.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/bt8xx/dst.c	2004-12-08 14:31:31.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/bt8xx/dst.c	2004-12-08 14:45:05.000000000 +0100
@@ -476,10 +476,10 @@
 		otype = "satellite";
 		break;
 	case DST_TYPE_IS_TERR:
-		otype = "terrestial TV";
+		otype = "terrestrial";
 		break;
 	case DST_TYPE_IS_CABLE:
-		otype = "terrestial TV";
+		otype = "cable";
 		break;
 	default:
 		printk("%s: invalid dst type %d\n", __FUNCTION__, type);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_core.c linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_core.c
--- linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_core.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_core.c	2004-11-30 15:26:46.000000000 +0100
@@ -292,7 +292,7 @@
 	if (0 != (isr & (MASK_16|MASK_17))) {
 		u32 status = saa7146_read(dev, I2C_STATUS);
 		if( (0x3 == (status & 0x3)) || (0 == (status & 0x1)) ) {
-			IER_DISABLE(dev, MASK_16|MASK_17);
+			SAA7146_IER_DISABLE(dev, MASK_16|MASK_17);
 			/* only wake up if we expect something */
 			if( 0 != dev->i2c_op ) {
 				u32 psr = (saa7146_read(dev, PSR) >> 16) & 0x2;
@@ -311,7 +311,7 @@
 	if( 0 != isr ) {
 		ERR(("warning: interrupt enabled, but not handled properly.(0x%08x)\n",isr));
 		ERR(("disabling interrupt source(s)!\n"));
-		IER_DISABLE(dev,isr);
+		SAA7146_IER_DISABLE(dev,isr);
 	}
 	return IRQ_HANDLED;
 }
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_i2c.c linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_i2c.c
--- linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_i2c.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_i2c.c	2004-11-30 15:26:46.000000000 +0100
@@ -190,7 +190,7 @@
 		saa7146_write(dev, I2C_TRANSFER, *dword);
 
 		dev->i2c_op = 1;
-		IER_ENABLE(dev, MASK_16|MASK_17);
+		SAA7146_IER_ENABLE(dev, MASK_16|MASK_17);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
 
 		wait_event_interruptible(dev->i2c_wq, dev->i2c_op == 0);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_vbi.c linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_vbi.c
--- linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_vbi.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_vbi.c	2004-11-30 15:26:46.000000000 +0100
@@ -91,7 +91,7 @@
 		saa7146_write(dev, MC2, MASK_04|MASK_20);
 	
 		/* enable rps1 irqs */
-		IER_ENABLE(dev,MASK_28);
+		SAA7146_IER_ENABLE(dev,MASK_28);
 
 		/* prepare to wait to be woken up by the irq-handler */
 		add_wait_queue(&vv->vbi_wq, &wait);
@@ -109,7 +109,7 @@
 		current->state = TASK_RUNNING;
 
 		/* disable rps1 irqs */
-		IER_DISABLE(dev,MASK_28);
+		SAA7146_IER_DISABLE(dev,MASK_28);
 
 		/* stop video-dma3 */
 		saa7146_write(dev, MC1, MASK_20);
@@ -190,7 +191,7 @@
 	WRITE_RPS1(CMD_STOP);					
 
 	/* enable rps1 irqs */
-	IER_ENABLE(dev, MASK_28);
+	SAA7146_IER_ENABLE(dev, MASK_28);
 
 	/* write the address of the rps-program */
 	saa7146_write(dev, RPS_ADDR1, dev->d_rps1.dma_handle);
@@ -325,7 +345,7 @@
 	saa7146_write(dev, MC1, MASK_29);
 
 	/* disable rps1 irqs */
-	IER_DISABLE(dev, MASK_28);
+	SAA7146_IER_DISABLE(dev, MASK_28);
 
 	/* shut down dma 3 transfers */
 	saa7146_write(dev, MC1, MASK_20);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_video.c linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_video.c
--- linux-2.6.10-rc3-bk3/drivers/media/common/saa7146_video.c	2004-12-08 14:31:34.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/common/saa7146_video.c	2004-11-30 15:26:46.000000000 +0100
@@ -760,7 +760,7 @@
 	saa7146_write(dev, MC2, MASK_27 );
 
 	/* enable rps0 irqs */
-	IER_ENABLE(dev, MASK_27);
+	SAA7146_IER_ENABLE(dev, MASK_27);
 
 	vv->video_fh = fh;
 	vv->video_status = STATUS_CAPTURE;
@@ -805,7 +805,7 @@
 	saa7146_write(dev, MC1, MASK_28);
 
 	/* disable rps0 irqs */
-	IER_DISABLE(dev, MASK_27);
+	SAA7146_IER_DISABLE(dev, MASK_27);
 
 	/* shut down all used video dma transfers */
 	saa7146_write(dev, MC1, dmas);
diff -uraNwB linux-2.6.10-rc3-bk3/include/media/saa7146.h linux-2.6.10-rc3-bk3-p/include/media/saa7146.h
--- linux-2.6.10-rc3-bk3/include/media/saa7146.h	2004-12-08 14:30:56.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/include/media/saa7146.h	2004-12-08 14:45:06.000000000 +0100
@@ -51,10 +63,12 @@
 #define DEB_INT(x)  if (0!=(DEBUG_VARIABLE&0x20)) { DEBUG_PROLOG; printk x; } /* interrupt debug messages */
 #define DEB_CAP(x)  if (0!=(DEBUG_VARIABLE&0x40)) { DEBUG_PROLOG; printk x; } /* capture debug messages */
 
-#define IER_DISABLE(x,y) \
+#define SAA7146_IER_DISABLE(x,y) \
 	saa7146_write(x, IER, saa7146_read(x, IER) & ~(y));
-#define IER_ENABLE(x,y) \
+#define SAA7146_IER_ENABLE(x,y) \
 	saa7146_write(x, IER, saa7146_read(x, IER) | (y));
+#define SAA7146_ISR_CLEAR(x,y) \
+	saa7146_write(x, ISR, (y));
 
 struct saa7146_dev;
 struct saa7146_extension;

--------------040406040404090207080306--
