Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315664AbSEIJ2x>; Thu, 9 May 2002 05:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315665AbSEIJ2x>; Thu, 9 May 2002 05:28:53 -0400
Received: from imladris.infradead.org ([194.205.184.45]:10255 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315664AbSEIJ2v>; Thu, 9 May 2002 05:28:51 -0400
Date: Thu, 9 May 2002 10:28:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8
Message-ID: <20020509102801.A9548@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205090019.g490JXY17324@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 05:19:33PM -0700, Patricia Gaughen wrote:
> 
> Please consider this patch for inclusion into the next 2.4 release.
> Sent this patch out last week as an RFC.  I've resolved the comments 
> from that post, mostly regarding config options.  

I think this patch, unlike the two previous cleanups, still needs some
polishing.

> http://prdownloads.sourceforge.net/lse/meminit-2.4.19pre8.patch
> http://prdownloads.sourceforge.net/lse/setup_arch-2.4.19pre8.patch
> The discontigmem patch is available at:
> 
> http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre8.patch

Urgg, sourceforge seems to have turned these nice links into some download
selector crap.  I think it's really time to stop using it as it gets worse
all time..
Any chance you could post links directly to one of the mirrors next time?

>  if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
> --- linux-2.4.19pre8-cleanup/arch/i386/kernel/Makefile	Fri Nov  9 14:21:21 2001
> +++ linux-2.4.19pre8-multi/arch/i386/kernel/Makefile	Wed May  8 11:09:21 2002
> @@ -40,5 +40,7 @@
>  obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
>  obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
>  obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
> +obj-$(CONFIG_X86_NUMAQ)		+= core_ibmnumaq.o

The core_ibmnumaq.* naming looks strange to me.  It seems derived from the
alpha naming where we support many different cores.  I think numaq.c
would fit much better in the naming of the other files in arch/i386/kernel/.
Please also note that the ifdef around the whole file body in core_ibmnumaq.c
is superflous as we already have the kbuild conditional.

> +obj-$(CONFIG_DISCONTIGMEM)	+= numa.o

Okay, this comes to the next issue, you seem to use CONFIG_DISCONTIGMEM
and CONFIG_X86_DISCONTIGMEM interchangable in arch/i386/* and numa.c in
fact has a big #ifdef CONFIG_X86_DISCONTIGMEM around all of the code.
AFAICS CONFIG_X86_DISCONTIGMEM is really the selector for the bootmem
workarounds and I think it shouldn't be used anywhere else, or even better
replaced by and HAVE_ARCH_BOOTMEM_NODE #define in asm/pgtable.h.

Also why is this file named numa.c and depends on CONFIG_DISCONTIGMEM?
Either it is NUMA-specific and depends on CONFIG_NUMA or it is dicontig
code and should be named discontig.c or something like that.  This file
is completly about memory managment, btw so I wonder why it isn't placed
in arch/i386/mm/..


> -static inline int page_is_ram (unsigned long pagenr)
> +inline int page_is_ram (unsigned long pagenr)

What about makeing this a static inline in one of the asm/ headers?
This way the external users also have it inline and I know besides
NUMAQ at least the LKCD people also want it.

> --- linux-2.4.19pre8-cleanup/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
> +++ linux-2.4.19pre8-multi/include/asm-i386/mmzone.h	Wed May  8 11:09:21 2002
> @@ -0,0 +1,103 @@
> +/*
> + * Written by Pat Gaughen (gone@us.ibm.com) Mar 2002
> + *
> + */
> +
> +#ifndef _ASM_MMZONE_H_
> +#define _ASM_MMZONE_H_
> +
> +#ifdef CONFIG_DISCONTIGMEM
<snip>
> +#endif /* CONFIG_X86_DISCONTIGMEM */

hmm?

