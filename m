Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJXTMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJXTMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVJXTMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:12:09 -0400
Received: from gold.veritas.com ([143.127.12.110]:55911 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750757AbVJXTMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:12:08 -0400
Date: Mon, 24 Oct 2005 20:11:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: David Howells <dhowells@redhat.com>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops
In-Reply-To: <9792.1130171024@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>
References: <1130168619.19518.43.camel@imp.csi.cam.ac.uk> 
 <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
 <7872.1130167591@warthog.cambridge.redhat.com>  <9792.1130171024@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 19:12:08.0008 (UTC) FILETIME=[D3E96C80:01C5D8CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, David Howells wrote:
> 
> The attached patch adds a new VMA operation to notify a filesystem or other
> driver about the MMU generating a fault because userspace attempted to write
> to a page mapped through a read-only PTE.
> 
> This facility permits the filesystem or driver to:
> 
>  (*) Implement storage allocation/reservation on attempted write, and so to
>      deal with problems such as ENOSPC more gracefully (perhaps by generating
>      SIGBUS).
> 
>  (*) Delay making the page writable until the contents have been written to a
>      backing cache. This is useful for NFS/AFS when using FS-Cache/CacheFS.
>      It permits the filesystem to have some guarantee about the state of the
>      cache.

I've only given it a quick look, it looks pretty good, but too hastily
thrown together, without understanding of the intervening changes:

> --- linux-2.6.14-rc4-mm1/mm/memory.c	2005-10-17 14:26:44.000000000 +0100
> +++ linux-2.6.14-rc4-mm1-cachefs/mm/memory.c	2005-10-20 18:53:04.000000000 +0100
> @@ -1261,19 +1261,53 @@ static int do_wp_page(struct mm_struct *
> +	if (unlikely(vma->vm_flags & VM_SHARED)) {
> +		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
> +			/*
> +			 * Notify the page owner without the lock held,
> +			 * so they can sleep if they want to.
> +			 */
> +			pte_unmap(page_table);
> +			if (!PageReserved(old_page))
> +				page_cache_get(old_page);
> +			spin_unlock(&mm->page_table_lock);

No, you need to pay attention to Nick's PageReserved removal, and
my pte lock stuff, throughout do_wp_page - there shouldn't be any
references to PageReserved or page_table_lock there now (and you'll
need to recheck the mapping/locking/unlocking/unmapping).  Sorry,
I don't have the time to spare to do it myself right now.

> +			page_table = pte_offset_map(pmd, address);
> +			if (!pte_same(*page_table, orig_pte)) {
> +				ret |= VM_FAULT_WRITE;

No, don't add VM_FAULT_WRITE in this case: you should only do that
when you've gone through the maybe_mkwrite yourself; this case
should remain the default VM_FAULT_MINOR.

> @@ -1847,18 +1890,28 @@ retry:
> +		} else {
> +			/* if the page will be shareable, see if the backing
> +			 * address space wants to know that the page is about
> +			 * to become writable */
> +			if (vma->vm_ops->page_mkwrite &&
> +			    vma->vm_ops->page_mkwrite(vma, new_page) < 0)
> +				return VM_FAULT_SIGBUS;
> +		}
>  	}

This isn't necessarily wrong, and may be exactly how it was before,
I don't remember.  But it implies that when page_mkwrite fails,
it page_cache_releases the page.  Is that desirable?  Or should
that be left to the caller?

> @@ -1945,7 +1998,7 @@ static int do_file_page(struct mm_struct

Drop all those changes to do_file_page (which I added), they're no
longer necessary.  A case appeared which made it clear that we cannot
rely on resolving this issue for get_user_pages in a single call to
handle_mm_fault, and that's why the VM_FAULT_WRITE stuff got added. 

This complication of do_file_page was always ugly, and I'm delighted
to drop it.  Whereas the call to do_wp_page from do_swap_page is less
obtrusive and may still be a worthwhile optimization, though I added
it for the same disgraced reason a year or more back.

Hugh
