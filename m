Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUHUSYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUHUSYb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267606AbUHUSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:24:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:49139 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267557AbUHUSYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:24:22 -0400
Date: Sat, 21 Aug 2004 14:28:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][1/4] Completely out of line spinlocks / i386
Message-ID: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- from previous announce --
Pulled from the -tiny tree, the focus of this patch is for reduced kernel
image size but in the process we benefit from improved cache performance
since it's possible for the common text to be present in cache. This is
probably more of a win on shared cache multiprocessor systems like
P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
ideal target would be a 4x+ logical cpu Xeon).
--

Changes have been made based on feedback from various people, most notably
profiling support for readprofile and oprofile.

 arch/i386/Kconfig.debug       |   10 ++++++++++
 arch/i386/kernel/i386_ksyms.c |    5 +++++
 arch/i386/lib/Makefile        |    1 +
 arch/i386/lib/spinlock.S      |   33 +++++++++++++++++++++++++++++++++
 include/asm-i386/spinlock.h   |   27 +++++++++++++++++++++++++--
 5 files changed, 74 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8.1-mm3/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8.1-mm3/include/asm-i386/spinlock.h	21 Aug 2004 13:15:01 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/include/asm-i386/spinlock.h	21 Aug 2004 16:14:44 -0000
@@ -43,6 +43,18 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

+#ifdef CONFIG_COOL_SPINLOCK
+extern void __spin_lock_loop(void);
+extern void __spin_lock_loop_flags(void);
+extern unsigned long start_spin_lock_text;
+extern unsigned long end_spin_lock_text;
+
+	#define spin_lock_string \
+		"call __spin_lock_loop\n\t"
+
+	#define spin_lock_string_flags \
+		"call __spin_lock_loop_flags\n\t"
+#else
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
@@ -71,6 +83,7 @@ typedef struct {
 	"cli\n\t" \
 	"jmp 1b\n" \
 	LOCK_SECTION_END
+#endif

 /*
  * This works. Despite all the confusion.
@@ -139,7 +152,12 @@ here:
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
@@ -154,7 +172,12 @@ here:
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+#ifdef CONFIG_COOL_SPINLOCK
+		: : "a" (&lock->lock), "d" (flags) : "memory"
+#else
+		:"=m" (lock->lock) : "r" (flags) : "memory"
+#endif
+	);
 }

 /*
Index: linux-2.6.8.1-mm3/arch/i386/Kconfig.debug
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/Kconfig.debug,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig.debug
--- linux-2.6.8.1-mm3/arch/i386/Kconfig.debug	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/Kconfig.debug	21 Aug 2004 16:01:47 -0000
@@ -74,6 +74,16 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.

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
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
Index: linux-2.6.8.1-mm3/arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i386_ksyms.c
--- linux-2.6.8.1-mm3/arch/i386/kernel/i386_ksyms.c	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/kernel/i386_ksyms.c	21 Aug 2004 16:17:00 -0000
@@ -57,6 +57,11 @@ extern struct drive_info_struct drive_in
 EXPORT_SYMBOL(drive_info);
 #endif

+#ifdef CONFIG_COOL_SPINLOCK
+EXPORT_SYMBOL(__spin_lock_loop);
+EXPORT_SYMBOL(__spin_lock_loop_flags);
+#endif
+
 extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);

Index: linux-2.6.8.1-mm3/arch/i386/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.8.1-mm3/arch/i386/lib/Makefile	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/lib/Makefile	21 Aug 2004 15:43:31 -0000
@@ -6,6 +6,7 @@
 lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
 	bitops.o

+lib-$(CONFIG_COOL_SPINLOCK) += spinlock.o
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 lib-$(CONFIG_KGDB) += kgdb_serial.o
Index: linux-2.6.8.1-mm3/arch/i386/lib/spinlock.S
===================================================================
RCS file: linux-2.6.8.1-mm3/arch/i386/lib/spinlock.S
diff -N linux-2.6.8.1-mm3/arch/i386/lib/spinlock.S
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.8.1-mm3/arch/i386/lib/spinlock.S	21 Aug 2004 15:52:13 -0000
@@ -0,0 +1,33 @@
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+.globl start_spin_lock_text
+start_spin_lock_text:
+
+ENTRY(__spin_lock_loop_flags)
+	lock; decb (%eax)
+	js 1f
+	nop
+	ret
+	1:
+	testl $0x200, %edx
+	jz 1f
+	sti
+	2: rep; nop
+	cmpb $0, (%eax)
+	jle 2b
+	cli
+	jmp __spin_lock_loop_flags
+
+ENTRY(__spin_lock_loop)
+	lock; decb (%eax)
+	js 1f
+	nop
+	ret
+	1: rep; nop
+	cmpb $0, (%eax)
+	jle 1b
+	jmp __spin_lock_loop
+
+.globl end_spin_lock_text
+end_spin_lock_text:
