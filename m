Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271095AbUJUXpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271095AbUJUXpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbUJUXnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:43:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:6021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271103AbUJUXiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:38:51 -0400
Date: Thu, 21 Oct 2004 16:42:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041021164245.4abec5d2.akpm@osdl.org>
In-Reply-To: <20041021232059.GE8756@dualathlon.random>
References: <1098393346.7157.112.camel@localhost>
	<20041021144531.22dd0d54.akpm@osdl.org>
	<20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> On Thu, Oct 21, 2004 at 04:02:33PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@novell.com> wrote:
> > >
> > > On Thu, Oct 21, 2004 at 02:45:31PM -0700, Andrew Morton wrote:
> > > > Maybe we should revisit invalidate_inode_pages2().  It used to be an
> > > > invariant that "pages which are mapped into process address space are
> > > > always uptodate".  We broke that (good) invariant and we're now seeing
> > > > some fallout.  There may be more.
> > > 
> > > such invariant doesn't exists since 2.4.10. There's no way to get mmaps
> > > reload data from disk without breaking such an invariant.
> > 
> > There are at least two ways:
> > 
> > a) Set a new page flag in invalidate, test+clear that at fault time
> 
> What's the point of adding a new page flag when the invariant
> !PageUptodate && page_mapcount(page) already provides the information?

Step back and think about this.  What earthly sense is there in permitting
userspace access to non uptodate pages?

None.  It's completely wrong and the invariant was a good one.  We broke it
by introducing some kluge to force new I/O when someone does a new fault
against the page.

(A new PG_needs_rereading flag isn't sufficient btw - we'd also need
BH_Needs_Rereading and associated code.  ug.)

> > b) shoot down all pte's mapping the locked page at invalidate time, mark the
> >    page not uptodate.
> 
> invalidate should run fast, I didn't enforce coherency or it'd hurt too
> much the O_DIRECT write if something is mapped, we only allow buffered
> read against O_DIRECT write to work coherently, the mmap coherency has
> never been provided to avoid having to search for vmas in the prio_tree
> for every single write to an inode.

I don't get it.  invalidate has the pageframe.  All it need to do is to
lock the page, examine mapcount and if it's non-zero, do the shootdown. 
The only way in which we would be performing the shootdown a significant
number of times would be if someone was repeatedly faulting the thing back
in anyway, and in that case the physical I/O cost would dominate.  Where's
the performance overhead??

Plus it makes the currently incorrect code correct for existing mmaps.

Plus it avoids the idiotic situation of having non uptodate pages
accessible to user processes.
