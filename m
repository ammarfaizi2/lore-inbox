Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJYM1R>; Fri, 25 Oct 2002 08:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbSJYM1R>; Fri, 25 Oct 2002 08:27:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27110 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261381AbSJYM1Q>;
	Fri, 25 Oct 2002 08:27:16 -0400
Date: Fri, 25 Oct 2002 18:09:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.44-mm5
Message-ID: <20021025180921.B14451@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1035547268.3db9328488960@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035547268.3db9328488960@kolivas.net>; from conman@kolivas.net on Fri, Oct 25, 2002 at 12:04:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 12:04:22PM +0000, Con Kolivas wrote:
> 
> Compile failure (gcc3.2):
> 
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
> -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
>   -c -o init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
> --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
> arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
> fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a 
> arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
> arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o
> --end-group  -o .tmp_vmlinux1
> kernel/built-in.o: In function `sched_init':
> kernel/built-in.o(.init.text+0xc4): undefined reference to `init_kstat'
> make: *** [.tmp_vmlinux1] Error 1

The patch below should fix your problem, hopefully. Although I 
don't understand why kstat initialization isn't in common code.
I will try to fix it the right way later.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.



diff -urN linux-2.5.44-mm5/kernel/sched.c linux-2.5.44-mm5-fix/kernel/sched.c
--- linux-2.5.44-mm5/kernel/sched.c	Fri Oct 25 15:11:06 2002
+++ linux-2.5.44-mm5-fix/kernel/sched.c	Fri Oct 25 15:40:01 2002
@@ -2160,6 +2160,8 @@
  * Don't use in new code.
  */
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+#else
+static inline void init_kstat(void) { }
 #endif
 
 void __init sched_init(void)

