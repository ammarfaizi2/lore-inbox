Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUGEJeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUGEJeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUGEJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:33:54 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:50345 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265966AbUGEJdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:33:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Use __volatile__ qualifier on test_bit asm statements
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040705093210.985B4491@mctpc71>
Date: Mon,  5 Jul 2004 18:32:10 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise recent versions of gcc seem to optimize away some necessary tests.

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/bitops.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/include/asm-v850/bitops.h linux-2.6.7-uc0-v850-20040705/include/asm-v850/bitops.h
--- linux-2.6.7-uc0/include/asm-v850/bitops.h	2004-05-11 13:20:53.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040705/include/asm-v850/bitops.h	2004-07-05 18:21:33.000000000 +0900
@@ -127,20 +127,20 @@
 #define test_and_change_bit(nr, addr)	__tns_atomic_bit_op ("not1", nr, addr)
 
 
-#define __const_test_bit(nr, addr)					\
-  ({ int __test_bit_res;						\
-     __asm__ ("tst1 (%1 - 0x123), %2; setf nz, %0"			\
-	      : "=r" (__test_bit_res)					\
-	      : "g" (((nr) & 0x7) + 0x123),				\
-                "m" (*((const char *)(addr) + ((nr) >> 3))));		\
-     __test_bit_res;							\
+#define __const_test_bit(nr, addr)					      \
+  ({ int __test_bit_res;						      \
+     __asm__ __volatile__ ("tst1 (%1 - 0x123), %2; setf nz, %0"		      \
+			   : "=r" (__test_bit_res)			      \
+			   : "g" (((nr) & 0x7) + 0x123),		      \
+			     "m" (*((const char *)(addr) + ((nr) >> 3))));    \
+     __test_bit_res;							      \
   })
 extern __inline__ int __test_bit (int nr, const void *addr)
 {
 	int res;
-	__asm__ ("tst1 %1, [%2]; setf nz, %0"
-		 : "=r" (res)
-		 : "r" (nr & 0x7), "r" (addr + (nr >> 3)));
+	__asm__ __volatile__ ("tst1 %1, [%2]; setf nz, %0"
+			      : "=r" (res)
+			      : "r" (nr & 0x7), "r" (addr + (nr >> 3)));
 	return res;
 }
 #define test_bit(nr,addr)						\
