Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUDGJJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUDGJJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:09:56 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:8847 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261884AbUDGJJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:09:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Use volatile qualifier on v850 test-n-bitop asm statements
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040407090946.E99CD131D9@mcspd15>
Date: Wed,  7 Apr 2004 18:09:46 +0900 (JST)
From: miles@mcspd15.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Otherwise the compiler can delete them (this is one of those "how on
earth did it ever work before" moments).

diff -ruN -X../cludes linux-2.6.5-uc0/include/asm-v850/bitops.h linux-2.6.5-uc0-v850-20040407/include/asm-v850/bitops.h
--- linux-2.6.5-uc0/include/asm-v850/bitops.h	2003-06-16 14:53:02.000000000 +0900
+++ linux-2.6.5-uc0-v850-20040407/include/asm-v850/bitops.h	2004-04-07 18:01:49.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/bitops.h -- Bit operations
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1992  Linus Torvalds.
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -84,24 +84,26 @@
 #define change_bit __change_bit
 
 
-#define __const_tns_bit_op(op, nr, addr)				\
-  ({ int __tns_res;							\
-     __asm__ ("tst1 (%1 - 0x123), %2; setf nz, %0; " op " (%1 - 0x123), %2" \
-	      : "=&r" (__tns_res)					\
-	      : "g" (((nr) & 0x7) + 0x123),				\
-		"m" (*((char *)(addr) + ((nr) >> 3)))			\
-	      : "memory");						\
-     __tns_res;							\
+#define __const_tns_bit_op(op, nr, addr)				      \
+  ({ int __tns_res;							      \
+     __asm__ __volatile__ (						      \
+	     "tst1 (%1 - 0x123), %2; setf nz, %0; " op " (%1 - 0x123), %2"    \
+	     : "=&r" (__tns_res)					      \
+	     : "g" (((nr) & 0x7) + 0x123),				      \
+	       "m" (*((char *)(addr) + ((nr) >> 3)))			      \
+	     : "memory");						      \
+     __tns_res;								      \
   })
-#define __var_tns_bit_op(op, nr, addr)					\
-  ({ int __nr = (nr);							\
-     int __tns_res;							\
-     __asm__ ("tst1 %1, [%2]; setf nz, %0; " op " %1, [%2]"		\
-	      : "=&r" (__tns_res)					\
-	      : "r" (__nr & 0x7),					\
-		"r" ((char *)(addr) + (__nr >> 3))			\
-	      : "memory");						\
-     __tns_res;							\
+#define __var_tns_bit_op(op, nr, addr)					      \
+  ({ int __nr = (nr);							      \
+     int __tns_res;							      \
+     __asm__ __volatile__ (						      \
+	     "tst1 %1, [%2]; setf nz, %0; " op " %1, [%2]"		      \
+	      : "=&r" (__tns_res)					      \
+	      : "r" (__nr & 0x7),					      \
+		"r" ((char *)(addr) + (__nr >> 3))			      \
+	      : "memory");						      \
+     __tns_res;								      \
   })
 #define __tns_bit_op(op, nr, addr)					\
   ((__builtin_constant_p (nr) && (unsigned)(nr) <= 0x7FFFF)		\
