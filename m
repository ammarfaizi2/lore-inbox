Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289175AbSA1Jxa>; Mon, 28 Jan 2002 04:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSA1JxV>; Mon, 28 Jan 2002 04:53:21 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:43529 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S289175AbSA1JxN>; Mon, 28 Jan 2002 04:53:13 -0500
Date: Mon, 28 Jan 2002 10:52:59 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.18-pre7] sonypi driver update
Message-ID: <20020128095259.GB30456@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

This patch adds support to the sonypi driver for the C1MRX Vaio
model, enabling the capture button / bluetooth button events
to be recognized.

This new version of the driver is also capable to turn on/off
this laptop's bluetooth subsystem (using new ioctls, you will
need the updated user mode tools - spicctrl - from 
http://www.alcove-labs.org/en/software/sonypi/).

Credits for this patch go to Junichi Morita.

Marcelo, please apply.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.18-pre7.orig/drivers/char/sonypi.c linux-2.4.18-pre7/drivers/char/sonypi.c
--- linux-2.4.18-pre7.orig/drivers/char/sonypi.c	Wed Jan 23 16:02:25 2002
+++ linux-2.4.18-pre7/drivers/char/sonypi.c	Wed Jan 23 15:44:13 2002
@@ -290,19 +290,38 @@
 	sonypi_device.camera_power = 1;
 }
 
+/* sets the bluetooth subsystem power state */
+static void sonypi_setbluetoothpower(u8 state) {
+
+	state = (state != 0);
+	if (sonypi_device.bluetooth_power && state) 
+		return;
+	if (!sonypi_device.bluetooth_power && !state) 
+		return;
+	
+	sonypi_call2(0x96, state);
+	sonypi_call1(0x93);
+	sonypi_device.bluetooth_power = state;
+}
+
 /* Interrupt handler: some event is available */
 void sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u8 v1, v2, event = 0;
 	int i;
 	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
+	u8 sonypi_capture_ev, sonypi_bluetooth_ev;
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
 		sonypi_jogger_ev = SONYPI_TYPE2_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE2_FNKEY_EV;
+		sonypi_capture_ev = SONYPI_TYPE2_CAPTURE_EV;
+		sonypi_bluetooth_ev = SONYPI_TYPE2_BLUETOOTH_EV;
 	}
 	else {
 		sonypi_jogger_ev = SONYPI_TYPE1_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE1_FNKEY_EV;
+		sonypi_capture_ev = SONYPI_TYPE1_CAPTURE_EV;
+		sonypi_bluetooth_ev = SONYPI_TYPE1_BLUETOOTH_EV;
 	}
 
 	v1 = inb_p(sonypi_device.ioport1);
@@ -322,7 +341,7 @@
 				goto found;
 			}
 	}
-	if ((v2 & SONYPI_CAPTURE_EV) == SONYPI_CAPTURE_EV) {
+	if ((v2 & sonypi_capture_ev) == sonypi_capture_ev) {
 		for (i = 0; sonypi_captureev[i].event; i++)
 			if (sonypi_captureev[i].data == v1) {
 				event = sonypi_captureev[i].event;
@@ -336,7 +355,7 @@
 				goto found;
 			}
 	}
-	if ((v2 & SONYPI_BLUETOOTH_EV) == SONYPI_BLUETOOTH_EV) {
+	if ((v2 & sonypi_bluetooth_ev) == sonypi_bluetooth_ev) {
 		for (i = 0; sonypi_blueev[i].event; i++)
 			if (sonypi_blueev[i].data == v1) {
 				event = sonypi_blueev[i].event;
@@ -568,6 +587,20 @@
 			goto out;
 		}
 		break;
+	case SONYPI_IOCGBLUE:
+		val8 = sonypi_device.bluetooth_power;
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCSBLUE:
+		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		sonypi_setbluetoothpower(val8);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -602,6 +635,7 @@
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 	sonypi_initq();
 	init_MUTEX(&sonypi_device.lock);
+	sonypi_device.bluetooth_power = 0;
 	
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
diff -uNr --exclude-from=dontdiff linux-2.4.18-pre7.orig/drivers/char/sonypi.h linux-2.4.18-pre7/drivers/char/sonypi.h
--- linux-2.4.18-pre7.orig/drivers/char/sonypi.h	Wed Jan 23 16:02:25 2002
+++ linux-2.4.18-pre7/drivers/char/sonypi.h	Thu Jan 24 10:58:45 2002
@@ -34,8 +34,8 @@
 
 #ifdef __KERNEL__
 
-#define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	9
+#define SONYPI_DRIVER_MAJORVERSION	 1
+#define SONYPI_DRIVER_MINORVERSION	10
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -132,15 +132,17 @@
 #define SONYPI_CAMERA_ROMVERSION 		9
 
 /* key press event data (ioport2) */
-#define SONYPI_TYPE1_JOGGER_EV	0x10
-#define SONYPI_TYPE2_JOGGER_EV	0x08
-#define SONYPI_CAPTURE_EV	0x60
-#define SONYPI_TYPE1_FNKEY_EV	0x20
-#define SONYPI_TYPE2_FNKEY_EV	0x08
-#define SONYPI_BLUETOOTH_EV	0x30
-#define SONYPI_TYPE1_PKEY_EV	0x40
-#define SONYPI_BACK_EV		0x08
-#define SONYPI_LID_EV		0x38
+#define SONYPI_TYPE1_JOGGER_EV		0x10
+#define SONYPI_TYPE2_JOGGER_EV		0x08
+#define SONYPI_TYPE1_CAPTURE_EV		0x60
+#define SONYPI_TYPE2_CAPTURE_EV		0x08
+#define SONYPI_TYPE1_FNKEY_EV		0x20
+#define SONYPI_TYPE2_FNKEY_EV		0x08
+#define SONYPI_TYPE1_BLUETOOTH_EV	0x30
+#define SONYPI_TYPE2_BLUETOOTH_EV	0x08
+#define SONYPI_TYPE1_PKEY_EV		0x40
+#define SONYPI_BACK_EV			0x08
+#define SONYPI_LID_EV			0x38
 
 struct sonypi_event {
 	u8	data;
@@ -203,6 +205,8 @@
 /* The set of possible bluetooth events */
 static struct sonypi_event sonypi_blueev[] = {
 	{ 0x55, SONYPI_EVENT_BLUETOOTH_PRESSED },
+	{ 0x59, SONYPI_EVENT_BLUETOOTH_ON },
+	{ 0x5a, SONYPI_EVENT_BLUETOOTH_OFF },
 	{ 0x00, 0x00 }
 };
 
@@ -241,6 +245,7 @@
 	u16 ioport2;
 	u16 region_size;
 	int camera_power;
+	int bluetooth_power;
 	struct semaphore lock;
 	struct sonypi_queue queue;
 	int open_count;
diff -uNr --exclude-from=dontdiff linux-2.4.18-pre7.orig/include/linux/sonypi.h linux-2.4.18-pre7/include/linux/sonypi.h
--- linux-2.4.18-pre7.orig/include/linux/sonypi.h	Wed Jan 23 16:02:40 2002
+++ linux-2.4.18-pre7/include/linux/sonypi.h	Thu Jan 24 10:58:45 2002
@@ -73,7 +73,8 @@
 #define SONYPI_EVENT_BACK_PRESSED		35
 #define SONYPI_EVENT_LID_CLOSED			36
 #define SONYPI_EVENT_LID_OPENED			37
-
+#define SONYPI_EVENT_BLUETOOTH_ON		38
+#define SONYPI_EVENT_BLUETOOTH_OFF		39
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
@@ -91,6 +92,10 @@
 #define SONYPI_BFLAGS_AC	0x04
 #define SONYPI_IOCGBATFLAGS	_IOR('v', 7, __u8)
 
+/* get/set bluetooth subsystem state on/off */
+#define SONYPI_IOCGBLUE		_IOR('v', 8, __u8)
+#define SONYPI_IOCSBLUE		_IOW('v', 9, __u8)
+
 #ifdef __KERNEL__
 
 /* used only for communication between v4l and sonypi */
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
