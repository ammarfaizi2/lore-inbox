Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRKDVvM>; Sun, 4 Nov 2001 16:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRKDVvC>; Sun, 4 Nov 2001 16:51:02 -0500
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:52082 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S278470AbRKDVup>; Sun, 4 Nov 2001 16:50:45 -0500
Date: Sun, 4 Nov 2001 23:50:37 +0200 (EET)
From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
X-X-Sender: <jjaakkol@loussa.kamppa>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with Toshiba Portege 4000 keyboard
Message-ID: <Pine.LNX.4.33.0111042337340.824-100000@loussa.kamppa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When writing rapidly using Toshiba Portege 4000 laptop keyboard, the
keypresses sometimes get doubled in X (so that instead of word 'doubled'
I get word 'ddoublled').

This seems to be hardware related. The keyboard controller seems to send
key release events often twice (so that about every fifth letter gets
doubled) but only when writing rapidly. It does not matter on Linux
console, but it makes X send X protocol key release events twice, which
makes some (or most) X programs to double keypresses. This is very
annoying.

I patched linux/drivers/char/keyboard.c to work around this (patch
included). If you have any better solutions or ideas I would be very happy
to hear about them.

Please CC comments to me, since I am not on the list.

Patch follows:

--- keyboard.c.orig     Sun Nov  4 23:25:19 2001
+++ keyboard.c  Sun Nov  4 23:18:42 2001
@@ -90,6 +90,8 @@
 static unsigned long key_down[256/BITS_PER_LONG];

 static int dead_key_next;
+static unsigned int prev_scancode;
+
 /*
  * In order to retrieve the shift_state (for the mouse server), either
  * the variable must be global, or a new procedure must be created to
@@ -222,7 +224,12 @@
        }
        kbd = kbd_table + fg_console;
        if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
-               put_queue(scancode | up_flag);
+               /* The following 'if' is a workaround for hardware
+                * which sometimes send the key release event twice */
+               if (!up_flag || (scancode|up_flag)!=prev_scancode) {
+                       prev_scancode=scancode|up_flag;
+                       put_queue(prev_scancode);
+               }
                /* we do not return yet, because we want to maintain
                   the key_down array, so that we have the correct
                   values when finishing RAW mode or when changing VT's */


