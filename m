Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVF0NXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVF0NXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVF0NUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:20:37 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:14821 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262059AbVF0MQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:34 -0400
Message-Id: <20050627121416.691410000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-isochronous-streaming.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 36/51] usb: add isochronous streaming method
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Added isochronous-streaming method.
Changed memory (de)allocation behaviour accordingly.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-common.h |    3 
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c    |  178 +++++++++++++++++++++++------
 drivers/media/dvb/dvb-usb/dvb-usb.h        |   24 +++
 3 files changed, 167 insertions(+), 38 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-common.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-common.h	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-common.h	2005-06-27 13:26:05.000000000 +0200
@@ -15,11 +15,12 @@ extern int dvb_usb_debug;
 
 #define deb_info(args...) dprintk(dvb_usb_debug,0x01,args)
 #define deb_xfer(args...) dprintk(dvb_usb_debug,0x02,args)
-#define deb_pll(args...) dprintk(dvb_usb_debug,0x04,args)
+#define deb_pll(args...)  dprintk(dvb_usb_debug,0x04,args)
 #define deb_ts(args...)   dprintk(dvb_usb_debug,0x08,args)
 #define deb_err(args...)  dprintk(dvb_usb_debug,0x10,args)
 #define deb_rc(args...)   dprintk(dvb_usb_debug,0x20,args)
 #define deb_fw(args...)   dprintk(dvb_usb_debug,0x40,args)
+#define deb_mem(args...)  dprintk(dvb_usb_debug,0x80,args)
 
 /* commonly used  methods */
 extern int usb_cypress_load_firmware(struct usb_device *, const char *, int);
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-urb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-urb.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-urb.c	2005-06-27 13:26:05.000000000 +0200
@@ -24,6 +24,7 @@ int dvb_usb_generic_rw(struct dvb_usb_de
 	if ((ret = down_interruptible(&d->usb_sem)))
 		return ret;
 
+	deb_xfer(">>> ");
 	debug_dump(wbuf,wlen,deb_xfer);
 
 	ret = usb_bulk_msg(d->udev,usb_sndbulkpipe(d->udev,
@@ -46,8 +47,10 @@ int dvb_usb_generic_rw(struct dvb_usb_de
 
 		if (ret)
 			err("recv bulk message failed: %d",ret);
-		else
+		else {
+			deb_xfer("<<< ");
 			debug_dump(rbuf,actlen,deb_xfer);
+		}
 	}
 
 	up(&d->usb_sem);
@@ -61,12 +64,19 @@ int dvb_usb_generic_write(struct dvb_usb
 }
 EXPORT_SYMBOL(dvb_usb_generic_write);
 
-static void dvb_usb_bulk_urb_complete(struct urb *urb, struct pt_regs *ptregs)
+
+/* URB stuff for streaming */
+static void dvb_usb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
 {
 	struct dvb_usb_device *d = urb->context;
+	int ptype = usb_pipetype(urb->pipe);
+	int i;
+	u8 *b;
 
-	deb_ts("bulk urb completed. feedcount: %d, status: %d, length: %d\n",d->feedcount,urb->status,
-			urb->actual_length);
+	deb_ts("'%s' urb completed. feedcount: %d, status: %d, length: %d/%d, pack_num: %d, errors: %d\n",
+			ptype == PIPE_ISOCHRONOUS ? "isoc" : "bulk", d->feedcount,
+			urb->status,urb->actual_length,urb->transfer_buffer_length,
+			urb->number_of_packets,urb->error_count);
 
 	switch (urb->status) {
 		case 0:         /* success */
@@ -81,11 +91,33 @@ static void dvb_usb_bulk_urb_complete(st
 			break;
 	}
 
-	if (d->feedcount > 0 && urb->actual_length > 0) {
-		if (d->state & DVB_USB_STATE_DVB)
-			dvb_dmx_swfilter(&d->demux, (u8*) urb->transfer_buffer,urb->actual_length);
-	} else
-		deb_ts("URB dropped because of feedcount.\n");
+	if (d->feedcount > 0) {
+		if (d->state & DVB_USB_STATE_DVB) {
+			switch (ptype) {
+				case PIPE_ISOCHRONOUS:
+					b = (u8 *) urb->transfer_buffer;
+					for (i = 0; i < urb->number_of_packets; i++) {
+						if (urb->iso_frame_desc[i].status != 0)
+							deb_ts("iso frame descriptor has an error: %d\n",urb->iso_frame_desc[i].status);
+						else if (urb->iso_frame_desc[i].actual_length > 0) {
+								dvb_dmx_swfilter(&d->demux,b + urb->iso_frame_desc[i].offset,
+										urb->iso_frame_desc[i].actual_length);
+							}
+						urb->iso_frame_desc[i].status = 0;
+						urb->iso_frame_desc[i].actual_length = 0;
+					}
+					debug_dump(b,20,deb_ts);
+					break;
+				case PIPE_BULK:
+					if (urb->actual_length > 0)
+						dvb_dmx_swfilter(&d->demux, (u8 *) urb->transfer_buffer,urb->actual_length);
+					break;
+				default:
+					err("unkown endpoint type in completition handler.");
+					return;
+			}
+		}
+	}
 
 	usb_submit_urb(urb,GFP_ATOMIC);
 }
@@ -94,7 +126,7 @@ int dvb_usb_urb_kill(struct dvb_usb_devi
 {
 	int i;
 	for (i = 0; i < d->urbs_submitted; i++) {
-		deb_info("killing URB no. %d.\n",i);
+		deb_ts("killing URB no. %d.\n",i);
 
 		/* stop the URB */
 		usb_kill_urb(d->urb_list[i]);
@@ -107,9 +139,9 @@ int dvb_usb_urb_submit(struct dvb_usb_de
 {
 	int i,ret;
 	for (i = 0; i < d->urbs_initialized; i++) {
-		deb_info("submitting URB no. %d\n",i);
+		deb_ts("submitting URB no. %d\n",i);
 		if ((ret = usb_submit_urb(d->urb_list[i],GFP_ATOMIC))) {
-			err("could not submit URB no. %d - get them all back\n",i);
+			err("could not submit URB no. %d - get them all back",i);
 			dvb_usb_urb_kill(d);
 			return ret;
 		}
@@ -118,32 +150,78 @@ int dvb_usb_urb_submit(struct dvb_usb_de
 	return 0;
 }
 
-static int dvb_usb_bulk_urb_init(struct dvb_usb_device *d)
+static int dvb_usb_free_stream_buffers(struct dvb_usb_device *d)
+{
+	if (d->state & DVB_USB_STATE_URB_BUF) {
+		while (d->buf_num) {
+			d->buf_num--;
+			deb_mem("freeing buffer %d\n",d->buf_num);
+			usb_buffer_free(d->udev, d->buf_size,
+					d->buf_list[d->buf_num], d->dma_addr[d->buf_num]);
+		}
+		kfree(d->buf_list);
+		kfree(d->dma_addr);
+	}
+
+	d->state &= ~DVB_USB_STATE_URB_BUF;
+
+	return 0;
+}
+
+static int dvb_usb_allocate_stream_buffers(struct dvb_usb_device *d, int num, unsigned long size)
 {
-	int i,bufsize = d->props.urb.count * d->props.urb.u.bulk.buffersize;
+	d->buf_num = 0;
+	d->buf_size = size;
+
+	deb_mem("all in all I will use %lu bytes for streaming\n",num*size);
 
-	deb_info("allocate %d bytes as buffersize for all URBs\n",bufsize);
-	/* allocate the actual buffer for the URBs */
-	if ((d->buffer =  usb_buffer_alloc(d->udev, bufsize, SLAB_ATOMIC, &d->dma_handle)) == NULL) {
-		deb_info("not enough memory for urb-buffer allocation.\n");
+	if ((d->buf_list = kmalloc(num*sizeof(u8 *), GFP_ATOMIC)) == NULL)
+		return -ENOMEM;
+
+	if ((d->dma_addr = kmalloc(num*sizeof(dma_addr_t), GFP_ATOMIC)) == NULL) {
+		kfree(d->buf_list);
 		return -ENOMEM;
 	}
-	deb_info("allocation successful\n");
-	memset(d->buffer,0,bufsize);
+	memset(d->buf_list,0,num*sizeof(u8 *));
+	memset(d->dma_addr,0,num*sizeof(dma_addr_t));
 
 	d->state |= DVB_USB_STATE_URB_BUF;
 
+	for (d->buf_num = 0; d->buf_num < num; d->buf_num++) {
+		deb_mem("allocating buffer %d\n",d->buf_num);
+		if (( d->buf_list[d->buf_num] =
+					usb_buffer_alloc(d->udev, size, SLAB_ATOMIC,
+					&d->dma_addr[d->buf_num]) ) == NULL) {
+			deb_mem("not enough memory for urb-buffer allocation.\n");
+			dvb_usb_free_stream_buffers(d);
+			return -ENOMEM;
+		}
+		deb_mem("buffer %d: %p (dma: %d)\n",d->buf_num,d->buf_list[d->buf_num],d->dma_addr[d->buf_num]);
+		memset(d->buf_list[d->buf_num],0,size);
+	}
+	deb_mem("allocation successful\n");
+
+	return 0;
+}
+
+static int dvb_usb_bulk_urb_init(struct dvb_usb_device *d)
+{
+	int i;
+
+	if ((i = dvb_usb_allocate_stream_buffers(d,d->props.urb.count,
+					d->props.urb.u.bulk.buffersize)) < 0)
+		return i;
+
 	/* allocate the URBs */
 	for (i = 0; i < d->props.urb.count; i++) {
-		if (!(d->urb_list[i] = usb_alloc_urb(0,GFP_ATOMIC))) {
+		if ((d->urb_list[i] = usb_alloc_urb(0,GFP_ATOMIC)) == NULL)
 			return -ENOMEM;
-		}
 
 		usb_fill_bulk_urb( d->urb_list[i], d->udev,
 				usb_rcvbulkpipe(d->udev,d->props.urb.endpoint),
-				&d->buffer[i*d->props.urb.u.bulk.buffersize],
+				d->buf_list[i],
 				d->props.urb.u.bulk.buffersize,
-				dvb_usb_bulk_urb_complete, d);
+				dvb_usb_urb_complete, d);
 
 		d->urb_list[i]->transfer_flags = 0;
 		d->urbs_initialized++;
@@ -151,6 +229,47 @@ static int dvb_usb_bulk_urb_init(struct 
 	return 0;
 }
 
+static int dvb_usb_isoc_urb_init(struct dvb_usb_device *d)
+{
+	int i,j;
+
+	if ((i = dvb_usb_allocate_stream_buffers(d,d->props.urb.count,
+					d->props.urb.u.isoc.framesize*d->props.urb.u.isoc.framesperurb)) < 0)
+		return i;
+
+	/* allocate the URBs */
+	for (i = 0; i < d->props.urb.count; i++) {
+		struct urb *urb;
+		int frame_offset = 0;
+		if ((d->urb_list[i] =
+					usb_alloc_urb(d->props.urb.u.isoc.framesperurb,GFP_ATOMIC)) == NULL)
+			return -ENOMEM;
+
+		urb = d->urb_list[i];
+
+		urb->dev = d->udev;
+		urb->context = d;
+		urb->complete = dvb_usb_urb_complete;
+		urb->pipe = usb_rcvisocpipe(d->udev,d->props.urb.endpoint);
+		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+		urb->interval = d->props.urb.u.isoc.interval;
+		urb->number_of_packets = d->props.urb.u.isoc.framesperurb;
+		urb->transfer_buffer_length = d->buf_size;
+		urb->transfer_buffer = d->buf_list[i];
+		urb->transfer_dma = d->dma_addr[i];
+
+		for (j = 0; j < d->props.urb.u.isoc.framesperurb; j++) {
+			urb->iso_frame_desc[j].offset = frame_offset;
+			urb->iso_frame_desc[j].length = d->props.urb.u.isoc.framesize;
+			frame_offset += d->props.urb.u.isoc.framesize;
+		}
+
+		d->urbs_initialized++;
+	}
+	return 0;
+
+}
+
 int dvb_usb_urb_init(struct dvb_usb_device *d)
 {
 	/*
@@ -174,8 +293,7 @@ int dvb_usb_urb_init(struct dvb_usb_devi
 		case DVB_USB_BULK:
 			return dvb_usb_bulk_urb_init(d);
 		case DVB_USB_ISOC:
-			err("isochronous transfer not yet implemented in dvb-usb.");
-			return -EINVAL;
+			return dvb_usb_isoc_urb_init(d);
 		default:
 			err("unkown URB-type for data transfer.");
 			return -EINVAL;
@@ -191,7 +309,7 @@ int dvb_usb_urb_exit(struct dvb_usb_devi
 	if (d->state & DVB_USB_STATE_URB_LIST) {
 		for (i = 0; i < d->urbs_initialized; i++) {
 			if (d->urb_list[i] != NULL) {
-				deb_info("freeing URB no. %d.\n",i);
+				deb_mem("freeing URB no. %d.\n",i);
 				/* free the URBs */
 				usb_free_urb(d->urb_list[i]);
 			}
@@ -202,10 +320,6 @@ int dvb_usb_urb_exit(struct dvb_usb_devi
 		d->state &= ~DVB_USB_STATE_URB_LIST;
 	}
 
-	if (d->state & DVB_USB_STATE_URB_BUF)
-		usb_buffer_free(d->udev, d->props.urb.u.bulk.buffersize * d->props.urb.count,
-				d->buffer, d->dma_handle);
-
-	d->state &= ~DVB_USB_STATE_URB_BUF;
+	dvb_usb_free_stream_buffers(d);
 	return 0;
 }
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-06-27 13:26:05.000000000 +0200
@@ -189,6 +189,7 @@ struct dvb_usb_properties {
 			struct {
 				int framesperurb;
 				int framesize;
+				int interval;
 			} isoc;
 		} u;
 	} urb;
@@ -207,19 +208,28 @@ struct dvb_usb_properties {
  * @udev: pointer to the device's struct usb_device.
  * @urb_list: array of dynamically allocated struct urb for the MPEG2-TS-
  *  streaming.
- * @buffer: buffer used to streaming.
- * @dma_handle: dma_addr_t for buffer.
+ *
+ * @buf_num: number of buffer allocated.
+ * @buf_size: size of each buffer in buf_list.
+ * @buf_list: array containing all allocate buffers for streaming.
+ * @dma_addr: list of dma_addr_t for each buffer in buf_list.
+ *
  * @urbs_initialized: number of URBs initialized.
  * @urbs_submitted: number of URBs submitted.
+ *
  * @feedcount: number of reqested feeds (used for streaming-activation)
  * @pid_filtering: is hardware pid_filtering used or not.
+ *
  * @usb_sem: semaphore of USB control messages (reading needs two messages)
  * @i2c_sem: semaphore for i2c-transfers
+ *
  * @i2c_adap: device's i2c_adapter if it uses I2CoverUSB
  * @pll_addr: I2C address of the tuner for programming
  * @pll_init: array containing the initialization buffer
  * @pll_desc: pointer to the appropriate struct dvb_pll_desc
- * @tuner_pass_ctrl: called to (de)activate tuner passthru of the demod
+ *
+ * @tuner_pass_ctrl: called to (de)activate tuner passthru of the demod or the board
+ *
  * @dvb_adap: device's dvb_adapter.
  * @dmxdev: device's dmxdev.
  * @demux: device's software demuxer.
@@ -253,8 +263,12 @@ struct dvb_usb_device {
 	/* usb */
 	struct usb_device *udev;
 	struct urb **urb_list;
-	u8 *buffer;
-	dma_addr_t dma_handle;
+
+	int buf_num;
+	unsigned long buf_size;
+	u8 **buf_list;
+	dma_addr_t *dma_addr;
+
 	int urbs_initialized;
 	int urbs_submitted;
 

--

