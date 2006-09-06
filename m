Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWIFKtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIFKtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWIFKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:49:51 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51719 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750770AbWIFKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:49:49 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157480873.3186.57.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
	 <1157132520.21733.78.camel@localhost>
	 <1157133780.18728.6.camel@localhost.localdomain>
	 <1157133841.21733.79.camel@localhost>
	 <1157135024.18728.19.camel@localhost.localdomain>
	 <1157135504.21733.83.camel@localhost>
	 <1157136106.18728.27.camel@localhost.localdomain>
	 <1157368883.5078.24.camel@localhost>
	 <1157480873.3186.57.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 06 Sep 2006 12:49:47 +0200
Message-Id: <1157539787.9582.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 11:27 -0700, Dave Hansen wrote:
> On Mon, 2006-09-04 at 13:21 +0200, Martin Schwidefsky wrote:
> > Any kind of locking won't work. You need the information that a page has
> > been discarded until the page has been freed. Only then the fact that
> > the page has been discarded may enter nirvana. Any kind of lock needs to
> > be freed again to allow the next discard fault to happen. Since you
> > don't when the last page reference is returned you cannot hold the lock
> > until the page is free.
> 
> First of all, you *CAN* sleep with the BKL held. ;)

You can call schedule with the BKL held. But schedule will release the
BKL before the process is put to sleep. To use a lock as mechanism to
prevent double frees of discarded pages you'd have to hold it while
sleeping.

> Why doesn't the normal lock_page() help?  It can sleep, too?

The PG_locked bit which is behind lock_page() is used for a different
purpose. Look at the way how e.g. find_lock_page works: the radix tree
lookup is made, a reference is acquired with page_cache_get() and then
__lock_page() is called. For the discard double page free prevention we
need to lock the page, then wait for all referenced to be returned. Only
then can we unlock the page again. These two uses are mutual exclusive.

> As far as simplifying the patches, I feel like some of the
> page_make_stable() stuff should be done inside of page_cache_get().
> Perhaps the API needs to be changed so that page_cache_get()s can fail.

Uhh, that is even more invasive than the things we do now.
page_cache_get() alias get_page() is just concerned about reference
counting. You definitly do not want to do state changes in
get_page/put_page. That would increase the number state changes by an
order of magnitude.

> There are also a ton of "mapping == page->mapping" tests all over.
> Perhaps you need a page_still_in_mapping(page, mapping) call that also
> checks the page's discard state.

Where does this help? All places that have "mapping == page->mapping"
either don't care about the page state or work on stable pages.

> I also have the feeling that every single page_host_discards() check
> which is actually placed in the VM code shouldn't be there.  The ones in
> page_make_stable() and friends are OK, but the ones in
> shrink_inactive_list() seem bogus to me.  Looks like they should be
> covered up in some _other_ function that checks PageDiscarded().

Hmm, we can reduce the number of page_host_discards() checks in the VM
code if PageDiscarded() and friends are defined conditionally on
CONFIG_PAGE_STATES. I'm not sure if all calls to page_host_discards()
can be removed but I will take a look at it. It would be a real
improvement to get rid of most of these calls.

> You could even put these things in (what are now) simple functions like
> lru_to_page().  The logic would be along the lines of, whenever I am
> looking into the LRU, I need to make sure this page is still actually
> there.

It would make the code simpler but the cost would be additional state
changes. For example whenever you free a page you would do a state
transition from volatile to stable shortly followed by a state
transition from stable to unused. These states changes have a cost that
we want to avoid.

> As for the locking, imagine a seqlock (per-zone, node, section, hash,
> anon_vma, mapping, whatever...).  A write is taken any time that
> PG_discard would have been set, and the page is placed in to a list so
> that it can be found (the data structure isn't important now).  All of
> the places that currently check PG_discard would go and take a read on
> the seqlock.  If they fail to acquire it (what is normally now a loop),
> they would go look in the list to see if the page they are interested in
> is there.  If it is, then they treat it as dicarded, otherwise they
> proceed normally.  So, the operation is normally very cheap (a
> non-atomic read).  It is very expensive _during_ a discard because of
> the traversal of the list, but these should be rare.
> 
> The structure storing the page could be like this:
> 
> struct page_list {
> 	struct list_head list;
> 	struct page *page;
> };
> 
> So that it doesn't require any extra space in the struct page, and
> limits the overhead to only the people actually using the page discard
> mechanism.

I'm a little confused about this suggestion. If I understood it
correctly you want to block a number of pages and use a seqlock per
block to indicate if there is a discarded page in that block of pages.
On discard you do write_seqlock and force the read_seqlock side if the
lock could to be acquired to traverse a list before they can conclude
that a page is not discarded. 
First question: where are the list_heads stored that are used to put
pages on the special list? They have to be allocated somewhere, per
discarded page. I do not think that you can do it lazy, that is after a
discard fault happened. You have to preallocate them and then you are
spending 16 byte per discardable page instead of 1 bit.
Second question: how do you deal with multiple discards for a block of
pages? The first sets the write_seqlock, how is the write_sequnlock
done? After a discarded page has been freed you need to check if there
is another discarded page in the block, or if a discard is in progress.
This sounds racy.

I do not think that the locking with a seqlock will work. But please
keep throwing ideas at me. The point about page_host_discards is valid.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


