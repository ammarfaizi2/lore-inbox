Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbTGDXFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbTGDXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:04:18 -0400
Received: from maile.telia.com ([194.22.190.16]:19938 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S266219AbTGDXD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 19:03:59 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Sat, 5 Jul 2003 01:09:11 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@best.localdomain
To: "P. Christeas" <p_christ@hol.gr>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Early mail about synaptics driver
In-Reply-To: <200306241846.26953.p_christ@hol.gr>
Message-ID: <Pine.LNX.4.44.0307050014560.2344-100000@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, P. Christeas wrote:

> I am trying to use your synaptics kernel driver. I do have the touchpad,
> which means that as from 2.573 the kernel tries to use that by default.
> 
> The other important part (which I have solved) is that you set "disable
> gestures" by default. I don't know if this is required in absolute mode,
> but it surely makes the touchpad less useful in relative mode. That is,
> if I unload the module and reload it with 'psmouse_noext=1' [1], then
> the previous setting [2] applies and gestures are disabled.

I think it would be better to restore default settings when the driver is
unloaded, as in the patch below. I have verified that this patch solves
the problem on my computer using kernel 2.5.74.

diff -u -r linux/drivers/input/mouse.orig/psmouse-base.c linux/drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse.orig/psmouse-base.c	Sat Jul  5 00:10:56 2003
+++ linux/drivers/input/mouse/psmouse-base.c	Fri Jul  4 23:57:40 2003
@@ -478,9 +478,10 @@
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
+	if (psmouse->type == PSMOUSE_SYNAPTICS)
+		synaptics_disconnect(psmouse);
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
-	synaptics_disconnect(psmouse);
 	kfree(psmouse);
 }
 
diff -u -r linux/drivers/input/mouse.orig/synaptics.c linux/drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse.orig/synaptics.c	Sat Jul  5 00:11:07 2003
+++ linux/drivers/input/mouse/synaptics.c	Sat Jul  5 00:09:30 2003
@@ -144,7 +144,7 @@
 static void print_ident(struct synaptics_data *priv)
 {
 	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
-	printk(KERN_INFO " Firware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
+	printk(KERN_INFO " Firmware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
 	       SYN_ID_MINOR(priv->identity));
 
 	if (SYN_MODEL_ROT180(priv->model_id))
@@ -228,7 +228,7 @@
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
-	 * the senser.
+	 * the sensor.
 	 */
 	set_bit(EV_ABS, psmouse->dev.evbit);
 	set_abs_params(&psmouse->dev, ABS_X, 1472, 5472, 0, 0);
@@ -259,6 +259,9 @@
 {
 	struct synaptics_data *priv = psmouse->private;
 
+	/* Restore touchpad to power on default state */
+	synaptics_set_mode(psmouse, 0);
+
 	kfree(priv);
 }
 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

