Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbSJEC6C>; Fri, 4 Oct 2002 22:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJEC6C>; Fri, 4 Oct 2002 22:58:02 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:31440 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261968AbSJEC6B> convert rfc822-to-8bit; Fri, 4 Oct 2002 22:58:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20-pre8-aa2 oops report.
Date: Sat, 5 Oct 2002 13:09:45 +1000
User-Agent: KMail/1.4.3
References: <200210051247.14368.harisri@bigpond.com>
In-Reply-To: <200210051247.14368.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210051309.45092.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 October 2002 12:47, Srihari Vijayaraghavan wrote:
> [1.] One line summary of the problem:
> 	2.4.20-pre8aa2 Kernel oopsed couple of times.

A little more research reveals that the oops happens at the following function 
in mm/memory.c

/*
 * remove user pages in a given range.
 */
void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long 
size)
{
	mmu_gather_t *tlb;
	pgd_t * dir;
	unsigned long start = address, end = address + size;
	int freed = 0;

	dir = pgd_offset(mm, address);

	/*
	 * This is a long-lived spinlock. That's fine.
	 * There's no contention, because the page table
	 * lock only protects against kswapd anyway, and
	 * even if kswapd happened to be looking at this
	 * process we _want_ it to get stuck.
	 */
	if (address >= end)
		BUG();
	spin_lock(&mm->page_table_lock);
	flush_cache_range(mm, address, end);
	tlb = tlb_gather_mmu(mm);

	do {
		freed += zap_pmd_range(tlb, dir, address, end - address);
		address = (address + PGDIR_SIZE) & PGDIR_MASK;
		dir++;
	} while (address && (address < end));

	/* this will flush any remaining tlb entries */
	tlb_finish_mmu(tlb, start, end);

	/*
	 * Update rss for the mm_struct (not necessarily current->mm)
	 * Notice that rss is an unsigned long.
	 */
	if (mm->rss > freed)
		mm->rss -= freed;
	else
		mm->rss = 0;
	spin_unlock(&mm->page_table_lock);
}

BTW I ran memtest2.x and memtest3.0 overnight few times in the past and it 
always passed for more than 30 times or so everytime. I forgot to mention 
this in my previous e-mail.
-- 
Hari
harisri@bigpond.com

