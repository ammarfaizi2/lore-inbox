Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314628AbSDTPH4>; Sat, 20 Apr 2002 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314630AbSDTPHz>; Sat, 20 Apr 2002 11:07:55 -0400
Received: from ar6-101i.dial-up.arnes.si ([194.249.1.101]:260 "EHLO
	tedi.linux.rules") by vger.kernel.org with ESMTP id <S314628AbSDTPHy>;
	Sat, 20 Apr 2002 11:07:54 -0400
Date: Sat, 20 Apr 2002 17:06:05 +0200 (CEST)
From: Andrej Lajovic <andrej.lajovic@guest.arnes.si>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: kd.h patch for keyboard LEDs
Message-ID: <Pine.LNX.4.40.0204201651320.3755-100000@tedi.linux.rules>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

While playing around with ioctls for keyboard LEDs, I noticed the
following thing: if you just want to set the LEDs on or off, everything
works normally. But if you try to actually change the state of
Num/Caps/Scrolllock flags, you get the following:

ioctl(0, KDSKBLED, K_SCROLLLOCK) -> ScrollLock led is lit
ioctl(0, KDSKBLED, K_CAPSLOCK)   -> NumLock led is lit (!)
ioctl(0, KDSKBLED, K_NUMLOCK)    -> CapsLock led is lit (!)

When I browsed the kd.h file (kernel 2.4.18) again, I noticed that the
definitions for *Lock flags are probably mistyped:

#define         K_SCROLLLOCK    0x01
#define         K_CAPSLOCK      0x02
#define         K_NUMLOCK       0x04

while the definitions for LEDs (which _do_ work) look like this:

#define         LED_SCR         0x01    /* scroll lock led */
#define         LED_CAP         0x04    /* caps lock led */
#define         LED_NUM         0x02    /* num lock led */

People on the local LUG mailing list also confirmed the bug, so I am
sending a small patch to correct it.

-----------kd.h_patch-------------------
--- 2.4.18/include/linux/kd.h	Thu Nov 22 20:47:07 2001
+++ 2.4.18-k_fix/include/linux/kd.h	Fri Apr 12 11:47:44 2002
@@ -26,8 +26,8 @@
 #define KDGETLED	0x4B31	/* return current led state */
 #define KDSETLED	0x4B32	/* set led state [lights, not flags] */
 #define 	LED_SCR		0x01	/* scroll lock led */
-#define 	LED_CAP		0x04	/* caps lock led */
 #define 	LED_NUM		0x02	/* num lock led */
+#define 	LED_CAP		0x04	/* caps lock led */

 #define KDGKBTYPE	0x4B33	/* get keyboard type */
 #define 	KB_84		0x01
@@ -89,8 +89,8 @@
 #define KDSKBMETA	0x4B63	/* sets meta key handling mode */

 #define		K_SCROLLLOCK	0x01
-#define		K_CAPSLOCK	0x02
-#define		K_NUMLOCK	0x04
+#define		K_NUMLOCK	0x02
+#define		K_CAPSLOCK	0x04
 #define	KDGKBLED	0x4B64	/* get led flags (not lights) */
 #define KDSKBLED	0x4B65	/* set led flags (not lights) */
----------end-kd.h_patch-----------------end

Kind regards,
Andrej Lajovic

