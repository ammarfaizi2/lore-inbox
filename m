Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWJJTPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWJJTPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWJJTPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:15:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbWJJTO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:14:57 -0400
Date: Tue, 10 Oct 2006 12:14:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hugepage regression
Message-Id: <20061010121447.4f8daf8f.akpm@osdl.org>
In-Reply-To: <000001c6ec92$871e5450$cb34030a@amr.corp.intel.com>
References: <20061010091552.GF18681@localhost.localdomain>
	<000001c6ec92$871e5450$cb34030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 10:35:50 -0700
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> David Gibson wrote on Tuesday, October 10, 2006 2:16 AM
> > > > It seems commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes a
> > > > hugepage regression.  A git bisect points the finger at that commit
> > > > for causing an oops in the 'alloc-instantiate-race' test from the
> > > > libhugetlbfs testsuite.
> > > > 
> > > > Still looking to determine the reason it breaks things.
> > > > 
> > > 
> > > It's assuming that unmap_hugepage_range() is always freeing these pages. 
> > > If the page is shared by another mapping, bad things will happen: the
> > > threads fight over page->lru.
> > > 
> > > Doing
> > > 
> > > +	if (page_count(page) == 1)
> > > 		list_add(&page->lru, &page_list);
> > > 
> > > might help.  But then we miss the tlb flush in rare racy conditions.
> > 
> > Well, there'd need to be an else doing a put_page(), too.
> > 
> > Looks like the fundamental problem is that a list is not a suitable
> > data structure for gathering here, since it's not truly local.  We
> > should probably change it to a small array, like in the normal tlb
> > gather structure.  If we run out of space we can force the tlb flush
> > and keep going.
> 
> 
> With the pending shared page table for hugetlb currently sitting in -mm,
> we serialize the all hugetlb unmap with a per file i_mmap_lock.  This
> race could well be solved by that pending patch?
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/shared-page-table-for-hugetlb-page-v
> 4.patch
> 

We need something for 2.6.19 though.  As David indicates, not using
page->lru should fix it (pagevec_add, pagevec_release would suit).

Or just a separate TBL invalidation per page.  Is that likely to be
particularly expensive?  It's the first one which hurts?

