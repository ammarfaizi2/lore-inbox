Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVAQUie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVAQUie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVAQUie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:38:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49536 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262874AbVAQUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:37:58 -0500
Date: Mon, 17 Jan 2005 15:30:23 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauricio.lin@indt.org.br>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] A new entry for /proc
Message-ID: <20050117173023.GA22202@logos.cnet>
References: <3f250c7105010613115554b9d9@mail.gmail.com> <20050106202339.4f9ba479.akpm@osdl.org> <3f250c7105011414466f22fc37@mail.gmail.com> <20050114154209.6b712e55.akpm@osdl.org> <3f250c71050117100332774211@mail.gmail.com> <3f250c71050117110241dfc46c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050117110241dfc46c@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mauricio,

On Mon, Jan 17, 2005 at 03:02:14PM -0400, Mauricio Lin wrote:
> Hi Andrew,
> 
> I figured out the error. This patch works for others editors as well.

<snip>

> diff -uprN linux-2.6.10/fs/proc/task_mmu.c linux-2.6.10-smaps/fs/proc/task_mmu.c
> --- linux-2.6.10/fs/proc/task_mmu.c	2004-12-24 17:34:01.000000000 -0400
> +++ linux-2.6.10-smaps/fs/proc/task_mmu.c	2005-01-17 14:55:17.000000000 -0400
> @@ -81,6 +81,76 @@ static int show_map(struct seq_file *m, 
>  	return 0;
>  }
>  
> +static void resident_mem_size(struct mm_struct *mm,
> +			      unsigned long start_address,
> +			      unsigned long end_address,
> +			      unsigned long *size)
> +{
> +	pgd_t *pgd;
> +	pmd_t *pmd;
> +	pte_t *ptep, pte;
> +	unsigned long each_page;
> +
> +	for (each_page = start_address; each_page < end_address; 
> +	     each_page += PAGE_SIZE) {
> +		pgd = pgd_offset(mm, each_page);
> +		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
> +			continue;
> +
> +		pmd = pmd_offset(pgd, each_page);
> +
> +		if (pmd_none(*pmd))
> +			continue;
> +
> +		if (unlikely(pmd_bad(*pmd)))
> +			continue;
> +
> +		if (pmd_present(*pmd)) {
> +			ptep = pte_offset_map(pmd, each_page);
> +			if (!ptep)
> +				continue;
> +			pte = *ptep;
> +			pte_unmap(ptep);
> +			if (pte_present(pte))
> +				*size += PAGE_SIZE;
> +		}
> +	}
> +}

You want to update your patch to handle the new 4level pagetables which introduces
a new indirection table: the PUD. 

Check 2.6.11-rc1 - mm/rmap.c.

BTW: What does PUD stand for?




