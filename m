Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264300AbUD0TYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUD0TYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbUD0TYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:24:16 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7387 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S264300AbUD0TYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:24:10 -0400
Date: Tue, 27 Apr 2004 12:24:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix thinkos in #if -> #ifdef conversions
Message-ID: <20040427192408.GC1655@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<donning brown paper bag>
When I changed some '#if FOO' tests to '#ifdef FOO' I forgot to make
sure that nothing was doing #define FOO 0.  So after auditing all of the
changes I made, the following is needed:

===== arch/ppc/4xx_io/serial_sicc.c 1.16 vs edited =====
--- 1.16/arch/ppc/4xx_io/serial_sicc.c	Wed Apr  7 15:55:06 2004
+++ edited/arch/ppc/4xx_io/serial_sicc.c	Tue Apr 27 12:17:52 2004
@@ -32,6 +32,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -190,10 +191,6 @@
 #define FALSE 0
 #endif
 
-#define DEBUG 0
-
-
-
 /*
  * Things needed by tty driver
  */
@@ -763,9 +760,7 @@
 
     cflag = info->tty->termios->c_cflag;
 
-#ifdef DEBUG
-    printk("siccuart_set_cflag(0x%x) called\n", cflag);
-#endif
+    pr_debug("siccuart_set_cflag(0x%x) called\n", cflag);
     /* byte size and parity */
     switch (cflag & CSIZE) {
     case CS7: lcr_h =   _LCR_PE_DISABLE | _LCR_DB_7_BITS | _LCR_SB_1_BIT; bits = 9;  break;
@@ -1027,9 +1022,7 @@
     struct SICC_info *info = tty->driver_data;
     unsigned long flags;
 
-#ifdef DEBUG
-    printk("siccuart_flush_buffer(%d) called\n", tty->index);
-#endif
+    pr_debug("siccuart_flush_buffer(%d) called\n", tty->index);
     save_flags(flags); cli();
     info->xmit.head = info->xmit.tail = 0;
     restore_flags(flags);
@@ -1433,9 +1426,7 @@
 
     state = info->state;
 
-#ifdef DEBUG
-    //printk("siccuart_close() called\n");
-#endif
+    //pr_debug("siccuart_close() called\n");
 
     save_flags(flags); cli();
 
@@ -1544,11 +1535,9 @@
         timeout = 2 * info->timeout;
 
     expire = jiffies + timeout;
-#ifdef DEBUG
-    printk("siccuart_wait_until_sent(%d), jiff=%lu, expire=%lu  char_time=%lu...\n",
+    pr_debug("siccuart_wait_until_sent(%d), jiff=%lu, expire=%lu  char_time=%lu...\n",
            tty->index, jiffies,
            expire, char_time);
-#endif
     while ((readb(info->port->uart_base + BL_SICC_LSR) & _LSR_TX_ALL) != _LSR_TX_ALL) {
         set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(char_time);
@@ -1831,9 +1820,8 @@
     unsigned int status;
     char *w;
     int c;
-#ifdef DEBUG
-    printk("siccuart_console_read() called\n");
-#endif
+
+    pr_debug("siccuart_console_read() called\n");
 
     c = 0;
     w = s;
===== arch/ppc/kernel/signal.c 1.31 vs edited =====
--- 1.31/arch/ppc/kernel/signal.c	Wed Apr  7 15:55:06 2004
+++ edited/arch/ppc/kernel/signal.c	Tue Apr 27 12:16:25 2004
@@ -33,7 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 
-#define DEBUG_SIG 0
+#undef DEBUG_SIG
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
