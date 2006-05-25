Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWEYB1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWEYB1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWEYB1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31630 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964826AbWEYB1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:04 -0400
Message-Id: <20060525003421.958272000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:49 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] restore amikbd compatibility with 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dump the extra mapping in the amikbd interrupt handler, so old Amiga
keymaps work again. Amigas need a special keymap anyway, standard
keymaps are not usable and recreating all keymaps is simply not worth
the trouble.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/input/keyboard/amikbd.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

Index: linux-2.6-mm/drivers/input/keyboard/amikbd.c
===================================================================
--- linux-2.6-mm.orig/drivers/input/keyboard/amikbd.c
+++ linux-2.6-mm/drivers/input/keyboard/amikbd.c
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/keyboard.h>
 
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
@@ -45,7 +46,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
 MODULE_DESCRIPTION("Amiga keyboard driver");
 MODULE_LICENSE("GPL");
 
-static unsigned char amikbd_keycode[0x78] = {
+static unsigned char amikbd_keycode[0x78] __initdata = {
 	[0]	 = KEY_GRAVE,
 	[1]	 = KEY_1,
 	[2]	 = KEY_2,
@@ -170,12 +171,9 @@ static irqreturn_t amikbd_interrupt(int 
 	scancode >>= 1;
 
 	if (scancode < 0x78) {		/* scancodes < 0x78 are keys */
-
-		scancode = amikbd_keycode[scancode];
-
 		input_regs(amikbd_dev, fp);
 
-		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
+		if (scancode == 98) {	/* CapsLock is a toggle switch key on Amiga */
 			input_report_key(amikbd_dev, scancode, 1);
 			input_report_key(amikbd_dev, scancode, 0);
 		} else {
@@ -191,7 +189,7 @@ static irqreturn_t amikbd_interrupt(int 
 
 static int __init amikbd_init(void)
 {
-	int i;
+	int i, j;
 
 	if (!AMIGAHW_PRESENT(AMI_KEYBOARD))
 		return -EIO;
@@ -214,14 +212,26 @@ static int __init amikbd_init(void)
 	amikbd_dev->id.version = 0x0100;
 
 	amikbd_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-	amikbd_dev->keycode = amikbd_keycode;
-	amikbd_dev->keycodesize = sizeof(unsigned char);
-	amikbd_dev->keycodemax = ARRAY_SIZE(amikbd_keycode);
 
 	for (i = 0; i < 0x78; i++)
-		if (amikbd_keycode[i])
-			set_bit(amikbd_keycode[i], amikbd_dev->keybit);
+		set_bit(i, amikbd_dev->keybit);
 
+	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
+		static u_short temp_map[NR_KEYS] __initdata;
+		if (!key_maps[i])
+			continue;
+		memset(temp_map, 0, sizeof(temp_map));
+		for (j = 0; j < 0x78; j++) {
+			if (!amikbd_keycode[j])
+				continue;
+			temp_map[j] = key_maps[i][amikbd_keycode[j]];
+		}
+		for (j = 0; j < NR_KEYS; j++) {
+			if (!temp_map[j])
+				temp_map[j] = 0xf200;
+		}
+		memcpy(key_maps[i], temp_map, sizeof(temp_map));
+	}
 	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
 	request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd", amikbd_interrupt);
 

--

