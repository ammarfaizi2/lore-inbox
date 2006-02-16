Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWBPJog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWBPJog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWBPJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:44:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63439 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932521AbWBPJoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:44:15 -0500
Date: Thu, 16 Feb 2006 10:42:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 5/6] lightweight robust futexes: i386
Message-ID: <20060216094234.GF29716@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i386: add the futex_atomic_cmpxchg_inuser() assembly implementation, and
wire up the new syscalls.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Acked-by: Ulrich Drepper <drepper@redhat.com>

----

 arch/i386/kernel/syscall_table.S |    2 ++
 include/asm-i386/futex.h         |   20 +++++++++++++++++++-
 include/asm-i386/unistd.h        |    4 +++-
 3 files changed, 24 insertions(+), 2 deletions(-)

Index: linux-robust-list.q/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-robust-list.q.orig/arch/i386/kernel/syscall_table.S
+++ linux-robust-list.q/arch/i386/kernel/syscall_table.S
@@ -310,3 +310,5 @@ ENTRY(sys_call_table)
 	.long sys_pselect6
 	.long sys_ppoll
 	.long sys_unshare		/* 310 */
+	.long sys_set_robust_list
+	.long sys_get_robust_list
Index: linux-robust-list.q/include/asm-i386/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-i386/futex.h
+++ linux-robust-list.q/include/asm-i386/futex.h
@@ -107,7 +107,25 @@ futex_atomic_op_inuser (int encoded_op, 
 static inline int
 futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
 {
-	return -ENOSYS;
+	__asm__ __volatile__(
+		"1:	" LOCK_PREFIX "cmpxchgl %3, %1		\n"
+
+		"2:	.section .fixup, \"ax\"			\n"
+		"3:	mov     %2, %0				\n"
+		"	jmp     2b				\n"
+		"	.previous				\n"
+
+		"	.section __ex_table, \"a\"		\n"
+		"	.align  8				\n"
+		"	.long   1b,3b				\n"
+		"	.previous				\n"
+
+		: "=a" (oldval), "=m" (*uaddr)
+		: "i" (-EFAULT), "r" (newval), "0" (oldval)
+		: "memory"
+	);
+
+	return oldval;
 }
 
 #endif
Index: linux-robust-list.q/include/asm-i386/unistd.h
===================================================================
--- linux-robust-list.q.orig/include/asm-i386/unistd.h
+++ linux-robust-list.q/include/asm-i386/unistd.h
@@ -316,8 +316,10 @@
 #define __NR_pselect6		308
 #define __NR_ppoll		309
 #define __NR_unshare		310
+#define __NR_set_robust_list	311
+#define __NR_get_robust_list	312
 
-#define NR_syscalls 311
+#define NR_syscalls 313
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
