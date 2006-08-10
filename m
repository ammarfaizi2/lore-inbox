Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWHJUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWHJUGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHJUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:28 -0400
Received: from ns2.suse.de ([195.135.220.15]:57835 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932630AbWHJTgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:40 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [82/145] x86_64: Don't use lock section for mutexes and semaphores
Message-Id: <20060810193639.0BB8C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:39 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Lock sections cannot be handled by the dwarf2 unwinder.

Disadvantage is a taken branch in the hot path.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/mutex.h     |   20 ++++++--------------
 include/asm-x86_64/semaphore.h |   40 ++++++++++++++--------------------------
 include/asm-x86_64/spinlock.h  |   13 ++++++-------
 3 files changed, 26 insertions(+), 47 deletions(-)

Index: linux/include/asm-x86_64/mutex.h
===================================================================
--- linux.orig/include/asm-x86_64/mutex.h
+++ linux/include/asm-x86_64/mutex.h
@@ -25,13 +25,9 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   decl (%%rdi)	\n"			\
-			"   js 2f		\n"			\
-			"1:			\n"			\
-									\
-		LOCK_SECTION_START("")					\
-			"2: call "#fail_fn"	\n"			\
-			"   jmp 1b		\n"			\
-		LOCK_SECTION_END					\
+			"   jns 1f		\n"			\
+			"   call "#fail_fn"	\n"			\
+			"1:"						\
 									\
 		:"=D" (dummy)						\
 		: "D" (v)						\
@@ -75,13 +71,9 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   incl (%%rdi)	\n"			\
-			"   jle 2f		\n"			\
-			"1:			\n"			\
-									\
-		LOCK_SECTION_START("")					\
-			"2: call "#fail_fn"	\n"			\
-			"   jmp 1b		\n"			\
-		LOCK_SECTION_END					\
+			"   jg 1f		\n"			\
+			"   call "#fail_fn"	\n"			\
+			"1:			  "			\
 									\
 		:"=D" (dummy)						\
 		: "D" (v)						\
Index: linux/include/asm-x86_64/spinlock.h
===================================================================
--- linux.orig/include/asm-x86_64/spinlock.h
+++ linux/include/asm-x86_64/spinlock.h
@@ -20,16 +20,15 @@
 		(*(volatile signed int *)(&(x)->slock) <= 0)
 
 #define __raw_spin_lock_string \
-	"\n1:\t" \
+	"\n0:\t" \
 	"lock ; decl %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
+	"jns 2f\n" \
+	"1:\n\t"   \
 	"rep;nop\n\t" \
 	"cmpl $0,%0\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"jle 1b\n\t" \
+	"jmp 0b\n"   \
+	"2:\t"
 
 #define __raw_spin_lock_string_up \
 	"\n\tdecl %0"
Index: linux/include/asm-x86_64/semaphore.h
===================================================================
--- linux.orig/include/asm-x86_64/semaphore.h
+++ linux/include/asm-x86_64/semaphore.h
@@ -107,12 +107,9 @@ static inline void down(struct semaphore
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
 		LOCK_PREFIX "decl %0\n\t"     /* --sem->count */
-		"js 2f\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tcall __down_failed\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jns 1f\n\t"
+		"call __down_failed\n"
+		"1:"
 		:"=m" (sem->count)
 		:"D" (sem)
 		:"memory");
@@ -130,14 +127,11 @@ static inline int down_interruptible(str
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
+		"xorl %0,%0\n\t"
 		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
-		"xorl %0,%0\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_interruptible\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jns 2f\n\t"
+		"call __down_failed_interruptible\n"
+		"2:\n"
 		:"=a" (result), "=m" (sem->count)
 		:"D" (sem)
 		:"memory");
@@ -154,14 +148,11 @@ static inline int down_trylock(struct se
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
+		"xorl %0,%0\n\t"
 		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
-		"xorl %0,%0\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tcall __down_failed_trylock\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jns 2f\n\t"
+		"call __down_failed_trylock\n\t"
+		"2:\n"
 		:"=a" (result), "=m" (sem->count)
 		:"D" (sem)
 		:"memory","cc");
@@ -179,12 +170,9 @@ static inline void up(struct semaphore *
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		LOCK_PREFIX "incl %0\n\t"     /* ++sem->count */
-		"jle 2f\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tcall __up_wakeup\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jg 1f\n\t"
+		"call __up_wakeup\n"
+		"1:"
 		:"=m" (sem->count)
 		:"D" (sem)
 		:"memory");
