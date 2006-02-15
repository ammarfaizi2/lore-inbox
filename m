Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWBOW7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWBOW7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBOW7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:59:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65260 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932453AbWBOW6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:58:50 -0500
Date: Wed, 15 Feb 2006 23:57:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 4/5] lightweight robust futexes: i386
Message-ID: <20060215225709.GE5599@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
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
+		"1:	" LOCK_PREFIX "cmpxchgl %1, %2		\n"
+
+		"2:	.section .fixup, \"ax\"			\n"
+		"3:	mov	%3, %0				\n"
+		"	jmp	2b				\n"
+		"	.previous				\n"
+
+		"	.section __ex_table, \"a\"		\n"
+		"	.align	8				\n"
+		"	.long	1b,3b				\n"
+		"	.previous				\n"
+
+	     : "=&a" (oldval), "=&r" (newval), "=m" (*uaddr)
+	     : "i" (-EFAULT)
+	     : "memory"
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
