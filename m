Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVBWVmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVBWVmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBWVmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:42:36 -0500
Received: from aun.it.uu.se ([130.238.12.36]:18330 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261603AbVBWVkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:40:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16924.63125.283356.769192@alkaid.it.uu.se>
Date: Wed, 23 Feb 2005 22:33:09 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.30-pre1] preliminary fixes for gcc-4.0
In-Reply-To: <20050223212559.GC3432@stusta.de>
References: <16907.32186.211277.994120@alkaid.it.uu.se>
	<20050223212559.GC3432@stusta.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > On Thu, Feb 10, 2005 at 04:28:58PM +0100, Mikael Pettersson wrote:
 > > Here is a preliminary set of patches to allow gcc-4.0 (20050130)
 > > to compile the 2.4.30-pre1 kernel. I make no claim that the patches
 > > are complete, but they have been tested successfully on i386 (multiple
 > > boxes), x86-64, and ppc32.
 > > 
 > > The changes fall into these categories:
 > >...
 > > - Add -Wno-pointer-sign to silence lots of compiler warnings.
 > >...
 > > /Mikael
 > >...
 > > --- linux-2.4.30-pre1/arch/i386/Makefile	2004-11-17 18:36:41.000000000 +0100
 > > +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/i386/Makefile	2005-02-10 14:35:01.000000000 +0100
 > > @@ -98,6 +98,9 @@ endif
 > >  # due to the lack of sharing of stacklots.
 > >  CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
 > >  
 > > +# disable pointer signedness warnings in gcc 4.0
 > > +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
 > > +
 > >  HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 > >  
 > >  SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
 > > diff -rupN linux-2.4.30-pre1/arch/ppc/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile
 > > --- linux-2.4.30-pre1/arch/ppc/Makefile	2004-04-14 20:22:20.000000000 +0200
 > > +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile	2005-02-10 14:35:01.000000000 +0100
 > > @@ -25,6 +25,11 @@ CFLAGS		:= $(CFLAGS) -I$(TOPDIR)/arch/$(
 > >  HOSTCFLAGS	+= -I$(TOPDIR)/arch/$(ARCH)
 > >  CPP		= $(CC) -E $(CFLAGS)
 > >  
 > > +check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 > > +
 > > +# disable pointer signedness warnings in gcc 4.0
 > > +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
 > > +
 > >  ifdef CONFIG_4xx
 > >  CFLAGS := $(CFLAGS) -Wa,-m405
 > >  endif
 > >...
 > > --- linux-2.4.30-pre1/arch/x86_64/Makefile	2004-04-14 20:22:20.000000000 +0200
 > > +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/x86_64/Makefile	2005-02-10 14:35:01.000000000 +0100
 > > @@ -56,6 +56,9 @@ endif
 > >  # this is needed right now for the 32bit ioctl code
 > >  CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
 > >  
 > > +# disable pointer signedness warnings in gcc 4.0
 > > +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
 > > +
 > >  ifdef CONFIG_MK8
 > >  CFLAGS += $(call check_gcc,-march=k8,)
 > >  endif
 > >...
 > 
 > Shouldn't the first part of these three patches (adding 
 > -Wno-pointer-sign to the main Makefile be enough)?
 > 
 > That's also how it's handled in 2.6 .

No, because in 2.4 it's up to the arch Makefiles to define check_gcc
if they want it, and not all of them do. That's why I had to put the
CFLAGS adjustment in the arch Makefiles.

Maybe I should just unconditionally add check_gcc in the top Makefile
and nuke the ones in the arch Makefiles.

/Mikael
