Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWCIMKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWCIMKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWCIMKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:10:12 -0500
Received: from ozlabs.org ([203.10.76.45]:42949 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932166AbWCIMKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:10:10 -0500
Date: Thu, 9 Mar 2006 23:06:31 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: wli@holomorphy.com, "'Andrew Morton'" <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hugetlb strict commit accounting
Message-ID: <20060309120631.GC9479@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, wli@holomorphy.com,
	'Andrew Morton' <akpm@osdl.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20060309112635.GB9479@localhost.localdomain> <200603091143.k29BhAg19160@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603091143.k29BhAg19160@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:43:12AM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, March 09, 2006 3:27 AM
> > Um... as far as I can tell, this patch doesn't actually reserve
> > anything.  There are no changes to the fault handler ot
> > alloc_huge_page(), so there's nothing to stop PRIVATE mappings dipping
> > into the supposedly reserved pool.
> 
> Well, the reservation is already done at mmap time for shared mapping. Why
> does kernel need to do anything at fault time?  Doing it at fault time is
> an indication of weakness (or brokenness) - you already promised at mmap
> time that there will be a page available for faulting.  Why check them
> again at fault time?

You can't know (or bound) at mmap() time how many pages a PRIVATE
mapping will take (because of fork()).  So unless you have a test at
fault time (essentialy deciding whether to draw from "reserved" and
"unreserved" hugepage pool) a supposedly reserved SHARED mapping will
OOM later if there have been enough COW faults to use up all the
hugepages before it's instantiated.

> I don't think your implementation handles PRIVATE mapping either, Isn't it?
> Private mapping doesn't enter into the page cache hanging of address_space
> pointer, so either way, it is busted.

Depends what you mean by "handle".  With my patch PRIVATE mappings are
never reserved or guaranteed (I couldn't think of any set of sane
semantics for it), *but* they will never eat into the pool reserved
for SHARED mappings.  With yours, they can, so:
	p = mmap(SHARED)
	/* Lots of COW faults elsewhere */
	*p = x;
Will result in an OOM Kill on the last line.

> > This looks a bit like a case of "let's make it an atomic_t to sprinkle
> > it with magic atomicity dust" without thinking about what operations
> > are and need to be atomic.  I think resv_huge_pages should be an
> > ordinary int, but protected by a lock (exactly which lock is not
> > immediately obvious).
> 
> Yeah, I agree.  It crossed my mind whether I should fix that or post a
> fairly straightforward back port.  I decided to do the latter and I got
> bitten :-(  That is in the pipeline if people agree that this variable
> reservation system is a better one.
> 
> 
> > What is the list of regions (mapping->private_list) protected by?
> > mmap_sem (the only thing I can think of off hand that's already taken)
> > doesn't cut it, because the mapping can be accessed by multiple mms.
> 
> I think it is the inode->i_mutex.

Ok, you should double check that's taken in all the right places, but
it sounds plausible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
