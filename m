Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSIINqh>; Mon, 9 Sep 2002 09:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSIINqh>; Mon, 9 Sep 2002 09:46:37 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:54437 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316595AbSIINqg>; Mon, 9 Sep 2002 09:46:36 -0400
Date: Mon, 9 Sep 2002 06:51:11 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail
Message-ID: <20020909065111.A1556@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I have a computer with an Iwill VD133 motherboard doing
USB-to-PS/2 keyboard emulation (built into the chipset somewhere)
for a BTC 7932M USB keyboard.  Under this configuration, the
SETLEDS command in atkbd_probe fails (the first atkbd_sendbyte
in atkbd_command fails), but the keyboard otherwise works if
that failure is ignored.

	I noticed this when my keyboard stopped working in 2.5.32.
I have verified that 2.5.31 (and probably all kernels before it)
also do not set the LEDs on my USB-emulating-PS/2 keyboard.

	I cannot say whether the problem occurs with other USB
keyboards because I don't have one handy.

	One cannot run the USB keyboard "natively" via Linux USB on this
motherboard because the BIOS does not seem to set an IRQ line for the USB
controller.  I've tried booting with "pci=biosirq", and I think I've tried
all the relevant BIOS menu options, and I'm running the latest BIOS,
and the VD133 product has been terminated.  So the patch does seem to be
"necessary" to support some configurations, at least for now.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kbd.diff"

--- linux-2.5.33/drivers/input/keyboard/atkbd.c	2002-08-31 15:05:31.000000000 -0700
+++ linux/drivers/input/keyboard/atkbd.c	2002-09-09 06:29:04.000000000 -0700
@@ -359,13 +359,13 @@
 #endif
 
 /*
- * Next we check we can set LEDs on the keyboard. This should work on every
- * keyboard out there. It also turns the LEDs off, which we want anyway.
+ * Turn off LEDs.  This command fails on at least a BTC 7932M USB keyboard
+ * connected to an Iwill VD133 motherboard that is configured to emulate
+ * a PS/2 keyboard via USB.
  */
 
 	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
-		return -1;
+	atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);
 
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.

--FCuugMFkClbJLl1L--
