Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVAaXQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVAaXQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVAaXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:16:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:2984 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261427AbVAaXQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:16:00 -0500
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal
	trampoline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050131192713.GA16268@mars.ravnborg.org>
References: <1107151447.5712.81.camel@gaston>
	 <20050131192713.GA16268@mars.ravnborg.org>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 10:15:33 +1100
Message-Id: <1107213333.5905.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 20:27 +0100, Sam Ravnborg wrote:
> > Index: linux-work/arch/ppc64/kernel/vdso32/Makefile
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/arch/ppc64/kernel/vdso32/Makefile	2005-01-31 16:25:56.000000000 +1100
> > @@ -0,0 +1,50 @@
> > +# Choose compiler
> > +#
> > +# XXX FIXME: We probably want to enforce using a biarch compiler by default
> > +#             and thus use (CC) with -m64, while letting the user pass a
> > +#             CROSS32_COMPILE prefix if wanted. Same goes for the zImage
> > +#             wrappers
> > +#
> > +
> > +CROSS32_COMPILE ?=
> > +
> > +CROSS32CC		:= $(CROSS32_COMPILE)gcc
> > +CROSS32AS		:= $(CROSS32_COMPILE)as
> This needs to go into arch/ppc64/Makefile

Yes, we need to consolidate that with the CROSS32_COMPILE stuff using by
the boot wrapper (arch/ppc64/boot). I haven't yet completely decided
what to do there, I'll probably assume a biarch compiler by default
instead of using the local gcc for 32 bits unless CROSS32_COMPILE is
specified.

> > +
> > +# List of files in the vdso, has to be asm only for now
> > +
> > +src-vdso32 = sigtramp.S gettimeofday.S datapage.S cacheflush.S
> 
> It is normal kbuild practice to list .o files.
> So it would be:
> 
> obj-vdso32 := sigtramp.o gettimeofday.o datapage.o cacheflush.o
> targets    := $(obj-vdso32)
> obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
> 
> One line saved compared to below (not counting the src-vdso32 assignment
> that is unused).
> Also notice that ':=' uses all over. No need to use late evaluation when
> no dynamic references are used ($ $@ etc.).
> 
> > +# Build rules
> > +
> > +obj-vdso32 := $(addsuffix .o, $(basename $(src-vdso32)))
> > +targets := $(obj-vdso32) vdso32.so
> > +obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
> > +src-vdso32 := $(addprefix $(src)/, $(src-vdso32))
> 
> 
> Same comments to the vdso64/Makefile

Hrm... I remember back then flip/flop'ing between using .S and .o in the
file list and I had a reason to stick to .S but I can't remember why
now :) It may be something I fixed in the meantime tho, I'll have a
look .

I'm not sure about the "late evaluation" thing, I'm no make expert (just
learning as I write those makefiles), I'll have to dig in the doc here.

Ben.


