Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbTAGV7K>; Tue, 7 Jan 2003 16:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbTAGV7K>; Tue, 7 Jan 2003 16:59:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27556 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267526AbTAGV7I>; Tue, 7 Jan 2003 16:59:08 -0500
Date: Tue, 7 Jan 2003 17:07:46 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Fwd: Patch for initial CapsLock
Message-ID: <20030107170746.A2689@devserv.devel.redhat.com>
References: <20030106133716.A7554@devserv.devel.redhat.com> <20030106225218.A1627@ucw.cz> <20030106171744.A13815@devserv.devel.redhat.com> <20030107095422.A4068@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030107095422.A4068@ucw.cz>; from vojtech@suse.cz on Tue, Jan 07, 2003 at 09:54:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you want me to do the same for 2.5? It should be a little
> > simpler there, and no new exports.
> 
> Yes, please.

Done, works for me.

I toyed with the idea to trigger keyboard tasklet instead of
locking it out and calling methods, but I did not see how
to force updates for unchanged ledstate. Changing ledstate to 0xff
just looked so very wrong...

-- Pete

--- linux-2.5.54/drivers/char/keyboard.c	2002-12-15 18:07:54.000000000 -0800
+++ linux-2.5.54-p3/drivers/char/keyboard.c	2003-01-07 13:55:25.000000000 -0800
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
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) || defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
 
 static unsigned short x86_keycodes[256] =
@@ -1159,6 +1175,7 @@
 	handle->name = kbd_name;
 
 	input_open_device(handle);
+	kbd_refresh_leds(handle);
 
 	return handle;
 }
