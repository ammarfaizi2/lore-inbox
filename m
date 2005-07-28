Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVG1BS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVG1BS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVG1BS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:18:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261470AbVG1BS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:18:27 -0400
Date: Wed, 27 Jul 2005 18:17:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shai@scalex86.org
Subject: Re: [patch] mm: Ensure proper alignment for node_remap_start_pfn
Message-Id: <20050727181724.36bd28ed.akpm@osdl.org>
In-Reply-To: <20050728004241.GA16073@localhost.localdomain>
References: <20050728004241.GA16073@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> While reserving KVA for lmem_maps of node, we have to make sure that
> node_remap_start_pfn[] is aligned to a proper pmd boundary.
> (node_remap_start_pfn[] gets its value from node_end_pfn[])
> 

What are the effects of not having this patch applied?  Does someone's
computer crash, or what?

IOW: what problem is this fixing, precisely?

> 
> Index: linux-2.6.13-rc3/arch/i386/mm/discontig.c
> ===================================================================
> --- linux-2.6.13-rc3.orig/arch/i386/mm/discontig.c	2005-07-26 15:10:25.000000000 -0700
> +++ linux-2.6.13-rc3/arch/i386/mm/discontig.c	2005-07-26 16:27:43.000000000 -0700
> @@ -243,6 +243,14 @@
>  		/* now the roundup is correct, convert to PAGE_SIZE pages */
>  		size = size * PTRS_PER_PTE;
>  
> +		if (node_end_pfn[nid] & (PTRS_PER_PTE-1)) {
> +			/* 
> +			 * Adjust size if node_end_pfn is not on a proper 
> +			 * pmd boundary. remap_numa_kva will barf otherwise.
> +			 */
> +			size +=  node_end_pfn[nid] & (PTRS_PER_PTE-1);
> +		}
> +
>  		/*
>  		 * Validate the region we are allocating only contains valid
>  		 * pages.
