Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274127AbRISSFv>; Wed, 19 Sep 2001 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274128AbRISSFf>; Wed, 19 Sep 2001 14:05:35 -0400
Received: from [195.223.140.107] ([195.223.140.107]:12286 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274127AbRISSE1>;
	Wed, 19 Sep 2001 14:04:27 -0400
Date: Wed, 19 Sep 2001 20:03:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919200357.Z720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5079.1000911203@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, Sep 19, 2001 at 03:53:23PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:53:23PM +0100, David Howells wrote:
> 
> Here's a patch to make rwsems unfair.

if we go generic then I strongly recommend my version of the generic
semaphores is _much_ faster (and cleaner) than this one (it even allows
more than 2^31 concurrent readers on 64 bit archs ;).

just apply this patch on top of pre12:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre11aa1/00_rwsem-19

and then I'll send another incremental patch to kill the XCHGADD
garbage. (but this patch will be enough to provide efficient and unfair
rwsem to all architectures, so fixing the deadlock)

I inlined the patch below (may need some conversion to likely/unlikely
as well).

diff -urN rwsem-ref/arch/alpha/config.in rwsem/arch/alpha/config.in
--- rwsem-ref/arch/alpha/config.in	Thu Aug 16 22:03:22 2001
+++ rwsem/arch/alpha/config.in	Tue Sep 18 10:31:29 2001
@@ -5,8 +5,7 @@
 
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 
diff -urN rwsem-ref/arch/arm/config.in rwsem/arch/arm/config.in
--- rwsem-ref/arch/arm/config.in	Thu Aug 16 22:03:22 2001
+++ rwsem/arch/arm/config.in	Tue Sep 18 10:31:29 2001
@@ -10,8 +10,6 @@
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
-
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN rwsem-ref/arch/cris/config.in rwsem/arch/cris/config.in
--- rwsem-ref/arch/cris/config.in	Sat Aug 11 08:03:53 2001
+++ rwsem/arch/cris/config.in	Tue Sep 18 10:31:29 2001
@@ -6,7 +6,6 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN rwsem-ref/arch/i386/config.in rwsem/arch/i386/config.in
--- rwsem-ref/arch/i386/config.in	Sat Jul 21 00:04:05 2001
+++ rwsem/arch/i386/config.in	Tue Sep 18 10:31:29 2001
@@ -51,7 +51,6 @@
    define_bool CONFIG_X86_XADD n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -59,8 +58,7 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -urN rwsem-ref/arch/ia64/config.in rwsem/arch/ia64/config.in
--- rwsem-ref/arch/ia64/config.in	Sat Aug 11 08:03:54 2001
+++ rwsem/arch/ia64/config.in	Tue Sep 18 10:31:29 2001
@@ -24,7 +24,6 @@
 define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
diff -urN rwsem-ref/arch/m68k/config.in rwsem/arch/m68k/config.in
--- rwsem-ref/arch/m68k/config.in	Wed Jul  4 04:03:45 2001
+++ rwsem/arch/m68k/config.in	Tue Sep 18 10:31:29 2001
@@ -5,7 +5,6 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
diff -urN rwsem-ref/arch/mips/config.in rwsem/arch/mips/config.in
--- rwsem-ref/arch/mips/config.in	Tue Sep 18 02:42:02 2001
+++ rwsem/arch/mips/config.in	Tue Sep 18 10:31:29 2001
@@ -69,7 +69,6 @@
 bool 'Support for Alchemy Semi PB1000 board' CONFIG_MIPS_PB1000
 
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 #
 # Select some configuration options automatically for certain systems.
diff -urN rwsem-ref/arch/mips64/config.in rwsem/arch/mips64/config.in
--- rwsem-ref/arch/mips64/config.in	Tue Sep 18 02:42:10 2001
+++ rwsem/arch/mips64/config.in	Tue Sep 18 10:31:29 2001
@@ -28,7 +28,6 @@
 endmenu
 
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 #
 # Select some configuration options automatically based on user selections
diff -urN rwsem-ref/arch/parisc/config.in rwsem/arch/parisc/config.in
--- rwsem-ref/arch/parisc/config.in	Tue May  1 19:35:20 2001
+++ rwsem/arch/parisc/config.in	Tue Sep 18 10:31:29 2001
@@ -8,7 +8,6 @@
 define_bool CONFIG_PARISC y
 define_bool CONFIG_UID16 n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN rwsem-ref/arch/ppc/config.in rwsem/arch/ppc/config.in
--- rwsem-ref/arch/ppc/config.in	Tue Sep 18 02:42:16 2001
+++ rwsem/arch/ppc/config.in	Tue Sep 18 10:31:29 2001
@@ -4,8 +4,7 @@
 # see Documentation/kbuild/config-language.txt.
 #
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
diff -urN rwsem-ref/arch/s390/config.in rwsem/arch/s390/config.in
--- rwsem-ref/arch/s390/config.in	Sat Aug 11 08:03:56 2001
+++ rwsem/arch/s390/config.in	Tue Sep 18 10:31:29 2001
@@ -8,7 +8,6 @@
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -urN rwsem-ref/arch/s390x/config.in rwsem/arch/s390x/config.in
--- rwsem-ref/arch/s390x/config.in	Sat Aug 11 08:04:00 2001
+++ rwsem/arch/s390x/config.in	Tue Sep 18 10:31:29 2001
@@ -7,7 +7,6 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -urN rwsem-ref/arch/sh/config.in rwsem/arch/sh/config.in
--- rwsem-ref/arch/sh/config.in	Tue Sep 18 02:42:19 2001
+++ rwsem/arch/sh/config.in	Tue Sep 18 10:31:29 2001
@@ -8,7 +8,6 @@
 
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN rwsem-ref/arch/sparc/config.in rwsem/arch/sparc/config.in
--- rwsem-ref/arch/sparc/config.in	Wed Jul  4 04:03:45 2001
+++ rwsem/arch/sparc/config.in	Tue Sep 18 10:31:29 2001
@@ -49,7 +49,6 @@
 define_bool CONFIG_SUN_AUXIO y
 define_bool CONFIG_SUN_IO y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 bool 'Support for SUN4 machines (disables SUN4[CDM] support)' CONFIG_SUN4
 if [ "$CONFIG_SUN4" != "y" ]; then
diff -urN rwsem-ref/arch/sparc64/config.in rwsem/arch/sparc64/config.in
--- rwsem-ref/arch/sparc64/config.in	Thu Aug 16 22:03:25 2001
+++ rwsem/arch/sparc64/config.in	Tue Sep 18 10:31:29 2001
@@ -33,8 +33,8 @@
 
 # Global things across all Sun machines.
 define_bool CONFIG_HAVE_DEC_LOCK y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+# sorry I broke it again
+define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n
diff -urN rwsem-ref/include/asm-alpha/rwsem_xchgadd.h rwsem/include/asm-alpha/rwsem_xchgadd.h
--- rwsem-ref/include/asm-alpha/rwsem_xchgadd.h	Thu Jan  1 01:00:00 1970
+++ rwsem/include/asm-alpha/rwsem_xchgadd.h	Tue Sep 18 10:31:29 2001
@@ -0,0 +1,27 @@
+#ifndef _ALPHA_RWSEM_XCHGADD_H
+#define _ALPHA_RWSEM_XCHGADD_H
+
+/* WRITEME */
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+}
+
+static inline void __down_write(struct rw_semaphore *sem)
+{
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+}
+
+static inline long rwsem_xchgadd(long value, long * count)
+{
+	return value;
+}
+
+#endif
diff -urN rwsem-ref/include/asm-i386/rwsem.h rwsem/include/asm-i386/rwsem.h
--- rwsem-ref/include/asm-i386/rwsem.h	Fri Aug 17 05:02:27 2001
+++ rwsem/include/asm-i386/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,226 +0,0 @@
-/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-i386/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _I386_RWSEM_H
-#define _I386_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  js        2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  pushl     %%edx\n\t"
-		"  call      rwsem_down_read_failed\n\t"
-		"  popl      %%edx\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous"
-		"# ending down_read\n\t"
-		: "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
-		"  testl     %0,%0\n\t" /* was the count 0 before? */
-		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_down_write_failed\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending down_write"
-		: "+d"(tmp), "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       1b\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-		"  movl      %2,%%edx\n\t"
-LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
-		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
-		"  jnz       1b\n\t" /* jump back if not */
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_write\n"
-		: "+m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
-		: "memory", "cc", "edx");
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-LOCK_PREFIX	"addl %1,%0"
-		:"=m"(sem->count)
-		:"ir"(delta), "m"(sem->count));
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,(%2)"
-		: "+r"(tmp), "=m"(sem->count)
-		: "r"(sem), "m"(sem->count)
-		: "memory");
-
-	return tmp+delta;
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_H */
diff -urN rwsem-ref/include/asm-i386/rwsem_xchgadd.h rwsem/include/asm-i386/rwsem_xchgadd.h
--- rwsem-ref/include/asm-i386/rwsem_xchgadd.h	Thu Jan  1 01:00:00 1970
+++ rwsem/include/asm-i386/rwsem_xchgadd.h	Tue Sep 18 10:31:29 2001
@@ -0,0 +1,93 @@
+#ifndef _X86_RWSEM_XCHGADD_H
+#define _X86_RWSEM_XCHGADD_H
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(LOCK "incl %0\n\t"
+			     "js 2f\n"
+			     "1:\n"
+			     ".section .text.lock,\"ax\"\n" 
+			     "2:\t"
+			     "pushl %%edx\n\t"
+			     "pushl %%ecx\n\t"
+			     "movl %2, %%edx\n\t"
+			     "call rwsem_down_failed\n\t"
+			     "popl %%ecx\n\t"
+			     "popl %%edx\n\t"
+			     "jmp 1b\n"
+			     ".previous"
+			     : "+m" (sem->count)
+			     : "a" (sem), "i" (RWSEM_READ_BLOCKING_BIAS)
+			     : "memory", "cc");
+}
+
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	long count;
+
+	count = RWSEM_WRITE_BIAS + RWSEM_READ_BIAS;
+	__asm__ __volatile(LOCK "xaddl %0, %1\n\t"
+			   "testl %0,%0\n\t"
+			   "jnz 2f\n"
+			   "1:\n"
+			   ".section .text.lock,\"ax\"\n"
+			   "2:\t"
+			   "pushl %%ecx\n\t"
+			   "movl %3, %%edx\n\t"
+			   "call rwsem_down_failed\n\t"
+			   "popl %%ecx\n\t"
+			   "jmp 1b\n"
+			   ".previous"
+			   : "+d" (count), "+m" (sem->count)
+			   : "a" (sem), "i" (RWSEM_WRITE_BLOCKING_BIAS)
+			   : "memory", "cc");
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	long count;
+
+	count = -RWSEM_READ_BIAS;
+	__asm__ __volatile__(LOCK "xaddl %0, %1\n\t"
+			     "js 2f\n"
+			     "1:\n"
+			     ".section .text.lock,\"ax\"\n"
+			     "2:\t"
+			     "cmpw $1, %w0\n\t"
+			     "jnz 1b\n\t"
+			     "pushl %%ecx\n\t"
+			     "call rwsem_wake\n\t"
+			     "popl %%ecx\n\t"
+			     "jmp 1b\n"
+			     ".previous"
+			     : "+d" (count), "+m" (sem->count)
+			     : "a" (sem)
+			     : "memory", "cc");
+}
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	__asm__ __volatile__(LOCK "subl %2, %0\n\t"
+			     "js 2f\n"
+			     "1:\n"
+			     ".section .text.lock,\"ax\"\n"
+			     "2:\t"
+			     "pushl %%edx\n\t"
+			     "pushl %%ecx\n\t"
+			     "call rwsem_wake\n\t"
+			     "popl %%ecx\n\t"
+			     "popl %%edx\n\t"
+			     "jmp 1b\n"
+			     ".previous"
+			     : "+m" (sem->count)
+			     : "a" (sem), "i" (RWSEM_READ_BIAS + RWSEM_WRITE_BIAS)
+			     : "memory", "cc");
+}
+
+static inline long rwsem_xchgadd(long value, long * count)
+{
+	__asm__ __volatile__(LOCK "xaddl %0,%1"
+			     : "+r" (value), "+m" (*count));
+	return value;
+}
+
+#endif
diff -urN rwsem-ref/include/linux/rwsem-spinlock.h rwsem/include/linux/rwsem-spinlock.h
--- rwsem-ref/include/linux/rwsem-spinlock.h	Wed Aug 29 15:05:24 2001
+++ rwsem/include/linux/rwsem-spinlock.h	Thu Jan  1 01:00:00 1970
@@ -1,62 +0,0 @@
-/* rwsem-spinlock.h: fallback C implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-
-#ifndef _LINUX_RWSEM_SPINLOCK_H
-#define _LINUX_RWSEM_SPINLOCK_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead
-#endif
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct rwsem_waiter;
-
-/*
- * the rw-semaphore definition
- * - if activity is 0 then there are no active readers or writers
- * - if activity is +ve then that is the number of active readers
- * - if activity is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			activity;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
-extern void FASTCALL(__down_read(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write(struct rw_semaphore *sem));
-extern void FASTCALL(__up_read(struct rw_semaphore *sem));
-extern void FASTCALL(__up_write(struct rw_semaphore *sem));
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -urN rwsem-ref/include/linux/rwsem.h rwsem/include/linux/rwsem.h
--- rwsem-ref/include/linux/rwsem.h	Wed Aug 29 15:05:24 2001
+++ rwsem/include/linux/rwsem.h	Tue Sep 18 10:31:34 2001
@@ -1,80 +1,19 @@
-/* rwsem.h: R/W semaphores, public interface
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from asm-i386/semaphore.h
- */
-
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
-#include <linux/linkage.h>
-
-#define RWSEM_DEBUG 0
-
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
 
-struct rw_semaphore;
+#undef RWSEM_DEBUG
 
 #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
-#else
-#include <asm/rwsem.h> /* use an arch-specific implementation */
-#endif
-
-#ifndef rwsemtrace
-#if RWSEM_DEBUG
-extern void FASTCALL(rwsemtrace(struct rw_semaphore *sem, const char *str));
+#include <linux/rwsem_spinlock.h>
+#elif defined(CONFIG_RWSEM_XCHGADD)
+#include <linux/rwsem_xchgadd.h>
 #else
-#define rwsemtrace(SEM,FMT)
+#include <asm/rwsem.h>
 #endif
-#endif
-
-/*
- * lock for reading
- */
-static inline void down_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering down_read");
-	__down_read(sem);
-	rwsemtrace(sem,"Leaving down_read");
-}
-
-/*
- * lock for writing
- */
-static inline void down_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering down_write");
-	__down_write(sem);
-	rwsemtrace(sem,"Leaving down_write");
-}
-
-/*
- * release a read lock
- */
-static inline void up_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering up_read");
-	__up_read(sem);
-	rwsemtrace(sem,"Leaving up_read");
-}
-
-/*
- * release a write lock
- */
-static inline void up_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering up_write");
-	__up_write(sem);
-	rwsemtrace(sem,"Leaving up_write");
-}
-
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_H */
diff -urN rwsem-ref/include/linux/rwsem_spinlock.h rwsem/include/linux/rwsem_spinlock.h
--- rwsem-ref/include/linux/rwsem_spinlock.h	Thu Jan  1 01:00:00 1970
+++ rwsem/include/linux/rwsem_spinlock.h	Tue Sep 18 10:31:34 2001
@@ -0,0 +1,62 @@
+#ifndef _LINUX_RWSEM_SPINLOCK_H
+#define _LINUX_RWSEM_SPINLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+
+struct rw_semaphore
+{
+	spinlock_t lock;
+	long count;
+#define RWSEM_READ_BIAS 1
+#define RWSEM_WRITE_BIAS (~(~0UL >> (BITS_PER_LONG>>1)))
+	struct list_head wait;
+#if RWSEM_DEBUG
+	long __magic;
+#endif
+};
+
+#if RWSEM_DEBUG
+#define __SEM_DEBUG_INIT(name) \
+	, (long)&(name).__magic
+#define RWSEM_MAGIC(x)							\
+	do {								\
+		if ((x) != (long)&(x)) {				\
+			printk("rwsem bad magic %lx (should be %lx), ",	\
+				(long)x, (long)&(x));			\
+			BUG();						\
+		}							\
+	} while (0)
+#else
+#define __SEM_DEBUG_INIT(name)
+#define CHECK_MAGIC(x)
+#endif
+
+#define __RWSEM_INITIALIZER(name, count)	\
+{						\
+	SPIN_LOCK_UNLOCKED,			\
+	(count),				\
+	LIST_HEAD_INIT((name).wait)		\
+	__SEM_DEBUG_INIT(name)			\
+}
+#define RWSEM_INITIALIZER(name) __RWSEM_INITIALIZER(name, 0)
+
+#define __DECLARE_RWSEM(name, count) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name, count)
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM(name, 0)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_READ_BIAS)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_WRITE_BIAS)
+
+#define RWSEM_READ_BLOCKING_BIAS (RWSEM_WRITE_BIAS-RWSEM_READ_BIAS)
+#define RWSEM_WRITE_BLOCKING_BIAS (0)
+
+#define RWSEM_READ_MASK (~RWSEM_WRITE_BIAS)
+#define RWSEM_WRITE_MASK (RWSEM_WRITE_BIAS)
+
+extern void FASTCALL(init_rwsem(struct rw_semaphore *));
+extern void FASTCALL(down_read(struct rw_semaphore *));
+extern void FASTCALL(down_write(struct rw_semaphore *));
+extern void FASTCALL(up_read(struct rw_semaphore *));
+extern void FASTCALL(up_write(struct rw_semaphore *));
+
+#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -urN rwsem-ref/include/linux/rwsem_xchgadd.h rwsem/include/linux/rwsem_xchgadd.h
--- rwsem-ref/include/linux/rwsem_xchgadd.h	Thu Jan  1 01:00:00 1970
+++ rwsem/include/linux/rwsem_xchgadd.h	Tue Sep 18 10:31:34 2001
@@ -0,0 +1,104 @@
+#ifndef _LINUX_RWSEM_XCHGADD_H
+#define _LINUX_RWSEM_XCHGADD_H
+
+#include <linux/kernel.h>
+
+struct rw_semaphore
+{
+	long count;
+	spinlock_t lock;
+#define RWSEM_READ_BIAS 1
+#define RWSEM_WRITE_BIAS (~(~0UL >> (BITS_PER_LONG>>1)))
+	struct list_head wait;
+#if RWSEM_DEBUG
+	long __magic;
+#endif
+};
+
+#if RWSEM_DEBUG
+#define __SEM_DEBUG_INIT(name) \
+	, (int)&(name).__magic
+#define RWSEM_MAGIC(x)							\
+	do {								\
+		if ((x) != (long)&(x)) {				\
+			printk("rwsem bad magic %lx (should be %lx), ",	\
+				(long)x, (long)&(x));			\
+			BUG();						\
+		}							\
+	} while (0)
+#else
+#define __SEM_DEBUG_INIT(name)
+#define CHECK_MAGIC(x)
+#endif
+
+#define __RWSEM_INITIALIZER(name, count)	\
+{						\
+	(count),				\
+	SPIN_LOCK_UNLOCKED,			\
+	LIST_HEAD_INIT((name).wait)		\
+	__SEM_DEBUG_INIT(name)			\
+}
+#define RWSEM_INITIALIZER(name) __RWSEM_INITIALIZER(name, 0)
+
+#define __DECLARE_RWSEM(name, count) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name, count)
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM(name, 0)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_READ_BIAS)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_WRITE_BIAS+RWSEM_READ_BIAS)
+
+#define RWSEM_READ_BLOCKING_BIAS (RWSEM_WRITE_BIAS-RWSEM_READ_BIAS)
+#define RWSEM_WRITE_BLOCKING_BIAS (-RWSEM_READ_BIAS)
+
+#define RWSEM_READ_MASK (~RWSEM_WRITE_BIAS)
+#define RWSEM_WRITE_MASK (RWSEM_WRITE_BIAS)
+
+/*
+ * We return the semaphore itself from the C functions so we can pass it
+ * in %eax via regparm and we don't need to declare %eax clobbered by C.
+ * This is mostly for x86 but maybe other archs can make a use of it too.
+ * Idea is from David Howells <dhowells@redhat.com>.
+ */
+extern struct rw_semaphore * FASTCALL(rwsem_down_failed(struct rw_semaphore *, long));
+extern struct rw_semaphore * FASTCALL(rwsem_wake(struct rw_semaphore *));
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->count = 0;
+	spin_lock_init(&sem->lock);
+	INIT_LIST_HEAD(&sem->wait);
+#if RWSEM_DEBUG
+	sem->__magic = (long)&sem->__magic;
+#endif
+}
+
+#include <asm/rwsem_xchgadd.h>
+
+static inline void down_read(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	__down_read(sem);
+}
+
+static inline void down_write(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	__down_write(sem);
+}
+
+static inline void up_read(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	__up_read(sem);
+}
+
+static inline void up_write(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	__up_write(sem);
+}
+
+#endif /* _LINUX_RWSEM_XCHGADD_H */
diff -urN rwsem-ref/include/linux/sched.h rwsem/include/linux/sched.h
--- rwsem-ref/include/linux/sched.h	Tue Sep 18 02:43:03 2001
+++ rwsem/include/linux/sched.h	Tue Sep 18 10:31:34 2001
@@ -239,7 +239,7 @@
 	pgd:		swapper_pg_dir, 		\
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
+	mmap_sem:	RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }
diff -urN rwsem-ref/lib/Makefile rwsem/lib/Makefile
--- rwsem-ref/lib/Makefile	Tue Sep 18 02:43:04 2001
+++ rwsem/lib/Makefile	Tue Sep 18 10:31:34 2001
@@ -8,12 +8,12 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem_spinlock.o rwsem_xchgadd.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
 
-obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem_spinlock.o
+obj-$(CONFIG_RWSEM_XCHGADD) += rwsem_xchgadd.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
diff -urN rwsem-ref/lib/rwsem.c rwsem/lib/rwsem.c
--- rwsem-ref/lib/rwsem.c	Sat Jul 21 00:04:34 2001
+++ rwsem/lib/rwsem.c	Thu Jan  1 01:00:00 1970
@@ -1,210 +0,0 @@
-/* rwsem.c: R/W semaphores: contention handling functions
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from arch/i386/kernel/semaphore.c
- */
-#include <linux/rwsem.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-struct rwsem_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	unsigned int		flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
-};
-
-#if RWSEM_DEBUG
-#undef rwsemtrace
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
-{
-	printk("sem=%p\n",sem);
-	printk("(sem)=%08lx\n",sem->count);
-	if (sem->debug)
-		printk("[%d] %s({%08lx})\n",current->pid,str,sem->count);
-}
-#endif
-
-/*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero but has been re-incremented
- *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
- *   - there must be someone on the queue
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having flags zeroised
- */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-	struct list_head *next;
-	signed long oldcount;
-	int woken, loop;
-
-	rwsemtrace(sem,"Entering __rwsem_do_wake");
-
-	/* only wake someone up if we can transition the active part of the count from 0 -> 1 */
- try_again:
-	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS,sem) - RWSEM_ACTIVE_BIAS;
-	if (oldcount & RWSEM_ACTIVE_MASK)
-		goto undo;
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
-	 *   incremented by 0x00010000
-	 */
-	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
-		goto readers_only;
-
-	list_del(&waiter->list);
-	waiter->flags = 0;
-	wake_up_process(waiter->task);
-	goto out;
-
-	/* grant an infinite number of read locks to the readers at the front of the queue
-	 * - note we increment the 'active part' of the count by the number of readers (less one
-	 *   for the activity decrement we've already done) before waking any processes up
-	 */
- readers_only:
-	woken = 0;
-	do {
-		woken++;
-
-		if (waiter->list.next==&sem->wait_list)
-			break;
-
-		waiter = list_entry(waiter->list.next,struct rwsem_waiter,list);
-
-	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
-
-	loop = woken;
-	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
-	woken -= RWSEM_ACTIVE_BIAS;
-	rwsem_atomic_add(woken,sem);
-
-	next = sem->wait_list.next;
-	for (; loop>0; loop--) {
-		waiter = list_entry(next,struct rwsem_waiter,list);
-		next = waiter->list.next;
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-	}
-
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
-
- out:
-	rwsemtrace(sem,"Leaving __rwsem_do_wake");
-	return sem;
-
-	/* undo the change to count, but check for a transition 1->0 */
- undo:
-	if (rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem)!=0)
-		goto out;
-	goto try_again;
-}
-
-/*
- * wait for a lock to be granted
- */
-static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
-								 struct rwsem_waiter *waiter,
-								 signed long adjustment)
-{
-	struct task_struct *tsk = current;
-	signed long count;
-
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
-	waiter->task = tsk;
-
-	list_add_tail(&waiter->list,&sem->wait_list);
-
-	/* note that we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(adjustment,sem);
-
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter->flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/*
- * wait for the read lock to be granted
- */
-struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	rwsemtrace(sem,"Entering rwsem_down_read_failed");
-
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-	rwsem_down_failed_common(sem,&waiter,RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
-	return sem;
-}
-
-/*
- * wait for the write lock to be granted
- */
-struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	rwsemtrace(sem,"Entering rwsem_down_write_failed");
-
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	rwsem_down_failed_common(sem,&waiter,-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
-	return sem;
-}
-
-/*
- * handle waking up a waiter on the semaphore
- * - up_read has decremented the active part of the count if we come here
- */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering rwsem_wake");
-
-	spin_lock(&sem->wait_lock);
-
-	/* do nothing if list empty */
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving rwsem_wake");
-
-	return sem;
-}
-
-EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_wake);
-#if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
-#endif
diff -urN rwsem-ref/lib/rwsem_spinlock.c rwsem/lib/rwsem_spinlock.c
--- rwsem-ref/lib/rwsem_spinlock.c	Thu Jan  1 01:00:00 1970
+++ rwsem/lib/rwsem_spinlock.c	Tue Sep 18 10:31:34 2001
@@ -0,0 +1,126 @@
+/*
+ *  rw_semaphores generic spinlock version
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ */
+
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <asm/semaphore.h>
+
+struct rwsem_wait_queue {
+	unsigned long retire;
+	struct task_struct * task;
+	struct list_head task_list;
+};
+
+static void FASTCALL(rwsem_down_failed(struct rw_semaphore *, long));
+static void rwsem_down_failed(struct rw_semaphore *sem, long retire)
+{
+	struct task_struct *tsk = current;
+	struct rwsem_wait_queue wait;
+
+	sem->count += retire;
+	wait.retire = retire;
+	wait.task = tsk;
+	INIT_LIST_HEAD(&wait.task_list);
+	list_add(&wait.task_list, &sem->wait);
+
+	do {
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	} while(wait.task_list.next);
+}
+
+static void FASTCALL(rwsem_wake(struct rw_semaphore *));
+static void rwsem_wake(struct rw_semaphore *sem)
+{
+	struct list_head * entry, * head = &sem->wait;
+	int last = 0;
+
+	while ((entry = head->prev) != head) {
+		struct rwsem_wait_queue * wait;
+
+		wait = list_entry(entry, struct rwsem_wait_queue, task_list);
+
+		if (wait->retire == RWSEM_WRITE_BLOCKING_BIAS) {
+			if (sem->count & RWSEM_READ_MASK)
+				break;
+			last = 1;
+		}
+
+		/* convert write lock into read lock when read become active */
+		sem->count -= wait->retire;
+		list_del(entry);
+		entry->next = NULL;
+		wake_up_process(wait->task);
+			
+		if (last)
+			break;
+	}
+}
+
+void init_rwsem(struct rw_semaphore *sem)
+{
+	spin_lock_init(&sem->lock);
+	sem->count = 0;
+	INIT_LIST_HEAD(&sem->wait);
+#if RWSEM_DEBUG
+	sem->__magic = (long)&sem->__magic;
+#endif
+}
+
+void down_read(struct rw_semaphore *sem)
+{
+	int count;
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_READ_BIAS;
+	if (__builtin_expect(count < 0 && !(count & RWSEM_READ_MASK), 0))
+		rwsem_down_failed(sem, RWSEM_READ_BLOCKING_BIAS);
+	spin_unlock(&sem->lock);
+}
+
+void down_write(struct rw_semaphore *sem)
+{
+	long count;
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_WRITE_BIAS;
+	if (__builtin_expect(count, 0))
+		rwsem_down_failed(sem, RWSEM_WRITE_BLOCKING_BIAS);
+	spin_unlock(&sem->lock);
+}
+
+void up_read(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_READ_BIAS;
+	if (__builtin_expect(sem->count < 0 && !(sem->count & RWSEM_READ_MASK), 0))
+		rwsem_wake(sem);
+	spin_unlock(&sem->lock);
+}
+
+void up_write(struct rw_semaphore *sem)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_WRITE_BIAS;
+	if (__builtin_expect(sem->count, 0))
+		rwsem_wake(sem);
+	spin_unlock(&sem->lock);
+}
+
+EXPORT_SYMBOL(init_rwsem);
+EXPORT_SYMBOL(down_read);
+EXPORT_SYMBOL(down_write);
+EXPORT_SYMBOL(up_read);
+EXPORT_SYMBOL(up_write);
diff -urN rwsem-ref/lib/rwsem_xchgadd.c rwsem/lib/rwsem_xchgadd.c
--- rwsem-ref/lib/rwsem_xchgadd.c	Thu Jan  1 01:00:00 1970
+++ rwsem/lib/rwsem_xchgadd.c	Tue Sep 18 10:31:34 2001
@@ -0,0 +1,92 @@
+/*
+ *  rw_semaphores xchgadd version
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ */
+
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <asm/semaphore.h>
+
+struct rwsem_wait_queue {
+	unsigned long retire;
+	struct task_struct * task;
+	struct list_head task_list;
+};
+
+static void FASTCALL(__rwsem_wake(struct rw_semaphore *));
+static void __rwsem_wake(struct rw_semaphore *sem)
+{
+	struct list_head * entry, * head = &sem->wait;
+	int wake_write = 0, wake_read = 0;
+
+	while ((entry = head->prev) != head) {
+		struct rwsem_wait_queue * wait;
+		long count;
+
+		wait = list_entry(entry, struct rwsem_wait_queue, task_list);
+
+		if (wait->retire == RWSEM_WRITE_BLOCKING_BIAS) {
+			if (wake_read)
+				break;
+			wake_write = 1;
+		}
+
+	again:
+		count = rwsem_xchgadd(-wait->retire, &sem->count);
+		if (!wake_read && (count & RWSEM_READ_MASK)) {
+			count = rwsem_xchgadd(wait->retire, &sem->count);
+			if ((count & RWSEM_READ_MASK) == 1)
+				goto again;
+			break;
+		}
+		
+		list_del(entry);
+		entry->next = NULL;
+		wake_up_process(wait->task);
+			
+		if (wake_write)
+			break;
+		wake_read = 1;
+	}
+}
+
+struct rw_semaphore * rwsem_down_failed(struct rw_semaphore *sem, long retire)
+{
+	struct task_struct *tsk = current;
+	struct rwsem_wait_queue wait;
+	long count;
+
+	wait.retire = retire;
+	wait.task = tsk;
+	INIT_LIST_HEAD(&wait.task_list);
+
+	spin_lock(&sem->lock);
+	list_add(&wait.task_list, &sem->wait);
+
+	count = rwsem_xchgadd(retire, &sem->count);
+	if ((count & RWSEM_READ_MASK) == 1)
+		__rwsem_wake(sem);
+
+	while (wait.task_list.next) {
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
+		schedule();
+		spin_lock(&sem->lock);
+	}
+
+	spin_unlock(&sem->lock);
+
+	return sem;
+}
+
+struct rw_semaphore * rwsem_wake(struct rw_semaphore *sem)
+{
+	spin_lock(&sem->lock);
+	__rwsem_wake(sem);
+	spin_unlock(&sem->lock);
+
+	return sem;
+}
+
+EXPORT_SYMBOL_NOVERS(rwsem_down_failed);
+EXPORT_SYMBOL_NOVERS(rwsem_wake);

Andrea
