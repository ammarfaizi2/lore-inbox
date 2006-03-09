Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWCIMzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCIMzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCIMzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:55:21 -0500
Received: from ozlabs.org ([203.10.76.45]:53447 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751215AbWCIMzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:55:20 -0500
Date: Thu, 9 Mar 2006 23:54:41 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: wli@holomorphy.com, "'Andrew Morton'" <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hugetlb strict commit accounting
Message-ID: <20060309125441.GE9479@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, wli@holomorphy.com,
	'Andrew Morton' <akpm@osdl.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20060309120631.GC9479@localhost.localdomain> <200603091231.k29CV9g20079@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603091231.k29CV9g20079@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:31:11AM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, March 09, 2006 4:07 AM
> > > Well, the reservation is already done at mmap time for shared mapping. Why
> > > does kernel need to do anything at fault time?  Doing it at fault time is
> > > an indication of weakness (or brokenness) - you already promised at mmap
> > > time that there will be a page available for faulting.  Why check them
> > > again at fault time?
> > 
> > You can't know (or bound) at mmap() time how many pages a PRIVATE
> > mapping will take (because of fork()).  So unless you have a test at
> > fault time (essentialy deciding whether to draw from "reserved" and
> > "unreserved" hugepage pool) a supposedly reserved SHARED mapping will
> > OOM later if there have been enough COW faults to use up all the
> > hugepages before it's instantiated.
> 
> I see. But that is easy to fix.  I just need to do exactly the same
> thing as what you did to alloc_huge_page.  I will then need to change
> definition of 'reservation' to needs-in-the future (also an easy thing
> to change).

Well.. except that then you *do* need to traverse the page cache on
truncate(), just like I do.  Note that in my latest revision,
hugetlb_extend_reservation() no longer walks the radix tree, only
hugetlb_truncate_reservation() does (extend *does* still take the
tree_lock, an oversight which I will send a patch for tomorrow).

(Oh, and you'll need to walk the reserved range list in
alloc_huge_page(), rather than one comparison like I have.  Although
in practice I imagine there will never be more than one entry on the
list, so I guess that doesn't really matter)

> The real question or discussion I want to bring up is whether kernel
> should do it's own accounting or relying on traversing the page cache. 
> My opinion is that kernel should do it's own accounting because it is
> simpler: you just need to do that at mmap and ftruncate time.

And as we've seen above, a little bit at fault time.  Which would be
exactly the same three places that my patch adds accounting.  I'm
quite willing to be convinced your patch is the better approach, but
this isn't an argument for it.


Incidentally, I've just realised that removing the dodgy heuristic and
allowing unconstrained overcommit for PRIVATE mappings (which both our
patches do) is potentially problematic.  In particular it means my
hugepage malloc() implementation will always OOM rather than fallback
to normal pages :( (I believe currently it will usually fall back, and
only OOM if you get unlucky with the timing).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
