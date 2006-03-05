Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCEAG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCEAG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWCEAG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:06:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:38584 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932108AbWCEAG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:06:28 -0500
Subject: [patch] zaurus keyboard driver updates
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 00:06:05 +0000
Message-Id: <1141517165.10871.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zaurus keyboard driver updates:
  * Change the scan interval from 100ms to 50ms. This stops the key 
    repeat from triggering on double letter presses.
  * Remove unneeded stale hinge code from corgikbd
  * Change unneeded corgi GPIO pins to inputs when suspended
  * Add support for the headphone jack switch for both corgi and spitz
    (as switch SW_2)

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.15.orig/drivers/input/keyboard/corgikbd.c	2006-03-04 23:08:30.000000000 +0000
+++ linux-2.6.15/drivers/input/keyboard/corgikbd.c	2006-03-04 23:10:07.000000000 +0000
@@ -29,11 +29,11 @@
 #define KB_COLS				12
 #define KB_ROWMASK(r)		(1 << (r))
 #define SCANCODE(r,c)		( ((r)<<4) + (c) + 1 )
-/* zero code, 124 scancodes + 3 hinge combinations */
-#define	NR_SCANCODES		( SCANCODE(KB_ROWS-1,KB_COLS-1) +1 +1 +3 )
-#define SCAN_INTERVAL		(HZ/10)
+/* zero code, 124 scancodes */
+#define	NR_SCANCODES		( SCANCODE(KB_ROWS-1,KB_COLS-1) +1 +1 )
 
-#define HINGE_SCAN_INTERVAL		(HZ/4)
+#define SCAN_INTERVAL		(50) /* ms */
+#define HINGE_SCAN_INTERVAL	(250) /* ms */
 
 #define CORGI_KEY_CALENDER	KEY_F1
 #define CORGI_KEY_ADDRESS	KEY_F2
@@ -49,9 +49,6 @@
 #define CORGI_KEY_MAIL		KEY_F10
 #define CORGI_KEY_OK		KEY_F11
 #define CORGI_KEY_MENU		KEY_F12
-#define CORGI_HINGE_0		KEY_KP0
-#define CORGI_HINGE_1		KEY_KP1
-#define CORGI_HINGE_2		KEY_KP2
 
 static unsigned char corgikbd_keycode[NR_SCANCODES] = {
 	0,                                                                                                                /* 0 */
@@ -63,7 +60,6 @@
 	CORGI_KEY_MAIL, KEY_Z, KEY_X, KEY_MINUS, KEY_SPACE, KEY_COMMA, 0, KEY_UP, 0, 0, 0, CORGI_KEY_FN, 0, 0, 0, 0,            /* 81-96 */
 	KEY_SYSRQ, CORGI_KEY_JAP1, CORGI_KEY_JAP2, CORGI_KEY_CANCEL, CORGI_KEY_OK, CORGI_KEY_MENU, KEY_LEFT, KEY_DOWN, KEY_RIGHT, 0, 0, 0, 0, 0, 0, 0,  /* 97-112 */
 	CORGI_KEY_OFF, CORGI_KEY_EXOK, CORGI_KEY_EXCANCEL, CORGI_KEY_EXJOGDOWN, CORGI_KEY_EXJOGUP, 0, 0, 0, 0, 0, 0, 0,   /* 113-124 */
-	CORGI_HINGE_0, CORGI_HINGE_1, CORGI_HINGE_2	  /* 125-127 */
 };
 
 
@@ -187,7 +183,7 @@
 
 	/* if any keys are pressed, enable the timer */
 	if (num_pressed)
-		mod_timer(&corgikbd_data->timer, jiffies + SCAN_INTERVAL);
+		mod_timer(&corgikbd_data->timer, jiffies + msecs_to_jiffies(SCAN_INTERVAL));
 
 	spin_unlock_irqrestore(&corgikbd_data->lock, flags);
 }
@@ -228,6 +224,7 @@
  *          0x0c - Keyboard and Screen Closed
  */
 
+#define READ_GPIO_BIT(x)    (GPLR(x) & GPIO_bit(x))
 #define HINGE_STABLE_COUNT 2
 static int sharpsl_hinge_state;
 static int hinge_count;
@@ -239,6 +236,7 @@
 	unsigned long flags;
 
 	gprr = read_scoop_reg(&corgiscoop_device.dev, SCOOP_GPRR) & (CORGI_SCP_SWA | CORGI_SCP_SWB);
+	gprr |= (READ_GPIO_BIT(CORGI_GPIO_AK_INT) != 0);
 	if (gprr != sharpsl_hinge_state) {
 		hinge_count = 0;
 		sharpsl_hinge_state = gprr;
@@ -249,27 +247,38 @@
 
 			input_report_switch(corgikbd_data->input, SW_0, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
 			input_report_switch(corgikbd_data->input, SW_1, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
+			input_report_switch(corgikbd_data->input, SW_2, (READ_GPIO_BIT(CORGI_GPIO_AK_INT) != 0));
 			input_sync(corgikbd_data->input);
 
 			spin_unlock_irqrestore(&corgikbd_data->lock, flags);
 		}
 	}
-	mod_timer(&corgikbd_data->htimer, jiffies + HINGE_SCAN_INTERVAL);
+	mod_timer(&corgikbd_data->htimer, jiffies + msecs_to_jiffies(HINGE_SCAN_INTERVAL));
 }
 
 #ifdef CONFIG_PM
 static int corgikbd_suspend(struct platform_device *dev, pm_message_t state)
 {
+	int i;
 	struct corgikbd *corgikbd = platform_get_drvdata(dev);
+
 	corgikbd->suspended = 1;
+	/* strobe 0 is the power key so this can't be made an input for
+	   powersaving therefore i = 1 */
+	for (i = 1; i < CORGI_KEY_STROBE_NUM; i++)
+		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_IN);
 
 	return 0;
 }
 
 static int corgikbd_resume(struct platform_device *dev)
 {
+	int i;
 	struct corgikbd *corgikbd = platform_get_drvdata(dev);
 
+	for (i = 1; i < CORGI_KEY_STROBE_NUM; i++)
+		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_OUT | GPIO_DFLT_HIGH);
+
 	/* Upon resume, ignore the suspend key for a short while */
 	corgikbd->suspend_jiffies=jiffies;
 	corgikbd->suspended = 0;
@@ -333,10 +342,11 @@
 	clear_bit(0, input_dev->keybit);
 	set_bit(SW_0, input_dev->swbit);
 	set_bit(SW_1, input_dev->swbit);
+	set_bit(SW_2, input_dev->swbit);
 
 	input_register_device(corgikbd->input);
 
-	mod_timer(&corgikbd->htimer, jiffies + HINGE_SCAN_INTERVAL);
+	mod_timer(&corgikbd->htimer, jiffies + msecs_to_jiffies(HINGE_SCAN_INTERVAL));
 
 	/* Setup sense interrupts - RisingEdge Detect, sense lines as inputs */
 	for (i = 0; i < CORGI_KEY_SENSE_NUM; i++) {
@@ -351,6 +361,9 @@
 	for (i = 0; i < CORGI_KEY_STROBE_NUM; i++)
 		pxa_gpio_mode(CORGI_GPIO_KEY_STROBE(i) | GPIO_OUT | GPIO_DFLT_HIGH);
 
+	/* Setup the headphone jack as an input */
+	pxa_gpio_mode(CORGI_GPIO_AK_INT | GPIO_IN);
+
 	return 0;
 }
 
Index: linux-2.6.15/drivers/input/keyboard/spitzkbd.c
===================================================================
--- linux-2.6.15.orig/drivers/input/keyboard/spitzkbd.c	2006-03-04 23:08:30.000000000 +0000
+++ linux-2.6.15/drivers/input/keyboard/spitzkbd.c	2006-03-04 23:09:06.000000000 +0000
@@ -30,6 +30,7 @@
 #define SCANCODE(r,c)		(((r)<<4) + (c) + 1)
 #define	NR_SCANCODES		((KB_ROWS<<4) + 1)
 
+#define SCAN_INTERVAL		(50) /* ms */
 #define HINGE_SCAN_INTERVAL	(150) /* ms */
 
 #define SPITZ_KEY_CALENDER	KEY_F1
@@ -230,7 +231,7 @@
 
 	/* if any keys are pressed, enable the timer */
 	if (num_pressed)
-		mod_timer(&spitzkbd_data->timer, jiffies + msecs_to_jiffies(100));
+		mod_timer(&spitzkbd_data->timer, jiffies + msecs_to_jiffies(SCAN_INTERVAL));
 
 	spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
 }
@@ -287,6 +288,7 @@
 	unsigned long flags;
 
 	state = GPLR(SPITZ_GPIO_SWA) & (GPIO_bit(SPITZ_GPIO_SWA)|GPIO_bit(SPITZ_GPIO_SWB));
+	state |= (GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT));
 	if (state != sharpsl_hinge_state) {
 		hinge_count = 0;
 		sharpsl_hinge_state = state;
@@ -299,6 +301,7 @@
 
 		input_report_switch(spitzkbd_data->input, SW_0, ((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) != 0));
 		input_report_switch(spitzkbd_data->input, SW_1, ((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) != 0));
+		input_report_switch(spitzkbd_data->input, SW_2, ((GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT)) != 0));
 		input_sync(spitzkbd_data->input);
 
 		spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
@@ -397,6 +400,7 @@
 	clear_bit(0, input_dev->keybit);
 	set_bit(SW_0, input_dev->swbit);
 	set_bit(SW_1, input_dev->swbit);
+	set_bit(SW_2, input_dev->swbit);
 
 	input_register_device(input_dev);
 
@@ -432,6 +436,9 @@
 	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
 		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
 		    "Spitzkbd SWB", spitzkbd);
+ 	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
+		    SA_INTERRUPT, | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    "Spitzkbd HP", spitzkbd);
 
 	printk(KERN_INFO "input: Spitz Keyboard Registered\n");
 
@@ -450,6 +457,7 @@
 	free_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd);
 	free_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd);
 	free_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd);
+	free_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd);
 
 	del_timer_sync(&spitzkbd->htimer);
 	del_timer_sync(&spitzkbd->timer);


