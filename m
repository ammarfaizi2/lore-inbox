Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTDJMpG (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 08:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTDJMpF (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 08:45:05 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:62950 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264035AbTDJMpD (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 08:45:03 -0400
Date: Thu, 10 Apr 2003 14:56:28 +0200 (MEST)
Message-Id: <200304101256.h3ACuSw3022796@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linuxppc-dev@lists.linuxppc.org
Subject: gcc-2.95 broken on PPC?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems gcc-2.95, specifically 2.95.4 as included in YDL2.3,
generates incorrect code for recent 2.4 standard kernels on PPC.

Background: Boot floppies made with 2.2 kernels work on my PM4400,
but ones made from recent standard 2.4 kernels fail with a CLAIM error
just after OF has loaded vmlinux.coff. To debug this, I've been slowly
moving forwards from older to newer kernels, making patches at each
point a new kernel version broke vmlinux.coff.

For the latest standard kernel, 2.4.21-pre7, I need three distinct
patches to make vmlinux.coff boot correctly. They are:

1. 2.4.19-pre4 changed arch/ppc/boot/zlib.c in what appears to be a
   reversal to an older version, causing a CLAIM error at the boot
   "clearing .bss" line; my patch reverts that change (but see below)
2. starting with 2.4.20, I get a CLAIM error at the "loading .data"
   line; a well-known patch posted to linuxppc-dev fixed that
   (change arch/ppc/boot/ld.script .data ALIGN(8) to ALIGN(4096))
3. 2.4.21-pre6 changed include/asm-ppc/div64.h to use long long
   arithmetic, again causing a CLAIM error at the "clearing .bss" line;
   my patch reverts that change (but see below)

However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
indication that 2.95.4 is broken on PPC. Is this something that's
well-known to PPC people?

The patches are included below for reference.

/Mikael

--- linux-2.4.21-pre7/arch/ppc/boot/lib/zlib.c.~1~	Wed Apr  9 10:32:51 2003
+++ linux-2.4.21-pre7/arch/ppc/boot/lib/zlib.c	Wed Apr  9 10:39:41 2003
@@ -925,10 +925,7 @@
       {
         r = t;
         if (r == Z_DATA_ERROR)
-	{
-          ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
           s->mode = BADB;
-	}
         LEAVE
       }
       s->sub.trees.index = 0;
@@ -964,7 +961,6 @@
           if (i + j > 258 + (t & 0x1f) + ((t >> 5) & 0x1f) ||
               (c == 16 && i < 1))
           {
-            ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
             s->mode = BADB;
             z->msg = "invalid bit length repeat";
             r = Z_DATA_ERROR;
@@ -992,10 +988,7 @@
         if (t != Z_OK)
         {
           if (t == (uInt)Z_DATA_ERROR)
-	  {
-            ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
             s->mode = BADB;
-	  }
           r = t;
           LEAVE
         }
--- linux-2.4.21-pre7/arch/ppc/boot/ld.script.~1~	Sat Nov 30 17:12:23 2002
+++ linux-2.4.21-pre7/arch/ppc/boot/ld.script	Wed Apr  9 10:38:43 2003
@@ -39,7 +39,7 @@
   PROVIDE (etext = .);
 
   /* Read-write section, merged into data segment: */
-  . = ALIGN(8);
+  . = ALIGN(4096);
   .data    :
   {
     *(.data)
--- linux-2.4.21-pre7/include/asm-ppc/div64.h.~1~	Wed Apr  9 10:34:58 2003
+++ linux-2.4.21-pre7/include/asm-ppc/div64.h	Wed Apr  9 10:38:11 2003
@@ -1,23 +1,10 @@
 #ifndef __PPC_DIV64
 #define __PPC_DIV64
 
-#include <linux/types.h>
-
-extern u32 __div64_32(u64 *dividend, u32 div);
-
-#define do_div(n, div)	({			\
-	u64 __n = (n);				\
-	u32 __d = (div);			\
-	u32 __q, __r;				\
-	if ((__n >> 32) == 0) {			\
-		__q = (u32)__n / __d;		\
-		__r = (u32)__n - __q * __d;	\
-		(n) = __q;			\
-	} else {				\
-		__r = __div64_32(&__n, __d);	\
-		(n) = __n;			\
-	}					\
-	__r;					\
-})
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
 
 #endif
