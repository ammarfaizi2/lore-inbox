Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUHHF4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUHHF4t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUHHF4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:56:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:43713 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264903AbUHHF4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:56:41 -0400
Date: Sun, 8 Aug 2004 02:00:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408072220490.1793@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408080143230.19619@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072157500.1793@ppc970.osdl.org>
 <Pine.LNX.4.58.0408080110280.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408072220490.1793@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Linus Torvalds wrote:

> On Sun, 8 Aug 2004, Zwane Mwaikambo wrote:
> > >
> > > that looks just broken.
> >
> > _raw_spin_lock will have the symbol __spin_lock_loop{,_flags} when used in
> > symbols, modules won't load otherwise.
>
> Yes, I was talking about the "failed" things only. The non-failure-cases
> obviously do have to be exported.

Thanks, here is a cleaned up version, we seem to have even managed to save
some text (~5k), gcc probably managed to do the asm call setup without too
much register shuffling. I still find the decrease in data odd.

   text    data     bss     dec     hex filename
5527214  873510  321872 6722596  669424 vmlinux-before
5480308  867964  321872 6670144  65c740 vmlinux-after
5474492  867930  321872 6664294  65b066 vmlinux-after2

 arch/i386/Kconfig           |   10 ++++++++++
 arch/i386/lib/Makefile      |    1 +
 arch/i386/lib/spinlock.c    |   38 ++++++++++++++++++++++++++++++++++++++
 include/asm-i386/spinlock.h |   22 ++++++++++++++++++++--
 4 files changed, 69 insertions(+), 2 deletions(-)

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
+++ linux-2.6.8-rc3-mm1/arch/i386/lib/spinlock.c	8 Aug 2004 05:39:13 -0000
@@ -0,0 +1,38 @@
+#include <linux/module.h>
+
+#define PROC(name)	\
+	".align 4\n" \
+	".globl " #name"\n" \
+	#name":\n"
+
+asm (PROC(__spin_lock_loop_flags)
+	"lock; decb (%eax)\n\t"
+	"js 1f\n\t"
+	"nop\n\t"
+	"ret\n\t"
+	"1:\n\t"
+	"testl $0x200, %edx\n\t"
+	"jz 1f\n\t"
+	"sti\n\t"
+	"2: rep; nop\n\t"
+	"cmpb $0, (%eax)\n\t"
+	"jle 2b\n\t"
+	"cli\n\t"
+	"jmp __spin_lock_loop_flags\n\t"
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
+void __spin_lock_loop_flags(void);
+void __spin_lock_loop(void);
+EXPORT_SYMBOL(__spin_lock_loop_flags);
+EXPORT_SYMBOL(__spin_lock_loop);
Index: linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h	5 Aug 2004 16:37:51 -0000	1.1.1.1
+++ linux-2.6.8-rc3-mm1/include/asm-i386/spinlock.h	8 Aug 2004 05:19:10 -0000
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
+		: : "a" (&lock->lock), "d" (flags) : "memory"
+#else
+		:"=m" (lock->lock) : "r" (flags) : "memory"
+#endif
+	);
 }

 /*
