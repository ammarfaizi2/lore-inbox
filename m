Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbRDVGof>; Sun, 22 Apr 2001 02:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135324AbRDVGoZ>; Sun, 22 Apr 2001 02:44:25 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:20235 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S135323AbRDVGoP>; Sun, 22 Apr 2001 02:44:15 -0400
Date: Sun, 22 Apr 2001 08:43:15 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix for __builtin_expect compile problem in 2.4.4-pre6.
Message-ID: <Pine.LNX.4.33.0104220840060.3118-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the __builtin_expect compile problem in 2.4.4-pre6 by
moving the definition of __builtin_expect from
include/asm-alpha/compiler.h to include/linux/compiler.h and including
this file where needed. I haven't touched the ia64 files that uses
__builtin_expect. Does any pre-2.96 compilers have support for ia64?

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

diff -u --recursive --new-file v2.4.4-pre6/linux/include/asm-alpha/compiler.h linux/include/asm-alpha/compiler.h
--- v2.4.4-pre6/linux/include/asm-alpha/compiler.h	Mon Nov 13 04:27:11 2000
+++ linux/include/asm-alpha/compiler.h	Sun Apr 22 08:28:07 2001
@@ -72,13 +72,4 @@
   __asm__("stw %1,%0" : "=m"(mem) : "r"(val))
 #endif

-/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
-   a mechanism by which the user can annotate likely branch directions and
-   expect the blocks to be reordered appropriately.  Define __builtin_expect
-   to nothing for earlier compilers.  */
-
-#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
-#define __builtin_expect(x, expected_value) (x)
-#endif
-
 #endif /* __ALPHA_COMPILER_H */
diff -u --recursive --new-file v2.4.4-pre6/linux/include/asm-alpha/semaphore.h linux/include/asm-alpha/semaphore.h
--- v2.4.4-pre6/linux/include/asm-alpha/semaphore.h	Sun Apr 22 08:18:53 2001
+++ linux/include/asm-alpha/semaphore.h	Sun Apr 22 08:28:29 2001
@@ -11,7 +11,7 @@
 #include <asm/current.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/compiler.h>	/* __builtin_expect */
+#include <linux/compiler.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>

diff -u --recursive --new-file v2.4.4-pre6/linux/include/linux/compiler.h linux/include/linux/compiler.h
--- v2.4.4-pre6/linux/include/linux/compiler.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/compiler.h	Sun Apr 22 08:29:12 2001
@@ -0,0 +1,13 @@
+#ifndef __LINUX_COMPILER_H
+#define __LINUX_COMPILER_H
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __LINUX_COMPILER_H */
diff -u --recursive --new-file v2.4.4-pre6/linux/lib/rwsem.c linux/lib/rwsem.c
--- v2.4.4-pre6/linux/lib/rwsem.c	Sun Apr 22 08:19:11 2001
+++ linux/lib/rwsem.c	Sun Apr 22 08:29:37 2001
@@ -6,6 +6,7 @@
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/compiler.h>

 struct rwsem_waiter {
 	struct rwsem_waiter	*next;

