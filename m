Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVAYWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVAYWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVAYWri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:47:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:934 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262212AbVAYWrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:47:00 -0500
Date: Tue, 25 Jan 2005 22:46:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: TASK_SIZE is variable.]
Message-ID: <20050125224654.GA30150@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Content-Description: Forwarded message - TASK_SIZE is variable.
> Date: Tue, 25 Jan 2005 22:26:52 +0000
> From: David Woodhouse <dwmw2@infradead.org>
> Subject: TASK_SIZE is variable.
> To: linux-arch@vger.kernel.org
> X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
> 
> Bad things can happen if a 32-bit process is the last user of a 64-bit
> mm. TASK_SIZE isn't a constant, and we can end up clearing page tables
> only up to the 32-bit TASK_SIZE instead of all the way. We should
> probably double-check every instance of TASK_SIZE or USER_PTRS_PER_PGD
> for this kind of problem.

Or better get rid of TASK_SIZE completely.  Having something that looks
like a constant change depending on the user process is a bad idea.

> We should also double-check that MM_VM_SIZE() and other such things are
> correctly defined on all architectures. I already fixed ppc64 which let
> it stay as TASK_SIZE, and hence dependent on the _current_ context
> instead of the mm in the argument.
> 
> --- mm/mmap.c.orig	2005-01-25 22:23:02.030427272 +0000
> +++ mm/mmap.c	2005-01-25 22:23:55.627279312 +0000
> @@ -1612,8 +1612,8 @@ static void free_pgtables(struct mmu_gat
>  	unsigned long last = end + PGDIR_SIZE - 1;
>  	struct mm_struct *mm = tlb->mm;
>  
> -	if (last > TASK_SIZE || last < end)
> -		last = TASK_SIZE;
> +	if (last > MM_VM_SIZE(mm) || last < end)
> +		last = MM_VM_SIZE(mm);
>  
>  	if (!prev) {
>  		prev = mm->mmap;
> @@ -1996,7 +1996,7 @@ void exit_mmap(struct mm_struct *mm)
>  	vm_unacct_memory(nr_accounted);
>  	BUG_ON(mm->map_count);	/* This is just debugging */
>  	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
> -			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
> +			(MM_VM_SIZE(mm) + PGDIR_SIZE - 1) & PGDIR_MASK);
>  	
>  	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
>  
> 
> -- 
> dwmw2
