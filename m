Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVA3NDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVA3NDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 08:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVA3NDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 08:03:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18702 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261698AbVA3NDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 08:03:10 -0500
Date: Sun, 30 Jan 2005 14:03:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add compiler-gcc4.h
Message-ID: <20050130130308.GK3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the release of gcc 4.0 being only a few months away and people 
already tring compiling with it, it's time for adding a compiler-gcc4.h .

This patch contains the following changes:
- compiler-gcc+.h: add the missing noinline and __compiler_offsetof
- compiler-gcc4.h: new file based on the corrected compiler-gcc+.h
- compiler.h: include compiler-gcc4.h for gcc 4
- compiler-gcc3.h: remove __compiler_offsetof (there will never be a
                                               gcc 3.5)
                   small indention corrections

I've tested the compilation with both gcc 3.4.4 and a recent gcc 4.0 
snapshot from Debian experimental.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/compiler-gcc+.h |    3 +++
 include/linux/compiler-gcc3.h |   10 ++++------
 include/linux/compiler-gcc4.h |   16 ++++++++++++++++
 include/linux/compiler.h      |    6 ++++--
 4 files changed, 27 insertions(+), 8 deletions(-)

--- linux-2.6.11-rc2-mm2-full/include/linux/compiler.h.old	2005-01-30 09:59:28.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/compiler.h	2005-01-30 10:00:15.000000000 +0100
@@ -34,8 +34,10 @@
 
 #ifdef __KERNEL__
 
-#if __GNUC__ > 3
-# include <linux/compiler-gcc+.h>	/* catch-all for GCC 4, 5, etc. */
+#if __GNUC__ > 4
+# include <linux/compiler-gcc+.h>	/* catch-all for GCC 5, 6, etc. */
+#elif __GNUC__ == 4
+# include <linux/compiler-gcc4.h>
 #elif __GNUC__ == 3
 # include <linux/compiler-gcc3.h>
 #elif __GNUC__ == 2
--- linux-2.6.11-rc2-mm2-full/include/linux/compiler-gcc+.h.old	2005-01-30 10:01:40.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/compiler-gcc+.h	2005-01-30 10:09:01.000000000 +0100
@@ -13,4 +13,7 @@
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
+#define  noinline		__attribute__((noinline))
 #define __must_check 		__attribute__((warn_unused_result))
+#define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
+
--- linux-2.6.11-rc2-mm2-full/include/linux/compiler-gcc3.h.old	2005-01-30 10:05:16.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/compiler-gcc3.h	2005-01-30 10:08:38.000000000 +0100
@@ -10,7 +10,7 @@
 #endif
 
 #if __GNUC_MINOR__ > 0
-# define __deprecated	__attribute__((deprecated))
+# define __deprecated		__attribute__((deprecated))
 #endif
 
 #if __GNUC_MINOR__ >= 3
@@ -23,12 +23,10 @@
 #define __attribute_const__	__attribute__((__const__))
 
 #if __GNUC_MINOR__ >= 1
-#define  noinline __attribute__((noinline))
+#define  noinline		__attribute__((noinline))
 #endif
+
 #if __GNUC_MINOR__ >= 4
-#define __must_check __attribute__((warn_unused_result))
+#define __must_check		__attribute__((warn_unused_result))
 #endif
 
-#if __GNUC_MINOR__ >= 5
-#define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
-#endif
--- /dev/null	2004-11-25 03:16:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/compiler-gcc4.h	2005-01-30 10:09:08.000000000 +0100
@@ -0,0 +1,16 @@
+/* Never include this file directly.  Include <linux/compiler.h> instead.  */
+
+/* These definitions are for GCC v4.x.  */
+#include <linux/compiler-gcc.h>
+
+#define inline			inline		__attribute__((always_inline))
+#define __inline__		__inline__	__attribute__((always_inline))
+#define __inline		__inline	__attribute__((always_inline))
+#define __deprecated		__attribute__((deprecated))
+#define __attribute_used__	__attribute__((__used__))
+#define __attribute_pure__	__attribute__((pure))
+#define __attribute_const__	__attribute__((__const__))
+#define  noinline		__attribute__((noinline))
+#define __must_check 		__attribute__((warn_unused_result))
+#define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
+
