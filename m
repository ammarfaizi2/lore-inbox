Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270003AbUIDAkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbUIDAkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270010AbUIDAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:39:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:22980 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270003AbUIDAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:34 -0400
Date: Fri, 3 Sep 2004 20:40:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][7/8] updated arch agnostic completely out of line locks /
 sparc64
Message-ID: <Pine.LNX.4.58.0409032031550.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/sparc64/kernel/time.c        |   13 ++++
 arch/sparc64/kernel/vmlinux.lds.S |    1
 arch/sparc64/lib/Makefile         |    4 -
 arch/sparc64/lib/debuglocks.c     |    2
 arch/sparc64/lib/rwlock.S         |   85 --------------------------
 arch/sparc64/lib/splock.S         |   39 ------------
 include/asm-sparc64/ptrace.h      |    4 +
 include/asm-sparc64/spinlock.h    |  122 ++++++++++++++++++++++++++++++++++----
 8 files changed, 133 insertions(+), 137 deletions(-)

Status: Tested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sparc64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/time.c	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/time.c	3 Sep 2004 23:55:27 -0000
@@ -68,6 +68,19 @@ struct sparc64_tick_ops *tick_ops;

 #define TICK_PRIV_BIT	(1UL << 63)

+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return regs->u_regs[UREG_RETPC];
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif
+
 static void tick_disable_protection(void)
 {
 	/* Set things up so user can access tick register for profiling
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sparc64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/vmlinux.lds.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -16,6 +16,7 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sparc64/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/Makefile	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/Makefile	3 Sep 2004 23:55:27 -0000
@@ -8,11 +8,11 @@ EXTRA_CFLAGS := -Werror
 lib-y := PeeCeeI.o copy_page.o clear_page.o strlen.o strncmp.o \
 	 memscan.o strncpy_from_user.o strlen_user.o memcmp.o checksum.o \
 	 VISbzero.o VISmemset.o VIScsum.o VIScsumcopy.o \
-	 VIScsumcopyusr.o VISsave.o atomic.o rwlock.o bitops.o \
+	 VIScsumcopyusr.o VISsave.o atomic.o bitops.o \
 	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
 	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
 	 copy_in_user.o user_fixup.o memmove.o \
-	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
+	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o

 lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/debuglocks.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sparc64/lib/debuglocks.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 debuglocks.c
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/debuglocks.c	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/debuglocks.c	3 Sep 2004 23:55:27 -0000
@@ -84,7 +84,7 @@ again:
 	put_cpu();
 }

-int _spin_trylock(spinlock_t *lock)
+int _do_spin_trylock(spinlock_t *lock)
 {
 	unsigned long val, caller;
 	int cpu = get_cpu();
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/rwlock.S
===================================================================
RCS file: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/rwlock.S
diff -N linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/rwlock.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/rwlock.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,85 +0,0 @@
-/* $Id: rwlock.S,v 1.1.1.1 2004/09/03 01:30:24 zwane Exp $
- * rwlocks.S: These things are too big to do inline.
- *
- * Copyright (C) 1999 David S. Miller (davem@redhat.com)
- */
-
-	.text
-	.align	64
-
-	/* The non-contention read lock usage is 2 cache lines. */
-
-	.globl	__read_lock, __read_unlock
-__read_lock: /* %o0 = lock_ptr */
-	ldsw		[%o0], %g5
-	brlz,pn		%g5, __read_wait_for_writer
-4:	 add		%g5, 1, %g7
-	cas		[%o0], %g5, %g7
-	cmp		%g5, %g7
-	bne,pn		%icc, __read_lock
-	 membar		#StoreLoad | #StoreStore
-99:	retl
-	 nop
-__read_unlock: /* %o0 = lock_ptr */
-	lduw		[%o0], %g5
-	sub		%g5, 1, %g7
-	cas		[%o0], %g5, %g7
-	cmp		%g5, %g7
-	be,pt		%xcc, 99b
-	 membar		#StoreLoad | #StoreStore
-	ba,a,pt		%xcc, __read_unlock
-
-__read_wait_for_writer:
-	ldsw		[%o0], %g5
-	brlz,pt		%g5, __read_wait_for_writer
-	 membar		#LoadLoad
-	ba,a,pt		%xcc, 4b
-__write_wait_for_any:
-	lduw		[%o0], %g5
-	brnz,pt		%g5, __write_wait_for_any
-	 membar		#LoadLoad
-	ba,a,pt		%xcc, 4f
-
-	.align		64
-	.globl		__write_unlock
-__write_unlock: /* %o0 = lock_ptr */
-	membar		#LoadStore | #StoreStore
-	retl
-	 stw		%g0, [%o0]
-
-	.globl		__write_lock
-__write_lock: /* %o0 = lock_ptr */
-	sethi		%hi(0x80000000), %g2
-
-1:	lduw		[%o0], %g5
-	brnz,pn		%g5, __write_wait_for_any
-4:	 or		%g5, %g2, %g7
-	cas		[%o0], %g5, %g7
-
-	cmp		%g5, %g7
-	be,pt		%icc, 99b
-	 membar		#StoreLoad | #StoreStore
-	ba,a,pt		%xcc, 1b
-
-	.globl		__write_trylock
-__write_trylock: /* %o0 = lock_ptr */
-	sethi		%hi(0x80000000), %g2
-1:	lduw		[%o0], %g5
-	brnz,pn		%g5, __write_trylock_fail
-4:	 or		%g5, %g2, %g7
-
-	cas		[%o0], %g5, %g7
-	cmp		%g5, %g7
-	be,pt		%icc, __write_trylock_succeed
-	 membar		#StoreLoad | #StoreStore
-
-	ba,pt		%xcc, 1b
-	 nop
-__write_trylock_succeed:
-	retl
-	 mov		1, %o0
-
-__write_trylock_fail:
-	retl
-	 mov		0, %o0
-
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/splock.S
===================================================================
RCS file: linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/splock.S
diff -N linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/splock.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc64/lib/splock.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,39 +0,0 @@
-/* splock.S: Spinlock primitives too large to inline.
- *
- * Copyright (C) 2004 David S. Miller (davem@redhat.com)
- */
-
-	.text
-	.align	64
-
-	.globl		_raw_spin_lock
-	.type		_raw_spin_lock,#function
-_raw_spin_lock:		/* %o0 = lock_ptr */
-1:	ldstub		[%o0], %g7
-	brnz,pn		%g7, 2f
-	 membar		#StoreLoad | #StoreStore
-	retl
-	 nop
-2:	ldub		[%o0], %g7
-	brnz,pt		%g7, 2b
-	 membar		#LoadLoad
-	ba,a,pt		%xcc, 1b
-	.size		_raw_spin_lock, .-_raw_spin_lock
-
-	.globl		_raw_spin_lock_flags
-	.type		_raw_spin_lock_flags,#function
-_raw_spin_lock_flags:	/* %o0 = lock_ptr, %o1 = irq_flags */
-1:	ldstub		[%o0], %g7
-	brnz,pn		%g7, 2f
-	 membar		#StoreLoad | #StoreStore
-	retl
-	 nop
-
-2:	rdpr		%pil, %g2		! Save PIL
-	wrpr		%o1, %pil		! Set previous PIL
-3:	ldub		[%o0], %g7		! Spin on lock set
-	brnz,pt		%g7, 3b
-	 membar		#LoadLoad
-	ba,pt		%xcc, 1b		! Retry lock acquire
-	 wrpr		%g2, %pil		! Restore PIL
-	.size		_raw_spin_lock_flags, .-_raw_spin_lock_flags
Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-sparc64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/ptrace.h	3 Sep 2004 01:30:43 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/ptrace.h	3 Sep 2004 23:55:27 -0000
@@ -98,7 +98,11 @@ struct sparc_trapf {
 	set_thread_flag(TIF_SYSCALL_SUCCESS)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
+#endif
 extern void show_regs(struct pt_regs *);
 #endif

Index: linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/include/asm-sparc64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/spinlock.h	3 Sep 2004 01:30:43 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/include/asm-sparc64/spinlock.h	3 Sep 2004 23:55:27 -0000
@@ -41,8 +41,20 @@ typedef unsigned char spinlock_t;
 do {	membar("#LoadLoad");	\
 } while(*((volatile unsigned char *)lock))

-/* arch/sparc64/lib/spinlock.S */
-extern void _raw_spin_lock(spinlock_t *lock);
+static __inline__ void _raw_spin_lock(spinlock_t *lock)
+{
+
+	__asm__ __volatile__("1: ldstub	[%0], %%g7\n\t"
+			     "brnz,pn	%%g7, 2f\n\t"
+			     "membar	#StoreLoad | #StoreStore\n\t"
+			     "b 3f\n\t"
+			     "2: ldub	[%0], %%g7\n\t"
+			     "brnz,pt	%%g7, 2b\n\t"
+			     "membar	#LoadLoad\n\t"
+			     "ba,a,pt	%%xcc, 1b\n\t"
+			     "3:\n\t"
+			     : : "r" (lock) : "memory");
+}

 static __inline__ int _raw_spin_trylock(spinlock_t *lock)
 {
@@ -64,7 +76,22 @@ static __inline__ void _raw_spin_unlock(
 			     : "memory");
 }

-extern void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags);
+static __inline__ void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
+{
+	__asm__ __volatile__ ("1:ldstub	[%0], %%g7\n\t"
+			      "brnz,pn	%%g7, 2f\n\t"
+			      "membar	#StoreLoad | #StoreStore\n\t"
+			      "b 4f\n\t"
+			      "2: rdpr	%%pil, %%g2	! Save PIL\n\t"
+			      "wrpr	%1, %%pil	! Set previous PIL\n\t"
+			      "3:ldub	[%0], %%g7	! Spin on lock set\n\t"
+			      "brnz,pt	%%g7, 3b\n\t"
+			      "membar	#LoadLoad\n\t"
+			      "ba,pt	%%xcc, 1b	! Retry lock acquire\n\t"
+			      "wrpr	%%g2, %%pil	! Restore PIL\n\t"
+			      "4:\n\t"
+				: : "r"(lock), "r"(flags) : "memory");
+}

 #else /* !(CONFIG_DEBUG_SPINLOCK) */

@@ -86,9 +113,9 @@ do { \

 extern void _do_spin_lock (spinlock_t *lock, char *str);
 extern void _do_spin_unlock (spinlock_t *lock);
-extern int _spin_trylock (spinlock_t *lock);
+extern int _do_spin_trylock (spinlock_t *lock);

-#define _raw_spin_trylock(lp)	_spin_trylock(lp)
+#define _raw_spin_trylock(lp)	_do_spin_trylock(lp)
 #define _raw_spin_lock(lock)	_do_spin_lock(lock, "spin_lock")
 #define _raw_spin_unlock(lock)	_do_spin_unlock(lock)
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -104,11 +131,86 @@ typedef unsigned int rwlock_t;
 #define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x) (*(x) != RW_LOCK_UNLOCKED)

-extern void __read_lock(rwlock_t *);
-extern void __read_unlock(rwlock_t *);
-extern void __write_lock(rwlock_t *);
-extern void __write_unlock(rwlock_t *);
-extern int __write_trylock(rwlock_t *);
+static void __inline__ __read_lock(rwlock_t *lock)
+{
+	__asm__ __volatile__ ("b 1f\n\t"
+			      "99:\n\t"
+			      "ldsw	[%0], %%g5\n\t"
+			      "brlz,pt	%%g5, 99b\n\t"
+			      "membar	#LoadLoad\n\t"
+			      "ba,a,pt	%%xcc, 4f\n\t"
+			      "1: ldsw	[%0], %%g5\n\t"
+			      "brlz,pn	%%g5, 99b\n\t"
+			      "4:add	%%g5, 1, %%g7\n\t"
+			      "cas	[%0], %%g5, %%g7\n\t"
+			      "cmp	%%g5, %%g7\n\t"
+			      "bne,pn	%%icc, 1b\n\t"
+			      "membar	#StoreLoad | #StoreStore\n\t"
+				: : "r"(lock) : "memory");
+}
+
+static void __inline__ __read_unlock(rwlock_t *lock)
+{
+	__asm__ __volatile__ ("1: lduw	[%0], %%g5\n\t"
+			      "sub	%%g5, 1, %%g7\n\t"
+			      "cas	[%0], %%g5, %%g7\n\t"
+			      "cmp	%%g5, %%g7\n\t"
+			      "be,pt	%%xcc, 2f\n\t"
+			      "membar	#StoreLoad | #StoreStore\n\t"
+			      "ba,a,pt	%%xcc, 1b\n\t"
+			      "2:\n\t"
+				: : "r" (lock) : "memory");
+}
+
+static void __inline__ __write_lock(rwlock_t *lock)
+{
+	__asm__ __volatile__ ("sethi	%%hi(0x80000000), %%g2\n\t"
+			      "b 1f\n\t"
+			      "99:\n\t"
+			      "lduw	[%0], %%g5\n\t"
+			      "brnz,pt	%%g5, 99b\n\t"
+			      "membar	#LoadLoad\n\t"
+			      "ba,a,pt	%%xcc, 4f\n\t"
+			      "1: lduw	[%0], %%g5\n\t"
+			      "brnz,pn	%%g5, 99b\n\t"
+			      "4: or	%%g5, %%g2, %%g7\n\t"
+			      "cas	[%0], %%g5, %%g7\n\t"
+			      "cmp	%%g5, %%g7\n\t"
+			      "be,pt	%%icc, 2f\n\t"
+			      "membar	#StoreLoad | #StoreStore\n\t"
+			      "ba,a,pt	%%xcc, 1b\n\t"
+			      "2:\n\t"
+				: : "r"(lock) : "memory");
+}
+
+static void __inline__ __write_unlock(rwlock_t *lock)
+{
+	__asm__ __volatile__ ("membar	#LoadStore | #StoreStore\n\t"
+			      "retl\n\t"
+			      "stw	%%g0, [%0]\n\t"
+				: : "r"(lock) : "memory");
+}
+
+static int __inline__ __write_trylock(rwlock_t *lock)
+{
+	__asm__ __volatile__ ("sethi	%%hi(0x80000000), %%g2\n\t"
+			      "1: lduw	[%0], %%g5\n\t"
+			      "brnz,pn	%%g5, 100f\n\t"
+			      "4: or	%%g5, %%g2, %%g7\n\t"
+			      "cas	[%0], %%g5, %%g7\n\t"
+			      "cmp	%%g5, %%g7\n\t"
+			      "be,pt	%%icc, 99f\n\t"
+			      "membar	#StoreLoad | #StoreStore\n\t"
+			      "ba,pt	%%xcc, 1b\n\t"
+			      "99:\n\t"
+			      "retl\n\t"
+			      "mov	1, %0\n\t"
+			      "100:\n\t"
+			      "retl\n\t"
+			      "mov	0, %0\n\t"
+				: : "r"(lock) : "memory");
+	return rwlock_is_locked(lock);
+}

 #define _raw_read_lock(p)	__read_lock(p)
 #define _raw_read_unlock(p)	__read_unlock(p)
