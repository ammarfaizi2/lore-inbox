Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUHFT47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUHFT47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268266AbUHFTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:54:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:57575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268258AbUHFTxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:53:53 -0400
Date: Fri, 6 Aug 2004 12:52:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Aas <josha@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] improve speed of freeing bootmem
Message-Id: <20040806125216.30405230.akpm@osdl.org>
In-Reply-To: <4113DB63.9020706@sgi.com>
References: <4113DB63.9020706@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Aas <josha@sgi.com> wrote:
>
> Attached is a patch that greatly improves the speed of freeing boot 
> memory.

hm, OK.  I have a vague feeling that Bill Irwin had patches to fix this up
ages ago.


A few nits:

> --- a/mm/bootmem.c	2004-08-05 15:33:39.000000000 -0500
> +++ b/mm/bootmem.c	2004-08-06 13:42:33.000000000 -0500
> @@ -259,6 +259,7 @@ static unsigned long __init free_all_boo
>  	unsigned long i, count, total = 0;
>  	unsigned long idx;
>  	unsigned long *map; 
> +	int gofast = 0;
>  
>  	BUG_ON(!bdata->node_bootmem_map);
>  
> @@ -267,14 +268,32 @@ static unsigned long __init free_all_boo
>  	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
>  	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
>  	map = bdata->node_bootmem_map;
> +	if (bdata->node_boot_start == 0 ||
> +	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
> +		gofast = 1;

A comment describing the above reasoning would be nice.

>  	for (i = 0; i < idx; ) {
>  		unsigned long v = ~map[i / BITS_PER_LONG];
> -		if (v) {
> +		if (gofast && v == ~0UL) {
> +			int j;
> +
> +			count += BITS_PER_LONG;
> +			ClearPageReservedNoAtomic(page);
> +			set_page_count(page, 1);
> +			for (j = 1; j < BITS_PER_LONG; j++) {
> +				if (j + 16 < BITS_PER_LONG) {
> +                      			prefetchw(page + j + 16);
> +                                }

The whitespace/tabbing has gone funny here.

> +#define ClearPageReservedNoAtomic(page)	(page)->flags &= ~(1UL << PG_reserved)

The naming convention we used in 2.4 for the nonatomic operation was
__ClearPageReserved(), so can we please stick with that?

And this macro can use __clear_bit() rather than open-coding it.
