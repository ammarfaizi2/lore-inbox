Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVHAUS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVHAUS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVHAUS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:18:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbVHAURX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:17:23 -0400
Date: Mon, 1 Aug 2005 13:16:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, nickpiggin@yahoo.com.au, holt@sgi.com,
       roland@redhat.com, schwidefsky@de.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <20050801125700.4ba0807b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508011311260.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
 <Pine.LNX.4.61.0508012024330.5373@goblin.wat.veritas.com>
 <20050801125700.4ba0807b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Andrew Morton wrote:
> 
> That was introduced 19 months ago by the s390 guys (see patch below). 

This really is a very broken patch, btw. 

> +		if (write && !pte_write(pte))
> +			goto out;
> +		if (write && !pte_dirty(pte)) {
> +			struct page *page = pte_page(pte);
> +			if (!PageDirty(page))
> +				set_page_dirty(page);
> +		}
> +		pfn = pte_pfn(pte);
> +		if (pfn_valid(pfn)) {
> +			struct page *page = pfn_to_page(pfn);
> +			
> +			mark_page_accessed(page);
> +			return page;

Note how it doesn't do any "pfn_valid()" stuff for the dirty bit setting, 
so it will set random bits in memory if the pte points to some IO page. 

Maybe that doesn't happen on s390, but..

Anyway, if the s390 people just have a sw-writable bit in their page table
layout, I bet they can fix their problem by just having a "sw dirty"  
bit, and then make "pte_mkdirty()" set that bit. Nobody else will care, 
but ptrace will then just work correctly for them too.

		Linus
