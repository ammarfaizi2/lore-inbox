Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUBCEj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUBCEj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:39:27 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:14983 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265817AbUBCEjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:39:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, "P. Christeas" <p_christ@hol.gr>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Mon, 2 Feb 2004 23:38:41 -0500
User-Agent: KMail/1.5.4
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
References: <200401251137.21646.p_christ@hol.gr> <20040125115946.GA414@ucw.cz>
In-Reply-To: <20040125115946.GA414@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402022338.48010.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 January 2004 06:59 am, Vojtech Pavlik wrote:
> On Sun, Jan 25, 2004 at 11:37:19AM +0200, P. Christeas wrote:
> > This may be just a minor issue:
> > I had to use the setkeycodes utility to enable some extra keys (that
> > weren't mapped by kernel's atkbd tables).
> > After waking from sleep 1, those keys were reset. That is, I had to
> > use 'setkeycodes' again to customize the tables again.
> >
> > IMHO the way kernel works now is correct. It should *not* have extra
> > code just to handle that. Just make sure anybody that alters his kbd
> > tables puts some extra script to recover the tables after an ACPI
> > wake.
> > This should be more like a note to Linux distributors.
> >
> > Have a nice day.
>
> Patch attached, please test. It'll make it into 2.6.3, with some luck
> even 2.6.2.

I feel a little uneasy about killing the input device if set changes after
resume. That would cause a new input device created but for user it would
look like keyboard is lost or am I missing someting?

What about the patch below which would reset keyboard to the default keymap
only if set changes?

-- 
Dmitry

===================================================================


ChangeSet@1.1543, 2004-02-02 23:33:52-05:00, dtor_core@ameritech.net
  Input: atkbd - load default keymap on resume only if set is changed


 atkbd.c |   95 ++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 51 insertions(+), 44 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Feb  2 23:35:33 2004
+++ b/drivers/input/keyboard/atkbd.c	Mon Feb  2 23:35:33 2004
@@ -619,6 +619,38 @@
 	kfree(atkbd);
 }
 
+static void atkbd_set_name(struct atkbd *atkbd)
+{
+	if (atkbd->set == 4) {
+		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
+	} else
+		sprintf(atkbd->name, "AT %s Set %d keyboard",
+			atkbd->translated ? "Translated" : "Raw", atkbd->set);
+}
+
+/*
+ * Installs default keymap based on the detected mode (set)
+ */
+static void atkbd_install_keymap(struct atkbd *atkbd)
+{
+	int i;
+
+	if (atkbd->translated) {
+		for (i = 0; i < 128; i++) {
+			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
+			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
+		}
+	} else if (atkbd->set == 2) {
+		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
+	} else {
+		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
+	}
+
+	for (i = 0; i < 512; i++)
+		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
+			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+}
+
 /*
  * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
@@ -629,7 +661,6 @@
 static void atkbd_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct atkbd *atkbd;
-	int i;
 
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
@@ -696,26 +727,12 @@
 		atkbd->id = 0xab00;
 	}
 
-	if (atkbd->set == 4) {
+	if (atkbd->set == 4)
 		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
-		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
-	} else
-		sprintf(atkbd->name, "AT %s Set %d keyboard",
-			atkbd->translated ? "Translated" : "Raw", atkbd->set);
 
+	atkbd_set_name(atkbd);
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
 
-	if (atkbd->translated) {
-		for (i = 0; i < 128; i++) {
-			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
-			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
-		}
-	} else if (atkbd->set == 2) {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	} else {
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	}
-
 	atkbd->dev.name = atkbd->name;
 	atkbd->dev.phys = atkbd->phys;
 	atkbd->dev.id.bustype = BUS_I8042;
@@ -723,9 +740,7 @@
 	atkbd->dev.id.product = atkbd->translated ? 1 : atkbd->set;
 	atkbd->dev.id.version = atkbd->id;
 
-	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+	atkbd_install_keymap(atkbd);
 
 	input_register_device(&atkbd->dev);
 
@@ -741,12 +756,12 @@
 {
 	struct atkbd *atkbd = serio->private;
 	struct serio_dev *dev = serio->dev;
-	int i;
+	int old_set = atkbd->set;
 
-        if (!dev) {
-                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
-                return -1;
-        }
+	if (!dev) {
+		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
+		return -1;
+	}
 
 	if (atkbd->write) {
 		if (atkbd_probe(atkbd))
@@ -759,27 +774,19 @@
 		atkbd->id = 0xab00;
 	}
 
-	/*
-	 * Here we probably should check if the keyboard has the same set that
-         * it had before and bail out if it's different. But this will most likely
-         * cause new keyboard device be created... and for the user it will look
-         * like keyboard is lost
-	 */
+	if (atkbd->set != old_set) {
+		/*
+		 * ok, we woke up with a different keyboard attached. Alhtough we could just
+		 * signal failure it's not very nice as it will most likely cause new keyboard
+		 * device be created... and for the user it will look like keyboard is lost.
+		 */
+		atkbd_set_name(atkbd);
 
-	if (atkbd->translated) {
-		for (i = 0; i < 128; i++) {
-			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
-			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
-		}
-	} else if (atkbd->set == 2) {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	} else {
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	}
+		printk(KERN_INFO "atkbd: new %s detected at %s, loading default keymap\n",
+			atkbd->name, atkbd->name);
 
-	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+		atkbd_install_keymap(atkbd);
+	}
 
 	return 0;
 }
