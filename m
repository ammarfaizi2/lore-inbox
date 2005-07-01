Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbVGAMvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbVGAMvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGAMvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:51:04 -0400
Received: from [210.76.114.20] ([210.76.114.20]:56720 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S263232AbVGAMuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:50:54 -0400
Message-ID: <42C53E7D.7090404@ccoss.com.cn>
Date: Fri, 01 Jul 2005 21:00:45 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: one question about pgd allocation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi LKML:

    I am reading kernel code about memory management.

    on i386 platform, the function pgd_alloc() alloc one page table 
directory,
every directory entry is one PMD address. that is OK.

pgd_t *pgd_alloc(struct mm_struct *mm)
{
    int i;
    pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);

    if (PTRS_PER_PMD == 1 || !pgd)
        return pgd;

    for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
        pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
        if (!pmd)
            goto out_oom;
        set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
    }
    return pgd;

out_oom:
    for (i--; i >= 0; i--)
        kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
    kmem_cache_free(pgd_cache, pgd);
    return NULL;
}

    My question is the statement:

        set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));

    why here is not :

        set_pgd(&pgd[i], __pgd(__pa(pmd)));

    I can not understand this. I search intel developer mannal. but 
nothing to help.
Who can tell me why?


    thank in advanced.

                                                          liyu
                                                                2005/7/1


