Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUELLZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUELLZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbUELLZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:25:50 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:5318 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264928AbUELLZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:25:42 -0400
Message-ID: <40A20A08.9EAAD8E@nospam.org>
Date: Wed, 12 May 2004 13:27:04 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Who owns those locks ? (2)
Content-Type: multipart/mixed;
 boundary="------------0866B09AA21AF112BB5F74E4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0866B09AA21AF112BB5F74E4
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have forgotten the function "_raw_spin_trylock()" :-(

Zoltán
--------------0866B09AA21AF112BB5F74E4
Content-Type: text/plain; charset=us-ascii;
 name="n475"
Content-Disposition: inline;
 filename="n475"
Content-Transfer-Encoding: 7bit

--- 2.6.5.ref/include/asm-ia64/spinlock.h	Sun Apr  4 05:36:17 2004
+++ 2.6.5.new/include/asm-ia64/spinlock.h	Wed May 12 13:17:50 2004
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
@@ -104,7 +111,7 @@
 
 #define spin_is_locked(x)	((x)->lock != 0)
 #define _raw_spin_unlock(x)	do { barrier(); ((spinlock_t *) x)->lock = 0; } while (0)
-#define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
+#define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, (__u32)((__u64) current >> 12)) == 0)
 #define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
 typedef struct {

--------------0866B09AA21AF112BB5F74E4--

