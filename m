Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUIQFKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUIQFKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUIQFIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:08:02 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:58280 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268438AbUIQFBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:01:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/3] atkbd-sysfs-attr.patch
Date: Fri, 17 Sep 2004 00:01:23 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409162358.27678.dtor_core@ameritech.net> <200409162359.45766.dtor_core@ameritech.net> <200409170000.21369.dtor_core@ameritech.net>
In-Reply-To: <200409170000.21369.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409170001.25201.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1904, 2004-09-16 23:24:30-05:00, dtor_core@ameritech.net
  Input: atkbd - export extra, scroll, set, softrepeat and softraw as individual
         keyboard attributes (sysfs) and allow them to be set/changed independently
         for each keyboard:
  
         echo -n "2" > /sys/bus/serio/devices/serio1/set
         echo -n "1" > /sys/bus/serio/devices/serio1/softrepeat
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 


 atkbd.c |  444 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 367 insertions(+), 77 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-09-16 23:32:32 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-09-16 23:32:32 -05:00
@@ -184,13 +184,15 @@
 	char phys[32];
 	struct input_dev dev;
 
-	unsigned char set;
 	unsigned short id;
 	unsigned char keycode[512];
+	unsigned char set;
 	unsigned char translated;
 	unsigned char extra;
 	unsigned char write;
-
+	unsigned char softrepeat;
+	unsigned char softraw;
+	unsigned char scroll;
 	unsigned char enabled;
 
 	/* Accessed only from interrupt */
@@ -202,6 +204,31 @@
 	unsigned long time;
 };
 
+static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
+				ssize_t (*handler)(struct atkbd *, char *));
+static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t count,
+				int (*handler)(struct atkbd *, const char *, size_t));
+#define ATKBD_DEFINE_ATTR(_name)						\
+static ssize_t atkbd_show_##_name(struct atkbd *, char *);			\
+static ssize_t atkbd_set_##_name(struct atkbd *, const char *, size_t);		\
+static ssize_t atkbd_do_show_##_name(struct device *d, char *b)			\
+{										\
+	return atkbd_attr_show_helper(d, b, atkbd_show_##_name);		\
+}										\
+static ssize_t atkbd_do_set_##_name(struct device *d, const char *b, size_t s)	\
+{										\
+	return atkbd_attr_set_helper(d, b, s, atkbd_set_##_name);		\
+}										\
+static struct device_attribute atkbd_attr_##_name = 				\
+	__ATTR(_name, S_IWUSR | S_IRUGO, atkbd_do_show_##_name, atkbd_do_set_##_name);
+
+ATKBD_DEFINE_ATTR(extra);
+ATKBD_DEFINE_ATTR(scroll);
+ATKBD_DEFINE_ATTR(set);
+ATKBD_DEFINE_ATTR(softrepeat);
+ATKBD_DEFINE_ATTR(softraw);
+
+
 static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
 {
 	input_regs(dev, regs);
@@ -253,7 +280,8 @@
 	if (!atkbd->enabled)
 		goto out;
 
-	input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
+	if (atkbd->softraw)
+		input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
 
 	if (atkbd->translated) {
 
@@ -343,7 +371,7 @@
 			break;
 		default:
 			value = atkbd->release ? 0 :
-				(1 + (!atkbd_softrepeat && test_bit(atkbd->keycode[code], atkbd->dev.key)));
+				(1 + (!atkbd->softrepeat && test_bit(atkbd->keycode[code], atkbd->dev.key)));
 
 			switch (value) { 	/* Workaround Toshiba laptop multiple keypress */
 				case 0:
@@ -418,7 +446,7 @@
 
 		case EV_REP:
 
-			if (atkbd_softrepeat) return 0;
+			if (atkbd->softrepeat) return 0;
 
 			i = j = 0;
 			while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
@@ -435,6 +463,30 @@
 }
 
 /*
+ * atkbd_enable() signals that interrupt handler is allowed to
+ * generate input events.
+ */
+
+static inline void atkbd_enable(struct atkbd *atkbd)
+{
+	serio_pause_rx(atkbd->ps2dev.serio);
+	atkbd->enabled = 1;
+	serio_continue_rx(atkbd->ps2dev.serio);
+}
+
+/*
+ * atkbd_disable() tells input handler that all incoming data except
+ * for ACKs and command response should be dropped.
+ */
+
+static inline void atkbd_disable(struct atkbd *atkbd)
+{
+	serio_pause_rx(atkbd->ps2dev.serio);
+	atkbd->enabled = 0;
+	serio_continue_rx(atkbd->ps2dev.serio);
+}
+
+/*
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
 
@@ -489,16 +541,17 @@
 }
 
 /*
- * atkbd_set_3 checks if a keyboard has a working Set 3 support, and
+ * atkbd_select_set checks if a keyboard has a working Set 3 support, and
  * sets it into that. Unfortunately there are keyboards that can be switched
  * to Set 3, but don't work well in that (BTC Multimedia ...)
  */
 
-static int atkbd_set_3(struct atkbd *atkbd)
+static int atkbd_select_set(struct atkbd *atkbd, int target_set, int allow_extra)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
 
+	atkbd->extra = 0;
 /*
  * For known special keyboards we can go ahead and set the correct set.
  * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
@@ -514,7 +567,7 @@
 		return 3;
 	}
 
-	if (atkbd_extra) {
+	if (allow_extra) {
 		param[0] = 0x71;
 		if (!ps2_command(ps2dev, param, ATKBD_CMD_EX_ENABLE)) {
 			atkbd->extra = 1;
@@ -522,7 +575,7 @@
 		}
 	}
 
-	if (atkbd_set != 3)
+	if (target_set != 3)
 		return 2;
 
 	if (!ps2_command(ps2dev, param, ATKBD_CMD_OK_GETID)) {
@@ -549,7 +602,7 @@
 	return 3;
 }
 
-static int atkbd_enable(struct atkbd *atkbd)
+static int atkbd_activate(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[1];
@@ -594,6 +647,7 @@
 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_BAT);
 }
 
+
 /*
  * atkbd_disconnect() closes and frees.
  */
@@ -602,19 +656,108 @@
 {
 	struct atkbd *atkbd = serio->private;
 
-	serio_pause_rx(serio);
-	atkbd->enabled = 0;
-	serio_continue_rx(serio);
+	atkbd_disable(atkbd);
 
 	/* make sure we don't have a command in flight */
 	synchronize_kernel();
 	flush_scheduled_work();
 
+	device_remove_file(&serio->dev, &atkbd_attr_extra);
+	device_remove_file(&serio->dev, &atkbd_attr_scroll);
+	device_remove_file(&serio->dev, &atkbd_attr_set);
+	device_remove_file(&serio->dev, &atkbd_attr_softrepeat);
+	device_remove_file(&serio->dev, &atkbd_attr_softraw);
+
 	input_unregister_device(&atkbd->dev);
 	serio_close(serio);
 	kfree(atkbd);
 }
 
+
+/*
+ * atkbd_set_device_attrs() initializes keyboard's keycode table
+ * according to the selected scancode set
+ */
+
+static void atkbd_set_keycode_table(struct atkbd *atkbd)
+{
+	int i, j;
+
+	memset(atkbd->keycode, 0, sizeof(atkbd->keycode));
+
+	if (atkbd->translated) {
+		for (i = 0; i < 128; i++) {
+			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
+			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
+			if (atkbd->scroll)
+				for (j = 0; i < 5; i++) {
+					if (atkbd_unxlate_table[i] == atkbd_scroll_keys[j][1])
+						atkbd->keycode[i] = atkbd_scroll_keys[j][0];
+					if ((atkbd_unxlate_table[i] | 0x80) == atkbd_scroll_keys[j][1])
+						atkbd->keycode[i | 0x80] = atkbd_scroll_keys[j][0];
+				}
+		}
+	} else if (atkbd->set == 3) {
+		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
+	} else {
+		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
+
+		if (atkbd->scroll)
+			for (i = 0; i < 5; i++)
+				atkbd->keycode[atkbd_scroll_keys[i][1]] = atkbd_scroll_keys[i][0];
+	}
+}
+
+/*
+ * atkbd_set_device_attrs() sets up keyboard's input device structure
+ */
+
+static void atkbd_set_device_attrs(struct atkbd *atkbd)
+{
+	int i;
+
+	memset(&atkbd->dev, 0, sizeof(struct input_dev));
+
+	init_input_dev(&atkbd->dev);
+
+	atkbd->dev.name = atkbd->name;
+	atkbd->dev.phys = atkbd->phys;
+	atkbd->dev.id.bustype = BUS_I8042;
+	atkbd->dev.id.vendor = 0x0001;
+	atkbd->dev.id.product = atkbd->translated ? 1 : atkbd->set;
+	atkbd->dev.id.version = atkbd->id;
+	atkbd->dev.event = atkbd_event;
+	atkbd->dev.private = atkbd;
+
+	atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
+
+	if (atkbd->write) {
+		atkbd->dev.evbit[0] |= BIT(EV_LED);
+		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
+	}
+
+	if (atkbd->extra)
+		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) |
+					BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
+
+	if (!atkbd->softrepeat) {
+		atkbd->dev.rep[REP_DELAY] = 250;
+		atkbd->dev.rep[REP_PERIOD] = 33;
+	}
+
+	atkbd->dev.mscbit[0] = atkbd->softraw ? BIT(MSC_SCAN) : BIT(MSC_RAW) | BIT(MSC_SCAN);
+
+	if (atkbd->scroll) {
+		atkbd->dev.evbit[0] |= BIT(EV_REL);
+		atkbd->dev.relbit[0] = BIT(REL_WHEEL);
+		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
+	}
+
+	for (i = 0; i < 512; i++)
+		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
+			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+}
+
 /*
  * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
@@ -625,7 +768,6 @@
 static void atkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct atkbd *atkbd;
-	int i;
 
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
@@ -649,29 +791,19 @@
 			return;
 	}
 
-	if (!atkbd->write)
-		atkbd_softrepeat = 1;
-	if (atkbd_softrepeat)
-		atkbd_softraw = 1;
-
-	if (atkbd->write) {
-		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP) | BIT(EV_MSC);
-		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
-	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
-	atkbd->dev.mscbit[0] = atkbd_softraw ? BIT(MSC_SCAN) : BIT(MSC_RAW) | BIT(MSC_SCAN);
+	atkbd->softraw = atkbd_softraw;
+	atkbd->softrepeat = atkbd_softrepeat;
+	atkbd->scroll = atkbd_scroll;
 
-	if (!atkbd_softrepeat) {
-		atkbd->dev.rep[REP_DELAY] = 250;
-		atkbd->dev.rep[REP_PERIOD] = 33;
-	} else atkbd_softraw = 1;
+	if (!atkbd->write)
+		atkbd->softrepeat = 1;
 
-	init_input_dev(&atkbd->dev);
+	if (atkbd->softrepeat)
+		atkbd->softraw = 1;
 
 	atkbd->dev.keycode = atkbd->keycode;
 	atkbd->dev.keycodesize = sizeof(unsigned char);
 	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
-	atkbd->dev.event = atkbd_event;
-	atkbd->dev.private = atkbd;
 
 	serio->private = atkbd;
 
@@ -689,58 +821,34 @@
 			return;
 		}
 
-		atkbd->set = atkbd_set_3(atkbd);
-		atkbd_enable(atkbd);
+		atkbd->set = atkbd_select_set(atkbd, atkbd_set, atkbd_extra);
+		atkbd_activate(atkbd);
 
 	} else {
 		atkbd->set = 2;
 		atkbd->id = 0xab00;
 	}
 
-	if (atkbd->extra) {
-		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
+	if (atkbd->extra)
 		sprintf(atkbd->name, "AT Set 2 Extra keyboard");
-	} else
+	else
 		sprintf(atkbd->name, "AT %s Set %d keyboard",
 			atkbd->translated ? "Translated" : "Raw", atkbd->set);
 
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
 
-	if (atkbd_scroll) {
-		for (i = 0; i < 5; i++)
-			atkbd_set2_keycode[atkbd_scroll_keys[i][1]] = atkbd_scroll_keys[i][0];
-		atkbd->dev.evbit[0] |= BIT(EV_REL);
-		atkbd->dev.relbit[0] = BIT(REL_WHEEL);
-		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
-	}
-
-	if (atkbd->translated) {
-		for (i = 0; i < 128; i++) {
-			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
-			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
-		}
-	} else if (atkbd->set == 3) {
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	} else {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	}
-
-	atkbd->dev.name = atkbd->name;
-	atkbd->dev.phys = atkbd->phys;
-	atkbd->dev.id.bustype = BUS_I8042;
-	atkbd->dev.id.vendor = 0x0001;
-	atkbd->dev.id.product = atkbd->translated ? 1 : atkbd->set;
-	atkbd->dev.id.version = atkbd->id;
-
-	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+	atkbd_set_keycode_table(atkbd);
+	atkbd_set_device_attrs(atkbd);
 
 	input_register_device(&atkbd->dev);
 
-	serio_pause_rx(serio);
-	atkbd->enabled = 1;
-	serio_continue_rx(serio);
+	device_create_file(&serio->dev, &atkbd_attr_extra);
+	device_create_file(&serio->dev, &atkbd_attr_scroll);
+	device_create_file(&serio->dev, &atkbd_attr_set);
+	device_create_file(&serio->dev, &atkbd_attr_softrepeat);
+	device_create_file(&serio->dev, &atkbd_attr_softraw);
+
+	atkbd_enable(atkbd);
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
@@ -756,14 +864,12 @@
 	struct serio_driver *drv = serio->drv;
 	unsigned char param[1];
 
-	if (!drv) {
+	if (!atkbd || !drv) {
 		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
 
-	serio_pause_rx(serio);
-	atkbd->enabled = 0;
-	serio_continue_rx(serio);
+	atkbd_disable(atkbd);
 
 	if (atkbd->write) {
 		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
@@ -772,18 +878,16 @@
 
 		if (atkbd_probe(atkbd))
 			return -1;
-		if (atkbd->set != atkbd_set_3(atkbd))
+		if (atkbd->set != atkbd_select_set(atkbd, atkbd->set, atkbd->extra))
 			return -1;
 
-		atkbd_enable(atkbd);
+		atkbd_activate(atkbd);
 
 		if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
 	}
 
-	serio_pause_rx(serio);
-	atkbd->enabled = 1;
-	serio_continue_rx(serio);
+	atkbd_enable(atkbd);
 
 	return 0;
 }
@@ -799,6 +903,192 @@
 	.disconnect	= atkbd_disconnect,
 	.cleanup	= atkbd_cleanup,
 };
+
+static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
+				ssize_t (*handler)(struct atkbd *, char *))
+{
+	struct serio *serio = to_serio_port(dev);
+	int retval;
+
+	retval = serio_pin_driver(serio);
+	if (retval)
+		return retval;
+
+	if (serio->drv != &atkbd_drv) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	retval = handler((struct atkbd *)serio->private, buf);
+
+out:
+	serio_unpin_driver(serio);
+	return retval;
+}
+
+static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t count,
+				int (*handler)(struct atkbd *, const char *, size_t))
+{
+	struct serio *serio = to_serio_port(dev);
+	struct atkbd *atkbd;
+	int retval;
+
+	retval = serio_pin_driver(serio);
+	if (retval)
+		return retval;
+
+	if (serio->drv != &atkbd_drv) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	atkbd = serio->private;
+	atkbd_disable(atkbd);
+	retval = handler(atkbd, buf, count);
+	atkbd_enable(atkbd);
+
+out:
+	serio_unpin_driver(serio);
+	return retval;
+}
+
+static ssize_t atkbd_show_extra(struct atkbd *atkbd, char *buf)
+{
+	return sprintf(buf, "%d\n", atkbd->extra ? 1 : 0);
+}
+
+static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	if (!atkbd->write)
+		return -EIO;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	if (atkbd->extra != value) {
+		/* unregister device as it's properties will change */
+		input_unregister_device(&atkbd->dev);
+		atkbd->set = atkbd_select_set(atkbd, atkbd->set, value);
+		atkbd_activate(atkbd);
+		atkbd_set_device_attrs(atkbd);
+		input_register_device(&atkbd->dev);
+	}
+	return count;
+}
+
+static ssize_t atkbd_show_scroll(struct atkbd *atkbd, char *buf)
+{
+	return sprintf(buf, "%d\n", atkbd->scroll ? 1 : 0);
+}
+
+static ssize_t atkbd_set_scroll(struct atkbd *atkbd, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	if (atkbd->scroll != value) {
+		/* unregister device as it's properties will change */
+		input_unregister_device(&atkbd->dev);
+		atkbd->scroll = value;
+		atkbd_set_keycode_table(atkbd);
+		atkbd_set_device_attrs(atkbd);
+		input_register_device(&atkbd->dev);
+	}
+	return count;
+}
+
+static ssize_t atkbd_show_set(struct atkbd *atkbd, char *buf)
+{
+	return sprintf(buf, "%d\n", atkbd->set);
+}
+
+static ssize_t atkbd_set_set(struct atkbd *atkbd, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	if (!atkbd->write)
+		return -EIO;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || (value != 2 && value != 3))
+		return -EINVAL;
+
+	if (atkbd->set != value) {
+		/* unregister device as it's properties will change */
+		input_unregister_device(&atkbd->dev);
+		atkbd->set = atkbd_select_set(atkbd, value, atkbd->extra);
+		atkbd_activate(atkbd);
+		atkbd_set_keycode_table(atkbd);
+		atkbd_set_device_attrs(atkbd);
+		input_register_device(&atkbd->dev);
+	}
+	return count;
+}
+
+static ssize_t atkbd_show_softrepeat(struct atkbd *atkbd, char *buf)
+{
+	return sprintf(buf, "%d\n", atkbd->softrepeat ? 1 : 0);
+}
+
+static ssize_t atkbd_set_softrepeat(struct atkbd *atkbd, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	if (!atkbd->write)
+		return -EIO;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	if (atkbd->softrepeat != value) {
+		/* unregister device as it's properties will change */
+		input_unregister_device(&atkbd->dev);
+		atkbd->softrepeat = value;
+		if (atkbd->softrepeat)
+			atkbd->softraw = 1;
+		atkbd_set_device_attrs(atkbd);
+		input_register_device(&atkbd->dev);
+	}
+
+	return count;
+}
+
+
+static ssize_t atkbd_show_softraw(struct atkbd *atkbd, char *buf)
+{
+	return sprintf(buf, "%d\n", atkbd->softraw ? 1 : 0);
+}
+
+static ssize_t atkbd_set_softraw(struct atkbd *atkbd, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	if (atkbd->softraw != value) {
+		/* unregister device as it's properties will change */
+		input_unregister_device(&atkbd->dev);
+		atkbd->softraw = value;
+		atkbd_set_device_attrs(atkbd);
+		input_register_device(&atkbd->dev);
+	}
+	return count;
+}
+
 
 int __init atkbd_init(void)
 {
