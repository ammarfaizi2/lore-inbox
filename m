Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUIJUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUIJUld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIJUlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:41:09 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:34820 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267776AbUIJUkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:40:49 -0400
Date: Fri, 10 Sep 2004 22:36:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Alan Modra <amodra@bigpond.net.au>, Ulrich Drepper <drepper@redhat.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: vDSO for ppc64 : Preliminary release #4
Message-ID: <20040910203635.GB11338@mars.ravnborg.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
	Alan Modra <amodra@bigpond.net.au>,
	Ulrich Drepper <drepper@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
References: <1094799101.2664.144.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094799101.2664.144.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben.

I would prefer to use a bit more core kbuild stuff.
Could you please try my version below (needs to be applied manually).

Let me know how it turns out.

	Sam


On Fri, Sep 10, 2004 at 04:51:42PM +1000, Benjamin Herrenschmidt wrote:
> diff -urN linux-2.5/arch/ppc64/kernel/vdso32/Makefile linux-vdso/arch/ppc64/kernel/vdso32/Makefile
> --- /dev/null	2004-09-01 15:26:22.000000000 +1000
> +++ linux-vdso/arch/ppc64/kernel/vdso32/Makefile	2004-09-07 18:25:44.000000000 +1000
> @@ -0,0 +1,51 @@
> +# Choose compiler

> +#
> +# XXX FIXME: We probably want to enforce using a biarch compiler by default
> +#             and thus use (CC) with -m64, while letting the user pass a
> +#             CROSS32_COMPILE prefix if wanted. Same goes for the zImage
> +#             wrappers
> +#
> +
> +CROSS32_COMPILE ?=
> +
> +CROSS32CC		:= $(CROSS32_COMPILE)gcc
> +CROSS32AS		:= $(CROSS32_COMPILE)as
> +
> +# List of files in the vdso, has to be asm only for now
> +
> +src-vdso32 = sigtramp.S gettimeofday.S datapage.S
> +
> +# Build rules
> +
> +obj-vdso32 := $(addsuffix .o, $(basename $(src-vdso32))
targets := $(obj-vdso32)
-> So they get removed by make clean

> +obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
> +src-vdso32 := $(addprefix $(src)/, $(src-vdso32))
OK.

> +
> +VDSO32_CFLAGS := -shared -s -fno-common -Iinclude -fno-builtin -nostdlib
> +VDSO32_CFLAGS += -Wl,-soname=linux-vdso32.so.1
> +VDSO32_AFLAGS := -D__ASSEMBLY__ -D__KERNEL__ -D__VDSO32__ -s -nostdinc -Iinclude

Replace with:
EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin 
EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1

EXTRA_AFLAGS := -D__VDSO32__ -s

> +obj-y += vdso32_wrapper.o
-> This causes built-in.o to be generated, which is fine.

> +extra-y += vdso32.lds
> +CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
OK

> +# Force dependency (incbin is bad)
> +$(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
OK

> +# link rule for the .so file, .lds has to be first
> +$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32)
> +	$(call if_changed,vdso32ld)
OK

> +
> +# assembly rules for the .S files
> +# This is probably wrong with split src & obj trees
> +$(obj-vdso32): %.o: %.S
> +	$(call if_changed_dep,vdso32as)
OK - but see below


> +# actual build commands
> +quiet_cmd_vdso32ld = VDSO32L $@

      cmd_vdso32ld = $(CROSS32CC) $(cflags) -Wl,-T $^ -o $@
Utilising $(cflags) gives:
-> Correct $(depfile)
-> Expanded include paths

> +quiet_cmd_vdso32as = VDSO32A $@
> +      cmd_vdso32as = $(CROSS32CC) $(aflags) -c -o $@ $^
Same here.

> +
> +targets += vdso32.so
OK - but put it closer to the rule that generates it.


