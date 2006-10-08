Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWJHNcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWJHNcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWJHNcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:32:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25783 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751142AbWJHNcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:32:17 -0400
Date: Sun, 8 Oct 2006 14:32:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32 rwlock fix
Message-ID: <20061008133215.GL29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        read_trylock() is broken on sparc32 (doesn't build and didn't
work right, actually).  Proposed fix:
        * make "writer holds lock" distinguishable from "reader tries
to grab lock"
        * have __raw_read_trylock() try to acquire the mutex (in LSB
of lock), terminating spin if we see that there's writer holding it.
Then do the rest as we do in read_lock().

Thanks to Ingo for discussion...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/sparc_ksyms.c |    4 +++-
 arch/sparc/lib/locks.S          |   20 ++++++++++++++++++++
 include/asm-sparc/spinlock.h    |   28 +++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 4d441a5..33dadd9 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -87,6 +87,7 @@ extern void ___set_bit(void);
 extern void ___clear_bit(void);
 extern void ___change_bit(void);
 extern void ___rw_read_enter(void);
+extern void ___rw_read_try(void);
 extern void ___rw_read_exit(void);
 extern void ___rw_write_enter(void);
 
@@ -104,8 +105,9 @@ extern unsigned _Urem(unsigned, unsigned
 EXPORT_SYMBOL(sparc_cpu_model);
 EXPORT_SYMBOL(kernel_thread);
 #ifdef CONFIG_SMP
-// XXX find what uses (or used) these.
+// XXX find what uses (or used) these.   AV: see asm/spinlock.h
 EXPORT_SYMBOL(___rw_read_enter);
+EXPORT_SYMBOL(___rw_read_try);
 EXPORT_SYMBOL(___rw_read_exit);
 EXPORT_SYMBOL(___rw_write_enter);
 #endif
diff --git a/arch/sparc/lib/locks.S b/arch/sparc/lib/locks.S
index 95fa484..b1df55c 100644
--- a/arch/sparc/lib/locks.S
+++ b/arch/sparc/lib/locks.S
@@ -25,6 +25,15 @@ ___rw_read_enter_spin_on_wlock:
 	 ldstub	[%g1 + 3], %g2
 	b	___rw_read_enter_spin_on_wlock
 	 ldub	[%g1 + 3], %g2
+___rw_read_try_spin_on_wlock:
+	andcc	%g2, 0xff, %g0
+	be,a	___rw_read_try
+	 ldstub	[%g1 + 3], %g2
+	xnorcc	%g2, 0x0, %o0	/* if g2 is ~0, set o0 to 0 and bugger off */
+	bne,a	___rw_read_enter_spin_on_wlock
+	 ld	[%g1], %g2
+	retl
+	 mov	%g4, %o7
 ___rw_read_exit_spin_on_wlock:
 	orcc	%g2, 0x0, %g0
 	be,a	___rw_read_exit
@@ -60,6 +69,17 @@ ___rw_read_exit:
 	retl
 	 mov	%g4, %o7
 
+	.globl	___rw_read_try
+___rw_read_try:
+	orcc	%g2, 0x0, %g0
+	bne	___rw_read_try_spin_on_wlock
+	 ld	[%g1], %g2
+	add	%g2, 1, %g2
+	st	%g2, [%g1]
+	set	1, %o1
+	retl
+	 mov	%g4, %o7
+
 	.globl	___rw_write_enter
 ___rw_write_enter:
 	orcc	%g2, 0x0, %g0
diff --git a/include/asm-sparc/spinlock.h b/include/asm-sparc/spinlock.h
index 557d089..de2249b 100644
--- a/include/asm-sparc/spinlock.h
+++ b/include/asm-sparc/spinlock.h
@@ -129,6 +129,7 @@ static inline void __raw_write_lock(raw_
 	: /* no outputs */
 	: "r" (lp)
 	: "g2", "g4", "memory", "cc");
+	*(volatile __u32 *)&lp->lock = ~0U;
 }
 
 static inline int __raw_write_trylock(raw_rwlock_t *rw)
@@ -144,15 +145,40 @@ static inline int __raw_write_trylock(ra
 		val = rw->lock & ~0xff;
 		if (val)
 			((volatile u8*)&rw->lock)[3] = 0;
+		else
+			*(volatile u32*)&rw->lock = ~0U;
 	}
 
 	return (val == 0);
 }
 
+static inline int __read_trylock(raw_rwlock_t *rw)
+{
+	register raw_rwlock_t *lp asm("g1");
+	register int res asm("o0");
+	lp = rw;
+	__asm__ __volatile__(
+	"mov	%%o7, %%g4\n\t"
+	"call	___rw_read_try\n\t"
+	" ldstub	[%%g1 + 3], %%g2\n"
+	: "=r" (res)
+	: "r" (lp)
+	: "g2", "g4", "memory", "cc");
+	return res;
+}
+
+#define __raw_read_trylock(lock) \
+({	unsigned long flags; \
+	int res; \
+	local_irq_save(flags); \
+	res = __read_trylock(lock); \
+	local_irq_restore(flags); \
+	res; \
+})
+
 #define __raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
-#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 #define _raw_spin_relax(lock)	cpu_relax()
 #define _raw_read_relax(lock)	cpu_relax()
-- 
1.4.2.GIT

