Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVBAPiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVBAPiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVBAPhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:37:41 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:47570 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262047AbVBAPhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:37:25 -0500
Message-ID: <41FFA21C.8060203@nortelnetworks.com>
Date: Tue, 01 Feb 2005 09:37:00 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com> <1107243398.4208.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1107243398.4208.47.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:

>>Is there any particular reason why modules should not be allowed to 
>>flush the tlb, or is this an oversight?
> 
> can you point at the url to your module source? I suspect modules doing
> tlb flushes is the wrong thing, but without seeing the source it's hard
> to tell.

I've included the relevent code at the bottom.  The module will be 
released under the GPL.

I've got a module that I'm porting forward from 2.4.  The basic idea is 
that we want to be able to track pages dirtied by an application.  The 
system has no swap, so we use the dirty bit to get this information.  On 
demand we walk the page tables belonging to the process, store the 
addresses of any dirty ones, flush the tlb, and mark them clean.

I (obviously) don't have a good understanding of how the tlb interacts 
with the software page tables.  If we don't need to flush the tlb I'd 
love to hear it.  If there's an easier way than walking the tables 
manually please let me know.

If it matters, some of the dirty pages may be code (it's used by an 
emulator for a system that can handle on-the-fly binary patching).

Thanks,

Chris







Note: this code is run while holding &mm->mmap_sem and &mm->page_table_lock.

	/* scan through the entire address space given */
	dirty_count = 0;
	for(addr=start&PAGE_MASK; addr<=end; addr+=PAGE_SIZE) {
		pgd_t *pgd;
		pmd_t *pmd;
		pte_t *ptep, pte;
		
		/* Page table walking code stolen from follow_page() except
		 * that this version does not support huge tlbs.
		 */
		pgd = pgd_offset(mm, addr);
		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
			continue;

		pmd = pmd_offset(pgd, addr);
		if (pmd_none(*pmd))
			continue;
		if (unlikely(pmd_bad(*pmd)))
			continue;

		ptep = pte_offset_map(pmd, addr);
		if (!ptep)
			continue;

		pte = *ptep;
		pte_unmap(ptep);
		if (!pte_present(pte))
			continue;

		if (!pte_dirty(pte))
			continue;

		if (!pte_read(pte))
			continue;

		/* We have a user readable dirty page.  Count it.*/
		dirty_count++;

		if (dirty_count > entries) {
			continue;
		} else {
			__put_user(addr, buf);
			buf++;
		}

		flush_tlb_page(find_vma(mm,addr), addr);
		pte = pte_mkclean(pte);
	}
