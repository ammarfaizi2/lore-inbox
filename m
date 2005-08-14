Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVHNJQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVHNJQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVHNJQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:16:04 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:59421 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932408AbVHNJQB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:16:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NEfemdcwItedg12PK6VzKQ15RgqIewjAZai8OVh55sxb6Xi+f0EKEMgaHtaXZIWJZAd2Co1tLdUt1xcQnYwC9u46YI7c809uhs4/TAG6sDpBV6yKYEcIso+gC1vvLH9ZmkDChL4htG1+C73V3HKi01/hqRhEDL+cr8aeBJOjwnE=
Message-ID: <98df96d305081402164ce52f8@mail.gmail.com>
Date: Sun, 14 Aug 2005 18:16:00 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following is a patch to reduce a cache pollution
of __copy_from_user_ll().

When I run simple iozone benchmark to find a performance bottleneck of
the linux kernel, I found that __copy_from_user_ll() spent CPU cycle
most and it did many cache misses.

The following is profiled by oprofile.

Top 5 CPU cycle
CPU: P4 / Xeon, speed 2200.91 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
281538   15.2083  vmlinux                  __copy_from_user_ll
81069     4.3792  vmlinux                  _spin_lock
75523     4.0796  vmlinux                  journal_add_journal_head
63674     3.4396  vmlinux                  do_get_write_access
52634     2.8432  vmlinux                  journal_put_journal_head
(pattern9-0-cpu4-0-08141700/summary.out)

Top 5 Memory Access and Cache miss
CPU: P4 / Xeon, speed 2200.91 MHz (estimated)
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x3f (multiple flags) count 3000
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        samples  %        app name                 symbol name
120801    7.4379  37017    63.4603  vmlinux                  __copy_from_user_ll
84139     5.1806  885       1.5172  vmlinux                  _spin_lock
66027     4.0654  656       1.1246  vmlinux                 
journal_add_journal_head
60400     3.7189  250       0.4286  vmlinux                  __find_get_block
60032     3.6963  120       0.2057  vmlinux                 
journal_dirty_metadata

__copy_from_user_ll spent 63.4603% of L3 cache miss though it spent only
7.4379% of memory access.

In order to reduce the cache miss in the __copy_from_user_ll, I made
the following patch and confirmed the reduction of the miss.

Top 5 CPU cycle
CPU: P4 / Xeon, speed 2200.93 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
120717    8.3454  vmlinux                  _mmx_memcpy_nt
65955     4.5596  vmlinux                  do_get_write_access
56088     3.8775  vmlinux                  journal_put_journal_head
52550     3.6329  vmlinux                  journal_dirty_metadata
38886     2.6883  vmlinux                  journal_add_journal_head
pattern9-0-cpu4-0-08141627/summary.out

_mmx_memcpy_nt is the new function which is called from
__copy_from_user_ll and it spent only 42.88% of the original
implementation. (120717/281538==42.88%)

Top 5 Memory Access
CPU: P4 / Xeon, speed 2200.93 MHz (estimated)
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x3f (multiple flags) count 3000
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        samples  %        app name                 symbol name
90918     6.3079  89        0.5673  vmlinux                  _mmx_memcpy_nt
83654     5.8039  177       1.1283  vmlinux                 
journal_dirty_metadata
57836     4.0127  348       2.2183  vmlinux                 
journal_put_journal_head
48236     3.3466  165       1.0518  vmlinux                  do_get_write_access
44546     3.0906  21        0.1339  vmlinux                  __getblk

The cache miss reduced from 37017 (63.4603%) to 89 (0.5673%). It is
0.24% of the original implementation.

The actual elapse time which five times run  were 229.76 (sec) and
222.94 (sec). (229.76/222.94= 3.06% gain)

iozone -CMR -i 0 -+n -+u -s 8000MB -t 4 

What do you think?

--- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05
16:04:37.000000000 +0900
+++ linux-2.6.12.4/arch/i386/lib/usercopy.c	2005-08-12 13:18:14.106916200 +0900
@@ -10,6 +10,7 @@
  #include <linux/highmem.h>
  #include <linux/blkdev.h>
  #include <linux/module.h>
+#include <asm/i387.h>
  #include <asm/uaccess.h>
  #include <asm/mmx.h>
 
@@ -511,6 +512,108 @@
 		: "memory");						\
 } while (0)
 
+/* Non Temporal Hint version of mmx_memcpy */
+/* It is cache aware                       */
+/* hyoshiok@miraclelinux.com               */
+static unsigned long _mmx_memcpy_nt(void *to, const void *from, size_t len)
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
 
  unsigned long __copy_to_user_ll(void __user *to, const void *from,
unsigned long n)
 {
@@ -575,10 +678,14 @@
  __copy_from_user_ll(void *to, const void __user *from, unsigned long n)
 {
 	BUG_ON((long)n < 0);
-	if (movsl_is_ok(to, from, n))
+	if (n < 512) {
+	  if (movsl_is_ok(to, from, n))
 		__copy_user_zeroing(to, from, n);
-	else
+	  else
 		n = __copy_user_zeroing_intel(to, from, n);
+	}
+	else
+	  n = _mmx_memcpy_nt(to, from, n);
 	return n;
 }

Thanks in advance,
  Hiro
--
hyoshiok at miraclelinux.com
