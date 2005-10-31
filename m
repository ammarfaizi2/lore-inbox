Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVJaHYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVJaHYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVJaHYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:24:06 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:25776 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932300AbVJaHYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:24:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: [RFT/PATCH] atkbd - speed up setting leds/repeat state
Date: Mon, 31 Oct 2005 02:24:02 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310224.03010.dtor_core@ameritech.net>
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
 
