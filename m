Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSAWGIe>; Wed, 23 Jan 2002 01:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289708AbSAWGIY>; Wed, 23 Jan 2002 01:08:24 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2543 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289702AbSAWGIH>;
	Wed, 23 Jan 2002 01:08:07 -0500
From: James Washer <e2big@us.ibm.com>
Message-Id: <200201230608.g0N685P09476@crg8.beaverton.ibm.com>
Subject: Question on current->local_pages and its usage
To: linux-kernel@vger.kernel.org
Date: Tue, 22 Jan 2002 22:08:05 -0800 (PST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing 2.4.17 __alloc_pages() and associated routines, I came across
something I don't understand ( no surprise ;-)

In __free_pages_ok(), if current->flags & PF_FREE_PAGES, the code adds the
pages being freed to current->local_pages using the following block of code:


 local_freelist:
        if (current->nr_local_pages)
                goto back_local_freelist;
        if (in_interrupt())
                goto back_local_freelist;

        list_add(&page->list, &current->local_pages);
        page->index = order;
        current->nr_local_pages++;


Unless I am misreading this, that first if statement in going to limit
us to at most one block of pages no matter how many times we call
__free_pages_ok()


However, in balance_classzone(), the code seems to expect that multiple 
blocks of pages may be 'cached' in local_pages.


     do {
		tmp = list_entry(entry, struct page, list);
		if (tmp->index == order && memclass(tmp->zone, classzone)) {
			list_del(entry);
			current->nr_local_pages--;
	...
	} while ((entry = entry->next) != local_pages);


So, am I misreading this.. or is one of these wrong? If I were to hazard a 
guess, __free_pages_ok() should be 'fixed'.

 - jim

-- 
James Washer
IBM Linux Change Team
