Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULJMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULJMbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 07:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULJMbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 07:31:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37153 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261184AbULJMbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 07:31:02 -0500
Date: Fri, 10 Dec 2004 12:30:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <linux-mm@kvack.org>, <linux-ia64@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
    tests
In-Reply-To: <41B931FC.8040109@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0412101208160.20182-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Nick Piggin wrote:
> Benjamin Herrenschmidt wrote:
> > On Fri, 2004-12-10 at 15:54 +1100, Nick Piggin wrote:
> >>
> >>The page-freed-before-update_mmu_cache issue can be solved in that way,
> >>not the set_pte and update_mmu_cache not performed under the same ptl
> >>section issue that you raised.
> > 
> > What is the problem with update_mmu_cache ? It doesn't need to be done
> > in the same lock section since it's approx. equivalent to a HW fault,
> > which doesn't take the ptl...
> 
> I don't think a problem has been observed, I think Hugh was just raising
> it as a general issue.

That's right, I know little of the arches on which update_mmu_cache does
something, so cannot say that separation is a problem.  And I did see mail
from Ben a month ago in which he arrived at the conclusion that it's not a
problem - but assumed he was speaking for ppc and ppc64.  (He was also
writing in the context of your patches rather than Christoph's.)

Perhaps Ben has in mind a logical argument that if update_mmu_cache does
just what its name implies, then doing it under a separate acquisition
of page_table_lock cannot introduce incorrectness on any architecture.
Maybe, but I'd still rather we heard that from an expert in each of the
affected architectures.

As it stands in Christoph's patches, update_mmu_cache is sometimes
called inside page_table_lock and sometimes outside: I'd be surprised
if that doesn't require adjustment for some architecture.

Your idea to raise do_anonymous_page's update_mmu_cache before the
lru_cache_add_active sounds just right; perhaps it should then even be
subsumed into the architectural ptep_cmpxchg.  But once we get this far,
I do wonder again whether it's right to be changing the rules in
do_anonymous_page alone (Christoph's patches) rather than all the
other faults together (your patches).

But there's no doubt that the do_anonymous_page case is easier,
or more obviously easy, to deal with - it helps a lot to know
that the page cannot yet be exposed to vmscan.c and rmap.c.

Hugh

