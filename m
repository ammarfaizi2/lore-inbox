Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWB0WA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWB0WA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0WA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:00:59 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:39892 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932347AbWB0WA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:00:58 -0500
Date: Mon, 27 Feb 2006 16:57:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: make bitops safe
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Message-ID: <200602271700_MC3-1-B969-F4A5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make i386 bitops safe.  Currently they can be fooled, even on
uniprocessor, by code that uses regions of the bitmap before
invoking the bitop.  The least costly way to make them safe
is to add a memory clobber and tag all of them as volatile.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 include/asm-i386/bitops.h |   56 ++++++++++++++++++++++++++++++----------------
 1 files changed, 37 insertions(+), 19 deletions(-)

--- 2.6.16-rc4-32b.orig/include/asm-i386/bitops.h
+++ 2.6.16-rc4-32b/include/asm-i386/bitops.h
@@ -44,7 +44,8 @@ static inline void set_bit(int nr, volat
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 
 /**
@@ -58,10 +59,11 @@ static inline void set_bit(int nr, volat
  */
 static inline void __set_bit(int nr, volatile unsigned long * addr)
 {
-	__asm__(
+	__asm__ __volatile__(
 		"btsl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 
 /**
@@ -79,7 +81,8 @@ static inline void clear_bit(int nr, vol
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 
 static inline void __clear_bit(int nr, volatile unsigned long * addr)
@@ -87,7 +90,8 @@ static inline void __clear_bit(int nr, v
 	__asm__ __volatile__(
 		"btrl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
@@ -106,7 +110,8 @@ static inline void __change_bit(int nr, 
 	__asm__ __volatile__(
 		"btcl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 
 /**
@@ -124,7 +129,8 @@ static inline void change_bit(int nr, vo
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
 		:"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 }
 
 /**
@@ -143,7 +149,8 @@ static inline int test_and_set_bit(int n
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -160,10 +167,11 @@ static inline int __test_and_set_bit(int
 {
 	int oldbit;
 
-	__asm__(
+	__asm__ __volatile__(
 		"btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -183,7 +191,8 @@ static inline int test_and_clear_bit(int
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -200,10 +209,11 @@ static inline int __test_and_clear_bit(i
 {
 	int oldbit;
 
-	__asm__(
+	__asm__ __volatile__(
 		"btrl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -215,7 +225,8 @@ static inline int __test_and_change_bit(
 	__asm__ __volatile__(
 		"btcl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -234,7 +245,8 @@ static inline int test_and_change_bit(in
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"+m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -259,7 +271,8 @@ static inline int variable_test_bit(int 
 	__asm__ __volatile__(
 		"btl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit)
-		:"m" (ADDR),"Ir" (nr));
+		:"m" (ADDR),"Ir" (nr)
+		:"memory");
 	return oldbit;
 }
 
@@ -298,7 +311,8 @@ static inline int find_first_zero_bit(co
 		"shll $3,%%edi\n\t"
 		"addl %%edi,%%edx"
 		:"=d" (res), "=&c" (d0), "=&D" (d1), "=&a" (d2)
-		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr) : "memory");
+		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr)
+		:"memory");
 	return res;
 }
 
@@ -405,7 +419,9 @@ static inline int ffs(int x)
 	__asm__("bsfl %1,%0\n\t"
 		"jnz 1f\n\t"
 		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "rm" (x));
+		"1:"
+		: "=r" (r)
+		: "rm" (x));
 	return r+1;
 }
 
@@ -422,7 +438,9 @@ static inline int fls(int x)
 	__asm__("bsrl %1,%0\n\t"
 		"jnz 1f\n\t"
 		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "rm" (x));
+		"1:"
+		: "=r" (r)
+		: "rm" (x));
 	return r+1;
 }
 
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
