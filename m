Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSGKG2q>; Thu, 11 Jul 2002 02:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317707AbSGKG2p>; Thu, 11 Jul 2002 02:28:45 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:15241 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317694AbSGKG2o>;
	Thu, 11 Jul 2002 02:28:44 -0400
Date: Thu, 11 Jul 2002 08:30:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Emmanuel Fuste <fuste@worldnet.fr>, Peter De Schrijver <p2@mind.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: RE: Info on dn_keyb.c
In-Reply-To: <Pine.LNX.4.44.0207101547420.11248-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0207110829210.8371-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, James Simmons wrote:
> > >How is in charge of it and where can I get docs on the hardware so I can
> > >port the driver to the input api?
> >
> > It was Peter De Schrijver who made the M68K Apollo DN port.
> > I have the hardware docs on paper. I could try to send you the relevant parts
> > or help you to port it.
> 
> Could you send me the docs. Its time to port the keyboard driver over to
> the input api.

FYI, you need the following patch (from Linux/m68k CVS) to make the current
dn_keyb.c compile:

--- linux-2.5.25/drivers/char/dn_keyb.c	Fri Jul 14 21:20:22 2000
+++ linux-m68k-2.5.25/drivers/char/dn_keyb.c	Mon Jun 17 11:39:09 2002
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/kd.h>
+#include <linux/kbd_ll.h>
 #include <linux/random.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,8 +20,6 @@
 
 #include "busmouse.h"
 
-/* extern void handle_scancode(unsigned char,int ); */
-
 #define DNKEY_CAPS 0x7e
 #define BREAK_FLAG 0x80
 #define DNKEY_REPEAT_DELAY 50
@@ -336,7 +335,8 @@
 
 	static short mouse_byte_count=0;
 	static u_char mouse_packet[3];
-	short mouse_buttons;	
+	short buttons;
+	int dx, dy;
 
 	mouse_packet[mouse_byte_count++]=mouse_data;
 
@@ -347,24 +347,12 @@
 /*			printk("modechange: %d\n",mouse_packet[1]); */
 			if(kbd_mode==APOLLO_KBD_MODE_KEYB)
 				dn_keyb_process_key_event(mouse_packet[2]);
-		}				
+		}
 		if((mouse_packet[0] & 0x8f) == 0x80) {
-			if(mouse_update_allowed) {
-				mouse_ready=1;
-				mouse_buttons=(mouse_packet[0] >> 4) & 0x7;
-				mouse_dx+=mouse_packet[1] == 0xff ? 0 : (signed char)mouse_packet[1];
-				mouse_dy+=mouse_packet[2] == 0xff ? 0 : (signed char)mouse_packet[2];
-				wake_up_interruptible(&mouse_wait);
-				if (mouse_dx < -2048)
-              				mouse_dx = -2048;
-          			else if (mouse_dx >  2048)
-              				mouse_dx =  2048;
-         	 		if (mouse_dy < -2048)
-              				mouse_dy = -2048;
-          			else if (mouse_dy >  2048)
-             			 	mouse_dy =  2048;
-              			kill_fasync(&mouse_fasyncptr, SIGIO, POLL_IN);
-			}
+			buttons = (mouse_packet[0] >> 4) & 0x7;
+			dx = mouse_packet[1] == 0xff ? 0 : (signed char)mouse_packet[1];
+			dy = mouse_packet[2] == 0xff ? 0 : (signed char)mouse_packet[2];
+			busmouse_add_movementbuttons(msedev, dx, dy, buttons);
 			mouse_byte_count=0;
 /*			printk("mouse: %d, %d, %x\n",mouse_x,mouse_y,buttons); */
 		}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

