Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132790AbRDDLLX>; Wed, 4 Apr 2001 07:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132795AbRDDLLN>; Wed, 4 Apr 2001 07:11:13 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:39361 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132790AbRDDLLD>;
	Wed, 4 Apr 2001 07:11:03 -0400
Date: Wed, 4 Apr 2001 13:09:11 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104041109.NAA28776@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org,
        linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: console.c unblank_screen problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001 18:40:03 +0200, Benjamin Herrenschmidt wrote:

>There is a problem with the power management code for console.c
>
>The current code calls do_blank_screen(0); on PM_SUSPEND, and
>unblank_screen() on PM_RESUME.
>
>The problem happens when X is the current display while putting the
>machine to sleep. The do_blank_screen(0) code will do nothing as
>the console is not in KD_TEXT mode.
>However, unblank_screen has no such protection. That means that
>on wakeup, the cursor timer & console blank timers will be re-enabled
>while X is frontmost, causing the blinking cursor to be displayed on
>top of X, and other possible issues.
>
>I hacked the following pacth to work around this. It appear to work
>fine, but since the console code is pretty complex, I'm not sure about
>possible side effects and I'd like some comments before submiting it
>to Linus:

Thanks for this patch. I've been using it on my Dell Latitude laptop
for the last 10 days, and it has been a significant improvement.

Before the patch: After a few days with a 2.4 kernel and RH7.0
(XFree86-4.0.1-1 and XFree86-SVGA-3.3.6-33) the latop would
misbehave at a resume event: when I opened the lid the screen would
unblank and then after less than a second the entire screen would
shift (wrap/rotate) left by about 40% of its width. Restarting X
would only fix this temporarily, as the next resume would have the
same problem. This does not occur with a 2.2 kernel or with the
Accelerated-X server I used before.

With the patch: No problem after 10 days with frequent suspend/resume
cycles. (2.4.2-ac24 + the patch)

[Alan, mind putting this in the next 2.4.3-ac? I've rediffed it
against 2.4.3-ac2.]

/Mikael


--- linux-2.4.3-ac2/drivers/char/console.c.~1~	Wed Apr  4 12:15:28 2001
+++ linux-2.4.3-ac2/drivers/char/console.c	Wed Apr  4 12:29:01 2001
@@ -2713,12 +2713,16 @@
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
