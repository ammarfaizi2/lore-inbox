Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263581AbUD2GLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbUD2GLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUD2GLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:11:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3046 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263581AbUD2GLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:11:07 -0400
Date: Thu, 29 Apr 2004 07:10:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Russell King <rmk@arm.linux.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 18 i_mmap_nonlinear
In-Reply-To: <20040428234448.GB737@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0404290621470.3719-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, William Lee Irwin III wrote:
> On Wed, Apr 28, 2004 at 07:11:18PM -0400, Rik van Riel wrote:
> > ... do we still need both i_mmap and i_mmap_shared?
> > Is there a place left where we're using both trees in
> > a different way, or are we just walking both trees
> > anyway in all places where they're referenced ?

Good point from Rik.  I very nearly combined them in this patchset
(and was trying to avoid adding i_mmap_nonlinear on top, but Rajesh
gently persuaded me that would be a little foolish, the nonlinear
processing too different).

I'm sure i_mmap and i_mmap_shared can and should be combined (with
addition of a count of shared writable mappings, for those places
which need to know if there were any at all); but in the end decided
to leave that for later, consult the architectures affected first.

Another change to contemplate: we should be able to add page_mapped
checks to cut down on the flushing, this stuff was written before
there was any such count.  But it's not straightforward: maybe some
of the flush_dcache_page calls come just before the rmap is added,
yet would be relying on it to be counted in?

> I believe the flush_dcache_page() implementations touching
> ->i_mmap_shared care about this distinction.

That's right, arm and parisc do handle them differently: currently
arm ignores i_mmap (and I think rmk was wondering a few months ago
whether that's actually correct, given that MAP_SHARED mappings
which can never become writable go in there - and that surprise is
itself a very good reason for combining them), and parisc... ah,
what it does in Linus' tree at present is about the same for both,
but there are some changes on the way.

The differences are not going to be enough to deserve two separate
prio_tree_roots in every struct address_space, we can check vm_flags
for any differences if necessary.

Something else I should have commented on, in that patch comment or
the next: although we now have the separate i_mmap_nonlinear list,
no attempt to search it for nonlinear pages in flush_dcache_page.

It looks like parisc has no sys_remap_file_pages syscall anyway,
and arm only flushes current active_mm, so should be okay so long
as people don't mix linear and nonlinear maps of same pages (hmm,
and don't map same page twice in a nonlinear: more likely) in same
mm: anyway, I think any problems there have to be a "Don't do that",
searching page tables in flush_dcache_page would be too too painful.

Hugh

