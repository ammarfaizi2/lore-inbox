Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWEQT7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWEQT7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWEQT7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:59:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751058AbWEQT7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:59:39 -0400
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage
	boundries when needed
From: Eric Paris <eparis@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, discuss@x86-64.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 15:59:24 -0400
Message-Id: <1147895964.26468.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 18:42 +0100, Hugh Dickins wrote:
> On Wed, 17 May 2006, Eric Paris wrote:
> > sys_m{,un}lock and do_mlock all align memory references and the length
> > of the mlock given by userspace to page boundaries.  If the page being
> > mlocked is a hugepage instead of a normal page the start and finish of
> > the mlock will still only be aligned to normal page boundaries.
> > Ultimately upon the process exiting we will eventually call unmap_vmas
> > which will call unmap_hugepage_range for all of the ranges.
> > unmap_hugepage_range checks to make sure the beginning and the end of
> > the range are actually hugepage aligned and if not will BUG().  Since we
> > only aligned to a normal page boundary the end of the first range and
> > the beginning of the second will likely (unless userspace passed of
> > values already hugepage aligned) not be hugepage aligned and thus we
> > bomb.
> 
> When did you test this?  It should have been fixed in 2.6.11 onwards
> by split_vma()'s simple:
> 
> 	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
> 		return -EINVAL;
> 
> Hugh

You're right.  My initial BUG() problem was on pre 2.6.11.  I wrote this
patch and tested that it worked on 2.6.16 to allow the test program I
described to run successfully.  Admittedly this is the first time I
tested on unpatched 2.6.16 and as you said the mlock will fail with
"Invalid Argument" instead of BUG().  So the panic is gone post 2.6.11,
but the problem remains.  We still are rounding incorrectly for
hugepages in the sys_mlock and do_mlock functions.

This patch still solves the problem of the kernel currently being more
restrictive on what we accept from userspace for the length of the mlock
if it is a hugepage rather than a regular page.  With a regular page we
will round the value from userspace and happily go about our business of
mlocking.  For a hugepage it just rejects it if userspace doesn't align
it themselves.  This allows the kernel to do the same work for hugepages
that it does for normal pages.

-Eric

