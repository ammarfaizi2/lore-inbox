Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVCCFDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVCCFDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVCCFBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:01:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:9918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbVCCE4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:56:35 -0500
Date: Wed, 2 Mar 2005 20:56:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050302205612.451d220b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	<20050302201425.2b994195.akpm@osdl.org>
	<Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> > > The cmpxchg will fail if that happens.
> >
> > How about if someone does remap_file_pages() against that virtual address
> > and that syscalls happens to pick the same physical page?  We have the same
> > physical page at the same pte slot with different contents, and the cmpxchg
> > will succeed.
> 
> Any mmap changes requires the mmapsem.

sys_remap_file_pages() will call install_page() under down_read(mmap_sem). 
It relies upon page_table_lock for pte atomicity.

> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=110272296503539&w=2
> >
> > Those are different cases.  I still don't see why the change is justified in
> > do_swap_page().
> 
> Lets undo that then.

OK.

> > > These architectures have the atomic pte's not enable.  It would require
> > > them to submit a patch to activate atomic pte's for these architectures.
> >
> >
> > But if the approach which these patches take is not suitable for these
> > architectures then they have no solution to the scalability problem.  The
> > machines will perform suboptimally and more (perhaps conflicting)
> > development will be needed.
> 
> They can implement their own approach with the provided hooks. You could
> for example use SSE / MMX for atomic 64 bit ops on i386 with PAE mode by
> using the start/stop macros to deal with the floatingh point issues.

Have the ppc64 and sparc64 people reviewed and acked the change?  (Not a
facetious question - I just haven't been following the saga sufficiently
closely to remember).

> > > One
> > > would have to check for the lock being active leading to significant code
> > > changes.
> >
> > Why?
> 
> Because if a pte is locked it should not be used.

Confused.  Why not just spin on the lock in the normal manner?

> Look this is an endless discussion with new things brought up at every
> corner and I have reworked the patches numerous times. Could you tell me
> some step by step way that we can finally deal with this? Specify a
> sequence of patches and I will submit them to you step by step.

No, I couldn't do that - that's what the collective brain is for.

Look, I'm sorry, but this patch is highly atypical.  Few have this much
trouble.  I have queazy feeling about it (maybe too low-level locking,
maybe inappropriate to other architectures, only addresses a subset of
workloads on a tiny subset of machines, doesn't seem to address all uses of
the lock, etc) and I know that others have had, and continue to have
similar feelings.  But if we could think of anything better, we'd have said
so :(   It's a diffucult problem.

If the other relvant architecture people say "we can use this" then perhaps
we should grin and bear it.  But one does wonder whether some more sweeping
design change is needed.
