Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTIWIwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 04:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTIWIwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 04:52:05 -0400
Received: from topconrd.ru ([62.105.138.7]:59407 "EHLO TopconRD.RU")
	by vger.kernel.org with ESMTP id S263002AbTIWIv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 04:51:59 -0400
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] drivers/char/mxser.c, 2.4.23-pre5, fix TIOCSBRK/TIOCCBRK.
X-attribution: osv
From: Sergei Organov <osv@topconrd.ru>
Date: 23 Sep 2003 12:51:42 +0400
Message-ID: <87pthr51lt.fsf@osv.topconrd.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
drivers/char/mxser.c doesn't handle TIOCSBRK/TIOCCBRK ioctls.

Fix: The patch below fixes TIOCSBRK/TIOCCBRK handling in 'mxser.c' by means of
defining break_ctl routine for tty_driver thus lets upper-level tty driver
handle all break related ioctls.

diff -Naur linux-2.4.23-pre5/drivers/char/mxser.c linux-2.4.23-pre5.patched/drivers/char/mxser.c
--- linux-2.4.23-pre5/drivers/char/mxser.c	Fri Nov 29 02:53:12 2002
+++ linux-2.4.23-pre5.patched/drivers/char/mxser.c	Mon Sep 22 17:01:20 2003
@@ -29,11 +29,14 @@
  *
  *      for             : LINUX 2.0.X, 2.2.X, 2.4.X
  *      date            : 2001/05/01
- *      version         : 1.2 
+ *      version         : 1.2
  *      
  *    Fixes for C104H/PCI by Tim Hockin <thockin@sun.com>
  *    Added support for: C102, CI-132, CI-134, CP-132, CP-114, CT-114 cards
  *                        by Damian Wrobel <dwrobel@ertel.com.pl>
+ *    09/03: Use tty_driver.break_ctl for break control. This fixes handling
+ *           of TIOCSBRK/TIOCCBRK by the driver.
+ *                        by Sergei Organov <osv@topconrd.ru>
  *
  */
 
@@ -65,7 +68,7 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-#define		MXSER_VERSION			"1.2.1"
+#define		MXSER_VERSION			"1.2.2"
 
 #define		MXSERMAJOR	 	174
 #define		MXSERCUMAJOR		175
@@ -368,7 +371,7 @@
 static int mxser_get_serial_info(struct mxser_struct *, struct serial_struct *);
 static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct *);
 static int mxser_get_lsr_info(struct mxser_struct *, unsigned int *);
-static void mxser_send_break(struct mxser_struct *, int);
+static void mxser_break_ctl(struct tty_struct *, int);
 static int mxser_get_modem_info(struct mxser_struct *, unsigned int *);
 static int mxser_set_modem_info(struct mxser_struct *, unsigned int, unsigned int *);
 
@@ -556,6 +559,7 @@
 	mxvar_sdriver.stop = mxser_stop;
 	mxvar_sdriver.start = mxser_start;
 	mxvar_sdriver.hangup = mxser_hangup;
+        mxvar_sdriver.break_ctl = mxser_break_ctl;
 
 	/*
 	 * The callout device is just like normal device except for
@@ -1061,7 +1065,6 @@
 {
 	unsigned long flags;
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
-	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct *p_cuser;		/* user space */
 	unsigned long templ;
@@ -1074,21 +1077,6 @@
 			return (-EIO);
 	}
 	switch (cmd) {
-	case TCSBRK:		/* SVID version: non-zero arg --> no break */
-		retval = tty_check_change(tty);
-		if (retval)
-			return (retval);
-		tty_wait_until_sent(tty, 0);
-		if (!arg)
-			mxser_send_break(info, HZ / 4);		/* 1/4 second */
-		return (0);
-	case TCSBRKP:		/* support for POSIX tcsendbreak() */
-		retval = tty_check_change(tty);
-		if (retval)
-			return (retval);
-		tty_wait_until_sent(tty, 0);
-		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
-		return (0);
 	case TIOCGSOFTCAR:
 		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
 	case TIOCSSOFTCAR:
@@ -2253,19 +2241,18 @@
 }
 
 /*
- * This routine sends a break character out the serial port.
+ * This routine turns the break condition on or off
  */
-static void mxser_send_break(struct mxser_struct *info, int duration)
+static void mxser_break_ctl(struct tty_struct *tty, int break_state)
 {
+	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned long flags;
-	if (!info->base)
-		return;
-	set_current_state(TASK_INTERRUPTIBLE);
-	save_flags(flags);
-	cli();
-	outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
-	schedule_timeout(duration);
-	outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
+	
+	save_flags(flags); cli();
+	if (break_state == -1)
+          outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
+	else
+          outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
 	restore_flags(flags);
 }
 

