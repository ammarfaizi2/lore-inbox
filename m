Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUGHHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUGHHCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGHHAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:00:36 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:50306 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265825AbUGHG7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/8] New set of input patches
Date: Thu, 8 Jul 2004 01:56:30 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080155.38937.dtor_core@ameritech.net> <200407080156.05021.dtor_core@ameritech.net>
In-Reply-To: <200407080156.05021.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080156.32341.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1822, 2004-07-08 00:23:44-05:00, dtor_core@ameritech.net
  Input: workaround for i8042 active multiplexing controllers losing
         track of where data is coming from. Also sprinkled some
         "likely"s in i8042 interrupt handler.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |   60 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 42 insertions(+), 18 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-07-08 01:35:04 -05:00
+++ b/drivers/input/serio/i8042.c	2004-07-08 01:35:04 -05:00
@@ -362,6 +362,7 @@
 	unsigned long flags;
 	unsigned char str, data = 0;
 	unsigned int dfl;
+	unsigned int aux_idx;
 	int ret;
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
@@ -378,44 +379,67 @@
 		goto out;
 	}
 
-	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
-	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
-
-	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
+	if (i8042_mux_present && (str & I8042_STR_AUXDATA)) {
+		static unsigned long last_transmit;
+		static unsigned char last_str;
 
+		dfl = 0;
 		if (str & I8042_STR_MUXERR) {
+			dbg("MUX error, status is %02x, data is %02x", str, data);
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
+
+		aux_idx = (str >> 6) & 3;
 
 		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-			data, (str >> 6), irq,
+			data, aux_idx, irq,
 			dfl & SERIO_PARITY ? ", bad parity" : "",
 			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-		serio_interrupt(i8042_mux_port[(str >> 6) & 3], data, dfl, regs);
+		if (likely(i8042_mux_values[aux_idx].exists))
+			serio_interrupt(i8042_mux_port[aux_idx], data, dfl, regs);
 
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
 		dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-	if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
-		serio_interrupt(i8042_aux_port, data, dfl, regs);
-		goto irq_ret;
-	}
-
-	if (!i8042_kbd_values.exists)
-		goto irq_ret;
 
-	serio_interrupt(i8042_kbd_port, data, dfl, regs);
+	if (str & I8042_STR_AUXDATA) {
+		if (likely(i8042_aux_values.exists))
+			serio_interrupt(i8042_aux_port, data, dfl, regs);
+	} else {
+		if (likely(i8042_kbd_values.exists))
+			serio_interrupt(i8042_kbd_port, data, dfl, regs);
+	}
 
 irq_ret:
 	ret = 1;
