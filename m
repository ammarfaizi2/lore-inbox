Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSG2SXC>; Mon, 29 Jul 2002 14:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSG2SXB>; Mon, 29 Jul 2002 14:23:01 -0400
Received: from draco.netpower.no ([212.33.133.34]:42507 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317570AbSG2SW5>; Mon, 29 Jul 2002 14:22:57 -0400
Date: Mon, 29 Jul 2002 20:26:01 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Patchmonkey <trivial@rustcorp.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL][PATCH 2.5] Fix users of handle_sysrq()
Message-ID: <20020729202601.A25972@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some weeks ago, handle_sysrq() lost a parameter. A few users of that
function were not modified, so they were broken. This patch should fix
them.

Affected files:
/arch/mips/au1000/common/serial.c
/arch/ppc/4xx_io/serial_sicc.c
/arch/ppc/8xx_io/uart.c
/drivers/s390/char/ctrlchar.c
/drivers/sbus/char/sunkbd.c
/drivers/tc/zs.c
/drivers/char/hvc_console.c

Applies to 2.5.29 and current bk.

Regards,
	Erlend Aasland

diff -urN linux-2.5.29/arch/mips/au1000/common/serial.c linux-2.5.29-dirty/arch/mips/au1000/common/serial.c
--- linux-2.5.29/arch/mips/au1000/common/serial.c	2002-07-06 01:42:20.000000000 +0200
+++ linux-2.5.29-dirty/arch/mips/au1000/common/serial.c	2002-07-18 13:13:34.000000000 +0200
@@ -433,7 +433,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}
diff -urN linux-2.5.29/arch/ppc/4xx_io/serial_sicc.c linux-2.5.29-dirty/arch/ppc/4xx_io/serial_sicc.c
--- linux-2.5.29/arch/ppc/4xx_io/serial_sicc.c	2002-07-06 01:42:02.000000000 +0200
+++ linux-2.5.29-dirty/arch/ppc/4xx_io/serial_sicc.c	2002-07-18 13:13:54.000000000 +0200
@@ -462,7 +462,7 @@
 #ifdef SUPPORT_SYSRQ
         if (info->sysrq) {
             if (ch && time_before(jiffies, info->sysrq)) {
-                handle_sysrq(ch, regs, NULL, NULL);
+                handle_sysrq(ch, regs, NULL);
                 info->sysrq = 0;
                 goto ignore_char;
             }
diff -urN linux-2.5.29/arch/ppc/8xx_io/uart.c linux-2.5.29-dirty/arch/ppc/8xx_io/uart.c
--- linux-2.5.29/arch/ppc/8xx_io/uart.c	2002-07-06 01:42:32.000000000 +0200
+++ linux-2.5.29-dirty/arch/ppc/8xx_io/uart.c	2002-07-18 13:13:43.000000000 +0200
@@ -481,7 +481,7 @@
 			if (break_pressed && info->line == sercons.index) {
 				if (ch != 0 && time_before(jiffies, 
 							break_pressed + HZ*5)) {
-					handle_sysrq(ch, regs, NULL, NULL);
+					handle_sysrq(ch, regs, NULL);
 					break_pressed = 0;
 					goto ignore_char;
 				} else
diff -urN linux-2.5.29/drivers/s390/char/ctrlchar.c linux-2.5.29-dirty/drivers/s390/char/ctrlchar.c
--- linux-2.5.29/drivers/s390/char/ctrlchar.c	2002-07-06 01:42:38.000000000 +0200
+++ linux-2.5.29-dirty/drivers/s390/char/ctrlchar.c	2002-07-18 13:11:24.000000000 +0200
@@ -26,7 +26,7 @@
 
 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif
 
diff -urN linux-2.5.29/drivers/sbus/char/sunkbd.c linux-2.5.29-dirty/drivers/sbus/char/sunkbd.c
--- linux-2.5.29/drivers/sbus/char/sunkbd.c	2002-07-06 01:42:32.000000000 +0200
+++ linux-2.5.29-dirty/drivers/sbus/char/sunkbd.c	2002-07-18 13:09:58.000000000 +0200
@@ -544,7 +544,7 @@
 #ifdef CONFIG_MAGIC_SYSRQ			/* Handle the SysRq hack */
 	if (l1a_state.l1_down) {
 		if (!up_flag)
-			handle_sysrq(sun_sysrq_xlate[keycode], pt_regs, kbd, tty);
+			handle_sysrq(sun_sysrq_xlate[keycode], pt_regs, tty);
 		goto out;
 	}
 #endif
diff -urN linux-2.5.29/drivers/tc/zs.c linux-2.5.29-dirty/drivers/tc/zs.c
--- linux-2.5.29/drivers/tc/zs.c	2002-07-06 01:42:33.000000000 +0200
+++ linux-2.5.29-dirty/drivers/tc/zs.c	2002-07-18 13:13:24.000000000 +0200
@@ -443,7 +443,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}
diff -urN linux-2.5.29/drivers/char/hvc_console.c linux-2.5.29-dirty/drivers/char/hvc_console.c
--- linux-2.5.29/drivers/char/hvc_console.c	Mon Jul 29 18:10:41 2002
+++ linux-2.5.29-dirty/drivers/char/hvc_console.c	Mon Jul 29 18:11:01 2002
@@ -204,7 +204,7 @@
 					sysrq_pressed = 1;
 					continue;
 				} else if (sysrq_pressed) {
-					handle_sysrq(buf[i], NULL, NULL, tty);
+					handle_sysrq(buf[i], NULL, tty);
 					sysrq_pressed = 0;
 					continue;
 				}
