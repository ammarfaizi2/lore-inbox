Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHPS23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHPS23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHPS23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:28:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:17201 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932176AbWHPS22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:28:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=lQsa+9bQgcoUDKpXcPAFC5FgDl0Em676ClgTySvejCU2vZcMUL3TyLJPM+rIhGTC5
	ncJQx3npop3lnPduLbt0g==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C8A.6030705@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 16 Aug 2006 11:24:53 -0700
Message-Id: <1155752693.22595.76.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> Introduce UB_KMEMSIZE resource which accounts kernel
> objects allocated by task's request.
> 
> Reference to UB is kept on struct page or slab object.
> For slabs each struct slab contains a set of pointers
> corresponding objects are charged to.
> 
> Allocation charge rules:
>  1. Pages - if allocation is performed with __GFP_UBC flag - page
>     is charged to current's exec_ub.
>  2. Slabs - kmem_cache may be created with SLAB_UBC flag - in this
>     case each allocation is charged. Caches used by kmalloc are
>     created with SLAB_UBC | SLAB_UBC_NOCHARGE flags. In this case
>     only __GFP_UBC allocations are charged.

<snip>

> --- ./mm/page_alloc.c.kmemcore	2006-08-16 19:10:38.000000000 +0400
> +++ ./mm/page_alloc.c	2006-08-16 19:10:51.000000000 +0400
> @@ -38,6 +38,8 @@
>  #include <linux/mempolicy.h>
>  #include <linux/stop_machine.h>
>  
> +#include <ub/kmem.h>
> +
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
>  #include "internal.h"
> @@ -484,6 +486,8 @@ static void __free_pages_ok(struct page 
>  	if (reserved)
>  		return;
>  
> +	ub_page_uncharge(page, order);
> +
>  	kernel_map_pages(page, 1 << order, 0);
>  	local_irq_save(flags);
>  	__count_vm_events(PGFREE, 1 << order);
> @@ -764,6 +768,8 @@ static void fastcall free_hot_cold_page(
>  	if (free_pages_check(page))
>  		return;
>  
> +	ub_page_uncharge(page, 0);
> +
>  	kernel_map_pages(page, 1, 0);
>  
>  	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
> @@ -1153,6 +1159,11 @@ nopage:
>  		show_mem();
>  	}
>  got_pg:
> +	if ((gfp_mask & __GFP_UBC) &&
> +			ub_page_charge(page, order, gfp_mask)) {
> +		__free_pages(page, order);
> +		page = NULL;
> +	}
>  #ifdef CONFIG_PAGE_OWNER
>  	if (page)
>  		set_page_owner(page, order, gfp_mask);

If I'm reading this patch right then seems like you are making page
allocations to fail w/o (for example) trying to purge some pages from
the page cache belonging to this container.  Or is that reclaim going to
come later?

-rohit

