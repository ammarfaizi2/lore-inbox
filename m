Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945974AbWBOPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbWBOPT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945975AbWBOPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:19:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28876 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945978AbWBOPTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:19:45 -0500
Date: Wed, 15 Feb 2006 16:18:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 5/5] lightweight robust futexes: x86_64
Message-ID: <20060215151801.GF31569@elte.hu>
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


x86_64: add the futex_atomic_cmpxchg_inuser() assembly implementation, and
wire up the new syscalls.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Acked-by: Ulrich Drepper <drepper@redhat.com>

----

 arch/x86_64/ia32/ia32entry.S |    2 ++
 include/asm-x86_64/futex.h   |   24 ++++++++++++++++++++++++
 include/asm-x86_64/unistd.h  |    6 +++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

Index: linux-robust-list.q/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux-robust-list.q.orig/arch/x86_64/ia32/ia32entry.S
+++ linux-robust-list.q/arch/x86_64/ia32/ia32entry.S
@@ -688,6 +688,8 @@ ia32_sys_call_table:
 	.quad sys_ni_syscall		/* pselect6 for now */
 	.quad sys_ni_syscall		/* ppoll for now */
 	.quad sys_unshare		/* 310 */
+	.quad compat_sys_set_robust_list
+	.quad compat_sys_get_robust_list
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
Index: linux-robust-list.q/include/asm-x86_64/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-x86_64/futex.h
+++ linux-robust-list.q/include/asm-x86_64/futex.h
@@ -94,5 +94,29 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
+
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
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
+		"	.quad	1b,3b				\n"
+		"	.previous				\n"
+
+	     : "=&a" (oldval), "=&r" (newval), "=m" (*uaddr)
+	     : "i" (-EFAULT)
+	     : "memory"
+	);
+
+	return oldval;
+}
 #endif
 #endif
Index: linux-robust-list.q/include/asm-x86_64/unistd.h
===================================================================
--- linux-robust-list.q.orig/include/asm-x86_64/unistd.h
+++ linux-robust-list.q/include/asm-x86_64/unistd.h
@@ -605,8 +605,12 @@ __SYSCALL(__NR_pselect6, sys_ni_syscall)
 __SYSCALL(__NR_ppoll,	sys_ni_syscall)		/* for now */
 #define __NR_unshare		272
 __SYSCALL(__NR_unshare,	sys_unshare)
+#define __NR_set_robust_list	273
+__SYSCALL(__NR_set_robust_list, sys_set_robust_list)
+#define __NR_get_robust_list	274
+__SYSCALL(__NR_get_robust_list, sys_get_robust_list)
 
-#define __NR_syscall_max __NR_unshare
+#define __NR_syscall_max __NR_get_robust_list
 
 #ifndef __NO_STUBS
 
