Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUFGM1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUFGM1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUFGM0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:26:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7297 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264561AbUFGLz6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:58 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093531704@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093532639@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 20/39] input: Create input_set_abs_params()
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.27, 2004-04-23 02:51:39-05:00, dtor_core@ameritech.net
  Input: - move set_abs_params from synaptics driver to input and
           rename to input_set_abs_params
         - convert input_report_* macros into inline functions
         - make use of set_abs_params in touchscreen drivers


 drivers/input/mouse/synaptics.c            |   17 +-------
 drivers/input/touchscreen/gunze.c          |    6 --
 drivers/input/touchscreen/h3600_ts_input.c |   14 ++----
 include/linux/input.h                      |   59 ++++++++++++++++++++++++-----
 4 files changed, 61 insertions(+), 35 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-07 13:12:03 +02:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-07 13:12:03 +02:00
@@ -485,25 +485,14 @@
 /*****************************************************************************
  *	Driver initialization/cleanup functions
  ****************************************************************************/
-
-static inline void set_abs_params(struct input_dev *dev, int axis, int min, int max, int fuzz, int flat)
-{
-	dev->absmin[axis] = min;
-	dev->absmax[axis] = max;
-	dev->absfuzz[axis] = fuzz;
-	dev->absflat[axis] = flat;
-
-	set_bit(axis, dev->absbit);
-}
-
 static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
 	int i;
 
 	set_bit(EV_ABS, dev->evbit);
-	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
-	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
-	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+	input_set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
+	input_set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
+	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 	set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
 	set_bit(EV_KEY, dev->evbit);
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-06-07 13:12:03 +02:00
+++ b/drivers/input/touchscreen/gunze.c	2004-06-07 13:12:03 +02:00
@@ -125,11 +125,9 @@
 
 	init_input_dev(&gunze->dev);
 	gunze->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	gunze->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 	gunze->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-
-	gunze->dev.absmin[ABS_X] = 96;   gunze->dev.absmin[ABS_Y] = 72;
-	gunze->dev.absmax[ABS_X] = 4000; gunze->dev.absmax[ABS_Y] = 3000;
+	input_set_abs_params(&gunze->dev, ABS_X, 96, 4000, 0, 0);
+	input_set_abs_params(&gunze->dev, ABS_Y, 72, 3000, 0, 0);
 
 	gunze->serio = serio;
 	serio->private = gunze;
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:12:03 +02:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:12:03 +02:00
@@ -397,17 +397,12 @@
 		kfree(ts);
 		return;
 	}
+
 	/* Now we have things going we setup our input device */
 	ts->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_LED) | BIT(EV_PWR);
-	ts->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 	ts->dev.ledbit[0] = BIT(LED_SLEEP);
-
-	ts->dev.absmin[ABS_X] = 60;   ts->dev.absmin[ABS_Y] = 35;
-	ts->dev.absmax[ABS_X] = 985; ts->dev.absmax[ABS_Y] = 1024;
-	ts->dev.absfuzz[ABS_X] = 0; ts->dev.absfuzz[ABS_Y] = 0;
-
-	ts->serio = serio;
-	serio->private = ts;
+	input_set_abs_params(&ts->dev, ABS_X, 60, 985, 0, 0);
+	input_set_abs_params(&ts->dev, ABS_Y, 35, 1024, 0, 0);
 
 	set_bit(KEY_RECORD, ts->dev.keybit);
 	set_bit(KEY_Q, ts->dev.keybit);
@@ -421,6 +416,9 @@
 	set_bit(KEY_ENTER, ts->dev.keybit);
 	ts->dev.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
 	ts->dev.keybit[LONG(KEY_SUSPEND)] |= BIT(KEY_SUSPEND);
+
+	ts->serio = serio;
+	serio->private = ts;
 
 	sprintf(ts->phys, "%s/input0", serio->phys);
 
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2004-06-07 13:12:03 +02:00
+++ b/include/linux/input.h	2004-06-07 13:12:03 +02:00
@@ -749,8 +749,6 @@
 #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
 	((dev->keycodesize == 2) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))
 
-#define init_input_dev(dev)	do { INIT_LIST_HEAD(&((dev)->h_list)); INIT_LIST_HEAD(&((dev)->node)); } while (0)
-
 #define SET_INPUT_KEYCODE(dev, scancode, val)			\
 		({	unsigned __old;				\
 		switch (dev->keycodesize) {			\
@@ -915,6 +913,12 @@
 #define to_handle(n) container_of(n,struct input_handle,d_node)
 #define to_handle_h(n) container_of(n,struct input_handle,h_node)
 
+static inline void init_input_dev(struct input_dev *dev)
+{
+	INIT_LIST_HEAD(&dev->h_list);
+	INIT_LIST_HEAD(&dev->node);
+}
+
 void input_register_device(struct input_dev *);
 void input_unregister_device(struct input_dev *);
 
@@ -932,14 +936,51 @@
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
-#define input_report_key(a,b,c) input_event(a, EV_KEY, b, !!(c))
-#define input_report_rel(a,b,c) input_event(a, EV_REL, b, c)
-#define input_report_abs(a,b,c) input_event(a, EV_ABS, b, c)
-#define input_report_ff(a,b,c)	input_event(a, EV_FF, b, c)
-#define input_report_ff_status(a,b,c)	input_event(a, EV_FF_STATUS, b, c)
+static inline void input_report_key(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_KEY, code, !!value);
+}
+
+static inline void input_report_rel(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_REL, code, value);
+}
+
+static inline void input_report_abs(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_ABS, code, value);
+}
+
+static inline void input_report_ff(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_FF, code, value);
+}
+
+static inline void input_report_ff_status(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_FF_STATUS, code, value);
+}
+
+static inline void input_regs(struct input_dev *dev, struct pt_regs *regs)
+{
+	dev->regs = regs;
+}
+
+static inline void input_sync(struct input_dev *dev)
+{
+	input_event(dev, EV_SYN, SYN_REPORT, 0);
+	dev->regs = NULL;
+}
+
+static inline void input_set_abs_params(struct input_dev *dev, int axis, int min, int max, int fuzz, int flat)
+{
+	dev->absmin[axis] = min;
+	dev->absmax[axis] = max;
+	dev->absfuzz[axis] = fuzz;
+	dev->absflat[axis] = flat;
 
-#define input_regs(a,b)		do { (a)->regs = (b); } while (0)
-#define input_sync(a)		do { input_event(a, EV_SYN, SYN_REPORT, 0); (a)->regs = NULL; } while (0)
+	dev->absbit[LONG(axis)] |= BIT(axis);
+}
 
 extern struct class_simple *input_class;
 

