Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277196AbRJQUxh>; Wed, 17 Oct 2001 16:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277192AbRJQUx1>; Wed, 17 Oct 2001 16:53:27 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:20241 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S277196AbRJQUxL>; Wed, 17 Oct 2001 16:53:11 -0400
Message-ID: <3BCDEFCC.35FCFB69@eisenstein.dk>
Date: Wed, 17 Oct 2001 22:53:32 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Keith Owens <kaos@ocs.com.au>, "Randy.Dunlap" <rddunlap@osdl.org>,
        linux-ia64@linuxia64.org
Subject: [PATCH] console_loglevel broken on ia64 - please test and comment
Content-Type: multipart/mixed;
 boundary="------------C6348075EA1E0BDD31E2351F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C6348075EA1E0BDD31E2351F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This is an attempt to fix the broken console_loglevel in kernel/printk.c
that Keith Owens reported to the list some hours ago.

Instead of the four different _loglevel variables it adds a
console_printk array to hold the four values - that should be safe.

I have tested this as far as

a) it compiles
b) it boots
c) it has not exploded yet after more than an hour of use
d) "cat /proc/sys/kernel/printk" output looks sane both with and without
the patch
e) changing console_loglevel with "ALT-Sysrq-<number>" works and is
correctly reflected in /proc/sys/kernel/printk

Randy Dunlap was kind enough to take a look at the patch and thought it
looked ok, so I'm now submitting it to a broader audience to get some
more feedback before I try to send this off to Linux and/or Alan.

If nobody seems to screams at it too badly, then I'll make a version
against -ac as well and send it off to Linus and Alan for them to look
at and hopefully include in the next kernel.

The patch is against 2.4.13-pre3  and is attached as
"2.4.13-pre3-console_loglevel.patch".


Best regards,
Jesper Juhl
juhl@eisenstein.dk
--------------C6348075EA1E0BDD31E2351F
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-console_loglevel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-console_loglevel.patch"

diff -ur linux-2.4.13-pre3-orig/arch/i386/mm/fault.c linux-2.4.13-pre3/arch/i386/mm/fault.c
--- linux-2.4.13-pre3-orig/arch/i386/mm/fault.c	Wed Oct 10 00:13:03 2001
+++ linux-2.4.13-pre3/arch/i386/mm/fault.c	Wed Oct 17 20:04:33 2001
@@ -27,8 +27,6 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
-extern int console_loglevel;
-
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
diff -ur linux-2.4.13-pre3-orig/arch/parisc/kernel/traps.c linux-2.4.13-pre3/arch/parisc/kernel/traps.c
--- linux-2.4.13-pre3-orig/arch/parisc/kernel/traps.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.13-pre3/arch/parisc/kernel/traps.c	Wed Oct 17 20:05:21 2001
@@ -43,7 +43,6 @@
 
 static inline void console_verbose(void)
 {
-	extern int console_loglevel;
 	console_loglevel = 15;
 }
 
diff -ur linux-2.4.13-pre3-orig/include/linux/kernel.h linux-2.4.13-pre3/include/linux/kernel.h
--- linux-2.4.13-pre3-orig/include/linux/kernel.h	Thu Oct 11 08:44:33 2001
+++ linux-2.4.13-pre3/include/linux/kernel.h	Wed Oct 17 22:05:00 2001
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
@@ -79,8 +86,6 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
-
-extern int console_loglevel;
 
 static inline void console_silent(void)
 {
diff -ur linux-2.4.13-pre3-orig/kernel/printk.c linux-2.4.13-pre3/kernel/printk.c
--- linux-2.4.13-pre3-orig/kernel/printk.c	Mon Sep 17 22:16:30 2001
+++ linux-2.4.13-pre3/kernel/printk.c	Wed Oct 17 22:21:51 2001
@@ -16,6 +16,7 @@
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -39,11 +40,12 @@
 
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
 

--------------C6348075EA1E0BDD31E2351F--

