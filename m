Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVG0UZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVG0UZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVG0UZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:25:08 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:49308 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262239AbVG0UYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:24:19 -0400
Date: Wed, 27 Jul 2005 16:20:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Build error in Kernel 2.6.13-rc3 git current
To: Michael Berger <mikeb1@t-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200507271623_MC3-1-A5BE-312B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 at 08:49:03 +0200, Michael Berger wrote:

> I would like to report following build error in Kernel 2.6.13-rc3 git 
> current:
> 
>    gcc -m32 -Wp,-MD,init/.do_mounts_initrd.o.d  -nostdinc -isystem 
> /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude  -Wall 
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
> -ffreestanding -O2     -fomit-frame-pointer -pipe -msoft-float 
> -mpreferred-stack-boundary=2  -march=i686  -mregparm=3 
> -Iinclude/asm-i386/mach-default      -DKBUILD_BASENAME=do_mounts_initrd 
> -DKBUILD_MODNAME=mounts -c -o init/do_mounts_initrd.o 
> init/do_mounts_initrd.c
> In file included from include/asm/unistd.h:426,
>                   from include/linux/unistd.h:9,
>                   from init/do_mounts_initrd.c:2:
> include/asm/ptrace.h: In function `user_mode_vm':
> include/asm/ptrace.h:67: error: `VM_MASK' undeclared (first use in this 
> function)
> include/asm/ptrace.h:67: error: (Each undeclared identifier is reported 
> only once
> include/asm/ptrace.h:67: error: for each function it appears in.)
> make[1]: *** [init/do_mounts_initrd.o] Error 1
> make: *** [init] Error 2


  Andrew has already fixed this and sent it to Linus.  And now I know to be
more careful when turning macros into inlines: a macro just sits there until
someone uses it while an inline function is always evaluated.

  Fix:

diff -puN include/asm-i386/ptrace.h~user_mode_vm-build-fix include/asm-i386/ptrace.h
--- devel/include/asm-i386/ptrace.h~user_mode_vm-build-fix	2005-07-27 11:14:01.000000000 -0700
+++ devel-akpm/include/asm-i386/ptrace.h	2005-07-27 11:14:27.000000000 -0700
@@ -55,6 +55,9 @@ struct pt_regs {
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
+
+#include <asm/vm86.h>
+
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);

__
Chuck
