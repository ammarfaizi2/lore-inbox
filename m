Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVKJJhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKJJhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKJJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:37:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750720AbVKJJhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:37:10 -0500
Date: Thu, 10 Nov 2005 01:36:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [patch] Cleanup bootmem allocator and fix alloc_bootmem_low
Message-Id: <20051110013654.75e55a61.akpm@osdl.org>
In-Reply-To: <20051108073224.GA3753@localhost.localdomain>
References: <20051108073224.GA3753@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Hi Andrew,
> The following patch removes alloc_bootmem_*limit apis and fixes
> alloc_bootmem_low and friends to allocate below the 4G limit.
> 
> ...
>
> +void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
> +{
> +	pg_data_t *pgdat = pgdat_list;
> +	void *ptr;
> +
> +	for_each_pgdat(pgdat)
> +		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
> +						 align, goal, 0x100000000)))
> +			return(ptr);
> +
> +	/*
> +	 * Whoops, we cannot satisfy the allocation request.
> +	 */
> +	printk(KERN_ALERT "low bootmem alloc of %lu bytes failed!\n", size);
> +	panic("Out of low memory");
> +	return NULL;
> +}
> +
> +void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size, 
> +				       unsigned long align, unsigned long goal)
> +{
> +	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0x100000000);
> +}

mm/bootmem.c: In function `__alloc_bootmem_low':
mm/bootmem.c:432: warning: integer constant is too large for "long" type
mm/bootmem.c:432: warning: large integer implicitly truncated to unsigned type
mm/bootmem.c: In function `__alloc_bootmem_low_node':
mm/bootmem.c:446: warning: integer constant is too large for "long" type
mm/bootmem.c:446: warning: large integer implicitly truncated to unsigned type

