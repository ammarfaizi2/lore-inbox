Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272936AbSISUha>; Thu, 19 Sep 2002 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272978AbSISUh2>; Thu, 19 Sep 2002 16:37:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:24226 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S272936AbSISUhT>;
	Thu, 19 Sep 2002 16:37:19 -0400
Message-ID: <3D8A36A5.846D806@digeo.com>
Date: Thu, 19 Sep 2002 13:42:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: alan@lxorguk.ukuu.org.uk, davem@redhat.com, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
References: <3D89176B.40FFD09B@digeo.com> <20020919.221513.28808421.taka@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 20:42:16.0713 (UTC) FILETIME=[0A8D0F90:01C2601D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> ...
> > It needs redoing.  These differences are really big, and this
> > is the kernel's most expensive function.
> >
> > A little project for someone.
> 
> OK, if there is nobody who wants to do it I'll do it by myself.

That would be fantastic - thanks.  This is more a measurement
and testing exercise than a coding one.  And if those measurements
are sufficiently nice (eg: >5%) then a 2.4 backport should be done.

It seems that movsl works acceptably with all alignments on AMD
hardware, although this needs to be checked with more recent machines.

movsl is a (bad) loss on PII and PIII for all alignments except 8&8.
Don't know about P4 - I can test that in a day or two.

I expect that a minimal, 90% solution would be just:

fancy_copy_to_user(dst, src, count)
{
	if (arch_has_sane_movsl || ((dst|src) & 7) == 0)
		movsl_copy_to_user(dst, src, count);
	else
		movl_copy_to_user(dst, src, count);
}

and

#ifndef ARCH_HAS_FANCY_COPY_USER
#define fancy_copy_to_user copy_to_user
#endif

and we really only need fancy_copy_to_user in a handful of
places - the bulk copies in networking and filemap.c.  For all
the other call sites it's probably more important to keep the
code footprint down than it is to squeeze the last few drops out
of the copy speed.

Mala Anand has done some work on this.  See
http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.3/0100.html

<searches>  Yes, I have a copy of Mala's patch here which works
against 2.5.current.  Mala's patch will cause quite an expansion
of kernel size; we would need an implementation which did not
use inlining.  This work was discussed at OLS2002.  See
http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz


 uaccess.h |  252 +++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 193 insertions(+), 59 deletions(-)

--- 2.5.25/include/asm-i386/uaccess.h~fast-cu	Tue Jul  9 21:34:58 2002
+++ 2.5.25-akpm/include/asm-i386/uaccess.h	Tue Jul  9 21:51:03 2002
@@ -253,55 +253,197 @@ do {									\
  */
 
 /* Generic arbitrary sized copy.  */
-#define __copy_user(to,from,size)					\
-do {									\
-	int __d0, __d1;							\
-	__asm__ __volatile__(						\
-		"0:	rep; movsl\n"					\
-		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
-		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
-		"	.align 4\n"					\
-		"	.long 0b,3b\n"					\
-		"	.long 1b,2b\n"					\
-		".previous"						\
-		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
-		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
-		: "memory");						\
+#define __copy_user(to,from,size)				\
+do {								\
+	int __d0, __d1;						\
+	__asm__ __volatile__(					\
+	"       cmpl $63, %0\n"					\
+	"       jbe  5f\n"					\
+	"       mov %%esi, %%eax\n"				\
+	"       test $7, %%al\n"				\
+	"       jz  5f\n"					\
+	"       .align 2,0x90\n"				\
+	"0:     movl 32(%4), %%eax\n"				\
+	"       cmpl $67, %0\n"					\
+	"       jbe 1f\n"					\
+	"       movl 64(%4), %%eax\n"				\
+	"       .align 2,0x90\n"				\
+	"1:     movl 0(%4), %%eax\n"				\
+	"       movl 4(%4), %%edx\n"				\
+	"2:     movl %%eax, 0(%3)\n"				\
+	"21:    movl %%edx, 4(%3)\n"				\
+	"       movl 8(%4), %%eax\n"				\
+	"       movl 12(%4),%%edx\n"				\
+	"3:     movl %%eax, 8(%3)\n"				\
+	"31:    movl %%edx, 12(%3)\n"				\
+	"       movl 16(%4), %%eax\n"				\
+	"       movl 20(%4), %%edx\n"				\
+	"4:     movl %%eax, 16(%3)\n"				\
+	"41:    movl %%edx, 20(%3)\n"				\
+	"       movl 24(%4), %%eax\n"				\
+	"       movl 28(%4), %%edx\n"				\
+	"10:    movl %%eax, 24(%3)\n"				\
+	"51:    movl %%edx, 28(%3)\n"				\
+	"       movl 32(%4), %%eax\n"				\
+	"       movl 36(%4), %%edx\n"				\
+	"11:    movl %%eax, 32(%3)\n"				\
+	"61:    movl %%edx, 36(%3)\n"				\
+	"       movl 40(%4), %%eax\n"				\
+	"       movl 44(%4), %%edx\n"				\
+	"12:    movl %%eax, 40(%3)\n"				\
+	"71:    movl %%edx, 44(%3)\n"				\
+	"       movl 48(%4), %%eax\n"				\
+	"       movl 52(%4), %%edx\n"				\
+	"13:    movl %%eax, 48(%3)\n"				\
+	"81:    movl %%edx, 52(%3)\n"				\
+	"       movl 56(%4), %%eax\n"				\
+	"       movl 60(%4), %%edx\n"				\
+	"14:    movl %%eax, 56(%3)\n"				\
+	"91:    movl %%edx, 60(%3)\n"				\
+	"       addl $-64, %0\n"				\
+	"       addl $64, %4\n"					\
+	"       addl $64, %3\n"					\
+	"       cmpl $63, %0\n"					\
+	"       ja  0b\n"					\
+	"5:   movl  %0, %%eax\n"				\
+	"       shrl  $2, %0\n"					\
+	"       andl  $3, %%eax\n"				\
+	"       cld\n"						\
+	"6:     rep; movsl\n"					\
+	"       movl %%eax, %0\n"				\
+	"7:   rep; movsb\n"					\
+	"8:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"9:   lea 0(%%eax,%0,4),%0\n"				\
+	"     jmp 8b\n"						\
+	"15:    movl %6, %0\n"					\
+	"       jmp 8b\n"					\
+	".previous\n"						\
+	".section __ex_table,\"a\"\n"				\
+	"     .align 4\n"					\
+	"     .long 2b,15b\n"					\
+	"     .long 21b,15b\n"					\
+	"     .long 3b,15b\n"					\
+	"     .long 31b,15b\n"					\
+	"     .long 4b,15b\n"					\
+	"     .long 41b,15b\n"					\
+	"     .long 10b,15b\n"					\
+	"     .long 51b,15b\n"					\
+	"     .long 11b,15b\n"					\
+	"     .long 61b,15b\n"					\
+	"     .long 12b,15b\n"					\
+	"     .long 71b,15b\n"					\
+	"     .long 13b,15b\n"					\
+	"     .long 81b,15b\n"					\
+	"     .long 14b,15b\n"					\
+	"     .long 91b,15b\n"					\
+	"     .long 6b,9b\n"					\
+	"       .long 7b,8b\n"					\
+	".previous"						\
+	: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
+	:  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)		\
+	: "eax", "edx", "memory");				\
 } while (0)
 
-#define __copy_user_zeroing(to,from,size)				\
-do {									\
-	int __d0, __d1;							\
-	__asm__ __volatile__(						\
-		"0:	rep; movsl\n"					\
-		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
-		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"4:	pushl %0\n"					\
-		"	pushl %%eax\n"					\
-		"	xorl %%eax,%%eax\n"				\
-		"	rep; stosb\n"					\
-		"	popl %%eax\n"					\
-		"	popl %0\n"					\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
-		"	.align 4\n"					\
-		"	.long 0b,3b\n"					\
-		"	.long 1b,4b\n"					\
-		".previous"						\
-		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
-		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
-		: "memory");						\
-} while (0)
+#define __copy_user_zeroing(to,from,size)			\
+do {								\
+	int __d0, __d1;						\
+	__asm__ __volatile__(					\
+	"       cmpl $63, %0\n"					\
+	"       jbe  5f\n"					\
+	"       movl %%edi, %%eax\n"				\
+	"       test $7, %%al\n"				\
+	"       jz   5f\n"					\
+	"       .align 2,0x90\n"				\
+	"0:     movl 32(%4), %%eax\n"				\
+	"       cmpl $67, %0\n"					\
+	"       jbe 2f\n"					\
+	"1:     movl 64(%4), %%eax\n"				\
+	"       .align 2,0x90\n"				\
+	"2:     movl 0(%4), %%eax\n"				\
+	"21:    movl 4(%4), %%edx\n"				\
+	"       movl %%eax, 0(%3)\n"				\
+	"       movl %%edx, 4(%3)\n"				\
+	"3:     movl 8(%4), %%eax\n"				\
+	"31:    movl 12(%4),%%edx\n"				\
+	"       movl %%eax, 8(%3)\n"				\
+	"       movl %%edx, 12(%3)\n"				\
+	"4:     movl 16(%4), %%eax\n"				\
+	"41:    movl 20(%4), %%edx\n"				\
+	"       movl %%eax, 16(%3)\n"				\
+	"       movl %%edx, 20(%3)\n"				\
+	"10:    movl 24(%4), %%eax\n"				\
+	"51:    movl 28(%4), %%edx\n"				\
+	"       movl %%eax, 24(%3)\n"				\
+	"       movl %%edx, 28(%3)\n"				\
+	"11:    movl 32(%4), %%eax\n"				\
+	"61:    movl 36(%4), %%edx\n"				\
+	"       movl %%eax, 32(%3)\n"				\
+	"       movl %%edx, 36(%3)\n"				\
+	"12:    movl 40(%4), %%eax\n"				\
+	"71:    movl 44(%4), %%edx\n"				\
+	"       movl %%eax, 40(%3)\n"				\
+	"       movl %%edx, 44(%3)\n"				\
+	"13:    movl 48(%4), %%eax\n"				\
+	"81:    movl 52(%4), %%edx\n"				\
+	"       movl %%eax, 48(%3)\n"				\
+	"       movl %%edx, 52(%3)\n"				\
+	"14:    movl 56(%4), %%eax\n"				\
+	"91:    movl 60(%4), %%edx\n"				\
+	"       movl %%eax, 56(%3)\n"				\
+	"       movl %%edx, 60(%3)\n"				\
+	"       addl $-64, %0\n"				\
+	"       addl $64, %4\n"					\
+	"       addl $64, %3\n"					\
+	"       cmpl $63, %0\n"					\
+	"       ja  0b\n"					\
+	"5:   movl  %0, %%eax\n"				\
+	"       shrl  $2, %0\n"					\
+	"       andl $3, %%eax\n"				\
+	"       cld\n"						\
+	"6:     rep; movsl\n"					\
+	"       movl %%eax,%0\n"				\
+	"7:   rep; movsb\n"					\
+	"8:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"9:   lea 0(%%eax,%0,4),%0\n"				\
+	"16:  pushl %0\n"					\
+	"     pushl %%eax\n"					\
+	"     xorl %%eax,%%eax\n"				\
+	"     rep; stosb\n"					\
+	"     popl %%eax\n"					\
+	"     popl %0\n"					\
+	"     jmp 8b\n"						\
+	"15:    movl %6, %0\n"					\
+	"       jmp 8b\n"					\
+	".previous\n"						\
+	".section __ex_table,\"a\"\n"				\
+	"     .align 4\n"					\
+	"     .long 0b,16b\n"					\
+	"     .long 1b,16b\n"					\
+	"     .long 2b,16b\n"					\
+	"     .long 21b,16b\n"					\
+	"     .long 3b,16b\n"					\
+	"     .long 31b,16b\n"					\
+	"     .long 4b,16b\n"					\
+	"     .long 41b,16b\n"					\
+	"     .long 10b,16b\n"					\
+	"     .long 51b,16b\n"					\
+	"     .long 11b,16b\n"					\
+	"     .long 61b,16b\n"					\
+	"     .long 12b,16b\n"					\
+	"     .long 71b,16b\n"					\
+	"     .long 13b,16b\n"					\
+	"     .long 81b,16b\n"					\
+	"     .long 14b,16b\n"					\
+	"     .long 91b,16b\n"					\
+	"     .long 6b,9b\n"					\
+	"       .long 7b,16b\n"					\
+	".previous"						\
+	: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
+	:  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)		\
+	: "eax", "edx", "memory");				\
+ } while (0)
 
 /* We let the __ versions of copy_from/to_user inline, because they're often
  * used in fast paths and have only a small space overhead.
@@ -578,24 +720,16 @@ __constant_copy_from_user_nocheck(void *
 }
 
 #define copy_to_user(to,from,n)				\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_to_user((to),(from),(n)) :	\
-	 __generic_copy_to_user((to),(from),(n)))
+	__generic_copy_to_user((to),(from),(n))
 
 #define copy_from_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_from_user((to),(from),(n)) :	\
-	 __generic_copy_from_user((to),(from),(n)))
+	__generic_copy_from_user((to),(from),(n))
 
 #define __copy_to_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_to_user_nocheck((to),(from),(n)) :	\
-	 __generic_copy_to_user_nocheck((to),(from),(n)))
+	__generic_copy_to_user_nocheck((to),(from),(n))
 
 #define __copy_from_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_from_user_nocheck((to),(from),(n)) :	\
-	 __generic_copy_from_user_nocheck((to),(from),(n)))
+	__generic_copy_from_user_nocheck((to),(from),(n))
 
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);

-
