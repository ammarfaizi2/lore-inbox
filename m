Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWFWPKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWFWPKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFWPKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:10:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:28536 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751438AbWFWPJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:09:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pc0QHyqTfCJOGWsu1ws0rTgCAElpKCq63ZAIcA6n/9NJ6W29fGaquRQKQqdFwVlTQPJ3yZFRngTL9SUqrkKb9xECVivipghG2cxHQpdTtBk8ceBcL4agihpz6Dg5k7XtIx0w6tub7j6K2CetQIHvIIgGoIzOof3J9csMnADHDNA=
Message-ID: <449C054F.7010109@innova-card.com>
Date: Fri, 23 Jun 2006 17:14:23 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: franck.bui-huu@innova-card.com
CC: Mel Gorman <mel@skynet.ie>, Franck Bui-Huu <vagabon.xyz@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com>
In-Reply-To: <449C036D.6060004@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> 
> what do you think about this use of ARCH_PFN_OFFSET ?
> 
> diff --git a/mm/bootmem.c b/mm/bootmem.c
> index d213fed..fd28eed 100644
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -377,11 +377,11 @@ unsigned long __init free_all_bootmem_no
>  	return(free_all_bootmem_core(pgdat));
>  }
>  
> -unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
> +unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
>  {
>  	max_low_pfn = pages;
>  	min_low_pfn = start;
> -	return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
> +	return init_bootmem_core(NODE_DATA(0), start, ARCH_PFN_OFFSET, pages);
>  }
>  
>  #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ed6a40f..43abaeb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2154,7 +2154,7 @@ #ifdef CONFIG_FLATMEM
>  		 * relative to node_mem_map to maintain this
>  		 * relationship.
>  		 */
> -		mem_map = map - ARCH_PFN_OFFSET;
> +		mem_map = map - pgdat->node_start_pfn;
>  #endif
>  #endif /* CONFIG_FLAT_NODE_MEM_MAP */
>  }
> @@ -2181,8 +2181,7 @@ #endif
>  
>  void __init free_area_init(unsigned long *zones_size)
>  {
> -	free_area_init_node(0, NODE_DATA(0), zones_size,
> -			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);

I'm wondering why using "__pa(PAGE_OFFSET) >> PAGE_SHIFT" to compute the start
of memory. That should always result in 0, shouldn't it ?

		Franck
