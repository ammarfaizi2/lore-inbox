Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268020AbTBRVKG>; Tue, 18 Feb 2003 16:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBRVKG>; Tue, 18 Feb 2003 16:10:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64772 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268020AbTBRVKF>; Tue, 18 Feb 2003 16:10:05 -0500
Date: Tue, 18 Feb 2003 22:19:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Toshiba keyboard workaroun
Message-ID: <20030218211940.GA1048@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You said that you'll submit toshiba keyboard fix for 2.4 to
marcelo... Here goes 2.5 version, will you submit it to Linus? ;-).

--- clean/drivers/char/keyboard.c	2003-02-15 18:51:18.000000000 +0100
+++ linux/drivers/char/keyboard.c	2003-02-15 19:19:45.000000000 +0100
@@ -1020,6 +1041,23 @@
 	struct tty_struct *tty;
 	int shift_final;
 
+        /*
+         * Fix for Toshiba Satellites. Toshiba's like to repeat 
+	 * "key down" event for A in combinations like shift-A.
+	 * Thanx to Andrei Pitis <pink@roedu.net>.
+         */
+        static int prev_scancode = 0;
+        static int stop_jiffies = 0;
+
+        /* new scancode, trigger delay */
+        if (keycode != prev_scancode) 	       stop_jiffies = jiffies;
+        else if (jiffies - stop_jiffies >= 10) stop_jiffies = 0;
+        else {
+	    printk( "Keyboard glitch detected, ignoring keypress\n" );
+            return;
+	}
+        prev_scancode = keycode;
+
 	if (down != 2)
 		add_keyboard_randomness((keycode << 1) ^ down);
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
