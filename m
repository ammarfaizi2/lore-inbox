Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUF2Rxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUF2Rxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUF2Rxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:53:33 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:36224 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265875AbUF2RxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:53:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Tue, 29 Jun 2004 12:53:08 -0500
User-Agent: KMail/1.6.2
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
References: <20040629143232.52963.qmail@web81303.mail.yahoo.com> <200406291808.08186.Marc.Waeckerlin@siemens.com>
In-Reply-To: <200406291808.08186.Marc.Waeckerlin@siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406291253.10542.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 June 2004 11:08 am, Marc Waeckerlin wrote:
> Am Dienstag, 29. Juni 2004 16.32 schrieben Sie unter "Re: Continue: psmouse.c 
> - synaptics touchpad driver sync problem":
> > Marc Waeckerlin wrote:
> > > Am Freitag, 25. Juni 2004 16.02 schrieb Dmitry Torokhov unter "Re:
> > > Continue:
> > > > Anyway, I also have a tiy patch to try out (attached, not tested/
> > > > not compiled). Please let me know how ifit makes any improvement.
> > > No, unfortunately no improvement at all.
> >
> > Yeah, I figure there would not be any. Still I have a nagging suspicion
> > that the mux gets confused and I would like to see the full dmesg with
> > this patch applied and DEBUG enabled.
> 
> "dmesg" won't help, because the buffer gets filled too quickly. I send you the 
> part from /var/log/messages since last boot. File size is 386KB, so I send it 
> to you directly, not through the mailing list. You are free to forward it, if 
> you think it's useful for others.
>

Ok, this is much better, it confirms my suspicions... It seems that your
keyboard controller gets confused where the data is coming from. Please
try the patch below (against vanilla 2.6.7, not compiled/tested). 

> 
> > Is there any change of getting it? 
> 
> What do you mean by this?
>

Nevermind ;)
 
-- 
Dmitry

--- 2.6.7/drivers/input/serio/i8042.c	2004-06-22 01:23:15.000000000 -0500
+++ linux-2.6.7/drivers/input/serio/i8042.c	2004-06-29 12:48:21.000000000 -0500
@@ -400,19 +400,35 @@
 		goto out;
 	}
 
-	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
-	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
-
 	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
+		static unsigned long last_transmit;
+		static unsigned char last_str;
 
+		dfl = 0;
 		if (str & I8042_STR_MUXERR) {
+			printk(KERN_INFO "i8042.c: MUX reports error condition %02x, data is %02x\n", str, data);
 			switch (data) {
+				default:
+/*
+ * When MUXERR condition is signalled the data register can only contain
+ * 0xfd, 0xfe or 0xff if implementation follows the spec. Unfortunately
+ * it is not always the case. Some KBC just get confused which port the
+ * data came from and signal error leaving the data intact. They _do not_
+ * revert to legacy mode (actually I've never seen KBC reverting to legacy
+ * mode yet, when we see one we'll add proper handling).
+ * Anyway, we will assume that the data came from the same serio last byte
+ * was transmitted (if transmission happened not too long ago).
+ */
+					if (time_before(jiffies, last_transmit + HZ/10)) {
+						str = last_str;
+						break;
+					}
+					/* fall through - report timeout */
 				case 0xfd:
-				case 0xfe: dfl = SERIO_TIMEOUT; break;
-				case 0xff: dfl = SERIO_PARITY; break;
+				case 0xfe: dfl = SERIO_TIMEOUT; data = 0xfe; break;
+				case 0xff: dfl = SERIO_PARITY;  data = 0xfe; break;
 			}
-			data = 0xfe;
-		} else dfl = 0;
+		}
 
 		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
 			data, (str >> 6), irq,
@@ -421,9 +437,14 @@
 
 		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
 
+		last_str = str;
+		last_transmit = jiffies;
 		goto irq_ret;
 	}
 
+	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
+	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
+
 	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
 		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
 		dfl & SERIO_PARITY ? ", bad parity" : "",
