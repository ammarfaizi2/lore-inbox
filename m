Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVHPDfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVHPDfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVHPDfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:35:42 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:26166 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965089AbVHPDfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:35:41 -0400
Date: Tue, 16 Aug 2005 12:30:42 +0900 (JST)
Message-Id: <20050816.123042.424254477.hyoshiok@miraclelinux.com>
To: lkml.hyoshiok@gmail.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <98df96d3050815163331d6cce1@mail.gmail.com>
References: <98df96d305081501441bc9b121@mail.gmail.com>
	<1124096021.3228.20.camel@laptopd505.fenrus.org>
	<98df96d3050815163331d6cce1@mail.gmail.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Date: Tue, 16 Aug 2005 08:33:59 +0900

> Thanks.
> 
> filemap_copy_from_user() calls __copy_from_user_inatomic() calls
> __copy_from_user_ll().
> 
> I'll look at the code.

The following is a quick hack of cache aware implementation
of __copy_from_user_ll() and __copy_from_user_inatomic()

__copy_from_user_ll_nocache() and __copy_from_user_inatomic_nocache()

filemap_copy_from_user() calles __copy_from_user_inatomic_nocache()
instead of __copy_from_user_inatomic() and reduced cashe miss.

The first column is the cache reference (memory access) and the
third column is the 3rd level cache miss.

The following example shows the L3 cache miss is reduced from 37410 to 107.

2.6.12.4 nocache version
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x3f (multiple flags) count 3000
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        samples  %     app name       symbol name
120442    6.4106  107    0.5620  vmlinux        __copy_user_zeroing_nocache
80049     4.2606  578    3.0357  vmlinux        journal_add_journal_head
69194     3.6829  154    0.8088  vmlinux        journal_dirty_metadata
67059     3.5692  78     0.4097  vmlinux        __find_get_block
64145     3.4141  32     0.1681  vmlinux        journal_put_journal_head
pattern9-0-cpu4-0-08161154/summary.out

The 2.6.12.4 original version is
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x3f (multiple flags) count 3000
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        samples  %     app name       symbol name
120646    7.4680  37410 62.3355  vmlinux        __copy_from_user_ll
79508     4.9215  903    1.5046  vmlinux        _spin_lock
65526     4.0561  873    1.4547  vmlinux        journal_add_journal_head
59296     3.6704  129    0.2149  vmlinux        __find_get_block
58647     3.6302  215    0.3582  vmlinux        journal_dirty_metadata

What do you think?

Hiro

diff -ur linux-2.6.12.4.orig/Makefile linux-2.6.12.4.nocache/Makefile
--- linux-2.6.12.4.orig/Makefile	2005-08-12 14:37:59.000000000 +0900
+++ linux-2.6.12.4.nocache/Makefile	2005-08-16 10:22:31.000000000 +0900
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .4.orig
+EXTRAVERSION = .4.nocache
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -ur linux-2.6.12.4.orig/arch/i386/lib/usercopy.c linux-2.6.12.4.nocache/arch/i386/lib/usercopy.c
--- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nocache/arch/i386/lib/usercopy.c	2005-08-16 10:49:59.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <asm/i387.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -511,6 +512,110 @@
 		: "memory");						\
 } while (0)
 
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
+
+	if (unlikely(in_interrupt())){
+	        __copy_user_zeroing(to, from, len);
+		return len;
+	}
+
+	p = to;
+	i = len >> 6; /* len/64 */
+
+        kernel_fpu_begin();
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
+		"2:  movq (%0), %%mm0\n"
+		"  movq 8(%0), %%mm1\n"
+		"  movq 16(%0), %%mm2\n"
+		"  movq 24(%0), %%mm3\n"
+		"  movntq %%mm0, (%1)\n"
+		"  movntq %%mm1, 8(%1)\n"
+		"  movntq %%mm2, 16(%1)\n"
+		"  movntq %%mm3, 24(%1)\n"
+		"  movq 32(%0), %%mm0\n"
+		"  movq 40(%0), %%mm1\n"
+		"  movq 48(%0), %%mm2\n"
+		"  movq 56(%0), %%mm3\n"
+		"  movntq %%mm0, 32(%1)\n"
+		"  movntq %%mm1, 40(%1)\n"
+		"  movntq %%mm2, 48(%1)\n"
+		"  movntq %%mm3, 56(%1)\n"
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
+		"  movq (%0), %%mm0\n"
+		"  movq 8(%0), %%mm1\n"
+		"  movq 16(%0), %%mm2\n"
+		"  movq 24(%0), %%mm3\n"
+		"  movntq %%mm0, (%1)\n"
+		"  movntq %%mm1, 8(%1)\n"
+		"  movntq %%mm2, 16(%1)\n"
+		"  movntq %%mm3, 24(%1)\n"
+		"  movq 32(%0), %%mm0\n"
+		"  movq 40(%0), %%mm1\n"
+		"  movq 48(%0), %%mm2\n"
+		"  movq 56(%0), %%mm3\n"
+		"  movntq %%mm0, 32(%1)\n"
+		"  movntq %%mm1, 40(%1)\n"
+		"  movntq %%mm2, 48(%1)\n"
+		"  movntq %%mm3, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+	/*
+	 *	Now do the tail of the block
+	 */
+	kernel_fpu_end();
+	if(i=(len&63))
+	  __copy_user_zeroing(to, from, i);
+	return i;
+}
+
 
 unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
 {
@@ -582,6 +687,21 @@
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
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
diff -ur linux-2.6.12.4.orig/include/asm/uaccess.h linux-2.6.12.4.nocache/include/asm/uaccess.h
--- linux-2.6.12.4.orig/include/asm/uaccess.h	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nocache/include/asm/uaccess.h	2005-08-16 10:44:05.000000000 +0900
@@ -413,6 +413,8 @@
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -502,11 +504,38 @@
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
+	return __copy_from_user_ll_nocache(to, from, n);
+}
+
+static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
+static inline unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_from_user_inatomic_nocache(to, from, n);
+}
 unsigned long __must_check copy_to_user(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check copy_from_user(void *to,
diff -ur linux-2.6.12.4.orig/include/asm-i386/uaccess.h linux-2.6.12.4.nocache/include/asm-i386/uaccess.h
--- linux-2.6.12.4.orig/include/asm-i386/uaccess.h	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nocache/include/asm-i386/uaccess.h	2005-08-16 10:44:05.000000000 +0900
@@ -413,6 +413,8 @@
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -502,11 +504,38 @@
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
+	return __copy_from_user_ll_nocache(to, from, n);
+}
+
+static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
+static inline unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_from_user_inatomic_nocache(to, from, n);
+}
 unsigned long __must_check copy_to_user(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check copy_from_user(void *to,
diff -ur linux-2.6.12.4.orig/include/linux/autoconf.h linux-2.6.12.4.nocache/include/linux/autoconf.h
--- linux-2.6.12.4.orig/include/linux/autoconf.h	2005-08-15 16:53:01.000000000 +0900
+++ linux-2.6.12.4.nocache/include/linux/autoconf.h	2005-08-16 10:32:33.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * Automatically generated C config: don't edit
- * Linux kernel version: 2.6.12.4.orig
- * Mon Aug 15 16:53:01 2005
+ * Linux kernel version: 2.6.12.4.nocache
+ * Tue Aug 16 10:32:33 2005
  */
 #define AUTOCONF_INCLUDED
 #define CONFIG_X86 1
diff -ur linux-2.6.12.4.orig/mm/filemap.c linux-2.6.12.4.nocache/mm/filemap.c
--- linux-2.6.12.4.orig/mm/filemap.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nocache/mm/filemap.c	2005-08-16 10:16:06.000000000 +0900
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
