Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTAHWgN>; Wed, 8 Jan 2003 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267946AbTAHWgN>; Wed, 8 Jan 2003 17:36:13 -0500
Received: from holomorphy.com ([66.224.33.161]:20877 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267938AbTAHWgJ>;
	Wed, 8 Jan 2003 17:36:09 -0500
Date: Wed, 8 Jan 2003 14:44:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH] allow bigger PAGE_OFFSET with PAE
Message-ID: <20030108224445.GE23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E1B334E.8030807@us.ibm.com> <20030107233713.GB23814@holomorphy.com> <3E1C9257.2040907@us.ibm.com> <20030108220533.GD23814@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108220533.GD23814@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 12:06:38PM -0800, Dave Hansen wrote:
>>>> Also, this gets the kernel's pagetables right, but neglects 
>>>> userspace's for now.  pgd_alloc() needs to be fixed to allocate 
>>>> another PMD, if the split isn't PMD-alighed.

William Lee Irwin III wrote:
>>> Um, that should be automatic when USER_PTRS_PER_PGD is increased.

On Wed, Jan 08, 2003 at 01:04:23PM -0800, Dave Hansen wrote:
>> Nope, you need a little bit more.  pgd_alloc() relies on its memcpy() 
>> to provide the kernel mappings.  After the last user PMD is allocated, 
>> you still need to copy the kernel-shared part of it in.

On Wed, Jan 08, 2003 at 02:05:33PM -0800, William Lee Irwin III wrote:
> See the bit about rounding up. Then again, the pmd entries don't get
> filled in by any of that...

Okay, basically:

#define __USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
#define PARTIAL_PGD	(TASK_SIZE > __USER_PTRS_PER_PGD*PGDIR_SIZE ? 1 : 0)
#define PARTIAL_PMD	((TASK_SIZE % PGDIR_SIZE)/PMD_SIZE)
#define USER_PTRS_PER_PGD	(PARTIAL_PGD + __USER_PTRS_PER_PGD)

then


pgd_t *pgd_alloc(struct mm_struct *mm)
{
	int i;
	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);

	if (pgd) {
		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
			unsigned long pmd = __get_free_page(GFP_KERNEL);
			if (!pmd)
				goto out_oom;
			clear_page(pmd);
			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
		}

		if (USER_PTRS_PER_PGD < PTRS_PER_PGD)
			memcpy(pgd + USER_PTRS_PER_PGD,
				swapper_pg_dir + USER_PTRS_PER_PGD,
				(PTRS_PER_PGD-USER_PTRS_PER_PGD)*sizeof(pgd_t));

		if (PARTIAL_PGD) {
			pgd_t *kpgd, *upgd;
			pmd_t *kpmd, *upmd;

			kpgd = pgd_offset_k(TASK_SIZE);
			upgd = pgd_offset(mm, TASK_SIZE);
			kpmd = pmd_offset(kpgd, TASK_SIZE);
			upmd = pmd_offset(upgd, TASK_SIZE);

			memcpy(upmd, kpmd, (PTRS_PER_PMD-PARTIAL_PMD)*sizeof(pmd_t));

		}
	}
	return pgd;
out_oom:
	for (i--; i >= 0; i--)
		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
	kmem_cache_free(pae_pgd_cachep, pgd);
	return NULL;
}

etc.
