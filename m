Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUDPEvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUDPEvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:51:21 -0400
Received: from ozlabs.org ([203.10.76.45]:17305 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262176AbUDPEvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:51:12 -0400
Date: Fri, 16 Apr 2004 14:49:17 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [2/3]
Message-ID: <20040416044917.GB26707@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <20040416032725.GG12735@zax> <200404160413.i3G4DcF13729@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160413.i3G4DcF13729@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 09:13:38PM -0700, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, April 15, 2004 8:27 PM
> > Ah!  So it's just an optimiziation - it makes a bit more sense to me
> > now.  I had assumed that this case (hugepage get_user_pages()) would
> > be sufficiently rare that it would not require optimization.
> > Apparently not.
> 
> It's a huge deal because for *every* I/O, kernel has to do get_user_pages()
> to lock the page, it's really gets in the way with the spin_lock as well.
> 
>         spin_lock(&mm->page_table_lock);
>         do {
>                 struct page *map;
>                 int lookup_write = write;
>                 while (!(map = follow_page(mm, start, lookup_write))) {
> 
> With current state of art platform, I/O requirement pushes into 200K
> per second, this become quite significant.

Ok.  This makes sense now that you explain it.

> > Do you know where the cycles are going without this optimization?  In
> > particular, could it be just the find_vma() in hugepage_vma() called
> > before follow_huge_addr()?  I note that IA64 is the only arch to have
> > a non-trivial hugepage_vma()/follow_huge_addr() and that its
> > follow_huge_addr() doesn't actually use the vma passed in.
> 
> That's one, plus the spin lock mentioned above.

And akpm has just explained why it can be avoided in the hugepage
case.

> > If we could get rid of follow_hugetlb_pages() it would remove an ugly
> > function from every arch, which would be nice.
> 
> I hope the goal here is not to trim code for existing prefaulting scheme.
> That function has to go for demand paging, and demand paging comes with
> a performance price most people don't realize.  If the goal here is to
> make the code prettier, I vote against that.

Well, I'm attempting to understand the hugepage code across all the
archs, so that I can try to implement copy-on-write with a minimum of
arch specific gunk.  Simplifying and consolidating the existing code
across archs would be a helpful first step, if possible.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
