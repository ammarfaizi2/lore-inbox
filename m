Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFODEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFODEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 23:04:21 -0400
Received: from smtp-2b.paradise.net.nz ([202.0.32.211]:41626 "EHLO
	smtp-2.paradise.net.nz") by vger.kernel.org with ESMTP
	id S261820AbTFODEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 23:04:20 -0400
Subject: [PATCH] kernel-2.4.21-final drivers/char/keyboard.c - key release
	bug
From: Geoff Jacobsen <geoffj@paradise.net.nz>
Reply-To: geoffj@paradise.net.nz
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1055647086.1066.32.camel@choc.casquet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jun 2003 15:18:06 +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- I am not on the list; please reply to geoffj@casquet.inet.net.nz --

In the kernel-2.4.21-final drivers/char/keyboard.c file there was a
workaround applied from the AC patches "for hardware which sometimes
send the key release event twice".

Unfortunately this fix causes a bug. If you hold down the left_ctrl and
press the right_ctrl then the left_ctrl release is missed (same story
with the two alt keys).

In X this means that until the left_ctrl is pressed again every key
typed will be as if the left_ctrl is still held down.

Removing the workaround fixes the problem.

Here is the patch to remove the offending code:


--- linux-2.4.21/drivers/char/keyboard.c        2003-06-15
15:00:38.000000000 +1200
+++ linux/drivers/char/keyboard.c       2003-06-15 15:03:00.000000000
+1200
@@ -72,7 +72,7 @@
  
 /*
  * global state includes the following, and various static variables
- * in this module: prev_scancode, shift_state, diacr, npadch,
dead_key_next.
+ * in this module: shift_state, diacr, npadch, dead_key_next.
  * (last_console is now a global variable)
  */
  
@@ -95,7 +95,6 @@
 static struct tty_struct **ttytab;
 static struct kbd_struct * kbd = kbd_table;
 static struct tty_struct * tty;
-static unsigned char prev_scancode;
  
 void compute_shiftstate(void);
  
@@ -215,17 +214,7 @@
        }
        kbd = kbd_table + fg_console;
        if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
-               /*
-                *      The following is a workaround for hardware
-                *      which sometimes send the key release event twice
-                */
-               unsigned char next_scancode = scancode|up_flag;
-               if (up_flag && next_scancode==prev_scancode) {
-                       /* unexpected 2nd release event */
-               } else {
-                       prev_scancode=next_scancode;
-                       put_queue(next_scancode);
-               }
+               put_queue(scancode | up_flag);
                /* we do not return yet, because we want to maintain
                   the key_down array, so that we have the correct
                   values when finishing RAW mode or when changing VT's
*/



-- 
Geoff Jacobsen <geoffj@casquet.inet.net.nz>
