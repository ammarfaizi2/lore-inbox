Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbULJE3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbULJE3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULJE3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:29:14 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:65200 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261697AbULJE24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:28:56 -0500
Message-ID: <41B92567.8070809@yahoo.com.au>
Date: Fri, 10 Dec 2004 15:26:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 1 Dec 2004, Christoph Lameter wrote:
> 
>>Changes from V11->V12 of this patch:
>>- dump sloppy_rss in favor of list_rss (Linus' proposal)
>>- keep up against current Linus tree (patch is based on 2.6.10-rc2-bk14)
>>
>>This is a series of patches that increases the scalability of
>>the page fault handler for SMP. Here are some performance results
>>on a machine with 512 processors allocating 32 GB with an increasing
>>number of threads (that are assigned a processor each).
> 
> 
> Your V12 patches would apply well to 2.6.10-rc3, except that (as noted
> before) your mailer or whatever is eating trailing whitespace: trivial
> patch attached to apply before yours, removing that whitespace so yours
> apply.  But what your patches need to apply to would be 2.6.10-mm.
> 
> Your i386 HIGHMEM64G 3level ptep_cmpxchg forgets to use cmpxchg8b, would
> have tested out okay up to 4GB but not above: trivial patch attached.
> 

That looks obviously correct. Probably the reason why Martin was
getting crashes.

[snip]

> Moving to the main patch, 1/7, the major issue I see there is the way
> do_anonymous_page does update_mmu_cache after setting the pte, without
> any page_table_lock to bracket them together.  Obviously no problem on
> architectures where update_mmu_cache is a no-op!  But although there's
> been plenty of discussion, particularly with Ben and Nick, I've not
> noticed anything to guarantee that as safe on all architectures.  I do
> think it's fine for you to post your patches before completing hooks in
> all the arches, but isn't this a significant issue which needs to be
> sorted before your patches go into -mm?  You hazily refer to such issues
> in 0/7, but now you need to work with arch maintainers to settle them
> and show the patches.
> 

Yep, the update_mmu_cache issue is real. There is a parallel problem
that is update_mmu_cache can be called on a pte who's page has since
been evicted and reused. Again, that looks safe on IA64, but maybe
not on other architectures.

It can be solved by moving lru_cache_add to after update_mmu_cache in
all cases but the "update accessed bit" type fault. I solved that by
simply defining that out for architectures that don't need it - a raced
fault will simply get repeated if need be.

> A lesser issue with the reordering in do_anonymous_page: don't you need
> to move the lru_cache_add_active after the page_add_anon_rmap, to avoid
> the very slight chance that vmscan will pick the page off the LRU and
> unmap it before you've counted it in, hitting page_remove_rmap's
> BUG_ON(page_mapcount(page) < 0)?
> 

That's what I had been doing too. Seems to be the right way to go.

> (I do wonder why do_anonymous_page calls mark_page_accessed as well as
> lru_cache_add_active.  The other instances of lru_cache_add_active for
> an anonymous page don't mark_page_accessed i.e. SetPageReferenced too,
> why here?  But that's nothing new with your patch, and although you've
> reordered the calls, the final page state is the same as before.)
> 
> Where handle_pte_fault does "entry = *pte" without page_table_lock:
> you're quite right to passing down precisely that entry to the fault
> handlers below, but there's still a problem on the 32bit architectures
> supporting 64bit ptes (i386, mips, ppc), that the upper and lower ints
> of entry may be out of synch.  Not a problem for do_anonymous_page, or
> anything else relying on ptep_cmpxchg to check; but a problem for
> do_wp_page (which could find !pfn_valid and kill the process) and
> probably others (harder to think through).  Your 4/7 patch for i386 has
> an unused atomic get_64bit function from Nick, I think you'll have to
> define a get_pte_atomic macro and use get_64bit in its 64-on-32 cases.
> 

Indeed. This was a real problem for my patch, definitely.

> Hmm, that will only work if you're using atomic set_64bit rather than
> relying on page_table_lock in the complementary places which matter.
> Which I believe you are indeed doing in your 3level set_pte.  Shouldn't
> __set_64bit be using LOCK_PREFIX like __get_64bit, instead of lock?
> 

That's what I was wondering. It could be that the actual 64-bit store is
still atomic without the lock prefix (just not the entire rmw), which I
think would be sufficient.

In that case, get_64bit may be able to drop the lock prefix as well.
