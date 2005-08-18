Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVHRLQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVHRLQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVHRLQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:16:23 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:6542 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932194AbVHRLQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:16:22 -0400
Date: Thu, 18 Aug 2005 20:11:38 +0900 (JST)
Message-Id: <20050818.201138.607962419.hyoshiok@miraclelinux.com>
To: lkml.hyoshiok@gmail.com
Cc: ak@suse.de, arjan@infradead.org, taka@valinux.co.jp,
       linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <98df96d305081804061ea70686@mail.gmail.com>
References: <1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	<p73oe7y10qw.fsf@verdi.suse.de>
	<98df96d305081804061ea70686@mail.gmail.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I make two APIs. 
> __copy_user_zeroing_nocache()
> __copy_user_zeroing_inatomic_nocache()
> 
> The former is a low latency version and the other is a throughput version.

1) using stack to save/restore MMX registers
2) low latency version of cache aware copy
3) __copy_user*_nocache APIs so if you want to use it.

diff -ur linux-2.6.12.4.orig/Makefile linux-2.6.12.4.preempt/Makefile
--- linux-2.6.12.4.orig/Makefile	2005-08-12 14:37:59.000000000 +0900
+++ linux-2.6.12.4.preempt/Makefile	2005-08-18 18:47:07.000000000 +0900
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .4.orig
+EXTRAVERSION = .4.preempt
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -ur linux-2.6.12.4.orig/arch/i386/lib/usercopy.c linux-2.6.12.4.preempt/arch/i386/lib/usercopy.c
--- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.preempt/arch/i386/lib/usercopy.c	2005-08-18 19:07:49.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <asm/i387.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -511,6 +512,254 @@
 		: "memory");						\
 } while (0)
 
+#define MMX_SAVE do {                           \
+        preempt_disable();                      \
+        __asm__ __volatile__ (                  \
+                "movl %%cr0,%0          ;\n\t"  \
+                "clts                   ;\n\t"  \
+                "movq %%mm0,(%1)     ;\n\t"     \
+                "movq %%mm1,8(%1) ;\n\t"     \
+                "movq %%mm2,16(%1) ;\n\t"     \
+                "movq %%mm3,24(%1) ;\n\t"     \
+                : "=&r" (cr0)                   \
+                : "r" (mmx_save)                \
+                : "memory");                    \
+} while(0)
+
+#define MMX_RESTORE do {                       \
+        __asm__ __volatile__ (                  \
+                "sfence                 ;\n\t"  \
+                "movq (%1),%%mm0     ;\n\t"  \
+                "movq 8(%1),%%mm1 ;\n\t"  \
+                "movq 16(%1),%%mm2 ;\n\t"  \
+                "movq 24(%1),%%mm3 ;\n\t"  \
+                "movl   %0,%%cr0        ;\n\t"  \
+                :                               \
+                : "r" (cr0), "r" (mmx_save)     \
+                : "memory");                    \
+        preempt_enable();                       \
+} while(0)
+
+#define ALIGN8 __attribute__((aligned(8)))
+
+/* Non Temporal Hint version of mmx_memcpy */
+/* It is cache aware                       */
+/* hyoshiok@miraclelinux.com               */
+static unsigned long 
+__copy_user_zeroing_nocache(void *to, const void *from, size_t len)
+{
+        /* Note! gcc doesn't seem to align stack variables properly, so we
+         * need to make use of unaligned loads and stores.
+         */
+	void *p;
+	int i;
+        char mmx_save[8*4] ALIGN8;
+        int cr0;
+
+	if (unlikely(in_interrupt())){
+	        __copy_user_zeroing(to, from, len);
+		return len;
+	}
+
+	p = to;
+	i = len >> 6; /* len/64 */
+
+	/*        kernel_fpu_begin();*/
+	MMX_SAVE;
+
+	__asm__ __volatile__ (
+		"1: prefetchnta (%0)\n"		/* This set is 28 bytes */
+		"   prefetchnta 64(%0)\n"
+		"   prefetchnta 128(%0)\n"
+		"   prefetchnta 192(%0)\n"
+		"   prefetchnta 256(%0)\n"
+		"2:  \n"
+		".section .fixup, \"ax\"\n"
+		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
+		"   jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from) );
+		
+	for(; i>5; i--)
+	{
+		__asm__ __volatile__ (
+		"1:  prefetchnta 320(%0)\n"
+                "2:  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+		".section .fixup, \"ax\"\n"
+		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
+		"   jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+#ifdef CONFIG_PREEMPT
+		if ( (i%64)==0 ) {
+		    MMX_RESTORE;
+		    MMX_SAVE;
+		};
+#endif
+	}
+
+	for(; i>0; i--)
+	{
+		__asm__ __volatile__ (
+                "  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+	/*
+	 *	Now do the tail of the block
+	 */
+	/*	kernel_fpu_end();*/
+	MMX_RESTORE;
+	if(i=(len&63))
+	  __copy_user_zeroing(to, from, i);
+	return i;
+}
+
+static unsigned long 
+__copy_user_zeroing_inatomic_nocache(void *to, const void *from, size_t len)
+{
+        /* Note! gcc doesn't seem to align stack variables properly, so we
+         * need to make use of unaligned loads and stores.
+         */
+	void *p;
+	int i;
+        char mmx_save[8*4] ALIGN8;
+        int cr0;
+
+	if (unlikely(in_interrupt())){
+	        __copy_user_zeroing(to, from, len);
+		return len;
+	}
+
+	p = to;
+	i = len >> 6; /* len/64 */
+
+	/*        kernel_fpu_begin();*/
+	MMX_SAVE;
+
+	__asm__ __volatile__ (
+		"1: prefetchnta (%0)\n"		/* This set is 28 bytes */
+		"   prefetchnta 64(%0)\n"
+		"   prefetchnta 128(%0)\n"
+		"   prefetchnta 192(%0)\n"
+		"   prefetchnta 256(%0)\n"
+		"2:  \n"
+		".section .fixup, \"ax\"\n"
+		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
+		"   jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from) );
+		
+	for(; i>5; i--)
+	{
+		__asm__ __volatile__ (
+		"1:  prefetchnta 320(%0)\n"
+                "2:  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+		".section .fixup, \"ax\"\n"
+		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
+		"   jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+
+	for(; i>0; i--)
+	{
+		__asm__ __volatile__ (
+                "  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+	/*
+	 *	Now do the tail of the block
+	 */
+	/*	kernel_fpu_end();*/
+	MMX_RESTORE;
+	if(i=(len&63))
+	  __copy_user_zeroing(to, from, i);
+	return i;
+}
 
 unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
 {
@@ -582,6 +831,36 @@
 	return n;
 }
 
+unsigned long
+__copy_from_user_ll_nocache(void *to, const void __user *from, unsigned long n)
+{
+	BUG_ON((long)n < 0);
+        if (n < 512) {
+          if (movsl_is_ok(to, from, n))
+                __copy_user_zeroing(to, from, n);
+          else
+                n = __copy_user_zeroing_intel(to, from, n);
+        }
+        else
+          n = __copy_user_zeroing_nocache(to, from, n);
+	return n;
+}
+
+unsigned long
+__copy_from_user_ll_inatomic_nocache(void *to, const void __user *from, unsigned long n)
+{
+	BUG_ON((long)n < 0);
+        if (n < 512) {
+          if (movsl_is_ok(to, from, n))
+                __copy_user_zeroing(to, from, n);
+          else
+                n = __copy_user_zeroing_intel(to, from, n);
+        }
+        else
+          n = __copy_user_zeroing_inatomic_nocache(to, from, n);
+	return n;
+}
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
diff -ur linux-2.6.12.4.orig/include/asm-i386/uaccess.h linux-2.6.12.4.preempt/include/asm-i386/uaccess.h
--- linux-2.6.12.4.orig/include/asm-i386/uaccess.h	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.preempt/include/asm-i386/uaccess.h	2005-08-18 19:16:55.000000000 +0900
@@ -413,6 +413,10 @@
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache(void *to,
+				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_inatomic_nocache(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -502,11 +506,55 @@
 }
 
 static inline unsigned long
+__copy_from_user_inatomic_nocache(void *to, const void __user *from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		unsigned long ret;
+
+		switch (n) {
+		case 1:
+			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			return ret;
+		case 2:
+			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			return ret;
+		case 4:
+			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			return ret;
+		}
+	}
+	return __copy_from_user_ll_inatomic_nocache(to, from, n);
+}
+
+static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
+
+static inline unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+	if (__builtin_constant_p(n)) {
+		unsigned long ret;
+
+		switch (n) {
+		case 1:
+			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			return ret;
+		case 2:
+			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			return ret;
+		case 4:
+			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			return ret;
+		}
+	}
+	return __copy_from_user_ll_nocache(to, from, n);
+}
+
 unsigned long __must_check copy_to_user(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check copy_from_user(void *to,
diff -ur linux-2.6.12.4.orig/mm/filemap.c linux-2.6.12.4.preempt/mm/filemap.c
--- linux-2.6.12.4.orig/mm/filemap.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.preempt/mm/filemap.c	2005-08-16 10:16:06.000000000 +0900
@@ -1727,13 +1727,13 @@
 	int left;
 
 	kaddr = kmap_atomic(page, KM_USER0);
-	left = __copy_from_user_inatomic(kaddr + offset, buf, bytes);
+	left = __copy_from_user_inatomic_nocache(kaddr + offset, buf, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
 
 	if (left != 0) {
 		/* Do it the slow way */
 		kaddr = kmap(page);
-		left = __copy_from_user(kaddr + offset, buf, bytes);
+		left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
 		kunmap(page);
 	}
 	return bytes - left;
@@ -1750,7 +1750,7 @@
 		int copy = min(bytes, iov->iov_len - base);
 
 		base = 0;
-		left = __copy_from_user_inatomic(vaddr, buf, copy);
+		left = __copy_from_user_inatomic_nocache(vaddr, buf, copy);
 		copied += copy;
 		bytes -= copy;
 		vaddr += copy;


Regards,
  Hiro
--
Hiro Yoshioka
CTO/Miracle Linux Corporation
