Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUC2SMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUC2SMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:12:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11511 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263024AbUC2SMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:12:35 -0500
Date: Mon, 29 Mar 2004 19:12:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, <akpm@osdl.org>,
       <riel@redhat.com>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <20040329172248.GR3808@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Andrea Arcangeli wrote:
> 
> Here a further update for xfs:
> 
> --- sles/fs/xfs/linux/xfs_vnode.h.~1~	2004-03-29 18:33:20.047028592 +0200
> +++ sles/fs/xfs/linux/xfs_vnode.h	2004-03-29 19:02:37.101915648 +0200
> @@ -601,8 +601,8 @@ static __inline__ void vn_flagclr(struct
>   * Some useful predicates.
>   */
>  #define VN_MAPPED(vp)	\
> -	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
> -	(!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
> +	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap)) || \
> +	(!prio_tree_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_shared))))
>  #define VN_CACHED(vp)	(LINVFS_GET_IP(vp)->i_mapping->nrpages)
>  #define VN_DIRTY(vp)	mapping_tagged(LINVFS_GET_IP(vp)->i_mapping, \
>  					PAGECACHE_TAG_DIRTY)

Needs also to check
	!list_empty(&(LINVFS_GET_IP(vp)->i_mapping->i_mmap_nonlinear))

Various arches need a similar conversion too (and use page_mapping(page)
rather than page->mapping: see arch and include/asm in my anobjrmap 3/6).

Those arches which do more than test list_empty (now prio_tree_empty),
arm and parisc (I think that's all): look as if they can take full
advantage of the prio tree; and I hope we can ignore the nonlinears
in those cases - if a page is mapped in a nonlinear vma it may suffer
from  D-cache aliasing inconsistencies if also mapped elsewhere in
that user address space, never mind.  Is that reasonable?

> and really some other bigger tree needs this part too (not a mainline
> issue).
> 
> --- sles/fs/xfs/dmapi/dmapi_xfs.c.~1~	2004-03-29 18:33:03.781501328 +0200
> +++ sles/fs/xfs/dmapi/dmapi_xfs.c	2004-03-29 18:58:57.754261560 +0200
> @@ -228,17 +228,21 @@ prohibited_mr_events(
>  	struct address_space *mapping = LINVFS_GET_IP(vp)->i_mapping;
>  	int prohibited = (1 << DM_EVENT_READ);
>  	struct vm_area_struct *vma;
> +	struct prio_tree_iter iter;
>  
>  	if (!VN_MAPPED(vp))
>  		return 0;
>  
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
>  	down(&mapping->i_shared_sem);
> -	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
> +	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
> +	while (vma) {
>  		if (!(vma->vm_flags & VM_DENYWRITE)) {
>  			prohibited |= (1 << DM_EVENT_WRITE);
>  			break;
>  		}
> +
> +		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter, 0, ULONG_MAX);
>  	}
>  	up(&mapping->i_shared_sem);
>  #else

This looks horrid (not your change, the original), and would need to look
at nonlinears too; but I thought this was what i_writecount < 0 is for?

Hugh

