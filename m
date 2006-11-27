Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758189AbWK0NSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbWK0NSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758190AbWK0NSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:18:40 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:55778 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1758189AbWK0NSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:18:40 -0500
Date: Mon, 27 Nov 2006 13:18:37 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch1/4]: fake numa for x86_64 patch
In-Reply-To: <1164245649.29844.148.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0611271310200.11949@skynet.skynet.ie>
References: <1164245649.29844.148.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006, Rohit Seth wrote:

> This patch provides a IO hole size in a given address range.
>

Hi,

This patch reintroduces a function that doubles up what 
absent_pages_in_range(start_pfn, end_pfn). I recognise you do this because 
you are interested in hole sizes before add_active_range() is called. 
However, what is not clear is why these patches are so specific to x86_64.

It looks possible to do the work of functions like split_nodes_equal() in 
an architecture-independent manner using early_node_map rather than 
dealing with the arch-specific nodes array. That would open the 
possibility of providing fake nodes on more than one architecture in the 
future.

What I think can be done is that you register memory as normal and then 
split up the nodes into fake nodes. This would remove the need for having 
e820_hole_size() reintroduced.

> Signed-off-by: David Rientjes <reintjes@google.com>
> Signed-off-by: Paul Menage <menage@google.com>
> Signed-off-by: Rohit Seth <rohitseth@google.com>
>
> --- linux-2.6.19-rc5-mm2.org/include/asm-x86_64/e820.h	2006-11-22 12:20:39.000000000 -0800
> +++ linux-2.6.19-rc5-mm2/include/asm-x86_64/e820.h	2006-11-22 12:17:25.000000000 -0800
> @@ -46,6 +46,7 @@ extern void e820_mark_nosave_regions(voi
> extern void e820_print_map(char *who);
> extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
> extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
> +extern unsigned long e820_hole_size(unsigned long start, unsigned long end);
>
> extern void e820_setup_gap(void);
> extern void e820_register_active_regions(int nid,
> --- linux-2.6.19-rc5-mm2.org/arch/x86_64/kernel/e820.c	2006-11-22 12:20:55.000000000 -0800
> +++ linux-2.6.19-rc5-mm2/arch/x86_64/kernel/e820.c	2006-11-21 18:48:15.000000000 -0800
> @@ -184,6 +184,38 @@ unsigned long __init e820_end_of_ram(voi
> }
>
> /*
> + * Find the hole size in the range.
> + */
> +unsigned long __init e820_hole_size(unsigned long start, unsigned long end)
> +{
> +	unsigned long ram = 0;
> +	int i;
> +
> +	for (i = 0; i < e820.nr_map; i++) {
> +		struct e820entry *ei = &e820.map[i];
> +		unsigned long last, addr;
> +
> +		if (ei->type != E820_RAM ||
> +		    ei->addr+ei->size <= start ||
> +		    ei->addr >= end)
> +			continue;
> +
> +		addr = round_up(ei->addr, PAGE_SIZE);
> +		if (addr < start)
> +			addr = start;
> +
> +		last = round_down(ei->addr + ei->size, PAGE_SIZE);
> +		if (last >= end)
> +			last = end;
> +
> +		if (last > addr)
> +			ram += last - addr;
> +	}
> +	return ((end - start) - ram);
> +}
> +
> +
> +/*
>  * Mark e820 reserved areas as busy for the resource manager.
>  */
> void __init e820_reserve_resources(void)
>
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
