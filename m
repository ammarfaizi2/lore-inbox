Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTA0Us1>; Mon, 27 Jan 2003 15:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTA0Us1>; Mon, 27 Jan 2003 15:48:27 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:52382 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263204AbTA0UsZ>;
	Mon, 27 Jan 2003 15:48:25 -0500
Date: Mon, 27 Jan 2003 21:57:43 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301272057.VAA13114@harpo.it.uu.se>
To: vojtech@suse.cz
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003 13:34:32 +0100, Vojtech Pavlik wrote:
>> Either removing the SSCANSET from atkbd_cleanup(), or changing
>> atkbd->oldset from 22 to 2, solves my CPi's keyboard problems.
>
>Can you try with the attached atkbd.c? It uses RESET_BAT instead of
>SSCANSET, which will slow down the reboot a bit, but should be very safe
>to bring the keyboard to its power-on state, which the BIOS should be
>able to handle.

I tried it, and the change to use RESET_BAT in atkbd_cleanup()
works fine. Tested on my Dell Latitiude CPi and four desktop
boxes of various vintages. No new problems. A reboot takes maybe
1/10 of a second longer, but I don't care.

However, your version of atkbd.c caused a linkage error due to a
reference to input_regs() in atkbd_interrupt(). I extracted
just the changes to atkbd_cleanup() and atkbd_command(), but that
left me with a dead keyboard on the first test box. In the end
I kept only the atkbd_cleanup() change and the increased timeout
for RESET_BAT in atkbd_command() [see below].

/Mikael

--- linux-2.5.59/drivers/input/keyboard/atkbd.c.~1~	2002-11-23 17:59:41.000000000 +0100
+++ linux-2.5.59/drivers/input/keyboard/atkbd.c	2003-01-27 19:54:30.000000000 +0100
@@ -233,6 +233,9 @@
 	int i;
 
 	atkbd->cmdcnt = receive;
+
+	if (command == ATKBD_CMD_RESET_BAT)
+		timeout = 200000; /* 2 sec */
 	
 	if (command & 0xff)
 		if (atkbd_sendbyte(atkbd, command & 0xff))
@@ -442,7 +445,7 @@
 static void atkbd_cleanup(struct serio *serio)
 {
 	struct atkbd *atkbd = serio->private;
-	atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_SSCANSET);
+	atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT);
 }
 
 /*
