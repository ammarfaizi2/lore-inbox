Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUIMOTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUIMOTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUIMOTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:19:05 -0400
Received: from [209.88.178.130] ([209.88.178.130]:63741 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S266850AbUIMOSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:18:55 -0400
Message-ID: <4145ABEE.5050606@qlusters.com>
Date: Mon, 13 Sep 2004 17:17:18 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Calling syscalls from x86-64 kernel results in a crash on
 Opteron machines
References: <200409131715.27584.anatolya@qlusters.com>
In-Reply-To: <200409131715.27584.anatolya@qlusters.com>
Content-Type: multipart/mixed;
 boundary="------------000803090101040500050100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000803090101040500050100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>Subject: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
>Date: Mon, 13 Sep 2004 17:04:17 +0300
>From: Constantine Gavrilov <constg@qlusters.com>
>To: bugs@x86-64.org, linux-kernel@vger.kernel.org
>
>Hello:
>
>We have a piece of kernel code that calls some system calls in kernel
>context (from a process with mm and a daemonized kernel thread that does
>not have mm). This works fine on IA64 and i386 architectures.
>
..............

>Attached please find a test module that tries to call the umask() (JUST
>TO DEMONSTRATE a problem) via the syscall machanism. Both methods (the
>_syscall1() marco and GLIBC INLINE_SYCALL() were used.
>  
>

I forgot to attach a header file with glibc version of syscall inline 
implementation.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------000803090101040500050100
Content-Type: text/plain;
 name="gsyscall.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gsyscall.h"

#ifndef _GSYSCALL_H_
#define _GSYSCALL_H_

#define __set_errno(Val) errno = (Val)

#undef INLINE_SYSCALL
#define INLINE_SYSCALL(name, nr, args...) \
  ({									      \
    unsigned long resultvar = INTERNAL_SYSCALL (name, , nr, args);	      \
    if (__builtin_expect (INTERNAL_SYSCALL_ERROR_P (resultvar, ), 0))	      \
      {									      \
	__set_errno (INTERNAL_SYSCALL_ERRNO (resultvar, ));		      \
	resultvar = (unsigned long) -1;					      \
      }									      \
    (long) resultvar; })

#undef INTERNAL_SYSCALL_DECL
#define INTERNAL_SYSCALL_DECL(err) do { } while (0)



#undef INTERNAL_SYSCALL
#define INTERNAL_SYSCALL(name, err, nr, args...) \
  ({									      \
    unsigned long resultvar;						      \
    LOAD_ARGS_##nr (args)						      \
    asm volatile (							      \
    "movq %1, %%rax\n\t"						      \
    "syscall\n\t"							      \
    : "=a" (resultvar)							      \
    : "i" (__NR_##name) ASM_ARGS_##nr : "memory", "cc", "r11", "cx");	      \
    (long) resultvar; })

#undef INTERNAL_SYSCALL_ERROR_P
#define INTERNAL_SYSCALL_ERROR_P(val, err) \
  ((unsigned long) (val) >= -4095L)

#undef INTERNAL_SYSCALL_ERRNO
#define INTERNAL_SYSCALL_ERRNO(val, err)	(-(val))

#define LOAD_ARGS_0()
#define ASM_ARGS_0

#define LOAD_ARGS_1(a1)					\
  register long int _a1 asm ("rdi") = (long) (a1);	\
  LOAD_ARGS_0 ()
#define ASM_ARGS_1	ASM_ARGS_0, "r" (_a1)

#define LOAD_ARGS_2(a1, a2)				\
  register long int _a2 asm ("rsi") = (long) (a2);	\
  LOAD_ARGS_1 (a1)
#define ASM_ARGS_2	ASM_ARGS_1, "r" (_a2)

#define LOAD_ARGS_3(a1, a2, a3)				\
  register long int _a3 asm ("rdx") = (long) (a3);	\
  LOAD_ARGS_2 (a1, a2)
#define ASM_ARGS_3	ASM_ARGS_2, "r" (_a3)

#define LOAD_ARGS_4(a1, a2, a3, a4)			\
  register long int _a4 asm ("r10") = (long) (a4);	\
  LOAD_ARGS_3 (a1, a2, a3)
#define ASM_ARGS_4	ASM_ARGS_3, "r" (_a4)

#define LOAD_ARGS_5(a1, a2, a3, a4, a5)			\
  register long int _a5 asm ("r8") = (long) (a5);	\
  LOAD_ARGS_4 (a1, a2, a3, a4)
#define ASM_ARGS_5	ASM_ARGS_4, "r" (_a5)

#define LOAD_ARGS_6(a1, a2, a3, a4, a5, a6)		\
  register long int _a6 asm ("r9") = (long) (a6);	\
  LOAD_ARGS_5 (a1, a2, a3, a4, a5)
#define ASM_ARGS_6	ASM_ARGS_5, "r" (_a6)

#endif

--------------000803090101040500050100--

