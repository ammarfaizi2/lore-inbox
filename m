Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWEVEwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWEVEwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWEVEwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:52:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:5577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWEVEwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:52:00 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 14:46:56 +1000
Cc: linux-kernel@vger.kernel.org
Message-Id: <1060522044656.31280@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 002 of 2] Make copy_from_user_inatomic NOT zero the tail on i386
References: <20060522143524.25410.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As described in a previous patch and documented in mm/filemap.h,
copy_from_user_inatomic* shouldn't zero out the tail of the buffer
after an incomplete copy.

This patch implements that change for i386.

For the _nocache version, a new __copy_user_intel_nocache is defined
similar to copy_user_zeroio_intel_nocache, and this is ultimately
used for the copy.

For the regular version, __copy_from_user_ll_nozero is defined which
uses __copy_user and __copy_user_intel - the later needs casts to
reposition the __user annotations.

If copy_from_user_atomic is given a constant length of 1, 2, or 4,
then we do still zero the destintion on failure.  This didn't seem
worth the effort of fixing as the places where it is used really
don't care.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./arch/i386/lib/usercopy.c   |  119 +++++++++++++++++++++++++++++++++++++++++++
 ./include/asm-i386/uaccess.h |   46 ++++++++++++----
 2 files changed, 153 insertions(+), 12 deletions(-)

diff ./arch/i386/lib/usercopy.c~current~ ./arch/i386/lib/usercopy.c
--- ./arch/i386/lib/usercopy.c~current~	2006-05-22 11:48:30.000000000 +1000
+++ ./arch/i386/lib/usercopy.c	2006-05-22 14:34:09.000000000 +1000
@@ -528,6 +528,97 @@ static unsigned long __copy_user_zeroing
 	return size;
 }
 
+static unsigned long __copy_user_intel_nocache(void *to,
+				const void __user *from, unsigned long size)
+{
+        int d0, d1;
+
+	__asm__ __volatile__(
+	       "        .align 2,0x90\n"
+	       "0:      movl 32(%4), %%eax\n"
+	       "        cmpl $67, %0\n"
+	       "        jbe 2f\n"
+	       "1:      movl 64(%4), %%eax\n"
+	       "        .align 2,0x90\n"
+	       "2:      movl 0(%4), %%eax\n"
+	       "21:     movl 4(%4), %%edx\n"
+	       "        movnti %%eax, 0(%3)\n"
+	       "        movnti %%edx, 4(%3)\n"
+	       "3:      movl 8(%4), %%eax\n"
+	       "31:     movl 12(%4),%%edx\n"
+	       "        movnti %%eax, 8(%3)\n"
+	       "        movnti %%edx, 12(%3)\n"
+	       "4:      movl 16(%4), %%eax\n"
+	       "41:     movl 20(%4), %%edx\n"
+	       "        movnti %%eax, 16(%3)\n"
+	       "        movnti %%edx, 20(%3)\n"
+	       "10:     movl 24(%4), %%eax\n"
+	       "51:     movl 28(%4), %%edx\n"
+	       "        movnti %%eax, 24(%3)\n"
+	       "        movnti %%edx, 28(%3)\n"
+	       "11:     movl 32(%4), %%eax\n"
+	       "61:     movl 36(%4), %%edx\n"
+	       "        movnti %%eax, 32(%3)\n"
+	       "        movnti %%edx, 36(%3)\n"
+	       "12:     movl 40(%4), %%eax\n"
+	       "71:     movl 44(%4), %%edx\n"
+	       "        movnti %%eax, 40(%3)\n"
+	       "        movnti %%edx, 44(%3)\n"
+	       "13:     movl 48(%4), %%eax\n"
+	       "81:     movl 52(%4), %%edx\n"
+	       "        movnti %%eax, 48(%3)\n"
+	       "        movnti %%edx, 52(%3)\n"
+	       "14:     movl 56(%4), %%eax\n"
+	       "91:     movl 60(%4), %%edx\n"
+	       "        movnti %%eax, 56(%3)\n"
+	       "        movnti %%edx, 60(%3)\n"
+	       "        addl $-64, %0\n"
+	       "        addl $64, %4\n"
+	       "        addl $64, %3\n"
+	       "        cmpl $63, %0\n"
+	       "        ja  0b\n"
+	       "        sfence \n"
+	       "5:      movl  %0, %%eax\n"
+	       "        shrl  $2, %0\n"
+	       "        andl $3, %%eax\n"
+	       "        cld\n"
+	       "6:      rep; movsl\n"
+	       "        movl %%eax,%0\n"
+	       "7:      rep; movsb\n"
+	       "8:\n"
+	       ".section .fixup,\"ax\"\n"
+	       "9:      lea 0(%%eax,%0,4),%0\n"
+	       "16:     jmp 8b\n"
+	       ".previous\n"
+	       ".section __ex_table,\"a\"\n"
+	       "	.align 4\n"
+	       "	.long 0b,16b\n"
+	       "	.long 1b,16b\n"
+	       "	.long 2b,16b\n"
+	       "	.long 21b,16b\n"
+	       "	.long 3b,16b\n"
+	       "	.long 31b,16b\n"
+	       "	.long 4b,16b\n"
+	       "	.long 41b,16b\n"
+	       "	.long 10b,16b\n"
+	       "	.long 51b,16b\n"
+	       "	.long 11b,16b\n"
+	       "	.long 61b,16b\n"
+	       "	.long 12b,16b\n"
+	       "	.long 71b,16b\n"
+	       "	.long 13b,16b\n"
+	       "	.long 81b,16b\n"
+	       "	.long 14b,16b\n"
+	       "	.long 91b,16b\n"
+	       "	.long 6b,9b\n"
+	       "        .long 7b,16b\n"
+	       ".previous"
+	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
+	       :  "1"(to), "2"(from), "0"(size)
+	       : "eax", "edx", "memory");
+	return size;
+}
+
 #else
 
 /*
@@ -694,6 +785,19 @@ unsigned long __copy_from_user_ll(void *
 }
 EXPORT_SYMBOL(__copy_from_user_ll);
 
+unsigned long __copy_from_user_ll_nozero(void *to, const void __user *from,
+					 unsigned long n)
+{
+	BUG_ON((long)n < 0);
+	if (movsl_is_ok(to, from, n))
+		__copy_user(to, from, n);
+	else
+		n = __copy_user_intel((void __user *)to,
+				      (const void *)from, n);
+	return n;
+}
+EXPORT_SYMBOL(__copy_from_user_ll_nozero);
+
 unsigned long __copy_from_user_ll_nocache(void *to, const void __user *from,
 					unsigned long n)
 {
@@ -709,6 +813,21 @@ unsigned long __copy_from_user_ll_nocach
 	return n;
 }
 
+unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
+					unsigned long n)
+{
+	BUG_ON((long)n < 0);
+#ifdef CONFIG_X86_INTEL_USERCOPY
+	if ( n > 64 && cpu_has_xmm2)
+                n = __copy_user_intel_nocache(to, from, n);
+	else
+		__copy_user(to, from, n);
+#else
+        __copy_user(to, from, n);
+#endif
+	return n;
+}
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.

diff ./include/asm-i386/uaccess.h~current~ ./include/asm-i386/uaccess.h
--- ./include/asm-i386/uaccess.h~current~	2006-05-22 11:20:26.000000000 +1000
+++ ./include/asm-i386/uaccess.h	2006-05-22 14:25:28.000000000 +1000
@@ -390,8 +390,12 @@ unsigned long __must_check __copy_to_use
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nozero(void *to,
+				const void __user *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll_nocache(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache_nozero(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -463,11 +467,36 @@ __copy_to_user(void __user *to, const vo
  * atomic context and will fail rather than sleep.  In this case the
  * uncopied bytes will *NOT* be padded with zeros.  See fs/filemap.h
  * for explanation of why this is needed.
- * FIXME this isn't implimented yet EMXIF
  */
 static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
+	/* Avoid zeroing the tail if the copy fails..
+	 * If 'n' is constant and 1, 2, or 4, we do still zero on a failure,
+	 * but as the zeroing behaviour is only significant when n is not
+	 * constant, that shouldn't be a problem.
+	 */
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
+	return __copy_from_user_ll_nozero(to, from, n);
+}
+static __always_inline unsigned long
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	might_sleep();
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -488,9 +517,10 @@ __copy_from_user_inatomic(void *to, cons
 
 #define ARCH_HAS_NOCACHE_UACCESS
 
-static __always_inline unsigned long __copy_from_user_inatomic_nocache(void *to,
+static __always_inline unsigned long __copy_from_user_nocache(void *to,
 				const void __user *from, unsigned long n)
 {
+	might_sleep();
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -510,17 +540,9 @@ static __always_inline unsigned long __c
 }
 
 static __always_inline unsigned long
-__copy_from_user(void *to, const void __user *from, unsigned long n)
+__copy_from_user_inatomic_nocache(void *to, const void __user *from, unsigned long n)
 {
-       might_sleep();
-       return __copy_from_user_inatomic(to, from, n);
-}
-
-static __always_inline unsigned long
-__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
-{
-       might_sleep();
-       return __copy_from_user_inatomic_nocache(to, from, n);
+       return __copy_from_user_ll_nocache_nozero(to, from, n);
 }
 
 unsigned long __must_check copy_to_user(void __user *to,
