Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129384AbRBKTGv>; Sun, 11 Feb 2001 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbRBKTGm>; Sun, 11 Feb 2001 14:06:42 -0500
Received: from colorfullife.com ([216.156.138.34]:6663 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129384AbRBKTGa>;
	Sun, 11 Feb 2001 14:06:30 -0500
Message-ID: <3A86E21D.9AB66964@colorfullife.com>
Date: Sun, 11 Feb 2001 20:03:57 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@fenrus.demon.nl>,
        Doug Ledford <dledford@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC] framework for fpu usage in kernel
Content-Type: multipart/mixed;
 boundary="------------94B0BE0A78358BD8076B0052"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------94B0BE0A78358BD8076B0052
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Currently there are 2 fpu users in the kernel:
raid5 checksumming and 3dnow memcpy/memset.

raid5 checksumming is not problematic, but _mmx_memcpy() has unexpected
side effects if someone else is also using the fpu:
memcopy is a really generic function, and calling it saves the current
fpu state into thread.i387.f{,x}save. IMHO that's wrong, memcopy must
save into a local buffer like raid5 checksumming.

I've attached a proposal that supports arbitrary combinations of fpu
users in kernel space.

* kernel threads can use the fpu freely. Nothing new.
* 2 sets of functions for fpu usage in "normal" threads:

- kfpu_acquire(), kfpu_try_acquire() + release functions.

- kfpu_full_begin(), kfpu_mmx_begin(), kfpu_nosave_begin(),
kfpu_try_begin() + _end() functions.

The first set is only possible from normal process context. The caller
can sleep between _acquire() and _release().

The second set can be called from arbitrary context, but the caller must
not sleep between _begin() and _end().

The _try() functions check if the fpu is unused, and fail if the fpu is
currently in use. That way the memcpy()/memset() functions can avoid fpu
context saves/restores and it saves stack space.

Nesting is partially possible: _begin() within _acquire is possible,
_acquire() within _begin() will BUG.

[_acquire()/_release() have similar restrictions as down() and up(),
_begin()/_end() have similar restrictions as spinlocks]

The patch itself is alpha quality: only the sse functions are tested, it
boots when compiled for Pentium III, the raid5 checksum _benchmark_
still works and distributed.net still cracks rc5.

I haven't yet checked that the exception handlers are still called
properly.

What do you think?
--
	Manfred
--------------94B0BE0A78358BD8076B0052
Content-Type: text/plain; charset=us-ascii;
 name="patch-kfpu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kfpu"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =
diff -urN 2.4/include/asm-i386/i387.h build-2.4/include/asm-i386/i387.h
--- 2.4/include/asm-i386/i387.h	Fri Feb  2 15:20:36 2001
+++ build-2.4/include/asm-i386/i387.h	Sun Feb 11 19:40:45 2001
@@ -16,6 +16,7 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
+#include <asm/kfpu.h>
 extern void init_fpu(void);
 /*
  * FPU lazy state save handling...
@@ -23,9 +24,7 @@
 extern void save_init_fpu( struct task_struct *tsk );
 extern void restore_fpu( struct task_struct *tsk );
 
-extern void kernel_fpu_begin(void);
-#define kernel_fpu_end() stts()
-
+#include <asm/kfpu.h>
 
 #define unlazy_fpu( tsk ) do { \
 	if ( tsk->flags & PF_USEDFPU ) \
@@ -36,7 +35,7 @@
 	if ( tsk->flags & PF_USEDFPU ) { \
 		asm volatile("fwait"); \
 		tsk->flags &= ~PF_USEDFPU; \
-		stts(); \
+		kfpu_leave(); \
 	} \
 } while (0)
 
diff -urN 2.4/include/asm-i386/kfpu.h build-2.4/include/asm-i386/kfpu.h
--- 2.4/include/asm-i386/kfpu.h	Thu Jan  1 01:00:00 1970
+++ build-2.4/include/asm-i386/kfpu.h	Sun Feb 11 19:59:51 2001
@@ -0,0 +1,83 @@
+#ifndef _ASM_KFPU_H
+#define _ASM_KFPU_H
+
+/*
+ * FPU support for kernel threads
+ *
+ * currently limited to MMX, SSE and SSE2.
+ * x87 and fpu emulation are not supported.
+ */
+
+/**********************************/
+/*
+ * Enable full fpu access.
+ * Only for kernel threads.
+ */
+void kfpu_start(void);
+
+
+/**********************************/
+/*
+ * Get full fpu access.
+ *
+ * Only permitted from process context.
+ * Caller must check that the FPU is present before calling.
+ */
+struct kfpubuf_acquire {
+	unsigned long saved;
+	unsigned char buffer[512+16];
+} kfpubuf_acquire;
+
+void kfpu_acquire(struct kfpubuf_acquire *buf);
+void kfpu_release(struct kfpubuf_acquire *buf);
+
+/* returns 1 if it got fpu access, 0 otherwise */
+int kfpu_try_acquire(void);
+void kfpu_try_release(void);
+
+
+/**********************************/
+/*
+ * Get short term fpu access.
+ *
+ * The functions can be called from any context (process,
+ * softirq, interrupt)
+ * Caller must check that the FPU is present before calling.
+ * The caller must not sleep between _begin() and _end()
+ */
+struct kfpubuf_full {
+	unsigned char buffer[512];
+};
+
+struct kfpubuf_mmx {
+	unsigned char buffer[108];
+};
+
+void kfpu_full_begin(struct kfpubuf_full *buf);
+void kfpu_mmx_begin(struct kfpubuf_mmx *buf);
+/*
+ * ret val 0: caller doesn't need to save clobbered regs
+ * ret val !0: the caller must save & restore any clobbered
+ *		fpu registers.
+ * This function DOES NOT reinitialize the fpu!
+ */
+int kfpu_nosave_begin(void);
+
+void kfpu_full_end(struct kfpubuf_full *buf);
+void kfpu_mmx_end(struct kfpubuf_mmx *buf);
+void kfpu_nosave_end(void);
+
+/* returns 1 if it got fpu access */
+int kfpu_try_begin(void);
+void kfpu_try_end(void);
+
+/**********************************/
+
+/* internal function, called by math_state_restore() */
+void kfpu_enter(void);
+/* internal function, called by save_init_fpu() */
+void kfpu_leave(void);
+/* internal function, called by cpu_init() */
+void kfpu_initialize(void);
+
+#endif
diff -urN 2.4/include/asm-i386/page.h build-2.4/include/asm-i386/page.h
--- 2.4/include/asm-i386/page.h	Thu Jan  4 23:50:46 2001
+++ build-2.4/include/asm-i386/page.h	Sun Feb 11 13:10:17 2001
@@ -11,7 +11,14 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_X86_USE_3DNOW
+#ifdef CONFIG_X86_USE_SSE
+
+#include <asm/sse.h>
+
+#define clear_page(page)	sse_clear_page(page)
+#define copy_page(to,from)	sse_copy_page(to,from)
+
+#elif defined(CONFIG_X86_USE_3DNOW)
 
 #include <asm/mmx.h>
 
diff -urN 2.4/include/asm-i386/sse.h build-2.4/include/asm-i386/sse.h
--- 2.4/include/asm-i386/sse.h	Thu Jan  1 01:00:00 1970
+++ build-2.4/include/asm-i386/sse.h	Sun Feb 11 12:59:43 2001
@@ -0,0 +1,11 @@
+#ifndef _ASM_SSE_H
+#define _ASM_SSE_H
+
+/*
+ *	SSE helper operations
+ */
+ 
+extern void sse_clear_page(void *page);
+extern void sse_copy_page(void *to, void *from);
+
+#endif
diff -urN 2.4/include/asm-i386/system.h build-2.4/include/asm-i386/system.h
--- 2.4/include/asm-i386/system.h	Sun Feb 11 00:39:07 2001
+++ build-2.4/include/asm-i386/system.h	Sun Feb 11 12:41:01 2001
@@ -100,7 +100,6 @@
 /*
  * Clear and set 'TS' bit respectively
  */
-#define clts() __asm__ __volatile__ ("clts")
 #define read_cr0() ({ \
 	unsigned int __dummy; \
 	__asm__( \
@@ -110,7 +109,6 @@
 })
 #define write_cr0(x) \
 	__asm__("movl %0,%%cr0": :"r" (x));
-#define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
 
diff -urN 2.4/include/asm-i386/xor.h build-2.4/include/asm-i386/xor.h
--- 2.4/include/asm-i386/xor.h	Mon Nov 13 04:39:51 2000
+++ build-2.4/include/asm-i386/xor.h	Sun Feb 11 19:37:24 2001
@@ -18,18 +18,16 @@
  * Copyright (C) 1998 Ingo Molnar.
  */
 
+#include <asm/kfpu.h>
+
 #define FPU_SAVE							\
   do {									\
-	if (!(current->flags & PF_USEDFPU))				\
-		__asm__ __volatile__ (" clts;\n");			\
-	__asm__ __volatile__ ("fsave %0; fwait": "=m"(fpu_save[0]));	\
+	kfpu_mmx_begin(&fpu_save);					\
   } while (0)
 
 #define FPU_RESTORE							\
   do {									\
-	__asm__ __volatile__ ("frstor %0": : "m"(fpu_save[0]));		\
-	if (!(current->flags & PF_USEDFPU))				\
-		stts();							\
+	kfpu_mmx_end(&fpu_save);					\
   } while (0)
 
 #define LD(x,y)		"       movq   8*("#x")(%1), %%mm"#y"   ;\n"
@@ -44,7 +42,7 @@
 xor_pII_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
 	unsigned long lines = bytes >> 7;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -89,7 +87,7 @@
 	      unsigned long *p3)
 {
 	unsigned long lines = bytes >> 7;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -139,7 +137,7 @@
 	      unsigned long *p3, unsigned long *p4)
 {
 	unsigned long lines = bytes >> 7;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -194,7 +192,7 @@
 	      unsigned long *p3, unsigned long *p4, unsigned long *p5)
 {
 	unsigned long lines = bytes >> 7;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -261,7 +259,7 @@
 xor_p5_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
 	unsigned long lines = bytes >> 6;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -310,7 +308,7 @@
 	     unsigned long *p3)
 {
 	unsigned long lines = bytes >> 6;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -368,7 +366,7 @@
 	     unsigned long *p3, unsigned long *p4)
 {
 	unsigned long lines = bytes >> 6;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -435,7 +433,7 @@
 	     unsigned long *p3, unsigned long *p4, unsigned long *p5)
 {
 	unsigned long lines = bytes >> 6;
-	char fpu_save[108];
+	struct kfpubuf_mmx fpu_save;
 
 	FPU_SAVE;
 
@@ -531,28 +529,31 @@
  */
 
 #define XMMS_SAVE				\
-	__asm__ __volatile__ ( 			\
-		"movl %%cr0,%0		;\n\t"	\
-		"clts			;\n\t"	\
-		"movups %%xmm0,(%1)	;\n\t"	\
-		"movups %%xmm1,0x10(%1)	;\n\t"	\
-		"movups %%xmm2,0x20(%1)	;\n\t"	\
-		"movups %%xmm3,0x30(%1)	;\n\t"	\
-		: "=r" (cr0)			\
+	restore = kfpu_nosave_begin();		\
+	if (restore)				\
+		__asm__ __volatile__ ( 		\
+		"movups %%xmm0,(%0)	;\n\t"	\
+		"movups %%xmm1,0x10(%0)	;\n\t"	\
+		"movups %%xmm2,0x20(%0)	;\n\t"	\
+		"movups %%xmm3,0x30(%0)	;\n\t"	\
+		: /* no output */		\
 		: "r" (xmm_save) 		\
 		: "memory")
 
 #define XMMS_RESTORE				\
-	__asm__ __volatile__ ( 			\
-		"sfence			;\n\t"	\
-		"movups (%1),%%xmm0	;\n\t"	\
-		"movups 0x10(%1),%%xmm1	;\n\t"	\
-		"movups 0x20(%1),%%xmm2	;\n\t"	\
-		"movups 0x30(%1),%%xmm3	;\n\t"	\
-		"movl 	%0,%%cr0	;\n\t"	\
-		:				\
-		: "r" (cr0), "r" (xmm_save)	\
-		: "memory")
+	__asm__ __volatile__ (			\
+		"sfence\n\t"			\
+		: : : "memory");		\
+	if (restore)				\
+		__asm__ __volatile__ ( 		\
+		"movups (%0),%%xmm0	;\n\t"	\
+		"movups 0x10(%0),%%xmm1	;\n\t"	\
+		"movups 0x20(%0),%%xmm2	;\n\t"	\
+		"movups 0x30(%0),%%xmm3	;\n\t"	\
+		: /* no output */		\
+		: "r" (xmm_save)		\
+		: "memory");			\
+	kfpu_nosave_end()
 
 #define OFFS(x)		"16*("#x")"
 #define	PF0(x)		"	prefetcht0  "OFFS(x)"(%1)   ;\n"
@@ -575,7 +576,7 @@
 {
         unsigned long lines = bytes >> 8;
 	char xmm_save[16*4];
-	int cr0;
+	int restore;
 
 	XMMS_SAVE;
 
@@ -629,7 +630,7 @@
 {
         unsigned long lines = bytes >> 8;
 	char xmm_save[16*4];
-	int cr0;
+	int restore;
 
 	XMMS_SAVE;
 
@@ -690,7 +691,7 @@
 {
         unsigned long lines = bytes >> 8;
 	char xmm_save[16*4];
-	int cr0;
+	int restore;
 
 	XMMS_SAVE;
 
@@ -758,7 +759,7 @@
 {
         unsigned long lines = bytes >> 8;
 	char xmm_save[16*4];
-	int cr0;
+	int restore;
 
 	XMMS_SAVE;
 
diff -urN --exclude .depend 2.4/arch/i386/lib/Makefile build-2.4/arch/i386/lib/Makefile
--- 2.4/arch/i386/lib/Makefile	Sun Feb 11 00:37:51 2001
+++ build-2.4/arch/i386/lib/Makefile	Sun Feb 11 12:59:43 2001
@@ -12,6 +12,7 @@
 	memcpy.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
+obj-$(CONFIG_X86_USE_SSE) += sse.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 
 include $(TOPDIR)/Rules.make
diff -urN --exclude .depend 2.4/arch/i386/lib/mmx.c build-2.4/arch/i386/lib/mmx.c
--- 2.4/arch/i386/lib/mmx.c	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/lib/mmx.c	Sun Feb 11 19:28:12 2001
@@ -28,7 +28,11 @@
 	void *p=to;
 	int i= len >> 6;	/* len/64 */
 
-	kernel_fpu_begin();
+	if(!kfpu_try_begin() {
+		/* FIXME: this belongs into string.h */
+		__memcpy(to, from, len);
+		return;
+	} 
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"		/* This set is 28 bytes */
@@ -84,7 +88,7 @@
 	 *	Now do the tail of the block
 	 */
 	__memcpy(to, from, len&63);
-	kernel_fpu_end();
+	kfpu_try_end();
 	return p;
 }
 
@@ -92,8 +96,6 @@
 {
 	int i;
 
-	kernel_fpu_begin();
-	
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
 	);
@@ -118,18 +120,12 @@
 	__asm__ __volatile__ (
 		"  sfence \n" : :
 	);
-	kernel_fpu_end();
 }
 
 static void fast_copy_page(void *to, void *from)
 {
 	int i;
 
-	kernel_fpu_begin();
-
-	/* maybe the prefetch stuff can go before the expensive fnsave...
-	 * but that is for later. -AV
-	 */
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"
 		"   prefetch 64(%0)\n"
@@ -185,7 +181,6 @@
 	__asm__ __volatile__ (
 		"  sfence \n" : :
 	);
-	kernel_fpu_end();
 }
 
 /*
@@ -205,10 +200,12 @@
  
 void mmx_clear_page(void * page)
 {
-	if(in_interrupt())
-		slow_zero_page(page);
-	else
+	if (kfpu_try_begin()) {
 		fast_clear_page(page);
+		kfpu_try_end();
+	} else {
+		slow_zero_page(page);
+	}
 }
 
 static void slow_copy_page(void *to, void *from)
@@ -225,8 +222,10 @@
 
 void mmx_copy_page(void *to, void *from)
 {
-	if(in_interrupt())
-		slow_copy_page(to, from);
-	else
+	if (kfpu_try_begin()) {
 		fast_copy_page(to, from);
+		kfpu_try_end();
+	} else {
+		slow_copy_page(to, from);
+	}
 }
diff -urN --exclude .depend 2.4/arch/i386/lib/sse.c build-2.4/arch/i386/lib/sse.c
--- 2.4/arch/i386/lib/sse.c	Thu Jan  1 01:00:00 1970
+++ build-2.4/arch/i386/lib/sse.c	Sun Feb 11 18:02:30 2001
@@ -0,0 +1,107 @@
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+
+#include <asm/i387.h>
+
+/*
+ *	SSE library helper functions
+ *
+ *	Copyright (C) 2001 Manfred Spraul
+ *
+ *	Based on Intel sample code from
+ *	 Block Copy Using Pentium(R) III Streaming SIMD Extensions
+ *		Revision 1.9
+ *		January 12, 1999	
+ *
+ */
+ 
+
+void sse_clear_page(void * page)
+{
+	int storage[4];
+	int restore;
+	int d0;
+	restore = kfpu_nosave_begin();
+	if (restore) {
+		__asm__ __volatile__(
+		"movups %%xmm0, (%0)\n\t"
+		: /* no output */
+		: "r" (&storage[0])
+		: "memory" );
+	}
+	__asm__ __volatile__(
+		"xorps %%xmm0, %%xmm0\n\t"
+		"xor %0, %0\n\t"
+		"1: movntps %%xmm0, (%1)\n\t"
+		"movntps %%xmm0, 16(%1)\n\t"
+		"add $32, %1\n\t"
+		"inc %0\n\t"
+		"cmp $128, %0\n\t"
+		"jne 1b\n\t"
+		"sfence\n\t"
+		: "=&r" (d0), "=&r" (page)
+		: "1" (page)
+		: "cc", "memory");
+	if (restore) {
+		__asm__ __volatile__(
+		"movups (%0), %%xmm0\n\t"
+		: /* no output */
+		: "r" (&storage[0])
+		: "memory" );
+	}
+	kfpu_nosave_end();
+}
+
+void sse_copy_page(void *to, void *from)
+{
+	int storage[16];
+	int restore;
+	int d0;
+	restore = kfpu_nosave_begin();
+	if (restore) {
+		__asm__ __volatile__(
+		"movups %%xmm0, (%0)\n\t"
+		"movups %%xmm1, 16(%0)\n\t"
+		"movups %%xmm2, 32(%0)\n\t"
+		"movups %%xmm3, 48(%0)\n\t"
+		: /* no output */
+		: "r" (&storage[0])
+		: "memory" );
+	}
+	__asm__ __volatile__(
+		"mov (%2), %0\n\t"		/* step 1: load the TLB */
+		"xor %0, %0\n\t"		/* step 2: prefetch the page */
+		"1:prefetchnta (%2, %0)\n\t"
+		"prefetchnta 32(%2, %0)\n\t"
+		"add $64,%0\n\t"
+		"cmp $4096, %0\n\t"
+		"jne 1b\n\t"
+		"2: movaps (%2), %%xmm0\n\t"	/* step 3: copy the page */
+		"movaps 16(%2), %%xmm1\n\t"
+		"movaps 32(%2), %%xmm2\n\t"
+		"movaps 48(%2), %%xmm3\n\t"
+		"add $64, %2\n\t"
+		"movntps %%xmm0, (%1)\n\t"
+		"movntps %%xmm1, 16(%1)\n\t"
+		"movntps %%xmm2, 32(%1)\n\t"
+		"movntps %%xmm3, 48(%1)\n\t"
+		"add $64, %1\n\t"
+		"sub $64, %0\n\t"
+		"jnz 2b\n\t"
+		"sfence\n\t"
+		: "=&r" (d0), "=&r" (to), "=&r" (from)
+		: "1" (to), "2" (from)
+		: "cc", "memory");
+	if (restore) {
+		__asm__ __volatile__(
+			"movups (%0), %%xmm0\n\t"
+			"movups 16(%0), %%xmm1\n\t"
+			"movups 32(%0), %%xmm2\n\t"
+			"movups 48(%0), %%xmm3\n\t"
+			: /* no output */
+			: "r" (&storage[0])
+			: "memory" );
+	}
+	kfpu_nosave_end();
+}
--- 2.4/arch/i386/kernel/i387.c	Sun Feb 11 00:37:51 2001
+++ build-2.4/arch/i386/kernel/i387.c	Sun Feb 11 19:35:49 2001
@@ -24,6 +24,8 @@
 #define HAVE_HWFP 1
 #endif
 
+static volatile int cpu_fpuactive[NR_CPUS];
+
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
@@ -39,10 +41,19 @@
 	current->used_math = 1;
 }
 
+void inline stts(void)
+{
+	write_cr0(8 | read_cr0())
+}
+
+char *sse_aligned(char *buffer)
+{
+	return (char*)((((unsigned long)buffer)+15)&(~15));
+}
+
 /*
  * FPU lazy state save handling.
  */
-
 static inline void __save_init_fpu( struct task_struct *tsk )
 {
 	if ( cpu_has_fxsr ) {
@@ -58,18 +69,191 @@
 void save_init_fpu( struct task_struct *tsk )
 {
 	__save_init_fpu(tsk);
-	stts();
+	kfpu_leave();
+}
+
+void kfpu_start(void)
+{
+	if ( cpu_has_fpu ) {
+		cpu_fpuactive[smp_processor_id()]++;
+		__asm__ __volatile__("clts");	/* Allow maths ops (or we recurse) */
+		init_fpu();
+		current->flags |= PF_USEDFPU;	/* So we fnsave on switch_to() */
+		current->used_math = 1;
+	}
 }
 
-void kernel_fpu_begin(void)
+void kfpu_acquire(struct kfpubuf_acquire *buf)
 {
-	struct task_struct *tsk = current;
+	if (!current->used_math) {
+		buf->saved = 0;
+		kfpu_try_acquire();
+		return;
+	}
+	buf->saved = 1;
+	unlazy_fpu(current);
+	if ( cpu_has_fxsr ) {
+		memcpy(buf->buffer, &current->thread.i387.fxsave,
+			sizeof(current->thread.i387.fxsave));
+	} else {
+		memcpy(buf->buffer, &current->thread.i387.fsave,
+			sizeof(current->thread.i387.fsave));
+	}
+	
+	if (cpu_fpuactive[smp_processor_id()])
+		BUG();
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	init_fpu();
+	current->flags |= PF_USEDFPU;
+}
 
-	if (tsk->flags & PF_USEDFPU) {
-		__save_init_fpu(tsk);
+void kfpu_release(struct kfpubuf_acquire *buf)
+{
+	if (!buf->saved) {
+		kfpu_try_release();
 		return;
 	}
-	clts();
+	clear_fpu(current);
+	if ( cpu_has_fxsr ) {
+		memcpy(&current->thread.i387.fxsave, buf->buffer,
+			sizeof(current->thread.i387.fxsave));
+	} else {
+		memcpy(&current->thread.i387.fsave, buf->buffer,
+			sizeof(current->thread.i387.fsave));
+	}
+	if (cpu_fpuactive[smp_processor_id()])
+		BUG();
+	if (current->flags & PF_USEDFPU)
+		BUG();
+}
+
+/* returns 1 if it got fpu access, 0 otherwise */
+int kfpu_try_acquire(void)
+{
+	if (current->used_math)
+		return 0;
+	current->used_math = 1;
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	init_fpu();
+	current->flags |= PF_USEDFPU;
+	return 1;
+}
+
+void kfpu_try_release(void)
+{
+	clear_fpu(current);
+	current->used_math = 0;
+	if (cpu_fpuactive[smp_processor_id()])
+		BUG();
+	if (current->flags & PF_USEDFPU)
+		BUG();
+}
+
+void kfpu_full_begin(struct kfpubuf_full *buf)
+{
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	if(cpu_fpuactive[smp_processor_id()] > 1) {
+		char *buffer = sse_aligned(buffer);
+		asm volatile( "fxsave %0 ; fnclex"
+			      : "=m" (buffer) );
+	}
+	__asm__("fninit");
+	load_mxcsr(0x1f80);
+}
+
+void kfpu_mmx_begin(struct kfpubuf_mmx *buf)
+{
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	if(cpu_fpuactive[smp_processor_id()] > 1) {
+		asm volatile( "fnsave %0 ; fwait"
+			      : "=m" (buf->buffer) );
+	}
+	__asm__("fninit");
+}
+
+/* ret val 0: caller doesn't need to save clobbered regs */
+int kfpu_nosave_begin(void)
+{
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	return cpu_fpuactive[smp_processor_id()]-1;
+}
+
+void kfpu_full_end(struct kfpubuf_full *buf)
+{
+	if(cpu_fpuactive[smp_processor_id()] > 1) {
+		char *buffer = sse_aligned(buffer);
+		asm volatile( "fxrstor %0"
+			      : "=m" (buffer) );
+		cpu_fpuactive[smp_processor_id()]--;
+	} else {
+		cpu_fpuactive[smp_processor_id()]--;
+		stts();
+	}
+}
+
+void kfpu_mmx_end(struct kfpubuf_mmx *buf)
+{
+	if(cpu_fpuactive[smp_processor_id()] > 1) {
+		asm volatile( "frstor %0"
+			      : "=m" (buf->buffer) );
+		cpu_fpuactive[smp_processor_id()]--;
+	} else {
+		cpu_fpuactive[smp_processor_id()]--;
+		stts();
+	}
+}
+
+void kfpu_nosave_end(void)
+{
+	cpu_fpuactive[smp_processor_id()]--;
+	if(cpu_fpuactive[smp_processor_id()] == 0)
+		stts();
+}
+
+/* returns 1 if it got fpu access */
+int kfpu_try_begin(void)
+{
+	if (cpu_fpuactive[smp_processor_id()] > 0)
+		return 0;
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+	__asm__("fninit");
+	if ( cpu_has_xmm )
+		load_mxcsr(0x1f80);
+	return 1;
+}
+
+void kfpu_try_end(void)
+{
+	cpu_fpuactive[smp_processor_id()]--;
+	stts();
+}
+
+void kfpu_initialize(void)
+{
+	cpu_fpuactive[smp_processor_id()] = 0;
+	stts();
+}
+
+void kfpu_enter(void)
+{
+	if(cpu_fpuactive[smp_processor_id()] != 0)
+		BUG();
+	cpu_fpuactive[smp_processor_id()]++;
+	__asm__ __volatile__("clts");
+}
+
+void kfpu_leave(void)
+{
+	cpu_fpuactive[smp_processor_id()]--;
+	stts();
+	if(cpu_fpuactive[smp_processor_id()] != 0)
+		BUG();
 }
 
 void restore_fpu( struct task_struct *tsk )
--- 2.4/arch/i386/kernel/traps.c	Sun Feb 11 00:37:51 2001
+++ build-2.4/arch/i386/kernel/traps.c	Sun Feb 11 19:18:59 2001
@@ -731,7 +731,7 @@
  */
 asmlinkage void math_state_restore(struct pt_regs regs)
 {
-	__asm__ __volatile__("clts");		/* Allow maths ops (or we recurse) */
+	kfpu_enter();		/* Allow maths ops (or we recurse) */
 
 	if (current->used_math) {
 		restore_fpu(current);
--- 2.4/arch/i386/kernel/setup.c	Sun Feb 11 00:37:51 2001
+++ build-2.4/arch/i386/kernel/setup.c	Sun Feb 11 14:33:58 2001
@@ -2274,7 +2274,8 @@
 	 */
 	current->flags &= ~PF_USEDFPU;
 	current->used_math = 0;
-	stts();
+	kfpu_initialize();
+
 }
 
 /*
--- 2.4/arch/i386/kernel/i386_ksyms.c	Sun Feb 11 00:37:51 2001
+++ build-2.4/arch/i386/kernel/i386_ksyms.c	Sun Feb 11 19:25:05 2001
@@ -117,6 +117,25 @@
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
 
+#ifdef CONFIG_X86_USE_SSE
+EXPORT_SYMBOL(sse_clear_page);
+EXPORT_SYMBOL(sse_copy_page);
+#endif
+
+EXPORT_SYMBOL(kfpu_start);
+EXPORT_SYMBOL(kfpu_acquire);
+EXPORT_SYMBOL(kfpu_release);
+EXPORT_SYMBOL(kfpu_try_acquire);
+EXPORT_SYMBOL(kfpu_try_release);
+EXPORT_SYMBOL(kfpu_full_begin);
+EXPORT_SYMBOL(kfpu_mmx_begin);
+EXPORT_SYMBOL(kfpu_nosave_begin);
+EXPORT_SYMBOL(kfpu_full_end);
+EXPORT_SYMBOL(kfpu_mmx_end);
+EXPORT_SYMBOL(kfpu_nosave_end);
+EXPORT_SYMBOL(kfpu_try_begin);
+EXPORT_SYMBOL(kfpu_try_end);
+
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag);
--- 2.4/arch/i386/config.in	Sun Feb 11 00:37:50 2001
+++ build-2.4/arch/i386/config.in	Sun Feb 11 19:18:59 2001
@@ -91,6 +91,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_SSE y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
@@ -98,6 +99,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_SSE y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5


--------------94B0BE0A78358BD8076B0052--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
