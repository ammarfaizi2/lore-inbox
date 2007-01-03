Return-Path: <linux-kernel-owner+w=401wt.eu-S1750820AbXACOgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbXACOgt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbXACOgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:36:49 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:48393 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbXACOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:36:40 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 09:36:40 EST
Message-ID: <459BBB36.1070907@gmail.com>
Date: Wed, 03 Jan 2007 15:18:07 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace __get_free_page() + memset(0) with get_zeroed_page()
 calls.
References: <Pine.LNX.4.64.0701030845500.5042@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701030845500.5042@localhost.localdomain>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   Replace the small number of combinations of __get_free_page() plus a
> call to memset(...,0,PAGE_SIZE) with a single call to
> get_zeroed_page().
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   all of the following simplifications *look* valid, but i'm happy to
> be convinced otherwise.
> 
> 
>  arch/sparc/mm/sun4c.c           |    4 +---
>  arch/sparc64/kernel/pci_iommu.c |    3 +--
>  drivers/s390/net/qeth_eddp.c    |    3 +--
>  include/asm-m68k/sun3_pgalloc.h |    3 +--
>  include/asm-um/pgtable-3level.h |    5 +----
>  sound/oss/emu10k1/main.c        |    3 +--
>  sound/oss/emu10k1/mixer.c       |    3 +--
>  7 files changed, 7 insertions(+), 17 deletions(-)
[...]
> index fd82411..b3932e5 100644
> --- a/include/asm-m68k/sun3_pgalloc.h
> +++ b/include/asm-m68k/sun3_pgalloc.h
> @@ -36,12 +36,11 @@ static inline void pte_free(struct page *page)
>  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>  					  unsigned long address)
>  {
> -	unsigned long page = __get_free_page(GFP_KERNEL|__GFP_REPEAT);
> +	unsigned long page = get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
> 
>  	if (!page)
>  		return NULL;
> 
> -	memset((void *)page, 0, PAGE_SIZE);
>  	return (pte_t *) (page);
>  }

perhaps simply
return (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);

> diff --git a/include/asm-um/pgtable-3level.h b/include/asm-um/pgtable-3level.h
> index ca0c2a9..6f43b58 100644
> --- a/include/asm-um/pgtable-3level.h
> +++ b/include/asm-um/pgtable-3level.h
> @@ -61,10 +61,7 @@ static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
> 
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
> -        pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
> -
> -        if(pmd)
> -                memset(pmd, 0, PAGE_SIZE);
> +        pmd_t *pmd = (pmd_t *) get_zeroed_page(GFP_KERNEL);
> 
>          return pmd;
>  }

here too, but this is also good.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
