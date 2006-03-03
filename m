Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWCCWCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWCCWCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWCCWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:02:12 -0500
Received: from fmr23.intel.com ([143.183.121.15]:64398 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751698AbWCCWCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:02:11 -0500
Date: Fri, 3 Mar 2006 13:51:14 -0800
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety
Message-ID: <20060303215114.GA13893@linux.intel.com>
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com> <5041.1141417027@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603031332140.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603031332140.22647@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 01:34:17PM -0800, Linus Torvalds wrote:
> Indeed. I think smp_wmb() should be a compiler fence only on x86(-64), ie 
> just compile to a "barrier()" (and not even that on UP, of course).

Actually, no.  At least in testing an implementation of Dekker's and 
Peterson's algorithms as a replacement for the locked operation in 
our spinlocks, it is absolutely necessary to have an sfence in the lock 
to ensure the lock is visible to the other CPU before proceeding.  I'd 
use smp_wmb() as the fence is completely unnecessary on UP and is even 
irq-safe.  Here's a copy of the Peterson's implementation to illustrate 
(it works, it's just slower than the existing spinlocks).

		-ben

diff --git a/include/asm-x86_64/spinlock.h b/include/asm-x86_64/spinlock.h
index fe484a6..45bd386 100644
--- a/include/asm-x86_64/spinlock.h
+++ b/include/asm-x86_64/spinlock.h
@@ -4,6 +4,8 @@
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
 #include <asm/page.h>
+#include <asm/pda.h>
+#include <asm/processor.h>
 #include <linux/config.h>
 
 /*
@@ -18,50 +20,53 @@
  */
 
 #define __raw_spin_is_locked(x) \
-		(*(volatile signed int *)(&(x)->slock) <= 0)
-
-#define __raw_spin_lock_string \
-	"\n1:\t" \
-	"lock ; decl %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"rep;nop\n\t" \
-	"cmpl $0,%0\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
-
-#define __raw_spin_unlock_string \
-	"movl $1,%0" \
-		:"=m" (lock->slock) : : "memory"
+		((*(volatile signed int *)(x) & ~0xff) != 0)
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__(
-		__raw_spin_lock_string
-		:"=m" (lock->slock) : : "memory");
+	int cpu = read_pda(cpunumber);
+
+	barrier();
+	lock->flags[cpu] = 1;
+	lock->turn = cpu ^ 1;
+	barrier();
+
+	asm volatile("sfence":::"memory");
+
+	while (lock->flags[cpu ^ 1] && (lock->turn != cpu)) {
+		cpu_relax();
+		barrier();
+	}
 }
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
-	int oldval;
-
-	__asm__ __volatile__(
-		"xchgl %0,%1"
-		:"=q" (oldval), "=m" (lock->slock)
-		:"0" (0) : "memory");
-
-	return oldval > 0;
+	int cpu = read_pda(cpunumber);
+	barrier();
+	if (__raw_spin_is_locked(lock))
+		return 0;
+
+	lock->flags[cpu] = 1;
+	lock->turn = cpu ^ 1;
+	asm volatile("sfence":::"memory");
+
+	if (lock->flags[cpu ^ 1] && (lock->turn != cpu)) {
+		lock->flags[cpu] = 0;
+		barrier();
+		return 0;
+	}
+	return 1;
 }
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__(
-		__raw_spin_unlock_string
-	);
+	int cpu;
+	//asm volatile("lfence":::"memory");
+	cpu = read_pda(cpunumber);
+	lock->flags[cpu] = 0;
+	barrier();
 }
 
 #define __raw_spin_unlock_wait(lock) \
diff --git a/include/asm-x86_64/spinlock_types.h b/include/asm-x86_64/spinlock_types.h
index 59efe84..a409cbf 100644
--- a/include/asm-x86_64/spinlock_types.h
+++ b/include/asm-x86_64/spinlock_types.h
@@ -6,10 +6,11 @@
 #endif
 
 typedef struct {
-	volatile unsigned int slock;
+	volatile unsigned char turn;
+	volatile unsigned char flags[3];
 } raw_spinlock_t;
 
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0, { 0, } }
 
 typedef struct {
 	volatile unsigned int lock;
