Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbQJaCJJ>; Mon, 30 Oct 2000 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130050AbQJaCI7>; Mon, 30 Oct 2000 21:08:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11273 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129804AbQJaCIp>; Mon, 30 Oct 2000 21:08:45 -0500
Date: Tue, 31 Oct 2000 03:08:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001031030838.A30461@athlon.random>
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001030124513.A28667@caldera.de>; from hch@caldera.de on Mon, Oct 30, 2000 at 12:45:13PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:45:13PM +0100, Christoph Hellwig wrote:
> @@ -393,10 +396,15 @@
>  	pmd = pmd_offset(pgd, address);
>  	if (pmd) {
>  		pte_t * pte = pte_offset(pmd, address);
> -		if (pte && pte_present(*pte))
> +		if (pte && pte_present(*pte)) {
> +			if (writeacc && !pte_write(*pte))
> +				goto retry;
>  			return pte_page(*pte);
> +		}
>  	}

It should also make sure the pte is dirty before starting the read-from-disk
I/O and then things will currently break in the swapout because the page is not
locked (see discussion of last week). The fix for that problem proposed by SCT
and Linus is that the page (not pte) will be marked dirty during swapout and
written back to disk _only_ once reference count is 1 (btw I now noticed
invalidate_inode_pages+MAP_SHARED will mess with that fix and it will trigger a
BUG() in free_pages).

> +
> +faultin:
>  		if (handle_mm_fault(current->mm, vma, ptr, datain) <= 0) 
>  			goto out_unlock;
>  		spin_lock(&mm->page_table_lock);
> -		map = follow_page(ptr);
> -		if (!map) {
> +		map = follow_page(ptr, datain, &failed);
> +		if (failed) {
> +			/*
> +			 * Page got stolen before we could lock it down.
> +			 * Retry.
> +			 */
>  			spin_unlock(&mm->page_table_lock);
> -			dprintk (KERN_ERR "Missing page in map_user_kiobuf\n");
> -			goto out_unlock;
> +			goto faultin;

This is suboptimal (walks the pagetables twice if the page is just mapped). It
should be a follow page first and handle_mm_fault only if follow page failed.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
