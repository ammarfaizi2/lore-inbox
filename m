Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311559AbSCNIXX>; Thu, 14 Mar 2002 03:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311560AbSCNIXN>; Thu, 14 Mar 2002 03:23:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5659 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311559AbSCNIWz>; Thu, 14 Mar 2002 03:22:55 -0500
Date: Thu, 14 Mar 2002 08:24:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 23 second kernel compile / pagemap_lru_lock improvement
In-Reply-To: <5740000.1016059202@flay>
Message-ID: <Pine.LNX.4.21.0203140804190.1294-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Martin J. Bligh wrote:
> > 
> > I'm surprised it made any difference at all, I think the patch mainly
> > adds more tests: activate_page is only called from mark_page_accessed
> > (after testing !PageActive) and from fail_writepage (where usually
> > !PageActive).  I don't think many !PageLRU pages can get there.
> 
> It does seem distinctly odd that we take the lock, *then* test whether
> we actually need to do anything. Is the test just a sanity check that
> should never fail?

It's quite normal to have to recheck flags after taking the relevant
lock.  Here I think the two flags have different needs.  I've not
checked rigorously, but I believe that the PageLRU flag cannot change
beneath us (but does need to be checked either outside or inside the
lock); whereas it's easy to find races where PageActive is set outside
but found clear once inside the lock, or vice versa.

Now it doesn't matter if we make a wrong activity decision occasionally,
but we do need to keep internal consistency.  If PageActive were not
rechecked inside pagemap_lru_lock, nr_active_pages and nr_inactive_pages
would become approximate instead of exact counts; then there's a danger
they would tend to drift in one direction, unbalancing shrink_caches.

Hugh

