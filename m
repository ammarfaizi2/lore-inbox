Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSI0Oii>; Fri, 27 Sep 2002 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbSI0Oii>; Fri, 27 Sep 2002 10:38:38 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:48401 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261708AbSI0Oig>; Fri, 27 Sep 2002 10:38:36 -0400
Date: Fri, 27 Sep 2002 16:43:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>
Subject: Re: [PATCH] Put modules into linear mapping
In-Reply-To: <20020927140930.GA12610@averell>
Message-ID: <Pine.LNX.4.44.0209271618360.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Sep 2002, Andi Kleen wrote:

> --- linux-2.5.38-work/include/asm-i386/module.h-MODULE	2002-09-25 00:59:28.000000000 +0200
> +++ linux-2.5.38-work/include/asm-i386/module.h	2002-09-27 15:30:35.000000000 +0200
> +/*
> + * Try to allocate in the linear large page mapping first to conserve
> + * TLB entries.
> + */
> +static inline void *module_map(unsigned long size)
> +{
> +	void *p = alloc_exact(size);
> +	if (!p)
> +		p = vmalloc(size);
> +	return p;
> +}

Why is i386 only? This is generic code and other archs will benefit from
it as well (or at least it won't hurt).

$ grep module_map include/asm-*/*.h
include/asm-alpha/module.h:#define module_map(x)                vmalloc(x)
include/asm-arm/module.h:#define module_map(x)          vmalloc(x)
include/asm-cris/module.h:#define module_map(x)         vmalloc(x)
include/asm-i386/module.h:#define module_map(x)         vmalloc(x)
include/asm-ia64/module.h:#define module_map(x)         vmalloc(x)
include/asm-m68k/module.h:#define module_map(x)         vmalloc(x)
include/asm-mips/module.h:#define module_map(x)         vmalloc(x)
include/asm-mips64/module.h:#define module_map(x)               vmalloc(x)
include/asm-parisc/pgtable.h:#define module_map vmalloc
include/asm-ppc/module.h:#define module_map(x)          vmalloc(x)
include/asm-ppc64/module.h:#define module_map(x)                vmalloc(x)
include/asm-s390/module.h:#define module_map(x)         vmalloc(x)
include/asm-s390x/module.h:#define module_map(x)                vmalloc(x)
include/asm-sh/module.h:#define module_map(x)           vmalloc(x)
include/asm-sparc/module.h:#define module_map(x)                vmalloc(x)
include/asm-sparc64/module.h:extern void * module_map (unsigned long size);
include/asm-x86_64/module.h:extern void *module_map(unsigned long);

The x86_64 version is currently broken, as it uses vmalloc_area_pages
which doesn't exist anymore, but it did the same as vmalloc. The sparc64
version also looks like vmalloc reimplementation.

> +
> +void *alloc_exact(unsigned int size)
> +{
> +	struct page *p, *w;
> +	int order = get_order(size);
> +
> +	p = alloc_pages(GFP_KERNEL, order);

Wouldn't it be better to add a gfp argument?

bye, Roman

