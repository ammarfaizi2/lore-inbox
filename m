Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVDAURg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVDAURg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVDAUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:16:47 -0500
Received: from waste.org ([216.27.176.166]:39313 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262876AbVDAUJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:09:02 -0500
Date: Fri, 1 Apr 2005 12:08:51 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] clean up kernel messages
Message-ID: <20050401200851.GG15453@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tidies up those annoying kernel messages. A typical kernel
boot now looks like this:

Loading Linux... Uncompressing kernel...
#

See? Much nicer. This patch saves about 375k on my laptop config and
nearly 100k on minimal configs.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: af/include/linux/kernel.h
===================================================================
--- af.orig/include/linux/kernel.h	2005-04-01 00:32:18.000000000 -0800
+++ af/include/linux/kernel.h	2005-04-01 10:38:43.000000000 -0800
@@ -115,10 +115,19 @@ extern int __kernel_text_address(unsigne
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
+#ifdef CONFIG_PRINTK
 asmlinkage int vprintk(const char *fmt, va_list args)
 	__attribute__ ((format (printf, 1, 0)));
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#else
+static inline int vprintk(const char *s, va_list args)
+	__attribute__ ((format (printf, 1, 0)));
+static inline int vprintk(const char *s, va_list args) { return 0; }
+static inline int printk(const char *s, ...)
+	__attribute__ ((format (printf, 1, 2)));
+static inline int printk(const char *s, ...) { return 0; }
+#endif
 
 unsigned long int_sqrt(unsigned long);
 
Index: af/init/Kconfig
===================================================================
--- af.orig/init/Kconfig	2005-04-01 00:40:27.000000000 -0800
+++ af/init/Kconfig	2005-04-01 11:02:18.000000000 -0800
@@ -275,6 +275,17 @@ config KALLSYMS_EXTRA_PASS
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
+ 
+config PRINTK
+	default y
+	bool "Enable support for printk" if EMBEDDED
+	help
+	  This option enables normal printk support. Removing it
+	  eliminates most of the message strings from the kernel image
+	  and makes the kernel more or less silent. As this makes it
+	  very difficult to diagnose system problems, saying N here is
+	  strongly discouraged.
+
 config BUG
 	bool "BUG() support" if EMBEDDED
 	default y
Index: af/kernel/printk.c
===================================================================
--- af.orig/kernel/printk.c	2005-04-01 00:32:18.000000000 -0800
+++ af/kernel/printk.c	2005-04-01 10:30:30.000000000 -0800
@@ -80,10 +80,6 @@ static int console_locked;
  */
 static DEFINE_SPINLOCK(logbuf_lock);
 
-static char __log_buf[__LOG_BUF_LEN];
-static char *log_buf = __log_buf;
-static int log_buf_len = __LOG_BUF_LEN;
-
 #define LOG_BUF_MASK	(log_buf_len-1)
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
@@ -94,7 +90,6 @@ static int log_buf_len = __LOG_BUF_LEN;
 static unsigned long log_start;	/* Index into log_buf: next char to be read by syslog() */
 static unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
 static unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
-static unsigned long logged_chars; /* Number of chars produced since last read+clear operation */
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -115,6 +110,13 @@ static int preferred_console = -1;
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
+#ifdef CONFIG_PRINTK
+
+static char __log_buf[__LOG_BUF_LEN];
+static char *log_buf = __log_buf;
+static int log_buf_len = __LOG_BUF_LEN;
+static unsigned long logged_chars; /* Number of chars produced since last read+clear operation */
+
 /*
  *	Setup a list of consoles. Called from init/main.c
  */
@@ -530,6 +532,7 @@ __setup("time", printk_time_setup);
  * then changes console_loglevel may break. This is because console_loglevel
  * is inspected when the actual printing occurs.
  */
+
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -650,6 +653,18 @@ out:
 EXPORT_SYMBOL(printk);
 EXPORT_SYMBOL(vprintk);
 
+#else
+
+asmlinkage long sys_syslog(int type, char __user * buf, int len)
+{
+	return 0;
+}
+
+int do_syslog(int type, char __user * buf, int len) { return 0; }
+static void call_console_drivers(unsigned long start, unsigned long end) {}
+
+#endif
+
 /**
  * acquire_console_sem - lock the console system for exclusive use.
  *
@@ -923,7 +938,7 @@ int unregister_console(struct console * 
 	return res;
 }
 EXPORT_SYMBOL(unregister_console);
-	
+
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
  *
Index: af/arch/i386/kernel/head.S
===================================================================
--- af.orig/arch/i386/kernel/head.S	2005-03-02 22:51:03.000000000 -0800
+++ af/arch/i386/kernel/head.S	2005-04-01 10:30:30.000000000 -0800
@@ -380,6 +380,7 @@ rp_sidt:
 	ALIGN
 ignore_int:
 	cld
+#ifdef CONFIG_PRINTK
 	pushl %eax
 	pushl %ecx
 	pushl %edx
@@ -400,6 +401,7 @@ ignore_int:
 	popl %edx
 	popl %ecx
 	popl %eax
+#endif
 	iret
 
 /*


-- 
Mathematics is the supreme nostalgia of our time.
