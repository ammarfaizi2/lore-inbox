Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161515AbWAMJwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161515AbWAMJwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWAMJwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:52:38 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:30097 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932620AbWAMJwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:52:37 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 09/13] USBATM: measure buffer size in bytes; force valid sizes
Date: Fri, 13 Jan 2006 10:52:38 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nh3xDbFFzB2olkd"
Message-Id: <200601131052.39257.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_nh3xDbFFzB2olkd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Change the module parameters rcv_buf_size and snd_buf_size to
specify buffer sizes in bytes rather than ATM cells.  Since
there is some danger that users may not notice this change,
the parameters are renamed to rcv_buf_bytes etc.  The transmit
buffer needs to be a multiple of the ATM cell size in length,
while the receive buffer should be a multiple of the endpoint
maxpacket size (this wasn't enforced before, which causes trouble
with isochronous transfers), so enforce these restrictions.  Now
that the usbatm probe method inspects the endpoint maxpacket size,
minidriver bind routines need to set the correct alternate setting
for the interface in their bind routine.  This is the reason for
the speedtch changes.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_nh3xDbFFzB2olkd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="09-bytes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="09-bytes"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:00:06.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:05:06.000000000 +0100
@@ -99,12 +99,11 @@
 
 #define UDSL_MAX_RCV_URBS		16
 #define UDSL_MAX_SND_URBS		16
-#define UDSL_MAX_RCV_BUF_SIZE		1024	/* ATM cells */
-#define UDSL_MAX_SND_BUF_SIZE		1024	/* ATM cells */
+#define UDSL_MAX_BUF_SIZE		64 * 1024	/* bytes */
 #define UDSL_DEFAULT_RCV_URBS		4
 #define UDSL_DEFAULT_SND_URBS		4
-#define UDSL_DEFAULT_RCV_BUF_SIZE	64	/* ATM cells */
-#define UDSL_DEFAULT_SND_BUF_SIZE	64	/* ATM cells */
+#define UDSL_DEFAULT_RCV_BUF_SIZE	64 * ATM_CELL_SIZE	/* bytes */
+#define UDSL_DEFAULT_SND_BUF_SIZE	64 * ATM_CELL_SIZE	/* bytes */
 
 #define ATM_CELL_HEADER			(ATM_CELL_SIZE - ATM_CELL_PAYLOAD)
 
@@ -112,8 +111,8 @@
 
 static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;
 static unsigned int num_snd_urbs = UDSL_DEFAULT_SND_URBS;
-static unsigned int rcv_buf_size = UDSL_DEFAULT_RCV_BUF_SIZE;
-static unsigned int snd_buf_size = UDSL_DEFAULT_SND_BUF_SIZE;
+static unsigned int rcv_buf_bytes = UDSL_DEFAULT_RCV_BUF_SIZE;
+static unsigned int snd_buf_bytes = UDSL_DEFAULT_SND_BUF_SIZE;
 
 module_param(num_rcv_urbs, uint, S_IRUGO);
 MODULE_PARM_DESC(num_rcv_urbs,
@@ -127,15 +126,15 @@
 		 __MODULE_STRING(UDSL_MAX_SND_URBS) ", default: "
 		 __MODULE_STRING(UDSL_DEFAULT_SND_URBS) ")");
 
-module_param(rcv_buf_size, uint, S_IRUGO);
-MODULE_PARM_DESC(rcv_buf_size,
-		 "Size of the buffers used for reception in ATM cells (range: 1-"
-		 __MODULE_STRING(UDSL_MAX_RCV_BUF_SIZE) ", default: "
+module_param(rcv_buf_bytes, uint, S_IRUGO);
+MODULE_PARM_DESC(rcv_buf_bytes,
+		 "Size of the buffers used for reception, in bytes (range: 1-"
+		 __MODULE_STRING(UDSL_MAX_BUF_SIZE) ", default: "
 		 __MODULE_STRING(UDSL_DEFAULT_RCV_BUF_SIZE) ")");
 
-module_param(snd_buf_size, uint, S_IRUGO);
-MODULE_PARM_DESC(snd_buf_size,
-		 "Size of the buffers used for transmission in ATM cells (range: 1-"
+module_param(snd_buf_bytes, uint, S_IRUGO);
+MODULE_PARM_DESC(snd_buf_bytes,
+		 "Size of the buffers used for transmission, in bytes (range: 1-"
 		 __MODULE_STRING(UDSL_MAX_SND_BUF_SIZE) ", default: "
 		 __MODULE_STRING(UDSL_DEFAULT_SND_BUF_SIZE) ")");
 
@@ -430,14 +429,14 @@
 {
 	struct usbatm_control *ctrl = UDSL_SKB(skb);
 	struct atm_vcc *vcc = ctrl->atm.vcc;
-	unsigned int num_written;
+	unsigned int bytes_written;
 	unsigned int stride = instance->tx_channel.stride;
 
 	vdbg("%s: skb->len=%d, avail_space=%u", __func__, skb->len, avail_space);
 	UDSL_ASSERT(!(avail_space % stride));
 
-	for (num_written = 0; num_written < avail_space && ctrl->len;
-	     num_written += stride, target += stride) {
+	for (bytes_written = 0; bytes_written < avail_space && ctrl->len;
+	     bytes_written += stride, target += stride) {
 		unsigned int data_len = min_t(unsigned int, skb->len, ATM_CELL_PAYLOAD);
 		unsigned int left = ATM_CELL_PAYLOAD - data_len;
 		u8 *ptr = target;
@@ -480,7 +479,7 @@
 			ctrl->crc = crc32_be(ctrl->crc, ptr, left);
 	}
 
-	return num_written;
+	return bytes_written;
 }
 
 
@@ -524,7 +523,7 @@
 	struct sk_buff *skb = instance->current_skb;
 	struct urb *urb = NULL;
 	const unsigned int buf_size = instance->tx_channel.buf_size;
-	unsigned int num_written = 0;
+	unsigned int bytes_written = 0;
 	u8 *buffer = NULL;
 
 	if (!skb)
@@ -536,16 +535,16 @@
 			if (!urb)
 				break;		/* no more senders */
 			buffer = urb->transfer_buffer;
-			num_written = (urb->status == -EAGAIN) ?
+			bytes_written = (urb->status == -EAGAIN) ?
 				urb->transfer_buffer_length : 0;
 		}
 
-		num_written += usbatm_write_cells(instance, skb,
-						  buffer + num_written,
-						  buf_size - num_written);
+		bytes_written += usbatm_write_cells(instance, skb,
+						  buffer + bytes_written,
+						  buf_size - bytes_written);
 
 		vdbg("%s: wrote %u bytes from skb 0x%p to urb 0x%p",
-		     __func__, num_written, skb, urb);
+		     __func__, bytes_written, skb, urb);
 
 		if (!UDSL_SKB(skb)->len) {
 			struct atm_vcc *vcc = UDSL_SKB(skb)->atm.vcc;
@@ -556,8 +555,8 @@
 			skb = skb_dequeue(&instance->sndqueue);
 		}
 
-		if (num_written == buf_size || (!skb && num_written)) {
-			urb->transfer_buffer_length = num_written;
+		if (bytes_written == buf_size || (!skb && bytes_written)) {
+			urb->transfer_buffer_length = bytes_written;
 
 			if (usbatm_submit_urb(urb))
 				break;
@@ -990,6 +989,7 @@
 	char *buf;
 	int error = -ENOMEM;
 	int i, length;
+	unsigned int maxpacket, num_packets;
 
 	dev_dbg(dev, "%s: trying driver %s with vendor=%04x, product=%04x, ifnum %2d\n",
 			__func__, driver->driver_name,
@@ -1058,10 +1058,38 @@
 	instance->tx_channel.endpoint = usb_sndbulkpipe(usb_dev, driver->out);
 	instance->rx_channel.stride = ATM_CELL_SIZE + driver->rx_padding;
 	instance->tx_channel.stride = ATM_CELL_SIZE + driver->tx_padding;
-	instance->rx_channel.buf_size = rcv_buf_size * instance->rx_channel.stride;
-	instance->tx_channel.buf_size = snd_buf_size * instance->tx_channel.stride;
 	instance->rx_channel.usbatm = instance->tx_channel.usbatm = instance;
 
+	/* tx buffer size must be a positive multiple of the stride */
+	instance->tx_channel.buf_size = max (instance->tx_channel.stride,
+			snd_buf_bytes - (snd_buf_bytes % instance->tx_channel.stride));
+
+	/* rx buffer size must be a positive multiple of the endpoint maxpacket */
+	maxpacket = usb_maxpacket(usb_dev, instance->rx_channel.endpoint, 0);
+
+	if ((maxpacket < 1) || (maxpacket > UDSL_MAX_BUF_SIZE)) {
+		dev_err(dev, "%s: invalid endpoint %02x!\n", __func__,
+				usb_pipeendpoint(instance->rx_channel.endpoint));
+		error = -EINVAL;
+		goto fail_unbind;
+	}
+
+	num_packets = max (1U, (rcv_buf_bytes + maxpacket / 2) / maxpacket); /* round */
+
+	if (num_packets * maxpacket > UDSL_MAX_BUF_SIZE)
+		num_packets--;
+
+	instance->rx_channel.buf_size = num_packets * maxpacket;
+
+#ifdef DEBUG
+	for (i = 0; i < 2; i++) {
+		struct usbatm_channel *channel = i ?
+			&instance->tx_channel : &instance->rx_channel;
+
+		dev_dbg(dev, "%s: using %d byte buffer for %s channel 0x%p\n", __func__, channel->buf_size, i ? "tx" : "rx", channel);
+	}
+#endif
+
 	skb_queue_head_init(&instance->sndqueue);
 
 	for (i = 0; i < num_rcv_urbs + num_snd_urbs; i++) {
@@ -1232,10 +1260,10 @@
 
 	if ((num_rcv_urbs > UDSL_MAX_RCV_URBS)
 	    || (num_snd_urbs > UDSL_MAX_SND_URBS)
-	    || (rcv_buf_size < 1)
-	    || (rcv_buf_size > UDSL_MAX_RCV_BUF_SIZE)
-	    || (snd_buf_size < 1)
-	    || (snd_buf_size > UDSL_MAX_SND_BUF_SIZE))
+	    || (rcv_buf_bytes < 1)
+	    || (rcv_buf_bytes > UDSL_MAX_BUF_SIZE)
+	    || (snd_buf_bytes < 1)
+	    || (snd_buf_bytes > UDSL_MAX_BUF_SIZE))
 		return -EINVAL;
 
 	return 0;
Index: Linux/drivers/usb/atm/speedtch.c
===================================================================
--- Linux.orig/drivers/usb/atm/speedtch.c	2006-01-13 09:08:36.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-13 09:08:53.000000000 +0100
@@ -89,6 +89,7 @@
 		 "Enable software buffering (default: "
 		 __MODULE_STRING(DEFAULT_SW_BUFFERING) ")");
 
+#define INTERFACE_DATA		1
 #define ENDPOINT_INT		0x81
 #define ENDPOINT_DATA		0x07
 #define ENDPOINT_FIRMWARE	0x05
@@ -98,6 +99,8 @@
 struct speedtch_instance_data {
 	struct usbatm_data *usbatm;
 
+	unsigned int altsetting;
+
 	struct work_struct status_checker;
 
 	unsigned char last_status;
@@ -270,6 +273,11 @@
 	   because we're in our own kernel thread anyway. */
 	msleep_interruptible(1000);
 
+	if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->altsetting)) < 0) {
+		usb_err(usbatm, "%s: setting interface to %d failed (%d)!\n", __func__, instance->altsetting, ret);
+		goto out_free;
+	}
+
 	/* Enable software buffering, if requested */
 	if (sw_buffering)
 		speedtch_set_swbuff(instance, 1);
@@ -586,11 +594,6 @@
 
 	atm_dbg(usbatm, "%s entered\n", __func__);
 
-	if ((ret = usb_set_interface(usb_dev, 1, altsetting)) < 0) {
-		atm_dbg(usbatm, "%s: usb_set_interface returned %d!\n", __func__, ret);
-		return ret;
-	}
-
 	/* Set MAC address, it is stored in the serial number */
 	memset(atm_dev->esi, 0, sizeof(atm_dev->esi));
 	if (usb_string(usb_dev, usb_dev->descriptor.iSerialNumber, mac_str, sizeof(mac_str)) == 12) {
@@ -725,6 +728,23 @@
 
 	instance->usbatm = usbatm;
 
+	/* altsetting may change at any moment, so take a snapshot */
+	instance->altsetting = altsetting;
+
+	if (instance->altsetting)
+		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->altsetting)) < 0) {
+			usb_err(usbatm, "%s: setting interface to %2d failed (%d)!\n", __func__, instance->altsetting, ret);
+			instance->altsetting = 0; /* fall back to default */
+		}
+
+	if (!instance->altsetting) {
+		if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, DEFAULT_ALTSETTING)) < 0) {
+			usb_err(usbatm, "%s: setting interface to %2d failed (%d)!\n", __func__, DEFAULT_ALTSETTING, ret);
+			goto fail_free;
+		}
+		instance->altsetting = DEFAULT_ALTSETTING;
+	}
+
 	INIT_WORK(&instance->status_checker, (void *)speedtch_check_status, instance);
 
 	instance->status_checker.timer.function = speedtch_status_poll;

--Boundary-00=_nh3xDbFFzB2olkd--
