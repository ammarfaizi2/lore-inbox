Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUHUSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUHUSYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUHUSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:24:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:50419 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267583AbUHUSY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:24:27 -0400
Date: Sat, 21 Aug 2004 14:28:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][2/4] Completely out of line spinlocks / x86_64
Message-ID: <Pine.LNX.4.58.0408211331120.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

 arch/x86_64/Kconfig.debug        |   10 ++++++++++
 arch/x86_64/kernel/x8664_ksyms.c |    4 ++++
 arch/x86_64/lib/Makefile         |    1 +
 arch/x86_64/lib/spinlock.S       |   33 +++++++++++++++++++++++++++++++++
 include/asm-x86_64/spinlock.h    |   27 +++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 2 deletions(-)

Index: linux-2.6.8.1-mm3/include/asm-x86_64/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/include/asm-x86_64/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8.1-mm3/include/asm-x86_64/spinlock.h	21 Aug 2004 13:15:02 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/include/asm-x86_64/spinlock.h	21 Aug 2004 16:15:58 -0000
@@ -42,6 +42,18 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

+#ifdef CONFIG_COOL_SPINLOCK
+extern void __spin_lock_loop(void);
+extern void __spin_lock_loop_flags(void);
+extern unsigned long start_spin_lock_text;
+extern unsigned long end_spin_lock_text;
+
+#define spin_lock_string \
+	"call __spin_lock_loop\n\t"
+
+#define spin_lock_string_flags \
+	"call __spin_lock_loop_flags\n\t"
+#else
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
@@ -70,6 +82,7 @@ typedef struct {
 	"cli\n\t" \
 	"jmp 1b\n" \
 	LOCK_SECTION_END
+#endif

 /*
  * This works. Despite all the confusion.
@@ -138,7 +151,12 @@ printk("eip: %p\n", &&here);
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
@@ -152,7 +170,12 @@ here:
 	}
 #endif
 	__asm__ __volatile__(spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+#ifdef CONFIG_COOL_SPINLOCK
+		: : "a" (&lock->lock), "d" (flags) : "memory"
+#else
+		:"=m" (lock->lock) : "r" (flags) : "memory"
+#endif
+	);
 }


Index: linux-2.6.8.1-mm3/arch/x86_64/Kconfig.debug
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/x86_64/Kconfig.debug,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig.debug
--- linux-2.6.8.1-mm3/arch/x86_64/Kconfig.debug	21 Aug 2004 13:14:53 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/x86_64/Kconfig.debug	21 Aug 2004 16:02:30 -0000
@@ -39,6 +39,16 @@ config FRAME_POINTER
 	 consistent frame pointer through inline assembly (semaphores etc.)
 	 Normally you should say N.

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
 config IOMMU_DEBUG
        depends on GART_IOMMU && DEBUG_KERNEL
        bool "Enable IOMMU debugging"
Index: linux-2.6.8.1-mm3/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/x86_64/kernel/x8664_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 x8664_ksyms.c
--- linux-2.6.8.1-mm3/arch/x86_64/kernel/x8664_ksyms.c	21 Aug 2004 13:14:53 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/x86_64/kernel/x8664_ksyms.c	21 Aug 2004 16:16:20 -0000
@@ -46,6 +46,10 @@ extern struct drive_info_struct drive_in
 EXPORT_SYMBOL(drive_info);
 #endif

+#ifdef CONFIG_COOL_SPINLOCK
+EXPORT_SYMBOL(__spin_lock_loop);
+EXPORT_SYMBOL(__spin_lock_loop_flags);
+#endif
 extern unsigned long get_cmos_time(void);

 /* platform dependent support */
Index: linux-2.6.8.1-mm3/arch/x86_64/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/x86_64/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.8.1-mm3/arch/x86_64/lib/Makefile	21 Aug 2004 13:14:53 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/x86_64/lib/Makefile	21 Aug 2004 15:43:35 -0000
@@ -13,3 +13,4 @@ lib-y += memcpy.o memmove.o memset.o cop

 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
+lib-$(CONFIG_COOL_SPINLOCK) += spinlock.o
Index: linux-2.6.8.1-mm3/arch/x86_64/lib/spinlock.S
===================================================================
RCS file: linux-2.6.8.1-mm3/arch/x86_64/lib/spinlock.S
diff -N linux-2.6.8.1-mm3/arch/x86_64/lib/spinlock.S
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.8.1-mm3/arch/x86_64/lib/spinlock.S	21 Aug 2004 15:55:30 -0000
@@ -0,0 +1,33 @@
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+.globl start_spin_lock_text
+start_spin_lock_text:
+
+ENTRY(__spin_lock_loop_flags)
+	lock; decb (%rax)
+	js 1f
+	nop
+	ret
+	1:
+	test $0x200, %rbx
+	jz 1f
+	sti
+	2: rep; nop
+	cmpb $0, (%rax)
+	jle 2b
+	cli
+	jmp __spin_lock_loop_flags
+
+ENTRY(__spin_lock_loop)
+	lock; decb (%rax)
+	js 1f
+	nop
+	ret
+	1: rep; nop
+	cmpb $0, (%rax)
+	jle 1b
+	jmp __spin_lock_loop
+
+.globl end_spin_lock_text
+end_spin_lock_text:
