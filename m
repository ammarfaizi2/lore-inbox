Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKTGrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKTGrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVKTGrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:12 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:60549 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750729AbVKTGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:11 -0500
Message-Id: <20051120064419.441325000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 01/14] atkbd - speed up setting leds/repeat state
Content-Disposition: inline; filename=atkbd-led-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: atkbd - speed up setting leds/repeat state

Changing led state is pretty slow operation; when there are multiple
requests coming at a high rate they may interfere with normal typing.
Try optimize (skip) changing hardware state when multiple requests
are coming back-to-back.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |   99 ++++++++++++++++++++++++++++-------------
 1 files changed, 68 insertions(+), 31 deletions(-)

Index: work/drivers/input/keyboard/atkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -166,6 +166,9 @@ static unsigned char atkbd_unxlate_table
 
 #define ATKBD_SPECIAL		248
 
+#define ATKBD_LED_EVENT_BIT	0
+#define ATKBD_REP_EVENT_BIT	1
+
 static struct {
 	unsigned char keycode;
 	unsigned char set2;
@@ -211,6 +214,10 @@ struct atkbd {
 	unsigned char err_xl;
 	unsigned int last;
 	unsigned long time;
+
+	struct work_struct event_work;
+	struct semaphore event_sem;
+	unsigned long event_mask;
 };
 
 static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
@@ -424,58 +431,86 @@ out:
 }
 
 /*
- * Event callback from the input module. Events that change the state of
- * the hardware are processed here.
+ * atkbd_event_work() is used to complete processing of events that
+ * can not be processed by input_event() which is often called from
+ * interrupt context.
  */
 
-static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static void atkbd_event_work(void *data)
 {
-	struct atkbd *atkbd = dev->private;
 	const short period[32] =
 		{ 33,  37,  42,  46,  50,  54,  58,  63,  67,  75,  83,  92, 100, 109, 116, 125,
 		 133, 149, 167, 182, 200, 217, 232, 250, 270, 303, 333, 370, 400, 435, 470, 500 };
 	const short delay[4] =
 		{ 250, 500, 750, 1000 };
+
+	struct atkbd *atkbd = data;
+	struct input_dev *dev = atkbd->dev;
 	unsigned char param[2];
 	int i, j;
 
+	down(&atkbd->event_sem);
+
+	if (test_and_clear_bit(ATKBD_LED_EVENT_BIT, &atkbd->event_mask)) {
+		param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
+			 | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
+			 | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
+		ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS);
+
+		if (atkbd->extra) {
+			param[0] = 0;
+			param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
+				 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
+				 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
+				 | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
+				 | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
+			ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_EX_SETLEDS);
+		}
+	}
+
+	if (test_and_clear_bit(ATKBD_REP_EVENT_BIT, &atkbd->event_mask)) {
+		i = j = 0;
+		while (i < 31 && period[i] < dev->rep[REP_PERIOD])
+			i++;
+		while (j < 3 && delay[j] < dev->rep[REP_DELAY])
+			j++;
+		dev->rep[REP_PERIOD] = period[i];
+		dev->rep[REP_DELAY] = delay[j];
+		param[0] = i | (j << 5);
+		ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
+	}
+
+	up(&atkbd->event_sem);
+}
+
+/*
+ * Event callback from the input module. Events that change the state of
+ * the hardware are processed here. If action can not be performed in
+ * interrupt context it is offloaded to atkbd_event_work.
+ */
+
+static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct atkbd *atkbd = dev->private;
+
 	if (!atkbd->write)
 		return -1;
 
 	switch (type) {
 
 		case EV_LED:
-
-			param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
-			         | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
-			         | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
-		        ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS);
-
-			if (atkbd->extra) {
-				param[0] = 0;
-				param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
-					 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
-					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
-				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
-				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
-				ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_EX_SETLEDS);
-			}
-
+			set_bit(ATKBD_LED_EVENT_BIT, &atkbd->event_mask);
+			wmb();
+			schedule_work(&atkbd->event_work);
 			return 0;
 
 		case EV_REP:
 
-			if (atkbd->softrepeat) return 0;
-
-			i = j = 0;
-			while (i < 31 && period[i] < dev->rep[REP_PERIOD])
-				i++;
-			while (j < 3 && delay[j] < dev->rep[REP_DELAY])
-				j++;
-			dev->rep[REP_PERIOD] = period[i];
-			dev->rep[REP_DELAY] = delay[j];
-			param[0] = i | (j << 5);
-			ps2_schedule_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
+			if (!atkbd->softrepeat) {
+				set_bit(ATKBD_REP_EVENT_BIT, &atkbd->event_mask);
+				wmb();
+				schedule_work(&atkbd->event_work);
+			}
 
 			return 0;
 	}
@@ -810,6 +845,8 @@ static int atkbd_connect(struct serio *s
 
 	atkbd->dev = dev;
 	ps2_init(&atkbd->ps2dev, serio);
+	INIT_WORK(&atkbd->event_work, atkbd_event_work, atkbd);
+	init_MUTEX(&atkbd->event_sem);
 
 	switch (serio->id.type) {
 

