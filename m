Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbUAJWui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUAJWui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:50:38 -0500
Received: from imf.math.ku.dk ([130.225.103.32]:43164 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265441AbUAJWuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:50:08 -0500
Date: Sat, 10 Jan 2004 23:50:02 +0100 (CET)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <20040109105855.GB9479@ucw.cz>
Message-ID: <Pine.LNX.4.40.0401102336450.588-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Vojtech Pavlik wrote:

> The sync problems have so far been found to be caused by two possible
> causes:
>
> 	1) Too long disabled interrupts. This is usually caused by ACPI
> 	   BIOS, when some application is polling for battery status
> 	   too often.
>
> 	2) Incorrectly working timer (jiffies). This maybe caused by
> 	   using the ACPI timer instead of the regular PIT one. Check
> 	   the config.
>
> Both these causes break the lost bytes detection mechanism in the ps/2
> code. It then thinks that a byte was lost (and thus the sync, too), but
> in reality everything is OK. This in turn causes two consecutive
> incorrectly parsed packets.

I also believe some of the troubles comes from that we never check all
error codes from the mux: If mux is disabled for some reason all bytes are
stamped as timed out.  The only way to recover is to reboot.  And (I am
speculating here) if for some reason the mux believe the touchpad is
removed and connected the touchpad sends 2 bytes ack.

I dont have a machine with active multiplexing so the the patch is
untested. It warns when the mouse is removed, and tries to recover
if multiplexing is disabled.


diff -rup a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Sun Oct 20 04:57:23 2002
+++ b/include/linux/serio.h	Sun Oct 20 04:58:32 2002
@@ -95,6 +95,7 @@
 #define SERIO_TIMEOUT	1
 #define SERIO_PARITY	2
 #define SERIO_FRAME	4
+#define SERIO_REMOVED	8

 #define SERIO_TYPE	0xff000000UL
 #define SERIO_XT	0x00000000UL
diff -rup a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-01-10 19:45:11.000000000 +0100
+++ b/drivers/input/serio/i8042.c	2004-01-10 22:56:28.000000000 +0100
@@ -275,6 +275,37 @@ static void i8042_close(struct serio *po
 }

 /*
+ * i8042_enable_mux() enables/disables mux.  Internal loopback test - send
+ * three bytes, they should come back from the mouse interface, the last byte
+ * should be the version. Note that we negate mouseport command responses for the
+ * i8042_check_aux() routine.
+ */
+
+static int i8042_enable_mux(int enable)
+{
+       unsigned char param;
+
+       param = 0xf0;
+       if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
+               return -1;
+       param = 0x56;
+       if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
+               return -1;
+
+       if (enable)
+               param = 0xa4;
+       else
+               param = 0xa5;
+       if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b || param == 0x5a)
+               return -1;
+
+       printk(KERN_INFO "i8042.c: Acknowledged active ps/2 multiplexing %s sequence, rev %d.%d.\n",
+               enable?"enabling":"disabling",(~param >> 4) & 0xf, ~param & 0xf);
+
+       return 0;
+}
+
+/*
  * Structures for registering the devices in the serio.c module.
  */

@@ -336,6 +367,7 @@ static irqreturn_t i8042_interrupt(int i
 		int str;
 	} buffer[I8042_BUFFER_SIZE];
 	int i, j = 0;
+	int mux_failed = 0;

 	spin_lock_irqsave(&i8042_lock, flags);

@@ -357,15 +389,17 @@ static irqreturn_t i8042_interrupt(int i

 			if (str & I8042_STR_MUXERR) {
 				switch (data) {
-					case 0xfd:
+					case 0xfd: dfl = SERIO_REMOVED; break;
 					case 0xfe: dfl = SERIO_TIMEOUT; break;
 					case 0xff: dfl = SERIO_PARITY; break;
+					default: mux_failed = 1;
 				}
 				data = 0xfe;
 			} else dfl = 0;

-			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
+			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s%s)",
 				data, (str >> 6), irq,
+				dfl & SERIO_REMOVED ? ", removed" : "",
 				dfl & SERIO_PARITY ? ", bad parity" : "",
 				dfl & SERIO_TIMEOUT ? ", timeout" : "");

@@ -389,6 +423,12 @@ static irqreturn_t i8042_interrupt(int i
 		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 	}

+	if (mux_failed) {
+		printk(KERN_ERR "i8042.c: Reverted to lagacy aux mode.\n");
+		if (!i8042_enable_mux(1))
+			printk(KERN_ERR "i8042.c: Failed to activate mux again.\n");
+	}
+
 	return IRQ_RETVAL(j);
 }

@@ -560,23 +600,11 @@ static int __init i8042_check_mux(struct
 	i8042_flush();

 /*
- * Internal loopback test - send three bytes, they should come back from the
- * mouse interface, the last should be version. Note that we negate mouseport
- * command responses for the i8042_check_aux() routine.
+ * Enable mux.
  */

-	param = 0xf0;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
-		return -1;
-	param = 0x56;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
+	if (i8042_enable_mux(1))
 		return -1;
-	param = 0xa4;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
-		return -1;
-
-	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
-		(~param >> 4) & 0xf, ~param & 0xf);

 /*
  * Disable all muxed ports by disabling AUX.


