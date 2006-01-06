Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWAFX7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWAFX7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWAFX7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:59:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:24550 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932679AbWAFX7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:59:33 -0500
Message-ID: <43BF0463.7010700@us.ibm.com>
Date: Fri, 06 Jan 2006 15:59:31 -0800
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Max Asbock <amax@us.ibm.com>
Subject: dynamic input_dev allocation for ibmasm driver
Content-Type: multipart/mixed;
 boundary="------------050403030702010602080206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403030702010602080206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch updates the ibmasm driver to use the dynamic allocation of input_dev
structs to work with the sysfs subsystem.  I have tested it on my machine and it
seems to work fine.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

 ibmasm.h |    6 ++---
 remote.c |   72 ++++++++++++++++++++++++++++++++++-----------------------------
 2 files changed, 42 insertions(+), 36 deletions(-)


--------------050403030702010602080206
Content-Type: text/x-patch;
 name="ibmasm_dynamic_allocate_input_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmasm_dynamic_allocate_input_device.patch"

diff -Nuarp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/misc/ibmasm/ibmasm.h linux-2.6.15-fixed/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.15/drivers/misc/ibmasm/ibmasm.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-fixed/drivers/misc/ibmasm/ibmasm.h	2006-01-05 03:43:03.000000000 -0800
@@ -141,8 +141,8 @@ struct reverse_heartbeat {
 };
 
 struct ibmasm_remote {
-	struct input_dev keybd_dev;
-	struct input_dev mouse_dev;
+	struct input_dev * keybd_dev;
+	struct input_dev * mouse_dev;
 };
 
 struct service_processor {
@@ -157,7 +157,7 @@ struct service_processor {
 	char			dirname[IBMASM_NAME_SIZE];
 	char			devname[IBMASM_NAME_SIZE];
 	unsigned int		number;
-	struct ibmasm_remote	*remote;
+	struct ibmasm_remote	remote;
 	int			serial_line;
 	struct device		*dev;
 };
diff -Nuarp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/misc/ibmasm/remote.c linux-2.6.15-fixed/drivers/misc/ibmasm/remote.c
--- linux-2.6.15/drivers/misc/ibmasm/remote.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-fixed/drivers/misc/ibmasm/remote.c	2006-01-06 07:38:57.000000000 -0800
@@ -203,9 +203,9 @@ void ibmasm_handle_mouse_interrupt(struc
 
 		print_input(&input);
 		if (input.type == INPUT_TYPE_MOUSE) {
-			send_mouse_event(&sp->remote->mouse_dev, regs, &input);
+			send_mouse_event(sp->remote.mouse_dev, regs, &input);
 		} else if (input.type == INPUT_TYPE_KEYBOARD) {
-			send_keyboard_event(&sp->remote->keybd_dev, regs, &input);
+			send_keyboard_event(sp->remote.keybd_dev, regs, &input);
 		} else
 			break;
 
@@ -217,56 +217,62 @@ void ibmasm_handle_mouse_interrupt(struc
 int ibmasm_init_remote_input_dev(struct service_processor *sp)
 {
 	/* set up the mouse input device */
-	struct ibmasm_remote *remote;
+	struct input_dev *mouse_dev, *keybd_dev;
 	struct pci_dev *pdev = to_pci_dev(sp->dev);
 	int i;
+	int ret = 0;
 
-	sp->remote = remote = kmalloc(sizeof(*remote), GFP_KERNEL);
-	if (!remote)
-		return -ENOMEM;
-
-	memset(remote, 0, sizeof(*remote));
-
-	remote->mouse_dev.private = remote;
-	init_input_dev(&remote->mouse_dev);
-	remote->mouse_dev.id.vendor = pdev->vendor;
-	remote->mouse_dev.id.product = pdev->device;
-	remote->mouse_dev.evbit[0]  = BIT(EV_KEY) | BIT(EV_ABS);
-	remote->mouse_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) |
+	mouse_dev = input_allocate_device();
+	keybd_dev = input_allocate_device();
+	if (!mouse_dev || !keybd_dev) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+	mouse_dev->id.vendor = pdev->vendor;
+	mouse_dev->id.product = pdev->device;
+	mouse_dev->evbit[0]  = BIT(EV_KEY) | BIT(EV_ABS);
+	mouse_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) |
 		BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
-	set_bit(BTN_TOUCH, remote->mouse_dev.keybit);
-	remote->mouse_dev.name = remote_mouse_name;
-	input_set_abs_params(&remote->mouse_dev, ABS_X, 0, xmax, 0, 0);
-	input_set_abs_params(&remote->mouse_dev, ABS_Y, 0, ymax, 0, 0);
-
-	remote->keybd_dev.private = remote;
-	init_input_dev(&remote->keybd_dev);
-	remote->keybd_dev.id.vendor = pdev->vendor;
-	remote->keybd_dev.id.product = pdev->device;
-	remote->keybd_dev.evbit[0]  = BIT(EV_KEY);
-	remote->keybd_dev.name = remote_keybd_name;
+	set_bit(BTN_TOUCH, mouse_dev->keybit);
+	mouse_dev->name = remote_mouse_name;
+	input_set_abs_params(mouse_dev, ABS_X, 0, xmax, 0, 0);
+	input_set_abs_params(mouse_dev, ABS_Y, 0, ymax, 0, 0);
+
+	keybd_dev->id.vendor = pdev->vendor;
+	keybd_dev->id.product = pdev->device;
+	keybd_dev->evbit[0]  = BIT(EV_KEY);
+	keybd_dev->name = remote_keybd_name;
 
 	for (i=0; i<XLATE_SIZE; i++) {
 		if (xlate_high[i])
-			set_bit(xlate_high[i], remote->keybd_dev.keybit);
+			set_bit(xlate_high[i], keybd_dev->keybit);
 		if (xlate[i])
-			set_bit(xlate[i], remote->keybd_dev.keybit);
+			set_bit(xlate[i], keybd_dev->keybit);
 	}
 
-	input_register_device(&remote->mouse_dev);
-	input_register_device(&remote->keybd_dev);
+	if ((ret = input_register_device(mouse_dev)))
+		goto error_alloc;
+	if ((ret = input_register_device(keybd_dev)))
+		goto error_alloc;
+
+	sp->remote.mouse_dev = mouse_dev;
+	sp->remote.keybd_dev = keybd_dev;
 	enable_mouse_interrupts(sp);
 
 	printk(KERN_INFO "ibmasm remote responding to events on RSA card %d\n", sp->number);
 
 	return 0;
+
+error_alloc:
+	input_free_device(mouse_dev);
+	input_free_device(keybd_dev);
+	return ret;
 }
 
 void ibmasm_free_remote_input_dev(struct service_processor *sp)
 {
 	disable_mouse_interrupts(sp);
-	input_unregister_device(&sp->remote->keybd_dev);
-	input_unregister_device(&sp->remote->mouse_dev);
-	kfree(sp->remote);
+	input_unregister_device(sp->remote.mouse_dev);
+	input_unregister_device(sp->remote.keybd_dev);
 }
 

--------------050403030702010602080206--
