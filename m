Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWAGJ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWAGJ6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWAGJ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:58:23 -0500
Received: from styx.suse.cz ([82.119.242.94]:2188 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030387AbWAGJ6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:58:22 -0500
Date: Sat, 7 Jan 2006 10:58:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vernon Mauery <vernux@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Max Asbock <amax@us.ibm.com>
Subject: Re: dynamic input_dev allocation for ibmasm driver
Message-ID: <20060107095817.GA32698@ucw.cz>
References: <43BF0463.7010700@us.ibm.com> <200601070001.33125.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601070001.33125.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 12:01:32AM -0500, Dmitry Torokhov wrote:
 
> Error handling is rotten here. If 2nd input_register_device fails you will
> whack fully registered remote->mouse_dev. You are missing call to
> input_unregister_device() there.
> 
> Please fix it up and send it my way - I'll add it to the input tree.

Here goes a fixed version:

-------------------------------------------------------------------------------

This patch updates the ibmasm driver to use the dynamic allocation of input_dev
structs to work with the sysfs subsystem.  I have tested it on my machine and it
seems to work fine.

Vojtech: Fixed some problems/bugs in the patch.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ibmasm.h |    6 ++--
 remote.c |   76 +++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
--- a/drivers/misc/ibmasm/ibmasm.h
+++ b/drivers/misc/ibmasm/ibmasm.h
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
diff --git a/drivers/misc/ibmasm/remote.c b/drivers/misc/ibmasm/remote.c
--- a/drivers/misc/ibmasm/remote.c
+++ b/drivers/misc/ibmasm/remote.c
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
 
@@ -217,56 +217,66 @@ void ibmasm_handle_mouse_interrupt(struc
 int ibmasm_init_remote_input_dev(struct service_processor *sp)
 {
 	/* set up the mouse input device */
-	struct ibmasm_remote *remote;
+	struct input_dev *mouse_dev, *keybd_dev;
 	struct pci_dev *pdev = to_pci_dev(sp->dev);
+	int ret = -ENOMEM;
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
+		goto error_alloc;
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
 
 	for (i=0; i<XLATE_SIZE; i++) {
 		if (xlate_high[i])
-			set_bit(xlate_high[i], remote->keybd_dev.keybit);
+			set_bit(xlate_high[i], keybd_dev->keybit);
 		if (xlate[i])
-			set_bit(xlate[i], remote->keybd_dev.keybit);
+			set_bit(xlate[i], keybd_dev->keybit);
+	}
+
+	if ((ret = input_register_device(mouse_dev)))
+		goto error_alloc;
+	if ((ret = input_register_device(keybd_dev))) {
+		input_unregister_device(mouse_dev);
+		goto error_alloc;
 	}
 
-	input_register_device(&remote->mouse_dev);
-	input_register_device(&remote->keybd_dev);
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
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
