Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUHLH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUHLH1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUHLHZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:25:41 -0400
Received: from holomorphy.com ([207.189.100.168]:60809 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268445AbUHLHXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:23:48 -0400
Date: Thu, 12 Aug 2004 00:23:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Keith Owens <kaos@ocs.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040812072338.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com> <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812072058.GH11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:20:58AM -0700, William Lee Irwin III wrote:
> Okay, the results on 2.6.8-rc4 (COOL had a bit of porting, basically
> dropping the hunks associated with spin_lock_flags_string or whatever
> it is). Chose the .config largely to be vaguely deterministic, but had
> to nuke the "System is too big" check in arch/x86_64/boot/tools/build.c.
> 
>               text    data     bss     dec     hex filename
> mainline: 20708323        6603052 1878448 29189823        1bd66bf vmlinux
> cool:     20619594        6588166 1878448 29086208        1bbd200 vmlinux
> C-func:   19969264        6583128 1878384 28430776        1b1d1b8 vmlinux
> x86-64, -O2, allyesconfig minus the following:
[...]

The precise COOL patch used:


Index: spinlock-2.6.8-rc4/arch/x86_64/Kconfig
===================================================================
--- spinlock-2.6.8-rc4.orig/arch/x86_64/Kconfig	2004-06-15 22:19:44.000000000 -0700
+++ spinlock-2.6.8-rc4/arch/x86_64/Kconfig	2004-08-11 22:24:47.944933072 -0700
@@ -436,6 +436,16 @@
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
Index: spinlock-2.6.8-rc4/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- spinlock-2.6.8-rc4.orig/arch/x86_64/kernel/x8664_ksyms.c	2004-08-10 23:00:19.712651608 -0700
+++ spinlock-2.6.8-rc4/arch/x86_64/kernel/x8664_ksyms.c	2004-08-11 22:24:47.944933072 -0700
@@ -218,3 +218,14 @@
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
Index: spinlock-2.6.8-rc4/arch/x86_64/lib/Makefile
===================================================================
--- spinlock-2.6.8-rc4.orig/arch/x86_64/lib/Makefile	2004-06-15 22:18:59.000000000 -0700
+++ spinlock-2.6.8-rc4/arch/x86_64/lib/Makefile	2004-08-11 22:25:22.127736496 -0700
@@ -12,3 +12,4 @@
 lib-y += memcpy.o memmove.o memset.o copy_user.o
 
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_COOL_SPINLOCK) += spinlock.o
Index: spinlock-2.6.8-rc4/arch/x86_64/lib/spinlock.c
===================================================================
--- spinlock-2.6.8-rc4.orig/arch/x86_64/lib/spinlock.c	2004-04-06 10:56:48.000000000 -0700
+++ spinlock-2.6.8-rc4/arch/x86_64/lib/spinlock.c	2004-08-11 22:24:47.945932920 -0700
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
Index: spinlock-2.6.8-rc4/include/asm-x86_64/spinlock.h
===================================================================
--- spinlock-2.6.8-rc4.orig/include/asm-x86_64/spinlock.h	2004-06-15 22:20:04.000000000 -0700
+++ spinlock-2.6.8-rc4/include/asm-x86_64/spinlock.h	2004-08-11 22:24:47.945932920 -0700
@@ -43,6 +43,13 @@
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
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
@@ -54,6 +61,7 @@
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
 	LOCK_SECTION_END
+#endif
 
 /*
  * This works. Despite all the confusion.
@@ -122,7 +130,12 @@
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
 
 
