Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVAaTZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVAaTZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVAaTZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:25:41 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:14882 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261324AbVAaTZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:25:16 -0500
Date: Mon, 31 Jan 2005 20:27:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal trampoline
Message-ID: <20050131192713.GA16268@mars.ravnborg.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <1107151447.5712.81.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107151447.5712.81.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: linux-work/arch/ppc64/kernel/vdso32/Makefile
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/ppc64/kernel/vdso32/Makefile	2005-01-31 16:25:56.000000000 +1100
> @@ -0,0 +1,50 @@
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
This needs to go into arch/ppc64/Makefile

> +
> +# List of files in the vdso, has to be asm only for now
> +
> +src-vdso32 = sigtramp.S gettimeofday.S datapage.S cacheflush.S

It is normal kbuild practice to list .o files.
So it would be:

obj-vdso32 := sigtramp.o gettimeofday.o datapage.o cacheflush.o
targets    := $(obj-vdso32)
obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))

One line saved compared to below (not counting the src-vdso32 assignment
that is unused).
Also notice that ':=' uses all over. No need to use late evaluation when
no dynamic references are used ($ $@ etc.).

> +# Build rules
> +
> +obj-vdso32 := $(addsuffix .o, $(basename $(src-vdso32)))
> +targets := $(obj-vdso32) vdso32.so
> +obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
> +src-vdso32 := $(addprefix $(src)/, $(src-vdso32))


Same comments to the vdso64/Makefile

	Sam
