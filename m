Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUG1B1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUG1B1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUG1B1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:27:18 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60634 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266753AbUG1B0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:26:54 -0400
Date: Tue, 27 Jul 2004 21:30:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Keith Owens <kaos@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
In-Reply-To: <21964.1090974908@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.58.0407272041370.932@montezuma.fsmlabs.com>
References: <21964.1090974908@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Keith Owens wrote:

> I consolidated the spinlock contention path to a single routine on
> ia64, with big space savings.  The problem with the ia64 consolidation
> was backtracing through a contended lock; the ia64 unwind API is not
> designed for code that is shared between multiple code paths but uses
> non-standard entry and exit conventions.  In the end, David Mosberger
> did a patch to gcc to do lightweight calls to the out of line
> contention code, just to get reliable backtraces.
>
> kdb has workarounds for backtracing through ia64 contended locks when
> the kernel is built with older versions of gcc.  gdb (and hence kgdb)
> has no idea about the special out of line code.  Mind you, the same is
> true right now with the out of line i386 code, you need special
> heuristics to backtrace the existing spinlock code reliably.  That will
> only get worse with Zwane's patch, interrupts can now occur in the out
> of line code.
>
> Are you are planning to consolidate the out of line code for i386?  Is
> there a patch (even work in progress) so I can start thinking about
> doing reliable backtraces?

Another problem i ran into was profiling contended locks. Here is a patch
(against 2.6.8-rc2, should apply to recent -mm) which does completely out
of line spinlocks on i386 with shared lock text, it's stable and has been
tested on 32x. This patch can be modified so that we have the entire
spinlock text out of line or simply during contention, the former has
significantly more space savings, something like;

   text    data     bss     dec     hex filename
5437496  831862  323792 6593150  649a7e vmlinux-ool
5449254  834525  323792 6607571  64d2d3 vmlinux-before
5431258  831862  323792 6586912  648220 vmlinux-cool

-ool is only the contended path out of line in shared text, -before is
mainline and -cool is completely out of line shared spinlock text.

Index: linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i386_ksyms.c
--- linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c	20 Jul 2004 18:14:54 -0000	1.1.1.1
+++ linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c	28 Jul 2004 00:29:05 -0000
@@ -49,6 +49,14 @@ EXPORT_SYMBOL(default_idle);
 #ifdef CONFIG_SMP
 extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
 extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
+extern void asmlinkage __spin_lock_failed(spinlock_t *);
+extern void asmlinkage __spin_lock_failed_flags(spinlock_t *, unsigned long);
+extern void asmlinkage __spin_lock_loop(spinlock_t *);
+extern void asmlinkage __spin_lock_loop_flags(spinlock_t *, unsigned long);
+EXPORT_SYMBOL(__spin_lock_failed);
+EXPORT_SYMBOL(__spin_lock_failed_flags);
+EXPORT_SYMBOL(__spin_lock_loop);
+EXPORT_SYMBOL(__spin_lock_loop_flags);
 #endif

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
Index: linux-2.6.8-rc2/arch/i386/lib/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2/arch/i386/lib/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.8-rc2/arch/i386/lib/Makefile	20 Jul 2004 18:14:54 -0000	1.1.1.1
+++ linux-2.6.8-rc2/arch/i386/lib/Makefile	28 Jul 2004 00:29:05 -0000
@@ -6,5 +6,6 @@
 lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
 	bitops.o

+lib-$(CONFIG_SMP) += spinlock.o
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
Index: linux-2.6.8-rc2/arch/i386/lib/spinlock.c
===================================================================
RCS file: linux-2.6.8-rc2/arch/i386/lib/spinlock.c
diff -N linux-2.6.8-rc2/arch/i386/lib/spinlock.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.8-rc2/arch/i386/lib/spinlock.c	28 Jul 2004 00:29:05 -0000
@@ -0,0 +1,53 @@
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
+	"ret\n"
+);
+
+asm (PROC(__spin_lock_loop_flags)
+	"lock; decb (%eax)\n\t"
+	"js 1f\n\t"
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
+	"ret\n\t"
+);
+
+asm (PROC(__spin_lock_loop)
+	"lock; decb (%eax)\n\t"
+	"js 1f\n\t"
+	"ret\n\t"
+	"1: rep; nop\n\t"
+	"cmpb $0, (%eax)\n\t"
+	"jle 1b\n\t"
+	"jmp __spin_lock_loop\n\t"
+);
+
Index: linux-2.6.8-rc2/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.8-rc2/include/asm-i386/spinlock.h	20 Jul 2004 18:15:14 -0000	1.1.1.1
+++ linux-2.6.8-rc2/include/asm-i386/spinlock.h	28 Jul 2004 00:37:44 -0000
@@ -43,34 +43,25 @@ typedef struct {
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))

-#define spin_lock_string \
-	"\n1:\t" \
-	"lock ; decb %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"rep;nop\n\t" \
-	"cmpb $0,%0\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
-
-#define spin_lock_string_flags \
-	"\n1:\t" \
-	"lock ; decb %0\n\t" \
-	"js 2f\n\t" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"testl $0x200, %1\n\t" \
-	"jz 3f\n\t" \
-	"sti\n\t" \
-	"3:\t" \
-	"rep;nop\n\t" \
-	"cmpb $0, %0\n\t" \
-	"jle 3b\n\t" \
-	"cli\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
+#if 0
+	#define spin_lock_string \
+		"lock ; decb (%0)\n\t" \
+		"jns 1f\n\t" \
+		"call __spin_lock_failed\n\t" \
+		"1:\n\t"
+
+	#define spin_lock_string_flags \
+		"lock ; decb (%0)\n\t" \
+		"jns 1f\n\t" \
+		"call __spin_lock_failed_flags\n\t" \
+		"1:\n\t"
+#else
+	#define spin_lock_string \
+		"call __spin_lock_loop\n\t"
+
+	#define spin_lock_string_flags \
+		"call __spin_lock_loop_flags\n\t"
+#endif

 /*
  * This works. Despite all the confusion.
@@ -139,7 +130,7 @@ here:
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		: : "a" (&lock->lock) : "memory");
 }

 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -154,7 +145,7 @@ here:
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+		: : "a" (&lock->lock), "b" (flags) : "memory");
 }

 /*
