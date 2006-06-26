Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWFZPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFZPBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWFZPBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:01:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64650 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932113AbWFZPBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:01:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=f4FCzISsYiTw8EPRGi7BPIkb0xAsIm+09ATK271uSNHH+TewjhS0vOdI7NGSZosL9gLKbYVviH4sYy9kZJIprVm3IOOMGLvmfsrF2HbvP4W2WXL/9VCgOcUl0UyNZF3EnK4iBrBMn2rxCFMnspWkgNFIx0d5o/j/vL9pr9zDOxo=
Message-ID: <449FF7D4.6010004@innova-card.com>
Date: Mon, 26 Jun 2006 17:05:56 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
CC: "vagabon >> Franck" <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
References: <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com> <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com> <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie> <449FC592.8050409@innova-card.com> <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie> <449FE5E0.3050603@innova-card.com> <20060626143159.GA700@skynet.ie>
In-Reply-To: <20060626143159.GA700@skynet.ie>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> 
> Lets close this out first and then figure out where to go next.  The following
> patch should fix the problem where mem_map is offset twice when ARCH_PFN_OFFSET
> != 0 and documents what ARCH_PFN_OFFSET is for.
> 

why not dropping the initial patch, and resubmit the whole thing that
can be called an optimization rather than a fix ?

> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm2-clean/include/asm-generic/memory_model.h linux-2.6.17-mm2-archpfnfix/include/asm-generic/memory_model.h
> --- linux-2.6.17-mm2-clean/include/asm-generic/memory_model.h	2006-06-26 11:38:21.000000000 +0100
> +++ linux-2.6.17-mm2-archpfnfix/include/asm-generic/memory_model.h	2006-06-26 15:22:19.000000000 +0100
> @@ -6,6 +6,20 @@
>  
>  #if defined(CONFIG_FLATMEM)
>  
> +/*
> + * With FLATMEM, the mem_map on node 0 is used as the global mem_map.
> + * This implicitly assumes that NODE_DATA(0)->node_start_pfn == 0 and
> + * represents the first physical page frame in the system. This is not
> + * always the case as an architecture may start physical memory at 3GB
> + * for example. Rather than allocating an empty mem_map to represent
> + * the non-existent memory, ARCH_PFN_OFFSET is subtracted from
> + * NODE_DATA(0)->node_mem_map such that;
> + *
> + * PFN 0 = mem_map = NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET
> + *
> + * One would expect NODE_DATA(0)->node_start_pfn == ARCH_PFN_OFFSET but
> + * depending on how memory is initialised, this is not always the case.
> + */
>  #ifndef ARCH_PFN_OFFSET
>  #define ARCH_PFN_OFFSET		(0UL)
>  #endif
> @@ -28,9 +42,8 @@
>   */
>  #if defined(CONFIG_FLATMEM)
>  
> -#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
> -#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
> -				 ARCH_PFN_OFFSET)
> +#define __pfn_to_page(pfn)	(mem_map + (pfn))
> +#define __page_to_pfn(page)	((unsigned long)((page) - mem_map))
>  #elif defined(CONFIG_DISCONTIGMEM)
>  
>  #define __pfn_to_page(pfn)			\
> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm2-clean/mm/page_alloc.c linux-2.6.17-mm2-archpfnfix/mm/page_alloc.c
> --- linux-2.6.17-mm2-clean/mm/page_alloc.c	2006-06-26 11:38:21.000000000 +0100
> +++ linux-2.6.17-mm2-archpfnfix/mm/page_alloc.c	2006-06-26 15:11:29.000000000 +0100
> @@ -2103,7 +2103,7 @@ static void __init alloc_node_mem_map(st
>  		 * is true. Adjust map relative to node_mem_map to
>  		 * maintain this relationship.
>  		 */
> -		map -= pgdat->node_start_pfn;
> +		map -= ARCH_PFN_OFFSET;

why not moving this inside the if statement below ?

>  	}
>  #ifdef CONFIG_FLATMEM
>  	/*
> 

