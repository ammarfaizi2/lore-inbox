Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWEaDGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWEaDGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWEaDGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:06:30 -0400
Received: from gold.veritas.com ([143.127.12.110]:63066 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751582AbWEaDG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:06:29 -0400
X-IronPort-AV: i="4.05,191,1146466800"; 
   d="scan'208"; a="60034298:sNHT1555155804"
Date: Wed, 31 May 2006 04:06:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447CE1A3.60507@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605310335180.4441@blonde.wat.veritas.com>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD9CE.2020505@yahoo.com.au>
 <Pine.LNX.4.64.0605301911480.10355@blonde.wat.veritas.com> <447CE1A3.60507@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 May 2006 03:06:27.0068 (UTC) FILETIME=[34E2DBC0:01C6845F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> > lock_page forbids it from being called from anywhere that can't
> > sleep, which is often just where we want to call it from.  Neil's
> > suggestion, using a spin_lock against the mapping changing, would
> > help there; but seems like more work than I'd want to get into.
> 
> But making PG_lock a spinning lock is completely unrelated to the
> bug at hand.

Neil wasn't suggesting making PG_lock a spinning lock, he was
suggesting a further bit used that way.  And I thought his suggestion
was relevant to the bug at hand.  But it's not the way I'd like to go.

> > So, although I think lock_page_nosync fixes the bug (at least in
> > that one place we've identified there's likely to be such a bug),
> > it seems to be aiming at the wrong target.  I'm pacing and thinking,
> > doubt I'll come up with anything better, please don't hold breath.
> 
> It is the correct target. I know all about your set_page_dirty_lock
> problems, but they aren't what I'm trying to fix.

Yes, I had noticed yours is a different issue.  I'm saying that if we
can "fix" set_page_dirty_nolock not to sleep, then your issue is fixed
(as least as it affects set_page_dirty_lock, which is all your patch
is dealing with, and we hope all it needs to deal with).  Because your
issue is with the sync_page in the lock_page of set_page_dirty_nolock,
and it's that particular lock_page which I'm trying to be rid of.

I now think it can be done: in cases where TestSetPageLocked finds
the page already locked, then I believe we can fall back to inode_lock
to stabilize.  But I do need to consider the possibilities some more.

> AFAIKS, you could also make set_page_dirty_lock non sleeping quite
> easily by making inode slabs RCU freed.

Which would equally deal with your issue.  Yes, but it's always
seemed to me too great a risk, to add an RCU delay into such
significant slab shrinking - I don't want to handle the fallout.

> What places want to use set_page_dirty_lock without sleeping?
> The only place in drivers/ apart from sg/st that SetPageDirty are
> rd.c and via_dmablit.c, both of which look OK, if a bit crufty.

I've not looked recently, but bio.c sticks in the mind as one which
is pushed to the full contortions to allow for sleeping there.

Hugh
