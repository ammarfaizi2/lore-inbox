Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVIYWJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVIYWJi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVIYWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:09:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23258 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932315AbVIYWJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:09:37 -0400
Date: Mon, 26 Sep 2005 00:07:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][Fix] Prevent swsusp from corrupting page translation tables during resume on x86-64
Message-ID: <20050925220738.GF2775@elf.ucw.cz>
References: <200509241936.12214.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509241936.12214.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch fixes Bug #4959.  It creates temporary page translation
> tables located in the page frames that are not overwritten by swsusp while copying
> the image.
> 
> The temporary page translation tables are generally based on the existing ones
> with the exception that the mappings using 4KB pages are replaced with the
> equivalent mappings that use 2MB pages only.  The temporary page tables are
> only used for copying the image.

Would not it be simpler to create them from scratch? mm/init.c has
some handy functions, they should be applicable. [init_memory_mapping,
phys_pud_init]. Perhaps even initialize only simple direct mapping,
and place virt_to_phys() at strategic places?
								Pavel

> +static int __duplicate_page_tables(pgd_t *src_pgd, pgd_t *pgd, unsigned long map_offset)
> +{
> +	pud_t *src_pud, *pud;
> +	pmd_t *src_pmd, *pmd;
> +	pte_t *src_pte;
> +	int i, j, k;
> +
> +	pr_debug("Duplicating pagetables for the map 0x%016lx at 0x%016lx\n",
> +		map_offset, (unsigned long)src_pgd);
> +	i = pgd_index(map_offset);
> +	j = pud_index(map_offset);
> +	k = pmd_index(map_offset);
> +	src_pgd += i;
> +	pgd += i;
> +	for (; pgd_val(*src_pgd) && i < PTRS_PER_PGD; i++, src_pgd++, pgd++) {
> +		pud = (pud_t *)get_usable_page(GFP_ATOMIC);
> +		if (!pud)
> +			return -ENOMEM;
> +		pgd_val(*pgd) = (pgd_val(*src_pgd) & ~__PGTABLE_MASK) |
> +			__pa((unsigned long)pud);
> +		pud += j;
> +		src_pud = (pud_t *)__va(pgd_val(*src_pgd) & __PGTABLE_MASK) + j;
> +		for (; pud_val(*src_pud) && j < PTRS_PER_PUD; j++, src_pud++, pud++) {
> +			pmd = (pmd_t *)get_usable_page(GFP_ATOMIC);
> +			if (!pmd)
> +				return -ENOMEM;
> +			pud_val(*pud) = (pud_val(*src_pud) & ~__PGTABLE_MASK) |
> +				__pa((unsigned long)pmd);
> +			pmd += k;
> +			src_pmd = (pmd_t *)__va(pud_val(*src_pud) & __PGTABLE_MASK) + k;
> +			for (; pmd_val(*src_pmd) && k < PTRS_PER_PMD; k++, src_pmd++, pmd++)
> +				if (pmd_val(*src_pmd) & _PAGE_PSE) /* 2MB page */
> +					pmd_val(*pmd) = pmd_val(*src_pmd);
> +				else { /* 4KB page table -> 2MB page */
> +					src_pte = __va(pmd_val(*src_pmd) & __PGTABLE_MASK);
> +					pmd_val(*pmd) = ((pmd_val(*src_pmd) & ~__PGTABLE_MASK) |
> +						_PAGE_PSE) |
> +						(pte_val(*src_pte) & __PGTABLE_PSE_MASK);
> +				}
> +			k = 0;
> +		}
> +		j = 0;
> +	}
> +	return 0;
> +}

-- 
if you have sharp zaurus hardware you don't need... you know my address
