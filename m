Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUCMQNw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 11:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUCMQNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 11:13:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:37297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263127AbUCMQL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 11:11:56 -0500
Date: Sat, 13 Mar 2004 08:18:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403130942200.15971-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0403130759150.1045@ppc970.osdl.org>
References: <Pine.LNX.4.44.0403130942200.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, guys,
 how about this anon-page suggestion?

I'm a bit nervous about the complexity issues in Andrea's current setup, 
so I've been thinking about Rik's per-mm thing. And I think that there is 
one very simple approach, which should work fine, and should have minimal 
impact on the existing setup exactly because it is so simple.

Basic setup:
 - each anonymous page is associated with exactly _one_ virtual address, 
   in a "anon memory group". 

   We put the virtual address (shifted down by PAGE_SHIFT) into 
   "page->index". We put the "anon memory group" pointer into 
   "page->mapping". We have a PAGE_ANONYMOUS flag to tell the
   rest of the world about this.

 - the anon memory group has a list of all mm's that it is associated 
   with.

 - an "execve()" creates a new "anon memory group" and drops the old one.

 - a mm copy operation just increments the reference count and adds the 
   new mm to the mm list for that anon memory group.

So now to do reverse mapping, we can take a page, and do

	if (PageAnonymous(page)) {
		struct anongroup *mmlist = (struct anongroup *)page->mapping;
		unsigned long address = page->index << PAGE_SHIFT;
		struct mm_struct *mm;

		for_each_entry(mm, mmlist->anon_mms, anon_mm) {
			.. look up page in page tables in "mm, address" ..
			.. most of the time we may not even need to look ..
			.. up the "vma" at all, just walk the page tables ..
		}
	} else {
		/* Shared page */
		.. look up page using the inode vma list ..
	}

The above all works 99% of the time.

The only problem is mremap() after a fork(), and hell, we know that's a
special case anyway, and let's just add a few lines to copy_one_pte(),
which basically does:

	if (PageAnonymous(page) && page->count > 1) {
		newpage = alloc_page();
		copy_page(page, newpage);
		page = newpage;
	}
	/* Move the page to the new address */
	page->index = address >> PAGE_SHIFT;

and now we have zero special cases.

The above should work very well. In most cases the "anongroup" will be 
very small, and even when it's large (if somebody does a ton of forks 
without any execve's), we only have _one_ address to check, and that is 
pretty fast. A high-performance server would use threads, anyway. (And 
quite frankly, _any_ algorithm will have this issue. Even rmap will have 
exactly the same loop, although rmap skips any vm's where the page might 
have been COW'ed or removed).

The extra COW in mremap() seems benign. Again, it should usually not even 
trigger.

What do you think? To me, this seems to be a really simple approach..

		Linus
