Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSKDVUF>; Mon, 4 Nov 2002 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSKDVUF>; Mon, 4 Nov 2002 16:20:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26125 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262859AbSKDVUE>; Mon, 4 Nov 2002 16:20:04 -0500
Date: Mon, 4 Nov 2002 21:26:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH-RFC] ARM Makefile cleanup
Message-ID: <20021104212636.D18967@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021102225530.GC15134@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021102225530.GC15134@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Nov 02, 2002 at 11:55:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:55:31PM +0100, Sam Ravnborg wrote:
> They looked pretty OK before, but I have updated then to use the new
> make clean infrastructure, and deleted inclusion of Rules.make when I
> touched a file that included that file.

Unfortunately it breaks:

  Generating build number
  Generating include/linux/compile.h (updated)
  arm-linux-gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -Os -mapcs -mno-sched-prolog -fno-strict-aliasing -fno-common -mapcs-32 -D__LINUX_ARM_ARCH__=4 -march=armv4 -mtune=strongarm1100 -mshort-load-bytes -msoft-float -Wa,-mno-fpu -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   arm-linux-ld   -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	arm-linux-ld  -p -X -T arch/arm/vmlinux.lds.s arch/arm/kernel/head.o arch/arm/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/arm/mach-sa1100/built-in.o  arch/arm/kernel/built-in.o  arch/arm/mm/built-in.o  arch/arm/nwfpe/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/arm/lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
make -f scripts/Makefile.build obj=arch/arm/boot arch/arm/boot/zImage
make -f scripts/Makefile.build obj=arch/arm/boot/compressed/ arch/arm/boot/compressed/vmlinux
make[2]: Nothing to be done for `arch/arm/boot/compressed/vmlinux'.
  arm-linux-objcopy -O binary -R .note -R .comment -S arch/arm/boot/compressed/vmlinux arch/arm/boot/zImage

I did a make clean without telling make ARCH=arm just prior, so
arch/arm/boot/compressed contains some stale files.  It looks like
there's a missing dependency on the top level vmlinux file:

-rwxrwxr-x    1 rmk      rmk       1822788 Nov  4 15:37 arch/arm/boot/compressed/piggy
-rwxrwxr-x    1 rmk      rmk       2283887 Nov  4 21:18 vmlinux

but oddly, arch/arm/boot/compressed/Makefile contains:

$(obj)/piggy:    vmlinux;       $(call if_changed,objcopy)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

