Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbTCKJxx>; Tue, 11 Mar 2003 04:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbTCKJxx>; Tue, 11 Mar 2003 04:53:53 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:25564 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262887AbTCKJxu>; Tue, 11 Mar 2003 04:53:50 -0500
Date: Tue, 11 Mar 2003 23:03:15 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Free pages leaking in 2.5.64?
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047376995.1692.23.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've come across the following problem in 2.5.64. Here's example output.
The header is one page - all messages only have a single call to
get_zeroed_page between the printings and the same code works as
expected (we have x pages reduces by one each time) under 2.4.21-pre4.

Regards,

Nigel

Mar 11 22:38:01 laptop-linux kernel: -- Creating pagedir1 and allocating extra pages (if any)
Mar 11 22:38:01 laptop-linux kernel:    At the start of create_suspend_pagedir, we have 26201 pages.
Mar 11 22:38:01 laptop-linux kernel:    After allocating header, we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 0 (at c7158000), we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 1 (at c70bc000), we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 2 (at c7344000), we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 3 (at c6b33000), we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 4 (at c747d000), we have 26195 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 5 (at c1320000), we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 6 (at c138e000), we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 7 (at c74eb000), we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After allocating pointer pages, we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    Created pagedir of 8 pages at c712f000 to store 1993 pages. 26189 free pages left.
Mar 11 22:38:01 laptop-linux kernel:    Check: 26189 + 1 + 8 + 0 = 26198  ***** DOESN'T MATCH ***** 

('Doesn't match' gets printed because if we start with 26201 pages and
allocate 9, we'd expect to see nr_free_pages() returning 26192, but as
you can see, it is returning 26189. Likewise below).


Mar 11 22:38:01 laptop-linux kernel: -- Creating pagedir2
Mar 11 22:38:01 laptop-linux kernel:    At the start of create_suspend_pagedir, we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After allocating header, we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 0 (at c13f1000), we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 1 (at c6d87000), we have 26189 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 2 (at c75ce000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 3 (at c6b79000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 4 (at c75d5000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 5 (at c6d6c000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 6 (at c7283000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 7 (at c13ed000), we have 26183 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 8 (at c70c5000), we have 26177 pages.
Mar 11 22:38:01 laptop-linux kernel:    After page 9 (at c730c000), we have 26177 pages.
Mar 11 22:38:01 laptop-linux kernel:    After allocating pointer pages, we have 26177 pages.
Mar 11 22:38:01 laptop-linux kernel:    Created pagedir of 10 pages at c70d9000 to store 2416 pages. 26177 free pages left.
Mar 11 22:38:01 laptop-linux kernel:    Check: 26177 + 1 + 10 + 0 = 26188  ***** DOESN'T MATCH ***** 
Mar 11 22:38:01 laptop-linux kernel: -- Calling count_data_pages to set pageset addresses.
Mar 11 22:38:01 laptop-linux kernel:    At the start of count_data_pages, we have 26177 pages.
Mar 11 22:38:01 laptop-linux kernel: Zone      DMA Zone   Normal 
Mar 11 22:38:01 laptop-linux kernel: Results: 1997 and 2416(2416 low). 2 marked Nosave
Mar 11 22:38:01 laptop-linux kernel: 
Mar 11 22:38:01 laptop-linux kernel: 4 more pages to be copied than were allowed for! Pagedir1 capacity is 1993

Code:

static int create_suspend_pagedir(struct pagedir * p, int pageset_size, int alloc_from)
{
	int pagedir_size = calcpagedirsize(pageset_size);
	int startfree = nr_free_pages(), endfree;

	if (!pageset_size) {
		p->pagedir_size = 0;
		p->pageset_size = 0;
		p->alloc_from = 0;
		PRINTK(SUSPEND_VERBOSE, "   No need to allocate anything for this pagedir.\n");
		return 0;
	}

	PRINTK(SUSPEND_VERBOSE, "   At the start of create_suspend_pagedir, we have %d pages.\n", nr_free_pages());

	p->data = (struct pbe **)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
	//PRINTK(SUSPEND_VERBOSE,"   Allocated pagedir header at %p.\n", p->data);
	
	if (!p->data) {
		abort_suspend("Failed to allocate a pagedir!\n");
		return 1;
	}
	
	PRINTK(SUSPEND_VERBOSE, "   After allocating header, we have %d pages.\n", nr_free_pages());

	/* Ensure saved in pageset 1 */
	ClearPageNosave(virt_to_page(p->data));
	ClearPageDontcopy(virt_to_page(p->data));

	{
		int i;
		for (i = 0; i < pagedir_size; i++) {
			p->data[i] = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
			//PRINTK(SUSPEND_VERBOSE,"   Allocated pagedir page %d at %p\r", i, p->data[i]);
			PRINTK(SUSPEND_VERBOSE, "   After page %d (at %lx), we have %d pages.\n", 
					i,
					p->data[i],
					nr_free_pages());
			if (!p->data[i]) {
				int j;
				for (j = 0; j < i; j++)
					free_page((unsigned long) p->data[j]);
				free_page((unsigned long) p->data);
				abort_suspend("Unable to allocate a pagedir.\n");
				spin_unlock_irq(&suspend_pagedir_lock);
				return 1;
			}
			ClearPageNosave(virt_to_page(p->data[i]));
			ClearPageDontcopy(virt_to_page(p->data[i]));
		}
	}
	
	PRINTK(SUSPEND_VERBOSE, "   After allocating pointer pages, we have %d pages.\n", nr_free_pages());

	{
		int i;
		
		for(i=0; i < pageset_size; i++) {
			PAGEDIR_ENTRY(p,i)->origaddress = 0;
			PAGEDIR_ENTRY(p,i)->address = 0;
			PAGEDIR_ENTRY(p,i)->swap_address.val = 0;
			//PRINTK(SUSPEND_VERBOSE,"   Clearing pagedir: %d.\r", i);
		}
		//PRINTK(SUSPEND_VERBOSE," \n");
	}
	
	//PRINTK(SUSPEND_VERBOSE,"   Allocating pages...\n");
	{
		int i, numnosaveallocated=0;
	
		for(i=alloc_from; i < pageset_size; i++) {
			PAGEDIR_ENTRY(p,i)->address = virt_to_page(get_zeroed_page(GFP_ATOMIC | __GFP_COLD));
			//PRINTK(SUSPEND_VERBOSE,"   Set pagedir entry %d to %lx.\r", i, PAGEDIR_ENTRY(p, i)->address);
			if (!PAGEDIR_ENTRY(p,i)->address) {
				abort_suspend("Unable to allocate pages for pagedir!\n");
				return 1;
			}
			SetPageNosave(PAGEDIR_ENTRY(p,i)->address);
			numnosaveallocated++;
		}
		if (pageset_size > alloc_from) {
			PRINTK(SUSPEND_VERBOSE,"   Allocated memory for pages from %d-%d.\n", alloc_from, pageset_size - 1);
		}
	}

	p->pagedir_size = calcpagedirsize(pageset_size);
	p->pageset_size = pageset_size;
	p->alloc_from = alloc_from;
	endfree = nr_free_pages();

	PRINTK(SUSPEND_VERBOSE,"   Created pagedir of %d pages at %p to store %d pages. %d free pages left.\n",
			p->pagedir_size,
			p->data,
			p->pageset_size,
			endfree);
	
	PRINTK(SUSPEND_VERBOSE,"   Check: %d + 1 + %d + %d = %d %s\n",
			endfree, pagedir_size, pageset_size - alloc_from, 
			endfree + pagedir_size + pageset_size - alloc_from + 1,
			(endfree + pagedir_size + pageset_size - alloc_from + 1 == startfree) ?
			"Ok" :
			" ***** DOESN'T MATCH ***** ");

	return 0;
}



