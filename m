Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUIVDWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUIVDWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 23:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUIVDWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 23:22:16 -0400
Received: from relay.pair.com ([209.68.1.20]:65288 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267785AbUIVDWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 23:22:12 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4150EF69.1060007@kegel.com>
Date: Tue, 21 Sep 2004 20:20:09 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 link failure for powerpc-970?
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com>
In-Reply-To: <1095669339.2800.3.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2004-09-20 at 10:24, Dan Kegel wrote:
> 
>>I'm trying to verify that I can build toolchains and compile
>>and link kernels for a large set of CPU types using simple kernel config files.
>>I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
>>So any problems I run into are a bit hard to pin down to
>>compiler, kernel, or user error, since this is mostly new territory for me.
> 
> 
> use this patch
> --- linux-2.6.8/arch/ppc64/Makefile~    2004-09-03 13:02:48.372244432 +0200
> +++ linux-2.6.8/arch/ppc64/Makefile     2004-09-03 13:02:48.372244432 +0200
> @@ -28,5 +28,7 @@
>  LDFLAGS_vmlinux        := -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
>  CFLAGS         += -msoft-float -pipe -mminimal-toc -mtraceback=none
> +CFLAGS += $(call cc-option,-mcall-aixdesc)

That didn't help.  In fact, cc-option is undefined, so it did nothing.
I tried correcting this to check_gcc:

--- linux-2.6.8/arch/ppc64/Makefile.old 2004-09-20 07:04:35.000000000 -0700
+++ linux-2.6.8/arch/ppc64/Makefile     2004-09-20 07:06:38.000000000 -0700
@@ -28,6 +28,7 @@
  LDFLAGS_vmlinux        := -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
  CFLAGS         += -msoft-float -pipe -Wno-uninitialized -mminimal-toc \
                    -mtraceback=none
+CFLAGS += $(call check_gcc,-mcall-aixdesc)

This actually affected the build in that -mcall-aixdesc was used on many
compiles, but the build still ended with the same errors:

/opt/crosstool/powerpc64-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/powerpc64-unknown-linux-gnu-ld -m elf64ppc -m elf64ppc -Bstatic -e 0xc000000000000000 -Ttext 0xc000000000000000 -T arch/ppc64/kernel/vmlinux.lds.asm 
arch/ppc64/kernel/head.o   init/built-in.o --start-group  usr/built-in.o  arch/ppc64/kernel/built-in.o  arch/ppc64/mm/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/ppc64/lib/lib.a  lib/built-in.o  arch/ppc64/lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
arch/ppc64/kernel/built-in.o(.text+0xdc44): In function `.sys32_ipc':
: undefined reference to `.compat_sys_shmctl'
arch/ppc64/kernel/built-in.o(.text+0xdca0): In function `.sys32_ipc':
: undefined reference to `.compat_sys_semctl'
arch/ppc64/kernel/built-in.o(.text+0xdcbc): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgsnd'
arch/ppc64/kernel/built-in.o(.text+0xdce0): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgrcv'
arch/ppc64/kernel/built-in.o(.text+0xdd0c): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgctl'
arch/ppc64/kernel/built-in.o(.text+0xdd28): In function `.sys32_ipc':
: undefined reference to `.compat_sys_shmat'
arch/ppc64/kernel/built-in.o(.text+0xdd3c): In function `.sys32_ipc':
: undefined reference to `.compat_sys_semtimedop'
arch/ppc64/kernel/built-in.o(.text+0xe9d4): In function `.sys32_sysctl':
: undefined reference to `.do_sysctl'
arch/ppc64/kernel/built-in.o(.text+0x10958): In function `.routing_ioctl':
: undefined reference to `.sockfd_lookup'
net/built-in.o(.text+0x278): In function `.verify_compat_iovec':
: undefined reference to `.move_addr_to_kernel'
net/built-in.o(.text+0x724): In function `.scm_detach_fds_compat':
: undefined reference to `.__scm_destroy'
make: *** [.tmp_vmlinux1] Error 1

Got another suggestion?

Thanks,
Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
