Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBBKXd>; Fri, 2 Feb 2001 05:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbRBBKXX>; Fri, 2 Feb 2001 05:23:23 -0500
Received: from wachturm.neopoly.de ([195.162.227.129]:54533 "HELO
	wachturm.neopoly.de") by vger.kernel.org with SMTP
	id <S129080AbRBBKXL>; Fri, 2 Feb 2001 05:23:11 -0500
Message-ID: <3A7A8A81.E72E1425@neopoly.de>
Date: Fri, 02 Feb 2001 11:22:57 +0100
From: Michael Stiller <ms@neopoly.de>
Organization: Neopoly AG - never stop trading -
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.2.18 serial console sysrq backport
Content-Type: multipart/mixed;
 boundary="------------7E5D54D55937C34E46B2C603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7E5D54D55937C34E46B2C603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi *,

i just backported the 2.4.x serial.c changes to enable MAGIC_SYSRQ via
serial console
on 2.2.18. Patch is working ok so far, i have included it here, maybe it
is useful for
someone. You need to enable CONFIG_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ
to use it.
To trigger MAGIC_SYSRQ send a "break" to the serial console. e.g. 
ALT-a f in minicom. (To trigger the help function try alt-a f h)

Cheers,
-Michael

-- 
Sik an regeln ortografi unt gramatik su halten erhohen 
ferstandlikkeit von gesribene tekste erheblik.
--------------7E5D54D55937C34E46B2C603
Content-Type: text/plain; charset=us-ascii;
 name="serial.sysrq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.sysrq.patch"

--- linux/drivers/char/serial.c.orig	Fri Feb  2 10:13:25 2001
+++ linux/drivers/char/serial.c	Fri Feb  2 10:35:39 2001
@@ -143,6 +143,10 @@
 #include <linux/console.h>
 #endif
 
+#ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/sysrq.h>
+#endif
+
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -178,6 +182,9 @@
 #ifdef CONFIG_SERIAL_CONSOLE
 static struct console sercons;
 #endif
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+static unsigned long break_pressed; /* break, really ... */
+#endif
 
 static unsigned detect_uart_irq (struct serial_state * state);
 static void autoconfig(struct serial_state * info);
@@ -376,7 +383,7 @@
 }
 
 static _INLINE_ void receive_chars(struct async_struct *info,
-				 int *status)
+				 int *status, struct pt_regs * regs)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch;
@@ -403,6 +410,21 @@
 			if (*status & UART_LSR_BI) {
 				*status &= ~(UART_LSR_FE | UART_LSR_PE);
 				icount->brk++;
+                        /*
+                         * We do the SysRQ and SAK checking
+                         * here because otherwise the break
+                         * may get masked by ignore_status_mask
+                         * or read_status_mask.
+                         */
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+                                if (info->line == sercons.index) {
+                                        if (!break_pressed) {
+                                                break_pressed = jiffies;
+                                                goto ignore_char;
+                                        }
+                                        break_pressed = 0;
+                                }
+#endif
 			} else if (*status & UART_LSR_PE)
 				icount->parity++;
 			else if (*status & UART_LSR_FE)
@@ -447,6 +469,17 @@
 				}
 			}
 		}
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+                if (break_pressed && info->line == sercons.index) {
+                        if (ch != 0 &&
+                            time_before(jiffies, break_pressed + HZ*5)) {
+                                handle_sysrq(ch, regs, NULL, NULL);
+                                break_pressed = 0;
+                                goto ignore_char;
+                        }
+                        break_pressed = 0;
+                }
+#endif
 		tty->flip.flag_buf_ptr++;
 		tty->flip.char_buf_ptr++;
 		tty->flip.count++;
@@ -612,7 +645,7 @@
 		printk("status = %x...", status);
 #endif
 		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
+			receive_chars(info, &status, regs);
 		check_modem_status(info);
 		if (status & UART_LSR_THRE)
 			transmit_chars(info, 0);
@@ -676,7 +709,7 @@
 		printk("status = %x...", status);
 #endif
 		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
+			receive_chars(info, &status, regs);
 		check_modem_status(info);
 		if (status & UART_LSR_THRE)
 			transmit_chars(info, 0);
@@ -739,7 +772,7 @@
 		printk("status = %x...", status);
 #endif
 		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
+			receive_chars(info, &status, regs);
 		check_modem_status(info);
 		if (status & UART_LSR_THRE)
 			transmit_chars(info, 0);

--------------7E5D54D55937C34E46B2C603--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
