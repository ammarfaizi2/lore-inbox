Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUAKCj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUAKCj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:39:28 -0500
Received: from imf.math.ku.dk ([130.225.103.32]:5009 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265718AbUAKCjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:39:21 -0500
Date: Sun, 11 Jan 2004 03:39:16 +0100 (CET)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <Pine.LNX.4.40.0401102336450.588-100000@shannon.math.ku.dk>
Message-ID: <Pine.LNX.4.40.0401110335330.588-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Jan 2004, Peter Berg Larsen wrote:

> I dont have a machine with active multiplexing so the the patch is
> untested. It warns when the mouse is removed, and tries to recover
> if multiplexing is disabled.

A lot a have changed since 2.6.0 so here is the patch against 2.6.1:

diff -rup a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Sun Oct 20 04:57:23 2002
+++ b/include/linux/serio.h	Sun Oct 20 04:58:32 2002
@@ -99,6 +99,7 @@
 #define SERIO_TIMEOUT	1
 #define SERIO_PARITY	2
 #define SERIO_FRAME	4
+#define SERIO_REMOVED	8

 #define SERIO_TYPE	0xff000000UL
 #define SERIO_XT	0x00000000UL
diff -rup a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-01-11 03:52:53.000000000 +0100
+++ b/drivers/input/serio/i8042.c	2004-01-11 04:02:34.000000000 +0100
@@ -78,6 +78,7 @@ struct timer_list i8042_timer;
 #define i8042_request_irq_cookie (&i8042_timer)

 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static int i8042_enable_mux_mode(struct i8042_values *values, unsigned char *mux_version);

 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
@@ -375,7 +376,7 @@ static irqreturn_t i8042_interrupt(int i
 		int data;
 		int str;
 	} buffer[I8042_BUFFER_SIZE];
-	int i, j = 0;
+	int i, j = 0, mux_failed = 0;

 	spin_lock_irqsave(&i8042_lock, flags);

@@ -397,15 +398,17 @@ static irqreturn_t i8042_interrupt(int i

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

@@ -429,6 +432,12 @@ static irqreturn_t i8042_interrupt(int i
 		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 	}

+	if (mux_failed) {
+		printk(KERN_ERR "i8042.c: Reverted to lagacy aux mode.\n");
+		if (i8042_enable_mux_mode(NULL,NULL))
+			printk(KERN_ERR "i8042.c: Failed to activate mux again.\n");
+	}
+
 	return IRQ_RETVAL(j);
 }



Peter



