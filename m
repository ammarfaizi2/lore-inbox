Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFNSp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFNSp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFNSp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:45:57 -0400
Received: from mail.aknet.ru ([82.179.72.26]:6917 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261178AbVFNSp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:45:26 -0400
Message-ID: <42AF25C7.90109@aknet.ru>
Date: Tue, 14 Jun 2005 22:45:27 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 2/2] pcspeaker driver update
Content-Type: multipart/mixed;
 boundary="------------090208000605080403020207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208000605080403020207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Attached patch does the following:
- changes the pcspeaker driver to
use the i8253_lock instead of i8253_beep_lock
- adds the SND_SUSPEND event that allows
to disable and re-enable the driver. It
is necessary, for example, for the PCM
PC-Speaker driver (which is currently in
an ALSA CVS), as it doesn't want to
interfere with the pcspkr, so it needs
some way to disable the thing.

Can this please be applied?

Signed-off-by: stsp@aknet.ru



--------------090208000605080403020207
Content-Type: text/x-patch;
 name="pcspkr-2.6.12-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspkr-2.6.12-rc6.diff"

diff -urN linux-2.6.12-rc6/drivers/input/misc/pcspkr.c linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c
--- linux-2.6.12-rc6/drivers/input/misc/pcspkr.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c	2005-06-14 12:57:59.000000000 +0400
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <asm/8253pit.h>
 #include <asm/io.h>
+#include <asm/timer.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("PC Speaker beeper driver");
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
@@ -61,7 +48,32 @@
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
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value = 1000;
+		case SND_TONE: break;
+		case SND_SUSPEND:
+			dev->state = value ? PCSPKR_SUSPENDED : PCSPKR_NORMAL;
+			return 0;
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
@@ -69,7 +81,7 @@
 static int __init pcspkr_init(void)
 {
 	pcspkr_dev.evbit[0] = BIT(EV_SND);
-	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE) | BIT(SND_SUSPEND);
 	pcspkr_dev.event = pcspkr_event;
 
 	pcspkr_dev.name = pcspkr_name;
@@ -78,6 +90,7 @@
 	pcspkr_dev.id.vendor = 0x001f;
 	pcspkr_dev.id.product = 0x0001;
 	pcspkr_dev.id.version = 0x0100;
+	pcspkr_dev.state = PCSPKR_NORMAL;
 
 	input_register_device(&pcspkr_dev);
 
@@ -90,7 +103,7 @@
 {
         input_unregister_device(&pcspkr_dev);
 	/* turn off the speaker */
-	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
+	pcspkr_do_sound(0);
 }
 
 module_init(pcspkr_init);
diff -urN linux-2.6.12-rc6/include/linux/input.h linux-2.6.12-rc6-spinlk/include/linux/input.h
--- linux-2.6.12-rc6/include/linux/input.h	2005-06-07 11:12:29.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/linux/input.h	2005-06-14 12:58:41.000000000 +0400
@@ -593,6 +593,7 @@
 #define SND_CLICK		0x00
 #define SND_BELL		0x01
 #define SND_TONE		0x02
+#define SND_SUSPEND		0x03
 #define SND_MAX			0x07
 
 /*

--------------090208000605080403020207--
