Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbSIXAS5>; Mon, 23 Sep 2002 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSIXAS4>; Mon, 23 Sep 2002 20:18:56 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:45445 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261503AbSIXASt>; Mon, 23 Sep 2002 20:18:49 -0400
Date: Mon, 23 Sep 2002 19:24:01 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org, <kbuild-devel@lists.sourceforge.net>
Subject: Re: UML kbuild patch
In-Reply-To: <200209240109.UAA05448@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0209231913060.13892-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Jeff Dike wrote:

> The UML build needs a few kbuild changes in order to work with the latest
> stuff.
> 
> Since kbuild now enforces the use of the linker script on the vmlinux build,
> UML can't use its old two-stage link, where
> 	vmlinux is a normal relocatable object file
> 	which is linked into the linux binary with the linker script
> 
> So, in order to fold those into one stage and produce an ELF binary, I need
> the vmlinux "linker" to actually be gcc.  This implies I need a 
> "-Wl,-T,arch/$(ARCH)/vmlinux.lds.s" instead of the usual 
> "-T arch/$(ARCH)/vmlinux.lds.s".
> 
> This is done without breaking the other arches by changing the final link
> command to $(LD_vmlinux) which is defaulted to $(LD) if the arch doesn't
> define it.
> 
> The "-Wl,..." is done similarly by using $(LDFLAGS_vmlinux_default) if
> the linker command is anything but gcc and $(LDFLAGS_vmlinux_gcc) if it is
> gcc.

I just thought of another solution, which actually seems cleaner and has 
less impact on the top-level (generic) Makefile.

Let's just do the 

	LDFLAGS_vmlinux := -T arch/$(ARCH)/vmlinux.lds.s

before including arch/$(ARCH)/Makefile.
Normal archs can then just do

	LDFLAGS_vmlinux += -extra_option

while UML does

	LDFLAGS_vmlinux := -r

The actual executable UML generates is called "linux" anyway, so its 
Makefile can have its own rule (as for other archs the boot images) which 
builds "linux" from "vmlinux" using gcc and the link script. - I.e. the 
same way as UML used to do it earlier, anyway.

The only impact on generic code is basically
s/LDFLAGS_vmlinux :=/LDFLAGS_vmlinux +=/
in arch/*/Makefile, and it makes the UML "linux" build conceptually 
similar to other archs' "bzImage" or whatever targets.

What do you think?

--Kai



