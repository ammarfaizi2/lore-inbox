Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVBGGYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVBGGYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBGGYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:24:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:47507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261358AbVBGGXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:23:54 -0500
Date: Sun, 6 Feb 2005 22:23:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Manfred Spraul <manfred@colorfullife.com>
Subject: out-of-line x86 "put_user()" implementation
Message-ID: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at some of the code we generate, and happened to notice that 
we have this strange situation where the x86 "get_user()" macros generate 
out-of-line code to do all the address verification etc, but the 
"put_user()" ones do not, and do everything inline.

I also noticed that (probably as a result of this), our "put_user()" on 
old i386 machines does not do the full magic manual page-following. Which 
means that copy-on-write doesn't necessarily work right due to the broken 
paging hw on the original 386 core.

I didn't fix the second part, but at least making things out-of-line makes
it possible. And making "put_user()" be out-of-line seemed quite doable.

I no longer use x86 as my main machine, so this patch is totally untested. 
I've compiled it to see that things look somewhat sane, but that doesn't 
mean much. If I forgot some register or screwed something else up, this 
will result in a totally nonworking kernel, but I thought that maybe 
somebody else would be interested in looking at whether this (a) works, 
(b) migth even shrink the kernel and (c) might make us able to DTRT wrt 
the page table following crud (old i386 cores may be hard to find these 
days, so maybe people don't care).

		Linus

----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/06 22:10:04-08:00 torvalds@evo.osdl.org 
#   x86: make "put_user()" be out-of-line
#   
#   It's really too big to be inlined.
# 
# arch/i386/lib/putuser.S
#   2005/02/06 22:09:53-08:00 torvalds@evo.osdl.org +87 -0
# 
# include/asm-i386/uaccess.h
#   2005/02/06 22:09:53-08:00 torvalds@evo.osdl.org +27 -3
#   x86: make "put_user()" be out-of-line
#   
#   It's really too big to be inlined.
# 
# arch/i386/lib/putuser.S
#   2005/02/06 22:09:53-08:00 torvalds@evo.osdl.org +0 -0
#   BitKeeper file /home/torvalds/v2.6/linux/arch/i386/lib/putuser.S
# 
# arch/i386/lib/Makefile
#   2005/02/06 22:09:53-08:00 torvalds@evo.osdl.org +1 -1
#   x86: make "put_user()" be out-of-line
#   
#   It's really too big to be inlined.
# 
# arch/i386/kernel/i386_ksyms.c
#   2005/02/06 22:09:53-08:00 torvalds@evo.osdl.org +5 -0
#   x86: make "put_user()" be out-of-line
#   
#   It's really too big to be inlined.
# 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	2005-02-06 22:12:01 -08:00
+++ b/arch/i386/kernel/i386_ksyms.c	2005-02-06 22:12:01 -08:00
@@ -97,6 +97,11 @@
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
 
+EXPORT_SYMBOL(__put_user_1);
+EXPORT_SYMBOL(__put_user_2);
+EXPORT_SYMBOL(__put_user_4);
+EXPORT_SYMBOL(__put_user_8);
+
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
diff -Nru a/arch/i386/lib/Makefile b/arch/i386/lib/Makefile
--- a/arch/i386/lib/Makefile	2005-02-06 22:12:01 -08:00
+++ b/arch/i386/lib/Makefile	2005-02-06 22:12:01 -08:00
@@ -3,7 +3,7 @@
 #
 
 
-lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
+lib-y = checksum.o delay.o usercopy.o getuser.o putuser.o memcpy.o strstr.o \
 	bitops.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
diff -Nru a/arch/i386/lib/putuser.S b/arch/i386/lib/putuser.S
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/lib/putuser.S	2005-02-06 22:12:01 -08:00
@@ -0,0 +1,87 @@
+/*
+ * __put_user functions.
+ *
+ * (C) Copyright 2005 Linus Torvalds
+ *
+ * These functions have a non-standard call interface
+ * to make them more efficient, especially as they
+ * return an error value in addition to the "real"
+ * return value.
+ */
+#include <asm/thread_info.h>
+
+
+/*
+ * __put_user_X
+ *
+ * Inputs:	%eax[:%edx] contains the data
+ *		%ecx contains the address
+ *
+ * Outputs:	%eax is error code (0 or -EFAULT)
+ *		%ecx is corrupted
+ *
+ * These functions should not modify any other registers,
+ * as they get called from within inline assembly.
+ */
+
+#define ENTER	pushl %ecx ; pushl %ebx ; GET_THREAD_INFO(%ebx)
+#define EXIT	popl %ebx ; popl %ecx ; ret
+
+.text
+.align 4
+.globl __put_user_1
+__put_user_1:
+	ENTER
+	cmpl TI_addr_limit(%ebx),%ecx
+	jae bad_put_user
+1:	movb %al,(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+.align 4
+.globl __put_user_2
+__put_user_2:
+	ENTER
+	addl $1,%ecx
+	jc bad_put_user
+	cmpl TI_addr_limit(%ebx),%ecx
+	jae bad_put_user
+2:	movw %ax,-1(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+.align 4
+.globl __put_user_4
+__put_user_4:
+	ENTER
+	addl $3,%ecx
+	jc bad_put_user
+	cmpl TI_addr_limit(%ebx),%ecx
+	jae bad_put_user
+3:	movl %eax,-3(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+.align 4
+.globl __put_user_8
+__put_user_8:
+	ENTER
+	addl $7,%ecx
+	jc bad_put_user
+	cmpl TI_addr_limit(%ebx),%ecx
+	jae bad_put_user
+3:	movl %eax,-7(%ecx)
+4:	movl %edx,-3(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+bad_put_user:
+	movl $-14,%eax
+	EXIT
+
+.section __ex_table,"a"
+	.long 1b,bad_put_user
+	.long 2b,bad_put_user
+	.long 3b,bad_put_user
+	.long 4b,bad_put_user
+.previous
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	2005-02-06 22:12:01 -08:00
+++ b/include/asm-i386/uaccess.h	2005-02-06 22:12:01 -08:00
@@ -185,6 +185,21 @@
 
 extern void __put_user_bad(void);
 
+/*
+ * Strange magic calling convention: pointer in %ecx,
+ * value in %eax(:%edx), return value in %eax, no clobbers.
+ */
+extern void __put_user_1(void);
+extern void __put_user_2(void);
+extern void __put_user_4(void);
+extern void __put_user_8(void);
+
+#define __put_user_1(x, ptr) __asm__ __volatile__("call __put_user_1":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
+#define __put_user_2(x, ptr) __asm__ __volatile__("call __put_user_2":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
+#define __put_user_4(x, ptr) __asm__ __volatile__("call __put_user_4":"=a" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
+#define __put_user_8(x, ptr) __asm__ __volatile__("call __put_user_8":"=A" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
+#define __put_user_X(x, ptr) __asm__ __volatile__("call __put_user_X":"=a" (__ret_pu):"c" (ptr))
+
 /**
  * put_user: - Write a simple value into user space.
  * @x:   Value to copy to user space.
@@ -201,9 +216,18 @@
  *
  * Returns zero on success, or -EFAULT on error.
  */
-#define put_user(x,ptr)							\
-  __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
-
+#define put_user(x,ptr)						\
+({	int __ret_pu;						\
+	__chk_user_ptr(ptr);					\
+	switch(sizeof(*(ptr))) {				\
+	case 1: __put_user_1(x, ptr); break;			\
+	case 2: __put_user_2(x, ptr); break;			\
+	case 4: __put_user_4(x, ptr); break;			\
+	case 8: __put_user_8(x, ptr); break;			\
+	default:__put_user_X(x, ptr); break;			\
+	}							\
+	__ret_pu;						\
+})
 
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
