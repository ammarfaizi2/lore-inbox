Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTEPHxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 03:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTEPHxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 03:53:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29427 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264364AbTEPHxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 03:53:31 -0400
Date: Fri, 16 May 2003 10:06:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Warren Togami <warren@togami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-bk10 compile failure
Message-ID: <20030516080618.GO1346@fs.tum.de>
References: <1053058876.15567.72.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053058876.15567.72.camel@laptop>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 06:21:16PM -1000, Warren Togami wrote:
> Compilation fails here for 2.5.59-bk9 and bk10.  Last I tried was bk3
> which compiled successfully.  Please let me know if you need any more
> information, or my .config file.
> 
> (Please CC me if you reply, I am not subscribed to the list.  Thanks.)
> 
> Warren Togami
> warren@togami.com
> 
> make -f scripts/Makefile.build obj=arch/i386/lib
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=version
> -DKBUILD_MODNAME=version -c -o init/.tmp_version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/mounts.o init/initramfs.o
>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> --start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
> arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
> drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
> net/built-in.o --end-group -o .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.data+0x169a): In function
> `do_suspend_lowlevel':
> : undefined reference to `saved_context_esp'
>...

Known bug, fix by mikpe@csd.uu.se below.

cu
Adrian


--- linux-2.5.69-bk9/arch/i386/kernel/suspend_asm.S.~1~	2003-05-15 11:07:04.000000000 +0200
+++ linux-2.5.69-bk9/arch/i386/kernel/suspend_asm.S	2003-05-15 11:09:29.000000000 +0200
@@ -7,6 +7,12 @@
 #include <asm/page.h>
 
 	.data
+	.align	4
+	.globl	saved_context_eax, saved_context_ebx
+	.globl	saved_context_ecx, saved_context_edx
+	.globl	saved_context_esp, saved_context_ebp
+	.globl	saved_context_esi, saved_context_edi
+	.globl	saved_context_eflags
 saved_context_eax:
 	.long	0
 saved_context_ebx:
