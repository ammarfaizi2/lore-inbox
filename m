Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJYFRD>; Fri, 25 Oct 2002 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSJYFRD>; Fri, 25 Oct 2002 01:17:03 -0400
Received: from mail.eskimo.com ([204.122.16.4]:53002 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261281AbSJYFQy>;
	Fri, 25 Oct 2002 01:16:54 -0400
Date: Thu, 24 Oct 2002 22:19:56 -0700
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Untested patch 1/2 - add ugly printk macros to kernel (was Re: [RFC] CONFIG_TINY)
Message-ID: <20021025051956.GA20357@eskimo.com>
References: <20021023215117.A29134@jaquet.dk> <20021024030143.GA13661@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024030143.GA13661@eskimo.com>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an untested patch example against 2.5.44 to add some ugly printk
macros to the kernel, to reduce kernel image size for tiny systems.

I verified that this builds a kernel image on my system (if I fix some
2.5.44 build failures, obviously), with the fixup patch I'm sending next
to modify some of the sources for the new printk style.

This patch is hardly complete, and is just an example of using macros to
selectively cut out printk string/code bloat from the kernel.  By
changing the TAG_PRINTK_LVL and UNTAG_PRINTK_LVL numbers, selective
levels of printks can be compiled out of the kernel.

With my config and gcc-3.1 (which has dead-string pruning), I got these
build-size numbers with different TAG_PRINTK values:

Define printk like normal (#define printk(a,arg...) _printk(a, ##arg))
System is 1093 kB

All levels on (7 TAG/7 UNTAG)
System is 1090 kB (3k less, not sure why)

Only tagged warning or above (4/7)
System is 1024 kB

Only tagged alert or above (1/7)
System is 1002 kB

Only tagged emergency (0/7)
System is 1002 kB

All printk off (-1/7)
System is 997 kB

Kill printk completely (#define printk(a...) 0)
System is 997 kB


There are several obvious problems with this implementation:

* The KERN_ERR etc. macros can't work in all situations, since they are
  no longer simple strings.  The second patch fixes some of these
  situations.
* Changing the printk symbol to be _printk is probably a bad idea.  It
  would be best to keep the symbol name the same in a real
  implementation.
* It's somewhat hard to read.

Comments?

-J

--- include/linux/kernel.h-orig	2002-10-24 18:20:16.000000000 -0700
+++ include/linux/kernel.h	2002-10-24 18:23:36.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
+#include <linux/printk.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
@@ -29,15 +30,6 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-#define	KERN_EMERG	"<0>"	/* system is unusable			*/
-#define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
-#define	KERN_CRIT	"<2>"	/* critical conditions			*/
-#define	KERN_ERR	"<3>"	/* error conditions			*/
-#define	KERN_WARNING	"<4>"	/* warning conditions			*/
-#define	KERN_NOTICE	"<5>"	/* normal but significant condition	*/
-#define	KERN_INFO	"<6>"	/* informational			*/
-#define	KERN_DEBUG	"<7>"	/* debug-level messages			*/
-
 struct completion;
 
 #ifdef CONFIG_DEBUG_KERNEL
@@ -78,9 +70,6 @@
 
 extern int session_of_pgrp(int pgrp);
 
-asmlinkage int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 extern int console_loglevel;
 
 static inline void console_silent(void)
--- kernel/printk.c-orig	2002-10-24 18:57:06.000000000 -0700
+++ kernel/printk.c	2002-10-24 18:57:40.000000000 -0700
@@ -296,7 +296,7 @@
 		if (copy_from_user(lbuf, buf, len))
 			break;
 		lbuf[len] = '\0';
-		error = printk("%s", lbuf);
+		error = _printk("%s", lbuf);
 		break;
 	default:
 		error = -EINVAL;
@@ -419,7 +419,7 @@
  * then changes console_loglevel may break. This is because console_loglevel
  * is inspected when the actual printing occurs.
  */
-asmlinkage int printk(const char *fmt, ...)
+asmlinkage int _printk(const char *fmt, ...)
 {
 	va_list args;
 	unsigned long flags;
@@ -488,7 +488,7 @@
 out:
 	return printed_len;
 }
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(_printk);
 
 /**
  * acquire_console_sem - lock the console system for exclusive use.
--- /dev/null	2002-07-27 00:29:01.000000000 -0700
+++ include/linux/printk.h	2002-10-24 21:33:01.000000000 -0700
@@ -0,0 +1,150 @@
+#ifndef _LINUX_PRINTK_H
+#define _LINUX_PRINTK_H
+
+/*
+ * 'printk.h' contains some scary macros implementing compile-time
+ * selectable warning levels.
+ */
+
+#ifdef __KERNEL__
+
+#include <stdarg.h>
+#include <linux/linkage.h>
+
+/* Actual prepend strings */
+#define	KERN_EMERG_STR	 "<0>"	/* system is unusable			*/
+#define	KERN_ALERT_STR	 "<1>"	/* action must be taken immediately	*/
+#define	KERN_CRIT_STR	 "<2>"	/* critical conditions			*/
+#define	KERN_ERR_STR	 "<3>"	/* error conditions			*/
+#define	KERN_WARNING_STR "<4>"	/* warning conditions			*/
+#define	KERN_NOTICE_STR	 "<5>"	/* normal but significant condition	*/
+#define	KERN_INFO_STR	 "<6>"	/* informational			*/
+#define	KERN_DEBUG_STR	 "<7>"	/* debug-level messages			*/
+
+#define	KERN_EMERG_LVL	 0
+#define	KERN_ALERT_LVL	 1
+#define	KERN_CRIT_LVL	 2
+#define	KERN_ERR_LVL	 3
+#define	KERN_WARNING_LVL 4
+#define	KERN_NOTICE_LVL	 5
+#define	KERN_INFO_LVL	 6
+#define	KERN_DEBUG_LVL	 7
+
+#if 1
+
+/* The operation of these macros is somewhat obscure.  Basically, we
+ * depend on the optimizing compiler being able to remove branches
+ * that can never be followed because the expression is constant
+ * false.
+ *
+ * TAG_PRINTK_LVL and UNTAG_PRINTK_LVL may be changed at build time,
+ * allowing the user to compile printk statements below the listed
+ * level out completely.
+ *
+ * By default, they always succeed, so these macros should be (more or less)
+ * equivalent to standard printk calls.
+ *
+ * A possible problem on older versions of GCC is that, even if turned
+ * off, the actual strings may still be included in the object file.
+ */
+
+#if !defined(TAG_PRINTK_LVL)
+# define TAG_PRINTK_LVL 7
+#endif
+
+#if !defined(UNTAG_PRINTK_LVL)
+# define UNTAG_PRINTK_LVL 7
+#endif
+
+/* The trick here is that the a argument may be replaced by a KERN_
+ * macro, which will cause the UNTAG switch statement to disable itself.
+ * The kern macro will then place the proper level-based code in its own
+ * if statement.
+ */
+extern const char *__broken_printk_call;
+
+#define printk(a, arg...) ({ \
+	{ \
+		int ret;\
+		if(TAG_PRINTK_LVL >= UNTAG_PRINTK_LVL) \
+			switch(UNTAG_PRINTK_LVL) { \
+			default: \
+				ret = _printk(0+ a, ##arg); \
+			} \
+		ret; \
+	} \
+}) 
+
+#define KERN_EMERG __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_EMERG_LVL) { \
+			ret = _printk(KERN_EMERG_STR
+
+#define KERN_ALERT __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_ALERT_LVL) { \
+			_printk(KERN_ALERT_STR
+
+#define KERN_CRIT __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_CRIT_LVL) { \
+			_printk(KERN_CRIT_STR
+
+#define KERN_ERR __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_ERR_LVL) { \
+			_printk(KERN_ERR_STR
+
+#define KERN_WARNING __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_WARNING_LVL) { \
+			_printk(KERN_WARNING_STR
+
+#define KERN_NOTICE __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_NOTICE_LVL) { \
+			_printk(KERN_NOTICE_STR
+
+#define KERN_INFO __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_INFO_LVL) { \
+			_printk(KERN_INFO_STR
+
+#define KERN_DEBUG __broken_printk_call); \
+			case UNTAG_PRINTK_LVL: \
+			ret = 0; \
+			} \
+		if(TAG_PRINTK_LVL >= KERN_DEBUG_LVL) { \
+			_printk(KERN_DEBUG_STR
+#else
+#define printk(a, arg...) _printk(a, ##arg)
+#define	KERN_EMERG	KERN_EMERG_STR
+#define	KERN_ALERT	KERN_ALERT_STR
+#define	KERN_CRIT	KERN_CRIT_STR
+#define	KERN_ERR	KERN_ERR_STR
+#define	KERN_WARNING 	KERN_WARNING_STR
+#define	KERN_NOTICE	KERN_NOTICE_STR
+#define	KERN_INFO	KERN_INFO_STR
+#define	KERN_DEBUG	KERN_DEBUG_STR
+#endif
+
+asmlinkage int _printk(const char * fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+#endif /* __KERNEL__ */
+
+#endif

