Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVCCEWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVCCEWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCEUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:20:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:10936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261264AbVCCEOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:14:47 -0500
Date: Wed, 2 Mar 2005 20:14:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050302201425.2b994195.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Wed, 2 Mar 2005, Andrew Morton wrote:
> 
> > > This is a related change discussed during V16 with Nick.
> >
> > It's worth retaining a paragraph for the changelog.
> 
> There have been extensive discussions on all aspects of this patch.
> This issue was discussed in
> http://marc.theaimsgroup.com/?t=110694497200004&r=1&w=2

This is a difficult, intrusive and controversial patch.  Things like the
above should be done in a separate patch.  Not only does this aid
maintainability, it also allows the change to be performance tested in
isolation.

If the change gets folded into other changes then it would be best to draw
attention to, and fully explain/justify the change within the changelog.

> >
> > > The page is protected from munmap because of the down_read(mmap_sem) in
> > > the arch specific code before calling handle_mm_fault.
> >
> > We don't take mmap_sem during page reclaim.  What prevents the page from
> > being freed by, say, kswapd?
> 
> The cmpxchg will fail if that happens.

How about if someone does remap_file_pages() against that virtual address
and that syscalls happens to pick the same physical page?  We have the same
physical page at the same pte slot with different contents, and the cmpxchg
will succeed.

Maybe mmap_sem will save us, maybe not.  Either way, this change needs a
ton of analysys, justification and documentation, please.

Plus if the page gets freed under our feet, CONFIG_DEBUG_PAGEALLOC will
oops during the copy.

> > I forget.  I do recall that we decided that the change was OK, but briefly
> > looking at it now, it seems that we'll fail to move a
> > PageReferenced,!PageActive onto the active list?
> 
> See http://marc.theaimsgroup.com/?l=bk-commits-head&m=110481975332117&w=2
> 
> and
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110272296503539&w=2

Those are different cases.  I still don't see why the change is justified in
do_swap_page().

> > > That is up to the arch maintainers.  Add something to arch/xx/Kconfig to
> > > allow atomic operations for an arch.  Out of the box it only works for
> > > x86_64, ia64 and ia32.
> > > > Feedback from s390, sparc64 and ppc64 people would help in making a merge
> > decision.
>
> These architectures have the atomic pte's not enable.  It would require
> them to submit a patch to activate atomic pte's for these architectures. 


But if the approach which these patches take is not suitable for these
architectures then they have no solution to the scalability problem.  The
machines will perform suboptimally and more (perhaps conflicting)
development will be needed.

> > > Earlier releases back in September 2004 had some pte locking code (and
> > > AFAIK Nick also played around with pte locking) but that
> > > was less efficient than atomic operations.
> >
> > How much less efficient?
> > Does anyone else have that code around?
> 
> Nick may have some data. It got far too complicated too fast when I tried
> to introduce locking for individual ptes. It required bit
> spinlocks for the pte meaning multiple atomic operations.

One could add a spinlock to the pageframe, or use hashed spinlocking.

> One
> would have to check for the lock being active leading to significant code
> changes.

Why?

> This would include the arch specific low level fault handers to
> update bits, walk the page table etc etc.


