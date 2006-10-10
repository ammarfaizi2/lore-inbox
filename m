Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWJJJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWJJJQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWJJJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:16:10 -0400
Received: from ozlabs.org ([203.10.76.45]:52430 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965121AbWJJJQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:16:06 -0400
Date: Tue, 10 Oct 2006 19:15:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "Kenneth W. Chen" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hugepage regression
Message-ID: <20061010091552.GF18681@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	"Kenneth W. Chen" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
References: <20061010084748.GE18681@localhost.localdomain> <20061010020426.4d597be2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010020426.4d597be2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:04:26AM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 18:47:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > It seems commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes a
> > hugepage regression.  A git bisect points the finger at that commit
> > for causing an oops in the 'alloc-instantiate-race' test from the
> > libhugetlbfs testsuite.
> > 
> > Still looking to determine the reason it breaks things.
> > 
> 
> It's assuming that unmap_hugepage_range() is always freeing these pages. 
> If the page is shared by another mapping, bad things will happen: the
> threads fight over page->lru.
> 
> Doing
> 
> +	if (page_count(page) == 1)
> 		list_add(&page->lru, &page_list);
> 
> might help.  But then we miss the tlb flush in rare racy conditions.

Well, there'd need to be an else doing a put_page(), too.

Looks like the fundamental problem is that a list is not a suitable
data structure for gathering here, since it's not truly local.  We
should probably change it to a small array, like in the normal tlb
gather structure.  If we run out of space we can force the tlb flush
and keep going.

Or we could just give up on lazy tlb flush for hugepages.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
