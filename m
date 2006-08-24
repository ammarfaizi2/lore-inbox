Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWHXC5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWHXC5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 22:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWHXC5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 22:57:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31051 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030223AbWHXC5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 22:57:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type;
	b=GJ/2LmTMSbKKMLtESh8m5dYmTqlSii9ILhP17bVpyt3/+Rhi86reyvBo5sVzgb+PE
	0T83KajSg9iP0mJ/Lffew==
Message-ID: <44ED157D.6050607@google.com>
Date: Wed, 23 Aug 2006 19:57:01 -0700
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix x86_64 _spin_lock_irqsave()
Content-Type: multipart/mixed;
 boundary="------------080400040006000207030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080400040006000207030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add spin_lock_string_flags and _raw_spin_lock_flags() to 
asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same 
semantics on x86_64 as it does on i386 and does *not* have interrupts 
disabled while it is waiting for the lock.

This fix is courtesy of Michael Davidson

--------------080400040006000207030504
Content-Type: text/plain;
 name="2012926.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2012926.patch"

Change 2012926 by md@md-test on 2006/01/23 18:28:12

	Add spin_lock_string_flags and _raw_spin_lock_flags() to
	asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the
	same semantics on x86_64 as it does on i386 and does *not*
	have interrupts disabled while it is waiting for the lock.
	
	PRESUBMIT=passed
	
	R=mbligh mikew
	OCL=2010261

diff -uprN linux-2.6.17/include/asm-x86_64/spinlock.h 2012926/include/asm-x86_64/spinlock.h
--- linux-2.6.17/include/asm-x86_64/spinlock.h	2006-06-17 18:49:35.000000000 -0700
+++ 2012926/include/asm-x86_64/spinlock.h	2006-07-12 16:09:50.000000000 -0700
@@ -32,6 +32,23 @@
 	"jmp 1b\n" \
 	LOCK_SECTION_END
 
+#define __raw_spin_lock_string_flags \
+	"\n1:\t" \
+	"lock ; decb %0\n\t" \
+	"js 2f\n\t" \
+	LOCK_SECTION_START("") \
+	"2:\t" \
+	"test $0x200, %1\n\t" \
+	"jz 3f\n\t" \
+	"sti\n\t" \
+	"3:\t" \
+	"rep;nop\n\t" \
+	"cmpb $0, %0\n\t" \
+	"jle 3b\n\t" \
+	"cli\n\t" \
+	"jmp 1b\n" \
+	LOCK_SECTION_END
+
 #define __raw_spin_unlock_string \
 	"movl $1,%0" \
 		:"=m" (lock->slock) : : "memory"
@@ -43,8 +60,6 @@ static inline void __raw_spin_lock(raw_s
 		:"=m" (lock->slock) : : "memory");
 }
 
-#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
-
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	int oldval;
@@ -57,6 +72,13 @@ static inline int __raw_spin_trylock(raw
 	return oldval > 0;
 }
 
+static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
+{
+	__asm__ __volatile__(
+		__raw_spin_lock_string_flags
+		:"=m" (lock->slock) : "r" (flags) : "memory");
+}
+
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(

--------------080400040006000207030504--
