Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945980AbWBOPT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbWBOPT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945978AbWBOPTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:19:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26060 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945974AbWBOPTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:19:37 -0500
Date: Wed, 15 Feb 2006 16:17:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 4/5] lightweight robust futexes: i386
Message-ID: <20060215151753.GE31569@elte.hu>
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
 include/asm-i386/futex.h         |   24 ++++++++++++++++++++++++
 include/asm-i386/unistd.h        |    4 +++-
 3 files changed, 29 insertions(+), 1 deletion(-)

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
@@ -104,5 +104,29 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
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
+		"	.long	1b,3b				\n"
+		"	.previous				\n"
+
+	     : "=&a" (oldval), "=&r" (newval), "=m" (*uaddr)
+	     : "i" (-EFAULT)
+	     : "memory"
+	);
+
+	return oldval;
+}
+
 #endif
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
