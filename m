Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbQKPRKm>; Thu, 16 Nov 2000 12:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQKPRKc>; Thu, 16 Nov 2000 12:10:32 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:3033 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131077AbQKPRKV> convert rfc822-to-8bit; Thu, 16 Nov 2000 12:10:21 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Linus Torvalds <torvalds@transmeta.com>
cc: mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Message-ID: <C1256999.005B8F06.00@d12mta07.de.ibm.com>
Date: Thu, 16 Nov 2000 17:12:27 +0100
Subject: Re: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>What happens if you just replace all places that would use a bad page
>table with a BUG()? (Ie do _not_ add the bug to the place where you
>added the test: by that time it's too late.  I'm talking about the
>places where the bad page tables are used, like in the error cases of
>"get_pte_kernel_slow()" etc.

Ok, the BUG() hit in get_pmd_slow:

pmd_t *
get_pmd_slow(pgd_t *pgd, unsigned long offset)
{
        pmd_t *pmd;
        int i;

        pmd = (pmd_t *) __get_free_pages(GFP_KERNEL,2);
        if (pgd_none(*pgd)) {
                if (pmd) {
                        for (i = 0; i < PTRS_PER_PMD; i++)
                                pmd_clear(pmd+i);
                        pgd_set(pgd, pmd);
                        return pmd + offset;
                }
                BUG();  /* <--- this one hit */
                pmd = (pmd_t *) get_bad_pmd_table();
                pgd_set(pgd, pmd);
                return NULL;
        }
        free_pages((unsigned long)pmd,2);
        if (pgd_bad(*pgd))
                BUG();
        return (pmd_t *) pgd_page(*pgd) + offset;
}

The allocation of 4 consecutive pages for the page middle directory failed.
This caused empty_bad_pmd_table to be used and clear_page_tables inserted
it to the pmd quicklist. The important question is: why did
__get_free_pages fail?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
