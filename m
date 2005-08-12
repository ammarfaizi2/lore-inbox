Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVHLOX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVHLOX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHLOX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:23:27 -0400
Received: from gold.veritas.com ([143.127.12.110]:61354 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751195AbVHLOX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:23:26 -0400
Date: Fri, 12 Aug 2005 15:25:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1123809302.17269.139.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508121506500.4208@goblin.wat.veritas.com>
References: <1123796188.17269.127.camel@localhost.localdomain>
 <1123809302.17269.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Aug 2005 14:23:23.0930 (UTC) FILETIME=[65CD27A0:01C59F49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Steven Rostedt wrote:
> 
> Found the problem.  It is a bug with mmap_kmem.  The order of checks is
> wrong, so here's the patch.
> -	if (!pfn_valid(vma->vm_pgoff))
> -		return -EIO;
>  	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
>  	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
> +	if (!pfn_valid(vma->vm_pgoff))
> +		return -EIO;
>  	return mmap_mem(file, vma);

Good find, looks right to me, so far as it goes (why does this check
pfn_valid just on the first? and remap_pfn_range will not behave as
you'd expect on most of kmem, not before Nick kills PageReserved;
and there's the red-penned issue of vmalloc'ed areas too).

Perhaps you're the first to mmap /dev/kmem: before those 2.6.11 changes,
going back beyond 2.4.0, it seems to have expected to caller to subtract
PAGE_OFFSET from the virtual address to give the file offset (when doing
mmap, but not when doing read/write - senseless, especially given the
variable behaviour of lseek to negative offset before the read/write).

Hugh
