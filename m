Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTE1FcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTE1FcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:32:23 -0400
Received: from main.gmane.org ([80.91.224.249]:7656 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264536AbTE1FcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:32:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andres Salomon" <dilinger@voxel.net>
Subject: [PATCH] register_ioctl32_conversion symbol exports fix
Date: Wed, 28 May 2003 01:45:33 -0400
Message-ID: <bb1i9v$t9b$1@main.gmane.org>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error when compiling 2.5.70 for sparc64, using
gcc-3.3:


 CC      init/version.o
scripts/fixdep init/.version.o.d init/version.o 'gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -finline-limit=100000 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/.tmp_version.o init/version.c' > init/.version.o.tmp; rm -f init/.version.o.d; mv -f init/.version.o.tmp init/.version.o.cmd
  LD      init/built-in.o
  LD      vmlinux
fs/built-in.o(*ABS*+0xb766971): In function `__crc_register_ioctl32_conversion':util.c: multiple definition of `__crc_register_ioctl32_conversion'
make: *** [vmlinux] Error 1


The problem is apparently register_ioctl32_conversion() is exported twice
for a few architectures:

./fs/compat.c:int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
./fs/compat.c:EXPORT_SYMBOL(register_ioctl32_conversion);
./arch/ppc64/kernel/ppc_ksyms.c:EXPORT_SYMBOL(register_ioctl32_conversion);
./arch/sparc64/kernel/sparc64_ksyms.c:EXPORT_SYMBOL(register_ioctl32_conversion);

Since compat.c is only built if CONFIG_COMPAT is defined, the entries in
${arch}_ksyms.c are incorrect (at the very least, they need to test for
this sort of thing).  I don't see the harm in removing the exports
altogether from the arch-specific stuff; so, that's what this patch does
(to both {,un}register_ioctl32_conversion).  Please apply (or correct me
;)




On Mon, 26 May 2003 19:08:45 -0700, Linus Torvalds wrote:
> 
> Ok, 
>  there's been too much delay between 69 and 70, but I was hoping to make 
> 70 the last "Linus only" release before getting together with Andrew and 
> figuring out how to start the "pre-2.6" series and more of a code slush. 
> 
[...]
>   o I2C: And another it87 patch
>   o I2C: And yet another it87 patch


