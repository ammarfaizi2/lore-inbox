Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVADTw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVADTw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVADTvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:51:23 -0500
Received: from one.firstfloor.org ([213.235.205.2]:46776 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261854AbVADTqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:46:51 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V14 [5/7]: x86_64 atomic pte
 operations
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Tue, 04 Jan 2005 20:46:50 +0100
In-Reply-To: <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Tue, 4 Jan 2005 11:38:20 -0800 (PST)")
Message-ID: <m1652ddljp.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

I bet this has been never tested.

>  #define pmd_populate_kernel(mm, pmd, pte) \
>  		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
>  #define pud_populate(mm, pud, pmd) \
> @@ -14,11 +18,24 @@
>  #define pgd_populate(mm, pgd, pud) \
>  		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pud)))
>
> +#define pmd_test_and_populate(mm, pmd, pte) \
> +		(cmpxchg((int *)pmd, PMD_NONE, _PAGE_TABLE | __pa(pte)) == PMD_NONE)
> +#define pud_test_and_populate(mm, pud, pmd) \
> +		(cmpxchg((int *)pgd, PUD_NONE, _PAGE_TABLE | __pa(pmd)) == PUD_NONE)
> +#define pgd_test_and_populate(mm, pgd, pud) \
> +		(cmpxchg((int *)pgd, PGD_NONE, _PAGE_TABLE | __pa(pud)) == PGD_NONE)
> +

Shouldn't this all be (long *)pmd ? page table entries on x86-64 are 64bit.
Also why do you cast at all? i think the macro should handle an arbitary
pointer.

> +
>  static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
>  {
>  	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
>  }
>
> +static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
> +{
> +	return cmpxchg((int *)pmd, PMD_NONE, _PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)) == PMD_NONE;

Same.

-Andi
