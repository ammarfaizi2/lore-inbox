Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWBUXrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWBUXrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBUXrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:47:10 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:44701 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932342AbWBUXrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:47:09 -0500
Date: Wed, 22 Feb 2006 10:46:34 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
Message-ID: <20060221234634.GC20872@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <20060221022124.GA18535@localhost.localdomain> <1140549936.8693.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140549936.8693.41.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 11:25:36AM -0800, Dave Hansen wrote:
> On Tue, 2006-02-21 at 13:21 +1100, David Gibson wrote:
> > The patch below is a draft attempt to address this problem, by
> > strictly reserving a number of physical hugepages for hugepages inodes
> > which have been mapped, but not instatiated.  MAP_SHARED mappings are
> > thus "safe" - they will fail on mmap(), not later with a SIGBUS.
> > MAP_PRIVATE mappings can still SIGBUS.
> ...
> > +	read_lock_irq(&inode->i_mapping->tree_lock);
> > +	for (pg = inode->i_blocks; pg < npages; pg++) {
> > +		page = radix_tree_lookup(&mapping->page_tree, pg);
> > +		if (! page)
> > +			change_in_reserve++;
> > +	}
> > +
> > +	for (pg = npages; pg < inode->i_blocks; pg++) {
> > +		page = radix_tree_lookup(&mapping->page_tree, pg);
> > +		if (! page)
> > +			change_in_reserve--;
> > +	}
> > +	spin_lock(&hugetlb_lock);
> 
> I'm a bit confused by this.  The for loops goes through and looks for
> pages that have indexes greater than the current i_blocks, but less than
> the number of pages requested by this reservation.  With demand
> faulting, can there be holes in the file?  Will this code account for
> them?

There can be holes in terms of which pages are instantiated, and in
terms of what's mapped but with this patch we always reserve space
from the beginning of the file.  This is a simplifying assumption, so
that i_blocks alone can store sufficient information about what pages
are pre-reserved.  Otherwise we'd either need individual information
about the reservation status of each page - and there's no obvious
place to store it, or we'd have to deduce it in multiple places by
working through each vma which might map the page.  Andy Whitcroft's
old hugepage strict reservation patch used the latter approach, I
invented this i_blocks method because it seems to be simpler.

> I think this would also be a bit more clear if the two for loops were a
> bit more explicit in what they are doing.  The first is growing the
> reservation when "npages > inode->i_blocks" and the second is shrinking
> the reservation when "npages < inode->i_blocks", right?  Is this
> completely clear from the code? ;)

Ok, I'll add some more explanation here.

> Also, since the operation you are performing is actually counting pages
> in the radix tree at certain indexes, would it be sane to have a patch
> such as the (completely untested) attached one to do just that, but in
> the radix code?

Given that the patch below seems to introduce more code that the
above, but scattered across several places, and the hugepage
accounting code would be its only user, I don't see the point.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
