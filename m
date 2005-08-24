Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVHXOQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVHXOQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVHXOQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:16:41 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:16204 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751010AbVHXOQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:16:40 -0400
Date: Wed, 24 Aug 2005 23:11:56 +0900 (JST)
Message-Id: <20050824.231156.278740508.hyoshiok@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050823.081246.846946371.hyoshiok@miraclelinux.com>
References: <20050818.201138.607962419.hyoshiok@miraclelinux.com>
	<98df96d30508181629d85edb5@mail.gmail.com>
	<20050823.081246.846946371.hyoshiok@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch does not use MMX regsiters so that we don't have
to worry about save/restore the FPU/MMX states.

What do you think?

Some performance data are

Total of GLOBAL_POWER_EVENTS (CPU cycle samples)

2.6.12.4.orig    1921587
2.6.12.4.nt      1688900
1688900/1921587=87.89% (12.1% reduction)
 
BSQ_CACHE_REFERENCE (L3 cache miss)
2.6.12.4.orig      57427
2.6.12.4.preempt   17122
17122/57427=29.81% (70.18% reduction)

L3 cache miss reduction of __copy_from_user_ll
samples  %
37408    65.1412  vmlinux                  __copy_from_user_ll
24        0.1402  vmlinux                  __copy_user_zeroing_intel_nocache
24/37408=0.064% (99.93% reduction)

> Top 5 2.6.12.4.orig
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
> samples  %        app name                 symbol name
> 287643   14.9692  vmlinux                  __copy_from_user_ll
> 72660     3.7813  vmlinux                  journal_add_journal_head
> 65011     3.3832  vmlinux                  do_get_write_access
> 50618     2.6342  vmlinux                  journal_put_journal_head
> 48068     2.5015  vmlinux                  journal_dirty_metadata
> pattern9-0-cpu4-0-08191743/summary.out
> 
> Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x3f (multiple flags) count 3000
> samples  %        app name                 symbol name
> 134756    7.9364  vmlinux                  __copy_from_user_ll
> 57735     3.4003  vmlinux                  journal_add_journal_head
> 50653     2.9832  vmlinux                  __find_get_block
> 44522     2.6221  vmlinux                  journal_put_journal_head
> 38928     2.2927  vmlinux                  journal_dirty_metadata
> pattern9-0-cpu4-0-08191741/summary.out
> 
> Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
> samples  %        app name                 symbol name
> 37408    65.1412  vmlinux                  __copy_from_user_ll
> 953       1.6595  vmlinux                  blk_rq_map_sg
> 886       1.5429  vmlinux                  sub_preempt_count
> 680       1.1841  vmlinux                  journal_add_journal_head
> 598       1.0413  vmlinux                  journal_commit_transaction
> pattern9-0-cpu4-0-08191720/summary.out
> 

The following data is an implementation without the MMX registers.
Top 5 2.6.12.4.nt
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
137744    8.1560  vmlinux                  __copy_user_zeroing_intel_nocache
68723     4.0692  vmlinux                  do_get_write_access
65808     3.8966  vmlinux                  journal_add_journal_head
50373     2.9826  vmlinux                  journal_dirty_metadata
49038     2.9036  vmlinux                  journal_put_journal_head
pattern9-0-cpu4-0-08242225/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x3f (multiple flags) count 3000
samples  %        app name                 symbol name
62165     3.7913  vmlinux                  __copy_user_zeroing_intel_nocache
57862     3.5289  vmlinux                  journal_add_journal_head
54230     3.3073  vmlinux                  __find_get_block
48335     2.9478  vmlinux                  journal_put_journal_head
35737     2.1795  vmlinux                  journal_dirty_metadata
pattern9-0-cpu4-0-08242152/summary.out

Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        app name                 symbol name
867       5.0637  vmlinux                  blk_rq_map_sg
694       4.0533  vmlinux                  journal_add_journal_head
629       3.6736  vmlinux                  journal_commit_transaction
624       3.6444  vmlinux                  radix_tree_delete
525       3.0662  vmlinux                  release_pages
pattern9-0-cpu4-0-08242147/summary.out

The following is MMX version of cache aware implementation.

> Top 5 2.6.12.4.preempt
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask of 0x01 (mandatory) count 100000
> samples  %        app name                 symbol name
> 123531    7.5582  vmlinux                  __copy_user_zeroing_inatomic_nocache
> 64820     3.9660  vmlinux                  journal_add_journal_head
> 60460     3.6992  vmlinux                  do_get_write_access
> 47172     2.8862  vmlinux                  journal_put_journal_head
> 46753     2.8606  vmlinux                  journal_dirty_metadata
> pattern9-0-cpu4-0-08190838/summary.out
> 
> Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x3f (multiple flags) count 3000
> samples  %        app name                 symbol name
> 126762    6.7993  vmlinux                  __copy_user_zeroing_inatomic_nocache
> 79803     4.2805  vmlinux                  journal_add_journal_head
> 70271     3.7692  vmlinux                  journal_dirty_metadata
> 66146     3.5480  vmlinux                  __find_get_block
> 58082     3.1154  vmlinux                  journal_put_journal_head
> pattern9-0-cpu4-0-08190855/summary.out
> 
> Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
> samples  %        app name                 symbol name
> 901       5.1788  vmlinux                  blk_rq_map_sg
> 675       3.8798  vmlinux                  journal_commit_transaction
> 637       3.6613  vmlinux                  radix_tree_delete
> 605       3.4774  vmlinux                  journal_add_journal_head
> 580       3.3337  vmlinux                  release_pages
> ...
> 51        0.2931  vmlinux                  __copy_user_zeroing_inatomic_nocache
> ...
> 1         0.0057  vmlinux                  __copy_from_user_ll_inatomic_nocache
> pattern9-0-cpu4-0-08190859/summary.out

diff -ur linux-2.6.12.4.orig/Makefile linux-2.6.12.4.nt/Makefile
--- linux-2.6.12.4.orig/Makefile	2005-08-12 14:37:59.000000000 +0900
+++ linux-2.6.12.4.nt/Makefile	2005-08-24 17:23:57.000000000 +0900
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .4.orig
+EXTRAVERSION = .4.nt
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -ur linux-2.6.12.4.orig/arch/i386/lib/usercopy.c linux-2.6.12.4.nt/arch/i386/lib/usercopy.c
--- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nt/arch/i386/lib/usercopy.c	2005-08-24 21:38:47.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <asm/i387.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -421,6 +422,106 @@
 		       : "eax", "edx", "memory");
 	return size;
 }
+
+/* Non Temporal Hint version of __copy_user_zeroing_intel */
+/* It is cache aware.                                     */
+/* hyoshiok@miraclelinux.com                              */
+static unsigned long 
+__copy_user_zeroing_intel_nocache(void *to, const void __user *from, unsigned long size)
+{
+        int d0, d1;
+
+	__asm__ __volatile__(
+		       "        .align 2,0x90\n"
+		       "0:      movl 32(%4), %%eax\n"
+		       "        cmpl $67, %0\n"      
+		       "        jbe 2f\n"            
+		       "1:      movl 64(%4), %%eax\n"
+		       "        .align 2,0x90\n"     
+		       "2:      movl 0(%4), %%eax\n" 
+		       "21:     movl 4(%4), %%edx\n" 
+		       "        movnti %%eax, 0(%3)\n" 
+		       "        movnti %%edx, 4(%3)\n" 
+		       "3:      movl 8(%4), %%eax\n" 
+		       "31:     movl 12(%4),%%edx\n" 
+		       "        movnti %%eax, 8(%3)\n" 
+		       "        movnti %%edx, 12(%3)\n"
+		       "4:      movl 16(%4), %%eax\n"
+		       "41:     movl 20(%4), %%edx\n"
+		       "        movnti %%eax, 16(%3)\n"
+		       "        movnti %%edx, 20(%3)\n"
+		       "10:     movl 24(%4), %%eax\n"
+		       "51:     movl 28(%4), %%edx\n"
+		       "        movnti %%eax, 24(%3)\n"
+		       "        movnti %%edx, 28(%3)\n"
+		       "11:     movl 32(%4), %%eax\n"
+		       "61:     movl 36(%4), %%edx\n"
+		       "        movnti %%eax, 32(%3)\n"
+		       "        movnti %%edx, 36(%3)\n"
+		       "12:     movl 40(%4), %%eax\n"
+		       "71:     movl 44(%4), %%edx\n"
+		       "        movnti %%eax, 40(%3)\n"
+		       "        movnti %%edx, 44(%3)\n"
+		       "13:     movl 48(%4), %%eax\n"
+		       "81:     movl 52(%4), %%edx\n"
+		       "        movnti %%eax, 48(%3)\n"
+		       "        movnti %%edx, 52(%3)\n"
+		       "14:     movl 56(%4), %%eax\n"
+		       "91:     movl 60(%4), %%edx\n"
+		       "        movnti %%eax, 56(%3)\n"
+		       "        movnti %%edx, 60(%3)\n"
+		       "        addl $-64, %0\n"     
+		       "        addl $64, %4\n"      
+		       "        addl $64, %3\n"      
+		       "        cmpl $63, %0\n"      
+		       "        ja  0b\n"            
+		       "5:      movl  %0, %%eax\n"   
+		       "        shrl  $2, %0\n"      
+		       "        andl $3, %%eax\n"    
+		       "        cld\n"               
+		       "6:      rep; movsl\n"   
+		       "        movl %%eax,%0\n"
+		       "7:      rep; movsb\n"	
+		       "8:\n"			
+		       ".section .fixup,\"ax\"\n"
+		       "9:      lea 0(%%eax,%0,4),%0\n"	
+		       "16:     pushl %0\n"	
+		       "        pushl %%eax\n"	
+		       "        xorl %%eax,%%eax\n"
+		       "        rep; stosb\n"	
+		       "        popl %%eax\n"	
+		       "        popl %0\n"	
+		       "        jmp 8b\n"	
+		       ".previous\n"		
+		       ".section __ex_table,\"a\"\n"
+		       "	.align 4\n"	   
+		       "	.long 0b,16b\n"	 
+		       "	.long 1b,16b\n"
+		       "	.long 2b,16b\n"
+		       "	.long 21b,16b\n"
+		       "	.long 3b,16b\n"	
+		       "	.long 31b,16b\n"
+		       "	.long 4b,16b\n"	
+		       "	.long 41b,16b\n"
+		       "	.long 10b,16b\n"
+		       "	.long 51b,16b\n"
+		       "	.long 11b,16b\n"
+		       "	.long 61b,16b\n"
+		       "	.long 12b,16b\n"
+		       "	.long 71b,16b\n"
+		       "	.long 13b,16b\n"
+		       "	.long 81b,16b\n"
+		       "	.long 14b,16b\n"
+		       "	.long 91b,16b\n"
+		       "	.long 6b,9b\n"	
+		       "        .long 7b,16b\n" 
+		       ".previous"		
+		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
+		       :  "1"(to), "2"(from), "0"(size)
+		       : "eax", "edx", "memory");
+	return size;
+}
+
 #else
 /*
  * Leave these declared but undefined.  They should not be any references to
@@ -430,6 +531,8 @@
 __copy_user_zeroing_intel(void *to, const void __user *from, unsigned long size);
 unsigned long
 __copy_user_intel(void __user *to, const void *from, unsigned long size);
+unsigned long
+__copy_user_zeroing_intel_nocache(void *to, const void __user *from, unsigned long size);
 #endif /* CONFIG_X86_INTEL_USERCOPY */
 
 /* Generic arbitrary sized copy.  */
@@ -511,7 +614,6 @@
 		: "memory");						\
 } while (0)
 
-
 unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
 {
 	BUG_ON((long) n < 0);
@@ -582,6 +684,21 @@
 	return n;
 }
 
+unsigned long
+__copy_from_user_ll_nocache(void *to, const void __user *from, unsigned long n)
+{
+	BUG_ON((long)n < 0);
+#ifdef CONFIG_X86_INTEL_USERCOPY
+	if ( n > 64)
+                n = __copy_user_zeroing_intel_nocache(to, from, n);
+	else
+		__copy_user_zeroing(to, from, n);
+#else
+        __copy_user_zeroing(to, from, n);
+#endif
+	return n;
+}
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
diff -ur linux-2.6.12.4.orig/include/asm-i386/uaccess.h linux-2.6.12.4.nt/include/asm-i386/uaccess.h
--- linux-2.6.12.4.orig/include/asm-i386/uaccess.h	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nt/include/asm-i386/uaccess.h	2005-08-24 18:18:57.000000000 +0900
@@ -413,6 +413,8 @@
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -502,11 +504,40 @@
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
+
+static inline unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_from_user_inatomic_nocache(to, from, n);
+}
+
 unsigned long __must_check copy_to_user(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check copy_from_user(void *to,
diff -ur linux-2.6.12.4.orig/mm/filemap.c linux-2.6.12.4.nt/mm/filemap.c
--- linux-2.6.12.4.orig/mm/filemap.c	2005-08-05 16:04:37.000000000 +0900
+++ linux-2.6.12.4.nt/mm/filemap.c	2005-08-16 10:16:06.000000000 +0900
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
