Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVGYGjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVGYGjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGYFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:58 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:40351 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261645AbVGYFxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:22 -0400
Message-Id: <20050725054531.480220000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 06/24] sonypi: make sure input_work is not running when unloading
Content-Disposition: inline; filename=sonypi-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonypi: make sure that input_work is not running when unloading
        the module; submit/retrieve key release data into/from
        input_fifo in one shot.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/sonypi.c |  122 +++++++++++++++++++++++++-------------------------
 1 files changed, 63 insertions(+), 59 deletions(-)

Index: work/drivers/char/sonypi.c
===================================================================
--- work.orig/drivers/char/sonypi.c
+++ work/drivers/char/sonypi.c
@@ -439,6 +439,11 @@ static struct {
 	{ 0, 0 },
 };
 
+struct sonypi_keypress {
+	struct input_dev *dev;
+	int key;
+};
+
 static struct sonypi_device {
 	struct pci_dev *dev;
 	struct platform_device *pdev;
@@ -710,22 +715,61 @@ static void sonypi_setbluetoothpower(u8 
 
 static void input_keyrelease(void *data)
 {
-	struct input_dev *input_dev;
-	int key;
-
-	while (1) {
-		if (kfifo_get(sonypi_device.input_fifo,
-			      (unsigned char *)&input_dev,
-			      sizeof(input_dev)) != sizeof(input_dev))
-			return;
-		if (kfifo_get(sonypi_device.input_fifo,
-			      (unsigned char *)&key,
-			      sizeof(key)) != sizeof(key))
-			return;
+	struct sonypi_keypress kp;
 
+	while (kfifo_get(sonypi_device.input_fifo, (unsigned char *)&kp,
+			 sizeof(kp)) == sizeof(kp)) {
 		msleep(10);
-		input_report_key(input_dev, key, 0);
-		input_sync(input_dev);
+		input_report_key(kp.dev, kp.key, 0);
+		input_sync(kp.dev);
+	}
+}
+
+static void sonypi_report_input_event(u8 event)
+{
+	struct input_dev *jog_dev = &sonypi_device.input_jog_dev;
+	struct input_dev *key_dev = &sonypi_device.input_key_dev;
+	struct sonypi_keypress kp = { NULL };
+	int i;
+
+	switch (event) {
+	case SONYPI_EVENT_JOGDIAL_UP:
+	case SONYPI_EVENT_JOGDIAL_UP_PRESSED:
+		input_report_rel(jog_dev, REL_WHEEL, 1);
+		input_sync(jog_dev);
+		break;
+
+	case SONYPI_EVENT_JOGDIAL_DOWN:
+	case SONYPI_EVENT_JOGDIAL_DOWN_PRESSED:
+		input_report_rel(jog_dev, REL_WHEEL, -1);
+		input_sync(jog_dev);
+		break;
+
+	case SONYPI_EVENT_JOGDIAL_PRESSED:
+		kp.key = BTN_MIDDLE;
+		kp.dev = jog_dev;
+		break;
+
+	case SONYPI_EVENT_FNKEY_RELEASED:
+		/* Nothing, not all VAIOs generate this event */
+		break;
+
+	default:
+		for (i = 0; sonypi_inputkeys[i].sonypiev; i++)
+			if (event == sonypi_inputkeys[i].sonypiev) {
+				kp.dev = key_dev;
+				kp.key = sonypi_inputkeys[i].inputev;
+				break;
+			}
+		break;
+	}
+
+	if (kp.dev) {
+		input_report_key(kp.dev, kp.key, 1);
+		input_sync(kp.dev);
+		kfifo_put(sonypi_device.input_fifo,
+			  (unsigned char *)&kp, sizeof(kp));
+		schedule_work(&sonypi_device.input_work);
 	}
 }
 
@@ -768,51 +812,8 @@ found:
 		printk(KERN_INFO
 		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
 
-	if (useinput) {
-		struct input_dev *input_jog_dev = &sonypi_device.input_jog_dev;
-		struct input_dev *input_key_dev = &sonypi_device.input_key_dev;
-		switch (event) {
-		case SONYPI_EVENT_JOGDIAL_UP:
-		case SONYPI_EVENT_JOGDIAL_UP_PRESSED:
-			input_report_rel(input_jog_dev, REL_WHEEL, 1);
-			break;
-		case SONYPI_EVENT_JOGDIAL_DOWN:
-		case SONYPI_EVENT_JOGDIAL_DOWN_PRESSED:
-			input_report_rel(input_jog_dev, REL_WHEEL, -1);
-			break;
-		case SONYPI_EVENT_JOGDIAL_PRESSED: {
-			int key = BTN_MIDDLE;
-			input_report_key(input_jog_dev, key, 1);
-			kfifo_put(sonypi_device.input_fifo,
-				  (unsigned char *)&input_jog_dev,
-				  sizeof(input_jog_dev));
-			kfifo_put(sonypi_device.input_fifo,
-				  (unsigned char *)&key, sizeof(key));
-			break;
-		}
-		case SONYPI_EVENT_FNKEY_RELEASED:
-			/* Nothing, not all VAIOs generate this event */
-			break;
-		}
-		input_sync(input_jog_dev);
-
-		for (i = 0; sonypi_inputkeys[i].sonypiev; i++) {
-			int key;
-
-			if (event != sonypi_inputkeys[i].sonypiev)
-				continue;
-
-			key = sonypi_inputkeys[i].inputev;
-			input_report_key(input_key_dev, key, 1);
-			kfifo_put(sonypi_device.input_fifo,
-				  (unsigned char *)&input_key_dev,
-				  sizeof(input_key_dev));
-			kfifo_put(sonypi_device.input_fifo,
-				  (unsigned char *)&key, sizeof(key));
-		}
-		input_sync(input_key_dev);
-		schedule_work(&sonypi_device.input_work);
-	}
+	if (useinput)
+		sonypi_report_input_event(event);
 
 	kfifo_put(sonypi_device.fifo, (unsigned char *)&event, sizeof(event));
 	kill_fasync(&sonypi_device.fifo_async, SIGIO, POLL_IN);
@@ -1337,6 +1338,9 @@ static void __devexit sonypi_remove(void
 {
 	sonypi_disable();
 
+	synchronize_sched();  /* Allow sonypi interrupt to complete. */
+	flush_scheduled_work();
+
 	platform_device_unregister(sonypi_device.pdev);
 
 	if (useinput) {

