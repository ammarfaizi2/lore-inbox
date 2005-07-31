Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGaJSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGaJSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVGaJSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:18:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261628AbVGaJRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:17:48 -0400
Date: Sun, 31 Jul 2005 02:16:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050731021628.42e3ab98.akpm@osdl.org>
In-Reply-To: <42EC9410.8080107@roarinelk.homelinux.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<42EC9410.8080107@roarinelk.homelinux.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
>
> something broke the sonypi driver a bit after -mm2:
>  I can no longer set bluetooth-power for instance, and it logs these
>  messages:
> 
>  sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
>  sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
>  sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
> 
>  setting/getting brightness, getting battery/ac status still work.
> 

Can you do a `patch -p1 -R' of the below, see if it fixes it?  It probably
won't.

Also please test 2.6.13-rc4-mm1 which is missing the acpi tree...

Thanks.



From: Dmitry Torokhov <dtor_core@ameritech.net>

Make sure that input_work is not running when unloading the module;
submit/retrieve key release data into/from input_fifo in one shot.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Cc: Stelian Pop <stelian@popies.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/sonypi.c |  122 +++++++++++++++++++++++++-------------------------
 1 files changed, 63 insertions(+), 59 deletions(-)

diff -puN drivers/char/sonypi.c~sonypi-make-sure-that-input_work-is-not-running-when-unloading drivers/char/sonypi.c
--- 25/drivers/char/sonypi.c~sonypi-make-sure-that-input_work-is-not-running-when-unloading	2005-06-03 02:13:08.000000000 -0700
+++ 25-akpm/drivers/char/sonypi.c	2005-06-03 02:13:08.000000000 -0700
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
_

