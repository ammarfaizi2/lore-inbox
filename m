Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286699AbRLUWvy>; Fri, 21 Dec 2001 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286648AbRLUWvf>; Fri, 21 Dec 2001 17:51:35 -0500
Received: from fe170.worldonline.dk ([212.54.64.199]:32014 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S286630AbRLUWva>; Fri, 21 Dec 2001 17:51:30 -0500
Message-ID: <3C23BD30.F8C3B2E1@dif.dk>
Date: Fri, 21 Dec 2001 23:52:32 +0100
From: Jesper Juhl <jju@dif.dk>
Reply-To: jju@dif.dk
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@conectiva.com.br
Subject: [PATCH] console_loglevel broken on ia64 (and possibly other archs)
Content-Type: multipart/mixed;
 boundary="------------BB217310CA571AB92C2C26DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BB217310CA571AB92C2C26DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This patch fixes the console_loglevel variable(s) so that code that
assumes the variables occupy continuous storage does not break (and
overwrite other data).

Without this patch this will break on ia64 :

echo 6 4 1 7 > /proc/sys/kernel/printk

with this patch everything works as expected on ia64 and ia32 and as far
as I can tell it should have no ill effects on other archs.

The patch has been tested by Keith Owens who agrees that the patch works
and fixes the bug. And I've been told that David Mosberger has included
this patch in his ia64 add on patch. 
So I hope that it could go into 2.4.18-pre when that starts but I'm
posting it to the list in case someone else wants to comment on it.

The patch applies cleanly to 2.4.17-final


Best regards,
Jesper Juhl
jju@dif.dk
--------------BB217310CA571AB92C2C26DC
Content-Type: text/plain; charset=us-ascii;
 name="2.4.17-console_loglevel-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.17-console_loglevel-1.patch"

diff -ur linux-2.4.17-rc1-orig/arch/i386/mm/fault.c linux-2.4.17-rc1/arch/i386/mm/fault.c
--- linux-2.4.17-rc1-orig/arch/i386/mm/fault.c	Wed Oct 10 00:13:03 2001
+++ linux-2.4.17-rc1/arch/i386/mm/fault.c	Mon Dec 17 20:05:41 2001
@@ -27,8 +27,6 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
-extern int console_loglevel;
-
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
diff -ur linux-2.4.17-rc1-orig/arch/parisc/kernel/traps.c linux-2.4.17-rc1/arch/parisc/kernel/traps.c
--- linux-2.4.17-rc1-orig/arch/parisc/kernel/traps.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.17-rc1/arch/parisc/kernel/traps.c	Mon Dec 17 20:05:41 2001
@@ -43,7 +43,6 @@
 
 static inline void console_verbose(void)
 {
-	extern int console_loglevel;
 	console_loglevel = 15;
 }
 
diff -ur linux-2.4.17-rc1-orig/include/linux/kernel.h linux-2.4.17-rc1/include/linux/kernel.h
--- linux-2.4.17-rc1-orig/include/linux/kernel.h	Fri Dec 14 00:08:23 2001
+++ linux-2.4.17-rc1/include/linux/kernel.h	Mon Dec 17 20:05:41 2001
@@ -36,6 +36,13 @@
 #define	KERN_INFO	"<6>"	/* informational			*/
 #define	KERN_DEBUG	"<7>"	/* debug-level messages			*/
 
+extern int console_printk[];
+
+#define console_loglevel (console_printk[0])
+#define default_message_loglevel (console_printk[1])
+#define minimum_console_loglevel (console_printk[2])
+#define default_console_loglevel (console_printk[3])
+
 # define NORET_TYPE    /**/
 # define ATTRIB_NORET  __attribute__((noreturn))
 # define NORET_AND     noreturn,
@@ -81,8 +88,6 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
-
-extern int console_loglevel;
 
 static inline void console_silent(void)
 {
diff -ur linux-2.4.17-rc1-orig/kernel/printk.c linux-2.4.17-rc1/kernel/printk.c
--- linux-2.4.17-rc1-orig/kernel/printk.c	Fri Dec 14 00:04:53 2001
+++ linux-2.4.17-rc1/kernel/printk.c	Mon Dec 17 20:05:41 2001
@@ -16,6 +16,7 @@
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -51,11 +52,12 @@
 
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
-/* Keep together for sysctl support */
-int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
-int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
-int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
-int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
+int console_printk[4] = {
+	DEFAULT_CONSOLE_LOGLEVEL,	/* console_loglevel */
+	DEFAULT_MESSAGE_LOGLEVEL,	/* default_message_loglevel */
+	MINIMUM_CONSOLE_LOGLEVEL,	/* minimum_console_loglevel */
+	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
+};
 
 int oops_in_progress;
 

--------------BB217310CA571AB92C2C26DC--

