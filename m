Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVHJRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVHJRRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVHJRRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:17:21 -0400
Received: from mail.aknet.ru ([82.179.72.26]:26126 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S965215AbVHJRRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:17:20 -0400
Message-ID: <42FA369F.3070401@aknet.ru>
Date: Wed, 10 Aug 2005 21:17:19 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] pc-speaker driver update
Content-Type: multipart/mixed;
 boundary="------------050505050906090404020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505050906090404020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Here is the patch that updates the
pcspeaker driver with the following:
1. Use i8253_lock to serialize the
port 0x43 accesses, rather than a
hand-made i8253_beep_lock.
2. Added EV_SYN/SYN_CONFIG event that
allows to disable the driver completely,
either to grant the hardware access to some
other driver, or to disable the annoying
beeps.

Acked-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------050505050906090404020304
Content-Type: text/x-patch;
 name="pcspkr-2.6.13-rc5-01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspkr-2.6.13-rc5-01.diff"

diff -urN linux-2.6.12-rc6/drivers/input/misc/pcspkr.c linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c
--- linux-2.6.12-rc6/drivers/input/misc/pcspkr.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c	2005-06-14 12:57:59.000000000 +0400
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <asm/8253pit.h>
+#include <asm/i8253.h>
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
@@ -26,27 +27,13 @@
 static char pcspkr_name[] = "PC Speaker";
 static char pcspkr_phys[] = "isa0061/input0";
 static struct input_dev pcspkr_dev;
+enum { PCSPKR_NORMAL, PCSPKR_SUSPENDED };
 
-static DEFINE_SPINLOCK(i8253_beep_lock);
-
-static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static void pcspkr_do_sound(unsigned int count)
 {
-	unsigned int count = 0;
 	unsigned long flags;
 
-	if (type != EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}
-
-	if (value > 20 && value < 32767)
-		count = PIT_TICK_RATE / value;
-
-	spin_lock_irqsave(&i8253_beep_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
 
 	if (count) {
 		/* enable counter 2 */
@@ -61,14 +48,48 @@
 		outb(inb_p(0x61) & 0xFC, 0x61);
 	}
 
-	spin_unlock_irqrestore(&i8253_beep_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int count = 0;
+
+	switch (type) {
+		case EV_SND:
+			switch (code) {
+				case SND_BELL: if (value) value = 1000;
+				case SND_TONE: break;
+				default: return -1;
+			}
+			break;
+
+		case EV_SYN:
+			switch (code) {
+				case SYN_CONFIG:
+					dev->state = value ? PCSPKR_SUSPENDED : PCSPKR_NORMAL;
+					return 0;
+				default: return -1;
+			}
+			break;
+
+		default: return -1;
+	}
+
+	if (dev->state == PCSPKR_SUSPENDED)
+		return 0;
+
+	if (value > 20 && value < 32767)
+		count = PIT_TICK_RATE / value;
+
+	pcspkr_do_sound(count);
 
 	return 0;
 }
 
 static int __init pcspkr_init(void)
 {
-	pcspkr_dev.evbit[0] = BIT(EV_SND);
+	pcspkr_dev.evbit[0] = BIT(EV_SND) | BIT(EV_SYN);
 	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
 	pcspkr_dev.event = pcspkr_event;
 
@@ -78,6 +99,7 @@
 	pcspkr_dev.id.vendor = 0x001f;
 	pcspkr_dev.id.product = 0x0001;
 	pcspkr_dev.id.version = 0x0100;
+	pcspkr_dev.state = PCSPKR_NORMAL;
 
 	input_register_device(&pcspkr_dev);
 
@@ -90,7 +112,7 @@
 {
         input_unregister_device(&pcspkr_dev);
 	/* turn off the speaker */
-	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
+	pcspkr_do_sound(0);
 }
 
 module_init(pcspkr_init);

--------------050505050906090404020304--
