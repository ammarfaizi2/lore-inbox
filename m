Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSJYIyW>; Fri, 25 Oct 2002 04:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSJYIyW>; Fri, 25 Oct 2002 04:54:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61457 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261319AbSJYIyU>; Fri, 25 Oct 2002 04:54:20 -0400
Date: Fri, 25 Oct 2002 10:00:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
Message-ID: <20021025100028.A19335@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Martin Bligh <mjbligh@us.ibm.com>
References: <3DB8927E.5090909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB8927E.5090909@us.ibm.com>; from colpatch@us.ibm.com on Thu, Oct 24, 2002 at 05:38:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 05:38:22PM -0700, Matthew Dobson wrote:
> Anyone who is more familiar with some of the architectures I mucked with 
> (arm, alpha, ppc64), please let me know if what I've done looks wrong.

Well, this breaks ARM.  ARM needs MAX_NR_NODES even for the non-discontig
mem case.  Also, I really don't like the idea of re-using param.h for
something else - if its going to hoover up random constants, then its
going to create the usual mess, where if you change one constant that's
used in 1% of files, 100% of files gets rebuilt.

That is why arm has asm/memory.h to contain everything related to memory
translation and discontig memory.

It would be better if it remained in mmzone.h for non-arm, and the
memory.h files for arm.  I really never understood why numnodes.h was
created when mmzone.h has works adequately well since 2.3.

> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h
> --- linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h	Fri Oct 18 21:01:08 2002
> +++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h	Thu Oct 24 17:21:31 2002
> @@ -109,8 +109,6 @@
>   * 	node 3:  0xd8000000 - 0xdfffffff
>   */
>  
> -#define NR_NODES	4
> -
>  /*
>   * Given a kernel address, find the home node of the underlying memory.
>   */
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/param.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/param.h
> --- linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/param.h	Fri Oct 18 21:02:59 2002
> +++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/param.h	Thu Oct 24 17:21:31 2002
> @@ -17,3 +17,4 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
> +#define MAX_NR_NODES	4
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h
> --- linux-2.5.44-vanilla/include/asm-arm/memory.h	Fri Oct 18 21:02:30 2002
> +++ linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h	Thu Oct 24 17:21:31 2002
> @@ -88,12 +88,12 @@
>  #define pfn_to_page(pfn)					\
>  	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
>  
> -#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < NR_NODES)
> +#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < MAX_NR_NODES)
>  
>  #define virt_to_page(kaddr)					\
>  	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
>  
> -#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < NR_NODES)
> +#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < MAX_NR_NODES)
>  
>  /*
>   * Common discontigmem stuff.
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/numnodes.h linux-2.5.44-max_numnodes_fix/include/asm-arm/numnodes.h
> --- linux-2.5.44-vanilla/include/asm-arm/numnodes.h	Fri Oct 18 21:01:48 2002
> +++ linux-2.5.44-max_numnodes_fix/include/asm-arm/numnodes.h	Wed Dec 31 16:00:00 1969
> @@ -1,17 +0,0 @@
> -/*
> - *  linux/include/asm-arm/numnodes.h
> - *
> - *  Copyright (C) 2002 Russell King
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#ifndef __ASM_ARM_NUMNODES_H
> -#define __ASM_ARM_NUMNODES_H
> -
> -#include <asm/memory.h>
> -
> -#define MAX_NUMNODES	NR_NODES
> -
> -#endif
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/param.h linux-2.5.44-max_numnodes_fix/include/asm-arm/param.h
> --- linux-2.5.44-vanilla/include/asm-arm/param.h	Fri Oct 18 21:01:55 2002
> +++ linux-2.5.44-max_numnodes_fix/include/asm-arm/param.h	Thu Oct 24 17:21:31 2002
> @@ -13,6 +13,12 @@
>  #include <asm/arch/param.h>	/* for HZ */
>  #include <asm/proc/page.h>	/* for EXEC_PAGE_SIZE */
>  
> +#ifdef CONFIG_DISCONTIGMEM
> +# ifndef MAX_NR_NODES
> +# define MAX_NR_NODES	4
> +# endif
> +#endif /* CONFIG_DISCONTIGMEM */
> +
>  #ifndef __KERNEL_HZ
>  #define __KERNEL_HZ	100
>  #endif

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

