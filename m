Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVAWHqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVAWHqW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVAWHqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:46:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:39633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVAWHpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:45:53 -0500
Date: Sat, 22 Jan 2005 23:45:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: davem@davemloft.net, hugh@veritas.com, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
Message-Id: <20050122234517.376ef3f8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c may benefit from a
>  clear_page that is capable of zeroing multiple pages at once (and scrubd
>  too but that is now an independent patch). The following patch extends
>  clear_page with a second parameter specifying the order of the page to be zeroed to allow an
>  efficient zeroing of pages. Hope I caught everything....
> 

Sorry, I take it back.  As Paul says:

: Wouldn't it be nicer to call the version that takes the order
: parameter "clear_pages" and then define clear_page(p) as
: clear_pages(p, 0) ?

It would make the patch considerably smaller, and our naming is all over
the place anyway...

>  -static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
>  +void prep_zero_page(struct page *page, unsigned int order, unsigned int gfp_flags)
>   {
>   	int i;
> 
>   	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
>  +	if (!PageHighMem(page)) {
>  +		clear_page(page_address(page), order);
>  +		return;
>  +	}
>  +
>   	for(i = 0; i < (1 << order); i++)
>   		clear_highpage(page + i);
>   }

I'd have thought that we'd want to make the new clear_pages() handle
highmem pages too, if only from a regularity POV.  x86 hugetlbpages could
use it then, if someone thinks up a fast page-clearer.
