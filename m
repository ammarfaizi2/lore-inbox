Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRAZUsb>; Fri, 26 Jan 2001 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRAZUsV>; Fri, 26 Jan 2001 15:48:21 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:54532 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130383AbRAZUsT>; Fri, 26 Jan 2001 15:48:19 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Fri, 26 Jan 2001 21:46:02 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, Stefani@seibold.net
Subject: patch for 2.4.0 disable printk
MIME-Version: 1.0
Message-Id: <01012621460200.01354@deepthought.seibold.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
Hi Alan,
Hi everybody,

this kernel patch allows to disable all printk messages, by overloading the 
printk function with a dummy printk macro.

This patch is usefull for embedded systems, where the hardware never changes 
and normaly no textconsole is attachted nor any user will see the boot 
messages. Also, it is nice for rescue disks.

On my system this saves about 10% of disk- and ramspace.

For example: My standart desktop kernel is 994834 bytes, without printk 
messages it is only 899664 bytes long. The basic kernel ram usage is also 10% 
less than the same kernel with printk messages.

Greetings,
Stefani

BTW: this is my first try to submit a kernel patch

-----patch for 2.4.0 disable printk-----

diff -u --recursive --new-file linux/Documentation/Configure.help 
linux.noprintk/Documentation/Configure.help
--- linux/Documentation/Configure.help  Thu Jan  4 22:00:55 2001
+++ linux.noprintk/Documentation/Configure.help Thu Jan 18 12:14:41 2001
@@ -12139,6 +12179,14 @@
 
   If unsure, say Y, or else you won't be able to do much with your new
   shiny Linux system :-)
+
+Disable kernel messages
+CONFIG_PRINTK
+  This option allows you to disable all kernel messages by overriding
+  the printk function with an empty macro.
+  On small embedded systems, this save a lot of rom and ram space. On
+  server or desktop systems you want human readable outputs, so it is
+  normaly the best choice to say N to this option.
 
 Support for console on virtual terminal
 CONFIG_VT_CONSOLE
diff -u --recursive --new-file linux/drivers/char/Config.in 
linux.noprintk/drivers/char/Config.in
--- linux/drivers/char/Config.in        Fri Dec 29 23:07:21 2000
+++ linux.noprintk/drivers/char/Config.in       Thu Jan 18 10:33:07 2001
@@ -4,6 +4,7 @@
 mainmenu_option next_comment
 comment 'Character devices'
 
+bool 'Disable kernel messages' CONFIG_PRINTK
 bool 'Virtual terminal' CONFIG_VT
 if [ "$CONFIG_VT" = "y" ]; then
    bool '  Support for console on virtual terminal' CONFIG_VT_CONSOLE
diff -u --recursive --new-file linux/include/asm-i386/spinlock.h 
linux.noprintk/include/asm-i386/spinlock.h
--- linux/include/asm-i386/spinlock.h   Thu Jan  4 23:50:46 2001
+++ linux.noprintk/include/asm-i386/spinlock.h  Thu Jan 25 23:07:43 2001
@@ -5,8 +5,10 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 
+#ifndef CONFIG_PRINTK
 extern int printk(const char * fmt, ...)
        __attribute__ ((format (printf, 1, 2)));
+#endif
 
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
diff -u --recursive --new-file linux/include/linux/kernel.h 
linux.noprintk/include/linux/kernel.h
--- linux/include/linux/kernel.h        Mon Dec 11 21:49:54 2000
+++ linux.noprintk/include/linux/kernel.h       Thu Jan 25 16:15:17 2001
@@ -68,8 +68,13 @@
 
 extern int session_of_pgrp(int pgrp);
 
+#ifdef CONFIG_PRINTK
+#define        printk(x...)    ((void)0)
+#else
 asmlinkage int printk(const char * fmt, ...)
        __attribute__ ((format (printf, 1, 2)));
+#endif
+
 
 extern int console_loglevel;
 
diff -u --recursive --new-file linux/kernel/ksyms.c 
linux.noprintk/kernel/ksyms.c
--- linux/kernel/ksyms.c        Wed Jan  3 01:45:37 2001
+++ linux.noprintk/kernel/ksyms.c       Thu Jan 18 12:14:41 2001
@@ -439,7 +440,9 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+#ifndef CONFIG_PRINTK
 EXPORT_SYMBOL(printk);
+#endif
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(kdevname);
diff -u --recursive --new-file linux/kernel/printk.c 
linux.noprintk/kernel/printk.c
--- linux/kernel/printk.c       Sun Dec 31 03:16:13 2000
+++ linux.noprintk/kernel/printk.c      Thu Jan 25 23:03:37 2001
@@ -25,7 +25,9 @@
 #define LOG_BUF_LEN    (16384)
 #define LOG_BUF_MASK   (LOG_BUF_LEN-1)
 
+#ifndef CONFIG_PRINTK
 static char buf[1024];
+#endif
 
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
@@ -251,6 +253,20 @@
        return do_syslog(type, buf, len);
 }
 
+
+#ifdef CONFIG_PRINTK
+#undef printk
+
+#include <linux/module.h>
+
+asmlinkage int printk(const char *fmt, ...)
+{
+       return 0;
+}
+
+EXPORT_SYMBOL_NOVERS(printk);
+
+#else
 asmlinkage int printk(const char *fmt, ...)
 {
        va_list args;
@@ -311,6 +322,7 @@
        wake_up_interruptible(&log_wait);
        return i;
 }
+#endif
 
 void console_print(const char *s)
 {
diff -u --recursive --new-file linux/CREDITS linux.noprintk/CREDITS
--- linux/CREDITS       Sun Dec 31 18:27:57 2000
+++ linux.noprintk/CREDITS      Fri Jan 26 10:51:19 2001
@@ -2395,6 +2395,14 @@
 S: Oldenburg
 S: Germany
 
+N: Stefani Seibold
+E: Stefani@Seibold.net
+D: Possibility to disable all kernel messages by overload printk with a
+D: dummy macro (saves a lot of disk- and ramspace for embedded systems
+D: and rescue disks)
+S: Munich
+S: Germany
+
 N: Darren Senn
 E: sinster@darkwater.com
 D: Whatever I notice needs doing (so far: itimers, /proc)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
