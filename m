Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVJ1GcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVJ1GcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVJ1GcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:32:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:41194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965139AbVJ1GbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:22 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: convert sonypi to dynamic input_dev allocation
In-Reply-To: <11304810242681@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:24 -0700
Message-Id: <11304810243087@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: convert sonypi to dynamic input_dev allocation

Input: convert sonypi to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 218e51d8b7c75a09e156696c037e6e3383a7808b
tree 5ac0471cac3b7fe7214d5d94d1017b9be81c0416
parent a7827f4a9186387c432f3c802ea6330396d83eb9
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:50 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:04 -0700

 drivers/char/sonypi.c |   92 ++++++++++++++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 36ae9ad..a487368 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -424,10 +424,6 @@ static struct sonypi_eventtypes {
 
 #define SONYPI_BUF_SIZE	128
 
-/* The name of the devices for the input device drivers */
-#define SONYPI_JOG_INPUTNAME	"Sony Vaio Jogdial"
-#define SONYPI_KEY_INPUTNAME	"Sony Vaio Keys"
-
 /* Correspondance table between sonypi events and input layer events */
 static struct {
 	int sonypiev;
@@ -490,8 +486,8 @@ static struct sonypi_device {
 	struct fasync_struct *fifo_async;
 	int open_count;
 	int model;
-	struct input_dev input_jog_dev;
-	struct input_dev input_key_dev;
+	struct input_dev *input_jog_dev;
+	struct input_dev *input_key_dev;
 	struct work_struct input_work;
 	struct kfifo *input_fifo;
 	spinlock_t input_fifo_lock;
@@ -779,8 +775,8 @@ static void input_keyrelease(void *data)
 
 static void sonypi_report_input_event(u8 event)
 {
-	struct input_dev *jog_dev = &sonypi_device.input_jog_dev;
-	struct input_dev *key_dev = &sonypi_device.input_key_dev;
+	struct input_dev *jog_dev = sonypi_device.input_jog_dev;
+	struct input_dev *key_dev = sonypi_device.input_key_dev;
 	struct sonypi_keypress kp = { NULL };
 	int i;
 
@@ -1203,6 +1199,47 @@ static struct device_driver sonypi_drive
 	.shutdown	= sonypi_shutdown,
 };
 
+static int __devinit sonypi_create_input_devices(void)
+{
+	struct input_dev *jog_dev;
+	struct input_dev *key_dev;
+	int i;
+
+	sonypi_device.input_jog_dev = jog_dev = input_allocate_device();
+	if (!jog_dev)
+		return -ENOMEM;
+
+	jog_dev->name = "Sony Vaio Jogdial";
+	jog_dev->id.bustype = BUS_ISA;
+	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
+
+	jog_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	jog_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_MIDDLE);
+	jog_dev->relbit[0] = BIT(REL_WHEEL);
+
+	sonypi_device.input_key_dev = key_dev = input_allocate_device();
+	if (!key_dev) {
+		input_free_device(jog_dev);
+		sonypi_device.input_jog_dev = NULL;
+		return -ENOMEM;
+	}
+
+	key_dev->name = "Sony Vaio Keys";
+	key_dev->id.bustype = BUS_ISA;
+	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
+
+	/* Initialize the Input Drivers: special keys */
+	key_dev->evbit[0] = BIT(EV_KEY);
+	for (i = 0; sonypi_inputkeys[i].sonypiev; i++)
+		if (sonypi_inputkeys[i].inputev)
+			set_bit(sonypi_inputkeys[i].inputev, key_dev->keybit);
+
+	input_register_device(jog_dev);
+	input_register_device(key_dev);
+
+	return 0;
+}
+
 static int __devinit sonypi_probe(void)
 {
 	int i, ret;
@@ -1298,34 +1335,10 @@ static int __devinit sonypi_probe(void)
 	}
 
 	if (useinput) {
-		/* Initialize the Input Drivers: jogdial */
-		int i;
-		sonypi_device.input_jog_dev.evbit[0] =
-			BIT(EV_KEY) | BIT(EV_REL);
-		sonypi_device.input_jog_dev.keybit[LONG(BTN_MOUSE)] =
-			BIT(BTN_MIDDLE);
-		sonypi_device.input_jog_dev.relbit[0] = BIT(REL_WHEEL);
-		sonypi_device.input_jog_dev.name = SONYPI_JOG_INPUTNAME;
-		sonypi_device.input_jog_dev.id.bustype = BUS_ISA;
-		sonypi_device.input_jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
-
-		input_register_device(&sonypi_device.input_jog_dev);
-		printk(KERN_INFO "%s input method installed.\n",
-		       sonypi_device.input_jog_dev.name);
 
-		/* Initialize the Input Drivers: special keys */
-		sonypi_device.input_key_dev.evbit[0] = BIT(EV_KEY);
-		for (i = 0; sonypi_inputkeys[i].sonypiev; i++)
-			if (sonypi_inputkeys[i].inputev)
-				set_bit(sonypi_inputkeys[i].inputev,
-					sonypi_device.input_key_dev.keybit);
-		sonypi_device.input_key_dev.name = SONYPI_KEY_INPUTNAME;
-		sonypi_device.input_key_dev.id.bustype = BUS_ISA;
-		sonypi_device.input_key_dev.id.vendor = PCI_VENDOR_ID_SONY;
-
-		input_register_device(&sonypi_device.input_key_dev);
-		printk(KERN_INFO "%s input method installed.\n",
-		       sonypi_device.input_key_dev.name);
+		ret = sonypi_create_input_devices();
+		if (ret)
+			goto out_inputdevices;
 
 		spin_lock_init(&sonypi_device.input_fifo_lock);
 		sonypi_device.input_fifo =
@@ -1375,8 +1388,9 @@ static int __devinit sonypi_probe(void)
 out_platformdev:
 	kfifo_free(sonypi_device.input_fifo);
 out_infifo:
-	input_unregister_device(&sonypi_device.input_key_dev);
-	input_unregister_device(&sonypi_device.input_jog_dev);
+	input_unregister_device(sonypi_device.input_key_dev);
+	input_unregister_device(sonypi_device.input_jog_dev);
+out_inputdevices:
 	free_irq(sonypi_device.irq, sonypi_irq);
 out_reqirq:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
@@ -1402,8 +1416,8 @@ static void __devexit sonypi_remove(void
 	platform_device_unregister(sonypi_device.pdev);
 
 	if (useinput) {
-		input_unregister_device(&sonypi_device.input_key_dev);
-		input_unregister_device(&sonypi_device.input_jog_dev);
+		input_unregister_device(sonypi_device.input_key_dev);
+		input_unregister_device(sonypi_device.input_jog_dev);
 		kfifo_free(sonypi_device.input_fifo);
 	}
 

