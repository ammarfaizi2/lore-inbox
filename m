Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVAMGs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVAMGs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVAMGs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:48:59 -0500
Received: from waste.org ([216.27.176.166]:25988 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261172AbVAMGsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:48:14 -0500
Date: Wed, 12 Jan 2005 22:48:08 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] random add_input_randomness
Message-ID: <20050113064808.GA2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The input layer wants to send us an entropy event per input event and
who are we to argue? Create add_input_randomness with an
input-friendly interface and kill the remaining two keyboard and mouse
sources.

This eliminates lots of duplicate entropy events while covering all
the input bases nicely. We now get two events per keystroke as we
should, one down and one up.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:27:57.406846542 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:27:58.178748133 -0800
@@ -125,15 +125,12 @@
  * The current exported interfaces for gathering environmental noise
  * from the devices are:
  *
- * 	void add_keyboard_randomness(unsigned char scancode);
- * 	void add_mouse_randomness(__u32 mouse_data);
+ * 	void add_input_randomness(unsigned int type, unsigned int code,
+ *                                unsigned int value);
  * 	void add_interrupt_randomness(int irq);
  *
- * add_keyboard_randomness() uses the inter-keypress timing, as well as the
- * scancode as random inputs into the "entropy pool".
- *
- * add_mouse_randomness() uses the mouse interrupt timing, as well as
- * the reported position of the mouse from the hardware.
+ * add_input_randomness() uses the input layer interrupt timing, as well as
+ * the event type information from the hardware.
  *
  * add_interrupt_randomness() uses the inter-interrupt timing as random
  * inputs to the entropy pool.  Note that not all interrupts are good
@@ -788,8 +785,7 @@
 	unsigned dont_count_entropy:1;
 };
 
-static struct timer_rand_state keyboard_timer_state;
-static struct timer_rand_state mouse_timer_state;
+static struct timer_rand_state input_timer_state;
 static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 
@@ -869,24 +865,20 @@
 	preempt_enable();
 }
 
-void add_keyboard_randomness(unsigned char scancode)
+extern void add_input_randomness(unsigned int type, unsigned int code,
+				 unsigned int value)
 {
-	static unsigned char last_scancode;
-	/* ignore autorepeat (multiple key down w/o key up) */
-	DEBUG_ENT("keyboard event\n");
-	if (scancode != last_scancode) {
-		last_scancode = scancode;
-		add_timer_randomness(&keyboard_timer_state, scancode);
-	}
-}
+	static unsigned char last_value;
 
-void add_mouse_randomness(__u32 mouse_data)
-{
-	DEBUG_ENT("mouse event\n");
-	add_timer_randomness(&mouse_timer_state, mouse_data);
-}
+	/* ignore autorepeat and the like */
+	if (value == last_value)
+		return;
 
-EXPORT_SYMBOL(add_mouse_randomness);
+	DEBUG_ENT("input event\n");
+	last_value = value;
+	add_timer_randomness(&input_timer_state,
+			     (type << 4) ^ code ^ (code >> 4) ^ value);
+}
 
 void add_interrupt_randomness(int irq)
 {
@@ -1550,8 +1542,7 @@
 #endif
 	for (i = 0; i < NR_IRQS; i++)
 		irq_timer_state[i] = NULL;
-	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
+	memset(&input_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
 	return 0;
Index: rnd/drivers/input/input.c
===================================================================
--- rnd.orig/drivers/input/input.c	2005-01-12 21:27:21.554417338 -0800
+++ rnd/drivers/input/input.c	2005-01-12 21:27:58.179748005 -0800
@@ -73,7 +73,7 @@
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
-	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
+	add_input_randomness(type, code, value);
 
 	switch (type) {
 
Index: rnd/drivers/char/qtronix.c
===================================================================
--- rnd.orig/drivers/char/qtronix.c	2005-01-12 21:27:21.567415680 -0800
+++ rnd/drivers/char/qtronix.c	2005-01-12 21:27:58.180747878 -0800
@@ -69,7 +69,6 @@
 #include <linux/init.h>
 #include <linux/kbd_ll.h>
 #include <linux/delay.h>
-#include <linux/random.h>
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
@@ -442,7 +441,6 @@
 		return;
 	}
 
-	add_mouse_randomness(scancode);
 	if (aux_count) {
 		int head = queue->head;
 
Index: rnd/drivers/char/keyboard.c
===================================================================
--- rnd.orig/drivers/char/keyboard.c	2005-01-12 21:27:21.554417338 -0800
+++ rnd/drivers/char/keyboard.c	2005-01-12 21:27:58.181747750 -0800
@@ -31,7 +31,6 @@
 #include <linux/tty_flip.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/random.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 
@@ -1040,9 +1039,6 @@
 	struct tty_struct *tty;
 	int shift_final;
 
-	if (down != 2)
-		add_keyboard_randomness((keycode << 1) ^ down);
-
 	tty = vc->vc_tty;
 
 	if (tty && (!tty->driver_data)) {
Index: rnd/include/linux/random.h
===================================================================
--- rnd.orig/include/linux/random.h	2005-01-12 21:27:21.567415680 -0800
+++ rnd/include/linux/random.h	2005-01-12 21:27:58.183747495 -0800
@@ -44,8 +44,8 @@
 
 extern void rand_initialize_irq(int irq);
 
-extern void add_keyboard_randomness(unsigned char scancode);
-extern void add_mouse_randomness(__u32 mouse_data);
+extern void add_input_randomness(unsigned int type, unsigned int code,
+				 unsigned int value);
 extern void add_interrupt_randomness(int irq);
 
 extern void get_random_bytes(void *buf, int nbytes);


-- 
Mathematics is the supreme nostalgia of our time.
