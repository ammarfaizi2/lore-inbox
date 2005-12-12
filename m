Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVLLA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVLLA1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVLLA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:27:18 -0500
Received: from ozlabs.org ([203.10.76.45]:13443 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750937AbVLLA1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:27:17 -0500
Date: Mon, 12 Dec 2005 11:26:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       William Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PageCompound avoid page[1].mapping
Message-ID: <20051212002656.GB18791@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	William Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:56:42PM +0000, Hugh Dickins wrote:
> If a compound page has its own put_page_testzero destructor (the only
> current example is free_huge_page), that is noted in page[1].mapping of
> the compound page.  But David Gibson's recent fix to access_process_vm
> shows that to be rather a poor place to keep it: functions which call
> set_page_dirty(_lock) after get_user_pages ought to check !PageCompound
> first, otherwise set_page_dirty may crash on what's not the address of
> a struct address_space; but Infiniband for one is unaware of this issue.
> 
> Even if we fixed all callers, or set_page_dirty(_lock) itself, it would
> still be unsatisfactory: e.g. get_user_pages calls flush_dcache_page,
> which involves page->mapping on some architectures - not a problem while
> hugetlb goes its own way in get_user_pages, but needs a test if another
> compound page destructor were added.  page->mapping is used too widely
> to be a safe field to reuse in this way.
> 
> The safest field to reuse, given how PageCompound redirects callers to
> the page count of the first page, is actually the _count field of the
> second page: save order (only used for debug) there, and move destructor
> address from mapping to index.  Add __page_count inline for internal
> debug use - to avoid reliance on page_private when page is in doubt.

It's not clear to me this is a good way to go.  It will make things
work neatly in the case where the correct action on a compound page is
to do nothing (and we already have a mapping == NULL test).  However
it will fail silently in cases where we actually need to get at the
mapping for a compound page (so we need to check for CompoundPage and
find the master page).  The existing code will probably blow up in
that case, at least showing there's a problem.

> Revert David's mod to access_process_vm, no longer required.  But leave
> the PageCompound tests in fs/bio.c and fs/direct-io.c: perhaps those are
> worthwhile optimizations when working on hugetlb areas.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
