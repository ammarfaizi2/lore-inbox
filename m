Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273805AbRIRCW7>; Mon, 17 Sep 2001 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273806AbRIRCWu>; Mon, 17 Sep 2001 22:22:50 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:6083 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S273805AbRIRCWg>; Mon, 17 Sep 2001 22:22:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11
Date: Mon, 17 Sep 2001 23:18:12 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010918031813.57E1062ABC@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You are fast.  Was just going report this one...
Using debian sid with gcc 2.95.4.  Both before and after
appling the patch below I get:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
mm/mm.o: In function `kmem_cache_alloc':
mm/mm.o(.text+0x8154): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x8173): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x81cc): undefined reference to `__builtin_expect'
mm/mm.o: In function `kmalloc':
mm/mm.o(.text+0x8294): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x82b3): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x830c): more undefined references to `__builtin_expect' follow
make: *** [vmlinux] Error 1

Impling the patch below is incomplete?

TIA
Ed Tomlinson

Andrea Arcangeli wrote:
 
> ah I just got a (verbose) report about one compilation trouble with old
> kernels, the 00_rwsem patch that includes this backwards compatibility
> hunk wasn't applied. This is a very very minor issue. Please Linus
> include this patch to fix the compilation troubles with the old
> compilers:
> 
> diff -urN 2.4.10pre10/include/linux/compiler.h rwsem/include/linux/compiler.h
> --- 2.4.10pre10/include/linux/compiler.h	Thu Jan  1 01:00:00 1970
> +++ rwsem/include/linux/compiler.h	Tue Sep 18 02:02:08 2001
> @@ -0,0 +1,13 @@
> +#ifndef __LINUX_COMPILER_H
> +#define __LINUX_COMPILER_H
> +
> +/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
> +   a mechanism by which the user can annotate likely branch directions and
> +   expect the blocks to be reordered appropriately.  Define __builtin_expect
> +   to nothing for earlier compilers.  */
> +
> +#if __GNUC__ == 2 && __GNUC_MINOR__ < 96ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
mm/mm.o: In function `kmem_cache_alloc':
mm/mm.o(.text+0x8154): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x8173): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x81cc): undefined reference to `__builtin_expect'
mm/mm.o: In function `kmalloc':
mm/mm.o(.text+0x8294): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x82b3): undefined reference to `__builtin_expect'
mm/mm.o(.text+0x830c): more undefined references to `__builtin_expect' follow
make: *** [vmlinux] Error 1
> +#define __builtin_expect(x, expected_value) (x)
> +#endif
> +
> +#endif /* __LINUX_COMPILER_H */
> 
> Then you need to simply include <linux/compile.h> from the files that
> doesn't compile, this second patch is untested but it should do the
> trick (00_rwsem-?? was including compile.h from the rwsem includes that
> were in turn included by those files implicitly so I didn't need to add
> compile.h in each file):
> 
> --- 2.4.10pre11/mm/slab.c.~1~	Tue Sep 18 02:43:04 2001
> +++ 2.4.10pre11/mm/slab.c	Tue Sep 18 04:00:30 2001
> @@ -72,6 +72,7 @@
>  #include	<linux/slab.h>
>  #include	<linux/interrupt.h>
>  #include	<linux/init.h>
> +#include	<linux/compile.h>
>  #include	<asm/uaccess.h>
>  
>  /*
> --- 2.4.10pre11/mm/page_alloc.c.~1~	Tue Sep 18 02:43:04 2001
> +++ 2.4.10pre11/mm/page_alloc.c	Tue Sep 18 04:00:20 2001
> @@ -17,6 +17,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/bootmem.h>
>  #include <linux/slab.h>
> +#include <linux/compile.h>
>  
>  int nr_swap_pages;
>  int nr_active_pages;
> --- 2.4.10pre11/mm/vmscan.c.~1~	Tue Sep 18 02:43:04 2001
> +++ 2.4.10pre11/mm/vmscan.c	Tue Sep 18 04:00:47 2001
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/highmem.h>
>  #include <linux/file.h>
> +#include <linux/compile.h>
>  
>  #include <asm/pgalloc.h>
>  
> 
> Andrea
