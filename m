Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbUCVVw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUCVVw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:52:57 -0500
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:29348 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263707AbUCVVwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:52:54 -0500
Date: Mon, 22 Mar 2004 16:52:47 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] anobjrmap 7/6 mremap moves
In-Reply-To: <Pine.LNX.4.44.0403222032470.19332-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0403221636270.20432@sapphire.engin.umich.edu>
References: <Pine.LNX.4.44.0403222032470.19332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +struct vm_area_struct *copy_vma(struct vm_area_struct *vma,
> +	unsigned long addr, unsigned long len, unsigned long pgoff)
> +{
[snip]

> +	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
> +	new_vma = vma_merge(mm, prev, rb_parent, addr, addr + len,
> +			vma->vm_flags, vma->vm_file, pgoff);
[snip]
> +}
>
>  static unsigned long move_vma(struct vm_area_struct *vma,
>  {
[snip]
> +	new_vma = copy_vma(vma, new_addr, new_len, new_pgoff);
> +	if (!new_vma)
> +		return -ENOMEM;
[snip]
> +	moved_len = move_page_tables(vma, new_addr, old_addr, old_len);
> +	if (moved_len < old_len) {
> +		/*
> +		 * On error, move entries back from new area to old,
> +		 * which will succeed since page tables still there,
> +		 * and then proceed to unmap new area instead of old.
> +		 *
> +		 * Subtle point from Rajesh Venkatasubramanian: before
> +		 * moving file-based ptes, move new_vma before old vma
> +		 * in the i_mmap or i_mmap_shared list, so when racing
> +		 * against vmtruncate we cannot propagate pages to be
> +		 * truncated back from new_vma into just cleaned old.
> +		 */
> +		vma_relink_file(vma, new_vma);
> +		move_page_tables(new_vma, old_addr, new_addr, moved_len);
> +		vma = new_vma;
> +		old_len = new_len;
> +		old_addr = new_addr;
> +		new_addr = -ENOMEM;
> +	}

IF prio_tree gets merged and IF we plan to go by this vma ordering
solution for fixing vmtruncate vs. mremap race, then the vma_merge
in the copy_vma can bite us. The prio_tree only keeps the vmas that
_exactly_ map the same file pages in a list. If two vmas map different
set of file pages, then the ordering between them can change under
us if we drop i_shared_sem.

If we decide to go with the ordering solution, then my plan is to
setup an identical new_vma (that exactly maps same file pages as vma)
at new_addr and move the page tables. If the move fails, then use
vma_relink_file. If the move is successful, then we can do vma_merge.
I think we can think about these changes later. No hurry at this point.

Thanks,
Rajesh

