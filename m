Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRCYQla>; Sun, 25 Mar 2001 11:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbRCYQlU>; Sun, 25 Mar 2001 11:41:20 -0500
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:36224 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S132109AbRCYQlK>; Sun, 25 Mar 2001 11:41:10 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: console.c unblank_screen problem
Date: Sun, 25 Mar 2001 18:40:03 +0200
Message-Id: <20010325164003.6131@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with the power management code for console.c

The current code calls do_blank_screen(0); on PM_SUSPEND, and
unblank_screen() on PM_RESUME.

The problem happens when X is the current display while putting the
machine to sleep. The do_blank_screen(0) code will do nothing as
the console is not in KD_TEXT mode.
However, unblank_screen has no such protection. That means that
on wakeup, the cursor timer & console blank timers will be re-enabled
while X is frontmost, causing the blinking cursor to be displayed on
top of X, and other possible issues.

I hacked the following pacth to work around this. It appear to work
fine, but since the console code is pretty complex, I'm not sure about
possible side effects and I'd like some comments before submiting it
to Linus:

(Don't worry about the {} I added, I just noticed them and will remove
them before submitting ;)

--- 1.2/drivers/char/console.c	Sat Feb 10 18:54:15 2001
+++ edited/drivers/char/console.c	Sun Mar 25 17:57:46 2001
@@ -2595,8 +2595,9 @@
 	int currcons = fg_console;
 	int i;
 
-	if (console_blanked)
+	if (console_blanked) {
 		return;
+	}
 
 	/* entering graphics mode? */
 	if (entering_gfx) {
@@ -2660,12 +2661,16 @@
 		printk("unblank_screen: tty %d not allocated ??\n", fg_console+1);
 		return;
 	}
+	currcons = fg_console;
+	if (vcmode != KD_TEXT) {
+		console_blanked = 0;
+		return;
+	}
 	console_timer.function = blank_screen;
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
 	}
 
-	currcons = fg_console;
 	console_blanked = 0;
 	if (console_blank_hook)
 		console_blank_hook(0);


