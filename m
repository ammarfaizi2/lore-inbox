Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317995AbSGRLeA>; Thu, 18 Jul 2002 07:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGRLeA>; Thu, 18 Jul 2002 07:34:00 -0400
Received: from draco.netpower.no ([212.33.133.34]:54031 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317995AbSGRLd7>; Thu, 18 Jul 2002 07:33:59 -0400
Date: Thu, 18 Jul 2002 13:36:36 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: patchmonkey <trivial@rustcorp.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL][PATCH 2.5] clean up drivers after sysrq changes in 2.5.26
Message-ID: <20020718133636.A15256@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.5.26 handle_sysrq() "lost" a parameter. I've grepped through the kernel and corrected all the users of this function.

Patch against clean 2.5.26


Regards,
	Erlend Aasland

diff -urN linux-2.5.26/arch/mips/au1000/common/serial.c linux-2.5.26-dirty/arch/mips/au1000/common/serial.c
--- linux-2.5.26/arch/mips/au1000/common/serial.c	2002-07-06 01:42:20.000000000 +0200
+++ linux-2.5.26-dirty/arch/mips/au1000/common/serial.c	2002-07-18 13:13:34.000000000 +0200
@@ -433,7 +433,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}
diff -urN linux-2.5.26/arch/ppc/4xx_io/serial_sicc.c linux-2.5.26-dirty/arch/ppc/4xx_io/serial_sicc.c
--- linux-2.5.26/arch/ppc/4xx_io/serial_sicc.c	2002-07-06 01:42:02.000000000 +0200
+++ linux-2.5.26-dirty/arch/ppc/4xx_io/serial_sicc.c	2002-07-18 13:13:54.000000000 +0200
@@ -462,7 +462,7 @@
 #ifdef SUPPORT_SYSRQ
         if (info->sysrq) {
             if (ch && time_before(jiffies, info->sysrq)) {
-                handle_sysrq(ch, regs, NULL, NULL);
+                handle_sysrq(ch, regs, NULL);
                 info->sysrq = 0;
                 goto ignore_char;
             }
diff -urN linux-2.5.26/arch/ppc/8xx_io/uart.c linux-2.5.26-dirty/arch/ppc/8xx_io/uart.c
--- linux-2.5.26/arch/ppc/8xx_io/uart.c	2002-07-06 01:42:32.000000000 +0200
+++ linux-2.5.26-dirty/arch/ppc/8xx_io/uart.c	2002-07-18 13:13:43.000000000 +0200
@@ -481,7 +481,7 @@
 			if (break_pressed && info->line == sercons.index) {
 				if (ch != 0 && time_before(jiffies, 
 							break_pressed + HZ*5)) {
-					handle_sysrq(ch, regs, NULL, NULL);
+					handle_sysrq(ch, regs, NULL);
 					break_pressed = 0;
 					goto ignore_char;
 				} else
diff -urN linux-2.5.26/drivers/char/serial_amba.c linux-2.5.26-dirty/drivers/char/serial_amba.c
--- linux-2.5.26/drivers/char/serial_amba.c	2002-07-06 01:42:04.000000000 +0200
+++ linux-2.5.26-dirty/drivers/char/serial_amba.c	2002-07-18 13:11:49.000000000 +0200
@@ -356,7 +356,7 @@
 #ifdef SUPPORT_SYSRQ
 		if (info->sysrq) {
 			if (ch && time_before(jiffies, info->sysrq)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				info->sysrq = 0;
 				goto ignore_char;
 			}
diff -urN linux-2.5.26/drivers/s390/char/ctrlchar.c linux-2.5.26-dirty/drivers/s390/char/ctrlchar.c
--- linux-2.5.26/drivers/s390/char/ctrlchar.c	2002-07-06 01:42:38.000000000 +0200
+++ linux-2.5.26-dirty/drivers/s390/char/ctrlchar.c	2002-07-18 13:11:24.000000000 +0200
@@ -26,7 +26,7 @@
 
 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif
 
diff -urN linux-2.5.26/drivers/sbus/char/sunkbd.c linux-2.5.26-dirty/drivers/sbus/char/sunkbd.c
--- linux-2.5.26/drivers/sbus/char/sunkbd.c	2002-07-06 01:42:32.000000000 +0200
+++ linux-2.5.26-dirty/drivers/sbus/char/sunkbd.c	2002-07-18 13:09:58.000000000 +0200
@@ -544,7 +544,7 @@
 #ifdef CONFIG_MAGIC_SYSRQ			/* Handle the SysRq hack */
 	if (l1a_state.l1_down) {
 		if (!up_flag)
-			handle_sysrq(sun_sysrq_xlate[keycode], pt_regs, kbd, tty);
+			handle_sysrq(sun_sysrq_xlate[keycode], pt_regs, tty);
 		goto out;
 	}
 #endif
diff -urN linux-2.5.26/drivers/tc/zs.c linux-2.5.26-dirty/drivers/tc/zs.c
--- linux-2.5.26/drivers/tc/zs.c	2002-07-06 01:42:33.000000000 +0200
+++ linux-2.5.26-dirty/drivers/tc/zs.c	2002-07-18 13:13:24.000000000 +0200
@@ -443,7 +443,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}
