Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUAKIgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUAKIgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:36:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:42729 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265796AbUAKIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:36:40 -0500
Date: Sun, 11 Jan 2004 09:37:52 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Peter Berg Larsen <pebl@math.ku.dk>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <Pine.LNX.4.40.0401110335330.588-100000@shannon.math.ku.dk>
Message-ID: <Pine.LNX.4.53.0401110935010.1395@calcula.uni-erlangen.de>
References: <Pine.LNX.4.40.0401110335330.588-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Now I get an "Reverted to legacy aux mode" after about every third
resync of the driver, and sometimes odd and sometimes even numbers of sync
losses...

But this patch also seems to fix bad clicks, tried for some minutes, and
still got none.

On Today, Peter Berg Larsen wrote:

>From: Peter Berg Larsen <pebl@math.ku.dk>
>Date: Sun, 11 Jan 2004 03:39:16 +0100 (CET)
>To: Vojtech Pavlik <vojtech@suse.cz>
>Delivered-To: GMX delivery to gunter.koenigsmann@gmx.de
>Cc: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     linux-kernel@vger.kernel.org
>Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
>    loss (With Patch).
>
>
>On Sat, 10 Jan 2004, Peter Berg Larsen wrote:
>
>> I dont have a machine with active multiplexing so the the patch is
>> untested. It warns when the mouse is removed, and tries to recover
>> if multiplexing is disabled.
>
>A lot a have changed since 2.6.0 so here is the patch against 2.6.1:
>
>diff -rup a/include/linux/serio.h b/include/linux/serio.h
>--- a/include/linux/serio.h	Sun Oct 20 04:57:23 2002
>+++ b/include/linux/serio.h	Sun Oct 20 04:58:32 2002
>@@ -99,6 +99,7 @@
> #define SERIO_TIMEOUT	1
> #define SERIO_PARITY	2
> #define SERIO_FRAME	4
>+#define SERIO_REMOVED	8
>
> #define SERIO_TYPE	0xff000000UL
> #define SERIO_XT	0x00000000UL
>diff -rup a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>--- a/drivers/input/serio/i8042.c	2004-01-11 03:52:53.000000000 +0100
>+++ b/drivers/input/serio/i8042.c	2004-01-11 04:02:34.000000000 +0100
>@@ -78,6 +78,7 @@ struct timer_list i8042_timer;
> #define i8042_request_irq_cookie (&i8042_timer)
>
> static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
>+static int i8042_enable_mux_mode(struct i8042_values *values, unsigned char *mux_version);
>
> /*
>  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
>@@ -375,7 +376,7 @@ static irqreturn_t i8042_interrupt(int i
> 		int data;
> 		int str;
> 	} buffer[I8042_BUFFER_SIZE];
>-	int i, j = 0;
>+	int i, j = 0, mux_failed = 0;
>
> 	spin_lock_irqsave(&i8042_lock, flags);
>
>@@ -397,15 +398,17 @@ static irqreturn_t i8042_interrupt(int i
>
> 			if (str & I8042_STR_MUXERR) {
> 				switch (data) {
>-					case 0xfd:
>+					case 0xfd: dfl = SERIO_REMOVED; break;
> 					case 0xfe: dfl = SERIO_TIMEOUT; break;
> 					case 0xff: dfl = SERIO_PARITY; break;
>+					default: mux_failed = 1;
> 				}
> 				data = 0xfe;
> 			} else dfl = 0;
>
>-			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
>+			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s%s)",
> 				data, (str >> 6), irq,
>+				dfl & SERIO_REMOVED ? ", removed" : "",
> 				dfl & SERIO_PARITY ? ", bad parity" : "",
> 				dfl & SERIO_TIMEOUT ? ", timeout" : "");
>
>@@ -429,6 +432,12 @@ static irqreturn_t i8042_interrupt(int i
> 		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
> 	}
>
>+	if (mux_failed) {
>+		printk(KERN_ERR "i8042.c: Reverted to lagacy aux mode.\n");
>+		if (i8042_enable_mux_mode(NULL,NULL))
>+			printk(KERN_ERR "i8042.c: Failed to activate mux again.\n");
>+	}
>+
> 	return IRQ_RETVAL(j);
> }
>
>
>
>Peter
>
>
>

-- 
First Corollary of Taber's Second Law:
        Machines that piss people off get murdered.
                -- Pat Taber
