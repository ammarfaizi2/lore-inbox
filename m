Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVBICbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVBICbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVBICbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:31:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:25027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbVBIC1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:27:13 -0500
Date: Tue, 8 Feb 2005 18:27:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
In-Reply-To: <Pine.LNX.4.58.0502081808410.2165@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502081818450.2165@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
 <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
 <20050209012741.GB13802@twiddle.net> <Pine.LNX.4.58.0502081808410.2165@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Feb 2005, Linus Torvalds wrote:
> 
> Hmm.. I always thought "A" was the _pairing_ of %eax/%edx, not "eax or
> edx"?

Ahh. Some testing shows that gcc really seems to think of it as "eax or 
edx", ie you can do

	asm("uglee %0 %1": :"a" (1), "A" (2));

and it will output

	movl    $1, %eax
	movl    $2, %edx
	uglee %eax %edx

without complaining. 

Live and learn. 

That brings up another issue: if I don't care which registers a 64-bit 
value goes into, can I get the "low reg" and "high reg" names some way? In 
this case I'm constrained, and do want eactly %eax:%edx, but in some other 
cases I might not care, and wouldn't mind having a

	asm("addl %2,%L0 ; adcl $0,%H0"
		:"=r" (ll_result)
		:"r" (increment), "0" (ll_input));

to add a 32-bit number to a 64-bit one (this is totally made up, since gcc 
can probably generate this sequence itself, but you get the idea - 
allowing the asm to treat the low/high parts of the 64-bit entity 
separately, without forcing them into one specific pair).

v4 with your asm constrain fix appended.

			Linus

-----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/08 18:18:46-08:00 torvalds@evo.osdl.org 
#   x86: make "put_user()" be out-of-line
#   
#   It's really too big to be inlined.
#   
#   Ingo tests and reports: this shrinks his kernel text size by
#   about 12kB (roughly 0.5%).
#   
#   Updated on input from Richard Henderson on how the "A" constraint
#   works on x86.
# 
# arch/i386/lib/putuser.S
#   2005/02/08 18:18:35-08:00 torvalds@evo.osdl.org +87 -0
# 
# include/asm-i386/uaccess.h
#   2005/02/08 18:18:35-08:00 torvalds@evo.osdl.org +27 -13
#   x86: make "put_user()" be out-of-line
# 
# arch/i386/lib/putuser.S
#   2005/02/08 18:18:35-08:00 torvalds@evo.osdl.org +0 -0
#   BitKeeper file /home/torvalds/v2.6/linux/arch/i386/lib/putuser.S
# 
# arch/i386/lib/Makefile
#   2005/02/08 18:18:34-08:00 torvalds@evo.osdl.org +1 -1
#   x86: make "put_user()" be out-of-line
# 
# arch/i386/kernel/i386_ksyms.c
#   2005/02/08 18:18:34-08:00 torvalds@evo.osdl.org +5 -0
#   x86: make "put_user()" be out-of-line
# 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	2005-02-08 18:25:22 -08:00
+++ b/arch/i386/kernel/i386_ksyms.c	2005-02-08 18:25:22 -08:00
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
--- a/arch/i386/lib/Makefile	2005-02-08 18:25:22 -08:00
+++ b/arch/i386/lib/Makefile	2005-02-08 18:25:22 -08:00
@@ -3,7 +3,7 @@
 #
 
 
-lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
+lib-y = checksum.o delay.o usercopy.o getuser.o putuser.o memcpy.o strstr.o \
 	bitops.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
diff -Nru a/arch/i386/lib/putuser.S b/arch/i386/lib/putuser.S
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/lib/putuser.S	2005-02-08 18:25:22 -08:00
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
+ *
+ * These functions should not modify any other registers,
+ * as they get called from within inline assembly.
+ */
+
+#define ENTER	pushl %ebx ; GET_THREAD_INFO(%ebx)
+#define EXIT	popl %ebx ; ret
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
+	movl TI_addr_limit(%ebx),%ebx
+	subl $1,%ebx
+	cmpl %ebx,%ecx
+	jae bad_put_user
+2:	movw %ax,(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+.align 4
+.globl __put_user_4
+__put_user_4:
+	ENTER
+	movl TI_addr_limit(%ebx),%ebx
+	subl $3,%ebx
+	cmpl %ebx,%ecx
+	jae bad_put_user
+3:	movl %eax,(%ecx)
+	xorl %eax,%eax
+	EXIT
+
+.align 4
+.globl __put_user_8
+__put_user_8:
+	ENTER
+	movl TI_addr_limit(%ebx),%ebx
+	subl $7,%ebx
+	cmpl %ebx,%ecx
+	jae bad_put_user
+4:	movl %eax,(%ecx)
+5:	movl %edx,4(%ecx)
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
+	.long 5b,bad_put_user
+.previous
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	2005-02-08 18:25:22 -08:00
+++ b/include/asm-i386/uaccess.h	2005-02-08 18:25:22 -08:00
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
+#define __put_user_8(x, ptr) __asm__ __volatile__("call __put_user_8":"=a" (__ret_pu):"A" ((typeof(*(ptr)))(x)), "c" (ptr))
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
@@ -258,16 +282,6 @@
 	__pu_err;						\
 })
 
-
-#define __put_user_check(x,ptr,size)					\
-({									\
-	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
-	might_sleep();						\
-	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
-		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
-	__pu_err;							\
-})							
 
 #define __put_user_u64(x, addr, err)				\
 	__asm__ __volatile__(					\
