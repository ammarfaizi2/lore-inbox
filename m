Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271130AbUJVAh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271130AbUJVAh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271114AbUJVAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:33:59 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:15809 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S271107AbUJVA3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:29:25 -0400
Date: Fri, 22 Oct 2004 02:30:04 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022003004.GA14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021164245.4abec5d2.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:42:45PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@novell.com> wrote:
> >
> > On Thu, Oct 21, 2004 at 04:02:33PM -0700, Andrew Morton wrote:
> > > Andrea Arcangeli <andrea@novell.com> wrote:
> > > >
> > > > On Thu, Oct 21, 2004 at 02:45:31PM -0700, Andrew Morton wrote:
> > > > > Maybe we should revisit invalidate_inode_pages2().  It used to be an
> > > > > invariant that "pages which are mapped into process address space are
> > > > > always uptodate".  We broke that (good) invariant and we're now seeing
> > > > > some fallout.  There may be more.
> > > > 
> > > > such invariant doesn't exists since 2.4.10. There's no way to get mmaps
> > > > reload data from disk without breaking such an invariant.
> > > 
> > > There are at least two ways:
> > > 
> > > a) Set a new page flag in invalidate, test+clear that at fault time
> > 
> > What's the point of adding a new page flag when the invariant
> > !PageUptodate && page_mapcount(page) already provides the information?
> 
> Step back and think about this.  What earthly sense is there in permitting
> userspace access to non uptodate pages?

this is exactly why new page faults re-read from disk. Istantiating not
uptodate pages is definitely a mistake. But after the pte is istantiated
the uptodate information becomes pointless. It's up to the page fault to
make sure the page is uptodate before mapping it into userspace.

> None.  It's completely wrong and the invariant was a good one.  We
> broke it
> by introducing some kluge to force new I/O when someone does a new fault
> against the page.

the invariant that is important, is that the page fault must never map
not uptodate pages into userspace. That invariant is still obeyed, it's
just after the page is mapped that we start making good use of the
uptodate bit again.

> (A new PG_needs_rereading flag isn't sufficient btw - we'd also need
> BH_Needs_Rereading and associated code.  ug.)

clearing uptodate bits for bh too would fix it. Anyways I doubt in
practice the lack of bh clearing could ever trigger thanks to
mpage_readpages and the page aligned API. Peraphs the 2.6 more relaxed
API could expose the problem, and that's why we need to address it in
2.6.

> I don't get it.  invalidate has the pageframe.  All it need to do is to
> lock the page, examine mapcount and if it's non-zero, do the shootdown. 
> The only way in which we would be performing the shootdown a significant
> number of times would be if someone was repeatedly faulting the thing back
> in anyway, and in that case the physical I/O cost would dominate.  Where's
> the performance overhead??
> 
> Plus it makes the currently incorrect code correct for existing mmaps.
> 
> Plus it avoids the idiotic situation of having non uptodate pages
> accessible to user processes.

peraphs we can implement it for 2.6, but for 2.4 it was not doable, and
clearing PG_uptodate in 2.4 is what made O_DIRECT possible at all, so I
wouldn't call it idiotic situation. It was a big new feature and it
still is, since your new bitflag is not needed: what the VM asks for is
to clear such uptodate bit because the page in the pagecache is not
uptodate anymore. What happens is that the disk has changed under you so
it's idotic to set another bitflag and to leave the uptodate bit set,
when the page is obviously not uptodate anymore.

If you want to shootdown ptes before clearing the bitflag, that's fine
with me, but you will still have to clear the uptodate bitflag on the
page after that, and the mmap coherency has never been provided by
O_DIRECT in linux, this would be a new feature, sure not a bugfix. the
mmap case is a controlled race by design that can cause no harm. btw,
nfs is doing it too in some 2.4 tree, we've got complains that mmaps
weren't refreshed.  If you change invalidate_inode_pages2 to shootdown
ptes then they'll get much better refreshing for nfs too, but again, not
doable in the 2.4 backport: in 2.4 all I could do is to clear uptodate
on mapped pages, since after the page is mapped the uptodate bit becomes
useless and we can re-use it. Adding a new bitflag wouldn't change a
thing except to make it more complicated than it already is.
