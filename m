Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWISLTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWISLTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 07:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWISLTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 07:19:40 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61834 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751900AbWISLTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 07:19:38 -0400
Date: Tue, 19 Sep 2006 13:19:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mingo@elte.hu, paulus@samba.org
Subject: [patch 1/3] Directed yield: cpu_relax variants for spinlocks and rw-locks.
Message-ID: <20060919111934.GC21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 1/3] Directed yield: cpu_relax variants for spinlocks and rw-locks.

On systems running with virtual cpus there is optimization potential
in regard to spinlocks and rw-locks. If the virtual cpu that has taken
a lock is known to a cpu that wants to acquire the same lock it is 
beneficial to yield the timeslice of the virtual cpu in favour of
the cpu that has the lock (directed yield).

With CONFIG_PREEMPT="n" this can be implemented by the architecture
without common code changes. Powerpc already does this.

With CONFIG_PREEMPT="y" the lock loops are coded with _raw_spin_trylock,
_raw_read_trylock and _raw_write_trylock in kernel/spinlock.c. If the
lock could not be taken cpu_relax is called. A directed yield is not
possible because cpu_relax doesn't know anything about the lock.
To be able to yield the lock in favour of the current lock holder
variants of cpu_relax for spinlocks and rw-locks are needed. The new
_raw_spin_relax, _raw_read_relax and _raw_write_relax primitives differ
from cpu_relax insofar that they have an argument: a pointer to the lock
structure.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-alpha/spinlock.h         |    4 ++++
 include/asm-arm/spinlock.h           |    4 ++++
 include/asm-cris/arch-v32/spinlock.h |    4 ++++
 include/asm-i386/spinlock.h          |    4 ++++
 include/asm-ia64/spinlock.h          |    4 ++++
 include/asm-m32r/spinlock.h          |    4 ++++
 include/asm-mips/spinlock.h          |    4 ++++
 include/asm-parisc/spinlock.h        |    4 ++++
 include/asm-powerpc/spinlock.h       |    4 ++++
 include/asm-ppc/spinlock.h           |    4 ++++
 include/asm-s390/spinlock.h          |    4 ++++
 include/asm-sh/spinlock.h            |    4 ++++
 include/asm-sparc/spinlock.h         |    4 ++++
 include/asm-sparc64/spinlock.h       |    4 ++++
 include/asm-x86_64/spinlock.h        |    4 ++++
 kernel/spinlock.c                    |    4 ++--
 16 files changed, 62 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-alpha/spinlock.h linux-2.6-patched/include/asm-alpha/spinlock.h
--- linux-2.6/include/asm-alpha/spinlock.h	2006-09-19 12:58:36.000000000 +0200
+++ linux-2.6-patched/include/asm-alpha/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -166,4 +166,8 @@ static inline void __raw_write_unlock(ra
 	lock->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* _ALPHA_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-arm/spinlock.h linux-2.6-patched/include/asm-arm/spinlock.h
--- linux-2.6/include/asm-arm/spinlock.h	2006-09-19 12:58:36.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -218,4 +218,8 @@ static inline int __raw_read_trylock(raw
 /* read_can_lock - would read_trylock() succeed? */
 #define __raw_read_can_lock(x)		((x)->lock < 0x80000000)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-cris/arch-v32/spinlock.h linux-2.6-patched/include/asm-cris/arch-v32/spinlock.h
--- linux-2.6/include/asm-cris/arch-v32/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-cris/arch-v32/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -160,4 +160,8 @@ static __inline__ int is_write_locked(rw
 	return rw->counter < 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_ARCH_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-i386/spinlock.h linux-2.6-patched/include/asm-i386/spinlock.h
--- linux-2.6/include/asm-i386/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -199,4 +199,8 @@ static inline void __raw_write_unlock(ra
 				 : "+m" (rw->lock) : : "memory");
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-ia64/spinlock.h linux-2.6-patched/include/asm-ia64/spinlock.h
--- linux-2.6/include/asm-ia64/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-ia64/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -213,4 +213,8 @@ static inline int __raw_read_trylock(raw
 	return (u32)ia64_cmpxchg4_acq((__u32 *)(x), new.word, old.word) == old.word;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /*  _ASM_IA64_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-m32r/spinlock.h linux-2.6-patched/include/asm-m32r/spinlock.h
--- linux-2.6/include/asm-m32r/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-m32r/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -309,4 +309,8 @@ static inline int __raw_write_trylock(ra
 	return 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif	/* _ASM_M32R_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-mips/spinlock.h linux-2.6-patched/include/asm-mips/spinlock.h
--- linux-2.6/include/asm-mips/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-mips/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -283,4 +283,8 @@ static inline int __raw_write_trylock(ra
 	return ret;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* _ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-parisc/spinlock.h linux-2.6-patched/include/asm-parisc/spinlock.h
--- linux-2.6/include/asm-parisc/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-parisc/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -152,4 +152,8 @@ static __inline__ int __raw_write_can_lo
 	return !rw->counter;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-powerpc/spinlock.h linux-2.6-patched/include/asm-powerpc/spinlock.h
--- linux-2.6/include/asm-powerpc/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -285,5 +285,9 @@ static __inline__ void __raw_write_unloc
 	rw->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-ppc/spinlock.h linux-2.6-patched/include/asm-ppc/spinlock.h
--- linux-2.6/include/asm-ppc/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-ppc/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -161,4 +161,8 @@ static __inline__ void __raw_write_unloc
 	rw->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -135,4 +135,8 @@ static inline int __raw_write_trylock(ra
 	return _raw_write_trylock_retry(rw);
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-sh/spinlock.h linux-2.6-patched/include/asm-sh/spinlock.h
--- linux-2.6/include/asm-sh/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-sh/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -100,4 +100,8 @@ static inline int __raw_write_trylock(ra
 	return 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SH_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-sparc/spinlock.h linux-2.6-patched/include/asm-sparc/spinlock.h
--- linux-2.6/include/asm-sparc/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -154,6 +154,10 @@ static inline int __raw_write_trylock(ra
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 #define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #define __raw_read_can_lock(rw) (!((rw)->lock & 0xff))
 #define __raw_write_can_lock(rw) (!(rw)->lock)
 
diff -urpN linux-2.6/include/asm-sparc64/spinlock.h linux-2.6-patched/include/asm-sparc64/spinlock.h
--- linux-2.6/include/asm-sparc64/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -241,6 +241,10 @@ static int inline __write_trylock(raw_rw
 #define __raw_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define __raw_write_can_lock(rw)	(!(rw)->lock)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_SPINLOCK_H) */
diff -urpN linux-2.6/include/asm-x86_64/spinlock.h linux-2.6-patched/include/asm-x86_64/spinlock.h
--- linux-2.6/include/asm-x86_64/spinlock.h	2006-09-19 12:58:37.000000000 +0200
+++ linux-2.6-patched/include/asm-x86_64/spinlock.h	2006-09-19 12:59:34.000000000 +0200
@@ -131,4 +131,8 @@ static inline void __raw_write_unlock(ra
 				: "=m" (rw->lock) : : "memory");
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/kernel/spinlock.c linux-2.6-patched/kernel/spinlock.c
--- linux-2.6/kernel/spinlock.c	2006-09-19 12:58:38.000000000 +0200
+++ linux-2.6-patched/kernel/spinlock.c	2006-09-19 12:59:34.000000000 +0200
@@ -221,7 +221,7 @@ void __lockfunc _##op##_lock(locktype##_
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			_raw_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
 }									\
@@ -243,7 +243,7 @@ unsigned long __lockfunc _##op##_lock_ir
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			_raw_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
 	return flags;							\
