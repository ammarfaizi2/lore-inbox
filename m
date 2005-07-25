Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVGYF72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVGYF72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGYF5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:40 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:13199 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261707AbVGYFzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:43 -0400
Message-Id: <20050725054531.737563000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 08/24] input: make name, phys and uniq const char
Content-Disposition: inline; filename=input-make-name-const.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: make name, phys and uniq be 'const char *' because once
       set noone should attempt to change them.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/sonypi.c       |   24 ++----------------------
 drivers/input/misc/uinput.c |   23 ++++++++++++-----------
 include/linux/input.h       |    6 +++---
 3 files changed, 17 insertions(+), 36 deletions(-)

Index: work/drivers/char/sonypi.c
===================================================================
--- work.orig/drivers/char/sonypi.c
+++ work/drivers/char/sonypi.c
@@ -1228,14 +1228,7 @@ static int __devinit sonypi_probe(void)
 		sonypi_device.input_jog_dev.keybit[LONG(BTN_MOUSE)] =
 			BIT(BTN_MIDDLE);
 		sonypi_device.input_jog_dev.relbit[0] = BIT(REL_WHEEL);
-		sonypi_device.input_jog_dev.name =
-			kmalloc(sizeof(SONYPI_JOG_INPUTNAME), GFP_KERNEL);
-		if (!sonypi_device.input_jog_dev.name) {
-			printk(KERN_ERR "sonypi: kmalloc failed\n");
-			ret = -ENOMEM;
-			goto out_inkmallocinput1;
-		}
-		sprintf(sonypi_device.input_jog_dev.name, SONYPI_JOG_INPUTNAME);
+		sonypi_device.input_jog_dev.name = SONYPI_JOG_INPUTNAME;
 		sonypi_device.input_jog_dev.id.bustype = BUS_ISA;
 		sonypi_device.input_jog_dev.id.vendor = PCI_VENDOR_ID_SONY;
 
@@ -1249,14 +1242,7 @@ static int __devinit sonypi_probe(void)
 			if (sonypi_inputkeys[i].inputev)
 				set_bit(sonypi_inputkeys[i].inputev,
 					sonypi_device.input_key_dev.keybit);
-		sonypi_device.input_key_dev.name =
-			kmalloc(sizeof(SONYPI_KEY_INPUTNAME), GFP_KERNEL);
-		if (!sonypi_device.input_key_dev.name) {
-			printk(KERN_ERR "sonypi: kmalloc failed\n");
-			ret = -ENOMEM;
-			goto out_inkmallocinput2;
-		}
-		sprintf(sonypi_device.input_key_dev.name, SONYPI_KEY_INPUTNAME);
+		sonypi_device.input_key_dev.name = SONYPI_KEY_INPUTNAME;
 		sonypi_device.input_key_dev.id.bustype = BUS_ISA;
 		sonypi_device.input_key_dev.id.vendor = PCI_VENDOR_ID_SONY;
 
@@ -1314,11 +1300,7 @@ out_platformdev:
 	kfifo_free(sonypi_device.input_fifo);
 out_infifo:
 	input_unregister_device(&sonypi_device.input_key_dev);
-	kfree(sonypi_device.input_key_dev.name);
-out_inkmallocinput2:
 	input_unregister_device(&sonypi_device.input_jog_dev);
-	kfree(sonypi_device.input_jog_dev.name);
-out_inkmallocinput1:
 	free_irq(sonypi_device.irq, sonypi_irq);
 out_reqirq:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
@@ -1345,9 +1327,7 @@ static void __devexit sonypi_remove(void
 
 	if (useinput) {
 		input_unregister_device(&sonypi_device.input_key_dev);
-		kfree(sonypi_device.input_key_dev.name);
 		input_unregister_device(&sonypi_device.input_jog_dev);
-		kfree(sonypi_device.input_jog_dev.name);
 		kfifo_free(sonypi_device.input_fifo);
 	}
 
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -811,9 +811,9 @@ struct input_dev {
 
 	void *private;
 
-	char *name;
-	char *phys;
-	char *uniq;
+	const char *name;
+	const char *phys;
+	const char *uniq;
 	struct input_id id;
 
 	unsigned long evbit[NBITS(EV_MAX)];
Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -251,6 +251,7 @@ static int uinput_alloc_device(struct fi
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
 	struct uinput_device	*udev;
+	char			*name;
 	int			size;
 	int			retval;
 
@@ -274,13 +275,13 @@ static int uinput_alloc_device(struct fi
 		kfree(dev->name);
 
 	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
-	dev->name = kmalloc(size, GFP_KERNEL);
-	if (!dev->name) {
+	dev->name = name = kmalloc(size, GFP_KERNEL);
+	if (!name) {
 		retval = -ENOMEM;
 		goto exit;
 	}
+	strlcpy(name, user_dev->name, size);
 
-	strlcpy(dev->name, user_dev->name, size);
 	dev->id.bustype	= user_dev->id.bustype;
 	dev->id.vendor	= user_dev->id.vendor;
 	dev->id.product	= user_dev->id.product;
@@ -397,6 +398,7 @@ static int uinput_ioctl(struct inode *in
 	struct uinput_ff_erase  ff_erase;
 	struct uinput_request   *req;
 	int                     length;
+	char			*phys;
 
 	udev = file->private_data;
 
@@ -494,20 +496,19 @@ static int uinput_ioctl(struct inode *in
 				retval = -EFAULT;
 				break;
 			}
-			if (NULL != udev->dev->phys)
-				kfree(udev->dev->phys);
-			udev->dev->phys = kmalloc(length, GFP_KERNEL);
-			if (!udev->dev->phys) {
+			kfree(udev->dev->phys);
+			udev->dev->phys = phys = kmalloc(length, GFP_KERNEL);
+			if (!phys) {
 				retval = -ENOMEM;
 				break;
 			}
-			if (copy_from_user(udev->dev->phys, p, length)) {
-				retval = -EFAULT;
-				kfree(udev->dev->phys);
+			if (copy_from_user(phys, p, length)) {
 				udev->dev->phys = NULL;
+				kfree(phys);
+				retval = -EFAULT;
 				break;
 			}
-			udev->dev->phys[length - 1] = '\0';
+			phys[length - 1] = '\0';
 			break;
 
 		case UI_BEGIN_FF_UPLOAD:

