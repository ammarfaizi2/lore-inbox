Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUHHEqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUHHEqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHHEqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:46:33 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64253 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265098AbUHHEqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:46:09 -0400
Date: Sun, 8 Aug 2004 00:49:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pulled from the -tiny tree, the focus of this patch is for reduced kernel
image size but in the process we benefit from improved cache performance
since it's possible for the common text to be present in cache. This is
probably more of a win on shared cache multiprocessor systems like
P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
ideal target would be a 4x+ logical cpu Xeon).

The bonnie++ results are here, the hostnames are of the form stpN-000 with
N denoting how many processors in the system. In a nutshell there doesn't
appear to be any performance regressions.

http://www.zwane.ca/results/cool-locks-stp

   text    data     bss     dec     hex filename
5527214  873510  321872 6722596  669424 vmlinux-before
5480308  867964  321872 6670144  65c740 vmlinux-after

 arch/i386/Kconfig             |   10 +++++++
 arch/i386/kernel/i386_ksyms.c |   11 ++++++++
 arch/i386/lib/Makefile        |    1
 arch/i386/lib/spinlock.c      |   57 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/spinlock.h   |   22 ++++++++++++++--
 5 files changed, 99 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc3-mm1/arch/i386/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/i386/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.8-rc3-mm1/arch/i386/Kconfig	5 Aug 2004 16:37:39 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1/arch/i386/Kconfig	7 Aug 2004 23:07:05 -0000
@@ -1262,6 +1262,16 @@ config DEBUG_SPINLOCK
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.

+config COOL_SPINLOCK
+	bool "Completely out of line spinlocks"
+	depends on SMP
+	default y
+	help
+          Say Y here to build spinlocks which have common text for contended
+          and uncontended paths. This reduces kernel text size by at least
+          50k on most configurations, plus there is the additional benefit
+          of better cache utilisation.
+
 config DEBUG_PAGEALLOC
 	bool "Page alloc debugging"
 	depends on DEBUG_KERNEL
Index: linux-2.6.8-rc3-mm1/arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i386_ksyms.c
--- linux-2.6.8-rc3-mm1/arch/i386/kernel/i386_ksyms.c	5 Aug 2004 16:37:39 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1/arch/i386/kernel/i386_ksyms.c	7 Aug 2004 22:51:22 -0000
@@ -51,6 +51,17 @@ extern void FASTCALL( __write_lock_faile
 extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
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
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
 extern struct drive_info_struct drive_info;
 EXPORT_SYMBOL(drive_info);
Index: linux-2.6.8-rc3-mm1/arch/i386/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/arch/i386/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.8-rc3-mm1/arch/i386/lib/Makefile	5 Aug 2004 16:37:39 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1/arch/i386/lib/Makefile	7 Aug 2004 22:51:37 -0000
@@ -6,6 +6,7 @@
 lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
 	bitops.o

+lib-$(CONFIG_COOL_SPINLOCK) += spinlock.o
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
Index: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
===================================================================
RCS file: linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
diff -N linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c	8 Aug 2004 01:53:01 -0000
@@ -0,0 +1,57 @@
+#define PROC(name)	\
+	".align 4\n" \
+	".globl " #name"\n" \
+	#name":\n"
+
+asm (PROC(__spin_lock_failed_flags)
+	"testl $0x200, %ebx\n"
+	"jz 1f\n"
+	"sti\n"
+	"1:\n\t"
+	"rep; nop\n"
+	"cmpb $0, (%eax)\n"
+	"jle 1b\n"
+	"cli\n"
+	"lock; decb (%eax)\n\t"
+	"js __spin_lock_failed_flags\n\t"
+	"nop\n\t"
+	"ret\n"
+);
+
+asm (PROC(__spin_lock_loop_flags)
+	"lock; decb (%eax)\n\t"
+	"js 1f\n\t"
+	"nop\n\t"
+	"ret\n\t"
+	"1:\n\t"
+	"testl $0x200, %ebx\n\t"
+	"jz 1f\n\t"
+	"sti\n\t"
+	"2: rep; nop\n\t"
+	"cmpb $0, (%eax)\n\t"
+	"jle 2b\n\t"
+	"cli\n\t"
+	"jmp __spin_lock_loop_flags\n\t"
+);
+
+asm (PROC(__spin_lock_failed)
+	"rep; nop\n\t"
+	"cmpb $0, (%eax)\n\t"
+	"jle __spin_lock_failed\n\t"
+	"lock; decb (%eax)\n\t"
+	"js __spin_lock_failed\n\t"
+	"nop\n\t"
+	"ret\n\t"
+);
+
+asm (PROC(__spin_lock_loop)
+	"lock; decb (%eax)\n\t"
+	"js 1f\n\t"
+	"nop\n\t"
+	"ret\n\t"
+	"1: rep; nop\n\t"
+	"cmpb $0, (%eax)\n\t"
+	"jle 1b\n\t"
+	"jmp __spin_lock_loop\n\t"
+);
+
Index: linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h	5 Aug 2004 16:37:51 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h	7 Aug 2004 22:56:46 -0000
@@ -43,6 +43,13 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

+#ifdef CONFIG_COOL_SPINLOCK
+	#define spin_lock_string \
+		"call __spin_lock_loop\n\t"
+
+	#define spin_lock_string_flags \
+		"call __spin_lock_loop_flags\n\t"
+#else
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
@@ -71,6 +78,7 @@ typedef struct {
 	"cli\n\t" \
 	"jmp 1b\n" \
 	LOCK_SECTION_END
+#endif

 /*
  * This works. Despite all the confusion.
@@ -139,7 +147,12 @@ here:
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
@@ -154,7 +167,12 @@ here:
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+#ifdef CONFIG_COOL_SPINLOCK
+		: : "a" (&lock->lock), "b" (flags) : "memory"
+#else
+		:"=m" (lock->lock) : "r" (flags) : "memory"
+#endif
+	);
 }

 /*
