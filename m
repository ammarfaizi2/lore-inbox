Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVDAJIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVDAJIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDAJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:08:53 -0500
Received: from waste.org ([216.27.176.166]:11148 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262592AbVDAJHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:07:48 -0500
Date: Fri, 1 Apr 2005 01:07:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove all kernel bugs
Message-ID: <20050401090744.GD15453@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been sitting on this patch for a while, figured it's high time I
shared it with the world. This patch eliminates all kernel bugs, trims
about 35k off the typical kernel, and makes the system slightly
faster. The patch is against the latest bk snapshot, please apply.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: af/include/asm-i386/bug.h
===================================================================
--- af.orig/include/asm-i386/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-i386/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -9,6 +9,8 @@
  * undefined" opcode for parsing in the trap handler.
  */
 
+#ifdef CONFIG_BUG
+#define HAVE_ARCH_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
@@ -18,8 +20,7 @@
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
+#endif
 
-#define HAVE_ARCH_BUG
 #include <asm-generic/bug.h>
-
 #endif
Index: af/include/asm-x86_64/bug.h
===================================================================
--- af.orig/include/asm-x86_64/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-x86_64/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -15,11 +15,14 @@ struct bug_frame {
 	unsigned short line;
 } __attribute__((packed));
 
+#ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
 #define BUG() \
 	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
 		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
 void out_of_line_bug(void);
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-sparc64/bug.h
===================================================================
--- af.orig/include/asm-sparc64/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-sparc64/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -1,6 +1,7 @@
 #ifndef _SPARC64_BUG_H
 #define _SPARC64_BUG_H
 
+#ifdef CONFIG_BUG
 #include <linux/compiler.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -14,6 +15,8 @@ extern void do_BUG(const char *file, int
 #endif
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-m68k/bug.h
===================================================================
--- af.orig/include/asm-m68k/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-m68k/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_SUN3
 #define BUG() do { \
@@ -22,6 +23,8 @@
 #endif
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-generic/bug.h
===================================================================
--- af.orig/include/asm-generic/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-generic/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -4,6 +4,7 @@
 #include <linux/compiler.h>
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
@@ -31,4 +32,22 @@
 } while (0)
 #endif
 
+#else /* !CONFIG_BUG */
+#ifndef HAVE_ARCH_BUG
+#define BUG()
+#endif
+
+#ifndef HAVE_ARCH_PAGE_BUG
+#define PAGE_BUG(page) do { if (page) ; } while (0)
+#endif
+
+#ifndef HAVE_ARCH_BUG_ON
+#define BUG_ON(condition) do { if (condition) ; } while(0)
+#endif
+
+#ifndef HAVE_ARCH_WARN_ON
+#define WARN_ON(condition) do { if (condition) ; } while(0)
+#endif
+#endif
+
 #endif
Index: af/include/asm-s390/bug.h
===================================================================
--- af.orig/include/asm-s390/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-s390/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,12 +3,15 @@
 
 #include <linux/kernel.h>
 
+#ifdef CONFIG_BUG
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
         __asm__ __volatile__(".long 0"); \
 } while (0)
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-arm/bug.h
===================================================================
--- af.orig/include/asm-arm/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-arm/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 extern volatile void __bug(const char *file, int line, void *data);
 
@@ -17,6 +18,8 @@ extern volatile void __bug(const char *f
 #endif
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-arm26/bug.h
===================================================================
--- af.orig/include/asm-arm26/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-arm26/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 extern volatile void __bug(const char *file, int line, void *data);
 /* give file/line information */
@@ -12,6 +13,8 @@ extern volatile void __bug(const char *f
 #endif
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-ia64/bug.h
===================================================================
--- af.orig/include/asm-ia64/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-ia64/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -1,6 +1,7 @@
 #ifndef _ASM_IA64_BUG_H
 #define _ASM_IA64_BUG_H
 
+#ifdef CONFIG_BUG
 #if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
 # define ia64_abort()	__builtin_trap()
 #else
@@ -8,8 +9,10 @@
 #endif
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
 
-/* should this BUG should be made generic? */
+/* should this BUG be made generic? */
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-v850/bug.h
===================================================================
--- af.orig/include/asm-v850/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-v850/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -14,9 +14,12 @@
 #ifndef __V850_BUG_H__
 #define __V850_BUG_H__
 
+#ifdef CONFIG_BUG
 extern void __bug (void) __attribute__ ((noreturn));
 #define BUG()		__bug()
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif /* __V850_BUG_H__ */
Index: af/include/asm-alpha/bug.h
===================================================================
--- af.orig/include/asm-alpha/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-alpha/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_BUG_H
 #define _ALPHA_BUG_H
 
+#ifdef CONFIG_BUG
 #include <asm/pal.h>
 
 /* ??? Would be nice to use .gprel32 here, but we can't be sure that the
@@ -10,6 +11,8 @@
 		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-ppc/bug.h
===================================================================
--- af.orig/include/asm-ppc/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-ppc/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -14,6 +14,7 @@ struct bug_entry {
  */
 #define BUG_WARNING_TRAP	0x1000000
 
+#ifdef CONFIG_BUG
 #define BUG() do {							 \
 	__asm__ __volatile__(						 \
 		"1:	twi 31,0,0\n"					 \
@@ -50,6 +51,8 @@ struct bug_entry {
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-frv/bug.h
===================================================================
--- af.orig/include/asm-frv/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-frv/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 /*
  * Tell the user there is some problem.
  */
@@ -45,6 +46,7 @@ do {						\
 #define HAVE_ARCH_KGDB_BAD_PAGE
 #define kgdb_bad_page(page) do { kgdb_raise(SIGABRT); } while(0)
 #endif
+#endif
 
 #include <asm-generic/bug.h>
 
Index: af/include/asm-ppc64/bug.h
===================================================================
--- af.orig/include/asm-ppc64/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-ppc64/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -26,6 +26,8 @@ struct bug_entry *find_bug(unsigned long
  */
 #define BUG_WARNING_TRAP	0x1000000
 
+#ifdef CONFIG_BUG
+
 #define BUG() do {							 \
 	__asm__ __volatile__(						 \
 		"1:	twi 31,0,0\n"					 \
@@ -55,11 +57,12 @@ struct bug_entry *find_bug(unsigned long
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
-#endif
-
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
+#endif
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-sh/bug.h
===================================================================
--- af.orig/include/asm-sh/bug.h	2005-04-01 00:31:54.000000000 -0800
+++ af/include/asm-sh/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_BUG
 /*
  * Tell the user there is some problem.
  */
@@ -12,6 +13,8 @@
 } while (0)
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-sparc/bug.h
===================================================================
--- af.orig/include/asm-sparc/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-sparc/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -1,6 +1,7 @@
 #ifndef _SPARC_BUG_H
 #define _SPARC_BUG_H
 
+#ifdef CONFIG_BUG
 /* Only use the inline asm until a gcc release that can handle __builtin_trap
  * -rob 2003-06-25
  *
@@ -26,6 +27,8 @@ extern void do_BUG(const char *file, int
 #endif
 
 #define HAVE_ARCH_BUG
+#endif
+
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-mips/bug.h
===================================================================
--- af.orig/include/asm-mips/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-mips/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -3,12 +3,14 @@
 
 #include <asm/break.h>
 
+#ifdef CONFIG_BUG
+#define HAVE_ARCH_BUG
 #define BUG()								\
 do {									\
 	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));		\
 } while (0)
+#endif
 
-#define HAVE_ARCH_BUG
 #include <asm-generic/bug.h>
 
 #endif
Index: af/include/asm-parisc/bug.h
===================================================================
--- af.orig/include/asm-parisc/bug.h	2005-03-02 22:51:03.000000000 -0800
+++ af/include/asm-parisc/bug.h	2005-04-01 00:33:32.000000000 -0800
@@ -1,12 +1,14 @@
 #ifndef _PARISC_BUG_H
 #define _PARISC_BUG_H
 
+#ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 	dump_stack(); \
 	panic("BUG!"); \
 } while (0)
+#endif
 
 #include <asm-generic/bug.h>
 #endif
Index: af/lib/Kconfig.debug
===================================================================
--- af.orig/lib/Kconfig.debug	2005-04-01 00:32:18.000000000 -0800
+++ af/lib/Kconfig.debug	2005-04-01 00:41:02.000000000 -0800
@@ -108,6 +108,7 @@ config DEBUG_HIGHMEM
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
+	depends on BUG
 	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
 	default !EMBEDDED
 	help
Index: af/init/Kconfig
===================================================================
--- af.orig/init/Kconfig	2005-04-01 00:32:18.000000000 -0800
+++ af/init/Kconfig	2005-04-01 00:40:27.000000000 -0800
@@ -275,6 +275,16 @@ config KALLSYMS_EXTRA_PASS
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
+config BUG
+	bool "BUG() support" if EMBEDDED
+	default y
+	help
+          Disabling this option eliminates support for BUG and WARN, reducing
+          the size of your kernel image and potentially quietly ignoring
+          numerous fatal conditions. You should only consider disabling this
+          option for embedded systems with no facilities for reporting errors.
+          Just say Y.
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EMBEDDED


-- 
Mathematics is the supreme nostalgia of our time.
