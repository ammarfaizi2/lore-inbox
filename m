Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWDTRYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWDTRYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWDTRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:24:14 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:63161 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751177AbWDTRYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:24:13 -0400
Date: Thu, 20 Apr 2006 10:24:06 -0700 (PDT)
From: Nickolai Zeldovich <nickolai@cs.stanford.edu>
To: linux-kernel@vger.kernel.org
cc: nickolai@cs.stanford.edu
Subject: [PATCH] specify cc in asm clobber list
Message-ID: <Pine.GSO.4.44.0604201014480.27468-100000@elaine15.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the inline assembly instructions used in the Linux kernel source
modify the condition codes in %rflags/%eflags.  However, almost none of
them specify "cc" in their clobber list (although a few erroneously
specify "memory" where none is needed -- perhaps as a workaround for some
problems that came up because "cc" was not there?).  I'm not sure whether
any actual problems arise from this now, but it seems prudent to specify
"cc" where %rflags is modified, to avoid problems with gcc optimizations
in the future.

The patch below adds "cc" in the asm clobber list for the inline assembly
in include/asm-x86_64/atomic.h, and removes some "memory" clobber entries
where no unspecified memory is actually clobbered.  Many more instances of
this remain in both x86_64 and i386 code.

-- kolya

--- linux-2.6.16.9/include/asm-x86_64/atomic.h	2006/04/20 16:49:15	1.1
+++ linux-2.6.16.9/include/asm-x86_64/atomic.h	2006/04/20 17:12:17
@@ -55,7 +55,8 @@
 	__asm__ __volatile__(
 		LOCK "addl %1,%0"
 		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 }

 /**
@@ -70,7 +71,8 @@
 	__asm__ __volatile__(
 		LOCK "subl %1,%0"
 		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 }

 /**
@@ -89,7 +91,8 @@
 	__asm__ __volatile__(
 		LOCK "subl %2,%0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 	return c;
 }

@@ -104,7 +107,8 @@
 	__asm__ __volatile__(
 		LOCK "incl %0"
 		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"m" (v->counter)
+		:"cc");
 }

 /**
@@ -118,7 +122,8 @@
 	__asm__ __volatile__(
 		LOCK "decl %0"
 		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"m" (v->counter)
+		:"cc");
 }

 /**
@@ -136,7 +141,8 @@
 	__asm__ __volatile__(
 		LOCK "decl %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"m" (v->counter)
+		:"cc");
 	return c != 0;
 }

@@ -155,7 +161,8 @@
 	__asm__ __volatile__(
 		LOCK "incl %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"m" (v->counter)
+		:"cc");
 	return c != 0;
 }

@@ -175,7 +182,8 @@
 	__asm__ __volatile__(
 		LOCK "addl %2,%0; sets %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 	return c;
 }

@@ -191,8 +199,9 @@
 	int __i = i;
 	__asm__ __volatile__(
 		LOCK "xaddl %0, %1;"
-		:"=r"(i)
-		:"m"(v->counter), "0"(i));
+		:"=r"(i), "=m"(v->counter)
+		:"m"(v->counter), "0"(i)
+		:"cc");
 	return i + __i;
 }

@@ -240,7 +249,8 @@
 	__asm__ __volatile__(
 		LOCK "addq %1,%0"
 		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 }

 /**
@@ -255,7 +265,8 @@
 	__asm__ __volatile__(
 		LOCK "subq %1,%0"
 		:"=m" (v->counter)
-		:"ir" (i), "m" (v->counter));
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 }

 /**
@@ -274,7 +285,8 @@
 	__asm__ __volatile__(
 		LOCK "subq %2,%0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 	return c;
 }

@@ -289,7 +301,8 @@
 	__asm__ __volatile__(
 		LOCK "incq %0"
 		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"m" (v->counter)
+		:"cc");
 }

 /**
@@ -303,7 +316,8 @@
 	__asm__ __volatile__(
 		LOCK "decq %0"
 		:"=m" (v->counter)
-		:"m" (v->counter));
+		:"m" (v->counter)
+		:"cc");
 }

 /**
@@ -321,7 +335,8 @@
 	__asm__ __volatile__(
 		LOCK "decq %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"m" (v->counter)
+		:"cc");
 	return c != 0;
 }

@@ -340,7 +355,8 @@
 	__asm__ __volatile__(
 		LOCK "incq %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"m" (v->counter) : "memory");
+		:"m" (v->counter)
+		:"cc");
 	return c != 0;
 }

@@ -360,7 +376,8 @@
 	__asm__ __volatile__(
 		LOCK "addq %2,%0; sets %1"
 		:"=m" (v->counter), "=qm" (c)
-		:"ir" (i), "m" (v->counter) : "memory");
+		:"ir" (i), "m" (v->counter)
+		:"cc");
 	return c;
 }

@@ -377,7 +394,8 @@
 	__asm__ __volatile__(
 		LOCK "xaddq %0, %1;"
 		:"=r"(i)
-		:"m"(v->counter), "0"(i));
+		:"m"(v->counter), "0"(i)
+		:"cc");
 	return i + __i;
 }

@@ -413,12 +431,12 @@

 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
-__asm__ __volatile__(LOCK "andl %0,%1" \
-: : "r" (~(mask)),"m" (*addr) : "memory")
+__asm__ __volatile__(LOCK "andl %1,%0" \
+: "=m" (*(addr)) : "r" (~(mask)), "m" (*(addr)) : "cc")

 #define atomic_set_mask(mask, addr) \
-__asm__ __volatile__(LOCK "orl %0,%1" \
-: : "r" ((unsigned)mask),"m" (*(addr)) : "memory")
+__asm__ __volatile__(LOCK "orl %1,%0" \
+: "=m" (*(addr)) : "r" ((unsigned)mask), "m" (*(addr)) : "cc")

 /* Atomic operations are already serializing on x86 */
 #define smp_mb__before_atomic_dec()	barrier()

