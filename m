Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUELJzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUELJzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUELJzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 05:55:13 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:47296 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264935AbUELJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 05:54:54 -0400
Message-ID: <40A1F4BE.4A298352@nospam.org>
Date: Wed, 12 May 2004 11:56:14 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Who owns those locks ?
Content-Type: multipart/mixed;
 boundary="------------F7628325D18A2B7959674E09"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F7628325D18A2B7959674E09
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Got a dead lock ?
No idea how you got there ?

Why don't you put the ID of the owner of the lock in the lock word ?
Here is your patch for IA-64.
Doesn't cost any additional instruction, you can have it in your
"production" kernel, too.

The current task pointers are identity mapped memory addresses.
I shift them to the right by 12 bits (these bits are always 0-s).
In that way, addresses up to 16 Tbytes can fit into the lock word.

Interrupt handlers use the current task pointers as IDs, too.
An interrupt handler has to free all the locks it has taken,
therefore using the same ID as the task pre-empted uses, is not
confusing. Locks which are taken with / without interrupt disabling
form two distinct sets.
If you are back into the pre-empted task and should there is a
"left over" lock with the ID of the task => you've got a hint ;-)

In debug mode, you can check if the lock is yours before setting it free:

#define spin_is_mine(x)	((x)->lock == (__u32)((__u64) current >> 12))

Good luck.


Zoltán Menyhárt
--------------F7628325D18A2B7959674E09
Content-Type: text/plain; charset=us-ascii;
 name="n475"
Content-Disposition: inline;
 filename="n475"
Content-Transfer-Encoding: 7bit

--- 2.6.5.ref/include/asm-ia64/spinlock.h	Sun Apr  4 05:36:17 2004
+++ 2.6.5.new/include/asm-ia64/spinlock.h	Wed May 12 10:29:38 2004
@@ -45,7 +45,8 @@
 	asm volatile ("{\n\t"
 		      "  mov ar.ccv = r0\n\t"
 		      "  mov r28 = ip\n\t"
-		      "  mov r30 = 1;;\n\t"
+		      /* "  mov r30 = 1;;\n\t" */
+		      "  shr.u r30 = r13, 12;;\n\t"	/* Current task pointer */
 		      "}\n\t"
 		      "cmpxchg4.acq r30 = [%1], r30, ar.ccv\n\t"
 		      "movl r29 = ia64_spinlock_contention_pre3_4;;\n\t"
@@ -57,7 +58,8 @@
 	asm volatile ("{\n\t"
 		      "  mov ar.ccv = r0\n\t"
 		      "  mov r28 = ip\n\t"
-		      "  mov r30 = 1;;\n\t"
+		      /* "  mov r30 = 1;;\n\t" */
+		      "  shr.u r30 = r13, 12;;\n\t"	/* Current task pointer */
 		      "}\n\t"
 		      "cmpxchg4.acq r30 = [%1], r30, ar.ccv;;\n\t"
 		      "cmp4.ne p14, p0 = r30, r0\n"
@@ -68,7 +70,8 @@
 # ifdef CONFIG_ITANIUM
 	/* don't use brl on Itanium... */
 	/* mis-declare, so we get the entry-point, not it's function descriptor: */
-	asm volatile ("mov r30 = 1\n\t"
+	asm volatile (/* "  mov r30 = 1;;\n\t" */
+		      "  shr.u r30 = r13, 12;;\n\t"	/* Current task pointer */
 		      "mov ar.ccv = r0;;\n\t"
 		      "cmpxchg4.acq r30 = [%0], r30, ar.ccv\n\t"
 		      "movl r29 = ia64_spinlock_contention;;\n\t"
@@ -77,7 +80,8 @@
 		      "(p14) br.call.spnt.many b6 = b6"
 		      : "=r"(ptr) : "r"(ptr) : IA64_SPINLOCK_CLOBBERS);
 # else
-	asm volatile ("mov r30 = 1\n\t"
+	asm volatile (/* "  mov r30 = 1;;\n\t" */
+		      "  shr.u r30 = r13, 12;;\n\t"	/* Current task pointer */
 		      "mov ar.ccv = r0;;\n\t"
 		      "cmpxchg4.acq r30 = [%0], r30, ar.ccv;;\n\t"
 		      "cmp4.ne p14, p0 = r30, r0\n\t"
@@ -89,14 +93,17 @@
 #else /* !ASM_SUPPORTED */
 # define _raw_spin_lock(x)								\
 do {											\
-	__u32 *ia64_spinlock_ptr = (__u32 *) (x);					\
-	__u64 ia64_spinlock_val;							\
-	ia64_spinlock_val = ia64_cmpxchg4_acq(ia64_spinlock_ptr, 1, 0);			\
+	__u32	*ia64_spinlock_ptr = (__u32 *) (x);					\
+	__u64	ia64_spinlock_val;							\
+	__u32	new_spinlock_val = (__u32)((__u64) current >> 12);			\
+											\
+	ia64_spinlock_val = ia64_cmpxchg4_acq(ia64_spinlock_ptr, new_spinlock_val, 0);	\
 	if (unlikely(ia64_spinlock_val)) {						\
 		do {									\
 			while (*ia64_spinlock_ptr)					\
 				ia64_barrier();						\
-			ia64_spinlock_val = ia64_cmpxchg4_acq(ia64_spinlock_ptr, 1, 0);	\
+			ia64_spinlock_val = ia64_cmpxchg4_acq(ia64_spinlock_ptr,	\
+								new_spinlock_val, 0);	\
 		} while (ia64_spinlock_val);						\
 	}										\
 } while (0)


--------------F7628325D18A2B7959674E09--

