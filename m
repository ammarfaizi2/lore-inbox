Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUFGI7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUFGI7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFGI7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:59:07 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:19334 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264346AbUFGI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:57:28 -0400
Message-ID: <40C42E4B.15F1E605@nospam.org>
Date: Mon, 07 Jun 2004 10:58:51 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Who owns those locks ?
References: <40A1F4BE.4A298352@nospam.org> <200406031139.58964.bjorn.helgaas@hp.com>
Content-Type: multipart/mixed;
 boundary="------------E6F0CA419C6690B42C812999"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E6F0CA419C6690B42C812999
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Bjorn Helgaas wrote:
> 
> On Wednesday 12 May 2004 3:56 am, Zoltan Menyhart wrote:
> > Got a dead lock ?
> > No idea how you got there ?
> >
> > Why don't you put the ID of the owner of the lock in the lock word ?
> > Here is your patch for IA-64.
> > Doesn't cost any additional instruction, you can have it in your
> > "production" kernel, too.
> 
> Whatever happened with this patch?  I really like the idea, but
> it seems like it died on the vine.  Maybe it's time to clean it
> up, pull all the bits together, and repost it.

Here you are.
(I'm still playing with 2.6.5)

Zoltán Menyhárt
--------------E6F0CA419C6690B42C812999
Content-Type: text/plain; charset=us-ascii;
 name="l"
Content-Disposition: inline;
 filename="l"
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
--- 2.6.5.ref/arch/ia64/kernel/head.S	Wed Apr 21 16:18:26 2004
+++ 2.6.5.new/arch/ia64/kernel/head.S	Wed May 12 16:31:33 2004
@@ -917,7 +917,8 @@
 	ld4 r30=[r31]		// don't use ld4.bias; if it's contended, we won't write the word
 	;;
 	cmp4.ne p14,p0=r30,r0
-	mov r30 = 1
+//	mov r30 = 1
+	shr.u r30 = r13, 12	// Current task pointer
 (p14)	br.cond.sptk.few .wait
 	;;
 	cmpxchg4.acq r30=[r31], r30, ar.ccv

--------------E6F0CA419C6690B42C812999--

