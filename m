Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUKXNWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUKXNWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUKXNUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:20:13 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:58516 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262648AbUKXNCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:02:43 -0500
Subject: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101296414.5805.286.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here we add simple hooks so that the user can interact with suspend
while it is running. (Hmm. The serial console condition could be
simplified :>). The hooks allow you to do such things as:

- cancel suspending
- change the amount of detail of debugging info shown
- change what debugging info is shown
- pause the process
- single step
- toggle rebooting instead of powering down

diff -ruN 702-keyboard-and-8250-hooks-old/drivers/char/keyboard.c 702-keyboard-and-8250-hooks-new/drivers/char/keyboard.c
--- 702-keyboard-and-8250-hooks-old/drivers/char/keyboard.c	2004-11-24 18:50:00.959995424 +1100
+++ 702-keyboard-and-8250-hooks-new/drivers/char/keyboard.c	2004-11-24 18:03:32.040404608 +1100
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
 #include <linux/slab.h>
 
 #include <linux/kbd_kern.h>
@@ -1091,6 +1092,10 @@
 		return;
 	}
 #endif
+	if (down && (test_suspend_state(SUSPEND_RUNNING))) {
+		suspend_handle_keypress(keycode, SUSPEND_KEY_KEYBOARD);
+		return;
+	}
 #if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
 	if (keycode == KEY_A && sparc_l1_a_state) {
 		sparc_l1_a_state = 0;
diff -ruN 702-keyboard-and-8250-hooks-old/drivers/serial/8250.c 702-keyboard-and-8250-hooks-new/drivers/serial/8250.c
--- 702-keyboard-and-8250-hooks-old/drivers/serial/8250.c	2004-11-24 18:50:00.962994968 +1100
+++ 702-keyboard-and-8250-hooks-new/drivers/serial/8250.c	2004-11-24 18:49:53.882071432 +1100
@@ -39,6 +39,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1068,6 +1069,15 @@
 		}
 		if (uart_handle_sysrq_char(&up->port, ch, regs))
 			goto ignore_char;
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) && defined(CONFIG_SOFTWARE_SUSPEND2)
+		if (test_suspend_state(SUSPEND_SANITY_CHECK_PROMPT) ||
+		    test_suspend_state(SUSPEND_RUNNING)) {
+			suspend_handle_keypress(ch, SUSPEND_KEY_SERIAL);
+			goto ignore_char;
+		}
+#endif
+
 		if ((lsr & up->port.ignore_status_mask) == 0) {
 			tty_insert_flip_char(tty, ch, flag);
 		}


