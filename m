Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbUCYVoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUCYVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:44:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32394
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263621AbUCYVoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:44:37 -0500
Date: Thu, 25 Mar 2004 22:45:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040325214529.GJ20019@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303070933.GB4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 08:09:33AM +0100, Andrea Arcangeli wrote:
> --- sles-objrmap/mm/mmap.c.~1~	2004-03-03 06:45:38.980596736 +0100
> +++ sles-objrmap/mm/mmap.c	2004-03-03 06:53:46.945414808 +0100
> @@ -1284,8 +1284,8 @@ int do_munmap(struct mm_struct *mm, unsi
>  	/*
>  	 * Remove the vma's, and unmap the actual pages
>  	 */
> -	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
>  	spin_lock(&mm->page_table_lock);
> +	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
>  	unmap_region(mm, mpnt, prev, start, end);
>  	spin_unlock(&mm->page_table_lock);
>  
> --- sles-objrmap/mm/swapfile.c.~1~	2004-03-03 06:45:39.023590200 +0100
> +++ sles-objrmap/mm/swapfile.c	2004-03-03 07:03:33.128301464 +0100
> @@ -499,7 +499,6 @@ static int unuse_process(struct mm_struc
>  	/*
>  	 * Go through process' page directory.
>  	 */
> -	down_read(&mm->mmap_sem);
>  	spin_lock(&mm->page_table_lock);
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>  		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
> @@ -507,7 +506,6 @@ static int unuse_process(struct mm_struc
>  			break;
>  	}
>  	spin_unlock(&mm->page_table_lock);
> -	up_read(&mm->mmap_sem);
>  	pte_chain_free(pte_chain);
>  	return 0;
>  }

Martin, I just found I was wrong about the above, I would been right in
the 2.4 VM, but in 2.6 the above is not needed. So you can delete the
above part from your tree too. it seems 2.6 really splitted the
page_table_lock from the mmap_sem and the only way to touch vmas is to
get the mmap_sem, the page_table_lock is unrelated to the vmas. This
wasn't the case in 2.4 where readers were allowed to take the
page_table_lock only.
