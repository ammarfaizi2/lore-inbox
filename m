Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWBMSym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWBMSym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWBMSyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:54:41 -0500
Received: from gold.veritas.com ([143.127.12.110]:47774 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964780AbWBMSyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:54:40 -0500
Date: Mon, 13 Feb 2006 18:23:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: William Irwin <wli@holomorphy.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213154114.GO32041@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0602131754430.8653@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 18:54:40.0081 (UTC) FILETIME=[F1907410:01C630CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Michael S. Tsirkin wrote:

> OK, I guess its time to start the push for merging this patch.
> Probably not 2.6.16 material, but it would be nice to get this say into -mm to
> make it easier to test this. Tested on x86_64 only.
> 
> Please Cc me directly with comments, I'm not on the list.
> 
> ---
> 
> Add madvise options to control whether memory range is inherited across fork.
> Useful e.g. for when hardware is doing DMA from/into these pages.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Looks good to me, Michael (but Gleb's eye has always proved better than
mine).  Just a couple of adjustments I'd ask before you send to Andrew: 

1. Please just drop your mm/mmap.c vm_stat_account() mod:

>  	if (flags & VM_HUGETLB) {
> -		if (!(flags & VM_DONTCOPY))
> +		if (!(flags & (VM_DONTCOPY|VM_DONTFORK)))
>  			mm->shared_vm += pages;

Conscientious of you to include that, but (a) if it's right, then you'd
need to be fiddling shared_vm up and down whenever madvise changes
VM_DONTFORK, and none us much want to get into that; and (b) I cannot
for the life of me work out what that VM_HUGETLB VM_DONTCOPY block is
about in the first place - I can't even find any instance of VM_HUGETLB
with VM_DONTCOPY to judge it by.  Luckily, wli CC'ed is the expert on
both hugetlb and vm_stat_account - I hope he'll just tell us that block
is wrong and should be deleted (which he or I could do as an unrelated
patch).  Perhaps it was an inappropriate hack to prevent some count
going negative, from the days when we forgot to correct total_vm in
the VM_DONTCOPY case in dup_mmap.

2. Your two-line changeset comment should be expanded: mention Infiniband,
mention get_user_pages, explain how frustrating it is for the carefully
pinned page to be orphaned from its user address space by a stray Copy-
On-Write, if the process happens to fork meanwhile; and how VM_DONTFORK
can be used to secure areas against that possibility.  Mention how it
could also be useful to an application, wanting to speed up its forks
by cutting large areas out of consideration.  Some of that information
will be useful to Michael Kerrisk when he updates the madvise man page.

Explain that MADV_DONTFORK should be reversible, hence MADV_DOFORK;
but should not be reversible on areas a driver has so marked, hence
VM_DONTFORK distinct from VM_DONTCOPY.

Thanks,
Hugh
