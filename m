Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161438AbWBUItX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161438AbWBUItX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWBUItI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:49:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28107 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161438AbWBUIsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:48:42 -0500
Date: Tue, 21 Feb 2006 09:47:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Paul Jackson <pj@sgi.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 6/6] lightweight robust futexes: x86_64
Message-ID: <20060221084710.GG5506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
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
 include/asm-x86_64/futex.h   |   23 ++++++++++++++++++++++-
 include/asm-x86_64/unistd.h  |    6 +++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S
+++ linux/arch/x86_64/ia32/ia32entry.S
@@ -688,6 +688,8 @@ ia32_sys_call_table:
 	.quad sys_ni_syscall		/* pselect6 for now */
 	.quad sys_ni_syscall		/* ppoll for now */
 	.quad sys_unshare		/* 310 */
+	.quad compat_sys_set_robust_list
+	.quad compat_sys_get_robust_list
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
Index: linux/include/asm-x86_64/futex.h
===================================================================
--- linux.orig/include/asm-x86_64/futex.h
+++ linux/include/asm-x86_64/futex.h
@@ -97,7 +97,28 @@ futex_atomic_op_inuser (int encoded_op, 
 static inline int
 futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
 {
-	return -ENOSYS;
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
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
+		"	.quad   1b,3b				\n"
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
Index: linux/include/asm-x86_64/unistd.h
===================================================================
--- linux.orig/include/asm-x86_64/unistd.h
+++ linux/include/asm-x86_64/unistd.h
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
 
