Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUEaTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUEaTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUEaTns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 15:43:48 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50340 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264749AbUEaTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 15:43:44 -0400
Message-ID: <40BB7C12.3040002@kegel.com>
Date: Mon, 31 May 2004 11:40:18 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bringing back 'make symlinks'?
References: <40B36A0E.5080509@kegel.com> <20040525214328.GA2675@mars.ravnborg.org> <40B41367.5070607@kegel.com> <20040530105502.GA19882@mars.ravnborg.org>
In-Reply-To: <20040530105502.GA19882@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>The way things are now, I can build toolchains for everything
>>except the sh architecture (though my toolchain bootstrap script
>>is ugly as noted due to the lack of 'make symlinks').
> 
> Does the following meet the needs of your cross-tool scripts?
> 
> 	Sam
> 
> ===== Makefile 1.492 vs edited =====
> --- 1.492/Makefile	2004-05-30 08:24:06 +02:00
> +++ edited/Makefile	2004-05-30 12:52:36 +02:00
> @@ -632,6 +632,10 @@
>  # All the preparing..
>  prepare-all: prepare0 prepare
>  
> +# symlinks provided for compatibility with 2.4 - this allows boot-strapping
> +# tool chains to be simpler
> +symlinks: prepare-all
> +
>  #	Leave this as default for preprocessing vmlinux.lds.S, which is now
>  #	done in arch/$(ARCH)/kernel/Makefile

Well, let's try it:

$ make ARCH=sh prepare
   Making asm-sh/cpu -> asm-sh/ link
   Making asm-sh/mach -> asm-sh/ link
   Generating include/asm-sh/machtypes.h

So far so good (excellent, in fact, since there is no other way
at the moment to create those two links).

$ make ARCH=ppc prepare
   HOSTCC  scripts/conmakehash
   HOSTCC  scripts/kallsyms
   CC      scripts/empty.o
cc1: invalid option `multiple'
cc1: invalid option `string'
cc1: warning: unknown register name: r2
make[1]: *** [scripts/empty.o] Error 1

Whoops, bad luck.  Let's try another:

$ make ARCH=arm prepare
   SPLIT   include/linux/autoconf.h -> include/config/*
   HOSTCC  scripts/conmakehash
   HOSTCC  scripts/kallsyms
   CC      scripts/empty.o
cc1: invalid option `apcs'
cc1: invalid option `no-sched-prolog'
cc1: invalid option `little-endian'
cc1: invalid option `apcs-32'
cc1: invalid option `short-load-bytes'
make[1]: *** [scripts/empty.o] Error 1
make: *** [scripts] Error 2

Bad luck again.

Your change works for some architectures, but for those
that try to build something with the target compilers, it fails
because at this point in the bootstrap process, there *is* no
target compiler.  (That's the next step.  We have to install the
kernel headers to build the target compiler...)

By the way, the mips architecture doesn't even make symlinks anymore,
preferring instead to use -I's.   This makes emulating 'make symlinks'
a bit more challenging.

For what it's worth, here's my current workaround.  I'm up
and happy on all architectures with this, I think.  (Well,
happy but ugly and afraid of future breakage, I guess.
And maybe not so happy on mips.)

case "$KERNEL_VERSION.$KERNEL_PATCHLEVEL.x" in
2.2.x|2.4.x) make ARCH=$ARCH symlinks    include/linux/version.h
              ;;
2.6.x)       case $ARCH in
              sh*)        # sh does secret stuff in 'make prepare' that can't be triggered separately,
                          # but happily, it doesn't use target gcc, so we can use it
                          make ARCH=$ARCH prepare
                          ;;
              arm*|cris*) make ARCH=$ARCH include/asm include/linux/version.h include/asm-$ARCH/.arch
                          ;;
              mips*)      # for linux-2.6, 'make prepare' for mips doesn't
                          # actually create any symlinks.  Hope generic is ok.
                          # Note that glibc ignores all -I flags passed in CFLAGS,
                          # so you have to use -isystem.
                          make ARCH=$ARCH include/asm include/linux/version.h
                          TARGET_CFLAGS="$TARGET_CFLAGS -isystem $LINUX_DIR/include/asm-mips/mach-generic"
                          ;;
              *)          make ARCH=$ARCH include/asm include/linux/version.h
                          ;;
              esac
              ;;
*)           abort "Unsupported kernel version $KERNEL_VERSION.$KERNEL_PATCHLEVEL"
esac

- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
