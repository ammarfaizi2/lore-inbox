Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUHHErV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUHHErV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHHEq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:46:59 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65277 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265099AbUHHEqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:46:15 -0400
Date: Sun, 8 Aug 2004 00:50:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][2.6] Completely out of line spinlocks / x86_64
Message-ID: <Pine.LNX.4.58.0408072217170.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pulled from the -tiny tree, the focus of this patch is for reduced kernel
image size, the shared spinlock text may be more of a benefit later on
when multicore packages with shared caches arrive but should benefit
em64t systems with HT enabled. I've set the config option to y so
that it gets a bit of runtime, but it can be left as a config option.

Tested on 4x logical em64t.

   text    data     bss     dec     hex filename
3870057 1350301  508048 5728406  576896 vmlinux-after
3885801 1352134  508048 5745983  57ad3f vmlinux-before

 arch/x86_64/Kconfig              |   10 ++++++
 arch/x86_64/kernel/x8664_ksyms.c |   11 +++++++
 arch/x86_64/lib/Makefile         |    1
 arch/x86_64/lib/spinlock.c       |   57 +++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/spinlock.h    |   22 +++++++++++++--
 5 files changed, 99 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	5 Aug 2004 16:37:48 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/Kconfig	7 Aug 2004 22:47:30 -0000
@@ -438,6 +438,16 @@ config DEBUG_SPINLOCK
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.

+config COOL_SPINLOCK
+	bool "Completely out of line spinlocks"
+	depends on SMP
+	default y
+	help
+	  Say Y here to build spinlocks which have common text for contended
+	  and uncontended paths. This reduces kernel text size by at least
+	  50k on most configurations, plus there is the additional benefit
+	  of better cache utilisation.
+
 # !SMP for now because the context switch early causes GPF in segment reloading
 # and the GS base checking does the wrong thing then, causing a hang.
 config CHECKING
Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/kernel/x8664_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 x8664_ksyms.c
--- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/x8664_ksyms.c	5 Aug 2004 16:37:48 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/x8664_ksyms.c	7 Aug 2004 22:41:34 -0000
@@ -220,3 +220,14 @@ EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif

+#ifdef CONFIG_COOL_SPINLOCK
+extern void asmlinkage __spin_lock_failed(spinlock_t *);
+extern void asmlinkage __spin_lock_failed_flags(spinlock_t *, unsigned long);
+extern void asmlinkage __spin_lock_loop(spinlock_t *);
+extern void asmlinkage __spin_lock_loop_flags(spinlock_t *, unsigned long);
+EXPORT_SYMBOL(__spin_lock_failed);
+EXPORT_SYMBOL(__spin_lock_failed_flags);
+EXPORT_SYMBOL(__spin_lock_loop);
+EXPORT_SYMBOL(__spin_lock_loop_flags);
+#endif
+
Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/Makefile	5 Aug 2004 16:37:48 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/Makefile	7 Aug 2004 22:32:44 -0000
@@ -13,3 +13,4 @@ lib-y += memcpy.o memmove.o memset.o cop

 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
+lib-$(CONFIG_COOL_SPINLOCK) += spinlock.o
Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
===================================================================
RCS file: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
diff -N linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/lib/spinlock.c	7 Aug 2004 23:00:34 -0000
@@ -0,0 +1,57 @@
+#define PROC(name)	\
+	".align 4\n"	\
+	".globl " #name"\n" \
+	#name":\n"
+
+asm (PROC(__spin_lock_failed_flags)
+	"test $0x200, %rbx\n"
+	"jz 1f\n"
+	"sti\n"
+	"1:\n\t"
+	"rep; nop\n"
+	"cmpb $0, (%rax)\n"
+	"jle 1b\n"
+	"cli\n"
+	"lock; decb (%rax)\n\t"
+	"js __spin_lock_failed_flags\n\t"
+	"nop\n"
+	"ret\n"
+);
+
+asm (PROC(__spin_lock_loop_flags)
+	"lock; decb (%rax)\n\t"
+	"js 1f\n\t"
+	"nop\n\t"
+	"ret\n\t"
+	"1:\n\t"
+	"test $0x200, %rbx\n\t"
+	"jz 1f\n\t"
+	"sti\n\t"
+	"2: rep; nop\n\t"
+	"cmpb $0, (%rax)\n\t"
+	"jle 2b\n\t"
+	"cli\n\t"
+	"jmp __spin_lock_loop_flags\n\t"
+);
+
+asm (PROC(__spin_lock_failed)
+	"rep; nop\n\t"
+	"cmpb $0, (%rax)\n\t"
+	"jle __spin_lock_failed\n\t"
+	"lock; decb (%rax)\n\t"
+	"js __spin_lock_failed\n\t"
+	"nop\n\t"
+	"ret\n\t"
+);
+
+asm (PROC(__spin_lock_loop)
+	"lock; decb (%rax)\n\t"
+	"js 1f\n\t"
+	"nop\n\t"
+	"ret\n\t"
+	"1: rep; nop\n\t"
+	"cmpb $0, (%rax)\n\t"
+	"jle 1b\n\t"
+	"jmp __spin_lock_loop\n\t"
+);
+
Index: linux-2.6.8-rc3-mm1-amd64/include/asm-x86_64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/include/asm-x86_64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8-rc3-mm1-amd64/include/asm-x86_64/spinlock.h	5 Aug 2004 16:37:48 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1-amd64/include/asm-x86_64/spinlock.h	7 Aug 2004 22:48:13 -0000
@@ -42,6 +42,13 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

+#ifdef CONFIG_COOL_SPINLOCK
+#define spin_lock_string \
+	"call __spin_lock_loop\n\t"
+
+#define spin_lock_string_flags \
+	"call __spin_lock_loop_flags\n\t"
+#else
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
@@ -70,6 +77,7 @@ typedef struct {
 	"cli\n\t" \
 	"jmp 1b\n" \
 	LOCK_SECTION_END
+#endif

 /*
  * This works. Despite all the confusion.
@@ -138,7 +146,12 @@ printk("eip: %p\n", &&here);
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+#ifdef CONFIG_COOL_SPINLOCK
+		: : "a" (&lock->lock) : "memory"
+#else
+		:"=m" (lock->lock) : : "memory"
+#endif
+	);
 }

 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -152,7 +165,12 @@ here:
 	}
 #endif
 	__asm__ __volatile__(spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+#ifdef CONFIG_COOL_SPINLOCK
+		: : "a" (&lock->lock), "b" (flags) : "memory"
+#else
+		:"=m" (lock->lock) : "r" (flags) : "memory"
+#endif
+	);
 }


