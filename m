Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129865AbRBIWSF>; Fri, 9 Feb 2001 17:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbRBIWRz>; Fri, 9 Feb 2001 17:17:55 -0500
Received: from colorfullife.com ([216.156.138.34]:8196 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129865AbRBIWRk>;
	Fri, 9 Feb 2001 17:17:40 -0500
Message-ID: <3A846C84.109F1D7D@colorfullife.com>
Date: Fri, 09 Feb 2001 23:17:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [beta patch] SSE copy_page() / clear_page()
Content-Type: multipart/mixed;
 boundary="------------985E80AD746CAB4F20767197"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------985E80AD746CAB4F20767197
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I wrote a kernel patch that replaces the standard
copy_page()/clear_page() functions on Pentium III and Pentium IV with
SSE instructions.

If you have access to a Pentium 4 it would be great if you could
download the user space test apps from

http://colorfullife.com/~manfred/sse/

and run them.

The patch itself is still beta:
* find optimal number of %%xmm registers for copy_page(). The current
code uses 4, but 2 registers is faster on my Pentium III.

* use sse for normal memcopy. Then main advantage of sse over mmx is
that only the clobbered registers must be saved, not the full fpu state.

* verify that the code doesn't break SSE enabled apps.
I checked a sse enabled mp3 encoder and Mesa.

The implementation is derived from Intel sample code available at

http://developer.intel.com/software/idap/media/pdf/copy.pdf

--
	Manfred
--------------985E80AD746CAB4F20767197
Content-Type: text/plain; charset=us-ascii;
 name="patch-sse"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sse"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =
--- 2.4/arch/i386/config.in	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/config.in	Fri Feb  9 15:52:19 2001
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
--- 2.4/arch/i386/kernel/i386_ksyms.c	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/kernel/i386_ksyms.c	Fri Feb  9 15:52:19 2001
@@ -117,6 +117,11 @@
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
 
+#ifdef CONFIG_X86_USE_SSE
+EXPORT_SYMBOL(sse_clear_page);
+EXPORT_SYMBOL(sse_copy_page);
+#endif
+
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag);
diff -urN --exclude .depend 2.4/arch/i386/lib/Makefile build-2.4/arch/i386/lib/Makefile
--- 2.4/arch/i386/lib/Makefile	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/lib/Makefile	Fri Feb  9 15:52:19 2001
@@ -12,6 +12,7 @@
 	memcpy.o
 
 obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
+obj-$(CONFIG_X86_USE_SSE) += sse.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 
 include $(TOPDIR)/Rules.make
diff -urN --exclude .depend 2.4/arch/i386/lib/sse.c build-2.4/arch/i386/lib/sse.c
--- 2.4/arch/i386/lib/sse.c	Thu Jan  1 01:00:00 1970
+++ build-2.4/arch/i386/lib/sse.c	Fri Feb  9 15:52:19 2001
@@ -0,0 +1,89 @@
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
+	int d0, d1, d2;
+	__asm__ __volatile__(
+		"mov %%cr0, %2\n\t"
+		"clts\n\t"
+		"movups %%xmm0, (%3)\n\t"
+		"xorps %%xmm0, %%xmm0\n\t"
+		"xor %0, %0\n\t"
+		"1: movntps %%xmm0, (%1)\n\t"
+		"movntps %%xmm0, 16(%1)\n\t"
+		"movntps %%xmm0, 32(%1)\n\t"
+		"movntps %%xmm0, 48(%1)\n\t"
+		"movntps %%xmm0, 64(%1)\n\t"
+		"movntps %%xmm0, 80(%1)\n\t"
+		"movntps %%xmm0, 96(%1)\n\t"
+		"movntps %%xmm0, 112(%1)\n\t"
+		"add $128, %1\n\t"
+		"inc %0\n\t"
+		"cmp $32, %0\n\t"
+		"jne 1b\n\t"
+		"movups (%3), %%xmm0\n\t"
+		"sfence\n\t"
+		"mov %2, %%cr0\n\t"
+		: "=&r" (d0), "=&r" (d1), "=&r" (d2)
+		: "r" (&storage), "1" (page)
+		: "cc", "memory");
+}
+
+void sse_copy_page(void *to, void *from)
+{
+	int storage[16];
+	int d0, d1, d2, d3;
+	__asm__ __volatile__(
+		"mov %%cr0, %3\n\t"		/* step 1: enable the FPU */
+		"clts\n\t"
+		"movups %%xmm0, (%4)\n\t"	/* step 2: save the clobbered regs */
+		"movups %%xmm1, 16(%4)\n\t"
+		"movups %%xmm2, 32(%4)\n\t"
+		"movups %%xmm3, 48(%4)\n\t"
+		"mov (%2), %0\n\t"		/* step 3: load the TLB */
+		"xor %0, %0\n\t"		/* step 4: prefetch the page */
+		"1:prefetchnta (%2, %0)\n\t"
+		"prefetchnta 32(%2, %0)\n\t"
+		"add $64,%0\n\t"
+		"cmp $4096, %0\n\t"
+		"jne 1b\n\t"
+		"2: movaps (%2), %%xmm0\n\t"	/* step 5: copy the page */
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
+		"movups (%4), %%xmm0\n\t"	/* step 6: restore the clobbered regs */
+		"movups 16(%4), %%xmm1\n\t"
+		"movups 32(%4), %%xmm2\n\t"
+		"movups 48(%4), %%xmm3\n\t"
+		"sfence\n\t"
+		"mov %3, %%cr0\n\t"		/* step 7: restore cr0 */
+		: "=&r" (d0), "=&r" (d1), "=&r" (d2), "=&r" (d3)
+		: "r" (&storage), "1" (to), "2" (from)
+		: "cc", "memory");
+}
diff -urN 2.4/include/asm-i386/page.h build-2.4/include/asm-i386/page.h
--- 2.4/include/asm-i386/page.h	Thu Jan  4 23:50:46 2001
+++ build-2.4/include/asm-i386/page.h	Fri Feb  9 15:52:19 2001
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
+++ build-2.4/include/asm-i386/sse.h	Fri Feb  9 17:26:34 2001
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

--------------985E80AD746CAB4F20767197--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
