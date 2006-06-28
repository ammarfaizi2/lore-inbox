Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWF1SUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWF1SUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWF1SUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:20:40 -0400
Received: from gold.veritas.com ([143.127.12.110]:11614 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750759AbWF1SUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:20:39 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="61007356:sNHT32922952"
Date: Wed, 28 Jun 2006 19:20:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] mm: fixup do_wp_page()
In-Reply-To: <1151506711.5383.24.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606281847540.16379@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> 
 <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
 <1151506711.5383.24.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jun 2006 18:20:39.0090 (UTC) FILETIME=[8ECE3120:01C69ADF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Peter Zijlstra wrote:
> 
> How about something like this? This should make all anonymous write
> faults do as before the page_mkwrite patch.

Yes, I believe your patch below is just how it should be.

> As for copy_one_pte(), I'm not sure what you meant, shared writable
> anonymous pages need not be write protected as far as I can see.

Anonymous pages in a shared writable vma, got there via ptrace poke.
They're in a curious limbo between private and shared.  You can
reasonably argue that the page was supposed to be shared in the first
place, so although it's now become private, it's reasonable for it to
remain shared at least between parent and child.  I don't disagree.

But if it's then swapped out under memory pressure, and brought back
in, it will be treated as an ordinary anonymous page, write-protected,
and once parent or child makes a modification, will cease to be shared
between parent and child.  Not a big deal to lose sleep over, but
such pages do behave inconsistently.

Hugh

> --- linux-2.6-dirty.orig/mm/memory.c	2006-06-28 13:16:15.000000000 +0200
> +++ linux-2.6-dirty/mm/memory.c	2006-06-28 16:18:51.000000000 +0200
> @@ -1466,11 +1466,21 @@ static int do_wp_page(struct mm_struct *
>  		goto gotten;
>  
>  	/*
> -	 * Only catch write-faults on shared writable pages, read-only
> -	 * shared pages can get COWed by get_user_pages(.write=1, .force=1).
> +	 * Take out anonymous pages first, anonymous shared vmas are
> +	 * not accountable.
>  	 */
> -	if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
> +	if (PageAnon(old_page)) {
> +		if (!TestSetPageLocked(old_page)) {
> +			reuse = can_share_swap_page(old_page);
> +			unlock(old_page);
> +		}
> +	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
>  					(VM_WRITE|VM_SHARED))) {
> +		/*
> +		 * Only catch write-faults on shared writable pages,
> +		 * read-only shared pages can get COWed by
> +		 * get_user_pages(.write=1, .force=1).
> +		 */
>  		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
>  			/*
>  			 * Notify the address space that the page is about to
> @@ -1502,9 +1512,6 @@ static int do_wp_page(struct mm_struct *
>  		dirty_page = old_page;
>  		get_page(dirty_page);
>  		reuse = 1;
> -	} else if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
> -		reuse = can_share_swap_page(old_page);
> -		unlock_page(old_page);
>  	}
>  
>  	if (reuse) {
