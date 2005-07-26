Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGZM3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGZM3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVGZM3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:29:39 -0400
Received: from silver.veritas.com ([143.127.12.111]:42542 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261749AbVGZM3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:29:33 -0400
Date: Tue, 26 Jul 2005 13:30:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Roland Dreier <roland@topspin.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
In-Reply-To: <20050725171928.GC12206@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Jul 2005 12:29:30.0840 (UTC) FILETIME=[ABF09D80:01C591DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Michael S. Tsirkin wrote:
> 
> This patch adds PROT_DONTCOPY to mmap and mprotect, to set VM_DONTCOPY on vma.
> This is needed for infiniband userspace i/o, where we need to protect against
>   - the child process accessing the parent hardware page
>   - the parent registered address (on which the driver did get_user_pages)
>     getting remapped to another page by COW
> One can imagine other uses, e.g. combined with mlock for real-time or security.

I don't much like it, but it does solve a real problem in an efficient way.

Partly I don't like it because of "PROT_DONTCOPY" itself: I'm queasy
about protection flags which are not protection flags, though I find
you're not the first to go down that road.

Is the patch tested?  I've not tried, but suspect the newflags shift
and mask won't work for it.  And I don't look forward to your adding
VM_MAYDONTCOPY - ugh!

> @@ -246,7 +246,7 @@ sys_mprotect(unsigned long start, size_t
>  			goto out;
>  		}
>  
> -		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
> +		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC | VM_DONTCOPY));
>  
>  		if ((newflags & ~(newflags >> 4)) & 0xf) {
>  			error = -EACCES;

I rather think it would all be more cleanly handled by dropping the mmap
and mprotect changes, adding an madvise instead.  Though you may object
that madvise is for optional behaviours, and this should be mandatory.

The other reason I dislike the patch is that the problem it fixes is
an old one, and I'd much rather have get_user_pages fix it for itself,
than ask the developer to do some additional magic to get around it.

But I've failed to work out a simple efficient alternative, which won't
burden the vast majority of get_user_pages usages which never hit the
issue.  So your way is probably appropriate, but I'd prefer madvise.

(Sorry, I won't be able to discuss further for a couple of days.)

Hugh
