Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUDPEOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUDPEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:14:25 -0400
Received: from fmr04.intel.com ([143.183.121.6]:38598 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262119AbUDPEOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:14:21 -0400
Message-Id: <200404160413.i3G4DcF13729@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [2/3]
Date: Thu, 15 Apr 2004 21:13:38 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjY+tTs7rQMCHIR5ebddNRyYZy+QAAXTSA
In-Reply-To: <20040416032725.GG12735@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, April 15, 2004 8:27 PM
> Ah!  So it's just an optimiziation - it makes a bit more sense to me
> now.  I had assumed that this case (hugepage get_user_pages()) would
> be sufficiently rare that it would not require optimization.
> Apparently not.

It's a huge deal because for *every* I/O, kernel has to do get_user_pages()
to lock the page, it's really gets in the way with the spin_lock as well.

        spin_lock(&mm->page_table_lock);
        do {
                struct page *map;
                int lookup_write = write;
                while (!(map = follow_page(mm, start, lookup_write))) {

With current state of art platform, I/O requirement pushes into 200K
per second, this become quite significant.


> Do you know where the cycles are going without this optimization?  In
> particular, could it be just the find_vma() in hugepage_vma() called
> before follow_huge_addr()?  I note that IA64 is the only arch to have
> a non-trivial hugepage_vma()/follow_huge_addr() and that its
> follow_huge_addr() doesn't actually use the vma passed in.

That's one, plus the spin lock mentioned above.


> If we could get rid of follow_hugetlb_pages() it would remove an ugly
> function from every arch, which would be nice.

I hope the goal here is not to trim code for existing prefaulting scheme.
That function has to go for demand paging, and demand paging comes with
a performance price most people don't realize.  If the goal here is to
make the code prettier, I vote against that.


