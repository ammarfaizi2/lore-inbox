Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135173AbRDRNkJ>; Wed, 18 Apr 2001 09:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135178AbRDRNj7>; Wed, 18 Apr 2001 09:39:59 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:48596 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S135173AbRDRNjs>;
	Wed, 18 Apr 2001 09:39:48 -0400
Date: Wed, 18 Apr 2001 15:39:25 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104181339.PAA27353@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.3-ac9 console unblank at resume fix
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I think I've finally eliminated the X screen corruption my laptop
has been seeing at resume from suspend events.

The fix in -ac3 eliminated the corruption but left the console
blank if I exited X. The fix in -ac4 didn't actually work --
the corruptions resurfaced later. (Sorry about that.) I've tested
a lot of variations of it, but all had the same problem.

The new fix goes back to the original (exit early if not in text
mode), with one crucial change: console_blanked is NOT reset to zero.
This appears to have the desired effect: while X is running we
don't mess with the hardware, and the first unblank after X has
exited does the right thing. Works fine over here (so far..).
Patch below for -ac9, please apply.

[To recap: Dell Latitude, 2.4 kernel, XFree86-SVGA-3.3.6, APM,
no frame buffer device. After a few (1-3) days of use with
frequent suspend/resume cycles, the X screen would partially
wrap around after a resume. Restarting X would fix this temporarily,
but the next resume would see the same problem. Reboot, and I'd get
another few days before it happened again. 2.2 kernel was fine.]

/Mikael

--- linux-2.4.3-ac9/drivers/char/console.c.~1~	Wed Apr 18 13:50:00 2001
+++ linux-2.4.3-ac9/drivers/char/console.c	Wed Apr 18 13:50:24 2001
@@ -2713,23 +2713,21 @@
 		printk("unblank_screen: tty %d not allocated ??\n", fg_console+1);
 		return;
 	}
+	currcons = fg_console;
+	if (vcmode != KD_TEXT)
+		return; /* but leave console_blanked != 0 */
 	console_timer.function = blank_screen;
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
 	}
-	currcons = fg_console;
+
 	console_blanked = 0;
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(currcons);
-	if (sw->con_blank(vc_cons[currcons].d, 0)) {
-		if (vcmode != KD_TEXT)
-			return;
+	if (sw->con_blank(vc_cons[currcons].d, 0))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
-	}
-	if (vcmode != KD_TEXT)
-		return;
 	set_cursor(fg_console);
 }
 
