Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWD1CK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWD1CK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWD1CK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:10:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:747 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965178AbWD1CK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:10:26 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:10:21 +1000
Message-Id: <1060428021021.22243@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: [PATCH 002 of 2] Make copy_from_user_inatomic NOT zero the tail on i386
References: <20060428114321.21969.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As described in a previous patch and documented in mm/filemap.h,
copy_from_user_inatomic* shouldn't zero out the tail of the buffer
after an incomplete copy.

This patch implements that change for i386.

For the _nocache version, a new __copy_user_intel_nocache is defined
similar to copy_user_zeroio_intel_nocache, and this is ultimately
used for the copy.

For the regular version, __copy_to_user_inatomic is used to implement
__copy_from_user_inatomic as the only difference is that copy_to
doesn't zero the tail, just as we want.  Possibly this is a horrible
hack.  Comments welcome.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./arch/i386/lib/usercopy.c   |  106 +++++++++++++++++++++++++++++++++++++++++++
 ./include/asm-i386/uaccess.h |   31 +++++++-----
 2 files changed, 125 insertions(+), 12 deletions(-)

diff ./arch/i386/lib/usercopy.c~current~ ./arch/i386/lib/usercopy.c
--- ./arch/i386/lib/usercopy.c~current~	2006-04-28 10:31:13.000000000 +1000
+++ ./arch/i386/lib/usercopy.c	2006-04-28 10:36:34.000000000 +1000
@@ -528,6 +528,97 @@ static unsigned long __copy_user_zeroing
 	return size;
 }
 
+static unsigned long __copy_user_intel_nocache(void __user *to,
+				const void *from, unsigned long size)
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
@@ -709,6 +800,21 @@ unsigned long __copy_from_user_ll_nocach
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
--- ./include/asm-i386/uaccess.h~current~	2006-04-28 10:08:04.000000000 +1000
+++ ./include/asm-i386/uaccess.h	2006-04-28 10:37:12.000000000 +1000
@@ -393,6 +393,8 @@ unsigned long __must_check __copy_from_u
 				const void __user *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll_nocache(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache_nozero(void __user *to,
+				const void *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -464,11 +466,23 @@ __copy_to_user(void __user *to, const vo
  * atomic context and will fail rather than sleep.  In this case the
  * uncopied bytes will *NOT* be padded with zeros.  See fs/filemap.h
  * for explanation of why this is needed.
- * FIXME this isn't implimented yet EMXIF
  */
 static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
+	/* As the only difference between copy_from and copy_to is that
+	 * copy_from zeros any tail that wasn't actually copied to,
+	 * and as that is exactly what we want for inatomic copy_from,
+	 * we use copy_to_user_inatomic to implement
+	 * copy_from_user_inatomic.  Ofcourse we need to lie about
+	 * __user tags....
+	 */
+	return __copy_to_user_inatomic((void __user*)to, (const void *)from, n);
+}
+static __always_inline unsigned long
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	might_sleep();
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -489,9 +503,10 @@ __copy_from_user_inatomic(void *to, cons
 
 #define ARCH_HAS_NOCACHE_UACCESS
 
-static __always_inline unsigned long __copy_from_user_inatomic_nocache(void *to,
+static __always_inline unsigned long __copy_from_user_nocache(void *to,
 				const void __user *from, unsigned long n)
 {
+	might_sleep();
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -511,17 +526,9 @@ static __always_inline unsigned long __c
 }
 
 static __always_inline unsigned long
-__copy_from_user(void *to, const void __user *from, unsigned long n)
-{
-       might_sleep();
-       return __copy_from_user_inatomic(to, from, n);
-}
-
-static __always_inline unsigned long
-__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+__copy_from_user_inatomic_nocache(void *to, const void __user *from, unsigned long n)
 {
-       might_sleep();
-       return __copy_from_user_inatomic_nocache(to, from, n);
+       return __copy_from_user_ll_nocache_nozero((void __user *)to, (const void *)from, n);
 }
 
 unsigned long __must_check copy_to_user(void __user *to,
