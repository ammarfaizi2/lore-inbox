Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266141AbRF2R7G>; Fri, 29 Jun 2001 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbRF2R64>; Fri, 29 Jun 2001 13:58:56 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266135AbRF2R6D>;
	Fri, 29 Jun 2001 13:58:03 -0400
Message-ID: <20010629002446.A11053@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:24:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Kill unused crap in putuser.S
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yup. Whole putuser.S is unused. Either it should be killed [as my
patch suggests], or ... well ... it should be used.

Please either apply or say how you'd like this to be fixed.
								Pavel
PS: Tested on i386, both make and make modules works ok.

--- clean/arch/i386/lib/putuser.S	Mon Jan 12 22:37:26 1998
+++ linux/arch/i386/lib/putuser.S	Thu Jun 28 12:53:09 2001
@@ -1,71 +0,0 @@
-/*
- * __put_user functions.
- *
- * (C) Copyright 1998 Linus Torvalds
- *
- * These functions have a non-standard call interface
- * to make them more efficient.
- */
-
-/*
- * __put_user_X
- *
- * Inputs:	%eax contains the address
- *		%edx contains the value
- *
- * Outputs:	%eax is error code (0 or -EFAULT)
- *		%ecx is corrupted (will contain "current_task").
- *
- * These functions should not modify any other registers,
- * as they get called from within inline assembly.
- */
-
-addr_limit = 12
-
-.text
-.align 4
-.globl __put_user_1
-__put_user_1:
-	movl %esp,%ecx
-	andl $0xffffe000,%ecx
-	cmpl addr_limit(%ecx),%eax
-	jae bad_put_user
-1:	movb %dl,(%eax)
-	xorl %eax,%eax
-	ret
-
-.align 4
-.globl __put_user_2
-__put_user_2:
-	addl $1,%eax
-	movl %esp,%ecx
-	jc bad_put_user
-	andl $0xffffe000,%ecx
-	cmpl addr_limit(%ecx),%eax
-	jae bad_put_user
-2:	movw %dx,-1(%eax)
-	xorl %eax,%eax
-	ret
-
-.align 4
-.globl __put_user_4
-__put_user_4:
-	addl $3,%eax
-	movl %esp,%ecx
-	jc bad_put_user
-	andl $0xffffe000,%ecx
-	cmpl addr_limit(%ecx),%eax
-	jae bad_put_user
-3:	movl %edx,-3(%eax)
-	xorl %eax,%eax
-	ret
-
-bad_put_user:
-	movl $-14,%eax
-	ret
-
-.section __ex_table,"a"
-	.long 1b,bad_put_user
-	.long 2b,bad_put_user
-	.long 3b,bad_put_user
-.previous
--- clean/arch/i386/kernel/i386_ksyms.c	Tue Jun  5 21:37:20 2001
+++ linux/arch/i386/kernel/i386_ksyms.c	Fri Jun 29 00:18:50 2001
@@ -90,9 +90,6 @@
 EXPORT_SYMBOL_NOVERS(__get_user_1);
 EXPORT_SYMBOL_NOVERS(__get_user_2);
 EXPORT_SYMBOL_NOVERS(__get_user_4);
-EXPORT_SYMBOL_NOVERS(__put_user_1);
-EXPORT_SYMBOL_NOVERS(__put_user_2);
-EXPORT_SYMBOL_NOVERS(__put_user_4);
 
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
--- clean/include/asm-i386/uaccess.h	Tue May  8 11:43:51 2001
+++ linux/include/asm-i386/uaccess.h	Thu Jun 28 12:52:48 2001
@@ -129,12 +129,6 @@
 
 extern void __put_user_bad(void);
 
-#define __put_user_x(size,ret,x,ptr)					\
-	__asm__ __volatile__("call __put_user_" #size			\
-		:"=a" (ret)						\
-		:"0" (ptr),"d" (x)					\
-		:"cx")
-
 #define put_user(x,ptr)							\
   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 



-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
