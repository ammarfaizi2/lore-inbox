Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVKAPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKAPMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVKAPMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:12:08 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:51086 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbVKAPMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:12:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=jCJUQKbn4PH2aZIPbpdIwzz/fKaq3X/NnToVZ2kXocDDwIYOKk8gJgOZe9+1m54ytxuhb1mTBzubbnx7oDZH251WE5lxDhL0SDlUJAH4Z4g5booSfbRu7HqmIOSNEmxPH1o+1yglAGDeDvu0nBvodLHbJY/V/Yn+lneKsQIO2Xk=
Message-ID: <d120d5000511010712o77b2b1afie52e47ac07b09a8c@mail.gmail.com>
Date: Tue, 1 Nov 2005 10:12:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: after latest input updates, locomo keyboard kills boot
Cc: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>,
       rpurdie@rpsys.net, lenz@cs.wisc.edu
In-Reply-To: <20051101094945.GA7293@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16644_7091670.1130857925802"
References: <20051101094945.GA7293@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16644_7091670.1130857925802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/1/05, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> drivers/input/keyboard/locomokbd.c:
>
> struct locomokbd {
>        unsigned char keycode[LOCOMOKBD_NUMKEYS];
>        struct input_dev input;
>        ~~~~~~~~~~~~~~~~~~~~~~~
>
> ...and I guess that's the problem. What needs to be done? Just replace
> it with struct input_dev *?
>

Try the attached. BTW, shouldn't input->id.bus be BUS_HOST and not BUS_XTKB=
D?

--
Dmitry

------=_Part_16644_7091670.1130857925802
Content-Type: application/octet-stream; name=input-dynalloc-locomo.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="input-dynalloc-locomo.patch"

Input: locomokbd - convert to dynamic input allocation

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/locomokbd.c |   63 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

Index: linux/drivers/input/keyboard/locomokbd.c
===================================================================
--- linux.orig/drivers/input/keyboard/locomokbd.c
+++ linux/drivers/input/keyboard/locomokbd.c
@@ -76,7 +76,7 @@ static unsigned char locomokbd_keycode[L
 
 struct locomokbd {
 	unsigned char keycode[LOCOMOKBD_NUMKEYS];
-	struct input_dev input;
+	struct input_dev *input;
 	char phys[32];
 
 	struct locomo_dev *ldev;
@@ -136,8 +136,7 @@ static void locomokbd_scankeyboard(struc
 
 	spin_lock_irqsave(&locomokbd->lock, flags);
 
-	if (regs)
-		input_regs(&locomokbd->input, regs);
+	input_regs(locomokbd->input, regs);
 
 	locomokbd_charge_all(membase);
 
@@ -152,16 +151,16 @@ static void locomokbd_scankeyboard(struc
 			scancode = SCANCODE(col, row);
 			if (rowd & KB_ROWMASK(row)) {
 				num_pressed += 1;
-				input_report_key(&locomokbd->input, locomokbd->keycode[scancode], 1);
+				input_report_key(locomokbd->input, locomokbd->keycode[scancode], 1);
 			} else {
-				input_report_key(&locomokbd->input, locomokbd->keycode[scancode], 0);
+				input_report_key(locomokbd->input, locomokbd->keycode[scancode], 0);
 			}
 		}
 		locomokbd_reset_col(membase, col);
 	}
 	locomokbd_activate_all(membase);
 
-	input_sync(&locomokbd->input);
+	input_sync(locomokbd->input);
 
 	/* if any keys are pressed, enable the timer */
 	if (num_pressed)
@@ -196,13 +195,15 @@ static void locomokbd_timer_callback(uns
 static int locomokbd_probe(struct locomo_dev *dev)
 {
 	struct locomokbd *locomokbd;
+	struct input_dev *input_dev;
 	int i, ret;
 
-	locomokbd = kmalloc(sizeof(struct locomokbd), GFP_KERNEL);
-	if (!locomokbd)
-		return -ENOMEM;
-
-	memset(locomokbd, 0, sizeof(struct locomokbd));
+	locomokbd = kzalloc(sizeof(struct locomokbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!locomokbd || !input_dev) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	/* try and claim memory region */
 	if (!request_mem_region((unsigned long) dev->mapbase,
@@ -224,27 +225,26 @@ static int locomokbd_probe(struct locomo
 	locomokbd->timer.function = locomokbd_timer_callback;
 	locomokbd->timer.data = (unsigned long) locomokbd;
 
-	locomokbd->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	locomokbd->input = input_dev;
+	strcpy(locomokbd->phys, "locomokbd/input0");
 
-	init_input_dev(&locomokbd->input);
-	locomokbd->input.keycode = locomokbd->keycode;
-	locomokbd->input.keycodesize = sizeof(unsigned char);
-	locomokbd->input.keycodemax = ARRAY_SIZE(locomokbd_keycode);
-	locomokbd->input.private = locomokbd;
+	input_dev->name = "LoCoMo keyboard";
+	input_dev->phys = locomokbd->phys;
+	input_dev->id.bustype = BUS_XTKBD;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->private = locomokbd;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->keycode = locomokbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(locomokbd_keycode);
 
 	memcpy(locomokbd->keycode, locomokbd_keycode, sizeof(locomokbd->keycode));
 	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
-		set_bit(locomokbd->keycode[i], locomokbd->input.keybit);
-	clear_bit(0, locomokbd->input.keybit);
-
-	strcpy(locomokbd->phys, "locomokbd/input0");
-
-	locomokbd->input.name = "LoCoMo keyboard";
-	locomokbd->input.phys = locomokbd->phys;
-	locomokbd->input.id.bustype = BUS_XTKBD;
-	locomokbd->input.id.vendor = 0x0001;
-	locomokbd->input.id.product = 0x0001;
-	locomokbd->input.id.version = 0x0100;
+		set_bit(locomokbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
 
 	/* attempt to get the interrupt */
 	ret = request_irq(dev->irq[0], locomokbd_interrupt, 0, "locomokbd", locomokbd);
@@ -253,9 +253,7 @@ static int locomokbd_probe(struct locomo
 		goto out;
 	}
 
-	input_register_device(&locomokbd->input);
-
-	printk(KERN_INFO "input: LoCoMo keyboard on locomokbd\n");
+	input_register_device(locomokbd->input);
 
 	return 0;
 
@@ -263,6 +261,7 @@ out:
 	release_mem_region((unsigned long) dev->mapbase, dev->length);
 	locomo_set_drvdata(dev, NULL);
 free:
+	input_free_device(input_dev)
 	kfree(locomokbd);
 
 	return ret;
@@ -276,7 +275,7 @@ static int locomokbd_remove(struct locom
 
 	del_timer_sync(&locomokbd->timer);
 
-	input_unregister_device(&locomokbd->input);
+	input_unregister_device(locomokbd->input);
 	locomo_set_drvdata(dev, NULL);
 
 	release_mem_region((unsigned long) dev->mapbase, dev->length);

------=_Part_16644_7091670.1130857925802--
