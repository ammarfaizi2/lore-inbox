Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBLKwz>; Wed, 12 Feb 2003 05:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbTBLKwy>; Wed, 12 Feb 2003 05:52:54 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:13705 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267033AbTBLKwQ>;
	Wed, 12 Feb 2003 05:52:16 -0500
Date: Wed, 12 Feb 2003 12:01:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Let newly connected keyboards pickup the LED state. [4/14]
Message-ID: <20030212120154.C1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120119.B1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:01:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1007, 2003-02-12 10:35:04+01:00, zaitcev@redhat.com
  input: Let newly connected keyboards pickup the LED state.


 keyboard.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Wed Feb 12 11:57:13 2003
+++ b/drivers/char/keyboard.c	Wed Feb 12 11:57:13 2003
@@ -894,9 +894,9 @@
  * Aside from timing (which isn't really that important for
  * keyboard interrupts as they happen often), using the software
  * interrupt routines for this thing allows us to easily mask
- * this when we don't want any of the above to happen. Not yet
- * used, but this allows for easy and efficient race-condition
- * prevention later on.
+ * this when we don't want any of the above to happen.
+ * This allows for easy and efficient race-condition prevention
+ * for kbd_refresh_leds => input_event(dev, EV_LED, ...) => ...
  */
 
 static void kbd_bh(unsigned long dummy)
@@ -918,6 +918,22 @@
 
 DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh, 0);
 
+/*
+ * This allows a newly plugged keyboard to pick the LED state.
+ */
+void kbd_refresh_leds(struct input_handle *handle)
+{
+	unsigned char leds = ledstate;
+
+	tasklet_disable(&keyboard_tasklet);
+	if (leds != 0xff) {
+		input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
+		input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
+		input_event(handle->dev, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+	}
+	tasklet_enable(&keyboard_tasklet);
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) || defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64) || defined(CONFIG_PARISC)
 
 static unsigned short x86_keycodes[256] =
@@ -1160,6 +1176,7 @@
 	handle->name = kbd_name;
 
 	input_open_device(handle);
+	kbd_refresh_leds(handle);
 
 	return handle;
 }
