Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVG2J4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVG2J4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVG2JrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:11 -0400
Received: from tim.rpsys.net ([194.106.48.114]:64703 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262557AbVG2Jq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:59 -0400
Subject: [patch 3/8] Corgi Keyboard: Code tidying
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:42 +0100
Message-Id: <1122630402.7747.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The input system handles key state tracking so there's no need for 
the driver to do so as well. Also tidy up some comment formatting 
and remove a now unneeded function.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.12.orig/drivers/input/keyboard/corgikbd.c	2005-07-28 16:42:54.000000000 +0100
+++ linux-2.6.12/drivers/input/keyboard/corgikbd.c	2005-07-28 16:58:01.000000000 +0100
@@ -33,7 +33,6 @@
 /* zero code, 124 scancodes + 3 hinge combinations */
 #define	NR_SCANCODES		( SCANCODE(KB_ROWS-1,KB_COLS-1) +1 +1 +3 )
 #define SCAN_INTERVAL		(HZ/10)
-#define CORGIKBD_PRESSED	1
 
 #define HINGE_SCAN_INTERVAL		(HZ/4)
 
@@ -74,9 +73,7 @@
 	struct input_dev input;
 	char phys[32];
 
-	unsigned char state[ARRAY_SIZE(corgikbd_keycode)];
 	spinlock_t lock;
-
 	struct timer_list timer;
 	struct timer_list htimer;
 
@@ -84,22 +81,6 @@
 	unsigned long suspend_jiffies;
 };
 
-static void handle_scancode(unsigned int pressed,unsigned int scancode, struct corgikbd *corgikbd_data)
-{
-	if (pressed && !(corgikbd_data->state[scancode] & CORGIKBD_PRESSED)) {
-		corgikbd_data->state[scancode] |= CORGIKBD_PRESSED;
-		input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], 1);
-		if ((corgikbd_data->keycode[scancode] == CORGI_KEY_OFF)
-				&& time_after(jiffies, corgikbd_data->suspend_jiffies + HZ)) {
-			input_event(&corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
-			corgikbd_data->suspend_jiffies=jiffies;
-		}
-	} else if (!pressed && corgikbd_data->state[scancode] & CORGIKBD_PRESSED) {
-		corgikbd_data->state[scancode] &= ~CORGIKBD_PRESSED;
-		input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], 0);
-	}
-}
-
 #define KB_DISCHARGE_DELAY	10
 #define KB_ACTIVATE_DELAY	10
 
@@ -112,36 +93,36 @@
  */
 static inline void corgikbd_discharge_all(void)
 {
-	// STROBE All HiZ
+	/* STROBE All HiZ */
 	GPCR2  = CORGI_GPIO_ALL_STROBE_BIT;
 	GPDR2 &= ~CORGI_GPIO_ALL_STROBE_BIT;
 }
 
 static inline void corgikbd_activate_all(void)
 {
-	// STROBE ALL -> High
+	/* STROBE ALL -> High */
 	GPSR2  = CORGI_GPIO_ALL_STROBE_BIT;
 	GPDR2 |= CORGI_GPIO_ALL_STROBE_BIT;
 
 	udelay(KB_DISCHARGE_DELAY);
 
-	// Clear any interrupts we may have triggered when altering the GPIO lines
+	/* Clear any interrupts we may have triggered when altering the GPIO lines */
 	GEDR1 = CORGI_GPIO_HIGH_SENSE_BIT;
 	GEDR2 = CORGI_GPIO_LOW_SENSE_BIT;
 }
 
 static inline void corgikbd_activate_col(int col)
 {
-	// STROBE col -> High, not col -> HiZ
+	/* STROBE col -> High, not col -> HiZ */
 	GPSR2 = CORGI_GPIO_STROBE_BIT(col);
 	GPDR2 = (GPDR2 & ~CORGI_GPIO_ALL_STROBE_BIT) | CORGI_GPIO_STROBE_BIT(col);
 }
 
 static inline void corgikbd_reset_col(int col)
 {
-	// STROBE col -> Low
+	/* STROBE col -> Low */
 	GPCR2 = CORGI_GPIO_STROBE_BIT(col);
-	// STROBE col -> out, not col -> HiZ
+	/* STROBE col -> out, not col -> HiZ */
 	GPDR2 = (GPDR2 & ~CORGI_GPIO_ALL_STROBE_BIT) | CORGI_GPIO_STROBE_BIT(col);
 }
 
@@ -156,7 +137,7 @@
 /* Scan the hardware keyboard and push any changes up through the input layer */
 static void corgikbd_scankeyboard(struct corgikbd *corgikbd_data, struct pt_regs *regs)
 {
-	unsigned int row, col, rowd, scancode;
+	unsigned int row, col, rowd;
 	unsigned long flags;
 	unsigned int num_pressed;
 
@@ -183,10 +164,21 @@
 
 		rowd = GET_ROWS_STATUS(col);
 		for (row = 0; row < KB_ROWS; row++) {
+			unsigned int scancode, pressed;
+
 			scancode = SCANCODE(row, col);
-			handle_scancode((rowd & KB_ROWMASK(row)), scancode, corgikbd_data);
-			if (rowd & KB_ROWMASK(row))
+			pressed = rowd & KB_ROWMASK(row);
+
+			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], pressed);
+
+			if (pressed) 
 				num_pressed++;
+
+			if (pressed && (corgikbd_data->keycode[scancode] == CORGI_KEY_OFF)
+					&& time_after(jiffies, corgikbd_data->suspend_jiffies + HZ)) {
+				input_event(&corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
+				corgikbd_data->suspend_jiffies=jiffies;
+			}
 		}
 		corgikbd_reset_col(col);
 	}
@@ -231,8 +223,11 @@
  * The hinge switches generate no interrupt so they need to be
  * monitored by a timer.
  *
- * When we detect changes, we debounce it and then pass the three
- * positions the system can take as keypresses to the input system.
+ * We debounce the switches and pass them to the input system.
+ *   
+ *  gprr == 0x00 - Keyboard with Landscape Screen
+ *          0x08 - No Keyboard with Portrait Screen
+ *          0x0c - Keyboard and Screen Closed
  */
 
 #define HINGE_STABLE_COUNT 2
@@ -254,9 +249,9 @@
 		if (hinge_count >= HINGE_STABLE_COUNT) {
 			spin_lock_irqsave(&corgikbd_data->lock, flags);
 
-			handle_scancode((sharpsl_hinge_state == 0x00), 125, corgikbd_data); /* Keyboard with Landscape Screen */
-			handle_scancode((sharpsl_hinge_state == 0x08), 126, corgikbd_data); /* No Keyboard with Portrait Screen */
-			handle_scancode((sharpsl_hinge_state == 0x0c), 127, corgikbd_data); /* Keyboard and Screen Closed  */
+			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[125], (sharpsl_hinge_state == 0x00));
+			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[126], (sharpsl_hinge_state == 0x08));
+			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[127], (sharpsl_hinge_state == 0x0c));
 			input_sync(&corgikbd_data->input);
 
 			spin_unlock_irqrestore(&corgikbd_data->lock, flags);


