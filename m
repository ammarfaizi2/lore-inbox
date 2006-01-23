Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWAWVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWAWVey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWAWVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:34:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2532 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964960AbWAWVex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:34:53 -0500
Subject: Re: Can't mlock hugetlb in 2.6.15
From: Adam Litke <agl@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Don Dupuis <dondster@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601231917210.5915@goblin.wat.veritas.com>
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com>
	 <20060120235240.39d34279.akpm@osdl.org>  <43D24167.1010007@yahoo.com.au>
	 <632b79000601221832w4cb44582y823ee7dc80e9a34f@mail.gmail.com>
	 <Pine.LNX.4.61.0601231917210.5915@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 23 Jan 2006 15:34:50 -0600
Message-Id: <1138052090.24257.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aye.

On Mon, 2006-01-23 at 19:51 +0000, Hugh Dickins wrote:
> Thanks a lot for the strace, that indeed helped to track it down.
> 
> This has nothing to do with mlock or MAP_LOCKED - which by the way do
> make more sense in 2.6.15, since they provide a way of prefaulting the
> hugepage area like in earlier releases (now hugepages are being faulted
> in on demand, though never paged out, as Andrew said).
> 
> Please try the patch below, and let us know if it works for you - thanks.
> Looks like we'll need this in 2.6.16-rc-git and 2.6.15-stable.
> 
> 
> 2.6.15's hugepage faulting introduced huge_pages_needed accounting into
> hugetlbfs: to count how many pages are already in cache, for spot check
> on how far a new mapping may be allowed to extend the file.  But it's
> muddled: each hugepage found covers HPAGE_SIZE, not PAGE_SIZE.  Once
> pages were already in cache, it would overshoot, wrap its hugepages
> count backwards, and so fail a harmless repeat mapping with -ENOMEM.
> Fixes the problem found by Don Dupuis.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-By: Adam Litke <agl@us.ibm.com>
> ---
> 
>  fs/hugetlbfs/inode.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- 2.6.15/fs/hugetlbfs/inode.c	2006-01-03 03:21:10.000000000 +0000
> +++ linux/fs/hugetlbfs/inode.c	2006-01-23 18:39:47.000000000 +0000
> @@ -71,8 +71,8 @@ huge_pages_needed(struct address_space *
>  	unsigned long start = vma->vm_start;
>  	unsigned long end = vma->vm_end;
>  	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
> -	pgoff_t next = vma->vm_pgoff;
> -	pgoff_t endpg = next + ((end - start) >> PAGE_SHIFT);
> +	pgoff_t next = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
> +	pgoff_t endpg = next + hugepages;
>  
>  	pagevec_init(&pvec, 0);
>  	while (next < endpg) {
> 
> 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

