Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDFPrb>; Fri, 6 Apr 2001 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDFPrW>; Fri, 6 Apr 2001 11:47:22 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:32494 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131733AbRDFPrI>;
	Fri, 6 Apr 2001 11:47:08 -0400
Date: Fri, 6 Apr 2001 17:46:02 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104061546.RAA15266@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org,
        linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mikpe@csd.uu.se
Subject: Re: console.c unblank_screen problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001 13:09:11 +0200 (MET DST), Mikael Petterson wrote:

> On Sun, 25 Mar 2001 18:40:03 +0200, Benjamin Herrenschmidt wrote:
> 
> >There is a problem with the power management code for console.c
> >
> >The current code calls do_blank_screen(0); on PM_SUSPEND, and
> >unblank_screen() on PM_RESUME.
> >
> >The problem happens when X is the current display while putting the
> >machine to sleep. The do_blank_screen(0) code will do nothing as
> >the console is not in KD_TEXT mode.
> >However, unblank_screen has no such protection. That means that
> >on wakeup, the cursor timer & console blank timers will be re-enabled
> >while X is frontmost, causing the blinking cursor to be displayed on
> >top of X, and other possible issues.
> >
> >I hacked the following pacth to work around this. It appear to work
> >fine, but since the console code is pretty complex, I'm not sure about
> >possible side effects and I'd like some comments before submiting it
> >to Linus:
>...
> Before the patch: After a few days with a 2.4 kernel and RH7.0
> (XFree86-4.0.1-1 and XFree86-SVGA-3.3.6-33) the latop would
> misbehave at a resume event: when I opened the lid the screen would
> unblank and then after less than a second the entire screen would
> shift (wrap/rotate) left by about 40% of its width.
>...
> With the patch: No problem after 10 days with frequent suspend/resume
> cycles. (2.4.2-ac24 + the patch)

Correction: While the patch eliminated the X screen wrap problem at resume,
it caused a new problem: now when I exit X the console is left in a blanked
state. This seems to happen if at least one suspend/resume cycle has
occurred before X is terminated.

After some experimentation I came up with the patch below (vs. 2.4.3-ac3)
which _so_far_ behaves ok on my laptop. If the resume-while-in-X problems
resurface or not I won't know until after several more days of testing,
but at least the console is unblanked correctly again.

Does _anyone_ understand this code and its interactions with X? I'm lost...

/Mikael

--- linux-2.4.3-ac3/drivers/char/console.c.~1~	Thu Apr  5 15:57:36 2001
+++ linux-2.4.3-ac3/drivers/char/console.c	Thu Apr  5 18:52:43 2001
@@ -2713,23 +2713,23 @@
 		printk("unblank_screen: tty %d not allocated ??\n", fg_console+1);
 		return;
 	}
-	currcons = fg_console;
-	if (vcmode != KD_TEXT) {
-		console_blanked = 0;
-		return;
-	}
 	console_timer.function = blank_screen;
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
 	}
-
+	currcons = fg_console;
 	console_blanked = 0;
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(currcons);
-	if (sw->con_blank(vc_cons[currcons].d, 0))
+	if (sw->con_blank(vc_cons[currcons].d, 0)) {
+		if (vcmode != KD_TEXT)
+			return;
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
+	}
+	if (vcmode != KD_TEXT)
+		return;
 	set_cursor(fg_console);
 }
 
