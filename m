Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVJKPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJKPde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVJKPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:33:34 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:15515 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751417AbVJKPdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:33:33 -0400
Message-ID: <434BDB1C.60105@cosmosbay.com>
Date: Tue, 11 Oct 2005 17:32:44 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Kirill Korotaev <dev@sw.ru>
Subject: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com> <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020609020507020807000201"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 11 Oct 2005 17:32:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609020507020807000201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As NR_CPUS might be > 128, and every spining CPU decrements the lock, we need 
to use more than 8 bits for a spinlock. The current (i386/x86_64) 
implementations have a (theorical) bug in this area.
As the allocated space for spinlock_t is 32 bits, let's use full 32 bits and 
let the CPUS fight :)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------020609020507020807000201
Content-Type: text/plain;
 name="i386_spinlock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_spinlock"

--- linux-2.6.14-rc4/include/asm-i386/spinlock.h	2005-10-11 03:19:19.000000000 +0200
+++ linux-2.6.14-rc4-ed/include/asm-i386/spinlock.h	2005-10-11 19:19:27.000000000 +0200
@@ -18,23 +18,24 @@
  * (the type definitions are in asm/spinlock_types.h)
  */
 
+
 #define __raw_spin_is_locked(x) \
-		(*(volatile signed char *)(&(x)->slock) <= 0)
+		(*(volatile int *)(&(x)->slock) <= 0)
 
 #define __raw_spin_lock_string \
 	"\n1:\t" \
-	"lock ; decb %0\n\t" \
+	"lock ; decl %0\n\t" \
 	"jns 3f\n" \
 	"2:\t" \
 	"rep;nop\n\t" \
-	"cmpb $0,%0\n\t" \
+	"cmpl $0,%0\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
 	"3:\n\t"
 
 #define __raw_spin_lock_string_flags \
 	"\n1:\t" \
-	"lock ; decb %0\n\t" \
+	"lock ; decl %0\n\t" \
 	"jns 4f\n\t" \
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
@@ -42,7 +43,7 @@
 	"sti\n\t" \
 	"3:\t" \
 	"rep;nop\n\t" \
-	"cmpb $0, %0\n\t" \
+	"cmpl $0, %0\n\t" \
 	"jle 3b\n\t" \
 	"cli\n\t" \
 	"jmp 1b\n" \
@@ -64,9 +65,10 @@
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
-	char oldval;
+	int oldval;
+	BUILD_BUG_ON(sizeof(lock->slock) != sizeof(oldval));
 	__asm__ __volatile__(
-		"xchgb %b0,%1"
+		"xchgl %0,%1"
 		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
 	return oldval > 0;
@@ -75,14 +77,14 @@
 /*
  * __raw_spin_unlock based on writing $1 to the low byte.
  * This method works. Despite all the confusion.
- * (except on PPro SMP or if we are using OOSTORE, so we use xchgb there)
+ * (except on PPro SMP or if we are using OOSTORE, so we use xchgl there)
  * (PPro errata 66, 92)
  */
 
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
 
 #define __raw_spin_unlock_string \
-	"movb $1,%0" \
+	"movl $1,%0" \
 		:"=m" (lock->slock) : : "memory"
 
 
@@ -96,13 +98,13 @@
 #else
 
 #define __raw_spin_unlock_string \
-	"xchgb %b0, %1" \
+	"xchgl %0, %1" \
 		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	char oldval = 1;
+	int oldval = 1;
 
 	__asm__ __volatile__(
 		__raw_spin_unlock_string

--------------020609020507020807000201--
