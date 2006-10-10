Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWJJRfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWJJRfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWJJRfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:35:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:63511 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751018AbWJJRfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:35:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144245477:sNHT23460563"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Hugepage regression
Date: Tue, 10 Oct 2006 10:35:50 -0700
Message-ID: <000001c6ec92$871e5450$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbsTLYvYoVO2YrMTYq7JdTAQAnksgARVAzQ
In-Reply-To: <20061010091552.GF18681@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, October 10, 2006 2:16 AM
> > > It seems commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes a
> > > hugepage regression.  A git bisect points the finger at that commit
> > > for causing an oops in the 'alloc-instantiate-race' test from the
> > > libhugetlbfs testsuite.
> > > 
> > > Still looking to determine the reason it breaks things.
> > > 
> > 
> > It's assuming that unmap_hugepage_range() is always freeing these pages. 
> > If the page is shared by another mapping, bad things will happen: the
> > threads fight over page->lru.
> > 
> > Doing
> > 
> > +	if (page_count(page) == 1)
> > 		list_add(&page->lru, &page_list);
> > 
> > might help.  But then we miss the tlb flush in rare racy conditions.
> 
> Well, there'd need to be an else doing a put_page(), too.
> 
> Looks like the fundamental problem is that a list is not a suitable
> data structure for gathering here, since it's not truly local.  We
> should probably change it to a small array, like in the normal tlb
> gather structure.  If we run out of space we can force the tlb flush
> and keep going.


With the pending shared page table for hugetlb currently sitting in -mm,
we serialize the all hugetlb unmap with a per file i_mmap_lock.  This
race could well be solved by that pending patch?

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/shared-page-table-for-hugetlb-page-v
4.patch

- Ken
