Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270060AbTGSNDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270063AbTGSNDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:03:49 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64468 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270060AbTGSNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:03:46 -0400
Date: Sat, 19 Jul 2003 09:18:28 -0400
From: Chris Heath <chris@heathens.co.nz>
To: Ralf.Hildebrandt@charite.de
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030718064444.GF6429@charite.de>
Message-Id: <20030719090538.9EC5.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch that fixed the issue with the key release events was this -
> I submitted it to Alan who then put it into ac and then it went into
> 2.4.x...
> 
> Details: http://www.informatik.uni-freiburg.de/~leibl/lol/
> 
> Patch excerpt:
> 
> +                /* The following 'if' is a workaround for hardware
> +                 * which sometimes send the key release event twice */
> +                unsigned char next_scancode = scancode|up_flag;
> +                if (up_flag && next_scancode==prev_scancode) {
> +                       /* unexpected 2nd release event */
> +                } else {
> +                        prev_scancode=next_scancode;
> +                        put_queue(next_scancode);
> +                }
> 
> I haven't checked if 2.6.0 already has this!

This patch went into 2.4.21, and we immediately got a bug report! 
See http://www.ussg.iu.edu/hypermail/linux/kernel/0306.1/1871.html

I wrote another patch (better, I hope), which is now in 2.4.22-pre6-ac1.
It is included below.  I would appreciate it if it got some testing on
both Toshiba laptops and other machines.

I am also interested in helping fix it in 2.6, but let's see if the fix
for 2.4 works first.

Chris


--- a/drivers/char/keyboard.c	2003-07-07 21:03:44.000000000 -0400
+++ b/drivers/char/keyboard.c	2003-07-08 23:07:47.000000000 -0400
@@ -198,6 +198,7 @@
 	unsigned char keycode;
 	char up_flag = down ? 0 : 0200;
 	char raw_mode;
+	char have_keycode;
 
 	pm_access(pm_kbd);
 	add_keyboard_randomness(scancode | up_flag);
@@ -214,16 +215,30 @@
 		tty = NULL;
 	}
 	kbd = kbd_table + fg_console;
-	if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
+	/*
+	 *  Convert scancode to keycode
+	 */
+	raw_mode = (kbd->kbdmode == VC_RAW);
+	have_keycode = kbd_translate(scancode, &keycode, raw_mode);
+	if (raw_mode) {
 		/*
 		 *	The following is a workaround for hardware
 		 *	which sometimes send the key release event twice 
 		 */
 		unsigned char next_scancode = scancode|up_flag;
-		if (up_flag && next_scancode==prev_scancode) {
+		if (have_keycode && up_flag && next_scancode==prev_scancode) {
 			/* unexpected 2nd release event */
 		} else {
-			prev_scancode=next_scancode;
+			/* 
+			 * Only save previous scancode if it was a key-up
+			 * and had a single-byte scancode.  
+			 */
+			if (!have_keycode)
+				prev_scancode = 1;
+			else if (!up_flag || prev_scancode == 1)
+				prev_scancode = 0;
+			else
+				prev_scancode = next_scancode;
 			put_queue(next_scancode);
 		}
 		/* we do not return yet, because we want to maintain
@@ -231,10 +246,7 @@
 		   values when finishing RAW mode or when changing VT's */
 	}
 
-	/*
-	 *  Convert scancode to keycode
-	 */
-	if (!kbd_translate(scancode, &keycode, raw_mode))
+	if (!have_keycode)
 		goto out;
 
 	/*

