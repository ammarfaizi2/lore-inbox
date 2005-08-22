Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVHVXGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVHVXGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVHVXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:06:29 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57999 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932309AbVHVXG1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:06:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=njhXTz+fXA18AqeMVndNt4TE68nYVy9nmlxFDOquTjWGADUCP55xKaDsmnOs1Frlv5XUJi2V074IsM6TZUw/2anEituI0aCMTp8FnMEDMUy32+iuHMzXpUw96uyBtPwhoDqPHHUcrcHMklTDfLvgrHHKnsFuHqR5L5HBlgYUAGA=
Message-ID: <98df96d30508211943148e3024@mail.gmail.com>
Date: Mon, 22 Aug 2005 11:43:41 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d30508181629d85edb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	 <p73oe7y10qw.fsf@verdi.suse.de>
	 <98df96d305081804061ea70686@mail.gmail.com>
	 <20050818.201138.607962419.hyoshiok@miraclelinux.com>
	 <98df96d30508181629d85edb5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems to me this mail does not go out.
So resending it.

> On 8/18/05, Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
> > 1) using stack to save/restore MMX registers
> 
> It seems to me that it has some regression.
> I'd like to rollback it and use kernel_fpu_begin() and kernel_fpu_end().

The following is a current version of cache aware copy_from_user_ll.

1) using kernel_fpu_begin()/kernel_fpu_end()
2) low latency version of cache aware copy
3) __copy_user*_nocache APIs so if you want to use it.
(There is no change in the current APIs.)

Some performance data are

Total of GLOBAL_POWER_EVENTS (CPU cycle samples)

2.6.12.4.orig    1921587
2.6.12.4.preempt 1634411
163411/1921587=85.06% (15% reduction)

BSQ_CACHE_REFERENCE (L3 cache miss)
2.6.12.4.orig      57427
2.6.12.4.preempt   17398

samples  %
37408    65.1412  vmlinux                  __copy_from_user_ll
51        0.2931  vmlinux                  __copy_user_zeroing_inatomic_nocache
51/37408=0.136% (99.86% reduction)

Top 5 2.6.12.4.orig
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
287643   14.9692  vmlinux                  __copy_from_user_ll
72660     3.7813  vmlinux                  journal_add_journal_head
65011     3.3832  vmlinux                  do_get_write_access
50618     2.6342  vmlinux                  journal_put_journal_head
48068     2.5015  vmlinux                  journal_dirty_metadata
pattern9-0-cpu4-0-08191743/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x3f (multiple flags) count 3000
samples  %        app name                 symbol name
134756    7.9364  vmlinux                  __copy_from_user_ll
57735     3.4003  vmlinux                  journal_add_journal_head
50653     2.9832  vmlinux                  __find_get_block
44522     2.6221  vmlinux                  journal_put_journal_head
38928     2.2927  vmlinux                  journal_dirty_metadata
pattern9-0-cpu4-0-08191741/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        app name                 symbol name
37408    65.1412  vmlinux                  __copy_from_user_ll
953       1.6595  vmlinux                  blk_rq_map_sg
886       1.5429  vmlinux                  sub_preempt_count
680       1.1841  vmlinux                  journal_add_journal_head
598       1.0413  vmlinux                  journal_commit_transaction
pattern9-0-cpu4-0-08191720/summary.out

Top 5 2.6.12.4.preempt
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
123531    7.5582  vmlinux                  __copy_user_zeroing_inatomic_nocache
64820     3.9660  vmlinux                  journal_add_journal_head
60460     3.6992  vmlinux                  do_get_write_access
47172     2.8862  vmlinux                  journal_put_journal_head
46753     2.8606  vmlinux                  journal_dirty_metadata
pattern9-0-cpu4-0-08190838/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x3f (multiple flags) count 3000
samples  %        app name                 symbol name
126762    6.7993  vmlinux                  __copy_user_zeroing_inatomic_nocache
79803     4.2805  vmlinux                  journal_add_journal_head
70271     3.7692  vmlinux                  journal_dirty_metadata
66146     3.5480  vmlinux                  __find_get_block
58082     3.1154  vmlinux                  journal_put_journal_head
pattern9-0-cpu4-0-08190855/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        app name                 symbol name
901       5.1788  vmlinux                  blk_rq_map_sg
675       3.8798  vmlinux                  journal_commit_transaction
637       3.6613  vmlinux                  radix_tree_delete
605       3.4774  vmlinux                  journal_add_journal_head
580       3.3337  vmlinux                  release_pages
...
51        0.2931  vmlinux                  __copy_user_zeroing_inatomic_nocache
...
1         0.0057  vmlinux                  __copy_from_user_ll_inatomic_nocache
pattern9-0-cpu4-0-08190859/summary.out

2.6.12.4-usercopy.c.patch.050819
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
diff -ur linux-2.6.12.4.orig/arch/i386/lib/usercopy.c
linux-2.6.12.4.preempt/arch/i386/lib/usercopy.c
--- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05
16:04:37.000000000 +0900
+++ linux-2.6.12.4.preempt/arch/i386/lib/usercopy.c	2005-08-19
08:25:08.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <asm/i387.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -511,6 +512,216 @@
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
+	kernel_fpu_begin();
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
+		if ( (i%256)==0 ) {
+		  kernel_fpu_end();
+		  kernel_fpu_begin();
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
+	kernel_fpu_end();
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
+	kernel_fpu_end();
+	if(i=(len&63))
+	  __copy_user_zeroing(to, from, i);
+	return i;
+}
 
 unsigned long __copy_to_user_ll(void __user *to, const void *from,
unsigned long n)
 {
@@ -582,6 +793,36 @@
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
+__copy_from_user_ll_inatomic_nocache(void *to, const void __user
*from, unsigned long n)
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
diff -ur linux-2.6.12.4.orig/include/asm-i386/uaccess.h
linux-2.6.12.4.preempt/include/asm-i386/uaccess.h
--- linux-2.6.12.4.orig/include/asm-i386/uaccess.h	2005-08-05
16:04:37.000000000 +0900
+++ linux-2.6.12.4.preempt/include/asm-i386/uaccess.h	2005-08-18
19:16:55.000000000 +0900
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
+__copy_from_user_inatomic_nocache(void *to, const void __user *from,
unsigned long n)
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

-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com
