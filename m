Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbUJ1KRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbUJ1KRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUJ1KPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:15:25 -0400
Received: from sd291.sivit.org ([194.146.225.122]:42390 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262889AbUJ1KG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:06:59 -0400
Date: Thu, 28 Oct 2004 12:08:24 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 4/8] sonypi: rework input support
Message-ID: <20041028100823.GE3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2194, 2004-10-27 17:32:21+02:00, stelian@popies.net
  sonypi: rework input support
  	* feed most of special keys through the input subsystem
  	* initialize two separate input devices: a mouse like one for
  	  the jogdial and a keyboard like one for the special keys
  	* add support for SONYPI_EVENT_FNKEY_RELEASED

  Many people participated in a way or another to this patch, 
  including Daniel K. <daniel@cluded.net>, Bastien Nocera <hadess@hadess.net>,
  Dmitry Torokhov <dtor@mail.ru> and Vojtech Pavlik <vojtech@suse.cz>.

  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 drivers/char/sonypi.c  |  169 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/char/sonypi.h  |   62 +++++++++++++----
 include/linux/input.h  |   22 ++++++
 include/linux/sonypi.h |    1 
 4 files changed, 205 insertions(+), 49 deletions(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:06:42 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:06:42 +02:00
@@ -309,6 +309,27 @@
 	sonypi_device.bluetooth_power = state;
 }
 
+static void input_keyrelease(void *data)
+{
+	struct input_dev *input_dev;
+	int key;
+
+	while (1) {
+		if (kfifo_get(sonypi_device.input_fifo,
+			      (unsigned char *)&input_dev,
+			      sizeof(input_dev)) != sizeof(input_dev))
+			return;
+		if (kfifo_get(sonypi_device.input_fifo,
+			      (unsigned char *)&key,
+			      sizeof(key)) != sizeof(key))
+			return;
+
+		msleep(10);
+		input_report_key(input_dev, key, 0);
+		input_sync(input_dev);
+	}
+}
+
 /* Interrupt handler: some event is available */
 static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u8 v1, v2, event = 0;
@@ -345,22 +366,51 @@
 		printk(KERN_INFO 
 		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
 
-#ifdef SONYPI_USE_INPUT
 	if (useinput) {
-		struct input_dev *jog_dev = &sonypi_device.jog_dev;
-		if (event == SONYPI_EVENT_JOGDIAL_PRESSED)
-			input_report_key(jog_dev, BTN_MIDDLE, 1);
-		else if (event == SONYPI_EVENT_ANYBUTTON_RELEASED)
-			input_report_key(jog_dev, BTN_MIDDLE, 0);
-		else if ((event == SONYPI_EVENT_JOGDIAL_UP) ||
-			 (event == SONYPI_EVENT_JOGDIAL_UP_PRESSED))
-			input_report_rel(jog_dev, REL_WHEEL, 1);
-		else if ((event == SONYPI_EVENT_JOGDIAL_DOWN) ||
-			 (event == SONYPI_EVENT_JOGDIAL_DOWN_PRESSED))
-			input_report_rel(jog_dev, REL_WHEEL, -1);
-		input_sync(jog_dev);
+		struct input_dev *input_jog_dev = &sonypi_device.input_jog_dev;
+		struct input_dev *input_key_dev = &sonypi_device.input_key_dev;
+		switch (event) {
+		case SONYPI_EVENT_JOGDIAL_UP:
+		case SONYPI_EVENT_JOGDIAL_UP_PRESSED:
+			input_report_rel(input_jog_dev, REL_WHEEL, 1);
+			break;
+		case SONYPI_EVENT_JOGDIAL_DOWN:
+		case SONYPI_EVENT_JOGDIAL_DOWN_PRESSED:
+			input_report_rel(input_jog_dev, REL_WHEEL, -1);
+			break;
+		case SONYPI_EVENT_JOGDIAL_PRESSED: {
+			int key = BTN_MIDDLE;
+			input_report_key(input_jog_dev, key, 1);
+			kfifo_put(sonypi_device.input_fifo,
+				  (unsigned char *)&input_jog_dev,
+				  sizeof(input_jog_dev));
+			kfifo_put(sonypi_device.input_fifo,
+				  (unsigned char *)&key, sizeof(key));
+			break;
+		}
+		case SONYPI_EVENT_FNKEY_RELEASED:
+			/* Nothing, not all VAIOs generate this event */
+			break;
+		}
+		input_sync(input_jog_dev);
+
+		for (i = 0; sonypi_inputkeys[i].sonypiev; i++) {
+			int key;
+
+			if (event != sonypi_inputkeys[i].sonypiev)
+				continue;
+
+			key = sonypi_inputkeys[i].inputev;
+			input_report_key(input_key_dev, key, 1);
+			kfifo_put(sonypi_device.input_fifo,
+				  (unsigned char *)&input_key_dev,
+				  sizeof(input_key_dev));
+			kfifo_put(sonypi_device.input_fifo,
+				  (unsigned char *)&key, sizeof(key));
+		}
+		input_sync(input_key_dev);
+		schedule_work(&sonypi_device.input_work);
 	}
-#endif /* SONYPI_USE_INPUT */
 
 	kfifo_put(sonypi_device.fifo, (unsigned char *)&event, sizeof(event));
 	kill_fasync(&sonypi_device.fifo_async, SIGIO, POLL_IN);
@@ -764,6 +814,62 @@
 		goto out3;
 	}
 
+	if (useinput) {
+		/* Initialize the Input Drivers: jogdial */
+		int i;
+		sonypi_device.input_jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		sonypi_device.input_jog_dev.keybit[LONG(BTN_MOUSE)] =
+			BIT(BTN_MIDDLE);
+		sonypi_device.input_jog_dev.relbit[0] = BIT(REL_WHEEL);
+		sonypi_device.input_jog_dev.name =
+			(char *) kmalloc(sizeof(SONYPI_JOG_INPUTNAME), GFP_KERNEL);
+		if (!sonypi_device.input_jog_dev.name) {
+			printk(KERN_ERR "sonypi: kmalloc failed\n");
+			ret = -ENOMEM;
+			goto out_inkmallocinput1;
+		}
+		sprintf(sonypi_device.input_jog_dev.name, SONYPI_JOG_INPUTNAME);
+		sonypi_device.input_jog_dev.id.bustype = BUS_ISA;
+		sonypi_device.input_jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
+
+		input_register_device(&sonypi_device.input_jog_dev);
+		printk(KERN_INFO "%s input method installed.\n",
+		       sonypi_device.input_jog_dev.name);
+
+		/* Initialize the Input Drivers: special keys */
+		sonypi_device.input_key_dev.evbit[0] = BIT(EV_KEY);
+		for (i = 0; sonypi_inputkeys[i].sonypiev; i++)
+			if (sonypi_inputkeys[i].inputev)
+				set_bit(sonypi_inputkeys[i].inputev,
+					sonypi_device.input_key_dev.keybit);
+		sonypi_device.input_key_dev.name =
+			(char *) kmalloc(sizeof(SONYPI_KEY_INPUTNAME), GFP_KERNEL);
+		if (!sonypi_device.input_key_dev.name) {
+			printk(KERN_ERR "sonypi: kmalloc failed\n");
+			ret = -ENOMEM;
+			goto out_inkmallocinput2;
+		}
+		sprintf(sonypi_device.input_key_dev.name, SONYPI_KEY_INPUTNAME);
+		sonypi_device.input_key_dev.id.bustype = BUS_ISA;
+		sonypi_device.input_key_dev.id.vendor = PCI_VENDOR_ID_SONY;
+
+		input_register_device(&sonypi_device.input_key_dev);
+		printk(KERN_INFO "%s input method installed.\n",
+		       sonypi_device.input_key_dev.name);
+
+		sonypi_device.input_fifo_lock = SPIN_LOCK_UNLOCKED;
+		sonypi_device.input_fifo =
+			kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
+				    &sonypi_device.input_fifo_lock);
+		if (IS_ERR(sonypi_device.input_fifo)) {
+			printk(KERN_ERR "sonypi: kfifo_alloc failed\n");
+			ret = PTR_ERR(sonypi_device.input_fifo);
+			goto out_infifo;
+		}
+
+		INIT_WORK(&sonypi_device.input_work, input_keyrelease, NULL);
+	}
+
 	sonypi_device.pdev = platform_device_register_simple("sonypi", -1,
 							     NULL, 0);
 	if (IS_ERR(sonypi_device.pdev)) {
@@ -795,26 +901,18 @@
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
 
-#ifdef SONYPI_USE_INPUT
-	if (useinput) {
-		/* Initialize the Input Drivers: */
-		sonypi_device.jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-		sonypi_device.jog_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_MIDDLE);
-		sonypi_device.jog_dev.relbit[0] = BIT(REL_WHEEL);
-		sonypi_device.jog_dev.name = (char *) kmalloc(
-			sizeof(SONYPI_INPUTNAME), GFP_KERNEL);
-		sprintf(sonypi_device.jog_dev.name, SONYPI_INPUTNAME);
-		sonypi_device.jog_dev.id.bustype = BUS_ISA;
-		sonypi_device.jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
-	  
-		input_register_device(&sonypi_device.jog_dev);
-		printk(KERN_INFO "%s installed.\n", sonypi_device.jog_dev.name);
-	}
-#endif /* SONYPI_USE_INPUT */
-
 	return 0;
 
 out_platformdev:
+	kfifo_free(sonypi_device.input_fifo);
+out_infifo:
+	input_unregister_device(&sonypi_device.input_key_dev);
+	kfree(sonypi_device.input_key_dev.name);
+out_inkmallocinput2:
+	input_unregister_device(&sonypi_device.input_jog_dev);
+	kfree(sonypi_device.input_jog_dev.name);
+out_inkmallocinput1:
+	free_irq(sonypi_device.irq, sonypi_irq);
 out3:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 out2:
@@ -832,12 +930,13 @@
 
 	platform_device_unregister(sonypi_device.pdev);
 
-#ifdef SONYPI_USE_INPUT
 	if (useinput) {
-		input_unregister_device(&sonypi_device.jog_dev);
-		kfree(sonypi_device.jog_dev.name);
+		input_unregister_device(&sonypi_device.input_key_dev);
+		kfree(sonypi_device.input_key_dev.name);
+		input_unregister_device(&sonypi_device.input_jog_dev);
+		kfree(sonypi_device.input_jog_dev.name);
+		kfifo_free(sonypi_device.input_fifo);
 	}
-#endif /* SONYPI_USE_INPUT */
 
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:06:42 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:06:42 +02:00
@@ -222,6 +222,7 @@
 	{ 0x1a, SONYPI_EVENT_FNKEY_F10 },
 	{ 0x1b, SONYPI_EVENT_FNKEY_F11 },
 	{ 0x1c, SONYPI_EVENT_FNKEY_F12 },
+	{ 0x1f, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x21, SONYPI_EVENT_FNKEY_1 },
 	{ 0x22, SONYPI_EVENT_FNKEY_2 },
 	{ 0x31, SONYPI_EVENT_FNKEY_D },
@@ -340,17 +341,48 @@
 
 #define SONYPI_BUF_SIZE	128
 
-/* We enable input subsystem event forwarding if the input 
- * subsystem is compiled in, but only if sonypi is not into the
- * kernel and input as a module... */
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
-#if ! (defined(CONFIG_SONYPI) && defined(CONFIG_INPUT_MODULE))
-#define SONYPI_USE_INPUT
-#endif
-#endif
-
-/* The name of the Jog Dial for the input device drivers */
-#define SONYPI_INPUTNAME	"Sony VAIO Jog Dial"
+/* The name of the devices for the input device drivers */
+#define SONYPI_JOG_INPUTNAME	"Sony Vaio Jogdial"
+#define SONYPI_KEY_INPUTNAME	"Sony Vaio Keys"
+
+/* Correspondance table between sonypi events and input layer events */
+struct {
+	int sonypiev;
+	int inputev;
+} sonypi_inputkeys[] = {
+	{ SONYPI_EVENT_CAPTURE_PRESSED,	 	KEY_CAMERA },
+	{ SONYPI_EVENT_FNKEY_ONLY, 		KEY_FN },
+	{ SONYPI_EVENT_FNKEY_ESC, 		KEY_FN_ESC },
+	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
+	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
+	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
+	{ SONYPI_EVENT_FNKEY_F4, 		KEY_FN_F4 },
+	{ SONYPI_EVENT_FNKEY_F5, 		KEY_FN_F5 },
+	{ SONYPI_EVENT_FNKEY_F6, 		KEY_FN_F6 },
+	{ SONYPI_EVENT_FNKEY_F7, 		KEY_FN_F7 },
+	{ SONYPI_EVENT_FNKEY_F8, 		KEY_FN_F8 },
+	{ SONYPI_EVENT_FNKEY_F9,		KEY_FN_F9 },
+	{ SONYPI_EVENT_FNKEY_F10,		KEY_FN_F10 },
+	{ SONYPI_EVENT_FNKEY_F11, 		KEY_FN_F11 },
+	{ SONYPI_EVENT_FNKEY_F12,		KEY_FN_F12 },
+	{ SONYPI_EVENT_FNKEY_1, 		KEY_FN_1 },
+	{ SONYPI_EVENT_FNKEY_2, 		KEY_FN_2 },
+	{ SONYPI_EVENT_FNKEY_D,			KEY_FN_D },
+	{ SONYPI_EVENT_FNKEY_E,			KEY_FN_E },
+	{ SONYPI_EVENT_FNKEY_F,			KEY_FN_F },
+	{ SONYPI_EVENT_FNKEY_S,			KEY_FN_S },
+	{ SONYPI_EVENT_FNKEY_B,			KEY_FN_B },
+	{ SONYPI_EVENT_BLUETOOTH_PRESSED, 	KEY_BLUE },
+	{ SONYPI_EVENT_BLUETOOTH_ON, 		KEY_BLUE },
+	{ SONYPI_EVENT_PKEY_P1, 		KEY_PROG1 },
+	{ SONYPI_EVENT_PKEY_P2, 		KEY_PROG2 },
+	{ SONYPI_EVENT_PKEY_P3, 		KEY_PROG3 },
+	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
+	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
+	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
+	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
+	{ 0, 0 },
+};
 
 struct sonypi_device {
 	struct pci_dev *dev;
@@ -370,9 +402,11 @@
 	struct fasync_struct *fifo_async;
 	int open_count;
 	int model;
-#ifdef SONYPI_USE_INPUT
-	struct input_dev jog_dev;
-#endif
+	struct input_dev input_jog_dev;
+	struct input_dev input_key_dev;
+	struct work_struct input_work;
+	struct kfifo *input_fifo;
+	spinlock_t input_fifo_lock;
 };
 
 #define ITERATIONS_LONG		10000
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2004-10-28 11:06:42 +02:00
+++ b/include/linux/input.h	2004-10-28 11:06:42 +02:00
@@ -473,6 +473,28 @@
 #define KEY_INS_LINE		0x1c2
 #define KEY_DEL_LINE		0x1c3
 
+#define KEY_FN			0x1d0
+#define KEY_FN_ESC		0x1d1
+#define KEY_FN_F1		0x1d2
+#define KEY_FN_F2		0x1d3
+#define KEY_FN_F3		0x1d4
+#define KEY_FN_F4		0x1d5
+#define KEY_FN_F5		0x1d6
+#define KEY_FN_F6		0x1d7
+#define KEY_FN_F7		0x1d8
+#define KEY_FN_F8		0x1d9
+#define KEY_FN_F9		0x1da
+#define KEY_FN_F10		0x1db
+#define KEY_FN_F11		0x1dc
+#define KEY_FN_F12		0x1dd
+#define KEY_FN_1		0x1de
+#define KEY_FN_2		0x1df
+#define KEY_FN_D		0x1e0
+#define KEY_FN_E		0x1e1
+#define KEY_FN_F		0x1e2
+#define KEY_FN_S		0x1e3
+#define KEY_FN_B		0x1e4
+
 #define KEY_MAX			0x1ff
 
 /*
diff -Nru a/include/linux/sonypi.h b/include/linux/sonypi.h
--- a/include/linux/sonypi.h	2004-10-28 11:06:42 +02:00
+++ b/include/linux/sonypi.h	2004-10-28 11:06:42 +02:00
@@ -96,6 +96,7 @@
 #define SONYPI_EVENT_ANYBUTTON_RELEASED		56
 #define SONYPI_EVENT_BATTERY_INSERT		57
 #define SONYPI_EVENT_BATTERY_REMOVE		58
+#define SONYPI_EVENT_FNKEY_RELEASED		59
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
