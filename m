Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265912AbSKBJAf>; Sat, 2 Nov 2002 04:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265915AbSKBJAf>; Sat, 2 Nov 2002 04:00:35 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:40625 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S265912AbSKBJAZ>; Sat, 2 Nov 2002 04:00:25 -0500
Date: Sat, 02 Nov 2002 03:06:20 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>
Message-Id: <20021102025838.220E.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 03:06:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This consists mainly of the optimized copy routine for PIII/P4.

It is basically identical to what was introduced in 2.5.45.
However,
I tweaked a bit.  I deleted accessing ‘movsl_mask’ every time, which 
is unlikely to change during the run time.
If anybody finds a better copy routine, don’t have to touch uaccess.h.
just edit here.

Akira Tsukamoto

diff -Nur -X dontdiff linux-2.5.45/include/asm-i386/uaccess-intel.h linux-2.5.45-aki/include/asm-i386/uaccess-intel.h
--- linux-2.5.45/include/asm-i386/uaccess-intel.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.45-aki/include/asm-i386/uaccess-intel.h	Sat Nov  2 03:00:45 2002
@@ -0,0 +1,294 @@
+#ifndef __i386_UACCESS_INTEL_H
+#define __i386_UACCESS_INTEL_H
+/*
+ * PentiumIII/Pentium4  Copy To/From Userspace, taka version.
+ *
+ * Split into CPU specific files by Akira Tsukamoto to keep #ifdef noise down.
+ */
+
+#define MOVSL_MASK 7
+static inline int 
+is_rep_movsl_faster(const void *a1, const void *a2, unsigned long n)
+{
+	if (n >= 64 && (((const long)a1 ^ (const long)a2) & MOVSL_MASK))
+		return 0;
+	return 1;
+}
+
+/* Using rep; movsl. */
+#define __copy_user_rep_movsl(to,from,size)				\
+do {									\
+	int __d0, __d1, __d2;						\
+	__asm__ __volatile__(						\
+		"	cmp  $7,%0\n"					\
+		"	jbe  1f\n"					\
+		"	movl %1,%0\n"					\
+		"	negl %0\n"					\
+		"	andl $7,%0\n"					\
+		"	subl %0,%3\n"					\
+		"4:	rep; movsb\n"					\
+		"	movl %3,%0\n"					\
+		"	shrl $2,%0\n"					\
+		"	andl $3,%3\n"					\
+		"	.align 2,0x90\n"				\
+		"0:	rep; movsl\n"					\
+		"	movl %3,%0\n"					\
+		"1:	rep; movsb\n"					\
+		"2:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"5:	addl %3,%0\n"					\
+		"	jmp 2b\n"					\
+		"3:	lea 0(%3,%0,4),%0\n"				\
+		"	jmp 2b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 4b,5b\n"					\
+		"	.long 0b,3b\n"					\
+		"	.long 1b,2b\n"					\
+		".previous"						\
+		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
+		: "3"(size), "0"(size), "1"(to), "2"(from)		\
+		: "memory");						\
+} while (0)
+
+#define __copy_user_zeroing_rep_movsl(to,from,size)			\
+do {									\
+	int __d0, __d1, __d2;						\
+	__asm__ __volatile__(						\
+		"	cmp  $7,%0\n"					\
+		"	jbe  1f\n"					\
+		"	movl %1,%0\n"					\
+		"	negl %0\n"					\
+		"	andl $7,%0\n"					\
+		"	subl %0,%3\n"					\
+		"4:	rep; movsb\n"					\
+		"	movl %3,%0\n"					\
+		"	shrl $2,%0\n"					\
+		"	andl $3,%3\n"					\
+		"	.align 2,0x90\n"				\
+		"0:	rep; movsl\n"					\
+		"	movl %3,%0\n"					\
+		"1:	rep; movsb\n"					\
+		"2:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"5:	addl %3,%0\n"					\
+		"	jmp 6f\n"					\
+		"3:	lea 0(%3,%0,4),%0\n"				\
+		"6:	pushl %0\n"					\
+		"	pushl %%eax\n"					\
+		"	xorl %%eax,%%eax\n"				\
+		"	rep; stosb\n"					\
+		"	popl %%eax\n"					\
+		"	popl %0\n"					\
+		"	jmp 2b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 4b,5b\n"					\
+		"	.long 0b,3b\n"					\
+		"	.long 1b,6b\n"					\
+		".previous"						\
+		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
+		: "3"(size), "0"(size), "1"(to), "2"(from)		\
+		: "memory");						\
+} while (0)
+
+
+/* Using bulk movl. */
+#define __copy_user_movl(to,from,size)					\
+do {									\
+	int d0, d1;							\
+	__asm__ __volatile__(						\
+		       "       .align 2,0x90\n" 			\
+		       "0:     movl 32(%4), %%eax\n"			\
+		       "       cmpl $67, %0\n"     			\
+		       "       jbe 1f\n"            			\
+		       "       movl 64(%4), %%eax\n"			\
+		       "       .align 2,0x90\n"     			\
+		       "1:     movl 0(%4), %%eax\n" 			\
+		       "       movl 4(%4), %%edx\n" 			\
+		       "2:     movl %%eax, 0(%3)\n" 			\
+		       "21:    movl %%edx, 4(%3)\n" 			\
+		       "       movl 8(%4), %%eax\n" 			\
+		       "       movl 12(%4),%%edx\n" 			\
+		       "3:     movl %%eax, 8(%3)\n" 			\
+		       "31:    movl %%edx, 12(%3)\n"			\
+		       "       movl 16(%4), %%eax\n"			\
+		       "       movl 20(%4), %%edx\n"			\
+		       "4:     movl %%eax, 16(%3)\n"			\
+		       "41:    movl %%edx, 20(%3)\n"			\
+		       "       movl 24(%4), %%eax\n"			\
+		       "       movl 28(%4), %%edx\n"			\
+		       "10:    movl %%eax, 24(%3)\n"			\
+		       "51:    movl %%edx, 28(%3)\n"			\
+		       "       movl 32(%4), %%eax\n"			\
+		       "       movl 36(%4), %%edx\n"			\
+		       "11:    movl %%eax, 32(%3)\n"			\
+		       "61:    movl %%edx, 36(%3)\n"			\
+		       "       movl 40(%4), %%eax\n"			\
+		       "       movl 44(%4), %%edx\n"			\
+		       "12:    movl %%eax, 40(%3)\n"			\
+		       "71:    movl %%edx, 44(%3)\n"			\
+		       "       movl 48(%4), %%eax\n"			\
+		       "       movl 52(%4), %%edx\n"			\
+		       "13:    movl %%eax, 48(%3)\n"			\
+		       "81:    movl %%edx, 52(%3)\n"			\
+		       "       movl 56(%4), %%eax\n"			\
+		       "       movl 60(%4), %%edx\n"			\
+		       "14:    movl %%eax, 56(%3)\n"			\
+		       "91:    movl %%edx, 60(%3)\n"			\
+		       "       addl $-64, %0\n"     			\
+		       "       addl $64, %4\n"      			\
+		       "       addl $64, %3\n"      			\
+		       "       cmpl $63, %0\n"      			\
+		       "       ja  0b\n"            			\
+		       "5:     movl  %0, %%eax\n"   			\
+		       "       shrl  $2, %0\n"      			\
+		       "       andl  $3, %%eax\n"   			\
+		       "       cld\n"               			\
+		       "6:     rep; movsl\n"        			\
+		       "       movl %%eax, %0\n"    			\
+		       "7:     rep; movsb\n"				\
+		       "8:\n"						\
+		       ".section .fixup,\"ax\"\n"			\
+		       "9:     lea 0(%%eax,%0,4),%0\n"			\
+		       "       jmp 8b\n"				\
+		       ".previous\n"					\
+		       ".section __ex_table,\"a\"\n"			\
+		       "       .align 4\n"				\
+		       "       .long 2b,8b\n"				\
+		       "       .long 21b,8b\n"				\
+		       "       .long 3b,8b\n"				\
+		       "       .long 31b,8b\n"				\
+		       "       .long 4b,8b\n"				\
+		       "       .long 41b,8b\n"				\
+		       "       .long 10b,8b\n"				\
+		       "       .long 51b,8b\n"				\
+		       "       .long 11b,8b\n"				\
+		       "       .long 61b,8b\n"				\
+		       "       .long 12b,8b\n"				\
+		       "       .long 71b,8b\n"				\
+		       "       .long 13b,8b\n"				\
+		       "       .long 81b,8b\n"				\
+		       "       .long 14b,8b\n"				\
+		       "       .long 91b,8b\n"				\
+		       "       .long 6b,9b\n"				\
+		       "       .long 7b,8b\n"				\
+		       ".previous"					\
+		       : "=&c"(size), "=&D" (d0), "=&S" (d1)		\
+		       :  "1"(to), "2"(from), "0"(size)			\
+		       : "eax", "edx", "memory");			\
+} while (0)
+
+#define __copy_user_zeroing_movl(to,from,size)				\
+do {									\
+	int d0, d1;							\
+	__asm__ __volatile__(						\
+		       "        .align 2,0x90\n"			\
+		       "0:      movl 32(%4), %%eax\n"			\
+		       "        cmpl $67, %0\n"      			\
+		       "        jbe 2f\n"            			\
+		       "1:      movl 64(%4), %%eax\n"			\
+		       "        .align 2,0x90\n"     			\
+		       "2:      movl 0(%4), %%eax\n" 			\
+		       "21:     movl 4(%4), %%edx\n" 			\
+		       "        movl %%eax, 0(%3)\n" 			\
+		       "        movl %%edx, 4(%3)\n" 			\
+		       "3:      movl 8(%4), %%eax\n" 			\
+		       "31:     movl 12(%4),%%edx\n" 			\
+		       "        movl %%eax, 8(%3)\n" 			\
+		       "        movl %%edx, 12(%3)\n"			\
+		       "4:      movl 16(%4), %%eax\n"			\
+		       "41:     movl 20(%4), %%edx\n"			\
+		       "        movl %%eax, 16(%3)\n"			\
+		       "        movl %%edx, 20(%3)\n"			\
+		       "10:     movl 24(%4), %%eax\n"			\
+		       "51:     movl 28(%4), %%edx\n"			\
+		       "        movl %%eax, 24(%3)\n"			\
+		       "        movl %%edx, 28(%3)\n"			\
+		       "11:     movl 32(%4), %%eax\n"			\
+		       "61:     movl 36(%4), %%edx\n"			\
+		       "        movl %%eax, 32(%3)\n"			\
+		       "        movl %%edx, 36(%3)\n"			\
+		       "12:     movl 40(%4), %%eax\n"			\
+		       "71:     movl 44(%4), %%edx\n"			\
+		       "        movl %%eax, 40(%3)\n"			\
+		       "        movl %%edx, 44(%3)\n"			\
+		       "13:     movl 48(%4), %%eax\n"			\
+		       "81:     movl 52(%4), %%edx\n"			\
+		       "        movl %%eax, 48(%3)\n"			\
+		       "        movl %%edx, 52(%3)\n"			\
+		       "14:     movl 56(%4), %%eax\n"			\
+		       "91:     movl 60(%4), %%edx\n"			\
+		       "        movl %%eax, 56(%3)\n"			\
+		       "        movl %%edx, 60(%3)\n"			\
+		       "        addl $-64, %0\n"     			\
+		       "        addl $64, %4\n"      			\
+		       "        addl $64, %3\n"      			\
+		       "        cmpl $63, %0\n"      			\
+		       "        ja  0b\n"            			\
+		       "5:      movl  %0, %%eax\n"   			\
+		       "        shrl  $2, %0\n"      			\
+		       "        andl $3, %%eax\n"    			\
+		       "        cld\n"               			\
+		       "6:      rep; movsl\n"   			\
+		       "        movl %%eax,%0\n"			\
+		       "7:      rep; movsb\n"				\
+		       "8:\n"						\
+		       ".section .fixup,\"ax\"\n"			\
+		       "9:      lea 0(%%eax,%0,4),%0\n"			\
+		       "16:     pushl %0\n"				\
+		       "        pushl %%eax\n"				\
+		       "        xorl %%eax,%%eax\n"			\
+		       "        rep; stosb\n"				\
+		       "        popl %%eax\n"				\
+		       "        popl %0\n"				\
+		       "        jmp 8b\n"				\
+		       ".previous\n"					\
+		       ".section __ex_table,\"a\"\n"			\
+		       "	.align 4\n"	   			\
+		       "	.long 0b,16b\n"	 			\
+		       "	.long 1b,16b\n"				\
+		       "	.long 2b,16b\n"				\
+		       "	.long 21b,16b\n"			\
+		       "	.long 3b,16b\n"				\
+		       "	.long 31b,16b\n"			\
+		       "	.long 4b,16b\n"				\
+		       "	.long 41b,16b\n"			\
+		       "	.long 10b,16b\n"			\
+		       "	.long 51b,16b\n"			\
+		       "	.long 11b,16b\n"			\
+		       "	.long 61b,16b\n"			\
+		       "	.long 12b,16b\n"			\
+		       "	.long 71b,16b\n"			\
+		       "	.long 13b,16b\n"			\
+		       "	.long 81b,16b\n"			\
+		       "	.long 14b,16b\n"			\
+		       "	.long 91b,16b\n"			\
+		       "	.long 6b,9b\n"				\
+		       "        .long 7b,16b\n" 			\
+		       ".previous"					\
+		       : "=&c"(size), "=&D" (d0), "=&S" (d1)		\
+		       :  "1"(to), "2"(from), "0"(size)			\
+		       : "eax", "edx", "memory");			\
+} while (0)
+
+/* These two will go inside copy_to/from_user() in usercopy.c */
+#define __do_copy_user(to,from,n)					\
+do {									\
+	if (is_rep_movsl_faster(to, from, n))				\
+		__copy_user_rep_movsl(to, from, n);			\
+	else								\
+		__copy_user_movl(to, from, n);				\
+} while (0)
+
+#define __do_copy_user_zeroing(to,from,n)				\
+do {									\
+	if (is_rep_movsl_faster(to, from, n))				\
+		__copy_user_zeroing_rep_movsl(to,from,n);		\
+	else								\
+		__copy_user_zeroing_movl(to, from, n);			\
+} while (0)
+
+#endif /* __i386_UACCESS_INTEL_H */



