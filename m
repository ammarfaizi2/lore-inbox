Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266164AbUF3Acb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUF3Acb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUF3Acb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:32:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:54737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266164AbUF3Abl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:31:41 -0400
Date: Tue, 29 Jun 2004 17:30:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: remap_pte_range
Message-Id: <20040629173037.68e5d958.akpm@osdl.org>
In-Reply-To: <65600000.1088554644@flay>
References: <65600000.1088554644@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I have no idea what remap_pte_range is trying to do here, but what it
> is doing makes no sense (to me at least). 
> 
> If the pfn is not valid, we CANNOT safely call PageReserved on it - 
> the *page returned from pfn_to_page is bullshit, and we crash deref'ing
> it.
> 
> Perhaps this was what it was trying to do? Not sure.
> 
> diff -purN -X /home/mbligh/.diff.exclude virgin/mm/memory.c remap_pte_range/mm/memory.c
> --- virgin/mm/memory.c	2004-06-16 10:22:15.000000000 -0700
> +++ remap_pte_range/mm/memory.c	2004-06-29 17:15:35.000000000 -0700
> @@ -908,7 +908,7 @@ static inline void remap_pte_range(pte_t
>  	pfn = phys_addr >> PAGE_SHIFT;
>  	do {
>  		BUG_ON(!pte_none(*pte));
> -		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
> +		if (pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
>   			set_pte(pte, pfn_pte(pfn, prot));
>  		address += PAGE_SIZE;
>  		pfn++;

It seems OK as-is.

If the pfn is not valid then establish the pte to point at physical memory.

If the pfn _is_ valid then check PageReserved.  If the page is reserved
then establish a pte to point at it.

The slightly weird thing is that we do

	pfn = phys_addr >> PAGE_SHIFT;
	...
	pfn_pte(pfn);

to go from the physical address back to a masked&shifted version of the
physical address.  Maybe that operation is doing the wrong thing in your
setup and we should go straight from the physical address to the pte value,
like 2.4's mk_pte_phys().


