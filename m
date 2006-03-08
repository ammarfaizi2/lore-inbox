Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWCHWqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCHWqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWCHWqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:46:07 -0500
Received: from mail.gmx.de ([213.165.64.20]:23194 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932224AbWCHWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:46:06 -0500
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Lanslott Gish <lanslott.gish@gmail.com>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Date: Wed, 8 Mar 2006 23:46:36 +0100
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-usb" <linux-usb-devel@lists.sourceforge.net>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603082346.37479.daniel.ritz@gmx.ch>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what about merging with the existing driver?

something like this? it's compile tested only. not even tested
on an egalax screen since i don't have it around...
if this is ok, we could also merge itmtouch and mtouchusb into a
single driver.

rgds
-daniel

---

diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 5246b35..e1caeb5 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -224,12 +224,13 @@ config USB_ITMTOUCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called itmtouch.
 
-config USB_EGALAX
-	tristate "eGalax TouchKit USB Touchscreen Driver"
+config USB_TOUCHKIT
+	tristate "TouchKit USB Touchscreen Driver"
 	depends on USB && INPUT
 	---help---
-	  Say Y here if you want to use a eGalax TouchKit USB
-	  Touchscreen controller.
+	  USB Touchscreen driver for:
+	  - eGalax Touchkit USB
+	  - PanJit TouchSet USB
 
 	  The driver has been tested on a Xenarc 700TSV monitor
 	  with eGalax touchscreen.
@@ -240,6 +241,16 @@ config USB_EGALAX
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchkitusb.
 
+config USB_TOUCHKIT_EGALAX
+	default y
+	bool "eGalax device support" if EMBEDDED
+	depends on USB_TOUCHKIT
+
+config USB_TOUCHKIT_PANJIT
+	default y
+	bool "PanJit device support" if EMBEDDED
+	depends on USB_TOUCHKIT
+
 config USB_YEALINK
 	tristate "Yealink usb-p1k voip phone"
 	depends on USB && INPUT && EXPERIMENTAL
diff --git a/drivers/usb/input/Makefile b/drivers/usb/input/Makefile
index d512d9f..c630ac9 100644
--- a/drivers/usb/input/Makefile
+++ b/drivers/usb/input/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_USB_KEYSPAN_REMOTE)	+= keys
 obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o
 obj-$(CONFIG_USB_MTOUCH)	+= mtouchusb.o
 obj-$(CONFIG_USB_ITMTOUCH)	+= itmtouch.o
-obj-$(CONFIG_USB_EGALAX)	+= touchkitusb.o
+obj-$(CONFIG_USB_TOUCHKIT)	+= touchkitusb.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_ACECAD)	+= acecad.o
diff --git a/drivers/usb/input/touchkitusb.c b/drivers/usb/input/touchkitusb.c
index 697c5e5..523cf1e 100644
--- a/drivers/usb/input/touchkitusb.c
+++ b/drivers/usb/input/touchkitusb.c
@@ -33,23 +33,8 @@
 #include <linux/usb.h>
 #include <linux/usb_input.h>
 
-#define TOUCHKIT_MIN_XC			0x0
-#define TOUCHKIT_MAX_XC			0x07ff
-#define TOUCHKIT_XC_FUZZ		0x0
-#define TOUCHKIT_XC_FLAT		0x0
-#define TOUCHKIT_MIN_YC			0x0
-#define TOUCHKIT_MAX_YC			0x07ff
-#define TOUCHKIT_YC_FUZZ		0x0
-#define TOUCHKIT_YC_FLAT		0x0
-#define TOUCHKIT_REPORT_DATA_SIZE	16
-
-#define TOUCHKIT_DOWN			0x01
-
-#define TOUCHKIT_PKT_TYPE_MASK		0xFE
-#define TOUCHKIT_PKT_TYPE_REPT		0x80
-#define TOUCHKIT_PKT_TYPE_DIAG		0x0A
 
-#define DRIVER_VERSION			"v0.1"
+#define DRIVER_VERSION			"v0.3"
 #define DRIVER_AUTHOR			"Daniel Ritz <daniel.ritz@gmx.ch>"
 #define DRIVER_DESC			"eGalax TouchKit USB HID Touchscreen Driver"
 
@@ -57,6 +42,29 @@ static int swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
 
+
+struct touchkit_usb;
+struct touchkit_device_info {
+	int min_xc, max_xc;
+	int min_yc, max_yc;
+
+	void (*process_pkt) (struct touchkit_usb *touchkit, struct pt_regs *regs, char *pkt, int len);
+	int  (*read_data)   (char *pkt, int *x, int *y, int *touch);
+
+};
+
+/* eGalax specific part */
+#define EGALAX_DOWN			0x01
+#define EGALAX_PKT_TYPE_MASK		0xFE
+#define EGALAX_PKT_TYPE_REPT		0x80
+#define EGALAX_PKT_TYPE_DIAG		0x0A
+
+/* PanJit specific part */
+#define PANJIT_DOWN			0x01
+
+
+/* a touchkit device */
+#define TOUCHKIT_REPORT_DATA_SIZE	16
 struct touchkit_usb {
 	unsigned char *data;
 	dma_addr_t data_dma;
@@ -65,76 +73,106 @@ struct touchkit_usb {
 	struct urb *irq;
 	struct usb_device *udev;
 	struct input_dev *input;
+	struct touchkit_device_info *type;
 	char name[128];
 	char phys[64];
 };
 
+
+enum {
+	DEVTPYE_DUMMY = -1,
+	DEVTYPE_EGALAX,
+	DEVTYPE_PANJIT,
+};
+
 static struct usb_device_id touchkit_devices[] = {
-	{USB_DEVICE(0x3823, 0x0001)},
-	{USB_DEVICE(0x0123, 0x0001)},
-	{USB_DEVICE(0x0eef, 0x0001)},
-	{USB_DEVICE(0x0eef, 0x0002)},
+#ifdef CONFIG_USB_TOUCHKIT_EGALAX
+	/* eGalax devices */
+	{USB_DEVICE(0x3823, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0123, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0eef, 0x0001), .driver_info = DEVTYPE_EGALAX},
+	{USB_DEVICE(0x0eef, 0x0002), .driver_info = DEVTYPE_EGALAX},
+#endif
+
+#ifdef CONFIG_USB_TOUCHKIT_PANJIT
+	/* PanJit devices */
+	{USB_DEVICE(0x134c, 0x0001), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0002), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0003), .driver_info = DEVTYPE_PANJIT},
+	{USB_DEVICE(0x134c, 0x0004), .driver_info = DEVTYPE_PANJIT},
+#endif
+
 	{}
 };
 
-/* helpers to read the data */
-static inline int touchkit_get_touched(char *data)
-{
-	return (data[0] & TOUCHKIT_DOWN) ? 1 : 0;
-}
+/* data readers */
 
-static inline int touchkit_get_x(char *data)
+#ifdef CONFIG_USB_TOUCHKIT_EGALAX
+static int egalax_read_data(char *pkt, int *x, int *y, int *touch)
 {
-	return ((data[3] & 0x0F) << 7) | (data[4] & 0x7F);
+	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) != EGALAX_PKT_TYPE_REPT)
+		return 0;
+
+	*x = ((pkt[3] & 0x0F) << 7) | (pkt[4] & 0x7F);
+	*y = ((pkt[1] & 0x0F) << 7) | (pkt[2] & 0x7F);
+	*touch = (pkt[0] & EGALAX_DOWN) ? 1 : 0;
+
+	return 1;
+
 }
+#endif
 
-static inline int touchkit_get_y(char *data)
+#ifdef CONFIG_USB_TOUCHKIT_PANJIT
+static int panjit_read_data(char *pkt, int *x, int *y, int *touch)
 {
-	return ((data[1] & 0x0F) << 7) | (data[2] & 0x7F);
-}
+	*x = pkt[1] | (pkt[2] << 8);
+	*y = pkt[3] | (pkt[4] << 8);
+	*touch = (pkt[0] & EGALAX_DOWN) ? 1 : 0;
 
+	return 1;
+}
+#endif
 
-/* processes one input packet. */
+/* processes one input packet. generic */
 static void touchkit_process_pkt(struct touchkit_usb *touchkit,
-                                 struct pt_regs *regs, char *pkt)
+                                 struct pt_regs *regs, char *pkt, int len)
 {
-	int x, y;
+	int x, y, touch;
 
-	/* only process report packets */
-	if ((pkt[0] & TOUCHKIT_PKT_TYPE_MASK) != TOUCHKIT_PKT_TYPE_REPT)
-		return;
+	if (!touchkit->type->read_data(pkt, &x, &y, &touch))
+			return;
+
+	input_regs(touchkit->input, regs);
+	input_report_key(touchkit->input, BTN_TOUCH, touch);
 
 	if (swap_xy) {
-		y = touchkit_get_x(pkt);
-		x = touchkit_get_y(pkt);
+		input_report_abs(touchkit->input, ABS_X, y);
+		input_report_abs(touchkit->input, ABS_Y, x);
 	} else {
-		x = touchkit_get_x(pkt);
-		y = touchkit_get_y(pkt);
+		input_report_abs(touchkit->input, ABS_X, x);
+		input_report_abs(touchkit->input, ABS_Y, y);
 	}
-
-	input_regs(touchkit->input, regs);
-	input_report_key(touchkit->input, BTN_TOUCH, touchkit_get_touched(pkt));
-	input_report_abs(touchkit->input, ABS_X, x);
-	input_report_abs(touchkit->input, ABS_Y, y);
 	input_sync(touchkit->input);
 }
 
 
-static int touchkit_get_pkt_len(char *buf)
+#ifdef CONFIG_USB_TOUCHKIT_EGALAX
+/* eGalax specific packet processing */
+static int egalax_get_pkt_len(char *buf)
 {
-	switch (buf[0] & TOUCHKIT_PKT_TYPE_MASK) {
-	case TOUCHKIT_PKT_TYPE_REPT:
+	switch (buf[0] & EGALAX_PKT_TYPE_MASK) {
+	case EGALAX_PKT_TYPE_REPT:
 		return 5;
 
-	case TOUCHKIT_PKT_TYPE_DIAG:
+	case EGALAX_PKT_TYPE_DIAG:
 		return buf[1] + 2;
 	}
 
 	return 0;
 }
 
-static void touchkit_process(struct touchkit_usb *touchkit, int len,
-                             struct pt_regs *regs)
+static void egalax_process(struct touchkit_usb *touchkit,
+                           struct pt_regs *regs, char *pkt, int len)
 {
 	char *buffer;
 	int pkt_len, buf_len, pos;
@@ -145,9 +183,9 @@ static void touchkit_process(struct touc
 
 		/* if only 1 byte in buffer, add another one to get length */
 		if (touchkit->buf_len == 1)
-			touchkit->buffer[1] = touchkit->data[0];
+			touchkit->buffer[1] = pkt[0];
 
-		pkt_len = touchkit_get_pkt_len(touchkit->buffer);
+		pkt_len = egalax_get_pkt_len(touchkit->buffer);
 
 		/* unknown packet: drop everything */
 		if (!pkt_len)
@@ -155,13 +193,13 @@ static void touchkit_process(struct touc
 
 		/* append, process */
 		tmp = pkt_len - touchkit->buf_len;
-		memcpy(touchkit->buffer + touchkit->buf_len, touchkit->data, tmp);
-		touchkit_process_pkt(touchkit, regs, touchkit->buffer);
+		memcpy(touchkit->buffer + touchkit->buf_len, pkt, tmp);
+		touchkit_process_pkt(touchkit, regs, touchkit->buffer, pkt_len);
 
-		buffer = touchkit->data + tmp;
+		buffer = pkt + tmp;
 		buf_len = len - tmp;
 	} else {
-		buffer = touchkit->data;
+		buffer = pkt;
 		buf_len = len;
 	}
 
@@ -176,7 +214,7 @@ static void touchkit_process(struct touc
 	pos = 0;
 	while (pos < buf_len) {
 		/* get packet len */
-		pkt_len = touchkit_get_pkt_len(buffer + pos);
+		pkt_len = egalax_get_pkt_len(buffer + pos);
 
 		/* unknown packet: drop everything */
 		if (unlikely(!pkt_len))
@@ -184,7 +222,7 @@ static void touchkit_process(struct touc
 
 		/* full packet: process */
 		if (likely(pkt_len <= buf_len)) {
-			touchkit_process_pkt(touchkit, regs, buffer + pos);
+			touchkit_process_pkt(touchkit, regs, buffer + pos, pkt_len);
 		} else {
 			/* incomplete packet: save in buffer */
 			memcpy(touchkit->buffer, buffer + pos, buf_len - pos);
@@ -193,6 +231,7 @@ static void touchkit_process(struct touc
 		pos += pkt_len;
 	}
 }
+#endif
 
 
 static void touchkit_irq(struct urb *urb, struct pt_regs *regs)
@@ -222,7 +261,7 @@ static void touchkit_irq(struct urb *urb
 		goto exit;
 	}
 
-	touchkit_process(touchkit, urb->actual_length, regs);
+	touchkit->type->process_pkt(touchkit, regs, touchkit->data, urb->actual_length);
 
 exit:
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
@@ -237,7 +276,7 @@ static int touchkit_open(struct input_de
 
 	touchkit->irq->dev = touchkit->udev;
 
-	if (usb_submit_urb(touchkit->irq, GFP_ATOMIC))
+	if (usb_submit_urb(touchkit->irq, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
@@ -254,7 +293,7 @@ static int touchkit_alloc_buffers(struct
 				  struct touchkit_usb *touchkit)
 {
 	touchkit->data = usb_buffer_alloc(udev, TOUCHKIT_REPORT_DATA_SIZE,
-	                                  SLAB_ATOMIC, &touchkit->data_dma);
+	                                  SLAB_KERNEL, &touchkit->data_dma);
 
 	if (!touchkit->data)
 		return -1;
@@ -270,6 +309,35 @@ static void touchkit_free_buffers(struct
 		                touchkit->data, touchkit->data_dma);
 }
 
+
+/* the different device descriptors */
+static struct touchkit_device_info touchkit_dev_info[] = {
+#ifdef CONFIG_USB_TOUCHKIT_EGALAX
+	[DEVTYPE_EGALAX] = {
+		.min_xc	= 0x0,
+		.max_xc = 0x07ff,
+		.min_yc = 0x0,
+		.max_yc = 0x07ff,
+
+		.process_pkt = egalax_process,
+		.read_data   = egalax_read_data,
+	},
+#endif
+
+#ifdef CONFIG_USB_TOUCHKIT_PANJIT
+	[DEVTYPE_PANJIT] = {
+		.min_xc	= 0x0,
+		.max_xc = 0x0fff,
+		.min_yc = 0x0,
+		.max_yc = 0x0fff,
+
+		.process_pkt = touchkit_process_pkt,
+		.read_data   = panjit_read_data,
+	},
+#endif
+};
+
+
 static int touchkit_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
@@ -298,6 +366,7 @@ static int touchkit_probe(struct usb_int
 
 	touchkit->udev = udev;
 	touchkit->input = input_dev;
+	touchkit->type = &touchkit_dev_info[id->driver_info];
 
 	if (udev->manufacturer)
 		strlcpy(touchkit->name, udev->manufacturer, sizeof(touchkit->name));
@@ -327,10 +396,8 @@ static int touchkit_probe(struct usb_int
 
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(input_dev, ABS_X, TOUCHKIT_MIN_XC, TOUCHKIT_MAX_XC,
-				TOUCHKIT_XC_FUZZ, TOUCHKIT_XC_FLAT);
-	input_set_abs_params(input_dev, ABS_Y, TOUCHKIT_MIN_YC, TOUCHKIT_MAX_YC,
-				TOUCHKIT_YC_FUZZ, TOUCHKIT_YC_FLAT);
+	input_set_abs_params(input_dev, ABS_X, touchkit->type->min_xc, touchkit->type->max_xc, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, touchkit->type->min_yc, touchkit->type->max_yc, 0, 0);
 
 	usb_fill_int_urb(touchkit->irq, touchkit->udev,
 			 usb_rcvintpipe(touchkit->udev, 0x81),
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 07a012f..2155513 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1460,6 +1460,12 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_DEVICE_ID_HP_USBHUB_KB	0x020c
 
+#define USB_VENDOR_ID_TOUCHSET		0x134c
+#define USB_DEVICE_ID_TOUCHSET_INITIAL	0x0001
+#define USB_DEVICE_ID_TOUCHSET_JUNIOR	0x0002
+#define USB_DEVICE_ID_TOUCHSET_TRIAD	0x0003
+#define USB_DEVICE_ID_TOUCHSET_QUATA	0x0004
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1605,6 +1611,11 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_INITIAL, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_JUNIOR, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_TRIAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOUCHSET, USB_DEVICE_ID_TOUCHSET_QUATA, HID_QUIRK_BADPAD },
+
 	{ 0, 0 }
 };
 

