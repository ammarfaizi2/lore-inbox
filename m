Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVKCEbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVKCEbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVKCEbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:31:35 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:31607 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030319AbVKCEbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:31:23 -0500
Message-Id: <20051103042818.847868000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 7/7] lkkbd: misc fixes
Content-Disposition: inline; filename=lkkbd-misc-fixes.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan-Benedict Glaw <jbglaw@lug-owl.de>

Input: lkkbd - miscellaneous fixes

* Hide debugging code into #ifdef, which allows to simplify
  the large switch statement
* Update macros to not reference variables not given as
  arguments

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/lkkbd.c |  101 +++++++++++++++++++++++------------------
 1 files changed, 59 insertions(+), 42 deletions(-)

Index: work/drivers/input/keyboard/lkkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/lkkbd.c
+++ work/drivers/input/keyboard/lkkbd.c
@@ -273,11 +273,11 @@ static lk_keycode_t lkkbd_keycode[LK_NUM
 	[0xfb] = KEY_APOSTROPHE,
 };
 
-#define CHECK_LED(LED, BITS) do {		\
-	if (test_bit (LED, lk->dev->led))	\
-		leds_on |= BITS;		\
-	else					\
-		leds_off |= BITS;		\
+#define CHECK_LED(LK, VAR_ON, VAR_OFF, LED, BITS) do {		\
+	if (test_bit (LED, (LK)->dev->led))			\
+		VAR_ON |= BITS;					\
+	else							\
+		VAR_OFF |= BITS;				\
 	} while (0)
 
 /*
@@ -298,6 +298,42 @@ struct lkkbd {
 	int ctrlclick_volume;
 };
 
+#ifdef LKKBD_DEBUG
+/*
+ * Responses from the keyboard and mapping back to their names.
+ */
+static struct {
+	unsigned char value;
+	unsigned char *name;
+} lk_response[] = {
+#define RESPONSE(x) { .value = (x), .name = #x, }
+	RESPONSE (LK_STUCK_KEY),
+	RESPONSE (LK_SELFTEST_FAILED),
+	RESPONSE (LK_ALL_KEYS_UP),
+	RESPONSE (LK_METRONOME),
+	RESPONSE (LK_OUTPUT_ERROR),
+	RESPONSE (LK_INPUT_ERROR),
+	RESPONSE (LK_KBD_LOCKED),
+	RESPONSE (LK_KBD_TEST_MODE_ACK),
+	RESPONSE (LK_PREFIX_KEY_DOWN),
+	RESPONSE (LK_MODE_CHANGE_ACK),
+	RESPONSE (LK_RESPONSE_RESERVED),
+#undef RESPONSE
+};
+
+static unsigned char *
+response_name (unsigned char value)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE (lk_response); i++)
+		if (lk_response[i].value == value)
+			return lk_response[i].name;
+
+	return "<unknown>";
+}
+#endif /* LKKBD_DEBUG */
+
 /*
  * Calculate volume parameter byte for a given volume.
  */
@@ -440,43 +476,24 @@ lkkbd_interrupt (struct serio *serio, un
 					input_report_key (lk->dev, lk->keycode[i], 0);
 			input_sync (lk->dev);
 			break;
-		case LK_METRONOME:
-			DBG (KERN_INFO "Got LK_METRONOME and don't "
-					"know how to handle...\n");
+
+		case 0x01:
+			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
+			lk->ignore_bytes = LK_NUM_IGNORE_BYTES;
+			lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] = data;
+			schedule_work (&lk->tq);
 			break;
+
+		case LK_METRONOME:
 		case LK_OUTPUT_ERROR:
-			DBG (KERN_INFO "Got LK_OUTPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_INPUT_ERROR:
-			DBG (KERN_INFO "Got LK_INPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_LOCKED:
-			DBG (KERN_INFO "Got LK_KBD_LOCKED and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_TEST_MODE_ACK:
-			DBG (KERN_INFO "Got LK_KBD_TEST_MODE_ACK and don't "
-					"know how to handle...\n");
-			break;
 		case LK_PREFIX_KEY_DOWN:
-			DBG (KERN_INFO "Got LK_PREFIX_KEY_DOWN and don't "
-					"know how to handle...\n");
-			break;
 		case LK_MODE_CHANGE_ACK:
-			DBG (KERN_INFO "Got LK_MODE_CHANGE_ACK and ignored "
-					"it properly...\n");
-			break;
 		case LK_RESPONSE_RESERVED:
-			DBG (KERN_INFO "Got LK_RESPONSE_RESERVED and don't "
-					"know how to handle...\n");
-			break;
-		case 0x01:
-			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
-			lk->ignore_bytes = LK_NUM_IGNORE_BYTES;
-			lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] = data;
-			schedule_work (&lk->tq);
+			DBG (KERN_INFO "Got %s and don't know how to handle...\n",
+					response_name (data));
 			break;
 
 		default:
@@ -509,10 +526,10 @@ lkkbd_event (struct input_dev *dev, unsi
 
 	switch (type) {
 		case EV_LED:
-			CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
-			CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
-			CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
-			CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+			CHECK_LED (lk, leds_on, leds_off, LED_CAPSL, LK_LED_SHIFTLOCK);
+			CHECK_LED (lk, leds_on, leds_off, LED_COMPOSE, LK_LED_COMPOSE);
+			CHECK_LED (lk, leds_on, leds_off, LED_SCROLLL, LK_LED_SCROLLLOCK);
+			CHECK_LED (lk, leds_on, leds_off, LED_SLEEP, LK_LED_WAIT);
 			if (leds_on != 0) {
 				lk->serio->write (lk->serio, LK_CMD_LED_ON);
 				lk->serio->write (lk->serio, leds_on);
@@ -574,10 +591,10 @@ lkkbd_reinit (void *data)
 	lk->serio->write (lk->serio, LK_CMD_SET_DEFAULTS);
 
 	/* Set LEDs */
-	CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
-	CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
-	CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
-	CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+	CHECK_LED (lk, leds_on, leds_off, LED_CAPSL, LK_LED_SHIFTLOCK);
+	CHECK_LED (lk, leds_on, leds_off, LED_COMPOSE, LK_LED_COMPOSE);
+	CHECK_LED (lk, leds_on, leds_off, LED_SCROLLL, LK_LED_SCROLLLOCK);
+	CHECK_LED (lk, leds_on, leds_off, LED_SLEEP, LK_LED_WAIT);
 	if (leds_on != 0) {
 		lk->serio->write (lk->serio, LK_CMD_LED_ON);
 		lk->serio->write (lk->serio, leds_on);

