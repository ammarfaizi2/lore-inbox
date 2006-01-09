Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWAISbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWAISbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWAISbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:31:08 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:42210 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030232AbWAISbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:31:06 -0500
Message-ID: <43C2ABF2.7020507@us.ibm.com>
Date: Mon, 09 Jan 2006 10:31:14 -0800
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 24/24] ibmasm: convert to dynamic input_dev allocation
References: <20060107171559.593824000.dtor_core@ameritech.net> <20060107172102.339318000.dtor_core@ameritech.net> <43C2AA23.4060107@us.ibm.com>
In-Reply-To: <43C2AA23.4060107@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090107030400060202010108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090107030400060202010108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Input: ibmasm - convert to dynamic input_dev allocation

Here is a fixed up patch that adds the mouse_dev = NULL to prevent freeing
memory twice.

Update the ibmasm driver to use the dynamic allocation of input_dev structs to
work with the sysfs subsystem.

Vernon: Added mouse_dev = NULL to error handling
Vojtech: Fixed some problems/bugs in the patch.
Dmitry: Fixed some more.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
---

 ibmasm.h |    6 ++--
 remote.c |   84 ++++++++++++++++++++++++++++++++++++---------------------------
 2 files changed, 52 insertions(+), 38 deletions(-)



--------------090107030400060202010108
Content-Type: text/x-patch;
 name="ibmasm_dynamic_allocate_input_device2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmasm_dynamic_allocate_input_device2.patch"

Index: work/drivers/misc/ibmasm/ibmasm.h
===================================================================
--- work.orig/drivers/misc/ibmasm/ibmasm.h
+++ work/drivers/misc/ibmasm/ibmasm.h
@@ -141,8 +141,8 @@ struct reverse_heartbeat {
 };
 
 struct ibmasm_remote {
-	struct input_dev keybd_dev;
-	struct input_dev mouse_dev;
+	struct input_dev *keybd_dev;
+	struct input_dev *mouse_dev;
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
Index: work/drivers/misc/ibmasm/remote.c
===================================================================
--- work.orig/drivers/misc/ibmasm/remote.c
+++ work/drivers/misc/ibmasm/remote.c
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
 
@@ -217,56 +217,71 @@ void ibmasm_handle_mouse_interrupt(struc
 int ibmasm_init_remote_input_dev(struct service_processor *sp)
 {
 	/* set up the mouse input device */
-	struct ibmasm_remote *remote;
+	struct input_dev *mouse_dev, *keybd_dev;
 	struct pci_dev *pdev = to_pci_dev(sp->dev);
+	int error = -ENOMEM;
 	int i;
 
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
+	sp->remote.mouse_dev = mouse_dev = input_allocate_device();
+	sp->remote.keybd_dev = keybd_dev = input_allocate_device();
+
+	if (!mouse_dev || !keybd_dev)
+		goto err_free_devices;
+
+	mouse_dev->id.bustype = BUS_PCI;
+	mouse_dev->id.vendor = pdev->vendor;
+	mouse_dev->id.product = pdev->device;
+	mouse_dev->id.version = 1;
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
+	mouse_dev->id.bustype = BUS_PCI;
+	keybd_dev->id.vendor = pdev->vendor;
+	keybd_dev->id.product = pdev->device;
+	mouse_dev->id.version = 2;
+	keybd_dev->evbit[0]  = BIT(EV_KEY);
+	keybd_dev->name = remote_keybd_name;
 
-	for (i=0; i<XLATE_SIZE; i++) {
+	for (i = 0; i < XLATE_SIZE; i++) {
 		if (xlate_high[i])
-			set_bit(xlate_high[i], remote->keybd_dev.keybit);
+			set_bit(xlate_high[i], keybd_dev->keybit);
 		if (xlate[i])
-			set_bit(xlate[i], remote->keybd_dev.keybit);
+			set_bit(xlate[i], keybd_dev->keybit);
 	}
 
-	input_register_device(&remote->mouse_dev);
-	input_register_device(&remote->keybd_dev);
+	error = input_register_device(mouse_dev);
+	if (error)
+		goto err_free_devices;
+
+	error = input_register_device(keybd_dev);
+	if (error)
+		goto err_unregister_mouse_dev;
+
 	enable_mouse_interrupts(sp);
 
 	printk(KERN_INFO "ibmasm remote responding to events on RSA card %d\n", sp->number);
 
 	return 0;
+
+ err_unregister_mouse_dev:
+	input_unregister_device(mouse_dev);
+	mouse_dev = NULL;
+ err_free_devices:
+	input_free_device(mouse_dev);
+	input_free_device(keybd_dev);
+
+	return error;
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
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--------------090107030400060202010108--
